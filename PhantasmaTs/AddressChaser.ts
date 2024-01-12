/********************************
 * Creator: Shaman Blackout
 * Occupation: Computer Scientist
 ********************************/
import { PhantasmaTS } from "phantasma-ts";

const host = "http://localhost:7077/rpc";
const nexus = "simnet";

/*****************************************************************
 *
 * An address should be inputted and "chased"
 * "Chased" -> means that all transctions
 * incoming and outgoing should be chased
 * Specifying a level of deepness would tell the algorithm to
 * chase the address collected in the first level. Any address
 * chased in a "collection" would be considered another level
 * of deepness.
 * @params
 * @account - Address of the account that should be chased
 * @level - How deep you should chase the address
 * @chain - chain where the address should be chased
 ****************************************************************/
async function chaseAddress(account: string, level: number, chain: string) {
  //ts-ignore to ignore typescript warning about API null
  //@ts-ignore
  const RPC = new PhantasmaTS.PhantasmaAPI(host, null, nexus);
}

//P2K9zmyFDNGN6n6hHiTUAz6jqn29s5G1SWLiXwCVQcpHcQb - first address
//P2K65RZhfxZhQcXKGgSPZL6c6hkygXipNxdeuW5FU531Bqc -2nd addresss
