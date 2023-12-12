// Line 1:token STKNN {
// Line 2:    import Runtime;
// Line 3:    import Token;
// Line 4:
// Line 5:    global _owner: address;

// ********* getName Property ***********
@entry_getName: // 0
// Line 6:    
// Line 7:    property name: string = "Simple Token";
	ALIAS r1 $literalexpression101 // 1
	LOAD $literalexpression101 "Simple Token" // 1
	PUSH $literalexpression101 // 17
	JMP @exit_getName // 19
@exit_getName: // 22
RET // 23

// ********* getSymbol Property ***********
@entry_getSymbol: // 24
// Line 8:    property symbol: string = "STKNN";
	ALIAS r1 $literalexpression105 // 25
	LOAD $literalexpression105 "STKNN" // 25
	PUSH $literalexpression105 // 34
	JMP @exit_getSymbol // 36
@exit_getSymbol: // 39
RET // 40

// ********* isDivisible Property ***********
@entry_isDivisible: // 41
// Line 9:    property isDivisible: bool = true;
	ALIAS r1 $literalexpression109 // 42
	LOAD $literalexpression109 true // 42
	PUSH $literalexpression109 // 47
	JMP @exit_isDivisible // 49
@exit_isDivisible: // 52
RET // 53

// ********* isFungible Property ***********
@entry_isFungible: // 54
// Line 10:    property isFungible: bool = true;
	ALIAS r1 $literalexpression113 // 55
	LOAD $literalexpression113 true // 55
	PUSH $literalexpression113 // 60
	JMP @exit_isFungible // 62
@exit_isFungible: // 65
RET // 66

// ********* isFinite Property ***********
@entry_isFinite: // 67
// Line 11:    property isFinite: bool = true;
	ALIAS r1 $literalexpression117 // 68
	LOAD $literalexpression117 true // 68
	PUSH $literalexpression117 // 73
	JMP @exit_isFinite // 75
@exit_isFinite: // 78
RET // 79

// ********* isBurnable Property ***********
@entry_isBurnable: // 80
// Line 12:    property isBurnable: bool = true;
	ALIAS r1 $literalexpression121 // 81
	LOAD $literalexpression121 true // 81
	PUSH $literalexpression121 // 86
	JMP @exit_isBurnable // 88
@exit_isBurnable: // 91
RET // 92

// ********* getDecimals Property ***********
@entry_getDecimals: // 93
// Line 13:    property decimals: number = 2;
	ALIAS r1 $literalexpression125 // 94
	LOAD $literalexpression125 2 // 94
	PUSH $literalexpression125 // 99
	JMP @exit_getDecimals // 101
@exit_getDecimals: // 104
RET // 105

// ********* getMaxSupply Property ***********
@entry_getMaxSupply: // 106
// Line 14:    property maxSupply: number = 100000000 ; //0 for an infinite
	ALIAS r1 $literalexpression129 // 107
	LOAD $literalexpression129 100000000 // 107
	PUSH $literalexpression129 // 115
	JMP @exit_getMaxSupply // 117
@exit_getMaxSupply: // 120
RET // 121

// ********* isCapped Property ***********
@entry_isCapped: // 122
// Line 15:    property isCapped: bool = true;
	ALIAS r1 $literalexpression133 // 123
	LOAD $literalexpression133 true // 123
	PUSH $literalexpression133 // 128
	JMP @exit_isCapped // 130
@exit_isCapped: // 133
RET // 134

// ********* isTransferable Property ***********
@entry_isTransferable: // 135
// Line 16:    property isTransferable: bool = true;
	ALIAS r1 $literalexpression137 // 136
	LOAD $literalexpression137 true // 136
	PUSH $literalexpression137 // 141
	JMP @exit_isTransferable // 143
@exit_isTransferable: // 146
RET // 147

// ********* getOwner Property ***********
@entry_getOwner: // 148
ALIAS r1 $dataGet // 149
LOAD $dataGet "Data.Get" // 149
ALIAS r2 $contractName // 161
LOAD $contractName "STKNN" // 161
ALIAS r3 $_owner // 170
// reading global: _owner
LOAD r0 8 // 170
PUSH r0 // 175
LOAD r0 "_owner" // 177
PUSH r0 // 187
PUSH $contractName // 189
EXTCALL $dataGet // 191
POP $_owner // 193
PUSH $_owner // 195
EXTCALL "Address()" // 197
POP $_owner // 212
// Line 17:    property owner: address = _owner;
	COPY $_owner r1 // 214
	PUSH r1 // 217
	JMP @exit_getOwner // 219
@exit_getOwner: // 222
RET // 223

// ********* Initialize Constructor ***********
@entry_constructor: // 224
ALIAS r1 $nexus_protocol_version // 225
// validate protocol version
LOAD r0 "Runtime.Version" // 225
EXTCALL r0 // 244
POP r0 // 246
LOAD $nexus_protocol_version 8 // 248
LT r0 $nexus_protocol_version r0 // 253
JMPNOT r0 @protocol_version_validated // 257
LOAD r0 "Current nexus protocol version should be 8 or more" // 261
THROW r0 // 315
@protocol_version_validated: NOP // 318
ALIAS r1 $_owner // 318
// Line 18:
// Line 19:
// Line 20:    constructor(owner:address){
ALIAS r2 $owner // 318
POP $owner // 318
PUSH $owner // 320
EXTCALL "Address()" // 322
POP $owner // 337
// Line 21:        _owner = owner;
	COPY $owner r3 // 339
	COPY r3 $_owner // 342
@exit_constructor: // 345
LOAD r2 "Data.Set" // 346
// writing global: _owner
PUSH $_owner // 358
LOAD r0 "_owner" // 360
PUSH r0 // 370
EXTCALL r2 // 372
RET // 374
// Line 22:
// Line 23:    }

// ********* mint Method ***********
@entry_mint: // 375
ALIAS r1 $dataGet // 376
LOAD $dataGet "Data.Get" // 376
ALIAS r2 $contractName // 388
LOAD $contractName "STKNN" // 388
ALIAS r3 $_owner // 397
// reading global: _owner
LOAD r0 8 // 397
PUSH r0 // 402
LOAD r0 "_owner" // 404
PUSH r0 // 414
PUSH $contractName // 416
EXTCALL $dataGet // 418
POP $_owner // 420
PUSH $_owner // 422
EXTCALL "Address()" // 424
POP $_owner // 439
// Line 24:
// Line 25:    public mint(amount:number){
ALIAS r1 $amount // 441
POP $amount // 441
CAST $amount $amount #Number // 443
// Line 26:        Runtime.expect(Runtime.isWitness(_owner),"Invalid verification.Dust yourself off and try again.");
	ALIAS r2 $methodcallexpression158 // 447
	COPY $_owner r4 // 447
	PUSH r4 // 450
	LOAD $methodcallexpression158 "Runtime.IsWitness" // 452
	EXTCALL $methodcallexpression158 // 473
	POP $methodcallexpression158 // 475
	JMPIF $methodcallexpression158 @expect_methodcallexpression155 // 477
	ALIAS r4 $literalexpression161 // 481
	LOAD $literalexpression161 "Invalid verification.Dust yourself off and try again." // 481
	THROW $literalexpression161 // 538
	@expect_methodcallexpression155: NOP // 541
// Line 27:        local singleToken: number = 10^Token.getDecimals($THIS_SYMBOL);
	ALIAS r2 $singleToken // 541
	ALIAS r4 $literalexpression162 // 541
	LOAD $literalexpression162 10 // 541
	ALIAS r5 $methodcallexpression163 // 546
	ALIAS r6 $literalexpression166 // 546
	LOAD $literalexpression166 "STKNN" // 546
	PUSH $literalexpression166 // 555
	LOAD $methodcallexpression163 "Runtime.GetTokenDecimals" // 557
	EXTCALL $methodcallexpression163 // 585
	POP $methodcallexpression163 // 587
	POW $literalexpression162 $methodcallexpression163 r6 // 589
	COPY r6 $singleToken // 593
// Line 28:        amount = amount * singleToken;
	COPY $amount r4 // 596
	COPY $singleToken r5 // 599
	MUL r4 r5 r6 // 602
	COPY r6 $amount // 606
// Line 29:        Token.mint(_owner, _owner, $THIS_SYMBOL, amount);
	ALIAS r4 $methodcallexpression175 // 609
	COPY $amount r5 // 609
	PUSH r5 // 612
	ALIAS r5 $literalexpression183 // 614
	LOAD $literalexpression183 "STKNN" // 614
	PUSH $literalexpression183 // 623
	COPY $_owner r5 // 625
	PUSH r5 // 628
	COPY $_owner r5 // 630
	PUSH r5 // 633
	LOAD $methodcallexpression175 "Runtime.MintTokens" // 635
	EXTCALL $methodcallexpression175 // 657
@exit_mint: // 659
RET // 660
// Line 30:    }

// ********* transfer Method ***********
@entry_transfer: // 661
// Line 31:
// Line 32:    public transfer(from:address,to:address,amount:number){
ALIAS r1 $from // 662
POP $from // 662
PUSH $from // 664
EXTCALL "Address()" // 666
POP $from // 681
ALIAS r2 $to // 683
POP $to // 683
PUSH $to // 685
EXTCALL "Address()" // 687
POP $to // 702
ALIAS r3 $amount // 704
POP $amount // 704
CAST $amount $amount #Number // 706
// Line 33:        Runtime.expect(Runtime.isWitness(from),"Improper verification");
	ALIAS r4 $methodcallexpression197 // 710
	COPY $from r5 // 710
	PUSH r5 // 713
	LOAD $methodcallexpression197 "Runtime.IsWitness" // 715
	EXTCALL $methodcallexpression197 // 736
	POP $methodcallexpression197 // 738
	JMPIF $methodcallexpression197 @expect_methodcallexpression194 // 740
	ALIAS r5 $literalexpression200 // 744
	LOAD $literalexpression200 "Improper verification" // 744
	THROW $literalexpression200 // 769
	@expect_methodcallexpression194: NOP // 772
// Line 34:        local singleToken: number = 10^Token.getDecimals($THIS_SYMBOL);
	ALIAS r4 $singleToken // 772
	ALIAS r5 $literalexpression201 // 772
	LOAD $literalexpression201 10 // 772
	ALIAS r6 $methodcallexpression202 // 777
	ALIAS r7 $literalexpression205 // 777
	LOAD $literalexpression205 "STKNN" // 777
	PUSH $literalexpression205 // 786
	LOAD $methodcallexpression202 "Runtime.GetTokenDecimals" // 788
	EXTCALL $methodcallexpression202 // 816
	POP $methodcallexpression202 // 818
	POW $literalexpression201 $methodcallexpression202 r7 // 820
	COPY r7 $singleToken // 824
// Line 35:        amount = amount * singleToken;
	COPY $amount r5 // 827
	COPY $singleToken r6 // 830
	MUL r5 r6 r7 // 833
	COPY r7 $amount // 837
// Line 36:        Token.transfer(from,to,$THIS_SYMBOL,amount);
	ALIAS r5 $methodcallexpression214 // 840
	COPY $amount r6 // 840
	PUSH r6 // 843
	ALIAS r6 $literalexpression222 // 845
	LOAD $literalexpression222 "STKNN" // 845
	PUSH $literalexpression222 // 854
	COPY $to r6 // 856
	PUSH r6 // 859
	COPY $from r6 // 861
	PUSH r6 // 864
	LOAD $methodcallexpression214 "Runtime.TransferTokens" // 866
	EXTCALL $methodcallexpression214 // 892
@exit_transfer: // 894
RET // 895
// Line 37:    }

// ********* onUpgrade Trigger ***********
@entry_onUpgrade: // 896
ALIAS r1 $dataGet // 897
LOAD $dataGet "Data.Get" // 897
ALIAS r2 $contractName // 909
LOAD $contractName "STKNN" // 909
ALIAS r3 $_owner // 918
// reading global: _owner
LOAD r0 8 // 918
PUSH r0 // 923
LOAD r0 "_owner" // 925
PUSH r0 // 935
PUSH $contractName // 937
EXTCALL $dataGet // 939
POP $_owner // 941
PUSH $_owner // 943
EXTCALL "Address()" // 945
POP $_owner // 960
// Line 38:
// Line 39:    trigger onUpgrade(from:address){
ALIAS r1 $from // 962
POP $from // 962
PUSH $from // 964
EXTCALL "Address()" // 966
POP $from // 981
// Line 40:        Runtime.expect(Runtime.isWitness(_owner),"Invalid verification.Dust yourself off and try again.");
	ALIAS r2 $methodcallexpression232 // 983
	COPY $_owner r4 // 983
	PUSH r4 // 986
	LOAD $methodcallexpression232 "Runtime.IsWitness" // 988
	EXTCALL $methodcallexpression232 // 1009
	POP $methodcallexpression232 // 1011
	JMPIF $methodcallexpression232 @expect_methodcallexpression229 // 1013
	ALIAS r4 $literalexpression235 // 1017
	LOAD $literalexpression235 "Invalid verification.Dust yourself off and try again." // 1017
	THROW $literalexpression235 // 1074
	@expect_methodcallexpression229: NOP // 1077
@exit_onUpgrade: // 1077
RET // 1078
// Line 41:    }

// ********* onBurn Trigger ***********
@entry_onBurn: // 1079
// Line 42:    trigger onBurn(from:address, to:address, symbol:string, tokenID:number){
ALIAS r1 $from // 1080
POP $from // 1080
PUSH $from // 1082
EXTCALL "Address()" // 1084
POP $from // 1099
ALIAS r2 $to // 1101
POP $to // 1101
PUSH $to // 1103
EXTCALL "Address()" // 1105
POP $to // 1120
ALIAS r3 $symbol // 1122
POP $symbol // 1122
ALIAS r4 $tokenID // 1124
POP $tokenID // 1124
CAST $tokenID $tokenID #Number // 1126
// Line 43:         Runtime.expect(Runtime.isWitness(from),"Improper verification");
	ALIAS r5 $methodcallexpression250 // 1130
	COPY $from r6 // 1130
	PUSH r6 // 1133
	LOAD $methodcallexpression250 "Runtime.IsWitness" // 1135
	EXTCALL $methodcallexpression250 // 1156
	POP $methodcallexpression250 // 1158
	JMPIF $methodcallexpression250 @expect_methodcallexpression247 // 1160
	ALIAS r6 $literalexpression253 // 1164
	LOAD $literalexpression253 "Improper verification" // 1164
	THROW $literalexpression253 // 1189
	@expect_methodcallexpression247: NOP // 1192
@exit_onBurn: // 1192
RET // 1193
// Line 44:    }

// ********* onMint Trigger ***********
@entry_onMint: // 1194
ALIAS r1 $dataGet // 1195
LOAD $dataGet "Data.Get" // 1195
ALIAS r2 $contractName // 1207
LOAD $contractName "STKNN" // 1207
ALIAS r3 $_owner // 1216
// reading global: _owner
LOAD r0 8 // 1216
PUSH r0 // 1221
LOAD r0 "_owner" // 1223
PUSH r0 // 1233
PUSH $contractName // 1235
EXTCALL $dataGet // 1237
POP $_owner // 1239
PUSH $_owner // 1241
EXTCALL "Address()" // 1243
POP $_owner // 1258
// Line 45:    trigger onMint(from:address, to:address, symbol:string, tokenID:number){
ALIAS r1 $from // 1260
POP $from // 1260
PUSH $from // 1262
EXTCALL "Address()" // 1264
POP $from // 1279
ALIAS r2 $to // 1281
POP $to // 1281
PUSH $to // 1283
EXTCALL "Address()" // 1285
POP $to // 1300
ALIAS r4 $symbol // 1302
POP $symbol // 1302
ALIAS r5 $tokenID // 1304
POP $tokenID // 1304
CAST $tokenID $tokenID #Number // 1306
// Line 46:        Runtime.expect(Runtime.isWitness(_owner),"Improper verification");
	ALIAS r6 $methodcallexpression268 // 1310
	COPY $_owner r7 // 1310
	PUSH r7 // 1313
	LOAD $methodcallexpression268 "Runtime.IsWitness" // 1315
	EXTCALL $methodcallexpression268 // 1336
	POP $methodcallexpression268 // 1338
	JMPIF $methodcallexpression268 @expect_methodcallexpression265 // 1340
	ALIAS r7 $literalexpression271 // 1344
	LOAD $literalexpression271 "Improper verification" // 1344
	THROW $literalexpression271 // 1369
	@expect_methodcallexpression265: NOP // 1372
@exit_onMint: // 1372
RET // 1373
// Line 47:
// Line 48:    }

// ********* onSend Trigger ***********
@entry_onSend: // 1374
// Line 49:
// Line 50:    trigger onSend(from:address, to:address, symbol:string, amount:number){
ALIAS r1 $from // 1375
POP $from // 1375
PUSH $from // 1377
EXTCALL "Address()" // 1379
POP $from // 1394
ALIAS r2 $to // 1396
POP $to // 1396
PUSH $to // 1398
EXTCALL "Address()" // 1400
POP $to // 1415
ALIAS r3 $symbol // 1417
POP $symbol // 1417
ALIAS r4 $amount // 1419
POP $amount // 1419
CAST $amount $amount #Number // 1421
// Line 51:        Runtime.expect(Runtime.isWitness(from),"Improper verification");
	ALIAS r5 $methodcallexpression286 // 1425
	COPY $from r6 // 1425
	PUSH r6 // 1428
	LOAD $methodcallexpression286 "Runtime.IsWitness" // 1430
	EXTCALL $methodcallexpression286 // 1451
	POP $methodcallexpression286 // 1453
	JMPIF $methodcallexpression286 @expect_methodcallexpression283 // 1455
	ALIAS r6 $literalexpression289 // 1459
	LOAD $literalexpression289 "Improper verification" // 1459
	THROW $literalexpression289 // 1484
	@expect_methodcallexpression283: NOP // 1487
@exit_onSend: // 1487
RET // 1488
// Line 52:
// Line 53:    }

// ********* onReceive Trigger ***********
@entry_onReceive: // 1489
// Line 54:    trigger onReceive(from:address, to:address, symbol:string, amount:number){
ALIAS r1 $from // 1490
POP $from // 1490
PUSH $from // 1492
EXTCALL "Address()" // 1494
POP $from // 1509
ALIAS r2 $to // 1511
POP $to // 1511
PUSH $to // 1513
EXTCALL "Address()" // 1515
POP $to // 1530
ALIAS r3 $symbol // 1532
POP $symbol // 1532
ALIAS r4 $amount // 1534
POP $amount // 1534
CAST $amount $amount #Number // 1536
@exit_onReceive: // 1540
RET // 1541
