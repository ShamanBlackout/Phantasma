import {
  Bytes32,
  PhantasmaAPI,
  PhantasmaKeys,
  TokenSchemasBuilder,
  VmDynamicStruct,
  VmNamedDynamicVariable,
  VmType,
  CarbonBinaryWriter,
  hexToBytes,
  Address,
  ScriptBuilder,
  Transaction,
  Base16,
} from "phantasma-sdk-ts";
import { WIF_KEY, RPC_URL, NEXUS } from "../../config.js";

async function main() {
  // Your credentials
  const keys = PhantasmaKeys.fromWIF(WIF_KEY);

  // NFT details
  const tokenSymbol = "SHAMANTESTSUBJECTARRAYSTR";
  const carbonTokenId = 109n;
  const nftAddress =
    "10885681501006153251963166823853549525832528771793274296177012711434633678938";
  // Configure RPC
  const rpc = new PhantasmaAPI(
    "https://testnet.phantasma.info/rpc",
    undefined as any,
    "testnet",
  );

  // Define the schema
  const tokenJson = {
    seriesMetadata: [
      { name: "name", type: "String" },
      { name: "description", type: "String" },
      { name: "imageURL", type: "String" },
      { name: "infoURL", type: "String" },
      { name: "royalties", type: "Int32" },
    ],
    rom: [],
    ram: [{ name: "databrick", type: "Array_String" }],
  };
  const tokenSchemas = TokenSchemasBuilder.fromJson(JSON.stringify(tokenJson));
  const ramSchema = tokenSchemas.ram;

  // Create new RAM data with updated array
  const newNamesArr = ["Cheese", "Potatoes", "MilkAndHoney", "SmokedFish"];
  console.log("New array data:", newNamesArr);

  // Build the new RAM payload
  const writer = new CarbonBinaryWriter();
  const ramStruct = new VmDynamicStruct();
  ramStruct.fields = [];

  const fieldName = VmNamedDynamicVariable.from(
    "databrick",
    VmType.Array_String,
    newNamesArr,
  );
  ramStruct.fields.push(fieldName);

  ramStruct.writeWithSchema(ramSchema, writer);
  const newRamPayload = new Uint8Array(writer.toUint8Array());
  console.log(newRamPayload);

  console.log("New RAM payload size:", newRamPayload.length, "bytes");

  // Build the update transaction using ScriptBuilder
  const gasPrice = 100000;
  const gasLimit = 900000;

  const sb = new ScriptBuilder();
  const script = sb
    .BeginScript()
    .AllowGas(keys.Address, Address.Null, gasPrice, gasLimit)
    .CallInterop("Runtime.WriteToken", [
      keys.Address,
      tokenSymbol,
      nftAddress,
      newRamPayload,
    ])
    .SpendGas(keys.Address)
    .EndScript();

  // console.log("Building transaction...");
  // const payload = Base16.encode("Shaman's Test Update");
  // // Build a complete transaction with expiration
  // const expiration = new Date(Date.now() + 300 * 1000); // 5 minutes from now
  // const tx = new Transaction(
  //   "testnet", // nexus name
  //   "main", // chain
  //   script,
  //   expiration,
  //   payload, // payload
  // );

  // // Sign the transaction
  // tx.signWithKeys(keys);

  // console.log("Sending update transaction...");

  // // Send the transaction
  // let transactionSignedBytes = tx.toString(true);
  // const txHash = await rpc.sendRawTransaction(transactionSignedBytes);
  // console.log("Transaction hash:", txHash);

  // // Wait for confirmation
  // await new Promise((resolve) => setTimeout(resolve, 3000));

  // // Get transaction result
  // const txInfo = await rpc.getTransaction(txHash);
  // console.log("Transaction result:", txInfo);
  // console.log("NFT RAM data updated successfully!");
}

main().catch(console.error);
