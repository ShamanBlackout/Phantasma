// Line 1:
// Line 2:struct payment{
// Line 3:
// Line 4:
// Line 5:
// Line 6:
// Line 7:}
// Line 8:
// Line 9:
// Line 10:contract paymentoperator{
// Line 11: 
// Line 12:    import Runtime;
// Line 13:    import String;
// Line 14:    import Map;
// Line 15:    import Oracle;
// Line 16:    import Token;
// Line 17:
// Line 18:    global _owner: address;
// Line 19:    global acceptablePayments: storage_map<string,bool>;//symbol and bool ex: SOUL: true -> then payment is acceptable

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
// Line 20:    //global owners: storage_map<>;
// Line 21:
// Line 22:    constructor(owner:address){
ALIAS r2 $owner // 133
POP $owner // 133
PUSH $owner // 135
EXTCALL "Address()" // 137
POP $owner // 152
// Line 23:        _owner = owner;
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
// Line 24:    }

// ********* addOrRemovePayment Method ***********
@entry_addOrRemovePayment: // 190
// Line 25:
// Line 26:
// Line 27:    private addOrRemovePayment(symbol:string,choice:string){
ALIAS r1 $symbol // 191
POP $symbol // 191
ALIAS r2 $choice // 193
POP $choice // 193
// Line 28:        Runtime.expect(Token.exists(symbol),"Only a Token or NFT can be added as payment");
	ALIAS r3 $methodcallexpression150 // 195
	COPY $symbol r4 // 195
	PUSH r4 // 198
	LOAD $methodcallexpression150 "Runtime.TokenExists" // 200
	EXTCALL $methodcallexpression150 // 223
	POP $methodcallexpression150 // 225
	JMPIF $methodcallexpression150 @expect_methodcallexpression147 // 227
	ALIAS r4 $literalexpression153 // 231
	LOAD $literalexpression153 "Only a Token or NFT can be added as payment" // 231
	THROW $literalexpression153 // 278
	@expect_methodcallexpression147: NOP // 281
// Line 29:        if(symbol == "add"){
	COPY $symbol r3 // 281
	ALIAS r4 $literalexpression156 // 284
	LOAD $literalexpression156 "add" // 284
	EQUAL r3 $literalexpression156 r5 // 291
		JMPNOT r5 @then_ifstatement154 // 295
// Line 30:            acceptablePayments.set(symbol,true);
		ALIAS r3 $methodcallexpression172 // 299
		ALIAS r4 $literalexpression180 // 299
		LOAD $literalexpression180 true // 299
		PUSH $literalexpression180 // 304
		COPY $symbol r4 // 306
		PUSH r4 // 309
		ALIAS r4 $literalexpression178 // 311
		LOAD $literalexpression178 "acceptablePayments" // 311
		PUSH $literalexpression178 // 333
		LOAD $methodcallexpression172 "Map.Set" // 335
		EXTCALL $methodcallexpression172 // 346
		@then_ifstatement154: NOP // 349
// Line 31:        }
// Line 32:        if(symbol == "remove"){
	COPY $symbol r3 // 349
	ALIAS r4 $literalexpression183 // 352
	LOAD $literalexpression183 "remove" // 352
	EQUAL r3 $literalexpression183 r5 // 362
		JMPNOT r5 @then_ifstatement181 // 366
// Line 33:            acceptablePayments.remove(symbol);
		ALIAS r3 $methodcallexpression187 // 370
		COPY $symbol r4 // 370
		PUSH r4 // 373
		ALIAS r4 $literalexpression191 // 375
		LOAD $literalexpression191 "acceptablePayments" // 375
		PUSH $literalexpression191 // 397
		LOAD $methodcallexpression187 "Map.Remove" // 399
		EXTCALL $methodcallexpression187 // 413
		@then_ifstatement181: NOP // 416
@exit_addOrRemovePayment: // 416
RET // 417
// Line 34:        }
// Line 35:    }

// ********* addAcceptablePayment Method ***********
@entry_addAcceptablePayment: // 418
ALIAS r1 $dataGet // 419
LOAD $dataGet "Data.Get" // 419
ALIAS r2 $contractName // 431
LOAD $contractName "paymentoperator" // 431
ALIAS r3 $_owner // 450
// reading global: _owner
LOAD r0 8 // 450
PUSH r0 // 455
LOAD r0 "_owner" // 457
PUSH r0 // 467
PUSH $contractName // 469
EXTCALL $dataGet // 471
POP $_owner // 473
PUSH $_owner // 475
EXTCALL "Address()" // 477
POP $_owner // 492
// Line 36:
// Line 37:    /******************************************************************
// Line 38:        !Design Choice:
// Line 39:            Will create 2 different functions for user simplicity
// Line 40:            Allows a user to call the smart contract without having to - 
// Line 41:            input parameters that decide whether to add or remove
// Line 42:    *******************************************************************/
// Line 43:    public addAcceptablePayment(symbol:string ,from:address){
ALIAS r1 $symbol // 494
POP $symbol // 494
ALIAS r2 $from // 496
POP $from // 496
PUSH $from // 498
EXTCALL "Address()" // 500
POP $from // 515
// Line 44:        Runtime.expect(Runtime.isWitness(_owner), "Unauthorized user");
	ALIAS r4 $methodcallexpression203 // 517
	COPY $_owner r5 // 517
	PUSH r5 // 520
	LOAD $methodcallexpression203 "Runtime.IsWitness" // 522
	EXTCALL $methodcallexpression203 // 543
	POP $methodcallexpression203 // 545
	JMPIF $methodcallexpression203 @expect_methodcallexpression200 // 547
	ALIAS r5 $literalexpression206 // 551
	LOAD $literalexpression206 "Unauthorized user" // 551
	THROW $literalexpression206 // 572
	@expect_methodcallexpression200: NOP // 575
// Line 45:        this.addOrRemovePayment(symbol,"add");
	ALIAS r4 $methodcallexpression208 // 575
	ALIAS r5 $literalexpression212 // 575
	LOAD $literalexpression212 "add" // 575
	PUSH $literalexpression212 // 582
	COPY $symbol r5 // 584
	PUSH r5 // 587
	CALL @entry_addOrRemovePayment // 589
@exit_addAcceptablePayment: // 593
RET // 594
// Line 46:
// Line 47:    }

// ********* removeAcceptablePayment Method ***********
@entry_removeAcceptablePayment: // 595
ALIAS r1 $dataGet // 596
LOAD $dataGet "Data.Get" // 596
ALIAS r2 $contractName // 608
LOAD $contractName "paymentoperator" // 608
ALIAS r3 $_owner // 627
// reading global: _owner
LOAD r0 8 // 627
PUSH r0 // 632
LOAD r0 "_owner" // 634
PUSH r0 // 644
PUSH $contractName // 646
EXTCALL $dataGet // 648
POP $_owner // 650
PUSH $_owner // 652
EXTCALL "Address()" // 654
POP $_owner // 669
// Line 48:     public removeAcceptablePayment(symbol:string ,from:address){
ALIAS r1 $symbol // 671
POP $symbol // 671
ALIAS r2 $from // 673
POP $from // 673
PUSH $from // 675
EXTCALL "Address()" // 677
POP $from // 692
// Line 49:        Runtime.expect(Runtime.isWitness(_owner), "Unauthorized user");
	ALIAS r4 $methodcallexpression223 // 694
	COPY $_owner r5 // 694
	PUSH r5 // 697
	LOAD $methodcallexpression223 "Runtime.IsWitness" // 699
	EXTCALL $methodcallexpression223 // 720
	POP $methodcallexpression223 // 722
	JMPIF $methodcallexpression223 @expect_methodcallexpression220 // 724
	ALIAS r5 $literalexpression226 // 728
	LOAD $literalexpression226 "Unauthorized user" // 728
	THROW $literalexpression226 // 749
	@expect_methodcallexpression220: NOP // 752
// Line 50:        Runtime.expect(acceptablePayments.has(symbol),"Symbol has not been added as an acceptable form of payment");
	LOAD r4 6 // field type // 752
	PUSH r4 // 757
	COPY $symbol r5 // 759
	PUSH r5 // 762
	ALIAS r5 $literalexpression235 // 764
	LOAD $literalexpression235 "acceptablePayments" // 764
	PUSH $literalexpression235 // 786
	LOAD $literalexpression235 "paymentoperator" // contract name // 788
	PUSH $literalexpression235 // 807
	LOAD r4 "Map.Has" // 809
	EXTCALL r4 // 820
	POP r4 // 822
	JMPIF r4 @expect_methodcallexpression228 // 824
	ALIAS r5 $literalexpression237 // 828
	LOAD $literalexpression237 "Symbol has not been added as an acceptable form of payment" // 828
	THROW $literalexpression237 // 890
	@expect_methodcallexpression228: NOP // 893
// Line 51:        this.addOrRemovePayment(symbol,"remove");
	ALIAS r4 $methodcallexpression239 // 893
	ALIAS r5 $literalexpression243 // 893
	LOAD $literalexpression243 "remove" // 893
	PUSH $literalexpression243 // 903
	COPY $symbol r5 // 905
	PUSH r5 // 908
	CALL @entry_addOrRemovePayment // 910
@exit_removeAcceptablePayment: // 914
RET // 915
// Line 52:
// Line 53:    }

// ********* checkPrice Method ***********
@entry_checkPrice: // 916
// Line 54:
// Line 55:    /************************************************************************************************
// Line 56:    Not sure how to use Oracles yet. Plan was to use Oracles to check price of given token
// Line 57:    and return that token.
// Line 58:    ************************************************************************************************/
// Line 59:    public checkPrice(symbol: string):number{
ALIAS r1 $symbol // 917
POP $symbol // 917
// Line 60:        local price: number = Oracle.price(symbol);
	ALIAS r2 $price // 919
	ALIAS r3 $methodcallexpression248 // 919
	COPY $symbol r4 // 919
	PUSH r4 // 922
	LOAD $methodcallexpression248 "Oracle.Price" // 924
	EXTCALL $methodcallexpression248 // 940
	COPY $methodcallexpression248 $price // 942
// Line 61:        return price;
	COPY $price r3 // 945
	PUSH r3 // 948
	JMP @exit_checkPrice // 950
@exit_checkPrice: // 953
RET // 954
// Line 62:    }

// ********* quotePrice Method ***********
@entry_quotePrice: // 955
// Line 63:
// Line 64:
// Line 65:    public quotePrice(baseSymbol:string, quoteSymbol:string, amount:number): number {
ALIAS r1 $baseSymbol // 956
POP $baseSymbol // 956
ALIAS r2 $quoteSymbol // 958
POP $quoteSymbol // 958
ALIAS r3 $amount // 960
POP $amount // 960
CAST $amount $amount #Number // 962
// Line 66:        local qu: number = Oracle.quote(baseSymbol,quoteSymbol,amount);
	ALIAS r4 $qu // 966
	ALIAS r5 $methodcallexpression263 // 966
	COPY $amount r6 // 966
	PUSH r6 // 969
	COPY $quoteSymbol r6 // 971
	PUSH r6 // 974
	COPY $baseSymbol r6 // 976
	PUSH r6 // 979
	LOAD $methodcallexpression263 "Oracle.Quote" // 981
	EXTCALL $methodcallexpression263 // 997
	COPY $methodcallexpression263 $qu // 999
// Line 67:       return qu;
	COPY $qu r5 // 1002
	PUSH r5 // 1005
	JMP @exit_quotePrice // 1007
@exit_quotePrice: // 1010
RET // 1011
// Line 68:    }

// ********* onUpgrade Trigger ***********
@entry_onUpgrade: // 1012
ALIAS r1 $dataGet // 1013
LOAD $dataGet "Data.Get" // 1013
ALIAS r2 $contractName // 1025
LOAD $contractName "paymentoperator" // 1025
ALIAS r3 $_owner // 1044
// reading global: _owner
LOAD r0 8 // 1044
PUSH r0 // 1049
LOAD r0 "_owner" // 1051
PUSH r0 // 1061
PUSH $contractName // 1063
EXTCALL $dataGet // 1065
POP $_owner // 1067
PUSH $_owner // 1069
EXTCALL "Address()" // 1071
POP $_owner // 1086
// Line 69:
// Line 70:    trigger onUpgrade(from:address)
ALIAS r1 $from // 1088
POP $from // 1088
PUSH $from // 1090
EXTCALL "Address()" // 1092
POP $from // 1107
// Line 71:    {
// Line 72:        Runtime.expect(Runtime.isWitness(_owner), "Only the owner can update");
	ALIAS r2 $methodcallexpression282 // 1109
	COPY $_owner r4 // 1109
	PUSH r4 // 1112
	LOAD $methodcallexpression282 "Runtime.IsWitness" // 1114
	EXTCALL $methodcallexpression282 // 1135
	POP $methodcallexpression282 // 1137
	JMPIF $methodcallexpression282 @expect_methodcallexpression279 // 1139
	ALIAS r4 $literalexpression285 // 1143
	LOAD $literalexpression285 "Only the owner can update" // 1143
	THROW $literalexpression285 // 1172
	@expect_methodcallexpression279: NOP // 1175
// Line 73:        return;
	JMP @exit_onUpgrade // 1175
@exit_onUpgrade: // 1178
RET // 1179
// Line 74:    }

// ********* onKill Trigger ***********
@entry_onKill: // 1180
ALIAS r1 $dataGet // 1181
LOAD $dataGet "Data.Get" // 1181
ALIAS r2 $contractName // 1193
LOAD $contractName "paymentoperator" // 1193
ALIAS r3 $_owner // 1212
// reading global: _owner
LOAD r0 8 // 1212
PUSH r0 // 1217
LOAD r0 "_owner" // 1219
PUSH r0 // 1229
PUSH $contractName // 1231
EXTCALL $dataGet // 1233
POP $_owner // 1235
PUSH $_owner // 1237
EXTCALL "Address()" // 1239
POP $_owner // 1254
// Line 75:    
// Line 76:    trigger onKill(from:address){
ALIAS r1 $from // 1256
POP $from // 1256
PUSH $from // 1258
EXTCALL "Address()" // 1260
POP $from // 1275
// Line 77:        Runtime.expect(Runtime.isWitness(_owner), "Only the owner can delete");
	ALIAS r2 $methodcallexpression295 // 1277
	COPY $_owner r4 // 1277
	PUSH r4 // 1280
	LOAD $methodcallexpression295 "Runtime.IsWitness" // 1282
	EXTCALL $methodcallexpression295 // 1303
	POP $methodcallexpression295 // 1305
	JMPIF $methodcallexpression295 @expect_methodcallexpression292 // 1307
	ALIAS r4 $literalexpression298 // 1311
	LOAD $literalexpression298 "Only the owner can delete" // 1311
	THROW $literalexpression298 // 1340
	@expect_methodcallexpression292: NOP // 1343
// Line 78:        return;
	JMP @exit_onKill // 1343
@exit_onKill: // 1346
RET // 1347
