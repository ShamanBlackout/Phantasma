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
    //A dictionary of dictionaries
    //If I show token send / receive then I would have to decode the data in the event. How would I do that

    /************************************************************************************
     * Store the last transaction hash
     * This is assuming that the transactions are all ordered
     * If im using graph theory then I would need to filter and organize the data
     *
     ********************************************8***************************************/
    let addressCollection = {};
    for (let x of value["result"]["txs"]) {
      console.log(x);
      /******************************
       * Go through the event data and
       * get kind : TokenRecieve
       *     kind: TokenSend
       *  decrypt data of both
       *
       *******************************/
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
/*
let results = collectAddresses(
  "P2KAcEJk2UPvTP5rStzeeSJCboE9yEdA2meNVT7UNiKbdH3",
  1,
  25
);
*/
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

//testing decoder

console.log(
  PhantasmaTS.Base16.decode(
    "0D000302340803000D000303A0860103000D000223220000000000000000000000000000000000000000000000000000000000000000000003000D000223220100657B86EBF14E6D5CF89A10A92B03C78BA47F6677A123FB7E5F0C3BE035F9E88203000D000408416C6C6F7747617303000D0004036761732D00012E010D00030500AC23FC0603000D000404534F554C03000D000223220100FED8AB8FB1BE9479A267F2FDE035685C3C01842EDBA8FBF8CE8552ED195ABBC103000D000223220100657B86EBF14E6D5CF89A10A92B03C78BA47F6677A123FB7E5F0C3BE035F9E88203000D00041652756E74696D652E5472616E73666572546F6B656E7307000D000223220100657B86EBF14E6D5CF89A10A92B03C78BA47F6677A123FB7E5F0C3BE035F9E88203000D0004085370656E6447617303000D0004036761732D00012E010B"
  )
);
