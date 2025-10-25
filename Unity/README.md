# 🧩 PhantasmaLinkClientSB for Unity

A Unity MonoBehaviour client for connecting to the Phantasma blockchain via Poltergeist Wallet using WebSockets. Built for Dapp integration, asset management, and secure transaction signing.

## 🚀 Features

- WebSocket-based wallet connection Support (Poltergeist)
- Web Support with UniTask
- Login and authorization flow
- Fetch account balances and NFT ownership
- Sign transactions and arbitrary data
- Auto-reconnect with retry logic
- Singleton pattern with Unity lifecycle hooks

## 📦 Setup

1. Clone or download the repo:

2. Copy `PhantasmaLinkClientSB.cs` into your Unity project's `Assets` folder.

3. Ensure the following dependencies are installed:
- [Cysharp UniTask](https://github.com/Cysharp/UniTask)
- [PhantasmaPhoenix.Unity.Core & PhantasmaPhoenix.Unity.LinkClient] (https://github.com/phantasma-io/Phantasma-UnitySDK)
- [Core Unity giturl] (https://github.com/phantasma-io/Phantasma-UnitySDK.git?path=PhantasmaPhoenix.Unity.Core)
- [LinkClient Unity giturl] (https://github.com/phantasma-io/Phantasma-UnitySDK.git?path=PhantasmaPhoenix.Unity.LinkClient)

## 🛠️ Configuration

Set parameters in the Unity Inspector:

- `DappID`: Your Dapp contract name
- `Host`: Wallet endpoint (default: `localhost:7090`)
- `Platform`: Blockchain platform (e.g., Phantasma)
- `Signature`: Signature type (e.g., ED25519)
- `GasPrice` / `GasLimit`: Transaction gas settings
- `Nexus`: Network type (`simnet`, `testnet`, `mainnet`)

## 📡 Usage

### Initialization

```csharp
void Start() {
 PhantasmaLinkClientSB.Instance.Enable();
}
