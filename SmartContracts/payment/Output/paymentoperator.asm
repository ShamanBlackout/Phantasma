// Line 1:
// Line 2:struct payment{
// Line 3:
// Line 4:
// Line 5:    fee: decimal<3>;
// Line 6:    price: decimal<2>;
// Line 7:    symbol: string;
// Line 8:
// Line 9:
// Line 10:
// Line 11:}
// Line 12:
// Line 13:
// Line 14:contract paymentoperator{
// Line 15: 
// Line 16:    import Runtime;
// Line 17:    import String;
// Line 18:    import Map;
// Line 19:    import Oracle;
// Line 20:    import Token;
// Line 21:
// Line 22:    global _owner: address;
// Line 23:    global acceptablePayments: storage_map<string,bool>;//symbol and bool ex: SOUL: true -> then payment is acceptable

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
// clearing acceptablePayments storage
LOAD r0 "acceptablePayments" // 94
PUSH r0 // 116
LOAD r0 "Map.Clear" // 118
EXTCALL r0 // 131
// Line 24:    //global owners: storage_map<>;
// Line 25:
// Line 26:    constructor(owner:address){
ALIAS r2 $owner // 133
POP $owner // 133
PUSH $owner // 135
EXTCALL "Address()" // 137
POP $owner // 152
// Line 27:        _owner = owner;
	COPY $owner r3 // 154
	COPY r3 $_owner // 157
@exit_constructor: // 160
LOAD r2 "Data.Set" // 161
// writing global: _owner
PUSH $_owner // 173
LOAD r0 "_owner" // 175
PUSH r0 // 185
EXTCALL r2 // 187
RET // 189
// Line 28:    }

// ********* addOrRemovePayment Method ***********
@entry_addOrRemovePayment: // 190
ALIAS r1 $dataGet // 191
LOAD $dataGet "Data.Get" // 191
ALIAS r2 $contractName // 203
LOAD $contractName "paymentoperator" // 203
ALIAS r3 $_owner // 222
// reading global: _owner
LOAD r0 8 // 222
PUSH r0 // 227
LOAD r0 "_owner" // 229
PUSH r0 // 239
PUSH $contractName // 241
EXTCALL $dataGet // 243
POP $_owner // 245
PUSH $_owner // 247
EXTCALL "Address()" // 249
POP $_owner // 264
// Line 29:
// Line 30:
// Line 31:    private addOrRemovePayment(symbol:string,choice:string){
ALIAS r1 $symbol // 266
POP $symbol // 266
ALIAS r2 $choice // 268
POP $choice // 268
// Line 32:        Runtime.expect(Runtime.isWitness(_owner), "Unauthorized user");
	ALIAS r4 $methodcallexpression153 // 270
	COPY $_owner r5 // 270
	PUSH r5 // 273
	LOAD $methodcallexpression153 "Runtime.IsWitness" // 275
	EXTCALL $methodcallexpression153 // 296
	POP $methodcallexpression153 // 298
	JMPIF $methodcallexpression153 @expect_methodcallexpression150 // 300
	ALIAS r5 $literalexpression156 // 304
	LOAD $literalexpression156 "Unauthorized user" // 304
	THROW $literalexpression156 // 325
	@expect_methodcallexpression150: NOP // 328
// Line 33:        Runtime.expect(Token.exists(symbol),"Only a Token or NFT can be added as payment");
	ALIAS r4 $methodcallexpression161 // 328
	COPY $symbol r5 // 328
	PUSH r5 // 331
	LOAD $methodcallexpression161 "Runtime.TokenExists" // 333
	EXTCALL $methodcallexpression161 // 356
	POP $methodcallexpression161 // 358
	JMPIF $methodcallexpression161 @expect_methodcallexpression158 // 360
	ALIAS r5 $literalexpression164 // 364
	LOAD $literalexpression164 "Only a Token or NFT can be added as payment" // 364
	THROW $literalexpression164 // 411
	@expect_methodcallexpression158: NOP // 414
// Line 34:        if(symbol == "add"){
	COPY $symbol r4 // 414
	ALIAS r5 $literalexpression167 // 417
	LOAD $literalexpression167 "add" // 417
	EQUAL r4 $literalexpression167 r6 // 424
		JMPNOT r6 @then_ifstatement165 // 428
// Line 35:            acceptablePayments.set(symbol,true);
		ALIAS r4 $methodcallexpression183 // 432
		ALIAS r5 $literalexpression191 // 432
		LOAD $literalexpression191 true // 432
		PUSH $literalexpression191 // 437
		COPY $symbol r5 // 439
		PUSH r5 // 442
		ALIAS r5 $literalexpression189 // 444
		LOAD $literalexpression189 "acceptablePayments" // 444
		PUSH $literalexpression189 // 466
		LOAD $methodcallexpression183 "Map.Set" // 468
		EXTCALL $methodcallexpression183 // 479
		@then_ifstatement165: NOP // 482
// Line 36:        }
// Line 37:        if(symbol == "remove"){
	COPY $symbol r4 // 482
	ALIAS r5 $literalexpression194 // 485
	LOAD $literalexpression194 "remove" // 485
	EQUAL r4 $literalexpression194 r6 // 495
		JMPNOT r6 @then_ifstatement192 // 499
// Line 38:            acceptablePayments.remove(symbol);
		ALIAS r4 $methodcallexpression198 // 503
		COPY $symbol r5 // 503
		PUSH r5 // 506
		ALIAS r5 $literalexpression202 // 508
		LOAD $literalexpression202 "acceptablePayments" // 508
		PUSH $literalexpression202 // 530
		LOAD $methodcallexpression198 "Map.Remove" // 532
		EXTCALL $methodcallexpression198 // 546
		@then_ifstatement192: NOP // 549
@exit_addOrRemovePayment: // 549
RET // 550
// Line 39:        }
// Line 40:    }

// ********* addAcceptablePayment Method ***********
@entry_addAcceptablePayment: // 551
// Line 41:
// Line 42:    /******************************************************************
// Line 43:        !Design Choice:
// Line 44:            Will create 2 different functions for user simplicity
// Line 45:            Allows a user to call the smart contract without having to - 
// Line 46:            input parameters that decide whether to add or remove
// Line 47:    *******************************************************************/
// Line 48:    public addAcceptablePayment(symbol:string ,from:address){
ALIAS r1 $symbol // 552
POP $symbol // 552
ALIAS r2 $from // 554
POP $from // 554
PUSH $from // 556
EXTCALL "Address()" // 558
POP $from // 573
// Line 49:        Runtime.expect(!acceptablePayments.has(symbol),"Symbol has already been added as an acceptable form of payment");
	LOAD r3 6 // field type // 575
	PUSH r3 // 580
	COPY $symbol r4 // 582
	PUSH r4 // 585
	ALIAS r4 $literalexpression218 // 587
	LOAD $literalexpression218 "acceptablePayments" // 587
	PUSH $literalexpression218 // 609
	LOAD $literalexpression218 "paymentoperator" // contract name // 611
	PUSH $literalexpression218 // 630
	LOAD r3 "Map.Has" // 632
	EXTCALL r3 // 643
	POP r3 // 645
	NOT r3 r3 // 647
	JMPIF r3 @expect_methodcallexpression211 // 650
	ALIAS r4 $literalexpression221 // 654
	LOAD $literalexpression221 "Symbol has already been added as an acceptable form of payment" // 654
	THROW $literalexpression221 // 720
	@expect_methodcallexpression211: NOP // 723
// Line 50:        this.addOrRemovePayment(symbol,"add");
	ALIAS r3 $methodcallexpression223 // 723
	ALIAS r4 $literalexpression227 // 723
	LOAD $literalexpression227 "add" // 723
	PUSH $literalexpression227 // 730
	COPY $symbol r4 // 732
	PUSH r4 // 735
	CALL @entry_addOrRemovePayment // 737
@exit_addAcceptablePayment: // 741
RET // 742
// Line 51:
// Line 52:    }

// ********* removeAcceptablePayment Method ***********
@entry_removeAcceptablePayment: // 743
// Line 53:     public removeAcceptablePayment(symbol:string ,from:address){
ALIAS r1 $symbol // 744
POP $symbol // 744
ALIAS r2 $from // 746
POP $from // 746
PUSH $from // 748
EXTCALL "Address()" // 750
POP $from // 765
// Line 54:        Runtime.expect(acceptablePayments.has(symbol),"Symbol has not been added as an acceptable form of payment");
	LOAD r3 6 // field type // 767
	PUSH r3 // 772
	COPY $symbol r4 // 774
	PUSH r4 // 777
	ALIAS r4 $literalexpression242 // 779
	LOAD $literalexpression242 "acceptablePayments" // 779
	PUSH $literalexpression242 // 801
	LOAD $literalexpression242 "paymentoperator" // contract name // 803
	PUSH $literalexpression242 // 822
	LOAD r3 "Map.Has" // 824
	EXTCALL r3 // 835
	POP r3 // 837
	JMPIF r3 @expect_methodcallexpression235 // 839
	ALIAS r4 $literalexpression244 // 843
	LOAD $literalexpression244 "Symbol has not been added as an acceptable form of payment" // 843
	THROW $literalexpression244 // 905
	@expect_methodcallexpression235: NOP // 908
// Line 55:        this.addOrRemovePayment(symbol,"remove");
	ALIAS r3 $methodcallexpression246 // 908
	ALIAS r4 $literalexpression250 // 908
	LOAD $literalexpression250 "remove" // 908
	PUSH $literalexpression250 // 918
	COPY $symbol r4 // 920
	PUSH r4 // 923
	CALL @entry_addOrRemovePayment // 925
@exit_removeAcceptablePayment: // 929
RET // 930
// Line 56:
// Line 57:    }

// ********* checkPrice Method ***********
@entry_checkPrice: // 931
// Line 58:
// Line 59:    /************************************************************************************************
// Line 60:    Not sure how to use Oracles yet. Plan was to use Oracles to check price of given token
// Line 61:    and return that token.
// Line 62:    ************************************************************************************************/
// Line 63:    public checkPrice(symbol: string):number{
ALIAS r1 $symbol // 932
POP $symbol // 932
// Line 64:        local price: number = Oracle.price(symbol);
	ALIAS r2 $price // 934
	ALIAS r3 $methodcallexpression255 // 934
	COPY $symbol r4 // 934
	PUSH r4 // 937
	LOAD $methodcallexpression255 "Oracle.Price" // 939
	EXTCALL $methodcallexpression255 // 955
	COPY $methodcallexpression255 $price // 957
// Line 65:        return price;
	COPY $price r3 // 960
	PUSH r3 // 963
	JMP @exit_checkPrice // 965
@exit_checkPrice: // 968
RET // 969
// Line 66:    }

// ********* quotePrice Method ***********
@entry_quotePrice: // 970
// Line 67:
// Line 68:
// Line 69:    public quotePrice(baseSymbol:string, quoteSymbol:string, amount:number): number {
ALIAS r1 $baseSymbol // 971
POP $baseSymbol // 971
ALIAS r2 $quoteSymbol // 973
POP $quoteSymbol // 973
ALIAS r3 $amount // 975
POP $amount // 975
CAST $amount $amount #Number // 977
// Line 70:        local qu: number = Oracle.quote(baseSymbol,quoteSymbol,amount);
	ALIAS r4 $qu // 981
	ALIAS r5 $methodcallexpression270 // 981
	COPY $amount r6 // 981
	PUSH r6 // 984
	COPY $quoteSymbol r6 // 986
	PUSH r6 // 989
	COPY $baseSymbol r6 // 991
	PUSH r6 // 994
	LOAD $methodcallexpression270 "Oracle.Quote" // 996
	EXTCALL $methodcallexpression270 // 1012
	COPY $methodcallexpression270 $qu // 1014
// Line 71:       return qu;
	COPY $qu r5 // 1017
	PUSH r5 // 1020
	JMP @exit_quotePrice // 1022
@exit_quotePrice: // 1025
RET // 1026
// Line 72:    }

// ********* onUpgrade Trigger ***********
@entry_onUpgrade: // 1027
ALIAS r1 $dataGet // 1028
LOAD $dataGet "Data.Get" // 1028
ALIAS r2 $contractName // 1040
LOAD $contractName "paymentoperator" // 1040
ALIAS r3 $_owner // 1059
// reading global: _owner
LOAD r0 8 // 1059
PUSH r0 // 1064
LOAD r0 "_owner" // 1066
PUSH r0 // 1076
PUSH $contractName // 1078
EXTCALL $dataGet // 1080
POP $_owner // 1082
PUSH $_owner // 1084
EXTCALL "Address()" // 1086
POP $_owner // 1101
// Line 73:
// Line 74:    trigger onUpgrade(from:address)
ALIAS r1 $from // 1103
POP $from // 1103
PUSH $from // 1105
EXTCALL "Address()" // 1107
POP $from // 1122
// Line 75:    {
// Line 76:        Runtime.expect(Runtime.isWitness(_owner), "Only the owner can update");
	ALIAS r2 $methodcallexpression289 // 1124
	COPY $_owner r4 // 1124
	PUSH r4 // 1127
	LOAD $methodcallexpression289 "Runtime.IsWitness" // 1129
	EXTCALL $methodcallexpression289 // 1150
	POP $methodcallexpression289 // 1152
	JMPIF $methodcallexpression289 @expect_methodcallexpression286 // 1154
	ALIAS r4 $literalexpression292 // 1158
	LOAD $literalexpression292 "Only the owner can update" // 1158
	THROW $literalexpression292 // 1187
	@expect_methodcallexpression286: NOP // 1190
// Line 77:        return;
	JMP @exit_onUpgrade // 1190
@exit_onUpgrade: // 1193
RET // 1194
// Line 78:    }

// ********* onKill Trigger ***********
@entry_onKill: // 1195
ALIAS r1 $dataGet // 1196
LOAD $dataGet "Data.Get" // 1196
ALIAS r2 $contractName // 1208
LOAD $contractName "paymentoperator" // 1208
ALIAS r3 $_owner // 1227
// reading global: _owner
LOAD r0 8 // 1227
PUSH r0 // 1232
LOAD r0 "_owner" // 1234
PUSH r0 // 1244
PUSH $contractName // 1246
EXTCALL $dataGet // 1248
POP $_owner // 1250
PUSH $_owner // 1252
EXTCALL "Address()" // 1254
POP $_owner // 1269
// Line 79:    
// Line 80:    trigger onKill(from:address){
ALIAS r1 $from // 1271
POP $from // 1271
PUSH $from // 1273
EXTCALL "Address()" // 1275
POP $from // 1290
// Line 81:        Runtime.expect(Runtime.isWitness(_owner), "Only the owner can delete");
	ALIAS r2 $methodcallexpression302 // 1292
	COPY $_owner r4 // 1292
	PUSH r4 // 1295
	LOAD $methodcallexpression302 "Runtime.IsWitness" // 1297
	EXTCALL $methodcallexpression302 // 1318
	POP $methodcallexpression302 // 1320
	JMPIF $methodcallexpression302 @expect_methodcallexpression299 // 1322
	ALIAS r4 $literalexpression305 // 1326
	LOAD $literalexpression305 "Only the owner can delete" // 1326
	THROW $literalexpression305 // 1355
	@expect_methodcallexpression299: NOP // 1358
// Line 82:        return;
	JMP @exit_onKill // 1358
@exit_onKill: // 1361
RET // 1362
