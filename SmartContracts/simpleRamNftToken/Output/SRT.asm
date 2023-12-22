
// ********* getName Property ***********
@entry_getName: // 0
	ALIAS r1 $literalexpression119 // 1
	LOAD $literalexpression119 "Simple RAM NFT" // 1
	PUSH $literalexpression119 // 19
	JMP @exit_getName // 21
@exit_getName: // 24
RET // 25

// ********* getSymbol Property ***********
@entry_getSymbol: // 26
	ALIAS r1 $literalexpression123 // 27
	LOAD $literalexpression123 "SRT" // 27
	PUSH $literalexpression123 // 34
	JMP @exit_getSymbol // 36
@exit_getSymbol: // 39
RET // 40

// ********* isFungible Property ***********
@entry_isFungible: // 41
	ALIAS r1 $literalexpression127 // 42
	LOAD $literalexpression127 false // 42
	PUSH $literalexpression127 // 47
	JMP @exit_isFungible // 49
@exit_isFungible: // 52
RET // 53

// ********* isFinite Property ***********
@entry_isFinite: // 54
	ALIAS r1 $literalexpression131 // 55
	LOAD $literalexpression131 true // 55
	PUSH $literalexpression131 // 60
	JMP @exit_isFinite // 62
@exit_isFinite: // 65
RET // 66

// ********* isBurnable Property ***********
@entry_isBurnable: // 67
	ALIAS r1 $literalexpression135 // 68
	LOAD $literalexpression135 true // 68
	PUSH $literalexpression135 // 73
	JMP @exit_isBurnable // 75
@exit_isBurnable: // 78
RET // 79

// ********* getMaxSupply Property ***********
@entry_getMaxSupply: // 80
	ALIAS r1 $literalexpression139 // 81
	LOAD $literalexpression139 50 // 81
	PUSH $literalexpression139 // 86
	JMP @exit_getMaxSupply // 88
@exit_getMaxSupply: // 91
RET // 92

// ********* isTransferable Property ***********
@entry_isTransferable: // 93
	ALIAS r1 $literalexpression143 // 94
	LOAD $literalexpression143 true // 94
	PUSH $literalexpression143 // 99
	JMP @exit_isTransferable // 101
@exit_isTransferable: // 104
RET // 105

// ********* getOwner Property ***********
@entry_getOwner: // 106
ALIAS r1 $dataGet // 107
LOAD $dataGet "Data.Get" // 107
ALIAS r2 $contractName // 119
LOAD $contractName "SRT" // 119
ALIAS r3 $_owner // 126
// reading global: _owner
LOAD r0 8 // 126
PUSH r0 // 131
LOAD r0 "_owner" // 133
PUSH r0 // 143
PUSH $contractName // 145
EXTCALL $dataGet // 147
POP $_owner // 149
PUSH $_owner // 151
EXTCALL "Address()" // 153
POP $_owner // 168
	COPY $_owner r1 // 170
	PUSH r1 // 173
	JMP @exit_getOwner // 175
@exit_getOwner: // 178
RET // 179
// Line 67:        }
// Line 68:
// Line 69:    }

// ********* Initialize Constructor ***********
@entry_constructor: // 180
ALIAS r1 $nexus_protocol_version // 181
// validate protocol version
LOAD r0 "Runtime.Version" // 181
EXTCALL r0 // 200
POP r0 // 202
LOAD $nexus_protocol_version 8 // 204
LT r0 $nexus_protocol_version r0 // 209
JMPNOT r0 @protocol_version_validated // 213
LOAD r0 "Current nexus protocol version should be 8 or more" // 217
THROW r0 // 271
@protocol_version_validated: NOP // 274
ALIAS r1 $_owner // 274
// Line 70:
// Line 71:   constructor(owner:address){
ALIAS r2 $owner // 274
POP $owner // 274
PUSH $owner // 276
EXTCALL "Address()" // 278
POP $owner // 293
// Line 72:        _owner = owner;
	COPY $owner r3 // 295
	COPY r3 $_owner // 298
// Line 73:        NFT.createSeries(owner,$THIS_SYMBOL,0,4,TokenSeries.Unique,simp);//TokenSeries.Unique
	ALIAS r3 $methodcallexpression245 // 301
	LOAD r4 0x08076765744E616D6504000000000107746F6B656E4944030E6765744465736372697074696F6E04570000000107746F6B656E4944030A676574496E666F55524C04B50000000107746F6B656E4944030B676574496D61676555524C040F0100000107746F6B656E4944030A67657443726561746564056A010000000E676574576561706F6E5F6E616D6504C4010000000D6765744475726162696C6974790322020000000C676574456E6368616E746564037F0200000000 // abi // 301
	PUSH r4 // 490
	LOAD r4 0x0004010D000403524F4D030003010D00040353525403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D0204046E616D65300101020301085600000B0004010D000403524F4D030003010D00040353525403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D02040B6465736372697074696F6E30010102030108B400000B0004010D000403524F4D030003010D00040353525403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D020407696E666F55524C300101020301080E01000B0004010D000403524F4D030003010D00040353525403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D020408696D61676555524C300101020301086901000B0004010D000403524F4D030003010D00040353525403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D0204076372656174656430010102030108C301000B0004010D00040352414D030003010D00040353525403000D00041152756E74696D652E52656164546F6B656E070004023202020D00040352414D300203003203030203010D02040B776561706F6E5F6E616D65300101020301082102000B0004010D00040352414D030003010D00040353525403000D00041152756E74696D652E52656164546F6B656E070004023202020D00040352414D300203003203030203010D02040A6475726162696C697479300101020301087E02000B0004010D00040352414D030003010D00040353525403000D00041152756E74696D652E52656164546F6B656E070004023202020D00040352414D300203003203030203010D020409656E6368616E74656430010102030108DA02000B // script // 492
	PUSH r4 // 1229
	ALIAS r4 $literalexpression257 // 1231
	LOAD $literalexpression257 0 Enum // 1231
	PUSH $literalexpression257 // 1239
	ALIAS r4 $literalexpression256 // 1241
	LOAD $literalexpression256 4 // 1241
	PUSH $literalexpression256 // 1246
	ALIAS r4 $literalexpression255 // 1248
	LOAD $literalexpression255 0 // 1248
	PUSH $literalexpression255 // 1253
	ALIAS r4 $literalexpression254 // 1255
	LOAD $literalexpression254 "SRT" // 1255
	PUSH $literalexpression254 // 1262
	COPY $owner r4 // 1264
	PUSH r4 // 1267
	LOAD $methodcallexpression245 "Nexus.CreateTokenSeries" // 1269
	EXTCALL $methodcallexpression245 // 1296
@exit_constructor: // 1298
LOAD r2 "Data.Set" // 1299
// writing global: _owner
PUSH $_owner // 1311
LOAD r0 "_owner" // 1313
PUSH r0 // 1323
EXTCALL r2 // 1325
RET // 1327
// Line 74:    }

// ********* Mint Method ***********
@entry_Mint: // 1328
// Line 75:
// Line 76:    public Mint(from:address, to:address, seriesID:number){
ALIAS r1 $from // 1329
POP $from // 1329
PUSH $from // 1331
EXTCALL "Address()" // 1333
POP $from // 1348
ALIAS r2 $to // 1350
POP $to // 1350
PUSH $to // 1352
EXTCALL "Address()" // 1354
POP $to // 1369
ALIAS r3 $seriesID // 1371
POP $seriesID // 1371
CAST $seriesID $seriesID #Number // 1373
// Line 77:
// Line 78:        local imageURL: string = "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/3fc0f3d5-6138-4b4c-bf96-985d8010c8c2/d9rqlio-baa2d9c9-4e45-4a76-9d11-2f2787d97311.png/v1/fill/w_1192,h_670,q_70,strp/chillrend___cristalgide___fan_art_tes_by_etrelley_d9rqlio-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTA4MCIsInBhdGgiOiJcL2ZcLzNmYzBmM2Q1LTYxMzgtNGI0Yy1iZjk2LTk4NWQ4MDEwYzhjMlwvZDlycWxpby1iYWEyZDljOS00ZTQ1LTRhNzYtOWQxMS0yZjI3ODdkOTczMTEucG5nIiwid2lkdGgiOiI8PTE5MjAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.vQSAwi5ovYTnP_c-JrKx4uA2PDn5wjJzIE8R8c_Kr3s";
	ALIAS r4 $imageURL // 1377
	ALIAS r5 $literalexpression267 // 1377
	LOAD $literalexpression267 "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/3fc0f3d5-6138-4b4c-bf96-985d8010c8c2/d9rqlio-baa2d9c9-4e45-4a76-9d11-2f2787d97311.png/v1/fill/w_1192,h_670,q_70,strp/chillrend___cristalgide___fan_art_tes_by_etrelley_d9rqlio-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTA4MCIsInBhdGgiOiJcL2ZcLzNmYzBmM2Q1LTYxMzgtNGI0Yy1iZjk2LTk4NWQ4MDEwYzhjMlwvZDlycWxpby1iYWEyZDljOS00ZTQ1LTRhNzYtOWQxMS0yZjI3ODdkOTczMTEucG5nIiwid2lkdGgiOiI8PTE5MjAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.vQSAwi5ovYTnP_c-JrKx4uA2PDn5wjJzIE8R8c_Kr3s" // 1377
	COPY $literalexpression267 $imageURL // 2093
// Line 79:        local rom: simp_rom = Struct.simp_rom("Crystal Gazer","Formulated from the eye crystals of a dead angel","",imageURL,Time.now());
	ALIAS r5 $rom // 2096
	CLEAR r6 // 2096
	ALIAS r8 $literalexpression276 // 2098
	LOAD $literalexpression276 "Crystal Gazer" // 2098
	LOAD r7 "name" // 2115
	PUT $literalexpression276 r6 r7 // 2123
	ALIAS r8 $literalexpression277 // 2127
	LOAD $literalexpression277 "Formulated from the eye crystals of a dead angel" // 2127
	LOAD r7 "description" // 2179
	PUT $literalexpression277 r6 r7 // 2194
	ALIAS r8 $literalexpression278 // 2198
	LOAD $literalexpression278 "" // 2198
	LOAD r7 "infoURL" // 2202
	PUT $literalexpression278 r6 r7 // 2213
	COPY $imageURL r8 // 2217
	LOAD r7 "imageURL" // 2220
	PUT r8 r6 r7 // 2232
	ALIAS r8 $methodcallexpression280 // 2236
	LOAD $methodcallexpression280 "Runtime.Time" // 2236
	EXTCALL $methodcallexpression280 // 2252
	POP $methodcallexpression280 // 2254
	LOAD r7 "created" // 2256
	PUT $methodcallexpression280 r6 r7 // 2267
	COPY r6 $rom // 2271
// Line 80:        local ram: simp_ram = Struct.simp_ram("Crystal Gazer",5,1);
	ALIAS r6 $ram // 2274
	CLEAR r7 // 2274
	ALIAS r9 $literalexpression287 // 2276
	LOAD $literalexpression287 "Crystal Gazer" // 2276
	LOAD r8 "weapon_name" // 2293
	PUT $literalexpression287 r7 r8 // 2308
	ALIAS r9 $literalexpression288 // 2312
	LOAD $literalexpression288 5 // 2312
	LOAD r8 "durability" // 2317
	PUT $literalexpression288 r7 r8 // 2331
	ALIAS r9 $literalexpression289 // 2335
	LOAD $literalexpression289 1 // 2335
	LOAD r8 "enchanted" // 2340
	PUT $literalexpression289 r7 r8 // 2353
	COPY r7 $ram // 2357
// Line 81:        NFT.mint(from, to, $THIS_SYMBOL, rom, ram, seriesID);
	ALIAS r7 $methodcallexpression293 // 2360
	COPY $seriesID r8 // 2360
	PUSH r8 // 2363
	COPY $ram r8 // 2365
	CAST r8 r8 #Bytes // 2368
	PUSH r8 // 2372
	COPY $rom r8 // 2374
	CAST r8 r8 #Bytes // 2377
	PUSH r8 // 2381
	ALIAS r8 $literalexpression303 // 2383
	LOAD $literalexpression303 "SRT" // 2383
	PUSH $literalexpression303 // 2390
	COPY $to r8 // 2392
	PUSH r8 // 2395
	COPY $from r8 // 2397
	PUSH r8 // 2400
	LOAD $methodcallexpression293 "Runtime.MintToken" // 2402
	EXTCALL $methodcallexpression293 // 2423
	POP $methodcallexpression293 // 2425
@exit_Mint: // 2427
RET // 2428
// Line 82:    }

// ********* readRam Method ***********
@entry_readRam: // 2429
// Line 83:
// Line 84: 
// Line 85:    public readRam(nftID: number):simp_ram{
ALIAS r1 $nftID // 2430
POP $nftID // 2430
CAST $nftID $nftID #Number // 2432
// Line 86:        local ram :simp_ram = NFT.readRAM<simp_ram>($THIS_SYMBOL,nftID);
	ALIAS r2 $ram // 2436
	ALIAS r3 $methodcallexpression311 // 2436
	COPY $nftID r4 // 2436
	PUSH r4 // 2439
	ALIAS r4 $literalexpression315 // 2441
	LOAD $literalexpression315 "SRT" // 2441
	PUSH $literalexpression315 // 2448
	LOAD $methodcallexpression311 "Runtime.ReadTokenRAM" // 2450
	EXTCALL $methodcallexpression311 // 2474
	POP $methodcallexpression311 // 2476
	UNPACK $methodcallexpression311 $methodcallexpression311 // 2478
	COPY $methodcallexpression311 $ram // 2481
// Line 87:        return ram;
	COPY $ram r3 // 2484
	PUSH r3 // 2487
	JMP @exit_readRam // 2489
@exit_readRam: // 2492
RET // 2493
// Line 88:    }

// ********* updateDurability Method ***********
@entry_updateDurability: // 2494
// Line 89:    /****
// Line 90:    Usage: Write to an existing NFT
// Line 91:    @param nftID
// Line 92:    @param weapon_name
// Line 93:    @param durabiility 
// Line 94:    @param enchanted
// Line 95:    *****/
// Line 96:    public updateDurability(from:address, nftID:number,durability: number){
ALIAS r1 $from // 2495
POP $from // 2495
PUSH $from // 2497
EXTCALL "Address()" // 2499
POP $from // 2514
ALIAS r2 $nftID // 2516
POP $nftID // 2516
CAST $nftID $nftID #Number // 2518
ALIAS r3 $durability // 2522
POP $durability // 2522
CAST $durability $durability #Number // 2524
// Line 97:        local nftData: NFT = NFT.read($THIS_SYMBOL,nftID);
	ALIAS r4 $nftData // 2528
	LOAD r5 "chain,owner,creator,ROM,RAM,seriesID,mintID" // field list // 2528
	PUSH r5 // 2575
	COPY $nftID r6 // 2577
	PUSH r6 // 2580
	ALIAS r6 $literalexpression333 // 2582
	LOAD $literalexpression333 "SRT" // 2582
	PUSH $literalexpression333 // 2589
	LOAD r5 "Runtime.ReadToken" // 2591
	EXTCALL r5 // 2612
	POP r5 // 2614
	UNPACK r5 r5 // 2616
	COPY r5 $nftData // 2619
// Line 98:        Runtime.expect(Runtime.isWitness(nftData.owner),"Must be owner of Nft to make changes");
	ALIAS r5 $methodcallexpression341 // 2622
	COPY $nftData r6 // 2622
	LOAD r7 "owner" // 2625
	GET r6 r6 r7 // 2634
	PUSH r6 // 2638
	LOAD $methodcallexpression341 "Runtime.IsWitness" // 2640
	EXTCALL $methodcallexpression341 // 2661
	POP $methodcallexpression341 // 2663
	JMPIF $methodcallexpression341 @expect_methodcallexpression338 // 2665
	ALIAS r6 $literalexpression344 // 2669
	LOAD $literalexpression344 "Must be owner of Nft to make changes" // 2669
	THROW $literalexpression344 // 2709
	@expect_methodcallexpression338: NOP // 2712
// Line 99:        Runtime.expect(durability >= 0 && durability <=10, "Durability has to be between 0-10");
	COPY $durability r5 // 2712
	ALIAS r6 $literalexpression350 // 2715
	LOAD $literalexpression350 0 // 2715
	GTE r5 $literalexpression350 r7 // 2720
	COPY $durability r5 // 2724
	ALIAS r6 $literalexpression353 // 2727
	LOAD $literalexpression353 10 // 2727
	LTE r5 $literalexpression353 r8 // 2732
	AND r7 r8 r5 // 2736
	JMPIF r5 @expect_methodcallexpression346 // 2740
	ALIAS r6 $literalexpression356 // 2744
	LOAD $literalexpression356 "Durability has to be between 0-10" // 2744
	THROW $literalexpression356 // 2781
	@expect_methodcallexpression346: NOP // 2784
// Line 100:        local prev_ram: simp_ram = NFT.readRAM<simp_ram>($THIS_SYMBOL,nftID);
	ALIAS r5 $prev_ram // 2784
	ALIAS r6 $methodcallexpression357 // 2784
	COPY $nftID r7 // 2784
	PUSH r7 // 2787
	ALIAS r7 $literalexpression361 // 2789
	LOAD $literalexpression361 "SRT" // 2789
	PUSH $literalexpression361 // 2796
	LOAD $methodcallexpression357 "Runtime.ReadTokenRAM" // 2798
	EXTCALL $methodcallexpression357 // 2822
	POP $methodcallexpression357 // 2824
	UNPACK $methodcallexpression357 $methodcallexpression357 // 2826
	COPY $methodcallexpression357 $prev_ram // 2829
// Line 101:
// Line 102:        local new_ram: simp_ram = Struct.simp_ram(prev_ram.weapon_name,durability,prev_ram.enchanted);
	ALIAS r6 $new_ram // 2832
	CLEAR r7 // 2832
	COPY $prev_ram r9 // 2834
	LOAD r10 "weapon_name" // 2837
	GET r9 r9 r10 // 2852
	LOAD r8 "weapon_name" // 2856
	PUT r9 r7 r8 // 2871
	COPY $durability r9 // 2875
	LOAD r8 "durability" // 2878
	PUT r9 r7 r8 // 2892
	COPY $prev_ram r9 // 2896
	LOAD r10 "enchanted" // 2899
	GET r9 r9 r10 // 2912
	LOAD r8 "enchanted" // 2916
	PUT r9 r7 r8 // 2929
	COPY r7 $new_ram // 2933
// Line 103:        NFT.write(from,$THIS_SYMBOL,nftID,new_ram);
	ALIAS r7 $methodcallexpression375 // 2936
	COPY $new_ram r8 // 2936
	CAST r8 r8 #Bytes // 2939
	PUSH r8 // 2943
	COPY $nftID r8 // 2945
	PUSH r8 // 2948
	ALIAS r8 $literalexpression382 // 2950
	LOAD $literalexpression382 "SRT" // 2950
	PUSH $literalexpression382 // 2957
	COPY $from r8 // 2959
	PUSH r8 // 2962
	LOAD $methodcallexpression375 "Runtime.WriteToken" // 2964
	EXTCALL $methodcallexpression375 // 2986
@exit_updateDurability: // 2988
RET // 2989
// Line 104:
// Line 105:    }

// ********* onUpgrade Trigger ***********
@entry_onUpgrade: // 2990
ALIAS r1 $dataGet // 2991
LOAD $dataGet "Data.Get" // 2991
ALIAS r2 $contractName // 3003
LOAD $contractName "SRT" // 3003
ALIAS r3 $_owner // 3010
// reading global: _owner
LOAD r0 8 // 3010
PUSH r0 // 3015
LOAD r0 "_owner" // 3017
PUSH r0 // 3027
PUSH $contractName // 3029
EXTCALL $dataGet // 3031
POP $_owner // 3033
PUSH $_owner // 3035
EXTCALL "Address()" // 3037
POP $_owner // 3052
// Line 106:
// Line 107:    trigger onUpgrade(from:address){
ALIAS r1 $from // 3054
POP $from // 3054
PUSH $from // 3056
EXTCALL "Address()" // 3058
POP $from // 3073
// Line 108:        Runtime.expect(Runtime.isWitness(_owner),"Improper verification");
	ALIAS r2 $methodcallexpression393 // 3075
	COPY $_owner r4 // 3075
	PUSH r4 // 3078
	LOAD $methodcallexpression393 "Runtime.IsWitness" // 3080
	EXTCALL $methodcallexpression393 // 3101
	POP $methodcallexpression393 // 3103
	JMPIF $methodcallexpression393 @expect_methodcallexpression390 // 3105
	ALIAS r4 $literalexpression396 // 3109
	LOAD $literalexpression396 "Improper verification" // 3109
	THROW $literalexpression396 // 3134
	@expect_methodcallexpression390: NOP // 3137
@exit_onUpgrade: // 3137
RET // 3138
// Line 109:
// Line 110:    }

// ********* onKill Trigger ***********
@entry_onKill: // 3139
ALIAS r1 $dataGet // 3140
LOAD $dataGet "Data.Get" // 3140
ALIAS r2 $contractName // 3152
LOAD $contractName "SRT" // 3152
ALIAS r3 $_owner // 3159
// reading global: _owner
LOAD r0 8 // 3159
PUSH r0 // 3164
LOAD r0 "_owner" // 3166
PUSH r0 // 3176
PUSH $contractName // 3178
EXTCALL $dataGet // 3180
POP $_owner // 3182
PUSH $_owner // 3184
EXTCALL "Address()" // 3186
POP $_owner // 3201
// Line 111:
// Line 112:    trigger onKill(from:address){
ALIAS r1 $from // 3203
POP $from // 3203
PUSH $from // 3205
EXTCALL "Address()" // 3207
POP $from // 3222
// Line 113:         Runtime.expect(Runtime.isWitness(_owner),"Improper verification");
	ALIAS r2 $methodcallexpression405 // 3224
	COPY $_owner r4 // 3224
	PUSH r4 // 3227
	LOAD $methodcallexpression405 "Runtime.IsWitness" // 3229
	EXTCALL $methodcallexpression405 // 3250
	POP $methodcallexpression405 // 3252
	JMPIF $methodcallexpression405 @expect_methodcallexpression402 // 3254
	ALIAS r4 $literalexpression408 // 3258
	LOAD $literalexpression408 "Improper verification" // 3258
	THROW $literalexpression408 // 3283
	@expect_methodcallexpression402: NOP // 3286
@exit_onKill: // 3286
RET // 3287
// Line 114:
// Line 115:    }

// ********* onMint Trigger ***********
@entry_onMint: // 3288
// Line 116:    trigger onMint(from:address, to:address, symbol:string, tokenID:number) { 
ALIAS r1 $from // 3289
POP $from // 3289
PUSH $from // 3291
EXTCALL "Address()" // 3293
POP $from // 3308
ALIAS r2 $to // 3310
POP $to // 3310
PUSH $to // 3312
EXTCALL "Address()" // 3314
POP $to // 3329
ALIAS r3 $symbol // 3331
POP $symbol // 3331
ALIAS r4 $tokenID // 3333
POP $tokenID // 3333
CAST $tokenID $tokenID #Number // 3335
// Line 117:        Runtime.expect(Runtime.isWitness(from),"Improper verification");
	ALIAS r5 $methodcallexpression423 // 3339
	COPY $from r6 // 3339
	PUSH r6 // 3342
	LOAD $methodcallexpression423 "Runtime.IsWitness" // 3344
	EXTCALL $methodcallexpression423 // 3365
	POP $methodcallexpression423 // 3367
	JMPIF $methodcallexpression423 @expect_methodcallexpression420 // 3369
	ALIAS r6 $literalexpression426 // 3373
	LOAD $literalexpression426 "Improper verification" // 3373
	THROW $literalexpression426 // 3398
	@expect_methodcallexpression420: NOP // 3401
@exit_onMint: // 3401
RET // 3402
// Line 118:
// Line 119:    }

// ********* onSeries Trigger ***********
@entry_onSeries: // 3403
// Line 120:
// Line 121:    trigger onSeries(from:address){
ALIAS r1 $from // 3404
POP $from // 3404
PUSH $from // 3406
EXTCALL "Address()" // 3408
POP $from // 3423
@exit_onSeries: // 3425
RET // 3426
// Line 122:
// Line 123:    }

// ********* onBurn Trigger ***********
@entry_onBurn: // 3427
// Line 124:    trigger onBurn(from:address, to:address, symbol:string, tokenID:number){
ALIAS r1 $from // 3428
POP $from // 3428
PUSH $from // 3430
EXTCALL "Address()" // 3432
POP $from // 3447
ALIAS r2 $to // 3449
POP $to // 3449
PUSH $to // 3451
EXTCALL "Address()" // 3453
POP $to // 3468
ALIAS r3 $symbol // 3470
POP $symbol // 3470
ALIAS r4 $tokenID // 3472
POP $tokenID // 3472
CAST $tokenID $tokenID #Number // 3474
// Line 125:         Runtime.expect(Runtime.isWitness(from),"Improper verification");
	ALIAS r5 $methodcallexpression445 // 3478
	COPY $from r6 // 3478
	PUSH r6 // 3481
	LOAD $methodcallexpression445 "Runtime.IsWitness" // 3483
	EXTCALL $methodcallexpression445 // 3504
	POP $methodcallexpression445 // 3506
	JMPIF $methodcallexpression445 @expect_methodcallexpression442 // 3508
	ALIAS r6 $literalexpression448 // 3512
	LOAD $literalexpression448 "Improper verification" // 3512
	THROW $literalexpression448 // 3537
	@expect_methodcallexpression442: NOP // 3540
@exit_onBurn: // 3540
RET // 3541
