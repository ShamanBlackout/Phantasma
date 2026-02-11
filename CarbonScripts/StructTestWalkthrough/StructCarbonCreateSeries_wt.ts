import {
  Bytes32,
  CreateSeriesFeeOptions,
  CreateTokenSeriesTxHelper,
  MetadataField,
  PhantasmaAPI,
  PhantasmaKeys,
  SeriesInfoBuilder,
  TokenSchemasBuilder,
  getRandomPhantasmaId,
} from "phantasma-sdk-ts";
import { WIF_KEY, RPC_URL, NEXUS } from "../config";

async function main() {
  const keys = PhantasmaKeys.fromWIF(WIF_KEY);
  const creatorPk = new Bytes32(keys.PublicKey);

  const carbonTokenId = 159n; // BigInt(CreateTokenTxHelper.parseResult(...))

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

  const seriesSchema = tokenSchemas.seriesMetadata;

  const metadata: MetadataField[] = [
    { name: "name", value: "My Struct Series" },
    { name: "description", value: "Struct Series description" },
    { name: "imageURL", value: "https://example.com/cover.png" },
    { name: "infoURL", value: "https://example.com/info" },
    { name: "royalties", value: 10000000 },
  ];

  const phantasmaSeriesId = await getRandomPhantasmaId();
  const seriesInfo = SeriesInfoBuilder.build(
    seriesSchema,
    phantasmaSeriesId,
    0,
    0,
    creatorPk,
    metadata,
  );

  const feeOptions = new CreateSeriesFeeOptions();
  const maxData = 100_000_000n;

  const txHex = CreateTokenSeriesTxHelper.buildTxAndSignHex(
    carbonTokenId,
    seriesInfo,
    keys,
    feeOptions,
    maxData,
  );

  const rpc = new PhantasmaAPI(RPC_URL, undefined as any, NEXUS);
  const txHash = await rpc.sendCarbonTransaction(txHex);

  await new Promise((resolve) => setTimeout(resolve, 2000));
  const txInfo = await rpc.getTransaction(txHash);
  const carbonSeriesId = CreateTokenSeriesTxHelper.parseResult(txInfo.result);
  console.log("Carbon series id:", carbonSeriesId);
}

main().catch(console.error);
