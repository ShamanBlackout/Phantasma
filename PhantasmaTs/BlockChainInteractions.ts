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

async function sendTrans(
  contract: string,
  method: string,
  args: any[],
  params: any[]
) {
  //ts-ignore to ignore typescript warning about API null
  //@ts-ignore
  const RPC = new PhantasmaTS.PhantasmaAPI(host, null, nexus);

  //Creating a new Script Builder Object
  let sb = new PhantasmaTS.ScriptBuilder();
  let gasPrice = 100000;
  let gasLimit = 99999;
  console.log("before script");
  console.log(PhantasmaTS.Address.IsValidAddress(args[0]));
  let addy = PhantasmaTS.Address.FromText(args[0]);

  sb.BeginScript()
    .AllowGas(args[0], sb.NullAddress, gasPrice, gasLimit)
    .CallContract(contract, method, params)
    .SpendGas(args[0]);
  let script = sb.EndScript();

  let expiration = 5; //This is in miniutes
  let getTime = new Date();
  let expiration_date = new Date(getTime.getTime() + expiration * 60000);

  let payload = PhantasmaTS.Base16.encode("Phantasma-ts"); //Says '7068616e7461736d612d7473' in hex

  console.log("before transaction");

  //Creating New Transaction Object
  let transaction = new PhantasmaTS.Transaction(
    nexus, //Nexus Name - if you're using mainnet change it to mainnet or simnet if you're using you localnode
    "main", //Chain
    script, //In string format
    expiration_date, //Date Object
    payload //Extra Info to attach to Transaction in Serialized Hex
  );

  transaction.sign(args[1]);

  let rawTx = PhantasmaTS.Base16.encodeUint8Array(transaction.ToByteAray(true));
  //Send Transaction
  let txHash = await RPC.sendRawTransaction(rawTx);

  //Return Transaction Hash
  return txHash;
}

function test() {
  let pvm =
    "000D00040F52756E74696D652E56657273696F6E070004000D010301081A0001000A005E000D00043243757272656E74206E657875732070726F746F636F6C2076657273696F6E2073686F756C642062652038206F72206D6F72650C0000040203020D00040941646472657373282907000402020203020301000D020408446174612E53657403010D0004065F6F776E6572030007020B000D010436436F6E747261637420686173206265656E206465706C6F796564206279205068616E7461736D615453205375636365737366756C6C79030108D800000B000D010408446174612E4765740D02040C6465706C6F797465737430300D0003010803000D0004065F6F776E6572030003020701040303030D00040941646472657373282907000403040103010D0004094164647265737328290700040102030403040D02041152756E74696D652E49735769746E65737307020402090275010D040415496D70726F70657220766572696669636174696F6E0C0400000B000D010408446174612E4765740D02040C6465706C6F797465737430300D0003010803000D0004065F6F776E6572030003020701040303030D00040941646472657373282907000403040103010D0004094164647265737328290700040102030403040D02041152756E74696D652E49735769746E65737307020402090213020D040415496D70726F70657220766572696669636174696F6E0C0400000B";
  let ret = PhantasmaTS.HexToBytes(pvm);

  console.log(ret);
}

let node_addr = [
  "P2K9zmyFDNGN6n6hHiTUAz6jqn29s5G1SWLiXwCVQcpHcQb",
  "P2K65RZhfxZhQcXKGgSPZL6c6hkygXipNxdeuW5FU531Bqc",
  "P2KAcEJk2UPvTP5rStzeeSJCboE9yEdA2meNVT7UNiKbdH3",
  "P2KLvu4UWXFz4r86PsCrtPdJSgkqCSWTZHjDgqdXXJ6Se1v",
];

let node_WIF = [
  "KxMn2TgXukYaNXx7tEdjh7qB2YaMgeuKy47j4rvKigHhBuZWeP3r",
  "L2sTuSzangXQCFxXFXJqfPAKJsstKvQdkGqP9J2VFkFRbEjd1Ez6",
  "L4Hmr2tsa7qNjp9syg4PW8MjLrrXobe7MNFWQmryg1jKzf8c3Y1D",
  "Kxr8xW8gwX617zieFeS3ByWcFgEoGKbR1QJyJ1YgCKofP7mqudgH",
];
/**
getAccountNftsByContract(
  "SDT",
  "P2K9zmyFDNGN6n6hHiTUAz6jqn29s5G1SWLiXwCVQcpHcQb",
  "main"
);
**/

let args = [node_addr[1], node_WIF[1]];
let params: any = [
  "P2K65RZhfxZhQcXKGgSPZL6c6hkygXipNxdeuW5FU531Bqc",
  "23026707334428162792539697278208738065996405703899924061098963047980672034548",
  "6",
];

sendTrans("SDT", "updateDurability", args, params);
test();
