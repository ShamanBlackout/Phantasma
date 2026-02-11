import {
  PhantasmaAPI,
  CarbonBinaryReader,
  TokenSchemasBuilder,
  VmDynamicStruct,
  hexToBytes,
  VmStructSchema,
  VmNamedVariableSchema,
  VmType,
  VmVariableSchema,
  VmNamedDynamicVariable,
} from "phantasma-sdk-ts";
import { WIF_KEY, RPC_URL, NEXUS } from "../config.js";

async function main() {
  // Configure RPC connection
  const rpc = new PhantasmaAPI(RPC_URL, undefined as any, NEXUS);

  // Your NFT details
  const tokenSymbol = "STRUCTTESTPTONE"; // e.g., "SHAMANTESTSUBJECTARRAYSTR"
  const nftAddress =
    "36694132851276716858149836604369275542992329185966872538537798990208671071009"; // The NFT address from minting

  console.log(`Fetching NFT: ${nftAddress}`);

  // Get NFT data from blockchain
  const nftData = await rpc.getNFT(tokenSymbol, nftAddress, true);

  // Define the schema (must match what you used when minting)
  const tokenJson = {
    seriesMetadata: [
      { name: "name", type: "String" },
      { name: "description", type: "String" },
      { name: "imageURL", type: "String" },
      { name: "infoURL", type: "String" },
      { name: "royalties", type: "Int32" },
    ],
    rom: [],
    ram: [],
  };

  var ramSchema = new VmStructSchema();

  var nestedSchema = new VmStructSchema([
    new VmNamedVariableSchema("person_name", VmType.String),
    new VmNamedVariableSchema("person_age", VmType.Int8),
  ]);

  var structSchema = new VmVariableSchema(VmType.Struct, nestedSchema);
  ramSchema.fields.push(new VmNamedVariableSchema("Person", structSchema));

  // Convert RAM hex string to bytes
  const ramBytes = hexToBytes(nftData.ram);

  // Read the RAM structure as VmDynamicStruct
  const reader = new CarbonBinaryReader(ramBytes);
  const ramStruct = new VmDynamicStruct();
  ramStruct.readWithSchema(ramSchema, reader);

  console.log("Decoded RAM Struct:", JSON.stringify(ramStruct));
}
main().catch(console.error);
