
// ********* getName Property ***********
@entry_getName: // 0
	ALIAS r1 $literalexpression139 // 1
	LOAD $literalexpression139 "Simple RAM NFT" // 1
	PUSH $literalexpression139 // 19
	JMP @exit_getName // 21
@exit_getName: // 24
RET // 25

// ********* getSymbol Property ***********
@entry_getSymbol: // 26
	ALIAS r1 $literalexpression143 // 27
	LOAD $literalexpression143 "SRT" // 27
	PUSH $literalexpression143 // 34
	JMP @exit_getSymbol // 36
@exit_getSymbol: // 39
RET // 40

// ********* isFungible Property ***********
@entry_isFungible: // 41
	ALIAS r1 $literalexpression147 // 42
	LOAD $literalexpression147 false // 42
	PUSH $literalexpression147 // 47
	JMP @exit_isFungible // 49
@exit_isFungible: // 52
RET // 53

// ********* isFinite Property ***********
@entry_isFinite: // 54
	ALIAS r1 $literalexpression151 // 55
	LOAD $literalexpression151 true // 55
	PUSH $literalexpression151 // 60
	JMP @exit_isFinite // 62
@exit_isFinite: // 65
RET // 66

// ********* isBurnable Property ***********
@entry_isBurnable: // 67
	ALIAS r1 $literalexpression155 // 68
	LOAD $literalexpression155 true // 68
	PUSH $literalexpression155 // 73
	JMP @exit_isBurnable // 75
@exit_isBurnable: // 78
RET // 79

// ********* getMaxSupply Property ***********
@entry_getMaxSupply: // 80
	ALIAS r1 $literalexpression159 // 81
	LOAD $literalexpression159 50 // 81
	PUSH $literalexpression159 // 86
	JMP @exit_getMaxSupply // 88
@exit_getMaxSupply: // 91
RET // 92

// ********* isTransferable Property ***********
@entry_isTransferable: // 93
	ALIAS r1 $literalexpression163 // 94
	LOAD $literalexpression163 true // 94
	PUSH $literalexpression163 // 99
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
// Line 70:        }
// Line 71:
// Line 72:    }

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
// clearing delegates storage
LOAD r0 "delegates" // 274
PUSH r0 // 287
LOAD r0 "Map.Clear" // 289
EXTCALL r0 // 302
// Line 73:
// Line 74:   constructor(owner:address){
ALIAS r2 $owner // 304
POP $owner // 304
PUSH $owner // 306
EXTCALL "Address()" // 308
POP $owner // 323
// Line 75:        _owner = owner;
	COPY $owner r3 // 325
	COPY r3 $_owner // 328
// Line 76:        NFT.createSeries(owner,$THIS_SYMBOL,0,4,TokenSeries.Unique,simp);//TokenSeries.Unique
	ALIAS r3 $methodcallexpression265 // 331
	LOAD r4 0x08076765744E616D6504000000000107746F6B656E4944030E6765744465736372697074696F6E04570000000107746F6B656E4944030A676574496E666F55524C04B50000000107746F6B656E4944030B676574496D61676555524C040F0100000107746F6B656E4944030A67657443726561746564056A010000000E676574576561706F6E5F6E616D6504C4010000000D6765744475726162696C6974790322020000000C676574456E6368616E746564037F0200000000 // abi // 331
	PUSH r4 // 520
	LOAD r4 0x0004010D000403524F4D030003010D00040353525403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D0204046E616D65300101020301085600000B0004010D000403524F4D030003010D00040353525403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D02040B6465736372697074696F6E30010102030108B400000B0004010D000403524F4D030003010D00040353525403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D020407696E666F55524C300101020301080E01000B0004010D000403524F4D030003010D00040353525403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D020408696D61676555524C300101020301086901000B0004010D000403524F4D030003010D00040353525403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D0204076372656174656430010102030108C301000B0004010D00040352414D030003010D00040353525403000D00041152756E74696D652E52656164546F6B656E070004023202020D00040352414D300203003203030203010D02040B776561706F6E5F6E616D65300101020301082102000B0004010D00040352414D030003010D00040353525403000D00041152756E74696D652E52656164546F6B656E070004023202020D00040352414D300203003203030203010D02040A6475726162696C697479300101020301087E02000B0004010D00040352414D030003010D00040353525403000D00041152756E74696D652E52656164546F6B656E070004023202020D00040352414D300203003203030203010D020409656E6368616E74656430010102030108DA02000B // script // 522
	PUSH r4 // 1259
	ALIAS r4 $literalexpression277 // 1261
	LOAD $literalexpression277 0 Enum // 1261
	PUSH $literalexpression277 // 1269
	ALIAS r4 $literalexpression276 // 1271
	LOAD $literalexpression276 4 // 1271
	PUSH $literalexpression276 // 1276
	ALIAS r4 $literalexpression275 // 1278
	LOAD $literalexpression275 0 // 1278
	PUSH $literalexpression275 // 1283
	ALIAS r4 $literalexpression274 // 1285
	LOAD $literalexpression274 "SRT" // 1285
	PUSH $literalexpression274 // 1292
	COPY $owner r4 // 1294
	PUSH r4 // 1297
	LOAD $methodcallexpression265 "Nexus.CreateTokenSeries" // 1299
	EXTCALL $methodcallexpression265 // 1326
@exit_constructor: // 1328
LOAD r2 "Data.Set" // 1329
// writing global: _owner
PUSH $_owner // 1341
LOAD r0 "_owner" // 1343
PUSH r0 // 1353
EXTCALL r2 // 1355
RET // 1357
// Line 77:    }

// ********* Mint Method ***********
@entry_Mint: // 1358
// Line 78:
// Line 79:    public Mint(from:address, to:address, seriesID:number){
ALIAS r1 $from // 1359
POP $from // 1359
PUSH $from // 1361
EXTCALL "Address()" // 1363
POP $from // 1378
ALIAS r2 $to // 1380
POP $to // 1380
PUSH $to // 1382
EXTCALL "Address()" // 1384
POP $to // 1399
ALIAS r3 $seriesID // 1401
POP $seriesID // 1401
CAST $seriesID $seriesID #Number // 1403
// Line 80:
// Line 81:        local imageURL: string = "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/3fc0f3d5-6138-4b4c-bf96-985d8010c8c2/d9rqlio-baa2d9c9-4e45-4a76-9d11-2f2787d97311.png/v1/fill/w_1192,h_670,q_70,strp/chillrend___cristalgide___fan_art_tes_by_etrelley_d9rqlio-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTA4MCIsInBhdGgiOiJcL2ZcLzNmYzBmM2Q1LTYxMzgtNGI0Yy1iZjk2LTk4NWQ4MDEwYzhjMlwvZDlycWxpby1iYWEyZDljOS00ZTQ1LTRhNzYtOWQxMS0yZjI3ODdkOTczMTEucG5nIiwid2lkdGgiOiI8PTE5MjAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.vQSAwi5ovYTnP_c-JrKx4uA2PDn5wjJzIE8R8c_Kr3s";
	ALIAS r4 $imageURL // 1407
	ALIAS r5 $literalexpression287 // 1407
	LOAD $literalexpression287 "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/3fc0f3d5-6138-4b4c-bf96-985d8010c8c2/d9rqlio-baa2d9c9-4e45-4a76-9d11-2f2787d97311.png/v1/fill/w_1192,h_670,q_70,strp/chillrend___cristalgide___fan_art_tes_by_etrelley_d9rqlio-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTA4MCIsInBhdGgiOiJcL2ZcLzNmYzBmM2Q1LTYxMzgtNGI0Yy1iZjk2LTk4NWQ4MDEwYzhjMlwvZDlycWxpby1iYWEyZDljOS00ZTQ1LTRhNzYtOWQxMS0yZjI3ODdkOTczMTEucG5nIiwid2lkdGgiOiI8PTE5MjAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.vQSAwi5ovYTnP_c-JrKx4uA2PDn5wjJzIE8R8c_Kr3s" // 1407
	COPY $literalexpression287 $imageURL // 2123
// Line 82:        local rom: simp_rom = Struct.simp_rom("Crystal Gazer","Formulated from the eye crystals of a dead angel","",imageURL,Time.now());
	ALIAS r5 $rom // 2126
	CLEAR r6 // 2126
	ALIAS r8 $literalexpression296 // 2128
	LOAD $literalexpression296 "Crystal Gazer" // 2128
	LOAD r7 "name" // 2145
	PUT $literalexpression296 r6 r7 // 2153
	ALIAS r8 $literalexpression297 // 2157
	LOAD $literalexpression297 "Formulated from the eye crystals of a dead angel" // 2157
	LOAD r7 "description" // 2209
	PUT $literalexpression297 r6 r7 // 2224
	ALIAS r8 $literalexpression298 // 2228
	LOAD $literalexpression298 "" // 2228
	LOAD r7 "infoURL" // 2232
	PUT $literalexpression298 r6 r7 // 2243
	COPY $imageURL r8 // 2247
	LOAD r7 "imageURL" // 2250
	PUT r8 r6 r7 // 2262
	ALIAS r8 $methodcallexpression300 // 2266
	LOAD $methodcallexpression300 "Runtime.Time" // 2266
	EXTCALL $methodcallexpression300 // 2282
	POP $methodcallexpression300 // 2284
	LOAD r7 "created" // 2286
	PUT $methodcallexpression300 r6 r7 // 2297
	COPY r6 $rom // 2301
// Line 83:        local ram: simp_ram = Struct.simp_ram("Crystal Gazer",5,1);
	ALIAS r6 $ram // 2304
	CLEAR r7 // 2304
	ALIAS r9 $literalexpression307 // 2306
	LOAD $literalexpression307 "Crystal Gazer" // 2306
	LOAD r8 "weapon_name" // 2323
	PUT $literalexpression307 r7 r8 // 2338
	ALIAS r9 $literalexpression308 // 2342
	LOAD $literalexpression308 5 // 2342
	LOAD r8 "durability" // 2347
	PUT $literalexpression308 r7 r8 // 2361
	ALIAS r9 $literalexpression309 // 2365
	LOAD $literalexpression309 1 // 2365
	LOAD r8 "enchanted" // 2370
	PUT $literalexpression309 r7 r8 // 2383
	COPY r7 $ram // 2387
// Line 84:        NFT.mint(from, to, $THIS_SYMBOL, rom, ram, seriesID);
	ALIAS r7 $methodcallexpression313 // 2390
	COPY $seriesID r8 // 2390
	PUSH r8 // 2393
	COPY $ram r8 // 2395
	CAST r8 r8 #Bytes // 2398
	PUSH r8 // 2402
	COPY $rom r8 // 2404
	CAST r8 r8 #Bytes // 2407
	PUSH r8 // 2411
	ALIAS r8 $literalexpression323 // 2413
	LOAD $literalexpression323 "SRT" // 2413
	PUSH $literalexpression323 // 2420
	COPY $to r8 // 2422
	PUSH r8 // 2425
	COPY $from r8 // 2427
	PUSH r8 // 2430
	LOAD $methodcallexpression313 "Runtime.MintToken" // 2432
	EXTCALL $methodcallexpression313 // 2453
	POP $methodcallexpression313 // 2455
@exit_Mint: // 2457
RET // 2458
// Line 85:    }

// ********* addDelegate Method ***********
@entry_addDelegate: // 2459
ALIAS r1 $dataGet // 2460
LOAD $dataGet "Data.Get" // 2460
ALIAS r2 $contractName // 2472
LOAD $contractName "SRT" // 2472
ALIAS r3 $_owner // 2479
// reading global: _owner
LOAD r0 8 // 2479
PUSH r0 // 2484
LOAD r0 "_owner" // 2486
PUSH r0 // 2496
PUSH $contractName // 2498
EXTCALL $dataGet // 2500
POP $_owner // 2502
PUSH $_owner // 2504
EXTCALL "Address()" // 2506
POP $_owner // 2521
// Line 86:
// Line 87:    public addDelegate(delegate:address){
ALIAS r1 $delegate // 2523
POP $delegate // 2523
PUSH $delegate // 2525
EXTCALL "Address()" // 2527
POP $delegate // 2542
// Line 88:        Runtime.expect(Runtime.isWitness(_owner),"Must be Owner to add Delegate");
	ALIAS r2 $methodcallexpression335 // 2544
	COPY $_owner r4 // 2544
	PUSH r4 // 2547
	LOAD $methodcallexpression335 "Runtime.IsWitness" // 2549
	EXTCALL $methodcallexpression335 // 2570
	POP $methodcallexpression335 // 2572
	JMPIF $methodcallexpression335 @expect_methodcallexpression332 // 2574
	ALIAS r4 $literalexpression338 // 2578
	LOAD $literalexpression338 "Must be Owner to add Delegate" // 2578
	THROW $literalexpression338 // 2611
	@expect_methodcallexpression332: NOP // 2614
// Line 89:        local delegate_str: string = delegate;
	ALIAS r2 $delegate_str // 2614
	COPY $delegate r4 // 2614
	COPY r4 $delegate_str // 2617
// Line 90:        Runtime.expect(!delegates.has(delegate),delegate_str + "User is already a delegate");
	LOAD r4 6 // field type // 2620
	PUSH r4 // 2625
	COPY $delegate r5 // 2627
	PUSH r5 // 2630
	ALIAS r5 $literalexpression362 // 2632
	LOAD $literalexpression362 "delegates" // 2632
	PUSH $literalexpression362 // 2645
	LOAD $literalexpression362 "SRT" // contract name // 2647
	PUSH $literalexpression362 // 2654
	LOAD r4 "Map.Has" // 2656
	EXTCALL r4 // 2667
	POP r4 // 2669
	NOT r4 r4 // 2671
	JMPIF r4 @expect_methodcallexpression343 // 2674
	COPY $delegate_str r5 // 2678
	ALIAS r6 $literalexpression366 // 2681
	LOAD $literalexpression366 "User is already a delegate" // 2681
	ADD r5 $literalexpression366 r7 // 2711
	THROW r7 // 2715
	@expect_methodcallexpression343: NOP // 2718
// Line 91:        delegates.set(delegate,1);
	ALIAS r4 $methodcallexpression369 // 2718
	ALIAS r5 $literalexpression377 // 2718
	LOAD $literalexpression377 1 // 2718
	PUSH $literalexpression377 // 2723
	COPY $delegate r5 // 2725
	PUSH r5 // 2728
	ALIAS r5 $literalexpression375 // 2730
	LOAD $literalexpression375 "delegates" // 2730
	PUSH $literalexpression375 // 2743
	LOAD $methodcallexpression369 "Map.Set" // 2745
	EXTCALL $methodcallexpression369 // 2756
@exit_addDelegate: // 2758
RET // 2759
// Line 92:    }

// ********* readRam Method ***********
@entry_readRam: // 2760
// Line 93:
// Line 94: 
// Line 95:    public readRam(nftID: number):simp_ram{
ALIAS r1 $nftID // 2761
POP $nftID // 2761
CAST $nftID $nftID #Number // 2763
// Line 96:        local ram :simp_ram = NFT.readRAM<simp_ram>($THIS_SYMBOL,nftID);
	ALIAS r2 $ram // 2767
	ALIAS r3 $methodcallexpression382 // 2767
	COPY $nftID r4 // 2767
	PUSH r4 // 2770
	ALIAS r4 $literalexpression386 // 2772
	LOAD $literalexpression386 "SRT" // 2772
	PUSH $literalexpression386 // 2779
	LOAD $methodcallexpression382 "Runtime.ReadTokenRAM" // 2781
	EXTCALL $methodcallexpression382 // 2805
	POP $methodcallexpression382 // 2807
	UNPACK $methodcallexpression382 $methodcallexpression382 // 2809
	COPY $methodcallexpression382 $ram // 2812
// Line 97:        return ram;
	COPY $ram r3 // 2815
	PUSH r3 // 2818
	JMP @exit_readRam // 2820
@exit_readRam: // 2823
RET // 2824
// Line 98:    }

// ********* updateDurability Method ***********
@entry_updateDurability: // 2825
// Line 99:    /****
// Line 100:    Usage: Write to an existing NFT
// Line 101:    @param nftID
// Line 102:    @param weapon_name
// Line 103:    @param durabiility 
// Line 104:    @param enchanted
// Line 105:    *****/
// Line 106:    public updateDurability(from:address, nftID:number,durability: number){
ALIAS r1 $from // 2826
POP $from // 2826
PUSH $from // 2828
EXTCALL "Address()" // 2830
POP $from // 2845
ALIAS r2 $nftID // 2847
POP $nftID // 2847
CAST $nftID $nftID #Number // 2849
ALIAS r3 $durability // 2853
POP $durability // 2853
CAST $durability $durability #Number // 2855
// Line 107:        local nftData: NFT = NFT.read($THIS_SYMBOL,nftID);
	ALIAS r4 $nftData // 2859
	LOAD r5 "chain,owner,creator,ROM,RAM,seriesID,mintID" // field list // 2859
	PUSH r5 // 2906
	COPY $nftID r6 // 2908
	PUSH r6 // 2911
	ALIAS r6 $literalexpression404 // 2913
	LOAD $literalexpression404 "SRT" // 2913
	PUSH $literalexpression404 // 2920
	LOAD r5 "Runtime.ReadToken" // 2922
	EXTCALL r5 // 2943
	POP r5 // 2945
	UNPACK r5 r5 // 2947
	COPY r5 $nftData // 2950
// Line 108:        local has_access :bool = false;
	ALIAS r5 $has_access // 2953
	ALIAS r6 $literalexpression408 // 2953
	LOAD $literalexpression408 false // 2953
	COPY $literalexpression408 $has_access // 2958
// Line 109:        if(Runtime.isWitness(nftData.owner)){
	ALIAS r6 $methodcallexpression412 // 2961
	COPY $nftData r7 // 2961
	LOAD r8 "owner" // 2964
	GET r7 r7 r8 // 2973
	PUSH r7 // 2977
	LOAD $methodcallexpression412 "Runtime.IsWitness" // 2979
	EXTCALL $methodcallexpression412 // 3000
	POP $methodcallexpression412 // 3002
		JMPNOT $methodcallexpression412 @else_ifstatement411 // 3004
// Line 110:            has_access = true;
		ALIAS r7 $literalexpression417 // 3008
		LOAD $literalexpression417 true // 3008
		COPY $literalexpression417 $has_access // 3013
		JMP @then_ifstatement411 // 3016
		@else_ifstatement411: NOP // 3020
// Line 111:        }
// Line 112:        else{
// Line 113:            if(delegates.has(from)){
		LOAD r7 6 // field type // 3020
		PUSH r7 // 3025
		COPY $from r8 // 3027
		PUSH r8 // 3030
		ALIAS r8 $literalexpression424 // 3032
		LOAD $literalexpression424 "delegates" // 3032
		PUSH $literalexpression424 // 3045
		LOAD $literalexpression424 "SRT" // contract name // 3047
		PUSH $literalexpression424 // 3054
		LOAD r7 "Map.Has" // 3056
		EXTCALL r7 // 3067
		POP r7 // 3069
			JMPNOT r7 @then_ifstatement419 // 3071
// Line 114:                if(Runtime.isWitness(from)){
			ALIAS r8 $methodcallexpression428 // 3075
			COPY $from r9 // 3075
			PUSH r9 // 3078
			LOAD $methodcallexpression428 "Runtime.IsWitness" // 3080
			EXTCALL $methodcallexpression428 // 3101
			POP $methodcallexpression428 // 3103
				JMPNOT $methodcallexpression428 @then_ifstatement427 // 3105
// Line 115:                    has_access = true;
				ALIAS r9 $literalexpression433 // 3109
				LOAD $literalexpression433 true // 3109
				COPY $literalexpression433 $has_access // 3114
				@then_ifstatement427: NOP // 3118
			@then_ifstatement419: NOP // 3119
		@then_ifstatement411: NOP // 3120
// Line 116:                }
// Line 117:            }
// Line 118:        }
// Line 119:        Runtime.expect(has_access,"Must be either owner or a delegate of Nft to make changes");
	COPY $has_access r6 // 3120
	JMPIF r6 @expect_methodcallexpression435 // 3123
	ALIAS r7 $literalexpression439 // 3127
	LOAD $literalexpression439 "Must be either owner or a delegate of Nft to make changes" // 3127
	THROW $literalexpression439 // 3188
	@expect_methodcallexpression435: NOP // 3191
// Line 120:        Runtime.expect(durability >= 0 && durability <=10, "Durability has to be between 0-10");
	COPY $durability r6 // 3191
	ALIAS r7 $literalexpression445 // 3194
	LOAD $literalexpression445 0 // 3194
	GTE r6 $literalexpression445 r8 // 3199
	COPY $durability r6 // 3203
	ALIAS r7 $literalexpression448 // 3206
	LOAD $literalexpression448 10 // 3206
	LTE r6 $literalexpression448 r9 // 3211
	AND r8 r9 r6 // 3215
	JMPIF r6 @expect_methodcallexpression441 // 3219
	ALIAS r7 $literalexpression451 // 3223
	LOAD $literalexpression451 "Durability has to be between 0-10" // 3223
	THROW $literalexpression451 // 3260
	@expect_methodcallexpression441: NOP // 3263
// Line 121:        local prev_ram: simp_ram = NFT.readRAM<simp_ram>($THIS_SYMBOL,nftID);
	ALIAS r6 $prev_ram // 3263
	ALIAS r7 $methodcallexpression452 // 3263
	COPY $nftID r8 // 3263
	PUSH r8 // 3266
	ALIAS r8 $literalexpression456 // 3268
	LOAD $literalexpression456 "SRT" // 3268
	PUSH $literalexpression456 // 3275
	LOAD $methodcallexpression452 "Runtime.ReadTokenRAM" // 3277
	EXTCALL $methodcallexpression452 // 3301
	POP $methodcallexpression452 // 3303
	UNPACK $methodcallexpression452 $methodcallexpression452 // 3305
	COPY $methodcallexpression452 $prev_ram // 3308
// Line 122:
// Line 123:        local new_ram: simp_ram = Struct.simp_ram(prev_ram.weapon_name,durability,prev_ram.enchanted);
	ALIAS r7 $new_ram // 3311
	CLEAR r8 // 3311
	COPY $prev_ram r10 // 3313
	LOAD r11 "weapon_name" // 3316
	GET r10 r10 r11 // 3331
	LOAD r9 "weapon_name" // 3335
	PUT r10 r8 r9 // 3350
	COPY $durability r10 // 3354
	LOAD r9 "durability" // 3357
	PUT r10 r8 r9 // 3371
	COPY $prev_ram r10 // 3375
	LOAD r11 "enchanted" // 3378
	GET r10 r10 r11 // 3391
	LOAD r9 "enchanted" // 3395
	PUT r10 r8 r9 // 3408
	COPY r8 $new_ram // 3412
// Line 124:        NFT.write(from,$THIS_SYMBOL,nftID,new_ram);
	ALIAS r8 $methodcallexpression470 // 3415
	COPY $new_ram r9 // 3415
	CAST r9 r9 #Bytes // 3418
	PUSH r9 // 3422
	COPY $nftID r9 // 3424
	PUSH r9 // 3427
	ALIAS r9 $literalexpression477 // 3429
	LOAD $literalexpression477 "SRT" // 3429
	PUSH $literalexpression477 // 3436
	COPY $from r9 // 3438
	PUSH r9 // 3441
	LOAD $methodcallexpression470 "Runtime.WriteToken" // 3443
	EXTCALL $methodcallexpression470 // 3465
@exit_updateDurability: // 3467
RET // 3468
// Line 125:
// Line 126:    }

// ********* onUpgrade Trigger ***********
@entry_onUpgrade: // 3469
ALIAS r1 $dataGet // 3470
LOAD $dataGet "Data.Get" // 3470
ALIAS r2 $contractName // 3482
LOAD $contractName "SRT" // 3482
ALIAS r3 $_owner // 3489
// reading global: _owner
LOAD r0 8 // 3489
PUSH r0 // 3494
LOAD r0 "_owner" // 3496
PUSH r0 // 3506
PUSH $contractName // 3508
EXTCALL $dataGet // 3510
POP $_owner // 3512
PUSH $_owner // 3514
EXTCALL "Address()" // 3516
POP $_owner // 3531
// Line 127:
// Line 128:    trigger onUpgrade(from:address){
ALIAS r1 $from // 3533
POP $from // 3533
PUSH $from // 3535
EXTCALL "Address()" // 3537
POP $from // 3552
// Line 129:        Runtime.expect(Runtime.isWitness(_owner),"Improper verification");
	ALIAS r2 $methodcallexpression488 // 3554
	COPY $_owner r4 // 3554
	PUSH r4 // 3557
	LOAD $methodcallexpression488 "Runtime.IsWitness" // 3559
	EXTCALL $methodcallexpression488 // 3580
	POP $methodcallexpression488 // 3582
	JMPIF $methodcallexpression488 @expect_methodcallexpression485 // 3584
	ALIAS r4 $literalexpression491 // 3588
	LOAD $literalexpression491 "Improper verification" // 3588
	THROW $literalexpression491 // 3613
	@expect_methodcallexpression485: NOP // 3616
@exit_onUpgrade: // 3616
RET // 3617
// Line 130:
// Line 131:    }

// ********* onKill Trigger ***********
@entry_onKill: // 3618
ALIAS r1 $dataGet // 3619
LOAD $dataGet "Data.Get" // 3619
ALIAS r2 $contractName // 3631
LOAD $contractName "SRT" // 3631
ALIAS r3 $_owner // 3638
// reading global: _owner
LOAD r0 8 // 3638
PUSH r0 // 3643
LOAD r0 "_owner" // 3645
PUSH r0 // 3655
PUSH $contractName // 3657
EXTCALL $dataGet // 3659
POP $_owner // 3661
PUSH $_owner // 3663
EXTCALL "Address()" // 3665
POP $_owner // 3680
// Line 132:
// Line 133:    trigger onKill(from:address){
ALIAS r1 $from // 3682
POP $from // 3682
PUSH $from // 3684
EXTCALL "Address()" // 3686
POP $from // 3701
// Line 134:         Runtime.expect(Runtime.isWitness(_owner),"Improper verification");
	ALIAS r2 $methodcallexpression500 // 3703
	COPY $_owner r4 // 3703
	PUSH r4 // 3706
	LOAD $methodcallexpression500 "Runtime.IsWitness" // 3708
	EXTCALL $methodcallexpression500 // 3729
	POP $methodcallexpression500 // 3731
	JMPIF $methodcallexpression500 @expect_methodcallexpression497 // 3733
	ALIAS r4 $literalexpression503 // 3737
	LOAD $literalexpression503 "Improper verification" // 3737
	THROW $literalexpression503 // 3762
	@expect_methodcallexpression497: NOP // 3765
@exit_onKill: // 3765
RET // 3766
// Line 135:
// Line 136:    }

// ********* onMint Trigger ***********
@entry_onMint: // 3767
// Line 137:    trigger onMint(from:address, to:address, symbol:string, tokenID:number) { 
ALIAS r1 $from // 3768
POP $from // 3768
PUSH $from // 3770
EXTCALL "Address()" // 3772
POP $from // 3787
ALIAS r2 $to // 3789
POP $to // 3789
PUSH $to // 3791
EXTCALL "Address()" // 3793
POP $to // 3808
ALIAS r3 $symbol // 3810
POP $symbol // 3810
ALIAS r4 $tokenID // 3812
POP $tokenID // 3812
CAST $tokenID $tokenID #Number // 3814
// Line 138:        Runtime.expect(Runtime.isWitness(from),"Improper verification");
	ALIAS r5 $methodcallexpression518 // 3818
	COPY $from r6 // 3818
	PUSH r6 // 3821
	LOAD $methodcallexpression518 "Runtime.IsWitness" // 3823
	EXTCALL $methodcallexpression518 // 3844
	POP $methodcallexpression518 // 3846
	JMPIF $methodcallexpression518 @expect_methodcallexpression515 // 3848
	ALIAS r6 $literalexpression521 // 3852
	LOAD $literalexpression521 "Improper verification" // 3852
	THROW $literalexpression521 // 3877
	@expect_methodcallexpression515: NOP // 3880
@exit_onMint: // 3880
RET // 3881
// Line 139:
// Line 140:    }

// ********* onSeries Trigger ***********
@entry_onSeries: // 3882
// Line 141:
// Line 142:    trigger onSeries(from:address){
ALIAS r1 $from // 3883
POP $from // 3883
PUSH $from // 3885
EXTCALL "Address()" // 3887
POP $from // 3902
@exit_onSeries: // 3904
RET // 3905
// Line 143:
// Line 144:    }

// ********* onBurn Trigger ***********
@entry_onBurn: // 3906
// Line 145:    trigger onBurn(from:address, to:address, symbol:string, tokenID:number){
ALIAS r1 $from // 3907
POP $from // 3907
PUSH $from // 3909
EXTCALL "Address()" // 3911
POP $from // 3926
ALIAS r2 $to // 3928
POP $to // 3928
PUSH $to // 3930
EXTCALL "Address()" // 3932
POP $to // 3947
ALIAS r3 $symbol // 3949
POP $symbol // 3949
ALIAS r4 $tokenID // 3951
POP $tokenID // 3951
CAST $tokenID $tokenID #Number // 3953
// Line 146:         Runtime.expect(Runtime.isWitness(from),"Improper verification");
	ALIAS r5 $methodcallexpression540 // 3957
	COPY $from r6 // 3957
	PUSH r6 // 3960
	LOAD $methodcallexpression540 "Runtime.IsWitness" // 3962
	EXTCALL $methodcallexpression540 // 3983
	POP $methodcallexpression540 // 3985
	JMPIF $methodcallexpression540 @expect_methodcallexpression537 // 3987
	ALIAS r6 $literalexpression543 // 3991
	LOAD $literalexpression543 "Improper verification" // 3991
	THROW $literalexpression543 // 4016
	@expect_methodcallexpression537: NOP // 4019
@exit_onBurn: // 4019
RET // 4020
