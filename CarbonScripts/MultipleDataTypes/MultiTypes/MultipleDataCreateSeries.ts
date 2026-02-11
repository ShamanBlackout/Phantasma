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

import { WIF_KEY, RPC_URL, NEXUS } from "../../config.js";
async function main() {
  const keys = PhantasmaKeys.fromWIF(WIF_KEY);
  const creatorPk = new Bytes32(keys.PublicKey);
  const carbonTokenId = 108n; //replace with your carbon token id
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

  var seriesSchema = tokenSchemas.seriesMetadata;
  var metadata: MetadataField[] = [
    { name: "name", value: "Shaman Array String Test NFT" },
    { name: "description", value: "Shaman Array String Test NFT" },
    { name: "imageURL", value: "sometest.com" },
    { name: "infoURL", value: "sometest.com" },
    { name: "royalties", value: 10 },
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

  const rpc = new PhantasmaAPI(
    "https://testnet.phantasma.info/rpc",
    undefined as any,
    "testnet",
  );
  const txHash = await rpc.sendCarbonTransaction(txHex);

  await new Promise((resolve) => setTimeout(resolve, 3000));
  const txInfo = await rpc.getTransaction(txHash);
  const carbonSeriesId = CreateTokenSeriesTxHelper.parseResult(txInfo.result);
  console.log("Carbon series id:", carbonSeriesId);
}

main().catch(console.error);
