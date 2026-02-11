import {
  PhantasmaAPI,
  CarbonBinaryReader,
  TokenSchemasBuilder,
  VmDynamicStruct,
  hexToBytes,
} from "phantasma-sdk-ts";

async function main() {
  // Configure RPC connection
  const rpc = new PhantasmaAPI(
    "https://testnet.phantasma.info/rpc",
    undefined as any,
    "testnet",
  );

  // Your NFT details
  const tokenSymbol = "SHAMANTESTSUBJECTARRAYSTRING"; // e.g., "SHAMANTESTSUBJECTARRAYSTR"
  const nftAddress =
    "54362355864335746200477379197617348690395745325494912897018366505915161567820"; // The NFT address from minting

  console.log(`Fetching NFT: ${nftAddress}`);

  // Get NFT data from blockchain
  const nftData = await rpc.getNFT(tokenSymbol, nftAddress, true);

  console.log("NFT Data:", nftData);
  console.log("NFT RAM (hex):", nftData.ram);
  console.log("NFT ROM (hex):", nftData.rom);

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
    ram: [{ name: "databrick", type: "Array_String" }],
  };
  const tokenSchemas = TokenSchemasBuilder.fromJson(JSON.stringify(tokenJson));
  const ramSchema = tokenSchemas.ram;

  // Convert RAM hex string to bytes
  const ramBytes = hexToBytes(nftData.ram);
  console.log("RAM bytes length:", ramBytes.length);

  // Read the RAM structure
  const reader = new CarbonBinaryReader(ramBytes);
  const ramStruct = new VmDynamicStruct();
  ramStruct.readWithSchema(ramSchema, reader);

  console.log("RAM struct fields:", ramStruct.fields.length);

  // Extract the array data
  for (const field of ramStruct.fields) {
    const fieldName = String(field.name?.data ?? "");
    console.log(`Field name: ${fieldName}`);

    if (fieldName === "databrick") {
      const arrayData = field.value as unknown as string[];
      console.log("Array from blockchain:", arrayData);
    }
  }
}

main().catch(console.error);
