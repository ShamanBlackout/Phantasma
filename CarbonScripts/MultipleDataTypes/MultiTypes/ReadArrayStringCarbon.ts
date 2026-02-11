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
  const keys = PhantasmaKeys.fromWIF(WIF_KEY);
  const creatorPk = new Bytes32(keys.PublicKey);
  const carbonTokenId = 108n;
  const carbonSeriesId = 1;

  // //Read the RAM data back from ramPayload
  // const reader = new CarbonBinaryReader(ramPayload);
  // const readRamStruct = new VmDynamicStruct();
  // readRamStruct.readWithSchema(ramSchema, reader);

  // console.log(
  //   "Read RAM struct - number of fields:",
  //   readRamStruct.fields.length,
  // );

  // // Extract and display each field
  // for (const field of readRamStruct.fields) {
  //   const fieldNameStr = String(field.name?.data ?? "");
  //   console.log(`Field name: ${fieldNameStr}`);

  //   if (fieldNameStr === "databrick") {
  //     // The value is now an array of strings
  //     console.log("Field value type:", typeof field.value);
  //     console.log("Field value:", field.value);

  //     const datbrickArray = field.value as unknown as string[];
  //     console.log("Datbrick array length:", datbrickArray?.length);
  //     console.log("Datbrick array:", datbrickArray);
  //   }
  // }

  //End of ram schema build
}

main().catch(console.error);
