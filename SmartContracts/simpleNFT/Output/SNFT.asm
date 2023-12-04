
// ********* getName Property ***********
@entry_getName: // 0
	ALIAS r1 $literalexpression106 // 1
	LOAD $literalexpression106 "Simple NFT" // 1
	PUSH $literalexpression106 // 15
	JMP @exit_getName // 17
@exit_getName: // 20
RET // 21

// ********* getSymbol Property ***********
@entry_getSymbol: // 22
	ALIAS r1 $literalexpression110 // 23
	LOAD $literalexpression110 "SNFT" // 23
	PUSH $literalexpression110 // 31
	JMP @exit_getSymbol // 33
@exit_getSymbol: // 36
RET // 37

// ********* isFungible Property ***********
@entry_isFungible: // 38
	ALIAS r1 $literalexpression114 // 39
	LOAD $literalexpression114 false // 39
	PUSH $literalexpression114 // 44
	JMP @exit_isFungible // 46
@exit_isFungible: // 49
RET // 50

// ********* isFinite Property ***********
@entry_isFinite: // 51
	ALIAS r1 $literalexpression118 // 52
	LOAD $literalexpression118 true // 52
	PUSH $literalexpression118 // 57
	JMP @exit_isFinite // 59
@exit_isFinite: // 62
RET // 63

// ********* isBurnable Property ***********
@entry_isBurnable: // 64
	ALIAS r1 $literalexpression122 // 65
	LOAD $literalexpression122 true // 65
	PUSH $literalexpression122 // 70
	JMP @exit_isBurnable // 72
@exit_isBurnable: // 75
RET // 76

// ********* getMaxSupply Property ***********
@entry_getMaxSupply: // 77
	ALIAS r1 $literalexpression126 // 78
	LOAD $literalexpression126 10 // 78
	PUSH $literalexpression126 // 83
	JMP @exit_getMaxSupply // 85
@exit_getMaxSupply: // 88
RET // 89

// ********* isTransferable Property ***********
@entry_isTransferable: // 90
	ALIAS r1 $literalexpression130 // 91
	LOAD $literalexpression130 true // 91
	PUSH $literalexpression130 // 96
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
// Line 46:        }
// Line 47:      
// Line 48:  
// Line 49:    }

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
// Line 50:
// Line 51:   constructor(owner:address){
ALIAS r2 $owner // 272
POP $owner // 272
PUSH $owner // 274
EXTCALL "Address()" // 276
POP $owner // 291
// Line 52:        _owner = owner;
	COPY $owner r3 // 293
	COPY r3 $_owner // 296
// Line 53:        NFT.createSeries(owner,$THIS_SYMBOL,0,4,TokenSeries.Duplicated,simp);//TokenSeries.Unique
	ALIAS r3 $methodcallexpression212 // 299
	LOAD r4 0x04076765744E616D6504000000000107746F6B656E4944030E6765744465736372697074696F6E04580000000107746F6B656E4944030A676574496E666F55524C04B70000000107746F6B656E4944030B676574496D61676555524C04120100000107746F6B656E49440300 // abi // 299
	PUSH r4 // 411
	LOAD r4 0x0004010D000403524F4D030003010D000404534E465403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D0204046E616D65300101020301085700000B0004010D000403524F4D030003010D000404534E465403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D02040B6465736372697074696F6E30010102030108B600000B0004010D000403524F4D030003010D000404534E465403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D020407696E666F55524C300101020301081101000B0004010D000403524F4D030003010D000404534E465403000D00041152756E74696D652E52656164546F6B656E070004023202020D000403524F4D300203003203030203010D020408696D61676555524C300101020301086D01000B // script // 413
	PUSH r4 // 785
	ALIAS r4 $literalexpression224 // 787
	LOAD $literalexpression224 1 Enum // 787
	PUSH $literalexpression224 // 795
	ALIAS r4 $literalexpression223 // 797
	LOAD $literalexpression223 4 // 797
	PUSH $literalexpression223 // 802
	ALIAS r4 $literalexpression222 // 804
	LOAD $literalexpression222 0 // 804
	PUSH $literalexpression222 // 809
	ALIAS r4 $literalexpression221 // 811
	LOAD $literalexpression221 "SNFT" // 811
	PUSH $literalexpression221 // 819
	COPY $owner r4 // 821
	PUSH r4 // 824
	LOAD $methodcallexpression212 "Nexus.CreateTokenSeries" // 826
	EXTCALL $methodcallexpression212 // 853
@exit_constructor: // 855
LOAD r2 "Data.Set" // 856
// writing global: _owner
PUSH $_owner // 868
LOAD r0 "_owner" // 870
PUSH r0 // 880
EXTCALL r2 // 882
RET // 884
// Line 54:    }

// ********* initMint Method ***********
@entry_initMint: // 885
// Line 55:
// Line 56:    public initMint(from:address,to:address,seriesID:number){
ALIAS r1 $from // 886
POP $from // 886
PUSH $from // 888
EXTCALL "Address()" // 890
POP $from // 905
ALIAS r2 $to // 907
POP $to // 907
PUSH $to // 909
EXTCALL "Address()" // 911
POP $to // 926
ALIAS r3 $seriesID // 928
POP $seriesID // 928
CAST $seriesID $seriesID #Number // 930
// Line 57:        local rom: simp_rom = Struct.simp_rom("The Manatee Gazer","One who gazes at the manatee becomes one with nature itself","","https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/8cfe7a95-07b5-45de-a26a-e310da6553f5/dgeuci3-0c0cc951-34c1-4573-9d15-6164367c32a4.jpg/v1/fill/w_1192,h_670,q_70,strp/the_dream_tour_is_over_by_kismuki_dgeuci3-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NzIwIiwicGF0aCI6IlwvZlwvOGNmZTdhOTUtMDdiNS00NWRlLWEyNmEtZTMxMGRhNjU1M2Y1XC9kZ2V1Y2kzLTBjMGNjOTUxLTM0YzEtNDU3My05ZDE1LTYxNjQzNjdjMzJhNC5qcGciLCJ3aWR0aCI6Ijw9MTI4MCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.QBvjj3MI9P-BytZiy3Hr_2QC3eIydWgyDOo9IdkG39Y");
	ALIAS r4 $rom // 934
	CLEAR r5 // 934
	ALIAS r7 $literalexpression239 // 936
	LOAD $literalexpression239 "The Manatee Gazer" // 936
	LOAD r6 "name" // 957
	PUT $literalexpression239 r5 r6 // 965
	ALIAS r7 $literalexpression240 // 969
	LOAD $literalexpression240 "One who gazes at the manatee becomes one with nature itself" // 969
	LOAD r6 "description" // 1032
	PUT $literalexpression240 r5 r6 // 1047
	ALIAS r7 $literalexpression241 // 1051
	LOAD $literalexpression241 "" // 1051
	LOAD r6 "infoURL" // 1055
	PUT $literalexpression241 r5 r6 // 1066
	ALIAS r7 $literalexpression242 // 1070
	LOAD $literalexpression242 "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/8cfe7a95-07b5-45de-a26a-e310da6553f5/dgeuci3-0c0cc951-34c1-4573-9d15-6164367c32a4.jpg/v1/fill/w_1192,h_670,q_70,strp/the_dream_tour_is_over_by_kismuki_dgeuci3-pre.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NzIwIiwicGF0aCI6IlwvZlwvOGNmZTdhOTUtMDdiNS00NWRlLWEyNmEtZTMxMGRhNjU1M2Y1XC9kZ2V1Y2kzLTBjMGNjOTUxLTM0YzEtNDU3My05ZDE1LTYxNjQzNjdjMzJhNC5qcGciLCJ3aWR0aCI6Ijw9MTI4MCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.QBvjj3MI9P-BytZiy3Hr_2QC3eIydWgyDOo9IdkG39Y" // 1070
	LOAD r6 "imageURL" // 1768
	PUT $literalexpression242 r5 r6 // 1780
	COPY r5 $rom // 1784
// Line 58:        NFT.mint(from, to, $THIS_SYMBOL, rom, "", seriesID);
	ALIAS r5 $methodcallexpression246 // 1787
	COPY $seriesID r6 // 1787
	PUSH r6 // 1790
	ALIAS r6 $literalexpression258 // 1792
	LOAD $literalexpression258 "" // 1792
	CAST $literalexpression258 $literalexpression258 #Bytes // 1796
	PUSH $literalexpression258 // 1800
	COPY $rom r6 // 1802
	CAST r6 r6 #Bytes // 1805
	PUSH r6 // 1809
	ALIAS r6 $literalexpression256 // 1811
	LOAD $literalexpression256 "SNFT" // 1811
	PUSH $literalexpression256 // 1819
	COPY $to r6 // 1821
	PUSH r6 // 1824
	COPY $from r6 // 1826
	PUSH r6 // 1829
	LOAD $methodcallexpression246 "Runtime.MintToken" // 1831
	EXTCALL $methodcallexpression246 // 1852
	POP $methodcallexpression246 // 1854
@exit_initMint: // 1856
RET // 1857
// Line 59:    }

// ********* dupMint Method ***********
@entry_dupMint: // 1858
// Line 60:
// Line 61:    public dupMint(from:address,to:address,seriesID:number){ 
ALIAS r1 $from // 1859
POP $from // 1859
PUSH $from // 1861
EXTCALL "Address()" // 1863
POP $from // 1878
ALIAS r2 $to // 1880
POP $to // 1880
PUSH $to // 1882
EXTCALL "Address()" // 1884
POP $to // 1899
ALIAS r3 $seriesID // 1901
POP $seriesID // 1901
CAST $seriesID $seriesID #Number // 1903
// Line 62:        NFT.mint(from, to, $THIS_SYMBOL, "", "", seriesID);
	ALIAS r4 $methodcallexpression269 // 1907
	COPY $seriesID r5 // 1907
	PUSH r5 // 1910
	ALIAS r5 $literalexpression281 // 1912
	LOAD $literalexpression281 "" // 1912
	CAST $literalexpression281 $literalexpression281 #Bytes // 1916
	PUSH $literalexpression281 // 1920
	ALIAS r5 $literalexpression280 // 1922
	LOAD $literalexpression280 "" // 1922
	CAST $literalexpression280 $literalexpression280 #Bytes // 1926
	PUSH $literalexpression280 // 1930
	ALIAS r5 $literalexpression279 // 1932
	LOAD $literalexpression279 "SNFT" // 1932
	PUSH $literalexpression279 // 1940
	COPY $to r5 // 1942
	PUSH r5 // 1945
	COPY $from r5 // 1947
	PUSH r5 // 1950
	LOAD $methodcallexpression269 "Runtime.MintToken" // 1952
	EXTCALL $methodcallexpression269 // 1973
	POP $methodcallexpression269 // 1975
@exit_dupMint: // 1977
RET // 1978
// Line 63:    }

// ********* onUpgrade Trigger ***********
@entry_onUpgrade: // 1979
ALIAS r1 $dataGet // 1980
LOAD $dataGet "Data.Get" // 1980
ALIAS r2 $contractName // 1992
LOAD $contractName "SNFT" // 1992
ALIAS r3 $_owner // 2000
// reading global: _owner
LOAD r0 8 // 2000
PUSH r0 // 2005
LOAD r0 "_owner" // 2007
PUSH r0 // 2017
PUSH $contractName // 2019
EXTCALL $dataGet // 2021
POP $_owner // 2023
PUSH $_owner // 2025
EXTCALL "Address()" // 2027
POP $_owner // 2042
// Line 64:
// Line 65:
// Line 66:    trigger onUpgrade(from:address){
ALIAS r1 $from // 2044
POP $from // 2044
PUSH $from // 2046
EXTCALL "Address()" // 2048
POP $from // 2063
// Line 67:        Runtime.expect(Runtime.isWitness(_owner),"Improper verification");
	ALIAS r2 $methodcallexpression291 // 2065
	COPY $_owner r4 // 2065
	PUSH r4 // 2068
	LOAD $methodcallexpression291 "Runtime.IsWitness" // 2070
	EXTCALL $methodcallexpression291 // 2091
	POP $methodcallexpression291 // 2093
	JMPIF $methodcallexpression291 @expect_methodcallexpression288 // 2095
	ALIAS r4 $literalexpression294 // 2099
	LOAD $literalexpression294 "Improper verification" // 2099
	THROW $literalexpression294 // 2124
	@expect_methodcallexpression288: NOP // 2127
@exit_onUpgrade: // 2127
RET // 2128
// Line 68:
// Line 69:    }

// ********* onKill Trigger ***********
@entry_onKill: // 2129
ALIAS r1 $dataGet // 2130
LOAD $dataGet "Data.Get" // 2130
ALIAS r2 $contractName // 2142
LOAD $contractName "SNFT" // 2142
ALIAS r3 $_owner // 2150
// reading global: _owner
LOAD r0 8 // 2150
PUSH r0 // 2155
LOAD r0 "_owner" // 2157
PUSH r0 // 2167
PUSH $contractName // 2169
EXTCALL $dataGet // 2171
POP $_owner // 2173
PUSH $_owner // 2175
EXTCALL "Address()" // 2177
POP $_owner // 2192
// Line 70:
// Line 71:    trigger onKill(from:address){
ALIAS r1 $from // 2194
POP $from // 2194
PUSH $from // 2196
EXTCALL "Address()" // 2198
POP $from // 2213
// Line 72:         Runtime.expect(Runtime.isWitness(_owner),"Improper verification");
	ALIAS r2 $methodcallexpression303 // 2215
	COPY $_owner r4 // 2215
	PUSH r4 // 2218
	LOAD $methodcallexpression303 "Runtime.IsWitness" // 2220
	EXTCALL $methodcallexpression303 // 2241
	POP $methodcallexpression303 // 2243
	JMPIF $methodcallexpression303 @expect_methodcallexpression300 // 2245
	ALIAS r4 $literalexpression306 // 2249
	LOAD $literalexpression306 "Improper verification" // 2249
	THROW $literalexpression306 // 2274
	@expect_methodcallexpression300: NOP // 2277
@exit_onKill: // 2277
RET // 2278
// Line 73:
// Line 74:    }

// ********* onMint Trigger ***********
@entry_onMint: // 2279
// Line 75:    trigger onMint(from:address, to:address, symbol:string, tokenID:number) {
ALIAS r1 $from // 2280
POP $from // 2280
PUSH $from // 2282
EXTCALL "Address()" // 2284
POP $from // 2299
ALIAS r2 $to // 2301
POP $to // 2301
PUSH $to // 2303
EXTCALL "Address()" // 2305
POP $to // 2320
ALIAS r3 $symbol // 2322
POP $symbol // 2322
ALIAS r4 $tokenID // 2324
POP $tokenID // 2324
CAST $tokenID $tokenID #Number // 2326
// Line 76:        Runtime.expect(Runtime.isWitness(from),"Improper verification");
	ALIAS r5 $methodcallexpression321 // 2330
	COPY $from r6 // 2330
	PUSH r6 // 2333
	LOAD $methodcallexpression321 "Runtime.IsWitness" // 2335
	EXTCALL $methodcallexpression321 // 2356
	POP $methodcallexpression321 // 2358
	JMPIF $methodcallexpression321 @expect_methodcallexpression318 // 2360
	ALIAS r6 $literalexpression324 // 2364
	LOAD $literalexpression324 "Improper verification" // 2364
	THROW $literalexpression324 // 2389
	@expect_methodcallexpression318: NOP // 2392
@exit_onMint: // 2392
RET // 2393
// Line 77:
// Line 78:    }

// ********* onSeries Trigger ***********
@entry_onSeries: // 2394
// Line 79:
// Line 80:    trigger onSeries(from:address){
ALIAS r1 $from // 2395
POP $from // 2395
PUSH $from // 2397
EXTCALL "Address()" // 2399
POP $from // 2414
@exit_onSeries: // 2416
RET // 2417
// Line 81:
// Line 82:    }

// ********* onBurn Trigger ***********
@entry_onBurn: // 2418
// Line 83:    trigger onBurn(from:address, to:address, symbol:string, tokenID:number){
ALIAS r1 $from // 2419
POP $from // 2419
PUSH $from // 2421
EXTCALL "Address()" // 2423
POP $from // 2438
ALIAS r2 $to // 2440
POP $to // 2440
PUSH $to // 2442
EXTCALL "Address()" // 2444
POP $to // 2459
ALIAS r3 $symbol // 2461
POP $symbol // 2461
ALIAS r4 $tokenID // 2463
POP $tokenID // 2463
CAST $tokenID $tokenID #Number // 2465
// Line 84:         Runtime.expect(Runtime.isWitness(from),"Improper verification");
	ALIAS r5 $methodcallexpression343 // 2469
	COPY $from r6 // 2469
	PUSH r6 // 2472
	LOAD $methodcallexpression343 "Runtime.IsWitness" // 2474
	EXTCALL $methodcallexpression343 // 2495
	POP $methodcallexpression343 // 2497
	JMPIF $methodcallexpression343 @expect_methodcallexpression340 // 2499
	ALIAS r6 $literalexpression346 // 2503
	LOAD $literalexpression346 "Improper verification" // 2503
	THROW $literalexpression346 // 2528
	@expect_methodcallexpression340: NOP // 2531
@exit_onBurn: // 2531
RET // 2532
