/********************************
 * Creator: Shaman Blackout
 * Occupation: Computer Scientist
 ********************************/
import { PhantasmaTS } from "phantasma-ts";

const host = "http://localhost:7077/rpc";
const nexus = "simnet";

/********************************************************
 *
 * Return the NFT ids of a given contract for an address
 * for a game we might want to get the nftIds and display
 * them to users. Token data needed
 * @params
 * contractSymbol - Symbol of the contract you want to query
 * account - Address of the account that contains the NFT's
 * chain - chain the data is found
 ********************************************************/

async function getAccountNftsByContract(
  contractSymbol: string,
  account: string,
  chain: string
) {
  //ts-ignore to ignore typescript warning about API null
  //@ts-ignore
  const RPC = new PhantasmaTS.PhantasmaAPI(host, null, nexus);
  let nfts: Record<string, any> = {};
  let acct = await RPC.getTokenBalance(account, contractSymbol, chain);

  if (acct.ids) {
    for (let nftid = 0; nftid < acct.ids.length; nftid++) {
      nfts[String(acct.ids[nftid])] = (
        await RPC.getTokenData(contractSymbol, acct.ids[nftid])
      ).rom;
    }
  }
  /*****************************************************************
   * Loop through gathered Nfts and convert the Rom to human readable
   *****************************************************************/
  for (let id in nfts) {
    let rom = nfts[id];
    let byteArr = PhantasmaTS.hexToByteArray(rom);
    //let testArr = PhantasmaTS.hexStringToUint8Array(rom); //does not correctly convert to a Uint8Array

    //Phantasmas hexToByteArray creates an extra character at the beginning of the array.Must remove it
    byteArr.shift();
    let convarr = new Uint8Array(byteArr);

    let vmRom = PhantasmaTS.VMObject.FromBytes(convarr);
    let children: any;
    if (vmRom.GetChildren() != null) {
      children = vmRom.GetChildren();
    }

    var romDict: Record<string, any> = {};
    /***********************************************************************************
     * Loops through map of VMObject for Rom Data
     * Considers if Data is a Primitive Type or an Object
     * Vm Object returns an array of 2 VM object, key is  contained in 1st element
     * value is contained in 2nd element
     ***********************************************************************************/
    for (let vmObj of children) {
      if (vmObj[1].Data === Object(vmObj[1].Data)) {
        romDict[vmObj[0].Data] = vmObj[1].AsString();
      } else {
        romDict[vmObj[0].Data] = vmObj[1].Data;
      }
    }
    nfts[id] = romDict;
  }

  return nfts;
}
/************************************************************************
 * Usage: Only used to
 * @param contract
 * @param method
 * @param args
 ***********************************************************************/
async function invokeCalls(contract: string, method: string, args: any[]) {
  //ts-ignore to ignore typescript warning about API null
  //@ts-ignore
  const RPC = new PhantasmaTS.PhantasmaAPI(host, null, nexus);

  let sb = new PhantasmaTS.ScriptBuilder();
  sb.CallContract(contract, method, args);
  let script = sb.EndScript();
  let targetNet = "main";

  // NOTE - we assume RPC was instantiated previously already, check other samples to see how
  let response = await RPC.invokeRawScript(targetNet, script);

  const decoder = new PhantasmaTS.Decoder(response.result);
  const value = decoder.readVmObject();
  console.log(value); // print the decoded value to the console
}

//not yet working, please wait
async function sendTrans(contract: string, method: string, args: any[]) {
  //ts-ignore to ignore typescript warning about API null
  //@ts-ignore
  const RPC = new PhantasmaTS.PhantasmaAPI(host, null, nexus);

  let node_pk = [
    "21fcaa2b0dcf1b63c0d9bc032fc678581e9e71d7675fb70c6388dbfd35c438a4",
    "a89be55f420594cd63ab935d3b379305d7769f039a8e734c8581d00dca683efa",
    "d2f3b69a3a0af7f7a2a071e92ed1ecdc4ed9e0663b948c92885248c5ae537ba9",
    "3093aefaf852d59df0b6d9de60249beb88a37af8a93bba88e18d81ae45664f1e",
  ];

  let fromAddress = "yourPublicWalletAddress";
  let toAddress = "addressYourSendingTo";

  //Creating a new Script Builder Object
  let sb = new PhantasmaTS.ScriptBuilder();
  let gasPrice = 10000;
  let gasLimit = 21000;

  //Making a Script
  let script = sb
    .AllowGas(fromAddress, sb.NullAddress, gasPrice, gasLimit)
    .CallInterop("Runtime.TransferTokens", [
      fromAddress,
      toAddress,
      "KCAL",
      10000000000,
    ]) //10000000000 = 1 KCAL
    .SpendGas(fromAddress)
    .EndScript();

  //Used to set expiration date
  let expiration = 5; //This is in miniutes
  let getTime = new Date();
  let date = new Date(getTime.getTime() + expiration * 60000);

  let payload = Base16.encode("Phantasma-ts"); //Says '7068616e7461736d612d7473' in hex

  //Creating New Transaction Object
  let transaction = new PhantasmaTS.Transaction(
    "testnet", //Nexus Name - if you're using mainnet change it to mainnet or simnet if you're using you localnode
    "main", //Chain
    script, //In string format
    expiration, //Date Object
    payload //Extra Info to attach to Transaction in Serialized Hex
  );

  //Sign's Transaction with Private Key
  transaction.sign(node_pk[0]);

  //Send Transaction
  let txHash = await RPC.sendRawTransaction(transaction.toString(true));

  //Return Transaction Hash
  return txHash;
}

//P2K9zmyFDNGN6n6hHiTUAz6jqn29s5G1SWLiXwCVQcpHcQb - first address
//P2K65RZhfxZhQcXKGgSPZL6c6hkygXipNxdeuW5FU531Bqc -2nd addresss

getAccountNftsByContract(
  "SRT",
  "P2K9zmyFDNGN6n6hHiTUAz6jqn29s5G1SWLiXwCVQcpHcQb",
  "main"
);

/***
let contract = "mail";
let method = "PushMessage";
let args = [
  "P2K9zmyFDNGN6n6hHiTUAz6jqn29s5G1SWLiXwCVQcpHcQb",
  "P2K65RZhfxZhQcXKGgSPZL6c6hkygXipNxdeuW5FU531Bqc",
  "20077272D341A946043610E7D40F2ECE33D0AF82729C480FE2C8ACDD66DC2C2A50",
];

let node_pk = [
  "21fcaa2b0dcf1b63c0d9bc032fc678581e9e71d7675fb70c6388dbfd35c438a4",
  "a89be55f420594cd63ab935d3b379305d7769f039a8e734c8581d00dca683efa",
  "d2f3b69a3a0af7f7a2a071e92ed1ecdc4ed9e0663b948c92885248c5ae537ba9",
  "3093aefaf852d59df0b6d9de60249beb88a37af8a93bba88e18d81ae45664f1e",
];
console.log(node_pk[3]);
 ********/
