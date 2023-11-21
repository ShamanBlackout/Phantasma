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
// Line 29:    public testAllTypes(str:string, truthy:bool,num:number,stamp:timestamp,bytArr:bytes,addy:address,hashish: hash): string{
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
// Line 30:
// Line 31:        local type_str ="Type of str: " +$TYPE_OF(str) + " Type of truthy: " +$TYPE_OF(truthy) +" Type of stamp: " +$TYPE_OF(stamp) +" Type of bytArr: " +$TYPE_OF(bytArr) + " Type of addy: " +$TYPE_OF(addy) +" Type of hashish: " +$TYPE_OF(hashish)+" Type of num: " +$TYPE_OF(num);
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
	LOAD $literalexpression158 " Type of hashish: " // 557
	ALIAS r10 $literalexpression160 // 579
	LOAD $literalexpression160 2 Enum // 579
	CAST $literalexpression160 $literalexpression160 #String // 587
	ADD $literalexpression158 $literalexpression160 r16 // 591
	ALIAS r9 $literalexpression163 // 595
	LOAD $literalexpression163 " Type of num: " // 595
	ALIAS r10 $literalexpression165 // 613
	LOAD $literalexpression165 3 Enum // 613
	CAST $literalexpression165 $literalexpression165 #String // 621
	ADD $literalexpression163 $literalexpression165 r17 // 625
	ADD r16 r17 r9 // 629
	ADD r15 r9 r10 // 633
	ADD r14 r10 r9 // 637
	ADD r13 r9 r10 // 641
	ADD r12 r10 r9 // 645
	ADD r11 r9 r10 // 649
	COPY r10 $type_str // 653
// Line 32:        return type_str;
	COPY $type_str r9 // 656
	PUSH r9 // 659
	JMP @exit_testAllTypes // 661
@exit_testAllTypes: // 664
RET // 665
// Line 33:    }

// ********* register Method ***********
@entry_register: // 666
// Line 34:   
// Line 35:    
// Line 36:    public register(from:address,domainName: string)
ALIAS r1 $from // 667
POP $from // 667
PUSH $from // 669
EXTCALL "Address()" // 671
POP $from // 686
ALIAS r2 $domainName // 688
POP $domainName // 688
// Line 37:    {   
// Line 38:        Runtime.expect(Runtime.isWitness(from),"Invalid Witness");
	ALIAS r3 $methodcallexpression188 // 690
	COPY $from r4 // 690
	PUSH r4 // 693
	LOAD $methodcallexpression188 "Runtime.IsWitness" // 695
	EXTCALL $methodcallexpression188 // 716
	POP $methodcallexpression188 // 718
	JMPIF $methodcallexpression188 @expect_methodcallexpression185 // 720
	ALIAS r4 $literalexpression191 // 724
	LOAD $literalexpression191 "Invalid Witness" // 724
	THROW $literalexpression191 // 743
	@expect_methodcallexpression185: NOP // 746
// Line 39:        Mail.registerDomain(from,domainName);
	ALIAS r3 $methodcallexpression193 // 746
	COPY $domainName r4 // 746
	PUSH r4 // 749
	COPY $from r4 // 751
	PUSH r4 // 754
	LOAD $methodcallexpression193 "RegisterDomain" // 756
	PUSH $methodcallexpression193 // 774
	LOAD $methodcallexpression193 "mail" // 776
	CTX $methodcallexpression193 $methodcallexpression193 // 784
	SWITCH $methodcallexpression193 // 787
@exit_register: // 789
RET // 790
// Line 40:
// Line 41:    }

// ********* domainExist Method ***********
@entry_domainExist: // 791
// Line 42:
// Line 43:    public domainExist(domainName:string): bool{
ALIAS r1 $domainName // 792
POP $domainName // 792
// Line 44:
// Line 45:        return Mail.domainExists(domainName);
	ALIAS r2 $methodcallexpression202 // 794
	COPY $domainName r3 // 794
	PUSH r3 // 797
	LOAD $methodcallexpression202 "DomainExists" // 799
	PUSH $methodcallexpression202 // 815
	LOAD $methodcallexpression202 "mail" // 817
	CTX $methodcallexpression202 $methodcallexpression202 // 825
	SWITCH $methodcallexpression202 // 828
	POP $methodcallexpression202 // 830
	PUSH $methodcallexpression202 // 832
	JMP @exit_domainExist // 834
@exit_domainExist: // 837
RET // 838
// Line 46:    }

// ********* quotePrice Method ***********
@entry_quotePrice: // 839
// Line 47:
// Line 48:    public quotePrice(baseSymbol:string, quoteSymbol:string, amount:number): number {
ALIAS r1 $baseSymbol // 840
POP $baseSymbol // 840
ALIAS r2 $quoteSymbol // 842
POP $quoteSymbol // 842
ALIAS r3 $amount // 844
POP $amount // 844
CAST $amount $amount #Number // 846
// Line 49:        local qu: number = Oracle.quote(baseSymbol,quoteSymbol,amount);
	ALIAS r4 $qu // 850
	ALIAS r5 $methodcallexpression214 // 850
	COPY $amount r6 // 850
	PUSH r6 // 853
	COPY $quoteSymbol r6 // 855
	PUSH r6 // 858
	COPY $baseSymbol r6 // 860
	PUSH r6 // 863
	LOAD $methodcallexpression214 "Oracle.Quote" // 865
	EXTCALL $methodcallexpression214 // 881
	COPY $methodcallexpression214 $qu // 883
// Line 50:       return qu;
	COPY $qu r5 // 886
	PUSH r5 // 889
	JMP @exit_quotePrice // 891
@exit_quotePrice: // 894
RET // 895
// Line 51:    }

// ********* onUpgrade Trigger ***********
@entry_onUpgrade: // 896
ALIAS r1 $dataGet // 897
LOAD $dataGet "Data.Get" // 897
ALIAS r2 $contractName // 909
LOAD $contractName "provingground" // 909
ALIAS r3 $_owner // 926
// reading global: _owner
LOAD r0 8 // 926
PUSH r0 // 931
LOAD r0 "_owner" // 933
PUSH r0 // 943
PUSH $contractName // 945
EXTCALL $dataGet // 947
POP $_owner // 949
PUSH $_owner // 951
EXTCALL "Address()" // 953
POP $_owner // 968
// Line 52:
// Line 53:    trigger onUpgrade(from:address)
ALIAS r1 $from // 970
POP $from // 970
PUSH $from // 972
EXTCALL "Address()" // 974
POP $from // 989
// Line 54:    {
// Line 55:        Runtime.expect(Runtime.isWitness(_owner), "Only the owner can update");
	ALIAS r2 $methodcallexpression233 // 991
	COPY $_owner r4 // 991
	PUSH r4 // 994
	LOAD $methodcallexpression233 "Runtime.IsWitness" // 996
	EXTCALL $methodcallexpression233 // 1017
	POP $methodcallexpression233 // 1019
	JMPIF $methodcallexpression233 @expect_methodcallexpression230 // 1021
	ALIAS r4 $literalexpression236 // 1025
	LOAD $literalexpression236 "Only the owner can update" // 1025
	THROW $literalexpression236 // 1054
	@expect_methodcallexpression230: NOP // 1057
// Line 56:        return;
	JMP @exit_onUpgrade // 1057
@exit_onUpgrade: // 1060
RET // 1061
// Line 57:    }

// ********* onKill Trigger ***********
@entry_onKill: // 1062
ALIAS r1 $dataGet // 1063
LOAD $dataGet "Data.Get" // 1063
ALIAS r2 $contractName // 1075
LOAD $contractName "provingground" // 1075
ALIAS r3 $_owner // 1092
// reading global: _owner
LOAD r0 8 // 1092
PUSH r0 // 1097
LOAD r0 "_owner" // 1099
PUSH r0 // 1109
PUSH $contractName // 1111
EXTCALL $dataGet // 1113
POP $_owner // 1115
PUSH $_owner // 1117
EXTCALL "Address()" // 1119
POP $_owner // 1134
// Line 58:    
// Line 59:    trigger onKill(from:address){
ALIAS r1 $from // 1136
POP $from // 1136
PUSH $from // 1138
EXTCALL "Address()" // 1140
POP $from // 1155
// Line 60:        Runtime.expect(Runtime.isWitness(_owner), "Only the owner can delete");
	ALIAS r2 $methodcallexpression246 // 1157
	COPY $_owner r4 // 1157
	PUSH r4 // 1160
	LOAD $methodcallexpression246 "Runtime.IsWitness" // 1162
	EXTCALL $methodcallexpression246 // 1183
	POP $methodcallexpression246 // 1185
	JMPIF $methodcallexpression246 @expect_methodcallexpression243 // 1187
	ALIAS r4 $literalexpression249 // 1191
	LOAD $literalexpression249 "Only the owner can delete" // 1191
	THROW $literalexpression249 // 1220
	@expect_methodcallexpression243: NOP // 1223
// Line 61:        return;
	JMP @exit_onKill // 1223
@exit_onKill: // 1226
RET // 1227
