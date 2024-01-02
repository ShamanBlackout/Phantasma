const { PhantasmaTS } = require("phantasma-ts");

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

  //Sign's Transaction with WIF
  transaction.sign(WIF);

  let hexEncodedTx = transaction.ToStringEncoded(true);

  //Send Transaction
  let txHash = await RPC.sendRawTransaction(hexEncodedTx);

  //Return Transaction Hash
  return txHash;
}

async function deployContract() {
  //Wallet Stuff
  let WIF = "KxMn2TgXukYaNXx7tEdjh7qB2YaMgeuKy47j4rvKigHhBuZWeP3r"; //In wif Format
  let fromAddress = "P2K9zmyFDNGN6n6hHiTUAz6jqn29s5G1SWLiXwCVQcpHcQb";

  //Contract Stuff
  let pvm =
    "000D00040F52756E74696D652E56657273696F6E070004000D010301081A0001000A005E000D00043243757272656E74206E657875732070726F746F636F6C2076657273696F6E2073686F756C642062652038206F72206D6F72650C0000040203020D00040941646472657373282907000402020203020301000D020408446174612E53657403010D0004065F6F776E6572030007020B000D010436436F6E747261637420686173206265656E206465706C6F796564206279205068616E7461736D615453205375636365737366756C6C79030108D800000B000D010408446174612E4765740D02040C6465706C6F797465737430300D0003010803000D0004065F6F776E6572030003020701040303030D00040941646472657373282907000403040103010D0004094164647265737328290700040102030403040D02041152756E74696D652E49735769746E65737307020402090275010D040415496D70726F70657220766572696669636174696F6E0C0400000B000D010408446174612E4765740D02040C6465706C6F797465737430300D0003010803000D0004065F6F776E6572030003020701040303030D00040941646472657373282907000403040103010D0004094164647265737328290700040102030403040D02041152756E74696D652E49735769746E65737307020402090213020D040415496D70726F70657220766572696669636174696F6E0C0400000B";
  let abi =
    "040A496E697469616C697A65000000000001056F776E6572080474657374049700000000096F6E5570677261646500D9000000010466726F6D08066F6E4B696C6C0077010000010466726F6D0800";
  let gasPrice = PhantasmaTS.DomainSettings.DefaultMinimumGasFee; //Internal Blockchain minimum gas fee needed - i.e 100000
  let gasLimit = 21000;
  let contractName = "deploytest00"; //Whatever you want

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

  //Signs Transaction with your WIF
  transaction.sign(WIF);

  let hexEncodedTx = transaction.ToStringEncoded(true);

  //Sends Transaction
  let txHash = await RPC.sendRawTransaction(hexEncodedTx);

  //Returns Transaction Hash
  return txHash;
}

deployContract();
