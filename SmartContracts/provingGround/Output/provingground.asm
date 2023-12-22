// Line 1:
// Line 2:contract provingground{
// Line 3: 
// Line 4:    import Runtime;
// Line 5:    import Oracle;
// Line 6:    import Mail;
// Line 7:    import Number;
// Line 8:    import Array;   
// Line 9:    import Hash; 
// Line 10:    global _owner: address;

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
// Line 11:
// Line 12:    constructor(owner:address){
ALIAS r2 $owner // 94
POP $owner // 94
PUSH $owner // 96
EXTCALL "Address()" // 98
POP $owner // 113
// Line 13:        _owner = owner;
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
// Line 14:    }

// ********* testHash Method ***********
@entry_testHash: // 151
// Line 15:
// Line 16:    public testHash(test_hash: string): string{
ALIAS r1 $test_hash // 152
POP $test_hash // 152
// Line 17:        local tx_hash = #DBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C;
	ALIAS r2 $tx_hash // 154
	ALIAS r3 $literalexpression110 // 154
	LOAD $literalexpression110 0xDBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C // 154
	PUSH $literalexpression110 // 190
	EXTCALL "Hash()" // 192
	POP $literalexpression110 // 204
	COPY $literalexpression110 $tx_hash // 206
// Line 18:        return tx_hash.toString();
	COPY $tx_hash r3 // 209
	CAST r3 r3 #String // 212
	PUSH r3 // 216
	JMP @exit_testHash // 218
@exit_testHash: // 221
RET // 222
// Line 19:    }

// ********* testHash2 Method ***********
@entry_testHash2: // 223
// Line 20:    public testHash2():hash {
// Line 21:        local tx_hash = #0xDBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C;
	ALIAS r1 $tx_hash // 224
	ALIAS r2 $literalexpression119 // 224
	LOAD $literalexpression119 0xDBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C // 224
	PUSH $literalexpression119 // 260
	EXTCALL "Hash()" // 262
	POP $literalexpression119 // 274
	COPY $literalexpression119 $tx_hash // 276
// Line 22:
// Line 23:        return tx_hash;
	COPY $tx_hash r2 // 279
	PUSH r2 // 282
	JMP @exit_testHash2 // 284
@exit_testHash2: // 287
RET // 288
// Line 24:    }

// ********* checkPrice Method ***********
@entry_checkPrice: // 289
// Line 25:
// Line 26:    /************************************************************************************************
// Line 27:    Not sure how to use Oracles yet. Plan was to use Oracles to check price of given token
// Line 28:    and return that token.
// Line 29:    ************************************************************************************************/
// Line 30:    public checkPrice(symbol: string):number{
ALIAS r1 $symbol // 290
POP $symbol // 290
// Line 31:        local price: number = Oracle.price(symbol);
	ALIAS r2 $price // 292
	ALIAS r3 $methodcallexpression128 // 292
	COPY $symbol r4 // 292
	PUSH r4 // 295
	LOAD $methodcallexpression128 "Oracle.Price" // 297
	EXTCALL $methodcallexpression128 // 313
	COPY $methodcallexpression128 $price // 315
// Line 32:        return price;
	COPY $price r3 // 318
	PUSH r3 // 321
	JMP @exit_checkPrice // 323
@exit_checkPrice: // 326
RET // 327
// Line 33:    }

// ********* sendMsg Method ***********
@entry_sendMsg: // 328
// Line 34:
// Line 35:    public sendMsg(from:address, target:address, archiveHash:hash){
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
// Line 36:        local tx_hash = "DBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C";
	ALIAS r4 $tx_hash // 389
	ALIAS r5 $literalexpression143 // 389
	LOAD $literalexpression143 "DBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C" // 389
	COPY $literalexpression143 $tx_hash // 457
// Line 37:        //archiveHash = Hash.FromString(tx_hash);
// Line 38:        Mail.pushMessage(from, target,archiveHash);
	ALIAS r5 $methodcallexpression147 // 460
	COPY $archiveHash r6 // 460
	PUSH r6 // 463
	COPY $target r6 // 465
	PUSH r6 // 468
	COPY $from r6 // 470
	PUSH r6 // 473
	LOAD $methodcallexpression147 "PushMessage" // 475
	PUSH $methodcallexpression147 // 490
	LOAD $methodcallexpression147 "mail" // 492
	CTX $methodcallexpression147 $methodcallexpression147 // 500
	SWITCH $methodcallexpression147 // 503
@exit_sendMsg: // 505
RET // 506
// Line 39:    }

// ********* testAllTypes Method ***********
@entry_testAllTypes: // 507
// Line 40:
// Line 41:    //deprecated since Hash has issues
// Line 42:    public testAllTypes(str:string, truthy:bool,num:number,stamp:timestamp,bytArr:bytes,addy:address,hashish: hash): string{
ALIAS r1 $str // 508
POP $str // 508
ALIAS r2 $truthy // 510
POP $truthy // 510
ALIAS r3 $num // 512
POP $num // 512
CAST $num $num #Number // 514
ALIAS r4 $stamp // 518
POP $stamp // 518
PUSH $stamp // 520
EXTCALL "Timestamp()" // 522
POP $stamp // 539
ALIAS r5 $bytArr // 541
POP $bytArr // 541
ALIAS r6 $addy // 543
POP $addy // 543
PUSH $addy // 545
EXTCALL "Address()" // 547
POP $addy // 562
ALIAS r7 $hashish // 564
POP $hashish // 564
PUSH $hashish // 566
EXTCALL "Hash()" // 568
POP $hashish // 580
// Line 43:
// Line 44:        local type_str ="Type of str: " +$TYPE_OF(str) + " Type of truthy: " +$TYPE_OF(truthy) +" Type of stamp: " +$TYPE_OF(stamp) +" Type of bytArr: " +$TYPE_OF(bytArr) + " Type of addy: " +$TYPE_OF(addy) +" Type of num: " +$TYPE_OF(num);
	ALIAS r8 $type_str // 582
	ALIAS r9 $literalexpression170 // 582
	LOAD $literalexpression170 "Type of str: " // 582
	ALIAS r10 $literalexpression172 // 599
	LOAD $literalexpression172 4 Enum // 599
	CAST $literalexpression172 $literalexpression172 #String // 607
	ADD $literalexpression170 $literalexpression172 r11 // 611
	ALIAS r9 $literalexpression175 // 615
	LOAD $literalexpression175 " Type of truthy: " // 615
	ALIAS r10 $literalexpression177 // 636
	LOAD $literalexpression177 6 Enum // 636
	CAST $literalexpression177 $literalexpression177 #String // 644
	ADD $literalexpression175 $literalexpression177 r12 // 648
	ALIAS r9 $literalexpression180 // 652
	LOAD $literalexpression180 " Type of stamp: " // 652
	ALIAS r10 $literalexpression182 // 672
	LOAD $literalexpression182 5 Enum // 672
	CAST $literalexpression182 $literalexpression182 #String // 680
	ADD $literalexpression180 $literalexpression182 r13 // 684
	ALIAS r9 $literalexpression185 // 688
	LOAD $literalexpression185 " Type of bytArr: " // 688
	ALIAS r10 $literalexpression187 // 709
	LOAD $literalexpression187 2 Enum // 709
	CAST $literalexpression187 $literalexpression187 #String // 717
	ADD $literalexpression185 $literalexpression187 r14 // 721
	ALIAS r9 $literalexpression190 // 725
	LOAD $literalexpression190 " Type of addy: " // 725
	ALIAS r10 $literalexpression192 // 744
	LOAD $literalexpression192 8 Enum // 744
	CAST $literalexpression192 $literalexpression192 #String // 752
	ADD $literalexpression190 $literalexpression192 r15 // 756
	ALIAS r9 $literalexpression195 // 760
	LOAD $literalexpression195 " Type of num: " // 760
	ALIAS r10 $literalexpression197 // 778
	LOAD $literalexpression197 3 Enum // 778
	CAST $literalexpression197 $literalexpression197 #String // 786
	ADD $literalexpression195 $literalexpression197 r16 // 790
	ADD r15 r16 r9 // 794
	ADD r14 r9 r10 // 798
	ADD r13 r10 r9 // 802
	ADD r12 r9 r10 // 806
	ADD r11 r10 r9 // 810
	COPY r9 $type_str // 814
// Line 45:        return type_str;
	COPY $type_str r9 // 817
	PUSH r9 // 820
	JMP @exit_testAllTypes // 822
@exit_testAllTypes: // 825
RET // 826
// Line 46:    }

// ********* testAllTypes2 Method ***********
@entry_testAllTypes2: // 827
// Line 47:
// Line 48:    public testAllTypes2(str:string, truthy:bool,num:number,stamp:timestamp,bytArr:bytes,addy:address): string{
ALIAS r1 $str // 828
POP $str // 828
ALIAS r2 $truthy // 830
POP $truthy // 830
ALIAS r3 $num // 832
POP $num // 832
CAST $num $num #Number // 834
ALIAS r4 $stamp // 838
POP $stamp // 838
PUSH $stamp // 840
EXTCALL "Timestamp()" // 842
POP $stamp // 859
ALIAS r5 $bytArr // 861
POP $bytArr // 861
ALIAS r6 $addy // 863
POP $addy // 863
PUSH $addy // 865
EXTCALL "Address()" // 867
POP $addy // 882
// Line 49:
// Line 50:        local type_str ="Type of str: " +$TYPE_OF(str) + " Type of truthy: " +$TYPE_OF(truthy) +" Type of stamp: " +$TYPE_OF(stamp) +" Type of bytArr: " +$TYPE_OF(bytArr) + " Type of addy: " +$TYPE_OF(addy) +" Type of num: " +$TYPE_OF(num);
	ALIAS r7 $type_str // 884
	ALIAS r8 $literalexpression223 // 884
	LOAD $literalexpression223 "Type of str: " // 884
	ALIAS r9 $literalexpression225 // 901
	LOAD $literalexpression225 4 Enum // 901
	CAST $literalexpression225 $literalexpression225 #String // 909
	ADD $literalexpression223 $literalexpression225 r10 // 913
	ALIAS r8 $literalexpression228 // 917
	LOAD $literalexpression228 " Type of truthy: " // 917
	ALIAS r9 $literalexpression230 // 938
	LOAD $literalexpression230 6 Enum // 938
	CAST $literalexpression230 $literalexpression230 #String // 946
	ADD $literalexpression228 $literalexpression230 r11 // 950
	ALIAS r8 $literalexpression233 // 954
	LOAD $literalexpression233 " Type of stamp: " // 954
	ALIAS r9 $literalexpression235 // 974
	LOAD $literalexpression235 5 Enum // 974
	CAST $literalexpression235 $literalexpression235 #String // 982
	ADD $literalexpression233 $literalexpression235 r12 // 986
	ALIAS r8 $literalexpression238 // 990
	LOAD $literalexpression238 " Type of bytArr: " // 990
	ALIAS r9 $literalexpression240 // 1011
	LOAD $literalexpression240 2 Enum // 1011
	CAST $literalexpression240 $literalexpression240 #String // 1019
	ADD $literalexpression238 $literalexpression240 r13 // 1023
	ALIAS r8 $literalexpression243 // 1027
	LOAD $literalexpression243 " Type of addy: " // 1027
	ALIAS r9 $literalexpression245 // 1046
	LOAD $literalexpression245 8 Enum // 1046
	CAST $literalexpression245 $literalexpression245 #String // 1054
	ADD $literalexpression243 $literalexpression245 r14 // 1058
	ALIAS r8 $literalexpression248 // 1062
	LOAD $literalexpression248 " Type of num: " // 1062
	ALIAS r9 $literalexpression250 // 1080
	LOAD $literalexpression250 3 Enum // 1080
	CAST $literalexpression250 $literalexpression250 #String // 1088
	ADD $literalexpression248 $literalexpression250 r15 // 1092
	ADD r14 r15 r8 // 1096
	ADD r13 r8 r9 // 1100
	ADD r12 r9 r8 // 1104
	ADD r11 r8 r9 // 1108
	ADD r10 r9 r8 // 1112
	COPY r8 $type_str // 1116
// Line 51:        return type_str;
	COPY $type_str r8 // 1119
	PUSH r8 // 1122
	JMP @exit_testAllTypes2 // 1124
@exit_testAllTypes2: // 1127
RET // 1128
// Line 52:    }

// ********* decimalTest Method ***********
@entry_decimalTest: // 1129
// Line 53:   
// Line 54:   /*****************************************************
// Line 55:    Not yet finished
// Line 56:   ******************************************************/
// Line 57:    public decimalTest(digits:number){
ALIAS r1 $digits // 1130
POP $digits // 1130
CAST $digits $digits #Number // 1132
@exit_decimalTest: // 1136
RET // 1137
// Line 58:        //local val: decimal<digits>; appears that it is no possible to dynamically assign a decimal digit
// Line 59:
// Line 60:    }

// ********* logTest Method ***********
@entry_logTest: // 1138
// Line 61:    /********************************************
// Line 62:    Log messages are shown under vm.txt within 
// Line 63:    docker
// Line 64:    *********************************************/
// Line 65:    public logTest(){
// Line 66:        Runtime.log("Testing");
	ALIAS r1 $methodcallexpression269 // 1139
	ALIAS r2 $literalexpression271 // 1139
	LOAD $literalexpression271 "Testing" // 1139
	PUSH $literalexpression271 // 1150
	LOAD $methodcallexpression269 "Runtime.Log" // 1152
	EXTCALL $methodcallexpression269 // 1167
@exit_logTest: // 1169
RET // 1170
// Line 67:    }

// ********* register Method ***********
@entry_register: // 1171
// Line 68:
// Line 69:
// Line 70:    public register(from:address,domainName: string)
ALIAS r1 $from // 1172
POP $from // 1172
PUSH $from // 1174
EXTCALL "Address()" // 1176
POP $from // 1191
ALIAS r2 $domainName // 1193
POP $domainName // 1193
// Line 71:    {   
// Line 72:        Runtime.expect(Runtime.isWitness(from),"Invalid Witness");
	ALIAS r3 $methodcallexpression282 // 1195
	COPY $from r4 // 1195
	PUSH r4 // 1198
	LOAD $methodcallexpression282 "Runtime.IsWitness" // 1200
	EXTCALL $methodcallexpression282 // 1221
	POP $methodcallexpression282 // 1223
	JMPIF $methodcallexpression282 @expect_methodcallexpression279 // 1225
	ALIAS r4 $literalexpression285 // 1229
	LOAD $literalexpression285 "Invalid Witness" // 1229
	THROW $literalexpression285 // 1248
	@expect_methodcallexpression279: NOP // 1251
// Line 73:        Mail.registerDomain(from,domainName);
	ALIAS r3 $methodcallexpression287 // 1251
	COPY $domainName r4 // 1251
	PUSH r4 // 1254
	COPY $from r4 // 1256
	PUSH r4 // 1259
	LOAD $methodcallexpression287 "RegisterDomain" // 1261
	PUSH $methodcallexpression287 // 1279
	LOAD $methodcallexpression287 "mail" // 1281
	CTX $methodcallexpression287 $methodcallexpression287 // 1289
	SWITCH $methodcallexpression287 // 1292
@exit_register: // 1294
RET // 1295
// Line 74:
// Line 75:    }

// ********* testBool Method ***********
@entry_testBool: // 1296
// Line 76:
// Line 77:    public testBool(bRole:bool):type{
ALIAS r1 $bRole // 1297
POP $bRole // 1297
// Line 78:    
// Line 79:
// Line 80:        return $TYPE_OF(bRole);
	ALIAS r2 $literalexpression297 // 1299
	LOAD $literalexpression297 6 Enum // 1299
	PUSH $literalexpression297 // 1307
	JMP @exit_testBool // 1309
@exit_testBool: // 1312
RET // 1313
// Line 81:        
// Line 82:    }

// ********* testNumToBoolConversion Method ***********
@entry_testNumToBoolConversion: // 1314
// Line 83:
// Line 84:    public testNumToBoolConversion(num:number):bool{
ALIAS r1 $num // 1315
POP $num // 1315
CAST $num $num #Number // 1317
// Line 85:        local convNumToBool: bool= Number.toBool(num);
	ALIAS r2 $convNumToBool // 1321
	COPY $num r3 // 1321
	CAST r3 r3 #Bool // 1324
	COPY r3 $convNumToBool // 1328
// Line 86:        //local convNumToBool: bool = true;
// Line 87:        return convNumToBool;
	COPY $convNumToBool r3 // 1331
	PUSH r3 // 1334
	JMP @exit_testNumToBoolConversion // 1336
@exit_testNumToBoolConversion: // 1339
RET // 1340
// Line 88:    }

// ********* domainExist Method ***********
@entry_domainExist: // 1341
// Line 89:
// Line 90:    public domainExist(domainName:string): bool{
ALIAS r1 $domainName // 1342
POP $domainName // 1342
// Line 91:
// Line 92:        return Mail.domainExists(domainName);
	ALIAS r2 $methodcallexpression314 // 1344
	COPY $domainName r3 // 1344
	PUSH r3 // 1347
	LOAD $methodcallexpression314 "DomainExists" // 1349
	PUSH $methodcallexpression314 // 1365
	LOAD $methodcallexpression314 "mail" // 1367
	CTX $methodcallexpression314 $methodcallexpression314 // 1375
	SWITCH $methodcallexpression314 // 1378
	POP $methodcallexpression314 // 1380
	PUSH $methodcallexpression314 // 1382
	JMP @exit_domainExist // 1384
@exit_domainExist: // 1387
RET // 1388
// Line 93:    }

// ********* quotePrice Method ***********
@entry_quotePrice: // 1389
// Line 94:
// Line 95:    public quotePrice(baseSymbol:string, quoteSymbol:string, amount:number): number {
ALIAS r1 $baseSymbol // 1390
POP $baseSymbol // 1390
ALIAS r2 $quoteSymbol // 1392
POP $quoteSymbol // 1392
ALIAS r3 $amount // 1394
POP $amount // 1394
CAST $amount $amount #Number // 1396
// Line 96:        local qu: number = Oracle.quote(baseSymbol,quoteSymbol,amount);
	ALIAS r4 $qu // 1400
	ALIAS r5 $methodcallexpression326 // 1400
	COPY $amount r6 // 1400
	PUSH r6 // 1403
	COPY $quoteSymbol r6 // 1405
	PUSH r6 // 1408
	COPY $baseSymbol r6 // 1410
	PUSH r6 // 1413
	LOAD $methodcallexpression326 "Oracle.Quote" // 1415
	EXTCALL $methodcallexpression326 // 1431
	COPY $methodcallexpression326 $qu // 1433
// Line 97:       return qu;
	COPY $qu r5 // 1436
	PUSH r5 // 1439
	JMP @exit_quotePrice // 1441
@exit_quotePrice: // 1444
RET // 1445
// Line 98:    }

// ********* onUpgrade Trigger ***********
@entry_onUpgrade: // 1446
ALIAS r1 $dataGet // 1447
LOAD $dataGet "Data.Get" // 1447
ALIAS r2 $contractName // 1459
LOAD $contractName "provingground" // 1459
ALIAS r3 $_owner // 1476
// reading global: _owner
LOAD r0 8 // 1476
PUSH r0 // 1481
LOAD r0 "_owner" // 1483
PUSH r0 // 1493
PUSH $contractName // 1495
EXTCALL $dataGet // 1497
POP $_owner // 1499
PUSH $_owner // 1501
EXTCALL "Address()" // 1503
POP $_owner // 1518
// Line 99:
// Line 100:    trigger onUpgrade(from:address)
ALIAS r1 $from // 1520
POP $from // 1520
PUSH $from // 1522
EXTCALL "Address()" // 1524
POP $from // 1539
// Line 101:    {
// Line 102:        Runtime.expect(Runtime.isWitness(_owner), "Only the owner can update");
	ALIAS r2 $methodcallexpression345 // 1541
	COPY $_owner r4 // 1541
	PUSH r4 // 1544
	LOAD $methodcallexpression345 "Runtime.IsWitness" // 1546
	EXTCALL $methodcallexpression345 // 1567
	POP $methodcallexpression345 // 1569
	JMPIF $methodcallexpression345 @expect_methodcallexpression342 // 1571
	ALIAS r4 $literalexpression348 // 1575
	LOAD $literalexpression348 "Only the owner can update" // 1575
	THROW $literalexpression348 // 1604
	@expect_methodcallexpression342: NOP // 1607
// Line 103:        return;
	JMP @exit_onUpgrade // 1607
@exit_onUpgrade: // 1610
RET // 1611
// Line 104:    }

// ********* onKill Trigger ***********
@entry_onKill: // 1612
ALIAS r1 $dataGet // 1613
LOAD $dataGet "Data.Get" // 1613
ALIAS r2 $contractName // 1625
LOAD $contractName "provingground" // 1625
ALIAS r3 $_owner // 1642
// reading global: _owner
LOAD r0 8 // 1642
PUSH r0 // 1647
LOAD r0 "_owner" // 1649
PUSH r0 // 1659
PUSH $contractName // 1661
EXTCALL $dataGet // 1663
POP $_owner // 1665
PUSH $_owner // 1667
EXTCALL "Address()" // 1669
POP $_owner // 1684
// Line 105:    
// Line 106:    trigger onKill(from:address){
ALIAS r1 $from // 1686
POP $from // 1686
PUSH $from // 1688
EXTCALL "Address()" // 1690
POP $from // 1705
// Line 107:        Runtime.expect(Runtime.isWitness(_owner), "Only the owner can delete");
	ALIAS r2 $methodcallexpression358 // 1707
	COPY $_owner r4 // 1707
	PUSH r4 // 1710
	LOAD $methodcallexpression358 "Runtime.IsWitness" // 1712
	EXTCALL $methodcallexpression358 // 1733
	POP $methodcallexpression358 // 1735
	JMPIF $methodcallexpression358 @expect_methodcallexpression355 // 1737
	ALIAS r4 $literalexpression361 // 1741
	LOAD $literalexpression361 "Only the owner can delete" // 1741
	THROW $literalexpression361 // 1770
	@expect_methodcallexpression355: NOP // 1773
// Line 108:        return;
	JMP @exit_onKill // 1773
@exit_onKill: // 1776
RET // 1777
