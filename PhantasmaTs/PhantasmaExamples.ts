const { PhantasmaTS } = require("phantasma-ts");

var host = "http://localhost:7077/rpc";
var nexus = "simnet";

async function sendTransaction() {
  let WIF = "KxMn2TgXukYaNXx7tEdjh7qB2YaMgeuKy47j4rvKigHhBuZWeP3r"; //In WIF Format - simnet node 0 WIF
  let fromAddress = "P2K9zmyFDNGN6n6hHiTUAz6jqn29s5G1SWLiXwCVQcpHcQb"; //simnet node0
  let toAddress = "P2K65RZhfxZhQcXKGgSPZL6c6hkygXipNxdeuW5FU531Bqc"; //simnet node1

  //Creating RPC Connection **(Needs To Be Updated)
  let RPC = new PhantasmaTS.PhantasmaAPI(
    "http://localhost:7077/rpc",
    null,
    "simnet"
  );

  //set Gas parameters for Runtime.TransferTokens
  let gasPrice = PhantasmaTS.DomainSettings.DefaultMinimumGasFee; //Internal Blockchain minimum gas fee needed - i.e 100000
  let gasLimit = 9999;

  //Creating a new Script Builder Object
  let sb = new PhantasmaTS.ScriptBuilder();

  //Making a Script
  let script = sb
    .BeginScript()
    .AllowGas(fromAddress, sb.NullAddress, gasPrice, gasLimit)
    .CallInterop("Runtime.TransferTokens", [
      fromAddress,
      toAddress,
      "SOUL",
      100000000,
    ]) //100000000 = 1 SOUL
    .SpendGas(fromAddress)
    .EndScript();

  //Used to set expiration date
  let expiration = 5; //This is in miniutes
  let getTime = new Date();
  let expiration_date = new Date(getTime.getTime() + expiration * 60000);

  let payload = PhantasmaTS.Base16.encode("Phantasma-ts"); //Says '7068616e7461736d612d7473' in hex

  //Creating New Transaction Object
  let transaction = new PhantasmaTS.Transaction(
    "simnet", //Nexus Name - if you're using mainnet change it to mainnet or simnet if you're using you localnode
    "main", //Chain
    script, //In string format
    expiration_date, //Date Object
    payload //Extra Info to attach to Transaction in Serialized Hex
  );

  //Sign's Transaction with WIF
  transaction.sign(WIF);
  let hexEncodedTx = transaction.ToStringEncoded(true); //converts trasnaction to base16 string -true means transaction is signed-

  //Send Transaction
  let txHash = await RPC.sendRawTransaction(hexEncodedTx);
  //Return Transaction Hash
  return txHash;
}

async function stakeSOUL() {
  let WIF = "KxMn2TgXukYaNXx7tEdjh7qB2YaMgeuKy47j4rvKigHhBuZWeP3r"; //WIF format

  let fromAddress = "P2K9zmyFDNGN6n6hHiTUAz6jqn29s5G1SWLiXwCVQcpHcQb"; // Phantasma Public Address

  //Creating a new Script Builder Object
  let sb = new PhantasmaTS.ScriptBuilder();
  let gasPrice = PhantasmaTS.DomainSettings.DefaultMinimumGasFee; //Internal Blockchain minimum gas fee needed - i.e 100000
  let gasLimit = 21000;
  let amount = String(10 * 10 ** 8); // 100 the amount - 10**8 it's to get the decimals to the desired amount
  // Soul has 8 decimals places.

  //Creating RPC Connection **(Needs To Be Updated)
  let RPC = new PhantasmaTS.PhantasmaAPI(
    "http://localhost:7077/rpc",
    null,
    "simnet"
  );

  //Making a Script
  let script = sb
    .AllowGas(fromAddress, sb.NullAddress, gasPrice, gasLimit)
    .CallContract("stake", "Stake", [fromAddress, amount])
    .SpendGas(fromAddress)
    .EndScript();

  //Used to set expiration date
  let expiration = 5; //This is in miniutes
  let getTime = new Date();
  let expiration_date = new Date(getTime.getTime() + expiration * 60000);

  let payload = "7068616e7461736d612d7473"; //Says 'Phantasma-ts' in hex

  //Creating New Transaction Object
  let transaction = new PhantasmaTS.Transaction(
    "simnet", //Nexus Name - if you're using mainnet change it to mainnet
    "main", //Chain
    script, //In string format
    expiration_date, //Date Object
    payload //Extra Info to attach to Transaction in Serialized Hex
  );

  //Sign's Transaction with Private Key
  transaction.sign(WIF);

  let hexEncodedTx = transaction.ToStringEncoded(true);

  //Send Transaction
  let txHash = await RPC.sendRawTransaction(hexEncodedTx);

  //Return Transaction Hash
  return txHash;
}

async function deployContract() {
  //Wallet Stuff
  let WIF = "WIF"; //In wif Format
  let fromAddress = "publicAddress";

  //Contract Stuff
  let pvm = "PVM HEX String";
  let abi = "ABI HEX String";
  let gasPrice = PhantasmaTS.DomainSettings.DefaultMinimumGasFee; //Internal Blockchain minimum gas fee needed - i.e 100000
  let gasLimit = 21000;
  let contractName = "ContractName"; //Whatever you want

  //Creating a new Script Builder Object
  let sb = new PhantasmaTS.ScriptBuilder();

  //New RPC and Peers Needed
  //Creating RPC Connection, use ('http://testnet.phantasma.io:5101/rpc', null, 'testnet') for testing
  let RPC = new PhantasmaTS.PhantasmaAPI(
    "http://localhost:7077/rpc",
    null,
    "simnet"
  );

  //Making a Script
  let script = sb
    .AllowGas(fromAddress, sb.NullAddress, gasPrice, gasLimit)
    .CallInterop("Runtime.DeployContract", [
      fromAddress,
      contractName,
      pvm,
      abi,
    ])
    .SpendGas(fromAddress)
    .EndScript();

  //Used to set expiration date
  let expiration = 5; //This is in miniutes
  let getTime = new Date();
  let expiration_date = new Date(getTime.getTime() + expiration * 60000);

  //Setting Temp Payload
  let payload = "MyApp";

  //Creating New Transaction Object
  let transaction = new PhantasmaTS.Transaction(
    "simnet", //Nexus Name
    "main", //Chain
    script, //In string format
    expiration_date, //Date Object
    payload //Extra Info to attach to Transaction in Serialized Hex
  );

  //Deploying Contract Requires POW -- Use a value of 5 to increase the hash difficulty by at least 5
  transaction.mineTransaction(5);

  //Signs Transaction with your private key
  transaction.sign(WIF);

  let hexEncodedTx = transaction.ToStringEncoded(true);

  //Sends Transaction
  let txHash = await RPC.sendRawTransaction(hexEncodedTx);

  //Returns Transaction Hash
  return txHash;
}
