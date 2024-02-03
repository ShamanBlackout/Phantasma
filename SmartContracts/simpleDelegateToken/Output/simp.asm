// Line 1:struct simp_ram {
// Line 2:  
// Line 3:   weapon_name: string;
// Line 4:   durability: number;
// Line 5:   enchanted: number;
// Line 6:}
// Line 7:
// Line 8:struct simp_rom {
// Line 9:    name: string;
// Line 10:    description: string;
// Line 11:    infoURL: string;
// Line 12:    imageURL: string;
// Line 13:    created: timestamp;
// Line 14:}
// Line 15:
// Line 16:
// Line 17:
// Line 18:token SDT {
// Line 19:
// Line 20:    import Runtime;
// Line 21:    import NFT;
// Line 22:    import Time;
// Line 23:    import Number;
// Line 24:    import Map;
// Line 25:    import Address;
// Line 26:   
// Line 27:
// Line 28:
// Line 29:    global _owner:address;
// Line 30:    global delegates: storage_map<address,number>;
// Line 31:
// Line 32:    property name: string = "Simple Delegate NFT";
// Line 33:    property symbol: string = "SDT";
// Line 34:    property isFungible: bool = false;
// Line 35:    property isFinite: bool = true;
// Line 36:    property isBurnable: bool = true;
// Line 37:    property maxSupply: number =  50; //0 for an infinite
// Line 38:    property isTransferable: bool = true;
// Line 39:    property owner: address = _owner;
// Line 40:
// Line 41:
// Line 42: 
// Line 43:
// Line 44:    nft simp<simp_rom,simp_ram>{

// ********* getName Property ***********
@entry_getName: // 0
POP r1 // get nft tokenID from stack // 1
// reading nft data
LOAD r0 "ROM" // 3
PUSH r0 // fields // 10
PUSH r1 // tokenID // 12
LOAD r0 "SDT" // 14
PUSH r0 // symbol // 21
LOAD r0 "Runtime.ReadToken" // 23
EXTCALL r0 // 44
POP r2 // 46
UNPACK r2 r2 // 48
ALIAS r3 $_ROM // 51
LOAD r0 "ROM" // 51
GET r2 $_ROM r0 // 58
UNPACK $_ROM $_ROM // 62
// Line 45:
// Line 46:        property name: string{
// Line 47:            return _ROM.name;
	COPY $_ROM r1 // 65
	LOAD r2 "name" // 68
	GET r1 r1 r2 // 76
	PUSH r1 // 80
	JMP @exit_getName // 82
@exit_getName: // 85
RET // 86
// Line 48:        }

// ********* getDescription Property ***********
@entry_getDescription: // 87
POP r1 // get nft tokenID from stack // 88
// reading nft data
LOAD r0 "ROM" // 90
PUSH r0 // fields // 97
PUSH r1 // tokenID // 99
LOAD r0 "SDT" // 101
PUSH r0 // symbol // 108
LOAD r0 "Runtime.ReadToken" // 110
EXTCALL r0 // 131
POP r2 // 133
UNPACK r2 r2 // 135
ALIAS r3 $_ROM // 138
LOAD r0 "ROM" // 138
GET r2 $_ROM r0 // 145
UNPACK $_ROM $_ROM // 149
// Line 49:        property description: string{
// Line 50:            return _ROM.description;
	COPY $_ROM r1 // 152
	LOAD r2 "description" // 155
	GET r1 r1 r2 // 170
	PUSH r1 // 174
	JMP @exit_getDescription // 176
@exit_getDescription: // 179
RET // 180
// Line 51:        }

// ********* getInfoURL Property ***********
@entry_getInfoURL: // 181
POP r1 // get nft tokenID from stack // 182
// reading nft data
LOAD r0 "ROM" // 184
PUSH r0 // fields // 191
PUSH r1 // tokenID // 193
LOAD r0 "SDT" // 195
PUSH r0 // symbol // 202
LOAD r0 "Runtime.ReadToken" // 204
EXTCALL r0 // 225
POP r2 // 227
UNPACK r2 r2 // 229
ALIAS r3 $_ROM // 232
LOAD r0 "ROM" // 232
GET r2 $_ROM r0 // 239
UNPACK $_ROM $_ROM // 243
// Line 52:        property infoURL: string{
// Line 53:            return _ROM.infoURL;
	COPY $_ROM r1 // 246
	LOAD r2 "infoURL" // 249
	GET r1 r1 r2 // 260
	PUSH r1 // 264
	JMP @exit_getInfoURL // 266
@exit_getInfoURL: // 269
RET // 270
// Line 54:        }

// ********* getImageURL Property ***********
@entry_getImageURL: // 271
POP r1 // get nft tokenID from stack // 272
// reading nft data
LOAD r0 "ROM" // 274
PUSH r0 // fields // 281
PUSH r1 // tokenID // 283
LOAD r0 "SDT" // 285
PUSH r0 // symbol // 292
LOAD r0 "Runtime.ReadToken" // 294
EXTCALL r0 // 315
POP r2 // 317
UNPACK r2 r2 // 319
ALIAS r3 $_ROM // 322
LOAD r0 "ROM" // 322
GET r2 $_ROM r0 // 329
UNPACK $_ROM $_ROM // 333
// Line 55:        property imageURL: string{
// Line 56:            return _ROM.imageURL;
	COPY $_ROM r1 // 336
	LOAD r2 "imageURL" // 339
	GET r1 r1 r2 // 351
	PUSH r1 // 355
	JMP @exit_getImageURL // 357
@exit_getImageURL: // 360
RET // 361
// Line 57:        }

// ********* getCreated Property ***********
@entry_getCreated: // 362
POP r1 // get nft tokenID from stack // 363
// reading nft data
LOAD r0 "ROM" // 365
PUSH r0 // fields // 372
PUSH r1 // tokenID // 374
LOAD r0 "SDT" // 376
PUSH r0 // symbol // 383
LOAD r0 "Runtime.ReadToken" // 385
EXTCALL r0 // 406
POP r2 // 408
UNPACK r2 r2 // 410
ALIAS r3 $_ROM // 413
LOAD r0 "ROM" // 413
GET r2 $_ROM r0 // 420
UNPACK $_ROM $_ROM // 424
// Line 58:        property created: timestamp{
// Line 59:            return _ROM.created;
	COPY $_ROM r1 // 427
	LOAD r2 "created" // 430
	GET r1 r1 r2 // 441
	PUSH r1 // 445
	JMP @exit_getCreated // 447
@exit_getCreated: // 450
RET // 451
// Line 60:        }

// ********* getWeapon_name Property ***********
@entry_getWeapon_name: // 452
POP r1 // get nft tokenID from stack // 453
// reading nft data
LOAD r0 "RAM" // 455
PUSH r0 // fields // 462
PUSH r1 // tokenID // 464
LOAD r0 "SDT" // 466
PUSH r0 // symbol // 473
LOAD r0 "Runtime.ReadToken" // 475
EXTCALL r0 // 496
POP r2 // 498
UNPACK r2 r2 // 500
ALIAS r3 $_RAM // 503
LOAD r0 "RAM" // 503
GET r2 $_RAM r0 // 510
UNPACK $_RAM $_RAM // 514
// Line 61:        
// Line 62:        property weapon_name: string{
// Line 63:            return _RAM.weapon_name;
	COPY $_RAM r1 // 517
	LOAD r2 "weapon_name" // 520
	GET r1 r1 r2 // 535
	PUSH r1 // 539
	JMP @exit_getWeapon_name // 541
@exit_getWeapon_name: // 544
RET // 545
// Line 64:        }

// ********* getDurability Property ***********
@entry_getDurability: // 546
POP r1 // get nft tokenID from stack // 547
// reading nft data
LOAD r0 "RAM" // 549
PUSH r0 // fields // 556
PUSH r1 // tokenID // 558
LOAD r0 "SDT" // 560
PUSH r0 // symbol // 567
LOAD r0 "Runtime.ReadToken" // 569
EXTCALL r0 // 590
POP r2 // 592
UNPACK r2 r2 // 594
ALIAS r3 $_RAM // 597
LOAD r0 "RAM" // 597
GET r2 $_RAM r0 // 604
UNPACK $_RAM $_RAM // 608
// Line 65:        property durability: number{
// Line 66:            return _RAM.durability;
	COPY $_RAM r1 // 611
	LOAD r2 "durability" // 614
	GET r1 r1 r2 // 628
	PUSH r1 // 632
	JMP @exit_getDurability // 634
@exit_getDurability: // 637
RET // 638
// Line 67:        }

// ********* getEnchanted Property ***********
@entry_getEnchanted: // 639
POP r1 // get nft tokenID from stack // 640
// reading nft data
LOAD r0 "RAM" // 642
PUSH r0 // fields // 649
PUSH r1 // tokenID // 651
LOAD r0 "SDT" // 653
PUSH r0 // symbol // 660
LOAD r0 "Runtime.ReadToken" // 662
EXTCALL r0 // 683
POP r2 // 685
UNPACK r2 r2 // 687
ALIAS r3 $_RAM // 690
LOAD r0 "RAM" // 690
GET r2 $_RAM r0 // 697
UNPACK $_RAM $_RAM // 701
// Line 68:        property enchanted: number{
// Line 69:            return _RAM.enchanted;
	COPY $_RAM r1 // 704
	LOAD r2 "enchanted" // 707
	GET r1 r1 r2 // 720
	PUSH r1 // 724
	JMP @exit_getEnchanted // 726
@exit_getEnchanted: // 729
RET // 730
