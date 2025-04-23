// Line 1:/**********************************************************
// Line 2:Creator: Shaman Blackout
// Line 3:
// Line 4:Purpose: A smart contract that is used for testing purposes
// Line 5:only. Test out different functionality of TOMB in an effort
// Line 6:to understand how everything works.
// Line 7:
// Line 8:**********************************************************/
// Line 9:contract provingground{
// Line 10: 
// Line 11:    import Runtime;
// Line 12:    import Oracle;
// Line 13:    import Mail;
// Line 14:    import Number;
// Line 15:    import String;
// Line 16:    import Array;   
// Line 17:    import Hash; 
// Line 18:    global _owner: address;

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
// Line 19:
// Line 20:    constructor(owner:address){
ALIAS r2 $owner // 94
POP $owner // 94
PUSH $owner // 96
EXTCALL "Address()" // 98
POP $owner // 113
// Line 21:        _owner = owner;
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
// Line 22:    }

// ********* testHash Method ***********
@entry_testHash: // 151
// Line 23:
// Line 24:    public testHash(test_hash: string): string{
ALIAS r1 $test_hash // 152
POP $test_hash // 152
// Line 25:        local tx_hash = #DBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C;
	ALIAS r2 $tx_hash // 154
	ALIAS r3 $literalexpression124 // 154
	LOAD $literalexpression124 0xDBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C // 154
	PUSH $literalexpression124 // 190
	EXTCALL "Hash()" // 192
	POP $literalexpression124 // 204
	COPY $literalexpression124 $tx_hash // 206
// Line 26:        return tx_hash.toString();
	COPY $tx_hash r3 // 209
	CAST r3 r3 #String // 212
	PUSH r3 // 216
	JMP @exit_testHash // 218
@exit_testHash: // 221
RET // 222
// Line 27:    }

// ********* testHash2 Method ***********
@entry_testHash2: // 223
// Line 28:    public testHash2():hash {
// Line 29:        local tx_hash = #0xDBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C;
	ALIAS r1 $tx_hash // 224
	ALIAS r2 $literalexpression133 // 224
	LOAD $literalexpression133 0xDBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C // 224
	PUSH $literalexpression133 // 260
	EXTCALL "Hash()" // 262
	POP $literalexpression133 // 274
	COPY $literalexpression133 $tx_hash // 276
// Line 30:
// Line 31:        return tx_hash;
	COPY $tx_hash r2 // 279
	PUSH r2 // 282
	JMP @exit_testHash2 // 284
@exit_testHash2: // 287
RET // 288
// Line 32:    }

// ********* checkPrice Method ***********
@entry_checkPrice: // 289
// Line 33:
// Line 34:    /************************************************************************************************
// Line 35:    Not sure how to use Oracles yet. Plan was to use Oracles to check price of given token
// Line 36:    and return that token.
// Line 37:    ************************************************************************************************/
// Line 38:    public checkPrice(symbol: string):number{
ALIAS r1 $symbol // 290
POP $symbol // 290
// Line 39:        local price: number = Oracle.price(symbol);
	ALIAS r2 $price // 292
	ALIAS r3 $methodcallexpression142 // 292
	COPY $symbol r4 // 292
	PUSH r4 // 295
	LOAD $methodcallexpression142 "Oracle.Price" // 297
	EXTCALL $methodcallexpression142 // 313
	COPY $methodcallexpression142 $price // 315
// Line 40:        return price;
	COPY $price r3 // 318
	PUSH r3 // 321
	JMP @exit_checkPrice // 323
@exit_checkPrice: // 326
RET // 327
// Line 41:    }

// ********* convToString Method ***********
@entry_convToString: // 328
// Line 42:    public convToString(addy:address):string{
ALIAS r1 $addy // 329
POP $addy // 329
PUSH $addy // 331
EXTCALL "Address()" // 333
POP $addy // 348
// Line 43:        local addr_string:string = addy;
	ALIAS r2 $addr_string // 350
	COPY $addy r3 // 350
	COPY r3 $addr_string // 353
// Line 44:        local retStr:string = "Address: " + addr_string;// + " is of type" + $TYPE_OF(addr_string);
	ALIAS r3 $retStr // 356
	ALIAS r4 $literalexpression156 // 356
	LOAD $literalexpression156 "Address: " // 356
	COPY $addr_string r5 // 369
	ADD $literalexpression156 r5 r6 // 372
	COPY r6 $retStr // 376
// Line 45:        return retStr;
	COPY $retStr r4 // 379
	PUSH r4 // 382
	JMP @exit_convToString // 384
@exit_convToString: // 387
RET // 388
// Line 46:
// Line 47:
// Line 48:    }

// ********* sendMsg Method ***********
@entry_sendMsg: // 389
// Line 49:
// Line 50:    public sendMsg(from:address, target:address, archiveHash:hash){
ALIAS r1 $from // 390
POP $from // 390
PUSH $from // 392
EXTCALL "Address()" // 394
POP $from // 409
ALIAS r2 $target // 411
POP $target // 411
PUSH $target // 413
EXTCALL "Address()" // 415
POP $target // 430
ALIAS r3 $archiveHash // 432
POP $archiveHash // 432
PUSH $archiveHash // 434
EXTCALL "Hash()" // 436
POP $archiveHash // 448
// Line 51:        local tx_hash = "DBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C";
	ALIAS r4 $tx_hash // 450
	ALIAS r5 $literalexpression171 // 450
	LOAD $literalexpression171 "DBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C" // 450
	COPY $literalexpression171 $tx_hash // 518
// Line 52:        //archiveHash = Hash.FromString(tx_hash);
// Line 53:        Mail.pushMessage(from, target,archiveHash);
	ALIAS r5 $methodcallexpression175 // 521
	COPY $archiveHash r6 // 521
	PUSH r6 // 524
	COPY $target r6 // 526
	PUSH r6 // 529
	COPY $from r6 // 531
	PUSH r6 // 534
	LOAD $methodcallexpression175 "PushMessage" // 536
	PUSH $methodcallexpression175 // 551
	LOAD $methodcallexpression175 "mail" // 553
	CTX $methodcallexpression175 $methodcallexpression175 // 561
	SWITCH $methodcallexpression175 // 564
@exit_sendMsg: // 566
RET // 567
// Line 54:    }

// ********* testAllTypes Method ***********
@entry_testAllTypes: // 568
// Line 55:
// Line 56:    //deprecated since Hash has issues
// Line 57:    public testAllTypes(str:string, truthy:bool,num:number,stamp:timestamp,bytArr:bytes,addy:address,hashish: hash): string{
ALIAS r1 $str // 569
POP $str // 569
ALIAS r2 $truthy // 571
POP $truthy // 571
ALIAS r3 $num // 573
POP $num // 573
CAST $num $num #Number // 575
ALIAS r4 $stamp // 579
POP $stamp // 579
PUSH $stamp // 581
EXTCALL "Timestamp()" // 583
POP $stamp // 600
ALIAS r5 $bytArr // 602
POP $bytArr // 602
ALIAS r6 $addy // 604
POP $addy // 604
PUSH $addy // 606
EXTCALL "Address()" // 608
POP $addy // 623
ALIAS r7 $hashish // 625
POP $hashish // 625
PUSH $hashish // 627
EXTCALL "Hash()" // 629
POP $hashish // 641
// Line 58:
// Line 59:        local type_str ="Type of str: " +$TYPE_OF(str) + " Type of truthy: " +$TYPE_OF(truthy) +" Type of stamp: " +$TYPE_OF(stamp) +" Type of bytArr: " +$TYPE_OF(bytArr) + " Type of addy: " +$TYPE_OF(addy) +" Type of num: " +$TYPE_OF(num);
	ALIAS r8 $type_str // 643
	ALIAS r9 $literalexpression198 // 643
	LOAD $literalexpression198 "Type of str: " // 643
	ALIAS r10 $literalexpression200 // 660
	LOAD $literalexpression200 4 Enum // 660
	CAST $literalexpression200 $literalexpression200 #String // 668
	ADD $literalexpression198 $literalexpression200 r11 // 672
	ALIAS r9 $literalexpression203 // 676
	LOAD $literalexpression203 " Type of truthy: " // 676
	ALIAS r10 $literalexpression205 // 697
	LOAD $literalexpression205 6 Enum // 697
	CAST $literalexpression205 $literalexpression205 #String // 705
	ADD $literalexpression203 $literalexpression205 r12 // 709
	ALIAS r9 $literalexpression208 // 713
	LOAD $literalexpression208 " Type of stamp: " // 713
	ALIAS r10 $literalexpression210 // 733
	LOAD $literalexpression210 5 Enum // 733
	CAST $literalexpression210 $literalexpression210 #String // 741
	ADD $literalexpression208 $literalexpression210 r13 // 745
	ALIAS r9 $literalexpression213 // 749
	LOAD $literalexpression213 " Type of bytArr: " // 749
	ALIAS r10 $literalexpression215 // 770
	LOAD $literalexpression215 2 Enum // 770
	CAST $literalexpression215 $literalexpression215 #String // 778
	ADD $literalexpression213 $literalexpression215 r14 // 782
	ALIAS r9 $literalexpression218 // 786
	LOAD $literalexpression218 " Type of addy: " // 786
	ALIAS r10 $literalexpression220 // 805
	LOAD $literalexpression220 8 Enum // 805
	CAST $literalexpression220 $literalexpression220 #String // 813
	ADD $literalexpression218 $literalexpression220 r15 // 817
	ALIAS r9 $literalexpression223 // 821
	LOAD $literalexpression223 " Type of num: " // 821
	ALIAS r10 $literalexpression225 // 839
	LOAD $literalexpression225 3 Enum // 839
	CAST $literalexpression225 $literalexpression225 #String // 847
	ADD $literalexpression223 $literalexpression225 r16 // 851
	ADD r15 r16 r9 // 855
	ADD r14 r9 r10 // 859
	ADD r13 r10 r9 // 863
	ADD r12 r9 r10 // 867
	ADD r11 r10 r9 // 871
	COPY r9 $type_str // 875
// Line 60:        return type_str;
	COPY $type_str r9 // 878
	PUSH r9 // 881
	JMP @exit_testAllTypes // 883
@exit_testAllTypes: // 886
RET // 887
// Line 61:    }

// ********* testAllTypes2 Method ***********
@entry_testAllTypes2: // 888
// Line 62:
// Line 63:    public testAllTypes2(str:string, truthy:bool,num:number,stamp:timestamp,bytArr:bytes,addy:address): string{
ALIAS r1 $str // 889
POP $str // 889
ALIAS r2 $truthy // 891
POP $truthy // 891
ALIAS r3 $num // 893
POP $num // 893
CAST $num $num #Number // 895
ALIAS r4 $stamp // 899
POP $stamp // 899
PUSH $stamp // 901
EXTCALL "Timestamp()" // 903
POP $stamp // 920
ALIAS r5 $bytArr // 922
POP $bytArr // 922
ALIAS r6 $addy // 924
POP $addy // 924
PUSH $addy // 926
EXTCALL "Address()" // 928
POP $addy // 943
// Line 64:
// Line 65:        local type_str ="Type of str: " +$TYPE_OF(str) + " Type of truthy: " +$TYPE_OF(truthy) +" Type of stamp: " +$TYPE_OF(stamp) +" Type of bytArr: " +$TYPE_OF(bytArr) + " Type of addy: " +$TYPE_OF(addy) +" Type of num: " +$TYPE_OF(num);
	ALIAS r7 $type_str // 945
	ALIAS r8 $literalexpression251 // 945
	LOAD $literalexpression251 "Type of str: " // 945
	ALIAS r9 $literalexpression253 // 962
	LOAD $literalexpression253 4 Enum // 962
	CAST $literalexpression253 $literalexpression253 #String // 970
	ADD $literalexpression251 $literalexpression253 r10 // 974
	ALIAS r8 $literalexpression256 // 978
	LOAD $literalexpression256 " Type of truthy: " // 978
	ALIAS r9 $literalexpression258 // 999
	LOAD $literalexpression258 6 Enum // 999
	CAST $literalexpression258 $literalexpression258 #String // 1007
	ADD $literalexpression256 $literalexpression258 r11 // 1011
	ALIAS r8 $literalexpression261 // 1015
	LOAD $literalexpression261 " Type of stamp: " // 1015
	ALIAS r9 $literalexpression263 // 1035
	LOAD $literalexpression263 5 Enum // 1035
	CAST $literalexpression263 $literalexpression263 #String // 1043
	ADD $literalexpression261 $literalexpression263 r12 // 1047
	ALIAS r8 $literalexpression266 // 1051
	LOAD $literalexpression266 " Type of bytArr: " // 1051
	ALIAS r9 $literalexpression268 // 1072
	LOAD $literalexpression268 2 Enum // 1072
	CAST $literalexpression268 $literalexpression268 #String // 1080
	ADD $literalexpression266 $literalexpression268 r13 // 1084
	ALIAS r8 $literalexpression271 // 1088
	LOAD $literalexpression271 " Type of addy: " // 1088
	ALIAS r9 $literalexpression273 // 1107
	LOAD $literalexpression273 8 Enum // 1107
	CAST $literalexpression273 $literalexpression273 #String // 1115
	ADD $literalexpression271 $literalexpression273 r14 // 1119
	ALIAS r8 $literalexpression276 // 1123
	LOAD $literalexpression276 " Type of num: " // 1123
	ALIAS r9 $literalexpression278 // 1141
	LOAD $literalexpression278 3 Enum // 1141
	CAST $literalexpression278 $literalexpression278 #String // 1149
	ADD $literalexpression276 $literalexpression278 r15 // 1153
	ADD r14 r15 r8 // 1157
	ADD r13 r8 r9 // 1161
	ADD r12 r9 r8 // 1165
	ADD r11 r8 r9 // 1169
	ADD r10 r9 r8 // 1173
	COPY r8 $type_str // 1177
// Line 66:        return type_str;
	COPY $type_str r8 // 1180
	PUSH r8 // 1183
	JMP @exit_testAllTypes2 // 1185
@exit_testAllTypes2: // 1188
RET // 1189
// Line 67:    }

// ********* decimalTest Method ***********
@entry_decimalTest: // 1190
// Line 68:   
// Line 69:   /*****************************************************
// Line 70:    Not yet finished
// Line 71:   ******************************************************/
// Line 72:    public decimalTest(digits:number){
ALIAS r1 $digits // 1191
POP $digits // 1191
CAST $digits $digits #Number // 1193
@exit_decimalTest: // 1197
RET // 1198
// Line 73:        //local val: decimal<digits>; appears that it is no possible to dynamically assign a decimal digit
// Line 74:
// Line 75:    }

// ********* logTest Method ***********
@entry_logTest: // 1199
// Line 76:    /********************************************
// Line 77:    Log messages are shown under vm.txt within 
// Line 78:    docker
// Line 79:    *********************************************/
// Line 80:    public logTest(){
// Line 81:        Runtime.log("Testing");
	ALIAS r1 $methodcallexpression297 // 1200
	ALIAS r2 $literalexpression299 // 1200
	LOAD $literalexpression299 "Testing" // 1200
	PUSH $literalexpression299 // 1211
	LOAD $methodcallexpression297 "Runtime.Log" // 1213
	EXTCALL $methodcallexpression297 // 1228
@exit_logTest: // 1230
RET // 1231
// Line 82:    }

// ********* register Method ***********
@entry_register: // 1232
// Line 83:
// Line 84:
// Line 85:    public register(from:address,domainName: string)
ALIAS r1 $from // 1233
POP $from // 1233
PUSH $from // 1235
EXTCALL "Address()" // 1237
POP $from // 1252
ALIAS r2 $domainName // 1254
POP $domainName // 1254
// Line 86:    {   
// Line 87:        Runtime.expect(Runtime.isWitness(from),"Invalid Witness");
	ALIAS r3 $methodcallexpression310 // 1256
	COPY $from r4 // 1256
	PUSH r4 // 1259
	LOAD $methodcallexpression310 "Runtime.IsWitness" // 1261
	EXTCALL $methodcallexpression310 // 1282
	POP $methodcallexpression310 // 1284
	JMPIF $methodcallexpression310 @expect_methodcallexpression307 // 1286
	ALIAS r4 $literalexpression313 // 1290
	LOAD $literalexpression313 "Invalid Witness" // 1290
	THROW $literalexpression313 // 1309
	@expect_methodcallexpression307: NOP // 1312
// Line 88:        Mail.registerDomain(from,domainName);
	ALIAS r3 $methodcallexpression315 // 1312
	COPY $domainName r4 // 1312
	PUSH r4 // 1315
	COPY $from r4 // 1317
	PUSH r4 // 1320
	LOAD $methodcallexpression315 "RegisterDomain" // 1322
	PUSH $methodcallexpression315 // 1340
	LOAD $methodcallexpression315 "mail" // 1342
	CTX $methodcallexpression315 $methodcallexpression315 // 1350
	SWITCH $methodcallexpression315 // 1353
@exit_register: // 1355
RET // 1356
// Line 89:
// Line 90:    }

// ********* testBool Method ***********
@entry_testBool: // 1357
// Line 91:
// Line 92:    public testBool(bRole:bool):type{
ALIAS r1 $bRole // 1358
POP $bRole // 1358
// Line 93:    
// Line 94:
// Line 95:        return $TYPE_OF(bRole);
	ALIAS r2 $literalexpression325 // 1360
	LOAD $literalexpression325 6 Enum // 1360
	PUSH $literalexpression325 // 1368
	JMP @exit_testBool // 1370
@exit_testBool: // 1373
RET // 1374
// Line 96:        
// Line 97:    }

// ********* convStrToBtyes Method ***********
@entry_convStrToBtyes: // 1375
// Line 98:    
// Line 99:    public convStrToBtyes(str:string):bytes{
ALIAS r1 $str // 1376
POP $str // 1376
// Line 100:        return String.toBytes(str);
	COPY $str r2 // 1378
	CAST r2 r2 #Bytes // 1381
	PUSH r2 // 1385
	JMP @exit_convStrToBtyes // 1387
@exit_convStrToBtyes: // 1390
RET // 1391
// Line 101:    }

// ********* testNumToBoolConversion Method ***********
@entry_testNumToBoolConversion: // 1392
// Line 102:
// Line 103:    public testNumToBoolConversion(num:number):bool{
ALIAS r1 $num // 1393
POP $num // 1393
CAST $num $num #Number // 1395
// Line 104:        local convNumToBool: bool = Number.toBool(num);
	ALIAS r2 $convNumToBool // 1399
	COPY $num r3 // 1399
	CAST r3 r3 #Bool // 1402
	COPY r3 $convNumToBool // 1406
// Line 105:        //local convNumToBool: bool = true;
// Line 106:        return convNumToBool;
	COPY $convNumToBool r3 // 1409
	PUSH r3 // 1412
	JMP @exit_testNumToBoolConversion // 1414
@exit_testNumToBoolConversion: // 1417
RET // 1418
// Line 107:    }

// ********* domainExist Method ***********
@entry_domainExist: // 1419
// Line 108:
// Line 109:
// Line 110:
// Line 111:    public domainExist(domainName:string): bool{
ALIAS r1 $domainName // 1420
POP $domainName // 1420
// Line 112:
// Line 113:        return Mail.domainExists(domainName);
	ALIAS r2 $methodcallexpression350 // 1422
	COPY $domainName r3 // 1422
	PUSH r3 // 1425
	LOAD $methodcallexpression350 "DomainExists" // 1427
	PUSH $methodcallexpression350 // 1443
	LOAD $methodcallexpression350 "mail" // 1445
	CTX $methodcallexpression350 $methodcallexpression350 // 1453
	SWITCH $methodcallexpression350 // 1456
	POP $methodcallexpression350 // 1458
	PUSH $methodcallexpression350 // 1460
	JMP @exit_domainExist // 1462
@exit_domainExist: // 1465
RET // 1466
// Line 114:    }

// ********* quotePrice Method ***********
@entry_quotePrice: // 1467
// Line 115:
// Line 116:    public quotePrice(baseSymbol:string, quoteSymbol:string, amount:number): number {
ALIAS r1 $baseSymbol // 1468
POP $baseSymbol // 1468
ALIAS r2 $quoteSymbol // 1470
POP $quoteSymbol // 1470
ALIAS r3 $amount // 1472
POP $amount // 1472
CAST $amount $amount #Number // 1474
// Line 117:        local qu: number = Oracle.quote(baseSymbol,quoteSymbol,amount);
	ALIAS r4 $qu // 1478
	ALIAS r5 $methodcallexpression362 // 1478
	COPY $amount r6 // 1478
	PUSH r6 // 1481
	COPY $quoteSymbol r6 // 1483
	PUSH r6 // 1486
	COPY $baseSymbol r6 // 1488
	PUSH r6 // 1491
	LOAD $methodcallexpression362 "Oracle.Quote" // 1493
	EXTCALL $methodcallexpression362 // 1509
	COPY $methodcallexpression362 $qu // 1511
// Line 118:       return qu;
	COPY $qu r5 // 1514
	PUSH r5 // 1517
	JMP @exit_quotePrice // 1519
@exit_quotePrice: // 1522
RET // 1523
// Line 119:    }

// ********* onUpgrade Trigger ***********
@entry_onUpgrade: // 1524
ALIAS r1 $dataGet // 1525
LOAD $dataGet "Data.Get" // 1525
ALIAS r2 $contractName // 1537
LOAD $contractName "provingground" // 1537
ALIAS r3 $_owner // 1554
// reading global: _owner
LOAD r0 8 // 1554
PUSH r0 // 1559
LOAD r0 "_owner" // 1561
PUSH r0 // 1571
PUSH $contractName // 1573
EXTCALL $dataGet // 1575
POP $_owner // 1577
PUSH $_owner // 1579
EXTCALL "Address()" // 1581
POP $_owner // 1596
// Line 120:
// Line 121:    trigger onUpgrade(from:address)
ALIAS r1 $from // 1598
POP $from // 1598
PUSH $from // 1600
EXTCALL "Address()" // 1602
POP $from // 1617
// Line 122:    {
// Line 123:        Runtime.expect(Runtime.isWitness(_owner), "Only the owner can update");
	ALIAS r2 $methodcallexpression381 // 1619
	COPY $_owner r4 // 1619
	PUSH r4 // 1622
	LOAD $methodcallexpression381 "Runtime.IsWitness" // 1624
	EXTCALL $methodcallexpression381 // 1645
	POP $methodcallexpression381 // 1647
	JMPIF $methodcallexpression381 @expect_methodcallexpression378 // 1649
	ALIAS r4 $literalexpression384 // 1653
	LOAD $literalexpression384 "Only the owner can update" // 1653
	THROW $literalexpression384 // 1682
	@expect_methodcallexpression378: NOP // 1685
// Line 124:        return;
	JMP @exit_onUpgrade // 1685
@exit_onUpgrade: // 1688
RET // 1689
// Line 125:    }

// ********* onKill Trigger ***********
@entry_onKill: // 1690
ALIAS r1 $dataGet // 1691
LOAD $dataGet "Data.Get" // 1691
ALIAS r2 $contractName // 1703
LOAD $contractName "provingground" // 1703
ALIAS r3 $_owner // 1720
// reading global: _owner
LOAD r0 8 // 1720
PUSH r0 // 1725
LOAD r0 "_owner" // 1727
PUSH r0 // 1737
PUSH $contractName // 1739
EXTCALL $dataGet // 1741
POP $_owner // 1743
PUSH $_owner // 1745
EXTCALL "Address()" // 1747
POP $_owner // 1762
// Line 126:    
// Line 127:    trigger onKill(from:address){
ALIAS r1 $from // 1764
POP $from // 1764
PUSH $from // 1766
EXTCALL "Address()" // 1768
POP $from // 1783
// Line 128:        Runtime.expect(Runtime.isWitness(_owner), "Only the owner can delete");
	ALIAS r2 $methodcallexpression394 // 1785
	COPY $_owner r4 // 1785
	PUSH r4 // 1788
	LOAD $methodcallexpression394 "Runtime.IsWitness" // 1790
	EXTCALL $methodcallexpression394 // 1811
	POP $methodcallexpression394 // 1813
	JMPIF $methodcallexpression394 @expect_methodcallexpression391 // 1815
	ALIAS r4 $literalexpression397 // 1819
	LOAD $literalexpression397 "Only the owner can delete" // 1819
	THROW $literalexpression397 // 1848
	@expect_methodcallexpression391: NOP // 1851
// Line 129:        return;
	JMP @exit_onKill // 1851
@exit_onKill: // 1854
RET // 1855
