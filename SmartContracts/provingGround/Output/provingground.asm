// Line 1:
// Line 2:contract provingground{
// Line 3: 
// Line 4:    import Runtime;
// Line 5:    import Oracle;
// Line 6:    import Mail;
// Line 7:
// Line 8:    global _owner: address;

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
// Line 9:
// Line 10:    constructor(owner:address){
ALIAS r2 $owner // 94
POP $owner // 94
PUSH $owner // 96
EXTCALL "Address()" // 98
POP $owner // 113
// Line 11:        _owner = owner;
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
// Line 12:    }

// ********* checkPrice Method ***********
@entry_checkPrice: // 151
// Line 13:
// Line 14:
// Line 15:    /************************************************************************************************
// Line 16:    Not sure how to use Oracles yet. Plan was to use Oracles to check price of given token
// Line 17:    and return that token.
// Line 18:    ************************************************************************************************/
// Line 19:    public checkPrice(symbol: string):number{
ALIAS r1 $symbol // 152
POP $symbol // 152
// Line 20:        local price: number = Oracle.price(symbol);
	ALIAS r2 $price // 154
	ALIAS r3 $methodcallexpression91 // 154
	COPY $symbol r4 // 154
	PUSH r4 // 157
	LOAD $methodcallexpression91 "Oracle.Price" // 159
	EXTCALL $methodcallexpression91 // 175
	COPY $methodcallexpression91 $price // 177
// Line 21:        return price;
	COPY $price r3 // 180
	PUSH r3 // 183
	JMP @exit_checkPrice // 185
@exit_checkPrice: // 188
RET // 189
// Line 22:    }

// ********* sendMsg Method ***********
@entry_sendMsg: // 190
// Line 23:
// Line 24:    public sendMsg(from:address, target:address, archiveHash:hash){
ALIAS r1 $from // 191
POP $from // 191
PUSH $from // 193
EXTCALL "Address()" // 195
POP $from // 210
ALIAS r2 $target // 212
POP $target // 212
PUSH $target // 214
EXTCALL "Address()" // 216
POP $target // 231
ALIAS r3 $archiveHash // 233
POP $archiveHash // 233
PUSH $archiveHash // 235
EXTCALL "Hash()" // 237
POP $archiveHash // 249
// Line 25:        local convToHash :hash = archiveHash;
	ALIAS r4 $convToHash // 251
	COPY $archiveHash r5 // 251
	COPY r5 $convToHash // 254
// Line 26:        Mail.pushMessage(from, target, convToHash);
	ALIAS r5 $methodcallexpression110 // 257
	COPY $convToHash r6 // 257
	PUSH r6 // 260
	COPY $target r6 // 262
	PUSH r6 // 265
	COPY $from r6 // 267
	PUSH r6 // 270
	LOAD $methodcallexpression110 "PushMessage" // 272
	PUSH $methodcallexpression110 // 287
	LOAD $methodcallexpression110 "mail" // 289
	CTX $methodcallexpression110 $methodcallexpression110 // 297
	SWITCH $methodcallexpression110 // 300
@exit_sendMsg: // 302
RET // 303
// Line 27:    }

// ********* testAllTypes Method ***********
@entry_testAllTypes: // 304
// Line 28:
// Line 29:    //deprecated since Hash has issues
// Line 30:    public testAllTypes(str:string, truthy:bool,num:number,stamp:timestamp,bytArr:bytes,addy:address,hashish: hash): string{
ALIAS r1 $str // 305
POP $str // 305
ALIAS r2 $truthy // 307
POP $truthy // 307
ALIAS r3 $num // 309
POP $num // 309
CAST $num $num #Number // 311
ALIAS r4 $stamp // 315
POP $stamp // 315
PUSH $stamp // 317
EXTCALL "Timestamp()" // 319
POP $stamp // 336
ALIAS r5 $bytArr // 338
POP $bytArr // 338
ALIAS r6 $addy // 340
POP $addy // 340
PUSH $addy // 342
EXTCALL "Address()" // 344
POP $addy // 359
ALIAS r7 $hashish // 361
POP $hashish // 361
PUSH $hashish // 363
EXTCALL "Hash()" // 365
POP $hashish // 377
// Line 31:
// Line 32:        local type_str ="Type of str: " +$TYPE_OF(str) + " Type of truthy: " +$TYPE_OF(truthy) +" Type of stamp: " +$TYPE_OF(stamp) +" Type of bytArr: " +$TYPE_OF(bytArr) + " Type of addy: " +$TYPE_OF(addy) +" Type of num: " +$TYPE_OF(num);
	ALIAS r8 $type_str // 379
	ALIAS r9 $literalexpression133 // 379
	LOAD $literalexpression133 "Type of str: " // 379
	ALIAS r10 $literalexpression135 // 396
	LOAD $literalexpression135 4 Enum // 396
	CAST $literalexpression135 $literalexpression135 #String // 404
	ADD $literalexpression133 $literalexpression135 r11 // 408
	ALIAS r9 $literalexpression138 // 412
	LOAD $literalexpression138 " Type of truthy: " // 412
	ALIAS r10 $literalexpression140 // 433
	LOAD $literalexpression140 6 Enum // 433
	CAST $literalexpression140 $literalexpression140 #String // 441
	ADD $literalexpression138 $literalexpression140 r12 // 445
	ALIAS r9 $literalexpression143 // 449
	LOAD $literalexpression143 " Type of stamp: " // 449
	ALIAS r10 $literalexpression145 // 469
	LOAD $literalexpression145 5 Enum // 469
	CAST $literalexpression145 $literalexpression145 #String // 477
	ADD $literalexpression143 $literalexpression145 r13 // 481
	ALIAS r9 $literalexpression148 // 485
	LOAD $literalexpression148 " Type of bytArr: " // 485
	ALIAS r10 $literalexpression150 // 506
	LOAD $literalexpression150 2 Enum // 506
	CAST $literalexpression150 $literalexpression150 #String // 514
	ADD $literalexpression148 $literalexpression150 r14 // 518
	ALIAS r9 $literalexpression153 // 522
	LOAD $literalexpression153 " Type of addy: " // 522
	ALIAS r10 $literalexpression155 // 541
	LOAD $literalexpression155 8 Enum // 541
	CAST $literalexpression155 $literalexpression155 #String // 549
	ADD $literalexpression153 $literalexpression155 r15 // 553
	ALIAS r9 $literalexpression158 // 557
	LOAD $literalexpression158 " Type of num: " // 557
	ALIAS r10 $literalexpression160 // 575
	LOAD $literalexpression160 3 Enum // 575
	CAST $literalexpression160 $literalexpression160 #String // 583
	ADD $literalexpression158 $literalexpression160 r16 // 587
	ADD r15 r16 r9 // 591
	ADD r14 r9 r10 // 595
	ADD r13 r10 r9 // 599
	ADD r12 r9 r10 // 603
	ADD r11 r10 r9 // 607
	COPY r9 $type_str // 611
// Line 33:        return type_str;
	COPY $type_str r9 // 614
	PUSH r9 // 617
	JMP @exit_testAllTypes // 619
@exit_testAllTypes: // 622
RET // 623
// Line 34:    }

// ********* testAllTypes2 Method ***********
@entry_testAllTypes2: // 624
// Line 35:
// Line 36:    public testAllTypes2(str:string, truthy:bool,num:number,stamp:timestamp,bytArr:bytes,addy:address): string{
ALIAS r1 $str // 625
POP $str // 625
ALIAS r2 $truthy // 627
POP $truthy // 627
ALIAS r3 $num // 629
POP $num // 629
CAST $num $num #Number // 631
ALIAS r4 $stamp // 635
POP $stamp // 635
PUSH $stamp // 637
EXTCALL "Timestamp()" // 639
POP $stamp // 656
ALIAS r5 $bytArr // 658
POP $bytArr // 658
ALIAS r6 $addy // 660
POP $addy // 660
PUSH $addy // 662
EXTCALL "Address()" // 664
POP $addy // 679
// Line 37:
// Line 38:        local type_str ="Type of str: " +$TYPE_OF(str) + " Type of truthy: " +$TYPE_OF(truthy) +" Type of stamp: " +$TYPE_OF(stamp) +" Type of bytArr: " +$TYPE_OF(bytArr) + " Type of addy: " +$TYPE_OF(addy) +" Type of num: " +$TYPE_OF(num);
	ALIAS r7 $type_str // 681
	ALIAS r8 $literalexpression186 // 681
	LOAD $literalexpression186 "Type of str: " // 681
	ALIAS r9 $literalexpression188 // 698
	LOAD $literalexpression188 4 Enum // 698
	CAST $literalexpression188 $literalexpression188 #String // 706
	ADD $literalexpression186 $literalexpression188 r10 // 710
	ALIAS r8 $literalexpression191 // 714
	LOAD $literalexpression191 " Type of truthy: " // 714
	ALIAS r9 $literalexpression193 // 735
	LOAD $literalexpression193 6 Enum // 735
	CAST $literalexpression193 $literalexpression193 #String // 743
	ADD $literalexpression191 $literalexpression193 r11 // 747
	ALIAS r8 $literalexpression196 // 751
	LOAD $literalexpression196 " Type of stamp: " // 751
	ALIAS r9 $literalexpression198 // 771
	LOAD $literalexpression198 5 Enum // 771
	CAST $literalexpression198 $literalexpression198 #String // 779
	ADD $literalexpression196 $literalexpression198 r12 // 783
	ALIAS r8 $literalexpression201 // 787
	LOAD $literalexpression201 " Type of bytArr: " // 787
	ALIAS r9 $literalexpression203 // 808
	LOAD $literalexpression203 2 Enum // 808
	CAST $literalexpression203 $literalexpression203 #String // 816
	ADD $literalexpression201 $literalexpression203 r13 // 820
	ALIAS r8 $literalexpression206 // 824
	LOAD $literalexpression206 " Type of addy: " // 824
	ALIAS r9 $literalexpression208 // 843
	LOAD $literalexpression208 8 Enum // 843
	CAST $literalexpression208 $literalexpression208 #String // 851
	ADD $literalexpression206 $literalexpression208 r14 // 855
	ALIAS r8 $literalexpression211 // 859
	LOAD $literalexpression211 " Type of num: " // 859
	ALIAS r9 $literalexpression213 // 877
	LOAD $literalexpression213 3 Enum // 877
	CAST $literalexpression213 $literalexpression213 #String // 885
	ADD $literalexpression211 $literalexpression213 r15 // 889
	ADD r14 r15 r8 // 893
	ADD r13 r8 r9 // 897
	ADD r12 r9 r8 // 901
	ADD r11 r8 r9 // 905
	ADD r10 r9 r8 // 909
	COPY r8 $type_str // 913
// Line 39:        return type_str;
	COPY $type_str r8 // 916
	PUSH r8 // 919
	JMP @exit_testAllTypes2 // 921
@exit_testAllTypes2: // 924
RET // 925
// Line 40:    }

// ********* register Method ***********
@entry_register: // 926
// Line 41:   
// Line 42:    
// Line 43:    public register(from:address,domainName: string)
ALIAS r1 $from // 927
POP $from // 927
PUSH $from // 929
EXTCALL "Address()" // 931
POP $from // 946
ALIAS r2 $domainName // 948
POP $domainName // 948
// Line 44:    {   
// Line 45:        Runtime.expect(Runtime.isWitness(from),"Invalid Witness");
	ALIAS r3 $methodcallexpression235 // 950
	COPY $from r4 // 950
	PUSH r4 // 953
	LOAD $methodcallexpression235 "Runtime.IsWitness" // 955
	EXTCALL $methodcallexpression235 // 976
	POP $methodcallexpression235 // 978
	JMPIF $methodcallexpression235 @expect_methodcallexpression232 // 980
	ALIAS r4 $literalexpression238 // 984
	LOAD $literalexpression238 "Invalid Witness" // 984
	THROW $literalexpression238 // 1003
	@expect_methodcallexpression232: NOP // 1006
// Line 46:        Mail.registerDomain(from,domainName);
	ALIAS r3 $methodcallexpression240 // 1006
	COPY $domainName r4 // 1006
	PUSH r4 // 1009
	COPY $from r4 // 1011
	PUSH r4 // 1014
	LOAD $methodcallexpression240 "RegisterDomain" // 1016
	PUSH $methodcallexpression240 // 1034
	LOAD $methodcallexpression240 "mail" // 1036
	CTX $methodcallexpression240 $methodcallexpression240 // 1044
	SWITCH $methodcallexpression240 // 1047
@exit_register: // 1049
RET // 1050
// Line 47:
// Line 48:    }

// ********* testBool Method ***********
@entry_testBool: // 1051
// Line 49:
// Line 50:    public testBool(bRole:bool):type{
ALIAS r1 $bRole // 1052
POP $bRole // 1052
// Line 51:    
// Line 52:
// Line 53:        return $TYPE_OF(bRole);
	ALIAS r2 $literalexpression250 // 1054
	LOAD $literalexpression250 6 Enum // 1054
	PUSH $literalexpression250 // 1062
	JMP @exit_testBool // 1064
@exit_testBool: // 1067
RET // 1068
// Line 54:        
// Line 55:    }

// ********* domainExist Method ***********
@entry_domainExist: // 1069
// Line 56:
// Line 57:    public domainExist(domainName:string): bool{
ALIAS r1 $domainName // 1070
POP $domainName // 1070
// Line 58:
// Line 59:        return Mail.domainExists(domainName);
	ALIAS r2 $methodcallexpression256 // 1072
	COPY $domainName r3 // 1072
	PUSH r3 // 1075
	LOAD $methodcallexpression256 "DomainExists" // 1077
	PUSH $methodcallexpression256 // 1093
	LOAD $methodcallexpression256 "mail" // 1095
	CTX $methodcallexpression256 $methodcallexpression256 // 1103
	SWITCH $methodcallexpression256 // 1106
	POP $methodcallexpression256 // 1108
	PUSH $methodcallexpression256 // 1110
	JMP @exit_domainExist // 1112
@exit_domainExist: // 1115
RET // 1116
// Line 60:    }

// ********* quotePrice Method ***********
@entry_quotePrice: // 1117
// Line 61:
// Line 62:    public quotePrice(baseSymbol:string, quoteSymbol:string, amount:number): number {
ALIAS r1 $baseSymbol // 1118
POP $baseSymbol // 1118
ALIAS r2 $quoteSymbol // 1120
POP $quoteSymbol // 1120
ALIAS r3 $amount // 1122
POP $amount // 1122
CAST $amount $amount #Number // 1124
// Line 63:        local qu: number = Oracle.quote(baseSymbol,quoteSymbol,amount);
	ALIAS r4 $qu // 1128
	ALIAS r5 $methodcallexpression268 // 1128
	COPY $amount r6 // 1128
	PUSH r6 // 1131
	COPY $quoteSymbol r6 // 1133
	PUSH r6 // 1136
	COPY $baseSymbol r6 // 1138
	PUSH r6 // 1141
	LOAD $methodcallexpression268 "Oracle.Quote" // 1143
	EXTCALL $methodcallexpression268 // 1159
	COPY $methodcallexpression268 $qu // 1161
// Line 64:       return qu;
	COPY $qu r5 // 1164
	PUSH r5 // 1167
	JMP @exit_quotePrice // 1169
@exit_quotePrice: // 1172
RET // 1173
// Line 65:    }

// ********* onUpgrade Trigger ***********
@entry_onUpgrade: // 1174
ALIAS r1 $dataGet // 1175
LOAD $dataGet "Data.Get" // 1175
ALIAS r2 $contractName // 1187
LOAD $contractName "provingground" // 1187
ALIAS r3 $_owner // 1204
// reading global: _owner
LOAD r0 8 // 1204
PUSH r0 // 1209
LOAD r0 "_owner" // 1211
PUSH r0 // 1221
PUSH $contractName // 1223
EXTCALL $dataGet // 1225
POP $_owner // 1227
PUSH $_owner // 1229
EXTCALL "Address()" // 1231
POP $_owner // 1246
// Line 66:
// Line 67:    trigger onUpgrade(from:address)
ALIAS r1 $from // 1248
POP $from // 1248
PUSH $from // 1250
EXTCALL "Address()" // 1252
POP $from // 1267
// Line 68:    {
// Line 69:        Runtime.expect(Runtime.isWitness(_owner), "Only the owner can update");
	ALIAS r2 $methodcallexpression287 // 1269
	COPY $_owner r4 // 1269
	PUSH r4 // 1272
	LOAD $methodcallexpression287 "Runtime.IsWitness" // 1274
	EXTCALL $methodcallexpression287 // 1295
	POP $methodcallexpression287 // 1297
	JMPIF $methodcallexpression287 @expect_methodcallexpression284 // 1299
	ALIAS r4 $literalexpression290 // 1303
	LOAD $literalexpression290 "Only the owner can update" // 1303
	THROW $literalexpression290 // 1332
	@expect_methodcallexpression284: NOP // 1335
// Line 70:        return;
	JMP @exit_onUpgrade // 1335
@exit_onUpgrade: // 1338
RET // 1339
// Line 71:    }

// ********* onKill Trigger ***********
@entry_onKill: // 1340
ALIAS r1 $dataGet // 1341
LOAD $dataGet "Data.Get" // 1341
ALIAS r2 $contractName // 1353
LOAD $contractName "provingground" // 1353
ALIAS r3 $_owner // 1370
// reading global: _owner
LOAD r0 8 // 1370
PUSH r0 // 1375
LOAD r0 "_owner" // 1377
PUSH r0 // 1387
PUSH $contractName // 1389
EXTCALL $dataGet // 1391
POP $_owner // 1393
PUSH $_owner // 1395
EXTCALL "Address()" // 1397
POP $_owner // 1412
// Line 72:    
// Line 73:    trigger onKill(from:address){
ALIAS r1 $from // 1414
POP $from // 1414
PUSH $from // 1416
EXTCALL "Address()" // 1418
POP $from // 1433
// Line 74:        Runtime.expect(Runtime.isWitness(_owner), "Only the owner can delete");
	ALIAS r2 $methodcallexpression300 // 1435
	COPY $_owner r4 // 1435
	PUSH r4 // 1438
	LOAD $methodcallexpression300 "Runtime.IsWitness" // 1440
	EXTCALL $methodcallexpression300 // 1461
	POP $methodcallexpression300 // 1463
	JMPIF $methodcallexpression300 @expect_methodcallexpression297 // 1465
	ALIAS r4 $literalexpression303 // 1469
	LOAD $literalexpression303 "Only the owner can delete" // 1469
	THROW $literalexpression303 // 1498
	@expect_methodcallexpression297: NOP // 1501
// Line 75:        return;
	JMP @exit_onKill // 1501
@exit_onKill: // 1504
RET // 1505
