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
    //let testArr = PhantasmaTS.hexStringToUint8Array(crom); //does not correctly convert to a Uint8Array

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

//P2K9zmyFDNGN6n6hHiTUAz6jqn29s5G1SWLiXwCVQcpHcQb - first address
//P2K65RZhfxZhQcXKGgSPZL6c6hkygXipNxdeuW5FU531Bqc -2nd addresss
getAccountNftsByContract(
  "TNTT",
  "P2K65RZhfxZhQcXKGgSPZL6c6hkygXipNxdeuW5FU531Bqc",
  "main"
);
