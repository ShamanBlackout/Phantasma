// Line 1:
// Line 2:contract provingground{
// Line 3: 
// Line 4:    import Runtime;
// Line 5:    import Oracle;
// Line 6:    import Mail;
// Line 7:    import Hash;
// Line 8:
// Line 9:    global _owner: address;

// ********* Initialize Constructor ***********
@entry_constructor: // 0
ALIAS r1 $nexus_protocol_version // 1
// validate protocol version
LOAD r0 "Runtime.Version" // 1
EXTCALL r0 // 20
POP r0 // 22
LOAD $nexus_protocol_version 8 // 24
LT r0 $nexus_protocol_version r0 // 29
JMPNOT r0 @protocol_version_validated // 33
LOAD r0 "Current nexus protocol version should be 8 or more" // 37
THROW r0 // 91
@protocol_version_validated: NOP // 94
ALIAS r1 $_owner // 94
// Line 10:
// Line 11:    constructor(owner:address){
ALIAS r2 $owner // 94
POP $owner // 94
PUSH $owner // 96
EXTCALL "Address()" // 98
POP $owner // 113
// Line 12:        _owner = owner;
	COPY $owner r3 // 115
	COPY r3 $_owner // 118
@exit_constructor: // 121
LOAD r2 "Data.Set" // 122
// writing global: _owner
PUSH $_owner // 134
LOAD r0 "_owner" // 136
PUSH r0 // 146
EXTCALL r2 // 148
RET // 150
// Line 13:    }

// ********* testHash Method ***********
@entry_testHash: // 151
// Line 14:
// Line 15:    public testHash(test_hash: string): string{
ALIAS r1 $test_hash // 152
POP $test_hash // 152
// Line 16:        local tx_hash = #DBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C;
	ALIAS r2 $tx_hash // 154
	ALIAS r3 $literalexpression95 // 154
	LOAD $literalexpression95 0xDBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C // 154
	PUSH $literalexpression95 // 190
	EXTCALL "Hash()" // 192
	POP $literalexpression95 // 204
	COPY $literalexpression95 $tx_hash // 206
// Line 17:        return tx_hash.toString();
	COPY $tx_hash r3 // 209
	CAST r3 r3 #String // 212
	PUSH r3 // 216
	JMP @exit_testHash // 218
@exit_testHash: // 221
RET // 222
// Line 18:    }

// ********* testHash2 Method ***********
@entry_testHash2: // 223
// Line 19:    public testHash2():hash {
// Line 20:        local tx_hash = #DBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C;
	ALIAS r1 $tx_hash // 224
	ALIAS r2 $literalexpression104 // 224
	LOAD $literalexpression104 0xDBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C // 224
	PUSH $literalexpression104 // 260
	EXTCALL "Hash()" // 262
	POP $literalexpression104 // 274
	COPY $literalexpression104 $tx_hash // 276
// Line 21:
// Line 22:        return tx_hash;
	COPY $tx_hash r2 // 279
	PUSH r2 // 282
	JMP @exit_testHash2 // 284
@exit_testHash2: // 287
RET // 288
// Line 23:    }

// ********* checkPrice Method ***********
@entry_checkPrice: // 289
// Line 24:
// Line 25:    /************************************************************************************************
// Line 26:    Not sure how to use Oracles yet. Plan was to use Oracles to check price of given token
// Line 27:    and return that token.
// Line 28:    ************************************************************************************************/
// Line 29:    public checkPrice(symbol: string):number{
ALIAS r1 $symbol // 290
POP $symbol // 290
// Line 30:        local price: number = Oracle.price(symbol);
	ALIAS r2 $price // 292
	ALIAS r3 $methodcallexpression113 // 292
	COPY $symbol r4 // 292
	PUSH r4 // 295
	LOAD $methodcallexpression113 "Oracle.Price" // 297
	EXTCALL $methodcallexpression113 // 313
	COPY $methodcallexpression113 $price // 315
// Line 31:        return price;
	COPY $price r3 // 318
	PUSH r3 // 321
	JMP @exit_checkPrice // 323
@exit_checkPrice: // 326
RET // 327
// Line 32:    }

// ********* sendMsg Method ***********
@entry_sendMsg: // 328
// Line 33:
// Line 34:    public sendMsg(from:address, target:address, archiveHash:hash){
ALIAS r1 $from // 329
POP $from // 329
PUSH $from // 331
EXTCALL "Address()" // 333
POP $from // 348
ALIAS r2 $target // 350
POP $target // 350
PUSH $target // 352
EXTCALL "Address()" // 354
POP $target // 369
ALIAS r3 $archiveHash // 371
POP $archiveHash // 371
PUSH $archiveHash // 373
EXTCALL "Hash()" // 375
POP $archiveHash // 387
// Line 35:        local tx_hash = #DBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C;
	ALIAS r4 $tx_hash // 389
	ALIAS r5 $literalexpression128 // 389
	LOAD $literalexpression128 0xDBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C // 389
	PUSH $literalexpression128 // 425
	EXTCALL "Hash()" // 427
	POP $literalexpression128 // 439
	COPY $literalexpression128 $tx_hash // 441
// Line 36:        Mail.pushMessage(from, target, tx_hash);
	ALIAS r5 $methodcallexpression132 // 444
	COPY $tx_hash r6 // 444
	PUSH r6 // 447
	COPY $target r6 // 449
	PUSH r6 // 452
	COPY $from r6 // 454
	PUSH r6 // 457
	LOAD $methodcallexpression132 "PushMessage" // 459
	PUSH $methodcallexpression132 // 474
	LOAD $methodcallexpression132 "mail" // 476
	CTX $methodcallexpression132 $methodcallexpression132 // 484
	SWITCH $methodcallexpression132 // 487
@exit_sendMsg: // 489
RET // 490
// Line 37:    }

// ********* testAllTypes Method ***********
@entry_testAllTypes: // 491
// Line 38:
// Line 39:    //deprecated since Hash has issues
// Line 40:    public testAllTypes(str:string, truthy:bool,num:number,stamp:timestamp,bytArr:bytes,addy:address,hashish: hash): string{
ALIAS r1 $str // 492
POP $str // 492
ALIAS r2 $truthy // 494
POP $truthy // 494
ALIAS r3 $num // 496
POP $num // 496
CAST $num $num #Number // 498
ALIAS r4 $stamp // 502
POP $stamp // 502
PUSH $stamp // 504
EXTCALL "Timestamp()" // 506
POP $stamp // 523
ALIAS r5 $bytArr // 525
POP $bytArr // 525
ALIAS r6 $addy // 527
POP $addy // 527
PUSH $addy // 529
EXTCALL "Address()" // 531
POP $addy // 546
ALIAS r7 $hashish // 548
POP $hashish // 548
PUSH $hashish // 550
EXTCALL "Hash()" // 552
POP $hashish // 564
// Line 41:
// Line 42:        local type_str ="Type of str: " +$TYPE_OF(str) + " Type of truthy: " +$TYPE_OF(truthy) +" Type of stamp: " +$TYPE_OF(stamp) +" Type of bytArr: " +$TYPE_OF(bytArr) + " Type of addy: " +$TYPE_OF(addy) +" Type of num: " +$TYPE_OF(num);
	ALIAS r8 $type_str // 566
	ALIAS r9 $literalexpression155 // 566
	LOAD $literalexpression155 "Type of str: " // 566
	ALIAS r10 $literalexpression157 // 583
	LOAD $literalexpression157 4 Enum // 583
	CAST $literalexpression157 $literalexpression157 #String // 591
	ADD $literalexpression155 $literalexpression157 r11 // 595
	ALIAS r9 $literalexpression160 // 599
	LOAD $literalexpression160 " Type of truthy: " // 599
	ALIAS r10 $literalexpression162 // 620
	LOAD $literalexpression162 6 Enum // 620
	CAST $literalexpression162 $literalexpression162 #String // 628
	ADD $literalexpression160 $literalexpression162 r12 // 632
	ALIAS r9 $literalexpression165 // 636
	LOAD $literalexpression165 " Type of stamp: " // 636
	ALIAS r10 $literalexpression167 // 656
	LOAD $literalexpression167 5 Enum // 656
	CAST $literalexpression167 $literalexpression167 #String // 664
	ADD $literalexpression165 $literalexpression167 r13 // 668
	ALIAS r9 $literalexpression170 // 672
	LOAD $literalexpression170 " Type of bytArr: " // 672
	ALIAS r10 $literalexpression172 // 693
	LOAD $literalexpression172 2 Enum // 693
	CAST $literalexpression172 $literalexpression172 #String // 701
	ADD $literalexpression170 $literalexpression172 r14 // 705
	ALIAS r9 $literalexpression175 // 709
	LOAD $literalexpression175 " Type of addy: " // 709
	ALIAS r10 $literalexpression177 // 728
	LOAD $literalexpression177 8 Enum // 728
	CAST $literalexpression177 $literalexpression177 #String // 736
	ADD $literalexpression175 $literalexpression177 r15 // 740
	ALIAS r9 $literalexpression180 // 744
	LOAD $literalexpression180 " Type of num: " // 744
	ALIAS r10 $literalexpression182 // 762
	LOAD $literalexpression182 3 Enum // 762
	CAST $literalexpression182 $literalexpression182 #String // 770
	ADD $literalexpression180 $literalexpression182 r16 // 774
	ADD r15 r16 r9 // 778
	ADD r14 r9 r10 // 782
	ADD r13 r10 r9 // 786
	ADD r12 r9 r10 // 790
	ADD r11 r10 r9 // 794
	COPY r9 $type_str // 798
// Line 43:        return type_str;
	COPY $type_str r9 // 801
	PUSH r9 // 804
	JMP @exit_testAllTypes // 806
@exit_testAllTypes: // 809
RET // 810
// Line 44:    }

// ********* testAllTypes2 Method ***********
@entry_testAllTypes2: // 811
// Line 45:
// Line 46:    public testAllTypes2(str:string, truthy:bool,num:number,stamp:timestamp,bytArr:bytes,addy:address): string{
ALIAS r1 $str // 812
POP $str // 812
ALIAS r2 $truthy // 814
POP $truthy // 814
ALIAS r3 $num // 816
POP $num // 816
CAST $num $num #Number // 818
ALIAS r4 $stamp // 822
POP $stamp // 822
PUSH $stamp // 824
EXTCALL "Timestamp()" // 826
POP $stamp // 843
ALIAS r5 $bytArr // 845
POP $bytArr // 845
ALIAS r6 $addy // 847
POP $addy // 847
PUSH $addy // 849
EXTCALL "Address()" // 851
POP $addy // 866
// Line 47:
// Line 48:        local type_str ="Type of str: " +$TYPE_OF(str) + " Type of truthy: " +$TYPE_OF(truthy) +" Type of stamp: " +$TYPE_OF(stamp) +" Type of bytArr: " +$TYPE_OF(bytArr) + " Type of addy: " +$TYPE_OF(addy) +" Type of num: " +$TYPE_OF(num);
	ALIAS r7 $type_str // 868
	ALIAS r8 $literalexpression208 // 868
	LOAD $literalexpression208 "Type of str: " // 868
	ALIAS r9 $literalexpression210 // 885
	LOAD $literalexpression210 4 Enum // 885
	CAST $literalexpression210 $literalexpression210 #String // 893
	ADD $literalexpression208 $literalexpression210 r10 // 897
	ALIAS r8 $literalexpression213 // 901
	LOAD $literalexpression213 " Type of truthy: " // 901
	ALIAS r9 $literalexpression215 // 922
	LOAD $literalexpression215 6 Enum // 922
	CAST $literalexpression215 $literalexpression215 #String // 930
	ADD $literalexpression213 $literalexpression215 r11 // 934
	ALIAS r8 $literalexpression218 // 938
	LOAD $literalexpression218 " Type of stamp: " // 938
	ALIAS r9 $literalexpression220 // 958
	LOAD $literalexpression220 5 Enum // 958
	CAST $literalexpression220 $literalexpression220 #String // 966
	ADD $literalexpression218 $literalexpression220 r12 // 970
	ALIAS r8 $literalexpression223 // 974
	LOAD $literalexpression223 " Type of bytArr: " // 974
	ALIAS r9 $literalexpression225 // 995
	LOAD $literalexpression225 2 Enum // 995
	CAST $literalexpression225 $literalexpression225 #String // 1003
	ADD $literalexpression223 $literalexpression225 r13 // 1007
	ALIAS r8 $literalexpression228 // 1011
	LOAD $literalexpression228 " Type of addy: " // 1011
	ALIAS r9 $literalexpression230 // 1030
	LOAD $literalexpression230 8 Enum // 1030
	CAST $literalexpression230 $literalexpression230 #String // 1038
	ADD $literalexpression228 $literalexpression230 r14 // 1042
	ALIAS r8 $literalexpression233 // 1046
	LOAD $literalexpression233 " Type of num: " // 1046
	ALIAS r9 $literalexpression235 // 1064
	LOAD $literalexpression235 3 Enum // 1064
	CAST $literalexpression235 $literalexpression235 #String // 1072
	ADD $literalexpression233 $literalexpression235 r15 // 1076
	ADD r14 r15 r8 // 1080
	ADD r13 r8 r9 // 1084
	ADD r12 r9 r8 // 1088
	ADD r11 r8 r9 // 1092
	ADD r10 r9 r8 // 1096
	COPY r8 $type_str // 1100
// Line 49:        return type_str;
	COPY $type_str r8 // 1103
	PUSH r8 // 1106
	JMP @exit_testAllTypes2 // 1108
@exit_testAllTypes2: // 1111
RET // 1112
// Line 50:    }

// ********* decimalTest Method ***********
@entry_decimalTest: // 1113
// Line 51:   
// Line 52:   /*****************************************************
// Line 53:    Not yet finished
// Line 54:   ******************************************************/
// Line 55:    public decimalTest(digits:number){
ALIAS r1 $digits // 1114
POP $digits // 1114
CAST $digits $digits #Number // 1116
@exit_decimalTest: // 1120
RET // 1121
// Line 56:        //local val: decimal<digits>; appears that it is no possible to dynamically assign a decimal digit
// Line 57:
// Line 58:    }

// ********* logTest Method ***********
@entry_logTest: // 1122
// Line 59:    /********************************************
// Line 60:    Log messages are shown under vm.txt within 
// Line 61:    docker
// Line 62:    *********************************************/
// Line 63:    public logTest(){
// Line 64:        Runtime.log("Testing");
	ALIAS r1 $methodcallexpression254 // 1123
	ALIAS r2 $literalexpression256 // 1123
	LOAD $literalexpression256 "Testing" // 1123
	PUSH $literalexpression256 // 1134
	LOAD $methodcallexpression254 "Runtime.Log" // 1136
	EXTCALL $methodcallexpression254 // 1151
@exit_logTest: // 1153
RET // 1154
// Line 65:    }

// ********* register Method ***********
@entry_register: // 1155
// Line 66:
// Line 67:
// Line 68:    public register(from:address,domainName: string)
ALIAS r1 $from // 1156
POP $from // 1156
PUSH $from // 1158
EXTCALL "Address()" // 1160
POP $from // 1175
ALIAS r2 $domainName // 1177
POP $domainName // 1177
// Line 69:    {   
// Line 70:        Runtime.expect(Runtime.isWitness(from),"Invalid Witness");
	ALIAS r3 $methodcallexpression267 // 1179
	COPY $from r4 // 1179
	PUSH r4 // 1182
	LOAD $methodcallexpression267 "Runtime.IsWitness" // 1184
	EXTCALL $methodcallexpression267 // 1205
	POP $methodcallexpression267 // 1207
	JMPIF $methodcallexpression267 @expect_methodcallexpression264 // 1209
	ALIAS r4 $literalexpression270 // 1213
	LOAD $literalexpression270 "Invalid Witness" // 1213
	THROW $literalexpression270 // 1232
	@expect_methodcallexpression264: NOP // 1235
// Line 71:        Mail.registerDomain(from,domainName);
	ALIAS r3 $methodcallexpression272 // 1235
	COPY $domainName r4 // 1235
	PUSH r4 // 1238
	COPY $from r4 // 1240
	PUSH r4 // 1243
	LOAD $methodcallexpression272 "RegisterDomain" // 1245
	PUSH $methodcallexpression272 // 1263
	LOAD $methodcallexpression272 "mail" // 1265
	CTX $methodcallexpression272 $methodcallexpression272 // 1273
	SWITCH $methodcallexpression272 // 1276
@exit_register: // 1278
RET // 1279
// Line 72:
// Line 73:    }

// ********* testBool Method ***********
@entry_testBool: // 1280
// Line 74:
// Line 75:    public testBool(bRole:bool):type{
ALIAS r1 $bRole // 1281
POP $bRole // 1281
// Line 76:    
// Line 77:
// Line 78:        return $TYPE_OF(bRole);
	ALIAS r2 $literalexpression282 // 1283
	LOAD $literalexpression282 6 Enum // 1283
	PUSH $literalexpression282 // 1291
	JMP @exit_testBool // 1293
@exit_testBool: // 1296
RET // 1297
// Line 79:        
// Line 80:    }

// ********* domainExist Method ***********
@entry_domainExist: // 1298
// Line 81:
// Line 82:    public domainExist(domainName:string): bool{
ALIAS r1 $domainName // 1299
POP $domainName // 1299
// Line 83:
// Line 84:        return Mail.domainExists(domainName);
	ALIAS r2 $methodcallexpression288 // 1301
	COPY $domainName r3 // 1301
	PUSH r3 // 1304
	LOAD $methodcallexpression288 "DomainExists" // 1306
	PUSH $methodcallexpression288 // 1322
	LOAD $methodcallexpression288 "mail" // 1324
	CTX $methodcallexpression288 $methodcallexpression288 // 1332
	SWITCH $methodcallexpression288 // 1335
	POP $methodcallexpression288 // 1337
	PUSH $methodcallexpression288 // 1339
	JMP @exit_domainExist // 1341
@exit_domainExist: // 1344
RET // 1345
// Line 85:    }

// ********* quotePrice Method ***********
@entry_quotePrice: // 1346
// Line 86:
// Line 87:    public quotePrice(baseSymbol:string, quoteSymbol:string, amount:number): number {
ALIAS r1 $baseSymbol // 1347
POP $baseSymbol // 1347
ALIAS r2 $quoteSymbol // 1349
POP $quoteSymbol // 1349
ALIAS r3 $amount // 1351
POP $amount // 1351
CAST $amount $amount #Number // 1353
// Line 88:        local qu: number = Oracle.quote(baseSymbol,quoteSymbol,amount);
	ALIAS r4 $qu // 1357
	ALIAS r5 $methodcallexpression300 // 1357
	COPY $amount r6 // 1357
	PUSH r6 // 1360
	COPY $quoteSymbol r6 // 1362
	PUSH r6 // 1365
	COPY $baseSymbol r6 // 1367
	PUSH r6 // 1370
	LOAD $methodcallexpression300 "Oracle.Quote" // 1372
	EXTCALL $methodcallexpression300 // 1388
	COPY $methodcallexpression300 $qu // 1390
// Line 89:       return qu;
	COPY $qu r5 // 1393
	PUSH r5 // 1396
	JMP @exit_quotePrice // 1398
@exit_quotePrice: // 1401
RET // 1402
// Line 90:    }

// ********* onUpgrade Trigger ***********
@entry_onUpgrade: // 1403
ALIAS r1 $dataGet // 1404
LOAD $dataGet "Data.Get" // 1404
ALIAS r2 $contractName // 1416
LOAD $contractName "provingground" // 1416
ALIAS r3 $_owner // 1433
// reading global: _owner
LOAD r0 8 // 1433
PUSH r0 // 1438
LOAD r0 "_owner" // 1440
PUSH r0 // 1450
PUSH $contractName // 1452
EXTCALL $dataGet // 1454
POP $_owner // 1456
PUSH $_owner // 1458
EXTCALL "Address()" // 1460
POP $_owner // 1475
// Line 91:
// Line 92:    trigger onUpgrade(from:address)
ALIAS r1 $from // 1477
POP $from // 1477
PUSH $from // 1479
EXTCALL "Address()" // 1481
POP $from // 1496
// Line 93:    {
// Line 94:        Runtime.expect(Runtime.isWitness(_owner), "Only the owner can update");
	ALIAS r2 $methodcallexpression319 // 1498
	COPY $_owner r4 // 1498
	PUSH r4 // 1501
	LOAD $methodcallexpression319 "Runtime.IsWitness" // 1503
	EXTCALL $methodcallexpression319 // 1524
	POP $methodcallexpression319 // 1526
	JMPIF $methodcallexpression319 @expect_methodcallexpression316 // 1528
	ALIAS r4 $literalexpression322 // 1532
	LOAD $literalexpression322 "Only the owner can update" // 1532
	THROW $literalexpression322 // 1561
	@expect_methodcallexpression316: NOP // 1564
// Line 95:        return;
	JMP @exit_onUpgrade // 1564
@exit_onUpgrade: // 1567
RET // 1568
// Line 96:    }

// ********* onKill Trigger ***********
@entry_onKill: // 1569
ALIAS r1 $dataGet // 1570
LOAD $dataGet "Data.Get" // 1570
ALIAS r2 $contractName // 1582
LOAD $contractName "provingground" // 1582
ALIAS r3 $_owner // 1599
// reading global: _owner
LOAD r0 8 // 1599
PUSH r0 // 1604
LOAD r0 "_owner" // 1606
PUSH r0 // 1616
PUSH $contractName // 1618
EXTCALL $dataGet // 1620
POP $_owner // 1622
PUSH $_owner // 1624
EXTCALL "Address()" // 1626
POP $_owner // 1641
// Line 97:    
// Line 98:    trigger onKill(from:address){
ALIAS r1 $from // 1643
POP $from // 1643
PUSH $from // 1645
EXTCALL "Address()" // 1647
POP $from // 1662
// Line 99:        Runtime.expect(Runtime.isWitness(_owner), "Only the owner can delete");
	ALIAS r2 $methodcallexpression332 // 1664
	COPY $_owner r4 // 1664
	PUSH r4 // 1667
	LOAD $methodcallexpression332 "Runtime.IsWitness" // 1669
	EXTCALL $methodcallexpression332 // 1690
	POP $methodcallexpression332 // 1692
	JMPIF $methodcallexpression332 @expect_methodcallexpression329 // 1694
	ALIAS r4 $literalexpression335 // 1698
	LOAD $literalexpression335 "Only the owner can delete" // 1698
	THROW $literalexpression335 // 1727
	@expect_methodcallexpression329: NOP // 1730
// Line 100:        return;
	JMP @exit_onKill // 1730
@exit_onKill: // 1733
RET // 1734
