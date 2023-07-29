const { phantasmaJS } = require("phantasma-ts");
import { PhantasmaLink } from "phantasma-ts";
import { Base16, PhantasmaAPI, ScriptBuilder } from "phantasma-ts/core";
import { isUint8Array } from "util/types";


async function ownerAutoSendTrans() {
  //Wallet Stuff
  let wif = "KxMn2TgXukYaNXx7tEdjh7qB2YaMgeuKy47j4rvKigHhBuZWeP3r";//simnet WIF
  let keys = phantasmaJS.PhantasmaKeys.fromWIF(wif);
  let fromAddress = "P2K9zmyFDNGN6n6hHiTUAz6jqn29s5G1SWLiXwCVQcpHcQb";//
  let toAddress = "P2K65RZhfxZhQcXKGgSPZL6c6hkygXipNxdeuW5FU531Bqc"; //

  let host = "http://localhost:7077/rpc";
  let nexus = "simnet";

  let gasPrice: number = 100000;
  let gasLimit: number = 9999999;

  let RPC = new phantasmaJS.PhantasmaAPI(host, undefined, nexus);
  let sb = new phantasmaJS.ScriptBuilder();
  let script = sb
    .AllowGas(fromAddress, sb.NullAddress, gasPrice, gasLimit)
    .CallInterop("Runtime.TransferTokens", cvar) //.CallContract(contractName, contractMethod, contractVariables)
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
  //Deploying Contract Requires POW -- Use a value of 5 to increase the hash difficulty by at least 5
  transaction.sign(wif);
  let rawTx = Base16.encodeUint8Array(transaction.ToByteAray(true));
  let txHash = await RPC.sendRawTransaction(rawTx);
  console.log("Hash is: " + txHash);
}
