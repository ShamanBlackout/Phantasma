
// ********* getName Property ***********
@entry_getName: // 0
	ALIAS r1 $literalexpression139 // 1
	LOAD $literalexpression139 "Simple Delegate NFT" // 1
	PUSH $literalexpression139 // 24
	JMP @exit_getName // 26
@exit_getName: // 29
RET // 30

// ********* getSymbol Property ***********
@entry_getSymbol: // 31
	ALIAS r1 $literalexpression143 // 32
	LOAD $literalexpression143 "SDT" // 32
	PUSH $literalexpression143 // 39
	JMP @exit_getSymbol // 41
@exit_getSymbol: // 44
RET // 45

// ********* isFungible Property ***********
@entry_isFungible: // 46
	ALIAS r1 $literalexpression147 // 47
	LOAD $literalexpression147 false // 47
	PUSH $literalexpression147 // 52
	JMP @exit_isFungible // 54
@exit_isFungible: // 57
RET // 58

// ********* isFinite Property ***********
@entry_isFinite: // 59
	ALIAS r1 $literalexpression151 // 60
	LOAD $literalexpression151 true // 60
	PUSH $literalexpression151 // 65
	JMP @exit_isFinite // 67
@exit_isFinite: // 70
RET // 71

// ********* isBurnable Property ***********
@entry_isBurnable: // 72
	ALIAS r1 $literalexpression155 // 73
	LOAD $literalexpression155 true // 73
	PUSH $literalexpression155 // 78
	JMP @exit_isBurnable // 80
@exit_isBurnable: // 83
RET // 84

// ********* getMaxSupply Property ***********
@entry_getMaxSupply: // 85
	ALIAS r1 $literalexpression159 // 86
	LOAD $literalexpression159 50 // 86
	PUSH $literalexpression159 // 91
	JMP @exit_getMaxSupply // 93
@exit_getMaxSupply: // 96
RET // 97

// ********* isTransferable Property ***********
@entry_isTransferable: // 98
	ALIAS r1 $literalexpression163 // 99
	LOAD $literalexpression163 true // 99
	PUSH $literalexpression163 // 104
	JMP @exit_isTransferable // 106
@exit_isTransferable: // 109
RET // 110

// ********* getOwner Property ***********
@entry_getOwner: // 111
ALIAS r1 $dataGet // 112
LOAD $dataGet "Data.Get" // 112
ALIAS r2 $contractName // 124
LOAD $contractName "SDT" // 124
ALIAS r3 $_owner // 131
// reading global: _owner
LOAD r0 8 // 131
PUSH r0 // 136
LOAD r0 "_owner" // 138
PUSH r0 // 148
PUSH $contractName // 150
EXTCALL $dataGet // 152
POP $_owner // 154
PUSH $_owner // 156
EXTCALL "Address()" // 158
POP $_owner // 173
	COPY $_owner r1 // 175
	PUSH r1 // 178
	JMP @exit_getOwner // 180
@exit_getOwner: // 183
RET // 184
// Line 70:        }
// Line 71:
// Line 72:    }

// ********* Initialize Constructor ***********
@entry_constructor: // 185
ALIAS r1 $nexus_protocol_version // 186
// validate protocol version
LOAD r0 "Runtime.Version" // 186
EXTCALL r0 // 205
POP r0 // 207
LOAD $nexus_protocol_version 8 // 209
LT r0 $nexus_protocol_version r0 // 214
JMPNOT r0 @protocol_version_validated // 218
LOAD r0 "Current nexus protocol version should be 8 or more" // 222
THROW r0 // 276
@protocol_version_validated: NOP // 279
ALIAS r1 $_owner // 279
// clearing delegates storage
LOAD r0 "delegates" // 279
PUSH r0 // 292
LOAD r0 "Map.Clear" // 294
EXTCALL r0 // 307
// Line 73:
// Line 74:   constructor(owner:address){
ALIAS r2 $owner // 309
POP $owner // 309
PUSH $owner // 311
EXTCALL "Address()" // 313
POP $owner // 328
// Line 75:        _owner = owner;
	COPY $owner r3 // 330
	COPY r3 $_owner // 333
// Line 76:        NFT.createSeries(owner,$THIS_SYMBOL,0,4,TokenSeries.Unique,simp);//TokenSeries.Unique
	ALIAS r3 $methodcallexpression265 // 336
	LOAD r4 0x08076765744E616D6504000000000107746F6B656E4944030E6765744465736372697074696F6E04570000000107746F6B656E4944030A676574496E666F55524C04B50000000107746F6B656E4944030B676574496D61676555524C040F0100000107746F6B656E4944030A67657443726561746564056A010000000E676574576561706F6E5F6E616D6504C4010000000D6765744475726162696C6974790322020000000C676574456E6368616E746564037F0200000000 // abi // 336
	PUSH r4 // 525
	LOAD r4 0x0004010D000403524F4D030003010D00040353445403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D0204046E616D65300101020301085600000B0004010D000403524F4D030003010D00040353445403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D02040B6465736372697074696F6E30010102030108B400000B0004010D000403524F4D030003010D00040353445403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D020407696E666F55524C300101020301080E01000B0004010D000403524F4D030003010D00040353445403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D020408696D61676555524C300101020301086901000B0004010D000403524F4D030003010D00040353445403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D0204076372656174656430010102030108C301000B0004010D00040352414D030003010D00040353445403000D00041152756E74696D652E52656164546F6B656E070004023202020D00040352414D300203003203030203010D02040B776561706F6E5F6E616D65300101020301082102000B0004010D00040352414D030003010D00040353445403000D00041152756E74696D652E52656164546F6B656E070004023202020D00040352414D300203003203030203010D02040A6475726162696C697479300101020301087E02000B0004010D00040352414D030003010D00040353445403000D00041152756E74696D652E52656164546F6B656E070004023202020D00040352414D300203003203030203010D020409656E6368616E74656430010102030108DA02000B // script // 527
	PUSH r4 // 1264
	ALIAS r4 $literalexpression277 // 1266
	LOAD $literalexpression277 0 Enum // 1266
	PUSH $literalexpression277 // 1274
	ALIAS r4 $literalexpression276 // 1276
	LOAD $literalexpression276 4 // 1276
	PUSH $literalexpression276 // 1281
	ALIAS r4 $literalexpression275 // 1283
	LOAD $literalexpression275 0 // 1283
	PUSH $literalexpression275 // 1288
	ALIAS r4 $literalexpression274 // 1290
	LOAD $literalexpression274 "SDT" // 1290
	PUSH $literalexpression274 // 1297
	COPY $owner r4 // 1299
	PUSH r4 // 1302
	LOAD $methodcallexpression265 "Nexus.CreateTokenSeries" // 1304
	EXTCALL $methodcallexpression265 // 1331
@exit_constructor: // 1333
LOAD r2 "Data.Set" // 1334
// writing global: _owner
PUSH $_owner // 1346
LOAD r0 "_owner" // 1348
PUSH r0 // 1358
EXTCALL r2 // 1360
RET // 1362
// Line 77:    }

// ********* Mint Method ***********
@entry_Mint: // 1363
// Line 78:
// Line 79:    public Mint(from:address, to:address, seriesID:number){
ALIAS r1 $from // 1364
POP $from // 1364
PUSH $from // 1366
EXTCALL "Address()" // 1368
POP $from // 1383
ALIAS r2 $to // 1385
POP $to // 1385
PUSH $to // 1387
EXTCALL "Address()" // 1389
POP $to // 1404
ALIAS r3 $seriesID // 1406
POP $seriesID // 1406
CAST $seriesID $seriesID #Number // 1408
// Line 80:
// Line 81:        local imageURL: string = "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/3fc0f3d5-6138-4b4c-bf96-985d8010c8c2/d9rqlio-baa2d9c9-4e45-4a76-9d11-2f2787d97311.png/v1/fill/w_1192,h_670,q_70,strp/chillrend___cristalgide___fan_art_tes_by_etrelley_d9rqlio-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTA4MCIsInBhdGgiOiJcL2ZcLzNmYzBmM2Q1LTYxMzgtNGI0Yy1iZjk2LTk4NWQ4MDEwYzhjMlwvZDlycWxpby1iYWEyZDljOS00ZTQ1LTRhNzYtOWQxMS0yZjI3ODdkOTczMTEucG5nIiwid2lkdGgiOiI8PTE5MjAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.vQSAwi5ovYTnP_c-JrKx4uA2PDn5wjJzIE8R8c_Kr3s";
	ALIAS r4 $imageURL // 1412
	ALIAS r5 $literalexpression287 // 1412
	LOAD $literalexpression287 "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/3fc0f3d5-6138-4b4c-bf96-985d8010c8c2/d9rqlio-baa2d9c9-4e45-4a76-9d11-2f2787d97311.png/v1/fill/w_1192,h_670,q_70,strp/chillrend___cristalgide___fan_art_tes_by_etrelley_d9rqlio-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTA4MCIsInBhdGgiOiJcL2ZcLzNmYzBmM2Q1LTYxMzgtNGI0Yy1iZjk2LTk4NWQ4MDEwYzhjMlwvZDlycWxpby1iYWEyZDljOS00ZTQ1LTRhNzYtOWQxMS0yZjI3ODdkOTczMTEucG5nIiwid2lkdGgiOiI8PTE5MjAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.vQSAwi5ovYTnP_c-JrKx4uA2PDn5wjJzIE8R8c_Kr3s" // 1412
	COPY $literalexpression287 $imageURL // 2128
// Line 82:        local rom: simp_rom = Struct.simp_rom("Crystal Gazer","Formulated from the eye crystals of a dead angel","",imageURL,Time.now());
	ALIAS r5 $rom // 2131
	CLEAR r6 // 2131
	ALIAS r8 $literalexpression296 // 2133
	LOAD $literalexpression296 "Crystal Gazer" // 2133
	LOAD r7 "name" // 2150
	PUT $literalexpression296 r6 r7 // 2158
	ALIAS r8 $literalexpression297 // 2162
	LOAD $literalexpression297 "Formulated from the eye crystals of a dead angel" // 2162
	LOAD r7 "description" // 2214
	PUT $literalexpression297 r6 r7 // 2229
	ALIAS r8 $literalexpression298 // 2233
	LOAD $literalexpression298 "" // 2233
	LOAD r7 "infoURL" // 2237
	PUT $literalexpression298 r6 r7 // 2248
	COPY $imageURL r8 // 2252
	LOAD r7 "imageURL" // 2255
	PUT r8 r6 r7 // 2267
	ALIAS r8 $methodcallexpression300 // 2271
	LOAD $methodcallexpression300 "Runtime.Time" // 2271
	EXTCALL $methodcallexpression300 // 2287
	POP $methodcallexpression300 // 2289
	LOAD r7 "created" // 2291
	PUT $methodcallexpression300 r6 r7 // 2302
	COPY r6 $rom // 2306
// Line 83:        local ram: simp_ram = Struct.simp_ram("Crystal Gazer",5,1);
	ALIAS r6 $ram // 2309
	CLEAR r7 // 2309
	ALIAS r9 $literalexpression307 // 2311
	LOAD $literalexpression307 "Crystal Gazer" // 2311
	LOAD r8 "weapon_name" // 2328
	PUT $literalexpression307 r7 r8 // 2343
	ALIAS r9 $literalexpression308 // 2347
	LOAD $literalexpression308 5 // 2347
	LOAD r8 "durability" // 2352
	PUT $literalexpression308 r7 r8 // 2366
	ALIAS r9 $literalexpression309 // 2370
	LOAD $literalexpression309 1 // 2370
	LOAD r8 "enchanted" // 2375
	PUT $literalexpression309 r7 r8 // 2388
	COPY r7 $ram // 2392
// Line 84:        NFT.mint(from, to, $THIS_SYMBOL, rom, ram, seriesID);
	ALIAS r7 $methodcallexpression313 // 2395
	COPY $seriesID r8 // 2395
	PUSH r8 // 2398
	COPY $ram r8 // 2400
	CAST r8 r8 #Bytes // 2403
	PUSH r8 // 2407
	COPY $rom r8 // 2409
	CAST r8 r8 #Bytes // 2412
	PUSH r8 // 2416
	ALIAS r8 $literalexpression323 // 2418
	LOAD $literalexpression323 "SDT" // 2418
	PUSH $literalexpression323 // 2425
	COPY $to r8 // 2427
	PUSH r8 // 2430
	COPY $from r8 // 2432
	PUSH r8 // 2435
	LOAD $methodcallexpression313 "Runtime.MintToken" // 2437
	EXTCALL $methodcallexpression313 // 2458
	POP $methodcallexpression313 // 2460
@exit_Mint: // 2462
RET // 2463
// Line 85:    }

// ********* addDelegate Method ***********
@entry_addDelegate: // 2464
ALIAS r1 $dataGet // 2465
LOAD $dataGet "Data.Get" // 2465
ALIAS r2 $contractName // 2477
LOAD $contractName "SDT" // 2477
ALIAS r3 $_owner // 2484
// reading global: _owner
LOAD r0 8 // 2484
PUSH r0 // 2489
LOAD r0 "_owner" // 2491
PUSH r0 // 2501
PUSH $contractName // 2503
EXTCALL $dataGet // 2505
POP $_owner // 2507
PUSH $_owner // 2509
EXTCALL "Address()" // 2511
POP $_owner // 2526
// Line 86:
// Line 87:    public addDelegate(delegate:address){
ALIAS r1 $delegate // 2528
POP $delegate // 2528
PUSH $delegate // 2530
EXTCALL "Address()" // 2532
POP $delegate // 2547
// Line 88:        Runtime.expect(Runtime.isWitness(_owner),"Must be Owner to add Delegate");
	ALIAS r2 $methodcallexpression335 // 2549
	COPY $_owner r4 // 2549
	PUSH r4 // 2552
	LOAD $methodcallexpression335 "Runtime.IsWitness" // 2554
	EXTCALL $methodcallexpression335 // 2575
	POP $methodcallexpression335 // 2577
	JMPIF $methodcallexpression335 @expect_methodcallexpression332 // 2579
	ALIAS r4 $literalexpression338 // 2583
	LOAD $literalexpression338 "Must be Owner to add Delegate" // 2583
	THROW $literalexpression338 // 2616
	@expect_methodcallexpression332: NOP // 2619
// Line 89:        Runtime.expect(!delegates.has(delegate),"User is already a delegate");
	LOAD r2 6 // field type // 2619
	PUSH r2 // 2624
	COPY $delegate r4 // 2626
	PUSH r4 // 2629
	ALIAS r4 $literalexpression359 // 2631
	LOAD $literalexpression359 "delegates" // 2631
	PUSH $literalexpression359 // 2644
	LOAD $literalexpression359 "SDT" // contract name // 2646
	PUSH $literalexpression359 // 2653
	LOAD r2 "Map.Has" // 2655
	EXTCALL r2 // 2666
	POP r2 // 2668
	NOT r2 r2 // 2670
	JMPIF r2 @expect_methodcallexpression340 // 2673
	ALIAS r4 $literalexpression362 // 2677
	LOAD $literalexpression362 "User is already a delegate" // 2677
	THROW $literalexpression362 // 2707
	@expect_methodcallexpression340: NOP // 2710
// Line 90:        delegates.set(delegate,1);
	ALIAS r2 $methodcallexpression364 // 2710
	ALIAS r4 $literalexpression372 // 2710
	LOAD $literalexpression372 1 // 2710
	PUSH $literalexpression372 // 2715
	COPY $delegate r4 // 2717
	PUSH r4 // 2720
	ALIAS r4 $literalexpression370 // 2722
	LOAD $literalexpression370 "delegates" // 2722
	PUSH $literalexpression370 // 2735
	LOAD $methodcallexpression364 "Map.Set" // 2737
	EXTCALL $methodcallexpression364 // 2748
@exit_addDelegate: // 2750
RET // 2751
// Line 91:    }

// ********* isDelegate Method ***********
@entry_isDelegate: // 2752
// Line 92:    
// Line 93:    public isDelegate(delegate:address): bool{
ALIAS r1 $delegate // 2753
POP $delegate // 2753
PUSH $delegate // 2755
EXTCALL "Address()" // 2757
POP $delegate // 2772
// Line 94:        return delegates.has(delegate);
	LOAD r2 6 // field type // 2774
	PUSH r2 // 2779
	COPY $delegate r3 // 2781
	PUSH r3 // 2784
	ALIAS r3 $literalexpression381 // 2786
	LOAD $literalexpression381 "delegates" // 2786
	PUSH $literalexpression381 // 2799
	LOAD $literalexpression381 "SDT" // contract name // 2801
	PUSH $literalexpression381 // 2808
	LOAD r2 "Map.Has" // 2810
	EXTCALL r2 // 2821
	POP r2 // 2823
	PUSH r2 // 2825
	JMP @exit_isDelegate // 2827
@exit_isDelegate: // 2830
RET // 2831
// Line 95:    }

// ********* readRam Method ***********
@entry_readRam: // 2832
// Line 96:
// Line 97: 
// Line 98:    public readRam(nftID: number):simp_ram{
ALIAS r1 $nftID // 2833
POP $nftID // 2833
CAST $nftID $nftID #Number // 2835
// Line 99:        local ram :simp_ram = NFT.readRAM<simp_ram>($THIS_SYMBOL,nftID);
	ALIAS r2 $ram // 2839
	ALIAS r3 $methodcallexpression388 // 2839
	COPY $nftID r4 // 2839
	PUSH r4 // 2842
	ALIAS r4 $literalexpression392 // 2844
	LOAD $literalexpression392 "SDT" // 2844
	PUSH $literalexpression392 // 2851
	LOAD $methodcallexpression388 "Runtime.ReadTokenRAM" // 2853
	EXTCALL $methodcallexpression388 // 2877
	POP $methodcallexpression388 // 2879
	UNPACK $methodcallexpression388 $methodcallexpression388 // 2881
	COPY $methodcallexpression388 $ram // 2884
// Line 100:        return ram;
	COPY $ram r3 // 2887
	PUSH r3 // 2890
	JMP @exit_readRam // 2892
@exit_readRam: // 2895
RET // 2896
// Line 101:    }

// ********* updateDurability Method ***********
@entry_updateDurability: // 2897
// Line 102:    /****
// Line 103:    Usage: Write to an existing NFT
// Line 104:    @param nftID
// Line 105:    @param weapon_name
// Line 106:    @param durabiility 
// Line 107:    @param enchanted
// Line 108:    *****/
// Line 109:    public updateDurability(from:address, nftID:number,durability: number){
ALIAS r1 $from // 2898
POP $from // 2898
PUSH $from // 2900
EXTCALL "Address()" // 2902
POP $from // 2917
ALIAS r2 $nftID // 2919
POP $nftID // 2919
CAST $nftID $nftID #Number // 2921
ALIAS r3 $durability // 2925
POP $durability // 2925
CAST $durability $durability #Number // 2927
// Line 110:        local nftData: NFT = NFT.read($THIS_SYMBOL,nftID);
	ALIAS r4 $nftData // 2931
	LOAD r5 "chain,owner,creator,ROM,RAM,seriesID,mintID" // field list // 2931
	PUSH r5 // 2978
	COPY $nftID r6 // 2980
	PUSH r6 // 2983
	ALIAS r6 $literalexpression410 // 2985
	LOAD $literalexpression410 "SDT" // 2985
	PUSH $literalexpression410 // 2992
	LOAD r5 "Runtime.ReadToken" // 2994
	EXTCALL r5 // 3015
	POP r5 // 3017
	UNPACK r5 r5 // 3019
	COPY r5 $nftData // 3022
// Line 111:        local has_access :bool = false;
	ALIAS r5 $has_access // 3025
	ALIAS r6 $literalexpression414 // 3025
	LOAD $literalexpression414 false // 3025
	COPY $literalexpression414 $has_access // 3030
// Line 112:        if(Runtime.isWitness(nftData.owner)){
	ALIAS r6 $methodcallexpression418 // 3033
	COPY $nftData r7 // 3033
	LOAD r8 "owner" // 3036
	GET r7 r7 r8 // 3045
	PUSH r7 // 3049
	LOAD $methodcallexpression418 "Runtime.IsWitness" // 3051
	EXTCALL $methodcallexpression418 // 3072
	POP $methodcallexpression418 // 3074
		JMPNOT $methodcallexpression418 @else_ifstatement417 // 3076
// Line 113:            has_access = true;
		ALIAS r7 $literalexpression423 // 3080
		LOAD $literalexpression423 true // 3080
		COPY $literalexpression423 $has_access // 3085
		JMP @then_ifstatement417 // 3088
		@else_ifstatement417: NOP // 3092
// Line 114:        }
// Line 115:        else{
// Line 116:            if(delegates.has(from)){
		LOAD r7 6 // field type // 3092
		PUSH r7 // 3097
		COPY $from r8 // 3099
		PUSH r8 // 3102
		ALIAS r8 $literalexpression430 // 3104
		LOAD $literalexpression430 "delegates" // 3104
		PUSH $literalexpression430 // 3117
		LOAD $literalexpression430 "SDT" // contract name // 3119
		PUSH $literalexpression430 // 3126
		LOAD r7 "Map.Has" // 3128
		EXTCALL r7 // 3139
		POP r7 // 3141
			JMPNOT r7 @then_ifstatement425 // 3143
// Line 117:                if(Runtime.isWitness(from)){
			ALIAS r8 $methodcallexpression434 // 3147
			COPY $from r9 // 3147
			PUSH r9 // 3150
			LOAD $methodcallexpression434 "Runtime.IsWitness" // 3152
			EXTCALL $methodcallexpression434 // 3173
			POP $methodcallexpression434 // 3175
				JMPNOT $methodcallexpression434 @then_ifstatement433 // 3177
// Line 118:                    has_access = true;
				ALIAS r9 $literalexpression439 // 3181
				LOAD $literalexpression439 true // 3181
				COPY $literalexpression439 $has_access // 3186
				@then_ifstatement433: NOP // 3190
			@then_ifstatement425: NOP // 3191
		@then_ifstatement417: NOP // 3192
// Line 119:                }
// Line 120:            }
// Line 121:        }
// Line 122:        Runtime.expect(has_access,"Must be either owner or a delegate of Nft to make changes");
	COPY $has_access r6 // 3192
	JMPIF r6 @expect_methodcallexpression441 // 3195
	ALIAS r7 $literalexpression445 // 3199
	LOAD $literalexpression445 "Must be either owner or a delegate of Nft to make changes" // 3199
	THROW $literalexpression445 // 3260
	@expect_methodcallexpression441: NOP // 3263
// Line 123:        Runtime.expect(durability >= 0 && durability <=10, "Durability has to be between 0-10");
	COPY $durability r6 // 3263
	ALIAS r7 $literalexpression451 // 3266
	LOAD $literalexpression451 0 // 3266
	GTE r6 $literalexpression451 r8 // 3271
	COPY $durability r6 // 3275
	ALIAS r7 $literalexpression454 // 3278
	LOAD $literalexpression454 10 // 3278
	LTE r6 $literalexpression454 r9 // 3283
	AND r8 r9 r6 // 3287
	JMPIF r6 @expect_methodcallexpression447 // 3291
	ALIAS r7 $literalexpression457 // 3295
	LOAD $literalexpression457 "Durability has to be between 0-10" // 3295
	THROW $literalexpression457 // 3332
	@expect_methodcallexpression447: NOP // 3335
// Line 124:        local prev_ram: simp_ram = NFT.readRAM<simp_ram>($THIS_SYMBOL,nftID);
	ALIAS r6 $prev_ram // 3335
	ALIAS r7 $methodcallexpression458 // 3335
	COPY $nftID r8 // 3335
	PUSH r8 // 3338
	ALIAS r8 $literalexpression462 // 3340
	LOAD $literalexpression462 "SDT" // 3340
	PUSH $literalexpression462 // 3347
	LOAD $methodcallexpression458 "Runtime.ReadTokenRAM" // 3349
	EXTCALL $methodcallexpression458 // 3373
	POP $methodcallexpression458 // 3375
	UNPACK $methodcallexpression458 $methodcallexpression458 // 3377
	COPY $methodcallexpression458 $prev_ram // 3380
// Line 125:
// Line 126:        local new_ram: simp_ram = Struct.simp_ram(prev_ram.weapon_name,durability,prev_ram.enchanted);
	ALIAS r7 $new_ram // 3383
	CLEAR r8 // 3383
	COPY $prev_ram r10 // 3385
	LOAD r11 "weapon_name" // 3388
	GET r10 r10 r11 // 3403
	LOAD r9 "weapon_name" // 3407
	PUT r10 r8 r9 // 3422
	COPY $durability r10 // 3426
	LOAD r9 "durability" // 3429
	PUT r10 r8 r9 // 3443
	COPY $prev_ram r10 // 3447
	LOAD r11 "enchanted" // 3450
	GET r10 r10 r11 // 3463
	LOAD r9 "enchanted" // 3467
	PUT r10 r8 r9 // 3480
	COPY r8 $new_ram // 3484
// Line 127:        NFT.write(from,$THIS_SYMBOL,nftID,new_ram);
	ALIAS r8 $methodcallexpression476 // 3487
	COPY $new_ram r9 // 3487
	CAST r9 r9 #Bytes // 3490
	PUSH r9 // 3494
	COPY $nftID r9 // 3496
	PUSH r9 // 3499
	ALIAS r9 $literalexpression483 // 3501
	LOAD $literalexpression483 "SDT" // 3501
	PUSH $literalexpression483 // 3508
	COPY $from r9 // 3510
	PUSH r9 // 3513
	LOAD $methodcallexpression476 "Runtime.WriteToken" // 3515
	EXTCALL $methodcallexpression476 // 3537
@exit_updateDurability: // 3539
RET // 3540
// Line 128:
// Line 129:    }

// ********* onUpgrade Trigger ***********
@entry_onUpgrade: // 3541
ALIAS r1 $dataGet // 3542
LOAD $dataGet "Data.Get" // 3542
ALIAS r2 $contractName // 3554
LOAD $contractName "SDT" // 3554
ALIAS r3 $_owner // 3561
// reading global: _owner
LOAD r0 8 // 3561
PUSH r0 // 3566
LOAD r0 "_owner" // 3568
PUSH r0 // 3578
PUSH $contractName // 3580
EXTCALL $dataGet // 3582
POP $_owner // 3584
PUSH $_owner // 3586
EXTCALL "Address()" // 3588
POP $_owner // 3603
// Line 130:
// Line 131:    trigger onUpgrade(from:address){
ALIAS r1 $from // 3605
POP $from // 3605
PUSH $from // 3607
EXTCALL "Address()" // 3609
POP $from // 3624
// Line 132:        Runtime.expect(Runtime.isWitness(_owner),"Improper verification");
	ALIAS r2 $methodcallexpression494 // 3626
	COPY $_owner r4 // 3626
	PUSH r4 // 3629
	LOAD $methodcallexpression494 "Runtime.IsWitness" // 3631
	EXTCALL $methodcallexpression494 // 3652
	POP $methodcallexpression494 // 3654
	JMPIF $methodcallexpression494 @expect_methodcallexpression491 // 3656
	ALIAS r4 $literalexpression497 // 3660
	LOAD $literalexpression497 "Improper verification" // 3660
	THROW $literalexpression497 // 3685
	@expect_methodcallexpression491: NOP // 3688
@exit_onUpgrade: // 3688
RET // 3689
// Line 133:
// Line 134:    }

// ********* onKill Trigger ***********
@entry_onKill: // 3690
ALIAS r1 $dataGet // 3691
LOAD $dataGet "Data.Get" // 3691
ALIAS r2 $contractName // 3703
LOAD $contractName "SDT" // 3703
ALIAS r3 $_owner // 3710
// reading global: _owner
LOAD r0 8 // 3710
PUSH r0 // 3715
LOAD r0 "_owner" // 3717
PUSH r0 // 3727
PUSH $contractName // 3729
EXTCALL $dataGet // 3731
POP $_owner // 3733
PUSH $_owner // 3735
EXTCALL "Address()" // 3737
POP $_owner // 3752
// Line 135:
// Line 136:    trigger onKill(from:address){
ALIAS r1 $from // 3754
POP $from // 3754
PUSH $from // 3756
EXTCALL "Address()" // 3758
POP $from // 3773
// Line 137:         Runtime.expect(Runtime.isWitness(_owner),"Improper verification");
	ALIAS r2 $methodcallexpression506 // 3775
	COPY $_owner r4 // 3775
	PUSH r4 // 3778
	LOAD $methodcallexpression506 "Runtime.IsWitness" // 3780
	EXTCALL $methodcallexpression506 // 3801
	POP $methodcallexpression506 // 3803
	JMPIF $methodcallexpression506 @expect_methodcallexpression503 // 3805
	ALIAS r4 $literalexpression509 // 3809
	LOAD $literalexpression509 "Improper verification" // 3809
	THROW $literalexpression509 // 3834
	@expect_methodcallexpression503: NOP // 3837
@exit_onKill: // 3837
RET // 3838
// Line 138:
// Line 139:    }

// ********* onMint Trigger ***********
@entry_onMint: // 3839
// Line 140:    trigger onMint(from:address, to:address, symbol:string, tokenID:number) { 
ALIAS r1 $from // 3840
POP $from // 3840
PUSH $from // 3842
EXTCALL "Address()" // 3844
POP $from // 3859
ALIAS r2 $to // 3861
POP $to // 3861
PUSH $to // 3863
EXTCALL "Address()" // 3865
POP $to // 3880
ALIAS r3 $symbol // 3882
POP $symbol // 3882
ALIAS r4 $tokenID // 3884
POP $tokenID // 3884
CAST $tokenID $tokenID #Number // 3886
// Line 141:        Runtime.expect(Runtime.isWitness(from),"Improper verification");
	ALIAS r5 $methodcallexpression524 // 3890
	COPY $from r6 // 3890
	PUSH r6 // 3893
	LOAD $methodcallexpression524 "Runtime.IsWitness" // 3895
	EXTCALL $methodcallexpression524 // 3916
	POP $methodcallexpression524 // 3918
	JMPIF $methodcallexpression524 @expect_methodcallexpression521 // 3920
	ALIAS r6 $literalexpression527 // 3924
	LOAD $literalexpression527 "Improper verification" // 3924
	THROW $literalexpression527 // 3949
	@expect_methodcallexpression521: NOP // 3952
@exit_onMint: // 3952
RET // 3953
// Line 142:
// Line 143:    }

// ********* onSeries Trigger ***********
@entry_onSeries: // 3954
// Line 144:
// Line 145:    trigger onSeries(from:address){
ALIAS r1 $from // 3955
POP $from // 3955
PUSH $from // 3957
EXTCALL "Address()" // 3959
POP $from // 3974
@exit_onSeries: // 3976
RET // 3977
// Line 146:
// Line 147:    }

// ********* onBurn Trigger ***********
@entry_onBurn: // 3978
// Line 148:    trigger onBurn(from:address, to:address, symbol:string, tokenID:number){
ALIAS r1 $from // 3979
POP $from // 3979
PUSH $from // 3981
EXTCALL "Address()" // 3983
POP $from // 3998
ALIAS r2 $to // 4000
POP $to // 4000
PUSH $to // 4002
EXTCALL "Address()" // 4004
POP $to // 4019
ALIAS r3 $symbol // 4021
POP $symbol // 4021
ALIAS r4 $tokenID // 4023
POP $tokenID // 4023
CAST $tokenID $tokenID #Number // 4025
// Line 149:         Runtime.expect(Runtime.isWitness(from),"Improper verification");
	ALIAS r5 $methodcallexpression546 // 4029
	COPY $from r6 // 4029
	PUSH r6 // 4032
	LOAD $methodcallexpression546 "Runtime.IsWitness" // 4034
	EXTCALL $methodcallexpression546 // 4055
	POP $methodcallexpression546 // 4057
	JMPIF $methodcallexpression546 @expect_methodcallexpression543 // 4059
	ALIAS r6 $literalexpression549 // 4063
	LOAD $literalexpression549 "Improper verification" // 4063
	THROW $literalexpression549 // 4088
	@expect_methodcallexpression543: NOP // 4091
@exit_onBurn: // 4091
RET // 4092
