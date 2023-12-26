// Line 1:
// Line 2:contract provingground{
// Line 3: 
// Line 4:    import Runtime;
// Line 5:    import Oracle;
// Line 6:    import Mail;
// Line 7:    import Number;
// Line 8:    import String;
// Line 9:    import Array;   
// Line 10:    import Hash; 
// Line 11:    global _owner: address;

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
// Line 12:
// Line 13:    constructor(owner:address){
ALIAS r2 $owner // 94
POP $owner // 94
PUSH $owner // 96
EXTCALL "Address()" // 98
POP $owner // 113
// Line 14:        _owner = owner;
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
// Line 15:    }

// ********* testHash Method ***********
@entry_testHash: // 151
// Line 16:
// Line 17:    public testHash(test_hash: string): string{
ALIAS r1 $test_hash // 152
POP $test_hash // 152
// Line 18:        local tx_hash = #DBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C;
	ALIAS r2 $tx_hash // 154
	ALIAS r3 $literalexpression124 // 154
	LOAD $literalexpression124 0xDBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C // 154
	PUSH $literalexpression124 // 190
	EXTCALL "Hash()" // 192
	POP $literalexpression124 // 204
	COPY $literalexpression124 $tx_hash // 206
// Line 19:        return tx_hash.toString();
	COPY $tx_hash r3 // 209
	CAST r3 r3 #String // 212
	PUSH r3 // 216
	JMP @exit_testHash // 218
@exit_testHash: // 221
RET // 222
// Line 20:    }

// ********* testHash2 Method ***********
@entry_testHash2: // 223
// Line 21:    public testHash2():hash {
// Line 22:        local tx_hash = #0xDBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C;
	ALIAS r1 $tx_hash // 224
	ALIAS r2 $literalexpression133 // 224
	LOAD $literalexpression133 0xDBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C // 224
	PUSH $literalexpression133 // 260
	EXTCALL "Hash()" // 262
	POP $literalexpression133 // 274
	COPY $literalexpression133 $tx_hash // 276
// Line 23:
// Line 24:        return tx_hash;
	COPY $tx_hash r2 // 279
	PUSH r2 // 282
	JMP @exit_testHash2 // 284
@exit_testHash2: // 287
RET // 288
// Line 25:    }

// ********* checkPrice Method ***********
@entry_checkPrice: // 289
// Line 26:
// Line 27:    /************************************************************************************************
// Line 28:    Not sure how to use Oracles yet. Plan was to use Oracles to check price of given token
// Line 29:    and return that token.
// Line 30:    ************************************************************************************************/
// Line 31:    public checkPrice(symbol: string):number{
ALIAS r1 $symbol // 290
POP $symbol // 290
// Line 32:        local price: number = Oracle.price(symbol);
	ALIAS r2 $price // 292
	ALIAS r3 $methodcallexpression142 // 292
	COPY $symbol r4 // 292
	PUSH r4 // 295
	LOAD $methodcallexpression142 "Oracle.Price" // 297
	EXTCALL $methodcallexpression142 // 313
	COPY $methodcallexpression142 $price // 315
// Line 33:        return price;
	COPY $price r3 // 318
	PUSH r3 // 321
	JMP @exit_checkPrice // 323
@exit_checkPrice: // 326
RET // 327
// Line 34:    }

// ********* sendMsg Method ***********
@entry_sendMsg: // 328
// Line 35:
// Line 36:    public sendMsg(from:address, target:address, archiveHash:hash){
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
// Line 37:        local tx_hash = "DBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C";
	ALIAS r4 $tx_hash // 389
	ALIAS r5 $literalexpression157 // 389
	LOAD $literalexpression157 "DBEBEA827CBA60657F141FD6F94B929D85A95EFC9340ADCFFE0FD73A3CF2845C" // 389
	COPY $literalexpression157 $tx_hash // 457
// Line 38:        //archiveHash = Hash.FromString(tx_hash);
// Line 39:        Mail.pushMessage(from, target,archiveHash);
	ALIAS r5 $methodcallexpression161 // 460
	COPY $archiveHash r6 // 460
	PUSH r6 // 463
	COPY $target r6 // 465
	PUSH r6 // 468
	COPY $from r6 // 470
	PUSH r6 // 473
	LOAD $methodcallexpression161 "PushMessage" // 475
	PUSH $methodcallexpression161 // 490
	LOAD $methodcallexpression161 "mail" // 492
	CTX $methodcallexpression161 $methodcallexpression161 // 500
	SWITCH $methodcallexpression161 // 503
@exit_sendMsg: // 505
RET // 506
// Line 40:    }

// ********* testAllTypes Method ***********
@entry_testAllTypes: // 507
// Line 41:
// Line 42:    //deprecated since Hash has issues
// Line 43:    public testAllTypes(str:string, truthy:bool,num:number,stamp:timestamp,bytArr:bytes,addy:address,hashish: hash): string{
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
// Line 44:
// Line 45:        local type_str ="Type of str: " +$TYPE_OF(str) + " Type of truthy: " +$TYPE_OF(truthy) +" Type of stamp: " +$TYPE_OF(stamp) +" Type of bytArr: " +$TYPE_OF(bytArr) + " Type of addy: " +$TYPE_OF(addy) +" Type of num: " +$TYPE_OF(num);
	ALIAS r8 $type_str // 582
	ALIAS r9 $literalexpression184 // 582
	LOAD $literalexpression184 "Type of str: " // 582
	ALIAS r10 $literalexpression186 // 599
	LOAD $literalexpression186 4 Enum // 599
	CAST $literalexpression186 $literalexpression186 #String // 607
	ADD $literalexpression184 $literalexpression186 r11 // 611
	ALIAS r9 $literalexpression189 // 615
	LOAD $literalexpression189 " Type of truthy: " // 615
	ALIAS r10 $literalexpression191 // 636
	LOAD $literalexpression191 6 Enum // 636
	CAST $literalexpression191 $literalexpression191 #String // 644
	ADD $literalexpression189 $literalexpression191 r12 // 648
	ALIAS r9 $literalexpression194 // 652
	LOAD $literalexpression194 " Type of stamp: " // 652
	ALIAS r10 $literalexpression196 // 672
	LOAD $literalexpression196 5 Enum // 672
	CAST $literalexpression196 $literalexpression196 #String // 680
	ADD $literalexpression194 $literalexpression196 r13 // 684
	ALIAS r9 $literalexpression199 // 688
	LOAD $literalexpression199 " Type of bytArr: " // 688
	ALIAS r10 $literalexpression201 // 709
	LOAD $literalexpression201 2 Enum // 709
	CAST $literalexpression201 $literalexpression201 #String // 717
	ADD $literalexpression199 $literalexpression201 r14 // 721
	ALIAS r9 $literalexpression204 // 725
	LOAD $literalexpression204 " Type of addy: " // 725
	ALIAS r10 $literalexpression206 // 744
	LOAD $literalexpression206 8 Enum // 744
	CAST $literalexpression206 $literalexpression206 #String // 752
	ADD $literalexpression204 $literalexpression206 r15 // 756
	ALIAS r9 $literalexpression209 // 760
	LOAD $literalexpression209 " Type of num: " // 760
	ALIAS r10 $literalexpression211 // 778
	LOAD $literalexpression211 3 Enum // 778
	CAST $literalexpression211 $literalexpression211 #String // 786
	ADD $literalexpression209 $literalexpression211 r16 // 790
	ADD r15 r16 r9 // 794
	ADD r14 r9 r10 // 798
	ADD r13 r10 r9 // 802
	ADD r12 r9 r10 // 806
	ADD r11 r10 r9 // 810
	COPY r9 $type_str // 814
// Line 46:        return type_str;
	COPY $type_str r9 // 817
	PUSH r9 // 820
	JMP @exit_testAllTypes // 822
@exit_testAllTypes: // 825
RET // 826
// Line 47:    }

// ********* testAllTypes2 Method ***********
@entry_testAllTypes2: // 827
// Line 48:
// Line 49:    public testAllTypes2(str:string, truthy:bool,num:number,stamp:timestamp,bytArr:bytes,addy:address): string{
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
// Line 50:
// Line 51:        local type_str ="Type of str: " +$TYPE_OF(str) + " Type of truthy: " +$TYPE_OF(truthy) +" Type of stamp: " +$TYPE_OF(stamp) +" Type of bytArr: " +$TYPE_OF(bytArr) + " Type of addy: " +$TYPE_OF(addy) +" Type of num: " +$TYPE_OF(num);
	ALIAS r7 $type_str // 884
	ALIAS r8 $literalexpression237 // 884
	LOAD $literalexpression237 "Type of str: " // 884
	ALIAS r9 $literalexpression239 // 901
	LOAD $literalexpression239 4 Enum // 901
	CAST $literalexpression239 $literalexpression239 #String // 909
	ADD $literalexpression237 $literalexpression239 r10 // 913
	ALIAS r8 $literalexpression242 // 917
	LOAD $literalexpression242 " Type of truthy: " // 917
	ALIAS r9 $literalexpression244 // 938
	LOAD $literalexpression244 6 Enum // 938
	CAST $literalexpression244 $literalexpression244 #String // 946
	ADD $literalexpression242 $literalexpression244 r11 // 950
	ALIAS r8 $literalexpression247 // 954
	LOAD $literalexpression247 " Type of stamp: " // 954
	ALIAS r9 $literalexpression249 // 974
	LOAD $literalexpression249 5 Enum // 974
	CAST $literalexpression249 $literalexpression249 #String // 982
	ADD $literalexpression247 $literalexpression249 r12 // 986
	ALIAS r8 $literalexpression252 // 990
	LOAD $literalexpression252 " Type of bytArr: " // 990
	ALIAS r9 $literalexpression254 // 1011
	LOAD $literalexpression254 2 Enum // 1011
	CAST $literalexpression254 $literalexpression254 #String // 1019
	ADD $literalexpression252 $literalexpression254 r13 // 1023
	ALIAS r8 $literalexpression257 // 1027
	LOAD $literalexpression257 " Type of addy: " // 1027
	ALIAS r9 $literalexpression259 // 1046
	LOAD $literalexpression259 8 Enum // 1046
	CAST $literalexpression259 $literalexpression259 #String // 1054
	ADD $literalexpression257 $literalexpression259 r14 // 1058
	ALIAS r8 $literalexpression262 // 1062
	LOAD $literalexpression262 " Type of num: " // 1062
	ALIAS r9 $literalexpression264 // 1080
	LOAD $literalexpression264 3 Enum // 1080
	CAST $literalexpression264 $literalexpression264 #String // 1088
	ADD $literalexpression262 $literalexpression264 r15 // 1092
	ADD r14 r15 r8 // 1096
	ADD r13 r8 r9 // 1100
	ADD r12 r9 r8 // 1104
	ADD r11 r8 r9 // 1108
	ADD r10 r9 r8 // 1112
	COPY r8 $type_str // 1116
// Line 52:        return type_str;
	COPY $type_str r8 // 1119
	PUSH r8 // 1122
	JMP @exit_testAllTypes2 // 1124
@exit_testAllTypes2: // 1127
RET // 1128
// Line 53:    }

// ********* decimalTest Method ***********
@entry_decimalTest: // 1129
// Line 54:   
// Line 55:   /*****************************************************
// Line 56:    Not yet finished
// Line 57:   ******************************************************/
// Line 58:    public decimalTest(digits:number){
ALIAS r1 $digits // 1130
POP $digits // 1130
CAST $digits $digits #Number // 1132
@exit_decimalTest: // 1136
RET // 1137
// Line 59:        //local val: decimal<digits>; appears that it is no possible to dynamically assign a decimal digit
// Line 60:
// Line 61:    }

// ********* logTest Method ***********
@entry_logTest: // 1138
// Line 62:    /********************************************
// Line 63:    Log messages are shown under vm.txt within 
// Line 64:    docker
// Line 65:    *********************************************/
// Line 66:    public logTest(){
// Line 67:        Runtime.log("Testing");
	ALIAS r1 $methodcallexpression283 // 1139
	ALIAS r2 $literalexpression285 // 1139
	LOAD $literalexpression285 "Testing" // 1139
	PUSH $literalexpression285 // 1150
	LOAD $methodcallexpression283 "Runtime.Log" // 1152
	EXTCALL $methodcallexpression283 // 1167
@exit_logTest: // 1169
RET // 1170
// Line 68:    }

// ********* register Method ***********
@entry_register: // 1171
// Line 69:
// Line 70:
// Line 71:    public register(from:address,domainName: string)
ALIAS r1 $from // 1172
POP $from // 1172
PUSH $from // 1174
EXTCALL "Address()" // 1176
POP $from // 1191
ALIAS r2 $domainName // 1193
POP $domainName // 1193
// Line 72:    {   
// Line 73:        Runtime.expect(Runtime.isWitness(from),"Invalid Witness");
	ALIAS r3 $methodcallexpression296 // 1195
	COPY $from r4 // 1195
	PUSH r4 // 1198
	LOAD $methodcallexpression296 "Runtime.IsWitness" // 1200
	EXTCALL $methodcallexpression296 // 1221
	POP $methodcallexpression296 // 1223
	JMPIF $methodcallexpression296 @expect_methodcallexpression293 // 1225
	ALIAS r4 $literalexpression299 // 1229
	LOAD $literalexpression299 "Invalid Witness" // 1229
	THROW $literalexpression299 // 1248
	@expect_methodcallexpression293: NOP // 1251
// Line 74:        Mail.registerDomain(from,domainName);
	ALIAS r3 $methodcallexpression301 // 1251
	COPY $domainName r4 // 1251
	PUSH r4 // 1254
	COPY $from r4 // 1256
	PUSH r4 // 1259
	LOAD $methodcallexpression301 "RegisterDomain" // 1261
	PUSH $methodcallexpression301 // 1279
	LOAD $methodcallexpression301 "mail" // 1281
	CTX $methodcallexpression301 $methodcallexpression301 // 1289
	SWITCH $methodcallexpression301 // 1292
@exit_register: // 1294
RET // 1295
// Line 75:
// Line 76:    }

// ********* testBool Method ***********
@entry_testBool: // 1296
// Line 77:
// Line 78:    public testBool(bRole:bool):type{
ALIAS r1 $bRole // 1297
POP $bRole // 1297
// Line 79:    
// Line 80:
// Line 81:        return $TYPE_OF(bRole);
	ALIAS r2 $literalexpression311 // 1299
	LOAD $literalexpression311 6 Enum // 1299
	PUSH $literalexpression311 // 1307
	JMP @exit_testBool // 1309
@exit_testBool: // 1312
RET // 1313
// Line 82:        
// Line 83:    }

// ********* convStrToBtyes Method ***********
@entry_convStrToBtyes: // 1314
// Line 84:    
// Line 85:    public convStrToBtyes(str:string):bytes{
ALIAS r1 $str // 1315
POP $str // 1315
// Line 86:        return String.toBytes(str);
	COPY $str r2 // 1317
	CAST r2 r2 #Bytes // 1320
	PUSH r2 // 1324
	JMP @exit_convStrToBtyes // 1326
@exit_convStrToBtyes: // 1329
RET // 1330
// Line 87:    }

// ********* testNumToBoolConversion Method ***********
@entry_testNumToBoolConversion: // 1331
// Line 88:
// Line 89:    public testNumToBoolConversion(num:number):bool{
ALIAS r1 $num // 1332
POP $num // 1332
CAST $num $num #Number // 1334
// Line 90:        local convNumToBool: bool = Number.toBool(num);
	ALIAS r2 $convNumToBool // 1338
	COPY $num r3 // 1338
	CAST r3 r3 #Bool // 1341
	COPY r3 $convNumToBool // 1345
// Line 91:        //local convNumToBool: bool = true;
// Line 92:        return convNumToBool;
	COPY $convNumToBool r3 // 1348
	PUSH r3 // 1351
	JMP @exit_testNumToBoolConversion // 1353
@exit_testNumToBoolConversion: // 1356
RET // 1357
// Line 93:    }

// ********* domainExist Method ***********
@entry_domainExist: // 1358
// Line 94:
// Line 95:
// Line 96:
// Line 97:    public domainExist(domainName:string): bool{
ALIAS r1 $domainName // 1359
POP $domainName // 1359
// Line 98:
// Line 99:        return Mail.domainExists(domainName);
	ALIAS r2 $methodcallexpression336 // 1361
	COPY $domainName r3 // 1361
	PUSH r3 // 1364
	LOAD $methodcallexpression336 "DomainExists" // 1366
	PUSH $methodcallexpression336 // 1382
	LOAD $methodcallexpression336 "mail" // 1384
	CTX $methodcallexpression336 $methodcallexpression336 // 1392
	SWITCH $methodcallexpression336 // 1395
	POP $methodcallexpression336 // 1397
	PUSH $methodcallexpression336 // 1399
	JMP @exit_domainExist // 1401
@exit_domainExist: // 1404
RET // 1405
// Line 100:    }

// ********* quotePrice Method ***********
@entry_quotePrice: // 1406
// Line 101:
// Line 102:    public quotePrice(baseSymbol:string, quoteSymbol:string, amount:number): number {
ALIAS r1 $baseSymbol // 1407
POP $baseSymbol // 1407
ALIAS r2 $quoteSymbol // 1409
POP $quoteSymbol // 1409
ALIAS r3 $amount // 1411
POP $amount // 1411
CAST $amount $amount #Number // 1413
// Line 103:        local qu: number = Oracle.quote(baseSymbol,quoteSymbol,amount);
	ALIAS r4 $qu // 1417
	ALIAS r5 $methodcallexpression348 // 1417
	COPY $amount r6 // 1417
	PUSH r6 // 1420
	COPY $quoteSymbol r6 // 1422
	PUSH r6 // 1425
	COPY $baseSymbol r6 // 1427
	PUSH r6 // 1430
	LOAD $methodcallexpression348 "Oracle.Quote" // 1432
	EXTCALL $methodcallexpression348 // 1448
	COPY $methodcallexpression348 $qu // 1450
// Line 104:       return qu;
	COPY $qu r5 // 1453
	PUSH r5 // 1456
	JMP @exit_quotePrice // 1458
@exit_quotePrice: // 1461
RET // 1462
// Line 105:    }

// ********* onUpgrade Trigger ***********
@entry_onUpgrade: // 1463
ALIAS r1 $dataGet // 1464
LOAD $dataGet "Data.Get" // 1464
ALIAS r2 $contractName // 1476
LOAD $contractName "provingground" // 1476
ALIAS r3 $_owner // 1493
// reading global: _owner
LOAD r0 8 // 1493
PUSH r0 // 1498
LOAD r0 "_owner" // 1500
PUSH r0 // 1510
PUSH $contractName // 1512
EXTCALL $dataGet // 1514
POP $_owner // 1516
PUSH $_owner // 1518
EXTCALL "Address()" // 1520
POP $_owner // 1535
// Line 106:
// Line 107:    trigger onUpgrade(from:address)
ALIAS r1 $from // 1537
POP $from // 1537
PUSH $from // 1539
EXTCALL "Address()" // 1541
POP $from // 1556
// Line 108:    {
// Line 109:        Runtime.expect(Runtime.isWitness(_owner), "Only the owner can update");
	ALIAS r2 $methodcallexpression367 // 1558
	COPY $_owner r4 // 1558
	PUSH r4 // 1561
	LOAD $methodcallexpression367 "Runtime.IsWitness" // 1563
	EXTCALL $methodcallexpression367 // 1584
	POP $methodcallexpression367 // 1586
	JMPIF $methodcallexpression367 @expect_methodcallexpression364 // 1588
	ALIAS r4 $literalexpression370 // 1592
	LOAD $literalexpression370 "Only the owner can update" // 1592
	THROW $literalexpression370 // 1621
	@expect_methodcallexpression364: NOP // 1624
// Line 110:        return;
	JMP @exit_onUpgrade // 1624
@exit_onUpgrade: // 1627
RET // 1628
// Line 111:    }

// ********* onKill Trigger ***********
@entry_onKill: // 1629
ALIAS r1 $dataGet // 1630
LOAD $dataGet "Data.Get" // 1630
ALIAS r2 $contractName // 1642
LOAD $contractName "provingground" // 1642
ALIAS r3 $_owner // 1659
// reading global: _owner
LOAD r0 8 // 1659
PUSH r0 // 1664
LOAD r0 "_owner" // 1666
PUSH r0 // 1676
PUSH $contractName // 1678
EXTCALL $dataGet // 1680
POP $_owner // 1682
PUSH $_owner // 1684
EXTCALL "Address()" // 1686
POP $_owner // 1701
// Line 112:    
// Line 113:    trigger onKill(from:address){
ALIAS r1 $from // 1703
POP $from // 1703
PUSH $from // 1705
EXTCALL "Address()" // 1707
POP $from // 1722
// Line 114:        Runtime.expect(Runtime.isWitness(_owner), "Only the owner can delete");
	ALIAS r2 $methodcallexpression380 // 1724
	COPY $_owner r4 // 1724
	PUSH r4 // 1727
	LOAD $methodcallexpression380 "Runtime.IsWitness" // 1729
	EXTCALL $methodcallexpression380 // 1750
	POP $methodcallexpression380 // 1752
	JMPIF $methodcallexpression380 @expect_methodcallexpression377 // 1754
	ALIAS r4 $literalexpression383 // 1758
	LOAD $literalexpression383 "Only the owner can delete" // 1758
	THROW $literalexpression383 // 1787
	@expect_methodcallexpression377: NOP // 1790
// Line 115:        return;
	JMP @exit_onKill // 1790
@exit_onKill: // 1793
RET // 1794
