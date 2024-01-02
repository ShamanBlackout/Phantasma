// Line 1:contract deploytest00 {
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

// ********* test Method ***********
@entry_test: // 151
// Line 10:
// Line 11:    public test():string{
// Line 12:        return "Contract has been deployed by PhantasmaTS Successfully";
	ALIAS r1 $literalexpression68 // 152
	LOAD $literalexpression68 "Contract has been deployed by PhantasmaTS Successfully" // 152
	PUSH $literalexpression68 // 210
	JMP @exit_test // 212
@exit_test: // 215
RET // 216
// Line 13:    }

// ********* onUpgrade Trigger ***********
@entry_onUpgrade: // 217
ALIAS r1 $dataGet // 218
LOAD $dataGet "Data.Get" // 218
ALIAS r2 $contractName // 230
LOAD $contractName "deploytest00" // 230
ALIAS r3 $_owner // 246
// reading global: _owner
LOAD r0 8 // 246
PUSH r0 // 251
LOAD r0 "_owner" // 253
PUSH r0 // 263
PUSH $contractName // 265
EXTCALL $dataGet // 267
POP $_owner // 269
PUSH $_owner // 271
EXTCALL "Address()" // 273
POP $_owner // 288
// Line 14:
// Line 15:    trigger onUpgrade(from:address){
ALIAS r1 $from // 290
POP $from // 290
PUSH $from // 292
EXTCALL "Address()" // 294
POP $from // 309
// Line 16:        Runtime.expect(Runtime.isWitness(_owner),"Improper verification");
	ALIAS r2 $methodcallexpression78 // 311
	COPY $_owner r4 // 311
	PUSH r4 // 314
	LOAD $methodcallexpression78 "Runtime.IsWitness" // 316
	EXTCALL $methodcallexpression78 // 337
	POP $methodcallexpression78 // 339
	JMPIF $methodcallexpression78 @expect_methodcallexpression75 // 341
	ALIAS r4 $literalexpression81 // 345
	LOAD $literalexpression81 "Improper verification" // 345
	THROW $literalexpression81 // 370
	@expect_methodcallexpression75: NOP // 373
@exit_onUpgrade: // 373
RET // 374
// Line 17:
// Line 18:    }

// ********* onKill Trigger ***********
@entry_onKill: // 375
ALIAS r1 $dataGet // 376
LOAD $dataGet "Data.Get" // 376
ALIAS r2 $contractName // 388
LOAD $contractName "deploytest00" // 388
ALIAS r3 $_owner // 404
// reading global: _owner
LOAD r0 8 // 404
PUSH r0 // 409
LOAD r0 "_owner" // 411
PUSH r0 // 421
PUSH $contractName // 423
EXTCALL $dataGet // 425
POP $_owner // 427
PUSH $_owner // 429
EXTCALL "Address()" // 431
POP $_owner // 446
// Line 19:
// Line 20:    trigger onKill(from:address){
ALIAS r1 $from // 448
POP $from // 448
PUSH $from // 450
EXTCALL "Address()" // 452
POP $from // 467
// Line 21:         Runtime.expect(Runtime.isWitness(_owner),"Improper verification");
	ALIAS r2 $methodcallexpression90 // 469
	COPY $_owner r4 // 469
	PUSH r4 // 472
	LOAD $methodcallexpression90 "Runtime.IsWitness" // 474
	EXTCALL $methodcallexpression90 // 495
	POP $methodcallexpression90 // 497
	JMPIF $methodcallexpression90 @expect_methodcallexpression87 // 499
	ALIAS r4 $literalexpression93 // 503
	LOAD $literalexpression93 "Improper verification" // 503
	THROW $literalexpression93 // 528
	@expect_methodcallexpression87: NOP // 531
@exit_onKill: // 531
RET // 532
