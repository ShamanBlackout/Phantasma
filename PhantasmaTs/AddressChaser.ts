/********************************
 * Creator: Shaman Blackout
 * Occupation: Computer Scientist
 ********************************/
import { PhantasmaTS } from "phantasma-ts";

const host = "http://localhost:7077/rpc";
const nexus = "simnet";

//ts-ignore to ignore typescript warning about API null
//@ts-ignore
const RPC = new PhantasmaTS.PhantasmaAPI(host, null, nexus);
//collect addresses
async function collectAddresses(
  account: string,
  page: number,
  pageSize: number
) {
  //return a collection of addresses --in what format
  let results = RPC.getAddressTransactions(account, page, pageSize);
  results.then((value) => {
    //console.log(value);
    for (let x of value["result"]["txs"]) {
      console.log(x);
    }
  });
}

//Filter collection based user input
async function filterCollection() {
  //return the filtered collection of addresses
}

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
  let addressCount = RPC.getAddressTransactionCount(account, chain);

  //Addresses ignore

  /***************************************************************
   * Loop
   * 1) Get an amount of transactions within an address
   * 2) Page through transactions and filter out un-needed transactions
   * 3) Go through filtered transactions according to level of deepness
  
   ***************************************************************/
}

//Questions: How to do page and Pagesize factor in

let results = collectAddresses(
  "P2K9zmyFDNGN6n6hHiTUAz6jqn29s5G1SWLiXwCVQcpHcQb",
  1,
  25
);

/****************************************************************************************
 * hash: string; //Hash of the transaction
 * chainAddress: string; //Transaction chain address
 *  timestamp: number; //Block time
 *  blockHeight: number; //Block height at which the transaction was accepted
 *  blockHash: string; //Hash of the block
 *  script: string; //Script content of the transaction, in hexadecimal format
 *  payload: string; //Payload content of the transaction, in hexadecimal format
 *  events: Array<Event>; //List of events that triggered in the transaction
 *  result: string; //Result of the transaction, if any. Serialized, in hexadecimal format
 *  fee: string; //Fee of the transaction, in KCAL, fixed point
 *  state: string;
 *  signatures: Array<SignatureResult>;
 *  sender: string;
 *  gasPayer: string;
 *  gasTarget: string;
 *  gasPrice: string;
 *  gasLimit: string;
 *  expiration: number;
 *
 ******************************************************************************************/
