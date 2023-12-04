// Line 1:contract simplecon00 {
// Line 2:
// Line 3:    import Runtime;
// Line 4:    global _owner: address;

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
// Line 5:
// Line 6:
// Line 7:    constructor(owner:address){
ALIAS r2 $owner // 94
POP $owner // 94
PUSH $owner // 96
EXTCALL "Address()" // 98
POP $owner // 113
// Line 8:        _owner = owner;
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
// Line 9:    }

// ********* pow Method ***********
@entry_pow: // 151
// Line 10:
// Line 11:    public pow(a:number,b:number):number{
ALIAS r1 $a // 152
POP $a // 152
CAST $a $a #Number // 154
ALIAS r2 $b // 158
POP $b // 158
CAST $b $b #Number // 160
// Line 12:
// Line 13:        if(b < 0){
	COPY $b r3 // 164
	ALIAS r4 $literalexpression74 // 167
	LOAD $literalexpression74 0 // 167
	LT r3 $literalexpression74 r5 // 172
		JMPNOT r5 @then_ifstatement72 // 176
// Line 14:            throw "We are not computing negatives at the moment. Check back later";
		ALIAS r3 $literalexpression77 // 180
		LOAD $literalexpression77 "We are not computing negatives at the moment. Check back later" // 180
		THROW $literalexpression77 // 246
		@then_ifstatement72: NOP // 249
// Line 15:        }
// Line 16:        if(b == 0){
	COPY $b r3 // 249
	ALIAS r4 $literalexpression81 // 252
	LOAD $literalexpression81 0 // 252
	EQUAL r3 $literalexpression81 r5 // 257
		JMPNOT r5 @then_ifstatement79 // 261
// Line 17:            return 1;
		ALIAS r3 $literalexpression84 // 265
		LOAD $literalexpression84 1 // 265
		PUSH $literalexpression84 // 270
		JMP @exit_pow // 272
		@then_ifstatement79: NOP // 276
// Line 18:        }
// Line 19:        if(b == 1){
	COPY $b r3 // 276
	ALIAS r4 $literalexpression88 // 279
	LOAD $literalexpression88 1 // 279
	EQUAL r3 $literalexpression88 r5 // 284
		JMPNOT r5 @then_ifstatement86 // 288
// Line 20:            return a;
		COPY $a r3 // 292
		PUSH r3 // 295
		JMP @exit_pow // 297
		@then_ifstatement86: NOP // 301
// Line 21:        }
// Line 22:        
// Line 23:        local tmp:number=a;
	ALIAS r3 $tmp // 301
	COPY $a r4 // 301
	COPY r4 $tmp // 304
// Line 24:
// Line 25:        for(local x:number=1; x<b; x++){
	ALIAS r4 $x // 307
	ALIAS r5 $literalexpression97 // 307
	LOAD $literalexpression97 1 // 307
	COPY $literalexpression97 $x // 312
	@loop_start_forstatement96: NOP // 316
	COPY $x r5 // 316
	COPY $b r6 // 319
	LT r5 r6 r7 // 322
		JMPNOT r7 @loop_end_forstatement96 // 326
// Line 26:            tmp = tmp*a;
		COPY $tmp r5 // 330
		COPY $a r6 // 333
		MUL r5 r6 r8 // 336
		COPY r8 $tmp // 340
		COPY $x r5 // 343
		ALIAS r6 $literalexpression105 // 346
		LOAD $literalexpression105 1 // 346
		ADD r5 $literalexpression105 r8 // 351
		COPY r8 $x // 355
		JMP @loop_start_forstatement96 // 358
		@loop_end_forstatement96: NOP // 362
// Line 27:        }
// Line 28:         return tmp;
	COPY $tmp r5 // 362
	PUSH r5 // 365
	JMP @exit_pow // 367
@exit_pow: // 370
RET // 371
// Line 29:    }

// ********* onUpgrade Trigger ***********
@entry_onUpgrade: // 372
ALIAS r1 $dataGet // 373
LOAD $dataGet "Data.Get" // 373
ALIAS r2 $contractName // 385
LOAD $contractName "simplecon00" // 385
ALIAS r3 $_owner // 400
// reading global: _owner
LOAD r0 8 // 400
PUSH r0 // 405
LOAD r0 "_owner" // 407
PUSH r0 // 417
PUSH $contractName // 419
EXTCALL $dataGet // 421
POP $_owner // 423
PUSH $_owner // 425
EXTCALL "Address()" // 427
POP $_owner // 442
// Line 30:
// Line 31:
// Line 32:    trigger onUpgrade(from:address){
ALIAS r1 $from // 444
POP $from // 444
PUSH $from // 446
EXTCALL "Address()" // 448
POP $from // 463
// Line 33:        Runtime.expect(Runtime.isWitness(_owner),"Improper verification");
	ALIAS r2 $methodcallexpression122 // 465
	COPY $_owner r4 // 465
	PUSH r4 // 468
	LOAD $methodcallexpression122 "Runtime.IsWitness" // 470
	EXTCALL $methodcallexpression122 // 491
	POP $methodcallexpression122 // 493
	JMPIF $methodcallexpression122 @expect_methodcallexpression119 // 495
	ALIAS r4 $literalexpression125 // 499
	LOAD $literalexpression125 "Improper verification" // 499
	THROW $literalexpression125 // 524
	@expect_methodcallexpression119: NOP // 527
@exit_onUpgrade: // 527
RET // 528
// Line 34:
// Line 35:    }

// ********* onKill Trigger ***********
@entry_onKill: // 529
ALIAS r1 $dataGet // 530
LOAD $dataGet "Data.Get" // 530
ALIAS r2 $contractName // 542
LOAD $contractName "simplecon00" // 542
ALIAS r3 $_owner // 557
// reading global: _owner
LOAD r0 8 // 557
PUSH r0 // 562
LOAD r0 "_owner" // 564
PUSH r0 // 574
PUSH $contractName // 576
EXTCALL $dataGet // 578
POP $_owner // 580
PUSH $_owner // 582
EXTCALL "Address()" // 584
POP $_owner // 599
// Line 36:
// Line 37:    trigger onKill(from:address){
ALIAS r1 $from // 601
POP $from // 601
PUSH $from // 603
EXTCALL "Address()" // 605
POP $from // 620
// Line 38:         Runtime.expect(Runtime.isWitness(_owner),"Improper verification");
	ALIAS r2 $methodcallexpression134 // 622
	COPY $_owner r4 // 622
	PUSH r4 // 625
	LOAD $methodcallexpression134 "Runtime.IsWitness" // 627
	EXTCALL $methodcallexpression134 // 648
	POP $methodcallexpression134 // 650
	JMPIF $methodcallexpression134 @expect_methodcallexpression131 // 652
	ALIAS r4 $literalexpression137 // 656
	LOAD $literalexpression137 "Improper verification" // 656
	THROW $literalexpression137 // 681
	@expect_methodcallexpression131: NOP // 684
@exit_onKill: // 684
RET // 685
