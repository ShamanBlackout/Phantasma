import {
  Bytes32,
  MintNftFeeOptions,
  MintNonFungibleTxHelper,
  MetadataField,
  NftRomBuilder,
  PhantasmaAPI,
  PhantasmaKeys,
  TokenSchemasBuilder,
  getRandomPhantasmaId,
  VmStructSchema,
  VmNamedVariableSchema,
  VmType,
  VmVariableSchema,
  VmDynamicStruct,
  pushMetadataField,
  CarbonBinaryWriter,
} from "phantasma-sdk-ts";
import { WIF_KEY, RPC_URL, NEXUS } from "../config";

async function main() {
  const keys = PhantasmaKeys.fromWIF(WIF_KEY);
  const creatorPk = new Bytes32(keys.PublicKey);

  const carbonTokenId = 159n; // BigInt(CreateTokenTxHelper.parseResult(...))
  const carbonSeriesId = 1; // CreateTokenSeriesTxHelper.parseResult(...)

  var tokenJSON = {
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
  const tokenSchemas = TokenSchemasBuilder.fromJson(JSON.stringify(tokenJSON));
  const romSchema = tokenSchemas.rom; // use the schema from your token

  var ramSchema = new VmStructSchema();

  var nestedSchema = new VmStructSchema([
    new VmNamedVariableSchema("person_name", VmType.String),
    new VmNamedVariableSchema("person_age", VmType.Int8),
  ]);

  var structSchema = new VmVariableSchema(VmType.Struct, nestedSchema);
  ramSchema.fields.push(new VmNamedVariableSchema("Person", structSchema));

  tokenSchemas.ram = ramSchema;

  let ramDataStruct = new VmDynamicStruct();
  let ramDataNestedStruct = new VmStructSchema([
    new VmNamedVariableSchema("person_name", VmType.String),
    new VmNamedVariableSchema("person_age", VmType.Int8),
  ]);

  let ramStructSchema = new VmNamedVariableSchema(
    "Person",
    new VmVariableSchema(VmType.Struct, ramDataNestedStruct),
  );

  var ramMetadata: MetadataField[] = [
    {
      name: "Person",
      value: {
        person_name: "Alice",
        person_age: 30,
      },
    },
  ];

  pushMetadataField(ramStructSchema, ramDataStruct, ramMetadata);
  let ramWriter = new CarbonBinaryWriter();
  ramDataStruct.write(ramWriter);
  let ramBytes = ramWriter.toUint8Array();

  // Include only fields defined in romSchema (plus optional "rom" bytes).
  const metadata: MetadataField[] = [
    { name: "name", value: "NFT #1" },
    { name: "description", value: "Example mint" },
    { name: "imageURL", value: "https://example.com/nft.png" },
    { name: "infoURL", value: "https://example.com/nft" },
    { name: "royalties", value: 10000000 },
  ];

  const phantasmaNftId = await getRandomPhantasmaId();
  const rom = NftRomBuilder.buildAndSerialize(
    romSchema,
    phantasmaNftId,
    metadata,
  );

  const feeOptions = new MintNftFeeOptions();
  const maxData = 100_000_000n;

  const txHex = MintNonFungibleTxHelper.buildTxAndSignHex(
    carbonTokenId,
    carbonSeriesId,
    keys,
    creatorPk,
    rom,
    ramBytes,
    feeOptions,
    maxData,
  );

  const rpc = new PhantasmaAPI(RPC_URL, undefined as any, NEXUS);
  const txHash = await rpc.sendCarbonTransaction(txHex);

  await new Promise((resolve) => setTimeout(resolve, 3000));
  const txInfo = await rpc.getTransaction(txHash);
  const carbonNftAddresses = MintNonFungibleTxHelper.parseResult(
    carbonTokenId,
    txInfo.result,
  );
  console.log(carbonNftAddresses[0].ToHex());
}

main().catch(console.error);
