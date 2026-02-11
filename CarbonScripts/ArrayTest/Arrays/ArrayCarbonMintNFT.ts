import {
  Bytes32,
  MintNftFeeOptions,
  CarbonBinaryWriter,
  MintNonFungibleTxHelper,
  MetadataField,
  NftRomBuilder,
  PhantasmaAPI,
  PhantasmaKeys,
  TokenSchemasBuilder,
  VmDynamicStruct,
  VmNamedDynamicVariable,
  getRandomPhantasmaId,
  VmType,
  SmallString,
  CarbonBlob,
  CarbonBinaryReader,
  ICarbonBlob,
} from "phantasma-sdk-ts";

import { parseHexBytes, parseVmMetadataValue } from "../../helper/metadata.js";
import { ensureError, toMessage } from "../../helper/errors.ts";
import { WIF_KEY, RPC_URL, NEXUS } from "../../config.js";

async function main() {
  // Set RAM values before processing
  const keys = PhantasmaKeys.fromWIF(WIF_KEY);
  const creatorPk = new Bytes32(keys.PublicKey);
  const carbonTokenId = 107n;
  const carbonSeriesId = 1;
  const tokenJson = {
    seriesMetadata: [
      { name: "name", type: "String" },
      { name: "description", type: "String" },
      { name: "imageURL", type: "String" },
      { name: "infoURL", type: "String" },
      { name: "royalties", type: "Int32" },
    ],
    rom: [],
    ram: [{ name: "datbrick", type: "Array" }], // Array of Carbon blobs
  };
  const tokenSchemas = TokenSchemasBuilder.fromJson(JSON.stringify(tokenJson));

  var seriesSchema = tokenSchemas.seriesMetadata;
  const romSchema = tokenSchemas.rom;
  let ramSchema = tokenSchemas.ram;
  var metadata: MetadataField[] = [
    { name: "name", value: "Shaman Array Test NFT" },
    { name: "description", value: "Shaman Array Test NFT" },
    { name: "imageURL", value: "sometest.com" },
    { name: "infoURL", value: "sometest.com" },
    { name: "royalties", value: 10 },
  ];

  const phantasmaNftId = await getRandomPhantasmaId();
  const rom = NftRomBuilder.buildAndSerialize(
    romSchema,
    phantasmaNftId,
    metadata,
  );

  const feeOptions = new MintNftFeeOptions();
  const maxData = 100_000_000n;

  /**********************
   * Build the ram Schema
   **********************/

  let ramPayload = new Uint8Array();
  if (
    ramSchema &&
    Array.isArray(ramSchema.fields) &&
    ramSchema.fields.length > 0
  ) {
    const writer = new CarbonBinaryWriter();
    const ramStruct = new VmDynamicStruct();

    ramStruct.fields = [];
    const schemaFieldsRam = ramSchema.fields ?? [];

    console.log(`RAM Schema Fields: ${schemaFieldsRam}`);

    // Create an array of Carbon blob objects
    const namesArr = ["databrick", "metadataArray", "metadataMap"];

    // Wrap each string in a Carbon blob

    // Store as Array type with Carbon blob elements
    const fieldName = VmNamedDynamicVariable.from(
      "datbrick",
      VmType.Array,
      namesArr, // Array of Carbon blobs
    );
    ramStruct.fields.push(fieldName);

    // Now serialize the complete ramStruct
    ramStruct.writeWithSchema(ramSchema, writer);
    ramPayload = new Uint8Array(writer.toUint8Array());

    console.log(
      "RAM Payload:",
      Array.from(ramPayload)
        .map((b) => `0x${b.toString(16).padStart(2, "0")}`)
        .join(" "),
    );

    //Read the RAM data back from ramPayload
    const reader = new CarbonBinaryReader(ramPayload);
    const readRamStruct = new VmDynamicStruct();
    readRamStruct.readWithSchema(ramSchema, reader);

    console.log(
      "Read RAM struct - number of fields:",
      readRamStruct.fields.length,
    );

    //End of ram schema build

    //   const txHex = MintNonFungibleTxHelper.buildTxAndSignHex(
    //     carbonTokenId,
    //     carbonSeriesId,
    //     keys,
    //     creatorPk,
    //     rom,
    //     ramPayload,
    //     feeOptions,
    //     maxData,
    //   );

    //   const rpc = new PhantasmaAPI(
    //     "https://testnet.phantasma.info/rpc",
    //     undefined as any,
    //     "testnet",
    //   );
    //   const txHash = await rpc.sendCarbonTransaction(txHex);

    //   const txInfo = await rpc.getTransaction(txHash);
    //   const carbonNftAddresses = MintNonFungibleTxHelper.parseResult(
    //     carbonTokenId,
    //     txInfo.result,
    //   );
    //   console.log(carbonNftAddresses[0].ToHex());
  }
}

main().catch(console.error);
