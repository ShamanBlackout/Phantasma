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

// ********* decimalTest Method ***********
@entry_decimalTest: // 926
// Line 41:   
// Line 42:   /*****************************************************
// Line 43:    Not yet finished
// Line 44:   ******************************************************/
// Line 45:    public decimalTest(digits:number){
ALIAS r1 $digits // 927
POP $digits // 927
CAST $digits $digits #Number // 929
@exit_decimalTest: // 933
RET // 934
// Line 46:        //local val: decimal<digits>; appears that it is no possible to dynamically assign a decimal digit
// Line 47:
// Line 48:    }

// ********* logTest Method ***********
@entry_logTest: // 935
// Line 49:    public logTest(message:string){
ALIAS r1 $message // 936
POP $message // 936
// Line 50:        Runtime.log(message);
	ALIAS r2 $methodcallexpression234 // 938
	COPY $message r3 // 938
	PUSH r3 // 941
	LOAD $methodcallexpression234 "Runtime.Log" // 943
	EXTCALL $methodcallexpression234 // 958
@exit_logTest: // 960
RET // 961
// Line 51:    }

// ********* register Method ***********
@entry_register: // 962
// Line 52:
// Line 53:
// Line 54:    public register(from:address,domainName: string)
ALIAS r1 $from // 963
POP $from // 963
PUSH $from // 965
EXTCALL "Address()" // 967
POP $from // 982
ALIAS r2 $domainName // 984
POP $domainName // 984
// Line 55:    {   
// Line 56:        Runtime.expect(Runtime.isWitness(from),"Invalid Witness");
	ALIAS r3 $methodcallexpression247 // 986
	COPY $from r4 // 986
	PUSH r4 // 989
	LOAD $methodcallexpression247 "Runtime.IsWitness" // 991
	EXTCALL $methodcallexpression247 // 1012
	POP $methodcallexpression247 // 1014
	JMPIF $methodcallexpression247 @expect_methodcallexpression244 // 1016
	ALIAS r4 $literalexpression250 // 1020
	LOAD $literalexpression250 "Invalid Witness" // 1020
	THROW $literalexpression250 // 1039
	@expect_methodcallexpression244: NOP // 1042
// Line 57:        Mail.registerDomain(from,domainName);
	ALIAS r3 $methodcallexpression252 // 1042
	COPY $domainName r4 // 1042
	PUSH r4 // 1045
	COPY $from r4 // 1047
	PUSH r4 // 1050
	LOAD $methodcallexpression252 "RegisterDomain" // 1052
	PUSH $methodcallexpression252 // 1070
	LOAD $methodcallexpression252 "mail" // 1072
	CTX $methodcallexpression252 $methodcallexpression252 // 1080
	SWITCH $methodcallexpression252 // 1083
@exit_register: // 1085
RET // 1086
// Line 58:
// Line 59:    }

// ********* testBool Method ***********
@entry_testBool: // 1087
// Line 60:
// Line 61:    public testBool(bRole:bool):type{
ALIAS r1 $bRole // 1088
POP $bRole // 1088
// Line 62:    
// Line 63:
// Line 64:        return $TYPE_OF(bRole);
	ALIAS r2 $literalexpression262 // 1090
	LOAD $literalexpression262 6 Enum // 1090
	PUSH $literalexpression262 // 1098
	JMP @exit_testBool // 1100
@exit_testBool: // 1103
RET // 1104
// Line 65:        
// Line 66:    }

// ********* domainExist Method ***********
@entry_domainExist: // 1105
// Line 67:
// Line 68:    public domainExist(domainName:string): bool{
ALIAS r1 $domainName // 1106
POP $domainName // 1106
// Line 69:
// Line 70:        return Mail.domainExists(domainName);
	ALIAS r2 $methodcallexpression268 // 1108
	COPY $domainName r3 // 1108
	PUSH r3 // 1111
	LOAD $methodcallexpression268 "DomainExists" // 1113
	PUSH $methodcallexpression268 // 1129
	LOAD $methodcallexpression268 "mail" // 1131
	CTX $methodcallexpression268 $methodcallexpression268 // 1139
	SWITCH $methodcallexpression268 // 1142
	POP $methodcallexpression268 // 1144
	PUSH $methodcallexpression268 // 1146
	JMP @exit_domainExist // 1148
@exit_domainExist: // 1151
RET // 1152
// Line 71:    }

// ********* quotePrice Method ***********
@entry_quotePrice: // 1153
// Line 72:
// Line 73:    public quotePrice(baseSymbol:string, quoteSymbol:string, amount:number): number {
ALIAS r1 $baseSymbol // 1154
POP $baseSymbol // 1154
ALIAS r2 $quoteSymbol // 1156
POP $quoteSymbol // 1156
ALIAS r3 $amount // 1158
POP $amount // 1158
CAST $amount $amount #Number // 1160
// Line 74:        local qu: number = Oracle.quote(baseSymbol,quoteSymbol,amount);
	ALIAS r4 $qu // 1164
	ALIAS r5 $methodcallexpression280 // 1164
	COPY $amount r6 // 1164
	PUSH r6 // 1167
	COPY $quoteSymbol r6 // 1169
	PUSH r6 // 1172
	COPY $baseSymbol r6 // 1174
	PUSH r6 // 1177
	LOAD $methodcallexpression280 "Oracle.Quote" // 1179
	EXTCALL $methodcallexpression280 // 1195
	COPY $methodcallexpression280 $qu // 1197
// Line 75:       return qu;
	COPY $qu r5 // 1200
	PUSH r5 // 1203
	JMP @exit_quotePrice // 1205
@exit_quotePrice: // 1208
RET // 1209
// Line 76:    }

// ********* onUpgrade Trigger ***********
@entry_onUpgrade: // 1210
ALIAS r1 $dataGet // 1211
LOAD $dataGet "Data.Get" // 1211
ALIAS r2 $contractName // 1223
LOAD $contractName "provingground" // 1223
ALIAS r3 $_owner // 1240
// reading global: _owner
LOAD r0 8 // 1240
PUSH r0 // 1245
LOAD r0 "_owner" // 1247
PUSH r0 // 1257
PUSH $contractName // 1259
EXTCALL $dataGet // 1261
POP $_owner // 1263
PUSH $_owner // 1265
EXTCALL "Address()" // 1267
POP $_owner // 1282
// Line 77:
// Line 78:    trigger onUpgrade(from:address)
ALIAS r1 $from // 1284
POP $from // 1284
PUSH $from // 1286
EXTCALL "Address()" // 1288
POP $from // 1303
// Line 79:    {
// Line 80:        Runtime.expect(Runtime.isWitness(_owner), "Only the owner can update");
	ALIAS r2 $methodcallexpression299 // 1305
	COPY $_owner r4 // 1305
	PUSH r4 // 1308
	LOAD $methodcallexpression299 "Runtime.IsWitness" // 1310
	EXTCALL $methodcallexpression299 // 1331
	POP $methodcallexpression299 // 1333
	JMPIF $methodcallexpression299 @expect_methodcallexpression296 // 1335
	ALIAS r4 $literalexpression302 // 1339
	LOAD $literalexpression302 "Only the owner can update" // 1339
	THROW $literalexpression302 // 1368
	@expect_methodcallexpression296: NOP // 1371
// Line 81:        return;
	JMP @exit_onUpgrade // 1371
@exit_onUpgrade: // 1374
RET // 1375
// Line 82:    }

// ********* onKill Trigger ***********
@entry_onKill: // 1376
ALIAS r1 $dataGet // 1377
LOAD $dataGet "Data.Get" // 1377
ALIAS r2 $contractName // 1389
LOAD $contractName "provingground" // 1389
ALIAS r3 $_owner // 1406
// reading global: _owner
LOAD r0 8 // 1406
PUSH r0 // 1411
LOAD r0 "_owner" // 1413
PUSH r0 // 1423
PUSH $contractName // 1425
EXTCALL $dataGet // 1427
POP $_owner // 1429
PUSH $_owner // 1431
EXTCALL "Address()" // 1433
POP $_owner // 1448
// Line 83:    
// Line 84:    trigger onKill(from:address){
ALIAS r1 $from // 1450
POP $from // 1450
PUSH $from // 1452
EXTCALL "Address()" // 1454
POP $from // 1469
// Line 85:        Runtime.expect(Runtime.isWitness(_owner), "Only the owner can delete");
	ALIAS r2 $methodcallexpression312 // 1471
	COPY $_owner r4 // 1471
	PUSH r4 // 1474
	LOAD $methodcallexpression312 "Runtime.IsWitness" // 1476
	EXTCALL $methodcallexpression312 // 1497
	POP $methodcallexpression312 // 1499
	JMPIF $methodcallexpression312 @expect_methodcallexpression309 // 1501
	ALIAS r4 $literalexpression315 // 1505
	LOAD $literalexpression315 "Only the owner can delete" // 1505
	THROW $literalexpression315 // 1534
	@expect_methodcallexpression309: NOP // 1537
// Line 86:        return;
	JMP @exit_onKill // 1537
@exit_onKill: // 1540
RET // 1541
