const { phantasmaJS } = require("phantasma-ts");
import { PhantasmaLink } from "phantasma-ts";
import { Base16, PhantasmaAPI, ScriptBuilder } from "phantasma-ts/core";
import { isUint8Array } from "util/types";

/************************************************************
 * Creators: Shaman Blackout & Thomas Ken (thomas0114)
 *
 *  Allows for a developer to automatically sign transactions
 *  when a smart contract function is called.
 *
 ***********************************************************/
async function ownerAutoSendTrans() {
  //Wallet Stuff
  let wif = "KxMn2TgXukYaNXx7tEdjh7qB2YaMgeuKy47j4rvKigHhBuZWeP3r"; //simnet WIF
  let keys = phantasmaJS.PhantasmaKeys.fromWIF(wif);
  let fromAddress = "P2K9zmyFDNGN6n6hHiTUAz6jqn29s5G1SWLiXwCVQcpHcQb"; //
  let toAddress = "P2K65RZhfxZhQcXKGgSPZL6c6hkygXipNxdeuW5FU531Bqc"; //
  let cvar = [fromAddress, toAddress, "KCAL", 10000000000]; //1kcal

  let host = "http://localhost:7077/rpc";
  let nexus = "simnet";

  let gasPrice: number = 100000;
  let gasLimit: number = 9999999;
  //Must ignore PhantasmaAPI error about passing an undefined or null when string is expected
  //@ts-ignore
  let RPC = new phantasmaJS.PhantasmaAPI(host, undefined, nexus);
  let sb = new phantasmaJS.ScriptBuilder();
  let script = sb
    .AllowGas(fromAddress, sb.NullAddress, gasPrice, gasLimit)
    .CallInterop("Runtime.TransferTokens", cvar)
    .SpendGas(fromAddress)
    .EndScript();

  //Used to set expiration date
  let expiration = 5; //This is in miniutes
  let getTime = new Date();
  let date = new Date(getTime.getTime() + expiration * 60000);

  let payload = "";
  //Creating New Transaction Object
  let transaction = new phantasmaJS.Transaction(
    nexus, //Nexus Name
    "main", //Chain
    script, //In string format
    date, //Date Object
    payload //Extra Info to attach to Transaction in Serialized Hex
  );

  transaction.sign(wif);
  let rawTx = Base16.encodeUint8Array(transaction.ToByteAray(true));
  let txHash = await RPC.sendRawTransaction(rawTx);
  console.log("Hash is: " + txHash);
}
