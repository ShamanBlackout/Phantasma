using System;
using System.Collections.Generic;
using System.Numerics;
using NativeWebSocket;
using UnityEngine;
using UnityEngine.Events;
using System.Text;
using Newtonsoft.Json.Linq;
using System.Linq;
using PhantasmaPhoenix.Cryptography;
using PhantasmaPhoenix.Core;
using Cysharp.Threading.Tasks;


/***
    * Phantasma Link Client for Unity
    * Created by Shaman Blackout and Phantasma Team 2025
    * Version 2.0
    * TODO: Add a Job scheduler when looping through the balances and the nfts
**/

public class PhantasmaLinkClientSB : MonoBehaviour
{
    [Header("Debug Settings")]
    [Tooltip("Enable/disable debug logging")]

    public bool EnableDebugLogs = true;

    private void Log(string message)
    {
        if (EnableDebugLogs)
        {
            Debug.Log(message);
        }
    }

    private void LogWarning(string message)
    {
        if (EnableDebugLogs)
        {
            Debug.LogWarning(message);
        }
    }

    private void LogError(string message)
    {
        if (EnableDebugLogs)
        {
            Debug.LogError(message);
        }
    }



    public struct Balance
    {
        public readonly string symbol;
        public readonly BigInteger value;
        public readonly int decimals;
        public readonly string[] ids;

        public Balance(string symbol, BigInteger value, int decimals, string[] ids)
        {
            this.symbol = symbol;
            this.value = value;
            this.decimals = decimals;
            this.ids = ids;
        }
    }
    public enum WalletConnectionState
    {
        Disconnected,
        Connecting,
        Connected,
        LoggedIn,
        Error
    }
    public static PhantasmaLinkClientSB Instance { get; private set; }

    [Header("Connection Version")]
    [Tooltip("Strongly recommend to use the version 2")]
    public int Version = 2;

    [SerializeField]
    [Tooltip("simnet -> for Local node, testnet -> for Testnet node, mainnet -> for the Mainnet node")]
    private string _nexus = "simnet";

    [Header("Dapp Name")]
    [Tooltip("Here is the contract name for the desired Dapp, i.e. Pharming")]
    public string DappID = "demo";

    [Header("Wallet Endpoint")]
    [Tooltip("Default value = localhost:7090 (don't change it)")]
    public string Host = "localhost:7090";

    [Header("Platform and Signature")]
    [Tooltip("This is used to sign transactions, for Phantasma blockchain use, (PlatformKind.Phantasma) and SignatureKind.ED25519 \n for Ethereum blockchain use, (PlatformKind.Ethereum) and SignatureKind.ECDSA")]
    public PlatformKind Platform = PlatformKind.Phantasma;
    public SignatureKind Signature = SignatureKind.Ed25519;

    [Space]
    [Header("Gas Setup")]
    public int GasPrice = 100000;
    public int GasLimit = 100000;

    [Header("Connection Settings")]
    [Tooltip("Timeout in milliseconds for reconnection attempts")]
    [SerializeField] private int reconnectTimeout = 5000;
    [Tooltip("Number of reconnection attempts before giving up")]
    [SerializeField] private int reconnectRetries = 10;

    private WebSocket websocket;

    public bool PingConnection { get; private set; } = true;


    public bool Ready { get; private set; }


    public bool useExternal { get; private set; }
    public bool Enabled { get; private set; }
    public bool isConnecting { get; private set; } = false;

    public bool Busy { get; private set; }

    public string Nexus
    {
        get { return _nexus; }
        private set { _nexus = value; }
    }
    public string Wallet { get; private set; }
    public string Token { get; private set; }
    public string Name { get; private set; }
    public string Address { get; private set; }
    public bool IsLogged { get; private set; }
    public WalletConnectionState ConnectionState { get; set; }

    public Texture2D Avatar { get; private set; }

    public IEnumerable<string> Assets => _balanceMap.Keys;

    private Dictionary<int, Action<JObject>> _requestCallbacks = new Dictionary<int, Action<JObject>>();

    private Dictionary<string, Balance> _balanceMap = new Dictionary<string, Balance>();
    private Dictionary<string, Balance> _ownershipMap = new Dictionary<string, Balance>();


    #region Events
    public static UnityEvent<bool, string> OnLogin = new UnityEvent<bool, string>();
    public static UnityEvent<string> OnInfo = new UnityEvent<string>();

    public static UnityEvent<WalletConnectionState> OnConnectionStateChange = new UnityEvent<WalletConnectionState>();
    private static readonly Queue<Action> _executionQueue = new Queue<Action>();
    #endregion

    static T GetValueOrDefault<T>(JObject obj, string field, T fallback = default)
    {
        return obj.TryGetValue(field, out var token) && token.Type != JTokenType.Null
            ? token.Value<T>()
            : fallback;
    }

    /// <summary>
    /// On Awake make it Singleton
    /// </summary>
    void Awake()
    {
        if (Instance != null && Instance != this)
        {
            Destroy(gameObject);
            return;
        }

        Instance = this;
        DontDestroyOnLoad(this.gameObject);

        SetMessage("Wallet Info Loading...");

    }
    void OnEnable()
    {
        OnLogin.AddListener(UpdateIsLogged);
        OnConnectionStateChange.AddListener(ChangeConnectionState);
    }

    void OnDisable()
    {
        OnConnectionStateChange.RemoveListener(ChangeConnectionState);
        OnLogin.RemoveListener(UpdateIsLogged);
    }


    /// <summary>
    /// Run on Start
    /// </summary>
    private async void Start()
    {
        //Check if we are using Poltergeist Wallet
        useExternal = PlayerPrefs.GetInt(PlayerPrefKeys.usePoltergeist, 0) == 1;

        //Only ping wallet if we are using Poltergeist
        if (useExternal)
            await PingWallet();
    }


    /// <summary>
    /// Update method
    /// </summary>
    void Update()
    {
        if (!Enabled)
        {
            return;
        }

#if !UNITY_WEBGL || UNITY_EDITOR
        websocket?.DispatchMessageQueue();
#endif
        lock (_executionQueue)
        {
            while (_executionQueue.Count > 0)
            {
                _executionQueue.Dequeue().Invoke();
            }
        }
    }




    #region Listeners
    void ChangeConnectionState(WalletConnectionState state)
    {
        this.ConnectionState = state;
        Log($"Connection State changed to: {state}");
    }
    void UpdateIsLogged(bool success, string msg)
    {
        if (success)
        {
            this.IsLogged = true;
            OnConnectionStateChange?.Invoke(WalletConnectionState.LoggedIn);
        }
        else
        {
            this.IsLogged = false;
        }
    }
    public static void Enqueue(Action action)
    {
        lock (_executionQueue)
        {
            _executionQueue.Enqueue(action);
        }
    }

    #endregion

    /// <summary>
    /// Set the Message to the OnInfo
    /// </summary>
    /// <param name="txt"></param>
    private void SetMessage(string txt) => OnInfo?.Invoke(txt);

    #region Requests Functions
    /// <summary>
    /// Fetch account info
    /// </summary>
    /// <param name="callback"></param>
    private void FetchAccount(Action<bool, string> callback)
    {
        SetMessage("Authorized, obtaining account info...");

        SendLinkRequest($"getAccount/{Platform}", (result) =>
        {
            var success = GetValueOrDefault<bool>(result, "success");
            if (success)
            {
                this.Name = GetValueOrDefault<string>(result, "name");
                this.Address = GetValueOrDefault<string>(result, "address");

                _balanceMap.Clear();
                _ownershipMap.Clear();

                var balances = result["balances"] as JArray;
                if (balances != null)
                {
                    foreach (var child in balances.Children<JObject>())
                    {
                        var symbol = GetValueOrDefault<string>(child, "symbol");
                        var value = GetValueOrDefault<string>(child, "value");
                        var amount = BigInteger.Parse(value);
                        var decimals = GetValueOrDefault<Int32>(child, "decimals");

                        string[] ids = child["ids"] is JArray arr
                            ? arr.Select(x => x?.Value<string>() ?? "").ToArray()
                            : Array.Empty<string>();

                        _balanceMap[symbol] = new Balance(symbol, amount, decimals, ids);
                        if (ids.Length > 0)
                            _ownershipMap[symbol] = new Balance(symbol, amount, decimals, ids);
                    }
                }

                callback?.Invoke(true, "Logged with success!");
                OnLogin?.Invoke(true, "Logged with success!");
            }
            else
            {
                callback?.Invoke(false, "could not obtain account");
                OnLogin?.Invoke(false, "could not obtain account");

            }
        });
    }

    private int requestID;

    /// <summary>
    /// Send Link Request
    /// </summary>
    /// <param name="request"></param>
    /// <param name="callback"></param>
    private async void SendLinkRequest(string request, Action<JObject> callback)
    {
        if (!request.Contains("authorize"))
        {
            if (this.Token != null)
            {
                request = request + '/' + this.DappID + '/' + this.Token;
            }
        }


        Log($"Sending Phantasma Link Request: {request}");

        requestID++;

        request = $"{requestID},{request}";

        _requestCallbacks[requestID] = callback;
        Log($"Request=> {request}");
#if UNITY_ANDROID
        await PhantasmaLinkClientSBPluginManager.Instance.SendTransaction(request);
#endif
#if UNITY_WEBGL && !UNITY_EDITOR
        await websocket.SendText(request).AsUniTask();
#else
        await UniTask.Create(async () => await websocket.SendText(request));
#endif
    }

    /*async UniTask SendWebSocketMessage()
    {
        if (websocket.State == WebSocketState.Open)
        {
            // Sending bytes
#if UNITY_WEBGL && !UNITY_EDITOR
            await websocket.Send(new byte[] { 10, 20, 30 }).AsUniTask();
            await websocket.SendText("plain text message").AsUniTask();
#else
            await UniTask.Create(async () => await websocket.Send(new byte[] { 10, 20, 30 }));
            await UniTask.Create(async () => await websocket.SendText("plain text message"));
#endif
        }
    }*/
    #endregion   

    #region Application Defaults
    /// <summary>
    /// On Quiting the Apliction, close the websocket
    /// </summary>
    private async void OnApplicationQuit()
    {
        ClearAll();
        Log("Closing WebSocket connection on application quit.");
#if UNITY_WEBGL && !UNITY_EDITOR
        await websocket.Close().AsUniTask();
#else
        await UniTask.Create(async () => await websocket.Close());
#endif
        websocket = null;
    }

    /// <summary>
    /// On Enable the PhantasmaLink, Create the websocket to connect to the Poltergeist Wallet.
    /// </summary>
    public async void Enable()
    {
        Log($"Checking if LinkClient Is Enabled: {this.Enabled}");

        if (this.Enabled)
        {
            return;
        }
        Log("Enabling Phantasma Link Client...");
        this.Enabled = true;

        this.Wallet = "Unknown";
        this.Token = null;
        this.Nexus = _nexus;

        websocket = new WebSocket($"ws://{Host}/phantasma");

        LogWarning("Creating");

        websocket.OnOpen += () =>
        {
            this.Ready = true;
            Log("Connection open!");
            if (!isConnecting)
                Enqueue(() =>
                {
                    OnConnectionStateChange?.Invoke(WalletConnectionState.Connected);
                });

        };

        websocket.OnError += (e) =>
        {
            if (!isConnecting)
            {
                LogError("Error! " + e);
                Enqueue(() =>
                {
                    OnConnectionStateChange?.Invoke(WalletConnectionState.Error);
                });
            }
        };


        websocket.OnClose += (e) =>
        {

            Log("Connection closed!");
            if (!isConnecting)
                Enqueue(() =>
            {
                OnConnectionStateChange?.Invoke(WalletConnectionState.Disconnected);
            });


            //may need to set Ready == false here for WalletConnectionState Disconnnected

        }
            ;

        websocket.OnMessage += (bytes) =>
        {
            // getting the message as a json string
            var json = System.Text.Encoding.UTF8.GetString(bytes);
            Log("OnMessage! " + json);

            var node = JObject.Parse(json);

            var reqID = GetValueOrDefault<Int32>(node, "id");
            if (_requestCallbacks.ContainsKey(reqID))
            {
                var callback = _requestCallbacks[reqID];
                _requestCallbacks.Remove(reqID);

                callback?.Invoke(node);
            }
            else
            {
                LogWarning("Got weird request with id " + reqID);
            }
        };

        // waiting for messages
#if UNITY_WEBGL && !UNITY_EDITOR
        await websocket.Connect().AsUniTask();
#else
        await UniTask.Create(async () => await websocket.Connect());
#endif
    }
    #endregion

    #region PUBLIC INTERFACE
    /// <summary>
    /// Get Balance for specific symbol
    /// </summary>
    /// <param name="symbol"></param>
    /// <returns></returns>
    public decimal GetBalance(string symbol)
    {
        if (_balanceMap.ContainsKey(symbol))
        {
            var temp = _balanceMap[symbol];
            // UnitConversion.ToDecimal expects a string representation for the value,
            // so convert the BigInteger to string first.
            return UnitConversion.ToDecimal(temp.value.ToString(), (uint)temp.decimals);
        }

        return 0;
    }

    /// <summary>
    /// Returns the NFTs IDs for a specific symbol
    /// </summary>
    /// <param name="symbol"></param>
    /// <returns></returns>
    public string[] GetNFTs(string symbol)
    {
        if (_ownershipMap.ContainsKey(symbol))
        {
            var temp = _ownershipMap[symbol];
            return temp.ids;
        }

        return Array.Empty<string>();
    }

    /// <summary>
    /// Login to the Dapp
    /// </summary>
    /// <param name="callback"></param>
    public void Login(Action<bool, string> callback = null)
    {
        if (string.IsNullOrEmpty(this.Nexus))
        {
            SetMessage("Nexus is not setup correctly...");
            return;
        }

        SetMessage("Connection established, authorizing...");

        SendLinkRequest($"authorize/{DappID}/{Version}", (result) =>
        {
            var success = GetValueOrDefault<bool>(result, "success");
            if (success)
            {
                var connectedNexus = GetValueOrDefault<string>(result, "nexus");

                if (connectedNexus != this.Nexus)
                {
                    OnLogin?.Invoke(false, $"invalid nexus: got {connectedNexus} but expected {this.Nexus}");
                    callback?.Invoke(false, $"invalid nexus: got {connectedNexus} but expected {this.Nexus}");
                }
                else
                {
                    this.Wallet = GetValueOrDefault<string>(result, "wallet");
                    this.Token = GetValueOrDefault<string>(result, "token");
                    OnLogin?.Invoke(true, "authorized");

                    FetchAccount(callback);
                }
            }
            else
            {
                callback?.Invoke(false, "connection failed (or rejected)");
                OnLogin?.Invoke(false, "connection failed (or rejected)");
            }
        });
    }

    /// <summary>
    /// To Reload the account info
    /// </summary>
    /// <param name="callback"></param>
    public void ReloadAccount(Action<bool, string> callback = null)
    {
        FetchAccount(callback);
    }


    /// <summary>
    /// Clears all the data from the client.
    /// Assumes wallet is disconnected.
    /// </summary>
    /// <param name="callback">returns a bool</param>
    public void ClearAll()
    {
        this.Enabled = false;
        this.PingConnection = false;
        this.Nexus = null;
        this.Wallet = "";
        this.Token = "";
        this.Avatar = null;
        this.Name = "";
        this.Address = "";
        this.Ready = false;
        OnLogin.Invoke(false, "Wallet disconnected");
        _balanceMap.Clear();
    }



    /// <summary>
    /// Logout from the Dapp
    /// Assumes websocket is still connected to the wallet.
    /// </summary>
    /// <param name="callback">returns a bool</param>
    public void Logout()
    {
        this.Wallet = "";
        this.Token = "";
        this.Avatar = null;
        this.Name = "";
        this.Address = "";
        OnLogin?.Invoke(false, "Logged out");
        OnConnectionStateChange?.Invoke(WalletConnectionState.Connected); //TODO: Might Change the state of this
        _balanceMap.Clear();
    }

    /// <summary>
    /// Send Transaction.
    /// </summary>
    /// <param name="chain"></param>
    /// <param name="script"></param>
    /// <param name="payload"></param>
    /// <param name="callback"></param>
    public void SendTransaction(string chain, byte[] script, byte[] payload, Action<Hash, string> callback = null, PlatformKind platform = PlatformKind.Phantasma, SignatureKind signature = SignatureKind.Ed25519)
    {
        SetMessage("Relaying transaction...");

        if (script.Length >= 8192)
        {
            callback?.Invoke(Hash.Null, "script too big");
            return;
        }

        var hexScript = Base16.Encode(script);
        var hexPayload = payload != null && payload.Length > 0 ? Base16.Encode(payload) : ""; // is empty string for payload ok?
        var requestStr = $"{chain}/{hexScript}/{hexPayload}";
        if (Version >= 2)
        {
            requestStr = $"{requestStr}/{signature}/{platform}";
        }
        else
        {
            requestStr = $"{this.Nexus}/{requestStr}";
        }

        SendLinkRequest($"signTx/{requestStr}", (result) =>
        {
            var success = GetValueOrDefault<bool>(result, "success");
            if (success)
            {
                var hashStr = GetValueOrDefault<string>(result, "hash");
                var hash = Hash.Parse(hashStr);
                callback?.Invoke(hash, null);
            }
            else
            {
                var msg = GetValueOrDefault<string>(result, "message");
                callback?.Invoke(Hash.Null, "transaction rejected: " + msg);
            }
        });
    }

    /// <summary>
    /// To signed some type of data
    /// </summary>
    /// <param name="data">String with the data you want to sign</param>
    /// <param name="callback"></param>
    /// <param name="platform"></param>
    /// <param name="signature"></param>
    public void SignData(string data, Action<bool, string, string, string> callback = null, PlatformKind platform = PlatformKind.Phantasma, SignatureKind signature = SignatureKind.Ed25519)
    {
        if (!Enabled)
        {
            callback?.Invoke(false, "Not logged in", "", "");
            return;
        }
        if (data == null)
        {
            callback?.Invoke(false, "Invalid data", "", "");
            return;
        }
        if (data.Length >= 1024)
        {
            callback?.Invoke(false, "Data too big", "", "");
            return;
        }

        var dataConverted = Base16.Encode(Encoding.UTF8.GetBytes(data));

        SendLinkRequest($"signData/{dataConverted}/{signature}/{platform}", (result) =>
        {
            var success = GetValueOrDefault<bool>(result, "success");
            if (success)
            {
                var random = GetValueOrDefault<string>(result, "random");
                var signedData = GetValueOrDefault<string>(result, "signature");
                callback?.Invoke(true, signedData, random, dataConverted);
            }
            else
            {
                var msg = GetValueOrDefault<string>(result, "message");
                callback?.Invoke(false, "Failed to sign data: " + msg, "", "");
            }
        });
    }

    public enum PlatformKind
    {
        None = 0x0,
        Phantasma = 0x1,
        Neo = 0x2,
        Ethereum = 0x4,
        BSC = 0x8,
    }
    #endregion

    #region SHAMAN CUSTOM


    /// <summary>
    /// IENUMERATOR Send Transaction.
    /// </summary>
    /// <param name="chain"></param>
    /// <param name="script"></param>
    /// <param name="payload"></param>
    /// <param name="callback"></param>


    async UniTask PingWallet()
    {
        this.Enable();
        while (PingConnection)
        {
            await UniTask.Delay(TimeSpan.FromSeconds(3), ignoreTimeScale: true).ContinueWith(async () =>
            {
                try { await CheckConnection(); } catch { }
            });

        }
    }
    async UniTask CheckConnection()
    {
        //Debug.Log("Checking Connection");
        if (websocket != null && websocket.State == WebSocketState.Open)
        {
            return; //OnConnectionStateChange?.Invoke(WalletConnectionState.Connected);
        }
        else if (websocket != null && websocket.State == WebSocketState.Closed)
        {
            this.Ready = false;
            OnLogin.Invoke(false, "Wallet disconnected");
            Log("Wallet Closed unexpectedly, attempting to reconnect...");
            await ReconnectWithTimeout((result) =>
            {
                Log("Portergeist Wallet Reconnection Result: " + result);
                if (!result)
                    this.PingConnection = false;
            });

            return;

        }
    }


    /// <summary>  
    /// Reconnects to the WebSocket with retries.
    /// </summary>
    /// <param name="timeout">Timeout in milliseconds (not used in this implementation).</param>
    /// <param name="retries">Number of retries.</param>    
    /// <returns>True if reconnected successfully, false otherwise.</returns>
    private async UniTask ReconnectWithTimeout(Action<bool> callback = null, int? timeout = null, int? retries = null)
    {

        int maxRetries = retries ?? reconnectRetries;
        int delay = timeout ?? reconnectTimeout;

        WebSocketOpenEventHandler reconnectOpenHandler = null;
        WebSocketCloseEventHandler reconnectCloseHandler = null;

        //need a reconnectoin task to monitor the connection

        UniTaskCompletionSource<bool> tcs = new UniTaskCompletionSource<bool>();
        reconnectOpenHandler = () =>
        {
            Log("Reconnection IS successful!");
            websocket.OnOpen -= reconnectOpenHandler;
            websocket.OnClose -= reconnectCloseHandler;
            isConnecting = false;
            tcs.TrySetResult(true);
        };
        reconnectCloseHandler = (e) =>
        {
            Log("Reconnection HAS failed!");
            websocket.OnOpen -= reconnectOpenHandler;
            websocket.OnClose -= reconnectCloseHandler;
            isConnecting = false;
            tcs.TrySetResult(false);
        };


        int attempt = 0;

        bool connecting = true;
        while (attempt < maxRetries && connecting)
        {
            //Cancel any existing connection and start reconnection process
            websocket.CancelConnection();
            websocket.OnOpen += reconnectOpenHandler; // subscribe to events
            websocket.OnClose += reconnectCloseHandler;
            isConnecting = true;

            this.Log($"Reconnection attempt {attempt} of {maxRetries}...");
            attempt++;

            try
            {
                // Reset the TaskCompletionSource for this attempt
                tcs = new UniTaskCompletionSource<bool>();

                // Start the connection attempt
#if UNITY_WEBGL && !UNITY_EDITOR
                var conn = websocket.Connect().AsUniTask();
#else
                var conn = UniTask.Create(async () => await websocket.Connect());
#endif

                Enqueue(() =>
                {
                    OnConnectionStateChange?.Invoke(WalletConnectionState.Connecting);
                });

                // Wait for either the connection to complete or the event handlers to fire
                await UniTask.WhenAny(conn, tcs.Task);

                // Get the result from our TaskCompletionSource
                bool connectionResult = await tcs.Task;

                if (connectionResult && websocket.State == WebSocketState.Open)
                {
                    Log("Reconnected successfully!");
                    isConnecting = false;
                    connecting = false;
                    Enqueue(() =>
                    {
                        OnConnectionStateChange?.Invoke(WalletConnectionState.Connected);
                    });
                    callback?.Invoke(true);// not sure if this breaks out of the for loop
                }
            }
            catch (Exception ex)
            {
                LogWarning($"Reconnection attempt {attempt} failed: {ex.Message}");
            }
            websocket.OnOpen -= reconnectOpenHandler;
            websocket.OnClose -= reconnectCloseHandler;
            await UniTask.Delay(delay);
        }
    }

    public async void resetConnection()
    {
        if (websocket != null && !this.PingConnection)
        {
            this.PingConnection = true;
            await PingWallet();
        }
    }




}
#endregion