
// ********* getName Property ***********
@entry_getName: // 0
	ALIAS r1 $literalexpression119 // 1
	LOAD $literalexpression119 "Simple NFT" // 1
	PUSH $literalexpression119 // 15
	JMP @exit_getName // 17
@exit_getName: // 20
RET // 21

// ********* getSymbol Property ***********
@entry_getSymbol: // 22
	ALIAS r1 $literalexpression123 // 23
	LOAD $literalexpression123 "SNFT" // 23
	PUSH $literalexpression123 // 31
	JMP @exit_getSymbol // 33
@exit_getSymbol: // 36
RET // 37

// ********* isFungible Property ***********
@entry_isFungible: // 38
	ALIAS r1 $literalexpression127 // 39
	LOAD $literalexpression127 false // 39
	PUSH $literalexpression127 // 44
	JMP @exit_isFungible // 46
@exit_isFungible: // 49
RET // 50

// ********* isFinite Property ***********
@entry_isFinite: // 51
	ALIAS r1 $literalexpression131 // 52
	LOAD $literalexpression131 true // 52
	PUSH $literalexpression131 // 57
	JMP @exit_isFinite // 59
@exit_isFinite: // 62
RET // 63

// ********* isBurnable Property ***********
@entry_isBurnable: // 64
	ALIAS r1 $literalexpression135 // 65
	LOAD $literalexpression135 true // 65
	PUSH $literalexpression135 // 70
	JMP @exit_isBurnable // 72
@exit_isBurnable: // 75
RET // 76

// ********* getMaxSupply Property ***********
@entry_getMaxSupply: // 77
	ALIAS r1 $literalexpression139 // 78
	LOAD $literalexpression139 50 // 78
	PUSH $literalexpression139 // 83
	JMP @exit_getMaxSupply // 85
@exit_getMaxSupply: // 88
RET // 89

// ********* isTransferable Property ***********
@entry_isTransferable: // 90
	ALIAS r1 $literalexpression143 // 91
	LOAD $literalexpression143 true // 91
	PUSH $literalexpression143 // 96
	JMP @exit_isTransferable // 98
@exit_isTransferable: // 101
RET // 102

// ********* getOwner Property ***********
@entry_getOwner: // 103
ALIAS r1 $dataGet // 104
LOAD $dataGet "Data.Get" // 104
ALIAS r2 $contractName // 116
LOAD $contractName "SNFT" // 116
ALIAS r3 $_owner // 124
// reading global: _owner
LOAD r0 8 // 124
PUSH r0 // 129
LOAD r0 "_owner" // 131
PUSH r0 // 141
PUSH $contractName // 143
EXTCALL $dataGet // 145
POP $_owner // 147
PUSH $_owner // 149
EXTCALL "Address()" // 151
POP $_owner // 166
	COPY $_owner r1 // 168
	PUSH r1 // 171
	JMP @exit_getOwner // 173
@exit_getOwner: // 176
RET // 177
// Line 67:        }
// Line 68:
// Line 69:    }

// ********* Initialize Constructor ***********
@entry_constructor: // 178
ALIAS r1 $nexus_protocol_version // 179
// validate protocol version
LOAD r0 "Runtime.Version" // 179
EXTCALL r0 // 198
POP r0 // 200
LOAD $nexus_protocol_version 8 // 202
LT r0 $nexus_protocol_version r0 // 207
JMPNOT r0 @protocol_version_validated // 211
LOAD r0 "Current nexus protocol version should be 8 or more" // 215
THROW r0 // 269
@protocol_version_validated: NOP // 272
ALIAS r1 $_owner // 272
// Line 70:
// Line 71:   constructor(owner:address){
ALIAS r2 $owner // 272
POP $owner // 272
PUSH $owner // 274
EXTCALL "Address()" // 276
POP $owner // 291
// Line 72:        _owner = owner;
	COPY $owner r3 // 293
	COPY r3 $_owner // 296
// Line 73:        NFT.createSeries(owner,$THIS_SYMBOL,0,4,TokenSeries.Unique,simp);//TokenSeries.Unique
	ALIAS r3 $methodcallexpression245 // 299
	LOAD r4 0x08076765744E616D6504000000000107746F6B656E4944030E6765744465736372697074696F6E04580000000107746F6B656E4944030A676574496E666F55524C04B70000000107746F6B656E4944030B676574496D61676555524C04120100000107746F6B656E4944030A67657443726561746564056E010000000E676574576561706F6E5F6E616D6504C9010000000D6765744475726162696C6974790328020000000C676574456E6368616E74656403860200000000 // abi // 299
	PUSH r4 // 488
	LOAD r4 0x0004010D000403524F4D030003010D000404534E465403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D0204046E616D65300101020301085700000B0004010D000403524F4D030003010D000404534E465403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D02040B6465736372697074696F6E30010102030108B600000B0004010D000403524F4D030003010D000404534E465403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D020407696E666F55524C300101020301081101000B0004010D000403524F4D030003010D000404534E465403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D020408696D61676555524C300101020301086D01000B0004010D000403524F4D030003010D000404534E465403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D0204076372656174656430010102030108C801000B0004010D00040352414D030003010D000404534E465403000D00041152756E74696D652E52656164546F6B656E070004023202020D00040352414D300203003203030203010D02040B776561706F6E5F6E616D65300101020301082702000B0004010D00040352414D030003010D000404534E465403000D00041152756E74696D652E52656164546F6B656E070004023202020D00040352414D300203003203030203010D02040A6475726162696C697479300101020301088502000B0004010D00040352414D030003010D000404534E465403000D00041152756E74696D652E52656164546F6B656E070004023202020D00040352414D300203003203030203010D020409656E6368616E74656430010102030108E202000B // script // 490
	PUSH r4 // 1235
	ALIAS r4 $literalexpression257 // 1237
	LOAD $literalexpression257 0 Enum // 1237
	PUSH $literalexpression257 // 1245
	ALIAS r4 $literalexpression256 // 1247
	LOAD $literalexpression256 4 // 1247
	PUSH $literalexpression256 // 1252
	ALIAS r4 $literalexpression255 // 1254
	LOAD $literalexpression255 0 // 1254
	PUSH $literalexpression255 // 1259
	ALIAS r4 $literalexpression254 // 1261
	LOAD $literalexpression254 "SNFT" // 1261
	PUSH $literalexpression254 // 1269
	COPY $owner r4 // 1271
	PUSH r4 // 1274
	LOAD $methodcallexpression245 "Nexus.CreateTokenSeries" // 1276
	EXTCALL $methodcallexpression245 // 1303
@exit_constructor: // 1305
LOAD r2 "Data.Set" // 1306
// writing global: _owner
PUSH $_owner // 1318
LOAD r0 "_owner" // 1320
PUSH r0 // 1330
EXTCALL r2 // 1332
RET // 1334
// Line 74:    }

// ********* Mint Method ***********
@entry_Mint: // 1335
// Line 75:
// Line 76:    public Mint(from:address, to:address, seriesID:number){
ALIAS r1 $from // 1336
POP $from // 1336
PUSH $from // 1338
EXTCALL "Address()" // 1340
POP $from // 1355
ALIAS r2 $to // 1357
POP $to // 1357
PUSH $to // 1359
EXTCALL "Address()" // 1361
POP $to // 1376
ALIAS r3 $seriesID // 1378
POP $seriesID // 1378
CAST $seriesID $seriesID #Number // 1380
// Line 77:
// Line 78:        local imageURL: string = "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/3fc0f3d5-6138-4b4c-bf96-985d8010c8c2/d9rqlio-baa2d9c9-4e45-4a76-9d11-2f2787d97311.png/v1/fill/w_1192,h_670,q_70,strp/chillrend___cristalgide___fan_art_tes_by_etrelley_d9rqlio-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTA4MCIsInBhdGgiOiJcL2ZcLzNmYzBmM2Q1LTYxMzgtNGI0Yy1iZjk2LTk4NWQ4MDEwYzhjMlwvZDlycWxpby1iYWEyZDljOS00ZTQ1LTRhNzYtOWQxMS0yZjI3ODdkOTczMTEucG5nIiwid2lkdGgiOiI8PTE5MjAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.vQSAwi5ovYTnP_c-JrKx4uA2PDn5wjJzIE8R8c_Kr3s";
	ALIAS r4 $imageURL // 1384
	ALIAS r5 $literalexpression267 // 1384
	LOAD $literalexpression267 "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/3fc0f3d5-6138-4b4c-bf96-985d8010c8c2/d9rqlio-baa2d9c9-4e45-4a76-9d11-2f2787d97311.png/v1/fill/w_1192,h_670,q_70,strp/chillrend___cristalgide___fan_art_tes_by_etrelley_d9rqlio-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTA4MCIsInBhdGgiOiJcL2ZcLzNmYzBmM2Q1LTYxMzgtNGI0Yy1iZjk2LTk4NWQ4MDEwYzhjMlwvZDlycWxpby1iYWEyZDljOS00ZTQ1LTRhNzYtOWQxMS0yZjI3ODdkOTczMTEucG5nIiwid2lkdGgiOiI8PTE5MjAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.vQSAwi5ovYTnP_c-JrKx4uA2PDn5wjJzIE8R8c_Kr3s" // 1384
	COPY $literalexpression267 $imageURL // 2100
// Line 79:        local rom: simp_rom = Struct.simp_rom("Crystal Gazer","Formulated from the eye crystals of a dead angel","",imageURL,Time.now());
	ALIAS r5 $rom // 2103
	CLEAR r6 // 2103
	ALIAS r8 $literalexpression276 // 2105
	LOAD $literalexpression276 "Crystal Gazer" // 2105
	LOAD r7 "name" // 2122
	PUT $literalexpression276 r6 r7 // 2130
	ALIAS r8 $literalexpression277 // 2134
	LOAD $literalexpression277 "Formulated from the eye crystals of a dead angel" // 2134
	LOAD r7 "description" // 2186
	PUT $literalexpression277 r6 r7 // 2201
	ALIAS r8 $literalexpression278 // 2205
	LOAD $literalexpression278 "" // 2205
	LOAD r7 "infoURL" // 2209
	PUT $literalexpression278 r6 r7 // 2220
	COPY $imageURL r8 // 2224
	LOAD r7 "imageURL" // 2227
	PUT r8 r6 r7 // 2239
	ALIAS r8 $methodcallexpression280 // 2243
	LOAD $methodcallexpression280 "Runtime.Time" // 2243
	EXTCALL $methodcallexpression280 // 2259
	POP $methodcallexpression280 // 2261
	LOAD r7 "created" // 2263
	PUT $methodcallexpression280 r6 r7 // 2274
	COPY r6 $rom // 2278
// Line 80:        local ram: simp_ram = Struct.simp_ram("Crystal Gazer",5,1);
	ALIAS r6 $ram // 2281
	CLEAR r7 // 2281
	ALIAS r9 $literalexpression287 // 2283
	LOAD $literalexpression287 "Crystal Gazer" // 2283
	LOAD r8 "weapon_name" // 2300
	PUT $literalexpression287 r7 r8 // 2315
	ALIAS r9 $literalexpression288 // 2319
	LOAD $literalexpression288 5 // 2319
	LOAD r8 "durability" // 2324
	PUT $literalexpression288 r7 r8 // 2338
	ALIAS r9 $literalexpression289 // 2342
	LOAD $literalexpression289 1 // 2342
	LOAD r8 "enchanted" // 2347
	PUT $literalexpression289 r7 r8 // 2360
	COPY r7 $ram // 2364
// Line 81:        NFT.mint(from, to, $THIS_SYMBOL, rom, ram, seriesID);
	ALIAS r7 $methodcallexpression293 // 2367
	COPY $seriesID r8 // 2367
	PUSH r8 // 2370
	COPY $ram r8 // 2372
	CAST r8 r8 #Bytes // 2375
	PUSH r8 // 2379
	COPY $rom r8 // 2381
	CAST r8 r8 #Bytes // 2384
	PUSH r8 // 2388
	ALIAS r8 $literalexpression303 // 2390
	LOAD $literalexpression303 "SNFT" // 2390
	PUSH $literalexpression303 // 2398
	COPY $to r8 // 2400
	PUSH r8 // 2403
	COPY $from r8 // 2405
	PUSH r8 // 2408
	LOAD $methodcallexpression293 "Runtime.MintToken" // 2410
	EXTCALL $methodcallexpression293 // 2431
	POP $methodcallexpression293 // 2433
@exit_Mint: // 2435
RET // 2436
// Line 82:    }

// ********* readRam Method ***********
@entry_readRam: // 2437
// Line 83:
// Line 84: 
// Line 85:    public readRam(nftID: number):simp_ram{
ALIAS r1 $nftID // 2438
POP $nftID // 2438
CAST $nftID $nftID #Number // 2440
// Line 86:        local ram :simp_ram = NFT.readRAM<simp_ram>($THIS_SYMBOL,nftID);
	ALIAS r2 $ram // 2444
	ALIAS r3 $methodcallexpression311 // 2444
	COPY $nftID r4 // 2444
	PUSH r4 // 2447
	ALIAS r4 $literalexpression315 // 2449
	LOAD $literalexpression315 "SNFT" // 2449
	PUSH $literalexpression315 // 2457
	LOAD $methodcallexpression311 "Runtime.ReadTokenRAM" // 2459
	EXTCALL $methodcallexpression311 // 2483
	POP $methodcallexpression311 // 2485
	UNPACK $methodcallexpression311 $methodcallexpression311 // 2487
	COPY $methodcallexpression311 $ram // 2490
// Line 87:        return ram;
	COPY $ram r3 // 2493
	PUSH r3 // 2496
	JMP @exit_readRam // 2498
@exit_readRam: // 2501
RET // 2502
// Line 88:    }

// ********* updateDurability Method ***********
@entry_updateDurability: // 2503
// Line 89:    /****
// Line 90:    Usage: Write to an existing NFT
// Line 91:    @param nftID
// Line 92:    @param weapon_name
// Line 93:    @param durabiility 
// Line 94:    @param enchanted
// Line 95:    *****/
// Line 96:    public updateDurability(from:address, nftID:number,durability: number){
ALIAS r1 $from // 2504
POP $from // 2504
PUSH $from // 2506
EXTCALL "Address()" // 2508
POP $from // 2523
ALIAS r2 $nftID // 2525
POP $nftID // 2525
CAST $nftID $nftID #Number // 2527
ALIAS r3 $durability // 2531
POP $durability // 2531
CAST $durability $durability #Number // 2533
// Line 97:        local nftData: NFT = NFT.read($THIS_SYMBOL,nftID);
	ALIAS r4 $nftData // 2537
	LOAD r5 "chain,owner,creator,ROM,RAM,seriesID,mintID" // field list // 2537
	PUSH r5 // 2584
	COPY $nftID r6 // 2586
	PUSH r6 // 2589
	ALIAS r6 $literalexpression333 // 2591
	LOAD $literalexpression333 "SNFT" // 2591
	PUSH $literalexpression333 // 2599
	LOAD r5 "Runtime.ReadToken" // 2601
	EXTCALL r5 // 2622
	POP r5 // 2624
	UNPACK r5 r5 // 2626
	COPY r5 $nftData // 2629
// Line 98:        Runtime.expect(Runtime.isWitness(nftData.owner),"Must be owner of Nft to make changes");
	ALIAS r5 $methodcallexpression341 // 2632
	COPY $nftData r6 // 2632
	LOAD r7 "owner" // 2635
	GET r6 r6 r7 // 2644
	PUSH r6 // 2648
	LOAD $methodcallexpression341 "Runtime.IsWitness" // 2650
	EXTCALL $methodcallexpression341 // 2671
	POP $methodcallexpression341 // 2673
	JMPIF $methodcallexpression341 @expect_methodcallexpression338 // 2675
	ALIAS r6 $literalexpression344 // 2679
	LOAD $literalexpression344 "Must be owner of Nft to make changes" // 2679
	THROW $literalexpression344 // 2719
	@expect_methodcallexpression338: NOP // 2722
// Line 99:        Runtime.expect(durability >= 0 && durability <=10, "Durability has to be between 0-10");
	COPY $durability r5 // 2722
	ALIAS r6 $literalexpression350 // 2725
	LOAD $literalexpression350 0 // 2725
	GTE r5 $literalexpression350 r7 // 2730
	COPY $durability r5 // 2734
	ALIAS r6 $literalexpression353 // 2737
	LOAD $literalexpression353 10 // 2737
	LTE r5 $literalexpression353 r8 // 2742
	AND r7 r8 r5 // 2746
	JMPIF r5 @expect_methodcallexpression346 // 2750
	ALIAS r6 $literalexpression356 // 2754
	LOAD $literalexpression356 "Durability has to be between 0-10" // 2754
	THROW $literalexpression356 // 2791
	@expect_methodcallexpression346: NOP // 2794
// Line 100:        local prev_ram: simp_ram = NFT.readRAM<simp_ram>($THIS_SYMBOL,nftID);
	ALIAS r5 $prev_ram // 2794
	ALIAS r6 $methodcallexpression357 // 2794
	COPY $nftID r7 // 2794
	PUSH r7 // 2797
	ALIAS r7 $literalexpression361 // 2799
	LOAD $literalexpression361 "SNFT" // 2799
	PUSH $literalexpression361 // 2807
	LOAD $methodcallexpression357 "Runtime.ReadTokenRAM" // 2809
	EXTCALL $methodcallexpression357 // 2833
	POP $methodcallexpression357 // 2835
	UNPACK $methodcallexpression357 $methodcallexpression357 // 2837
	COPY $methodcallexpression357 $prev_ram // 2840
// Line 101:
// Line 102:        local new_ram: simp_ram = Struct.simp_ram(prev_ram.weapon_name,durability,prev_ram.enchanted);
	ALIAS r6 $new_ram // 2843
	CLEAR r7 // 2843
	COPY $prev_ram r9 // 2845
	LOAD r10 "weapon_name" // 2848
	GET r9 r9 r10 // 2863
	LOAD r8 "weapon_name" // 2867
	PUT r9 r7 r8 // 2882
	COPY $durability r9 // 2886
	LOAD r8 "durability" // 2889
	PUT r9 r7 r8 // 2903
	COPY $prev_ram r9 // 2907
	LOAD r10 "enchanted" // 2910
	GET r9 r9 r10 // 2923
	LOAD r8 "enchanted" // 2927
	PUT r9 r7 r8 // 2940
	COPY r7 $new_ram // 2944
// Line 103:        NFT.write(from,$THIS_SYMBOL,nftID,new_ram);
	ALIAS r7 $methodcallexpression375 // 2947
	COPY $new_ram r8 // 2947
	CAST r8 r8 #Bytes // 2950
	PUSH r8 // 2954
	COPY $nftID r8 // 2956
	PUSH r8 // 2959
	ALIAS r8 $literalexpression382 // 2961
	LOAD $literalexpression382 "SNFT" // 2961
	PUSH $literalexpression382 // 2969
	COPY $from r8 // 2971
	PUSH r8 // 2974
	LOAD $methodcallexpression375 "Runtime.WriteToken" // 2976
	EXTCALL $methodcallexpression375 // 2998
@exit_updateDurability: // 3000
RET // 3001
// Line 104:
// Line 105:    }

// ********* onUpgrade Trigger ***********
@entry_onUpgrade: // 3002
ALIAS r1 $dataGet // 3003
LOAD $dataGet "Data.Get" // 3003
ALIAS r2 $contractName // 3015
LOAD $contractName "SNFT" // 3015
ALIAS r3 $_owner // 3023
// reading global: _owner
LOAD r0 8 // 3023
PUSH r0 // 3028
LOAD r0 "_owner" // 3030
PUSH r0 // 3040
PUSH $contractName // 3042
EXTCALL $dataGet // 3044
POP $_owner // 3046
PUSH $_owner // 3048
EXTCALL "Address()" // 3050
POP $_owner // 3065
// Line 106:
// Line 107:    trigger onUpgrade(from:address){
ALIAS r1 $from // 3067
POP $from // 3067
PUSH $from // 3069
EXTCALL "Address()" // 3071
POP $from // 3086
// Line 108:        Runtime.expect(Runtime.isWitness(_owner),"Improper verification");
	ALIAS r2 $methodcallexpression393 // 3088
	COPY $_owner r4 // 3088
	PUSH r4 // 3091
	LOAD $methodcallexpression393 "Runtime.IsWitness" // 3093
	EXTCALL $methodcallexpression393 // 3114
	POP $methodcallexpression393 // 3116
	JMPIF $methodcallexpression393 @expect_methodcallexpression390 // 3118
	ALIAS r4 $literalexpression396 // 3122
	LOAD $literalexpression396 "Improper verification" // 3122
	THROW $literalexpression396 // 3147
	@expect_methodcallexpression390: NOP // 3150
@exit_onUpgrade: // 3150
RET // 3151
// Line 109:
// Line 110:    }

// ********* onKill Trigger ***********
@entry_onKill: // 3152
ALIAS r1 $dataGet // 3153
LOAD $dataGet "Data.Get" // 3153
ALIAS r2 $contractName // 3165
LOAD $contractName "SNFT" // 3165
ALIAS r3 $_owner // 3173
// reading global: _owner
LOAD r0 8 // 3173
PUSH r0 // 3178
LOAD r0 "_owner" // 3180
PUSH r0 // 3190
PUSH $contractName // 3192
EXTCALL $dataGet // 3194
POP $_owner // 3196
PUSH $_owner // 3198
EXTCALL "Address()" // 3200
POP $_owner // 3215
// Line 111:
// Line 112:    trigger onKill(from:address){
ALIAS r1 $from // 3217
POP $from // 3217
PUSH $from // 3219
EXTCALL "Address()" // 3221
POP $from // 3236
// Line 113:         Runtime.expect(Runtime.isWitness(_owner),"Improper verification");
	ALIAS r2 $methodcallexpression405 // 3238
	COPY $_owner r4 // 3238
	PUSH r4 // 3241
	LOAD $methodcallexpression405 "Runtime.IsWitness" // 3243
	EXTCALL $methodcallexpression405 // 3264
	POP $methodcallexpression405 // 3266
	JMPIF $methodcallexpression405 @expect_methodcallexpression402 // 3268
	ALIAS r4 $literalexpression408 // 3272
	LOAD $literalexpression408 "Improper verification" // 3272
	THROW $literalexpression408 // 3297
	@expect_methodcallexpression402: NOP // 3300
@exit_onKill: // 3300
RET // 3301
// Line 114:
// Line 115:    }

// ********* onMint Trigger ***********
@entry_onMint: // 3302
// Line 116:    trigger onMint(from:address, to:address, symbol:string, tokenID:number) { 
ALIAS r1 $from // 3303
POP $from // 3303
PUSH $from // 3305
EXTCALL "Address()" // 3307
POP $from // 3322
ALIAS r2 $to // 3324
POP $to // 3324
PUSH $to // 3326
EXTCALL "Address()" // 3328
POP $to // 3343
ALIAS r3 $symbol // 3345
POP $symbol // 3345
ALIAS r4 $tokenID // 3347
POP $tokenID // 3347
CAST $tokenID $tokenID #Number // 3349
// Line 117:        Runtime.expect(Runtime.isWitness(from),"Improper verification");
	ALIAS r5 $methodcallexpression423 // 3353
	COPY $from r6 // 3353
	PUSH r6 // 3356
	LOAD $methodcallexpression423 "Runtime.IsWitness" // 3358
	EXTCALL $methodcallexpression423 // 3379
	POP $methodcallexpression423 // 3381
	JMPIF $methodcallexpression423 @expect_methodcallexpression420 // 3383
	ALIAS r6 $literalexpression426 // 3387
	LOAD $literalexpression426 "Improper verification" // 3387
	THROW $literalexpression426 // 3412
	@expect_methodcallexpression420: NOP // 3415
@exit_onMint: // 3415
RET // 3416
// Line 118:
// Line 119:    }

// ********* onSeries Trigger ***********
@entry_onSeries: // 3417
// Line 120:
// Line 121:    trigger onSeries(from:address){
ALIAS r1 $from // 3418
POP $from // 3418
PUSH $from // 3420
EXTCALL "Address()" // 3422
POP $from // 3437
@exit_onSeries: // 3439
RET // 3440
// Line 122:
// Line 123:    }

// ********* onBurn Trigger ***********
@entry_onBurn: // 3441
// Line 124:    trigger onBurn(from:address, to:address, symbol:string, tokenID:number){
ALIAS r1 $from // 3442
POP $from // 3442
PUSH $from // 3444
EXTCALL "Address()" // 3446
POP $from // 3461
ALIAS r2 $to // 3463
POP $to // 3463
PUSH $to // 3465
EXTCALL "Address()" // 3467
POP $to // 3482
ALIAS r3 $symbol // 3484
POP $symbol // 3484
ALIAS r4 $tokenID // 3486
POP $tokenID // 3486
CAST $tokenID $tokenID #Number // 3488
// Line 125:         Runtime.expect(Runtime.isWitness(from),"Improper verification");
	ALIAS r5 $methodcallexpression445 // 3492
	COPY $from r6 // 3492
	PUSH r6 // 3495
	LOAD $methodcallexpression445 "Runtime.IsWitness" // 3497
	EXTCALL $methodcallexpression445 // 3518
	POP $methodcallexpression445 // 3520
	JMPIF $methodcallexpression445 @expect_methodcallexpression442 // 3522
	ALIAS r6 $literalexpression448 // 3526
	LOAD $literalexpression448 "Improper verification" // 3526
	THROW $literalexpression448 // 3551
	@expect_methodcallexpression442: NOP // 3554
@exit_onBurn: // 3554
RET // 3555
