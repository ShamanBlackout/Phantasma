// Line 1:
// Line 2:  struct rentalData {
// Line 3:
// Line 4:    active:bool;
// Line 5:    rented:bool;
// Line 6:    timesRented: number; //for popularity
// Line 7:    rentalStart: number;
// Line 8:    rentalEnd: number;
// Line 9:    rentalUser: address;
// Line 10:    //price:number;
// Line 11:    //owner: address;
// Line 12:
// Line 13:}
// Line 14:/**
// Line 15:Questions for Concerns: 
// Line 16: - If a mass amount of users are adding and removing rentals  
// Line 17:   from the Storage Map will that cause data to have gaps/ be exploitable. Race conditions
// Line 18:  
// Line 19:  Example: I remove an nft at the same time a user rents an nft. Which will take precedence
// Line 20:
// Line 21:  - How would enable an nft to not be used by the original owner if it is being rented. 
// Line 22:   - Could possibly do a check that the nft cannot be transfered if its being rented but that wouldnt be handled by this contract.
// Line 23:
// Line 24:  - rentals storage Map
// Line 25:    - Might change the key to String to account for  nftids from different series/symbols
// Line 26:**/
// Line 27:
// Line 28:contract shamans_rental{
// Line 29:
// Line 30:    import Map;
// Line 31:    import NFT;//Will use mail to send a message to the users account once their time is up
// Line 32:    import Mail;
// Line 33:    import Runtime;
// Line 34:
// Line 35:    global rentals: storage_map<number,rentalData>; 

// ********* AddRental Method ***********
@entry_AddRental: // 0
// Line 36:    //Don't need this. Could add this to available Rentals
// Line 37:
// Line 38:  //I can use the the nft Id as a Rental ID
// Line 39:  public AddRental(nftSymbol:string,id:number){
ALIAS r1 $nftSymbol // 1
POP $nftSymbol // 1
ALIAS r2 $id // 3
POP $id // 3
CAST $id $id #Number // 5
// Line 40:
// Line 41:    local nftData: NFT = NFT.read(nftSymbol, id);
	ALIAS r3 $nftData // 9
	LOAD r4 "chain,owner,creator,ROM,RAM,seriesID,mintID" // field list // 9
	PUSH r4 // 56
	COPY $id r5 // 58
	PUSH r5 // 61
	COPY $nftSymbol r5 // 63
	PUSH r5 // 66
	LOAD r4 "Runtime.ReadToken" // 68
	EXTCALL r4 // 89
	POP r4 // 91
	UNPACK r4 r4 // 93
	COPY r4 $nftData // 96
// Line 42:    //check if nft is already a part of the rental pool
// Line 43:    //check if the one adding the rental is the owner
// Line 44:    Runtime.expect(rentals.has(id),"Nft is already in the pool of rentals.");
	LOAD r4 6 // field type // 99
	PUSH r4 // 104
	COPY $id r5 // 106
	PUSH r5 // 109
	ALIAS r5 $literalexpression166 // 111
	LOAD $literalexpression166 "rentals" // 111
	PUSH $literalexpression166 // 122
	LOAD $literalexpression166 "shamans_rental" // contract name // 124
	PUSH $literalexpression166 // 142
	LOAD r4 "Map.Has" // 144
	EXTCALL r4 // 155
	POP r4 // 157
	JMPIF r4 @expect_methodcallexpression147 // 159
	ALIAS r5 $literalexpression168 // 163
	LOAD $literalexpression168 "Nft is already in the pool of rentals." // 163
	THROW $literalexpression168 // 205
	@expect_methodcallexpression147: NOP // 208
// Line 45:    Runtime.expect(Runtime.isWitness(nftData.owner),"Must own NFT to rent it out");
	ALIAS r4 $methodcallexpression173 // 208
	COPY $nftData r5 // 208
	LOAD r6 "owner" // 211
	GET r5 r5 r6 // 220
	PUSH r5 // 224
	LOAD $methodcallexpression173 "Runtime.IsWitness" // 226
	EXTCALL $methodcallexpression173 // 247
	POP $methodcallexpression173 // 249
	JMPIF $methodcallexpression173 @expect_methodcallexpression170 // 251
	ALIAS r5 $literalexpression176 // 255
	LOAD $literalexpression176 "Must own NFT to rent it out" // 255
	THROW $literalexpression176 // 286
	@expect_methodcallexpression170: NOP // 289
// Line 46:    local newRentalData: rentalData = Struct.rentalData(true,false,0,0,0,nftData.owner);
	ALIAS r4 $newRentalData // 289
	CLEAR r5 // 289
	ALIAS r7 $literalexpression184 // 291
	LOAD $literalexpression184 true // 291
	LOAD r6 "active" // 296
	PUT $literalexpression184 r5 r6 // 306
	ALIAS r7 $literalexpression185 // 310
	LOAD $literalexpression185 false // 310
	LOAD r6 "rented" // 315
	PUT $literalexpression185 r5 r6 // 325
	ALIAS r7 $literalexpression186 // 329
	LOAD $literalexpression186 0 // 329
	LOAD r6 "timesRented" // 334
	PUT $literalexpression186 r5 r6 // 349
	ALIAS r7 $literalexpression187 // 353
	LOAD $literalexpression187 0 // 353
	LOAD r6 "rentalStart" // 358
	PUT $literalexpression187 r5 r6 // 373
	ALIAS r7 $literalexpression188 // 377
	LOAD $literalexpression188 0 // 377
	LOAD r6 "rentalEnd" // 382
	PUT $literalexpression188 r5 r6 // 395
	COPY $nftData r7 // 399
	LOAD r8 "owner" // 402
	GET r7 r7 r8 // 411
	LOAD r6 "rentalUser" // 415
	PUT r7 r5 r6 // 429
	COPY r5 $newRentalData // 433
// Line 47:    rentals.set(id,newRentalData);
	ALIAS r5 $methodcallexpression193 // 436
	COPY $newRentalData r6 // 436
	PUSH r6 // 439
	COPY $id r6 // 441
	PUSH r6 // 444
	ALIAS r6 $literalexpression199 // 446
	LOAD $literalexpression199 "rentals" // 446
	PUSH $literalexpression199 // 457
	LOAD $methodcallexpression193 "Map.Set" // 459
	EXTCALL $methodcallexpression193 // 470
@exit_AddRental: // 472
RET // 473
// Line 48:
// Line 49:  }

// ********* RentNft Method ***********
@entry_RentNft: // 474
// Line 50:  
// Line 51:  public RentNft(rentalUser:address, nftId:number){
ALIAS r1 $rentalUser // 475
POP $rentalUser // 475
PUSH $rentalUser // 477
EXTCALL "Address()" // 479
POP $rentalUser // 494
ALIAS r2 $nftId // 496
POP $nftId // 496
CAST $nftId $nftId #Number // 498
// Line 52:
// Line 53:    local oldRentalData: rentalData = rentals.get(nftId);
	ALIAS r3 $oldRentalData // 502
	LOAD r4 1 // field type // 502
	PUSH r4 // 507
	COPY $nftId r5 // 509
	PUSH r5 // 512
	ALIAS r5 $literalexpression212 // 514
	LOAD $literalexpression212 "rentals" // 514
	PUSH $literalexpression212 // 525
	LOAD $literalexpression212 "shamans_rental" // contract name // 527
	PUSH $literalexpression212 // 545
	LOAD r4 "Map.Get" // 547
	EXTCALL r4 // 558
	POP r4 // 560
	UNPACK r4 r4 // 562
	COPY r4 $oldRentalData // 565
// Line 54:    Runtime.expect(oldRentalData.active,"NFT is not available for rental");//active must be true for a user to rent
	COPY $oldRentalData r4 // 568
	LOAD r5 "active" // 571
	GET r4 r4 r5 // 581
	JMPIF r4 @expect_methodcallexpression217 // 585
	ALIAS r5 $literalexpression221 // 589
	LOAD $literalexpression221 "NFT is not available for rental" // 589
	THROW $literalexpression221 // 624
	@expect_methodcallexpression217: NOP // 627
// Line 55:    Runtime.expect(!oldRentalData.rented,"NFT is already being rented");
	COPY $oldRentalData r4 // 627
	LOAD r5 "rented" // 630
	GET r4 r4 r5 // 640
	NOT r4 r4 // 644
	JMPIF r4 @expect_methodcallexpression223 // 647
	ALIAS r5 $literalexpression228 // 651
	LOAD $literalexpression228 "NFT is already being rented" // 651
	THROW $literalexpression228 // 682
	@expect_methodcallexpression223: NOP // 685
// Line 56:    Runtime.expect(Runtime.isWitness(rentalUser),"Must be renter of NFT");
	ALIAS r4 $methodcallexpression233 // 685
	COPY $rentalUser r5 // 685
	PUSH r5 // 688
	LOAD $methodcallexpression233 "Runtime.IsWitness" // 690
	EXTCALL $methodcallexpression233 // 711
	POP $methodcallexpression233 // 713
	JMPIF $methodcallexpression233 @expect_methodcallexpression230 // 715
	ALIAS r5 $literalexpression236 // 719
	LOAD $literalexpression236 "Must be renter of NFT" // 719
	THROW $literalexpression236 // 744
	@expect_methodcallexpression230: NOP // 747
// Line 57:    local newRentalData: rentalData = Struct.rentalData(oldRentalData.active,true,oldRentalData.timesRented+1,0,0,rentalUser);
	ALIAS r4 $newRentalData // 747
	CLEAR r5 // 747
	COPY $oldRentalData r7 // 749
	LOAD r8 "active" // 752
	GET r7 r7 r8 // 762
	LOAD r6 "active" // 766
	PUT r7 r5 r6 // 776
	ALIAS r7 $literalexpression245 // 780
	LOAD $literalexpression245 true // 780
	LOAD r6 "rented" // 785
	PUT $literalexpression245 r5 r6 // 795
	COPY $oldRentalData r7 // 799
	LOAD r8 "timesRented" // 802
	GET r7 r7 r8 // 817
	ALIAS r8 $literalexpression247 // 821
	LOAD $literalexpression247 1 // 821
	ADD r7 $literalexpression247 r9 // 826
	LOAD r6 "timesRented" // 830
	PUT r9 r5 r6 // 845
	ALIAS r7 $literalexpression249 // 849
	LOAD $literalexpression249 0 // 849
	LOAD r6 "rentalStart" // 854
	PUT $literalexpression249 r5 r6 // 869
	ALIAS r7 $literalexpression250 // 873
	LOAD $literalexpression250 0 // 873
	LOAD r6 "rentalEnd" // 878
	PUT $literalexpression250 r5 r6 // 891
	COPY $rentalUser r7 // 895
	LOAD r6 "rentalUser" // 898
	PUT r7 r5 r6 // 912
	COPY r5 $newRentalData // 916
// Line 58:    rentals.set(nftId,newRentalData);
	ALIAS r5 $methodcallexpression255 // 919
	COPY $newRentalData r6 // 919
	PUSH r6 // 922
	COPY $nftId r6 // 924
	PUSH r6 // 927
	ALIAS r6 $literalexpression261 // 929
	LOAD $literalexpression261 "rentals" // 929
	PUSH $literalexpression261 // 940
	LOAD $methodcallexpression255 "Map.Set" // 942
	EXTCALL $methodcallexpression255 // 953
@exit_RentNft: // 955
RET // 956
// Line 59:   
// Line 60:
// Line 61:  }

// ********* RentNftOnBehalf Method ***********
@entry_RentNftOnBehalf: // 957
// Line 62:
// Line 63:  //Allows a user to rent an NFT for another user. Similar to Gifting.
// Line 64:  public RentNftOnBehalf(from:address,to:address,nftId:number){
ALIAS r1 $from // 958
POP $from // 958
PUSH $from // 960
EXTCALL "Address()" // 962
POP $from // 977
ALIAS r2 $to // 979
POP $to // 979
PUSH $to // 981
EXTCALL "Address()" // 983
POP $to // 998
ALIAS r3 $nftId // 1000
POP $nftId // 1000
CAST $nftId $nftId #Number // 1002
// Line 65:    
// Line 66:    local oldRentalData: rentalData = rentals.get(nftId);
	ALIAS r4 $oldRentalData // 1006
	LOAD r5 1 // field type // 1006
	PUSH r5 // 1011
	COPY $nftId r6 // 1013
	PUSH r6 // 1016
	ALIAS r6 $literalexpression276 // 1018
	LOAD $literalexpression276 "rentals" // 1018
	PUSH $literalexpression276 // 1029
	LOAD $literalexpression276 "shamans_rental" // contract name // 1031
	PUSH $literalexpression276 // 1049
	LOAD r5 "Map.Get" // 1051
	EXTCALL r5 // 1062
	POP r5 // 1064
	UNPACK r5 r5 // 1066
	COPY r5 $oldRentalData // 1069
// Line 67:    Runtime.expect(oldRentalData.active,"NFT is not available for rental");//active must be true for a user to rent
	COPY $oldRentalData r5 // 1072
	LOAD r6 "active" // 1075
	GET r5 r5 r6 // 1085
	JMPIF r5 @expect_methodcallexpression281 // 1089
	ALIAS r6 $literalexpression285 // 1093
	LOAD $literalexpression285 "NFT is not available for rental" // 1093
	THROW $literalexpression285 // 1128
	@expect_methodcallexpression281: NOP // 1131
// Line 68:    Runtime.expect(!oldRentalData.rented,"NFT is already being rented");
	COPY $oldRentalData r5 // 1131
	LOAD r6 "rented" // 1134
	GET r5 r5 r6 // 1144
	NOT r5 r5 // 1148
	JMPIF r5 @expect_methodcallexpression287 // 1151
	ALIAS r6 $literalexpression292 // 1155
	LOAD $literalexpression292 "NFT is already being rented" // 1155
	THROW $literalexpression292 // 1186
	@expect_methodcallexpression287: NOP // 1189
// Line 69:    Runtime.expect(Runtime.isWitness(from),"Must be user gifting the NFT");
	ALIAS r5 $methodcallexpression297 // 1189
	COPY $from r6 // 1189
	PUSH r6 // 1192
	LOAD $methodcallexpression297 "Runtime.IsWitness" // 1194
	EXTCALL $methodcallexpression297 // 1215
	POP $methodcallexpression297 // 1217
	JMPIF $methodcallexpression297 @expect_methodcallexpression294 // 1219
	ALIAS r6 $literalexpression300 // 1223
	LOAD $literalexpression300 "Must be user gifting the NFT" // 1223
	THROW $literalexpression300 // 1255
	@expect_methodcallexpression294: NOP // 1258
// Line 70:    local newRentalData: rentalData = Struct.rentalData(true,oldRentalData.rented,oldRentalData.timesRented+1,0,0,to);
	ALIAS r5 $newRentalData // 1258
	CLEAR r6 // 1258
	ALIAS r8 $literalexpression308 // 1260
	LOAD $literalexpression308 true // 1260
	LOAD r7 "active" // 1265
	PUT $literalexpression308 r6 r7 // 1275
	COPY $oldRentalData r8 // 1279
	LOAD r9 "rented" // 1282
	GET r8 r8 r9 // 1292
	LOAD r7 "rented" // 1296
	PUT r8 r6 r7 // 1306
	COPY $oldRentalData r8 // 1310
	LOAD r9 "timesRented" // 1313
	GET r8 r8 r9 // 1328
	ALIAS r9 $literalexpression311 // 1332
	LOAD $literalexpression311 1 // 1332
	ADD r8 $literalexpression311 r10 // 1337
	LOAD r7 "timesRented" // 1341
	PUT r10 r6 r7 // 1356
	ALIAS r8 $literalexpression313 // 1360
	LOAD $literalexpression313 0 // 1360
	LOAD r7 "rentalStart" // 1365
	PUT $literalexpression313 r6 r7 // 1380
	ALIAS r8 $literalexpression314 // 1384
	LOAD $literalexpression314 0 // 1384
	LOAD r7 "rentalEnd" // 1389
	PUT $literalexpression314 r6 r7 // 1402
	COPY $to r8 // 1406
	LOAD r7 "rentalUser" // 1409
	PUT r8 r6 r7 // 1423
	COPY r6 $newRentalData // 1427
// Line 71:    rentals.set(nftId,newRentalData);
	ALIAS r6 $methodcallexpression319 // 1430
	COPY $newRentalData r7 // 1430
	PUSH r7 // 1433
	COPY $nftId r7 // 1435
	PUSH r7 // 1438
	ALIAS r7 $literalexpression325 // 1440
	LOAD $literalexpression325 "rentals" // 1440
	PUSH $literalexpression325 // 1451
	LOAD $methodcallexpression319 "Map.Set" // 1453
	EXTCALL $methodcallexpression319 // 1464
@exit_RentNftOnBehalf: // 1466
RET // 1467
// Line 72:    
// Line 73:  }

// ********* RentalEnded Method ***********
@entry_RentalEnded: // 1468
@exit_RentalEnded: // 1469
RET // 1470
// Line 74:
// Line 75: 
// Line 76:  public RentalEnded(){
// Line 77:    //rented
// Line 78:  }

// ********* RemoveRental Method ***********
@entry_RemoveRental: // 1471
// Line 79:  //When owner wants to permanently remove rental from storage map, will have to add it back with stats reset to 0 if this is called
// Line 80:  public RemoveRental(nftSymbol:string, nftId:number){
ALIAS r1 $nftSymbol // 1472
POP $nftSymbol // 1472
ALIAS r2 $nftId // 1474
POP $nftId // 1474
CAST $nftId $nftId #Number // 1476
// Line 81:
// Line 82:    Runtime.expect(rentals.has(nftId),"NFT is not a part of Available Rentals");
	LOAD r3 6 // field type // 1480
	PUSH r3 // 1485
	COPY $nftId r4 // 1487
	PUSH r4 // 1490
	ALIAS r4 $literalexpression344 // 1492
	LOAD $literalexpression344 "rentals" // 1492
	PUSH $literalexpression344 // 1503
	LOAD $literalexpression344 "shamans_rental" // contract name // 1505
	PUSH $literalexpression344 // 1523
	LOAD r3 "Map.Has" // 1525
	EXTCALL r3 // 1536
	POP r3 // 1538
	JMPIF r3 @expect_methodcallexpression337 // 1540
	ALIAS r4 $literalexpression346 // 1544
	LOAD $literalexpression346 "NFT is not a part of Available Rentals" // 1544
	THROW $literalexpression346 // 1586
	@expect_methodcallexpression337: NOP // 1589
// Line 83:    /*********************************************************************************************
// Line 84:    Design Choice: Personally for optimization I want to expect a user to verify they
// Line 85:        are the owner of the nft before loading in the rental data.However, psychologically
// Line 86:        it would please the user to know once they sign then everything is okay, versus signing
// Line 87:        and then finding out that the nft is being rented.
// Line 88:    *********************************************************************************************/
// Line 89:    local oldRentalData: rentalData = rentals.get(nftId);
	ALIAS r3 $oldRentalData // 1589
	LOAD r4 1 // field type // 1589
	PUSH r4 // 1594
	COPY $nftId r5 // 1596
	PUSH r5 // 1599
	ALIAS r5 $literalexpression351 // 1601
	LOAD $literalexpression351 "rentals" // 1601
	PUSH $literalexpression351 // 1612
	LOAD $literalexpression351 "shamans_rental" // contract name // 1614
	PUSH $literalexpression351 // 1632
	LOAD r4 "Map.Get" // 1634
	EXTCALL r4 // 1645
	POP r4 // 1647
	UNPACK r4 r4 // 1649
	COPY r4 $oldRentalData // 1652
// Line 90:    Runtime.expect(!oldRentalData.rented,"Cannot remove an NFT that is being rented");
	COPY $oldRentalData r4 // 1655
	LOAD r5 "rented" // 1658
	GET r4 r4 r5 // 1668
	NOT r4 r4 // 1672
	JMPIF r4 @expect_methodcallexpression356 // 1675
	ALIAS r5 $literalexpression361 // 1679
	LOAD $literalexpression361 "Cannot remove an NFT that is being rented" // 1679
	THROW $literalexpression361 // 1724
	@expect_methodcallexpression356: NOP // 1727
// Line 91:    local nftData: NFT = NFT.read(nftSymbol,nftId);
	ALIAS r4 $nftData // 1727
	LOAD r5 "chain,owner,creator,ROM,RAM,seriesID,mintID" // field list // 1727
	PUSH r5 // 1774
	COPY $nftId r6 // 1776
	PUSH r6 // 1779
	COPY $nftSymbol r6 // 1781
	PUSH r6 // 1784
	LOAD r5 "Runtime.ReadToken" // 1786
	EXTCALL r5 // 1807
	POP r5 // 1809
	UNPACK r5 r5 // 1811
	COPY r5 $nftData // 1814
// Line 92:    Runtime.expect(Runtime.isWitness(nftData.owner), "Must be owner of NFT to permanently remove rental");
	ALIAS r5 $methodcallexpression373 // 1817
	COPY $nftData r6 // 1817
	LOAD r7 "owner" // 1820
	GET r6 r6 r7 // 1829
	PUSH r6 // 1833
	LOAD $methodcallexpression373 "Runtime.IsWitness" // 1835
	EXTCALL $methodcallexpression373 // 1856
	POP $methodcallexpression373 // 1858
	JMPIF $methodcallexpression373 @expect_methodcallexpression370 // 1860
	ALIAS r6 $literalexpression376 // 1864
	LOAD $literalexpression376 "Must be owner of NFT to permanently remove rental" // 1864
	THROW $literalexpression376 // 1917
	@expect_methodcallexpression370: NOP // 1920
// Line 93:    rentals.remove(nftId);
	ALIAS r5 $methodcallexpression378 // 1920
	COPY $nftId r6 // 1920
	PUSH r6 // 1923
	ALIAS r6 $literalexpression382 // 1925
	LOAD $literalexpression382 "rentals" // 1925
	PUSH $literalexpression382 // 1936
	LOAD $methodcallexpression378 "Map.Remove" // 1938
	EXTCALL $methodcallexpression378 // 1952
@exit_RemoveRental: // 1954
RET // 1955
// Line 94:    }

// ********* DeactivateOrActivateRental Method ***********
@entry_DeactivateOrActivateRental: // 1956
// Line 95:
// Line 96:  //In the case that an owner wants to deactivate his/her nft from being rented
// Line 97:  public DeactivateOrActivateRental(activate:bool,nftSymbol:string,nftId: number){
ALIAS r1 $activate // 1957
POP $activate // 1957
ALIAS r2 $nftSymbol // 1959
POP $nftSymbol // 1959
ALIAS r3 $nftId // 1961
POP $nftId // 1961
CAST $nftId $nftId #Number // 1963
// Line 98:
// Line 99:    Runtime.expect(rentals.has(nftId),"NFT is not a part of Available Rentals");
	LOAD r4 6 // field type // 1967
	PUSH r4 // 1972
	COPY $nftId r5 // 1974
	PUSH r5 // 1977
	ALIAS r5 $literalexpression400 // 1979
	LOAD $literalexpression400 "rentals" // 1979
	PUSH $literalexpression400 // 1990
	LOAD $literalexpression400 "shamans_rental" // contract name // 1992
	PUSH $literalexpression400 // 2010
	LOAD r4 "Map.Has" // 2012
	EXTCALL r4 // 2023
	POP r4 // 2025
	JMPIF r4 @expect_methodcallexpression393 // 2027
	ALIAS r5 $literalexpression402 // 2031
	LOAD $literalexpression402 "NFT is not a part of Available Rentals" // 2031
	THROW $literalexpression402 // 2073
	@expect_methodcallexpression393: NOP // 2076
// Line 100:    local oldRentalData: rentalData = rentals.get(nftId);
	ALIAS r4 $oldRentalData // 2076
	LOAD r5 1 // field type // 2076
	PUSH r5 // 2081
	COPY $nftId r6 // 2083
	PUSH r6 // 2086
	ALIAS r6 $literalexpression407 // 2088
	LOAD $literalexpression407 "rentals" // 2088
	PUSH $literalexpression407 // 2099
	LOAD $literalexpression407 "shamans_rental" // contract name // 2101
	PUSH $literalexpression407 // 2119
	LOAD r5 "Map.Get" // 2121
	EXTCALL r5 // 2132
	POP r5 // 2134
	UNPACK r5 r5 // 2136
	COPY r5 $oldRentalData // 2139
// Line 101:    Runtime.expect(!oldRentalData.rented,"Cannot deactivate an NFT that is being rented");
	COPY $oldRentalData r5 // 2142
	LOAD r6 "rented" // 2145
	GET r5 r5 r6 // 2155
	NOT r5 r5 // 2159
	JMPIF r5 @expect_methodcallexpression412 // 2162
	ALIAS r6 $literalexpression417 // 2166
	LOAD $literalexpression417 "Cannot deactivate an NFT that is being rented" // 2166
	THROW $literalexpression417 // 2215
	@expect_methodcallexpression412: NOP // 2218
// Line 102:    Runtime.expect(oldRentalData.active != activate, "active state is already: " + oldRentalData.active); //using oldRentalData.active if an error is present with this logic the user can compare what they entered vs the oldRental State
	COPY $oldRentalData r5 // 2218
	LOAD r6 "active" // 2221
	GET r5 r5 r6 // 2231
	COPY $activate r6 // 2235
	EQUAL r5 r6 r7 // 2238
	NOT r7 r7 // 2242
	JMPIF r7 @expect_methodcallexpression419 // 2245
	ALIAS r5 $literalexpression426 // 2249
	LOAD $literalexpression426 "active state is already: " // 2249
	COPY $oldRentalData r6 // 2278
	LOAD r8 "active" // 2281
	GET r6 r6 r8 // 2291
	CAST r6 r6 #String // 2295
	ADD $literalexpression426 r6 r8 // 2299
	THROW r8 // 2303
	@expect_methodcallexpression419: NOP // 2306
// Line 103:    local nftData: NFT = NFT.read(nftSymbol,nftId);
	ALIAS r5 $nftData // 2306
	LOAD r6 "chain,owner,creator,ROM,RAM,seriesID,mintID" // field list // 2306
	PUSH r6 // 2353
	COPY $nftId r7 // 2355
	PUSH r7 // 2358
	COPY $nftSymbol r7 // 2360
	PUSH r7 // 2363
	LOAD r6 "Runtime.ReadToken" // 2365
	EXTCALL r6 // 2386
	POP r6 // 2388
	UNPACK r6 r6 // 2390
	COPY r6 $nftData // 2393
// Line 104:    Runtime.expect(Runtime.isWitness(nftData.owner), "Must be owner of NFT to change active state");
	ALIAS r6 $methodcallexpression441 // 2396
	COPY $nftData r7 // 2396
	LOAD r8 "owner" // 2399
	GET r7 r7 r8 // 2408
	PUSH r7 // 2412
	LOAD $methodcallexpression441 "Runtime.IsWitness" // 2414
	EXTCALL $methodcallexpression441 // 2435
	POP $methodcallexpression441 // 2437
	JMPIF $methodcallexpression441 @expect_methodcallexpression438 // 2439
	ALIAS r7 $literalexpression444 // 2443
	LOAD $literalexpression444 "Must be owner of NFT to change active state" // 2443
	THROW $literalexpression444 // 2490
	@expect_methodcallexpression438: NOP // 2493
// Line 105:    local newRentalData: rentalData = Struct.rentalData(activate,oldRentalData.rented,oldRentalData.timesRented,oldRentalData.rentalStart,oldRentalData.rentalEnd,nftData.owner); //reset rental user to owner of nft
	ALIAS r6 $newRentalData // 2493
	CLEAR r7 // 2493
	COPY $activate r9 // 2495
	LOAD r8 "active" // 2498
	PUT r9 r7 r8 // 2508
	COPY $oldRentalData r9 // 2512
	LOAD r10 "rented" // 2515
	GET r9 r9 r10 // 2525
	LOAD r8 "rented" // 2529
	PUT r9 r7 r8 // 2539
	COPY $oldRentalData r9 // 2543
	LOAD r10 "timesRented" // 2546
	GET r9 r9 r10 // 2561
	LOAD r8 "timesRented" // 2565
	PUT r9 r7 r8 // 2580
	COPY $oldRentalData r9 // 2584
	LOAD r10 "rentalStart" // 2587
	GET r9 r9 r10 // 2602
	LOAD r8 "rentalStart" // 2606
	PUT r9 r7 r8 // 2621
	COPY $oldRentalData r9 // 2625
	LOAD r10 "rentalEnd" // 2628
	GET r9 r9 r10 // 2641
	LOAD r8 "rentalEnd" // 2645
	PUT r9 r7 r8 // 2658
	COPY $nftData r9 // 2662
	LOAD r10 "owner" // 2665
	GET r9 r9 r10 // 2674
	LOAD r8 "rentalUser" // 2678
	PUT r9 r7 r8 // 2692
	COPY r7 $newRentalData // 2696
// Line 106:    rentals.set(nftId,newRentalData);
	ALIAS r7 $methodcallexpression461 // 2699
	COPY $newRentalData r8 // 2699
	PUSH r8 // 2702
	COPY $nftId r8 // 2704
	PUSH r8 // 2707
	ALIAS r8 $literalexpression467 // 2709
	LOAD $literalexpression467 "rentals" // 2709
	PUSH $literalexpression467 // 2720
	LOAD $methodcallexpression461 "Map.Set" // 2722
	EXTCALL $methodcallexpression461 // 2733
@exit_DeactivateOrActivateRental: // 2735
RET // 2736
