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
// Line 11:    rentalOwner: address;
// Line 12:
// Line 13:}
// Line 14:
// Line 15:/************************************************************************
// Line 16:  Using this contract to test basic functionality of NFTIds and renting
// Line 17:  without the actual use of NFT's , just simulation with numbers
// Line 18:*************************************************************************/
// Line 19:
// Line 20:contract rentaltest{
// Line 21:
// Line 22:    import Map;
// Line 23:    import NFT;//Will use mail to send a message to the users account once their time is up
// Line 24:    import Mail;
// Line 25:    import Runtime;
// Line 26:
// Line 27:    global _owner: address;
// Line 28:    global rentals: storage_map<number,rentalData>; 

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
// clearing rentals storage
LOAD r0 "rentals" // 94
PUSH r0 // 105
LOAD r0 "Map.Clear" // 107
EXTCALL r0 // 120
// Line 29:    //Don't need this. Could add this to available Rentals
// Line 30:
// Line 31:  constructor(owner:address){
ALIAS r2 $owner // 122
POP $owner // 122
PUSH $owner // 124
EXTCALL "Address()" // 126
POP $owner // 141
// Line 32:    _owner = owner;
	COPY $owner r3 // 143
	COPY r3 $_owner // 146
@exit_constructor: // 149
LOAD r2 "Data.Set" // 150
// writing global: _owner
PUSH $_owner // 162
LOAD r0 "_owner" // 164
PUSH r0 // 174
EXTCALL r2 // 176
RET // 178
// Line 33:  }

// ********* AddRental Method ***********
@entry_AddRental: // 179
// Line 34:  public AddRental(owner:address , id:number){
ALIAS r1 $owner // 180
POP $owner // 180
PUSH $owner // 182
EXTCALL "Address()" // 184
POP $owner // 199
ALIAS r2 $id // 201
POP $id // 201
CAST $id $id #Number // 203
// Line 35:
// Line 36:    /****************************************
// Line 37:        - Going to add Rentals based on ID
// Line 38:    *****************************************/
// Line 39:    Runtime.expect(!rentals.has(id),"Nft is already in the pool of rentals.");
	LOAD r3 6 // field type // 207
	PUSH r3 // 212
	COPY $id r4 // 214
	PUSH r4 // 217
	ALIAS r4 $literalexpression167 // 219
	LOAD $literalexpression167 "rentals" // 219
	PUSH $literalexpression167 // 230
	LOAD $literalexpression167 "rentaltest" // contract name // 232
	PUSH $literalexpression167 // 246
	LOAD r3 "Map.Has" // 248
	EXTCALL r3 // 259
	POP r3 // 261
	NOT r3 r3 // 263
	JMPIF r3 @expect_methodcallexpression148 // 266
	ALIAS r4 $literalexpression170 // 270
	LOAD $literalexpression170 "Nft is already in the pool of rentals." // 270
	THROW $literalexpression170 // 312
	@expect_methodcallexpression148: NOP // 315
// Line 40:    Runtime.expect(Runtime.isWitness(owner),"Must own NFT to rent it out");
	ALIAS r3 $methodcallexpression175 // 315
	COPY $owner r4 // 315
	PUSH r4 // 318
	LOAD $methodcallexpression175 "Runtime.IsWitness" // 320
	EXTCALL $methodcallexpression175 // 341
	POP $methodcallexpression175 // 343
	JMPIF $methodcallexpression175 @expect_methodcallexpression172 // 345
	ALIAS r4 $literalexpression178 // 349
	LOAD $literalexpression178 "Must own NFT to rent it out" // 349
	THROW $literalexpression178 // 380
	@expect_methodcallexpression172: NOP // 383
// Line 41:    local newRentalData: rentalData = Struct.rentalData(true,false,0,0,0,owner,owner);
	ALIAS r3 $newRentalData // 383
	CLEAR r4 // 383
	ALIAS r6 $literalexpression187 // 385
	LOAD $literalexpression187 true // 385
	LOAD r5 "active" // 390
	PUT $literalexpression187 r4 r5 // 400
	ALIAS r6 $literalexpression188 // 404
	LOAD $literalexpression188 false // 404
	LOAD r5 "rented" // 409
	PUT $literalexpression188 r4 r5 // 419
	ALIAS r6 $literalexpression189 // 423
	LOAD $literalexpression189 0 // 423
	LOAD r5 "timesRented" // 428
	PUT $literalexpression189 r4 r5 // 443
	ALIAS r6 $literalexpression190 // 447
	LOAD $literalexpression190 0 // 447
	LOAD r5 "rentalStart" // 452
	PUT $literalexpression190 r4 r5 // 467
	ALIAS r6 $literalexpression191 // 471
	LOAD $literalexpression191 0 // 471
	LOAD r5 "rentalEnd" // 476
	PUT $literalexpression191 r4 r5 // 489
	COPY $owner r6 // 493
	LOAD r5 "rentalUser" // 496
	PUT r6 r4 r5 // 510
	COPY $owner r6 // 514
	LOAD r5 "rentalOwner" // 517
	PUT r6 r4 r5 // 532
	COPY r4 $newRentalData // 536
// Line 42:    rentals.set(id,newRentalData);
	ALIAS r4 $methodcallexpression197 // 539
	COPY $newRentalData r5 // 539
	PUSH r5 // 542
	COPY $id r5 // 544
	PUSH r5 // 547
	ALIAS r5 $literalexpression203 // 549
	LOAD $literalexpression203 "rentals" // 549
	PUSH $literalexpression203 // 560
	LOAD $methodcallexpression197 "Map.Set" // 562
	EXTCALL $methodcallexpression197 // 573
@exit_AddRental: // 575
RET // 576
// Line 43:
// Line 44:  }

// ********* RentNft Method ***********
@entry_RentNft: // 577
// Line 45:  
// Line 46:  public RentNft(rentalUser:address, id:number){
ALIAS r1 $rentalUser // 578
POP $rentalUser // 578
PUSH $rentalUser // 580
EXTCALL "Address()" // 582
POP $rentalUser // 597
ALIAS r2 $id // 599
POP $id // 599
CAST $id $id #Number // 601
// Line 47:    
// Line 48:    Runtime.expect(rentals.has(id),"There is no such rental associated with the supplied ID");
	LOAD r3 6 // field type // 605
	PUSH r3 // 610
	COPY $id r4 // 612
	PUSH r4 // 615
	ALIAS r4 $literalexpression220 // 617
	LOAD $literalexpression220 "rentals" // 617
	PUSH $literalexpression220 // 628
	LOAD $literalexpression220 "rentaltest" // contract name // 630
	PUSH $literalexpression220 // 644
	LOAD r3 "Map.Has" // 646
	EXTCALL r3 // 657
	POP r3 // 659
	JMPIF r3 @expect_methodcallexpression213 // 661
	ALIAS r4 $literalexpression222 // 665
	LOAD $literalexpression222 "There is no such rental associated with the supplied ID" // 665
	THROW $literalexpression222 // 724
	@expect_methodcallexpression213: NOP // 727
// Line 49:    local oldRentalData: rentalData = rentals.get(id);
	ALIAS r3 $oldRentalData // 727
	LOAD r4 1 // field type // 727
	PUSH r4 // 732
	COPY $id r5 // 734
	PUSH r5 // 737
	ALIAS r5 $literalexpression227 // 739
	LOAD $literalexpression227 "rentals" // 739
	PUSH $literalexpression227 // 750
	LOAD $literalexpression227 "rentaltest" // contract name // 752
	PUSH $literalexpression227 // 766
	LOAD r4 "Map.Get" // 768
	EXTCALL r4 // 779
	POP r4 // 781
	UNPACK r4 r4 // 783
	COPY r4 $oldRentalData // 786
// Line 50:    Runtime.expect(oldRentalData.active,"NFT is not available for rental");//active must be true for a user to rent
	COPY $oldRentalData r4 // 789
	LOAD r5 "active" // 792
	GET r4 r4 r5 // 802
	JMPIF r4 @expect_methodcallexpression232 // 806
	ALIAS r5 $literalexpression236 // 810
	LOAD $literalexpression236 "NFT is not available for rental" // 810
	THROW $literalexpression236 // 845
	@expect_methodcallexpression232: NOP // 848
// Line 51:    Runtime.expect(!oldRentalData.rented,"NFT is already being rented");
	COPY $oldRentalData r4 // 848
	LOAD r5 "rented" // 851
	GET r4 r4 r5 // 861
	NOT r4 r4 // 865
	JMPIF r4 @expect_methodcallexpression238 // 868
	ALIAS r5 $literalexpression243 // 872
	LOAD $literalexpression243 "NFT is already being rented" // 872
	THROW $literalexpression243 // 903
	@expect_methodcallexpression238: NOP // 906
// Line 52:    Runtime.expect(Runtime.isWitness(rentalUser),"Must be renter of NFT");
	ALIAS r4 $methodcallexpression248 // 906
	COPY $rentalUser r5 // 906
	PUSH r5 // 909
	LOAD $methodcallexpression248 "Runtime.IsWitness" // 911
	EXTCALL $methodcallexpression248 // 932
	POP $methodcallexpression248 // 934
	JMPIF $methodcallexpression248 @expect_methodcallexpression245 // 936
	ALIAS r5 $literalexpression251 // 940
	LOAD $literalexpression251 "Must be renter of NFT" // 940
	THROW $literalexpression251 // 965
	@expect_methodcallexpression245: NOP // 968
// Line 53:    local newRentalData: rentalData = Struct.rentalData(oldRentalData.active,true,oldRentalData.timesRented+1,0,0,rentalUser,oldRentalData.rentalOwner);
	ALIAS r4 $newRentalData // 968
	CLEAR r5 // 968
	COPY $oldRentalData r7 // 970
	LOAD r8 "active" // 973
	GET r7 r7 r8 // 983
	LOAD r6 "active" // 987
	PUT r7 r5 r6 // 997
	ALIAS r7 $literalexpression261 // 1001
	LOAD $literalexpression261 true // 1001
	LOAD r6 "rented" // 1006
	PUT $literalexpression261 r5 r6 // 1016
	COPY $oldRentalData r7 // 1020
	LOAD r8 "timesRented" // 1023
	GET r7 r7 r8 // 1038
	ALIAS r8 $literalexpression263 // 1042
	LOAD $literalexpression263 1 // 1042
	ADD r7 $literalexpression263 r9 // 1047
	LOAD r6 "timesRented" // 1051
	PUT r9 r5 r6 // 1066
	ALIAS r7 $literalexpression265 // 1070
	LOAD $literalexpression265 0 // 1070
	LOAD r6 "rentalStart" // 1075
	PUT $literalexpression265 r5 r6 // 1090
	ALIAS r7 $literalexpression266 // 1094
	LOAD $literalexpression266 0 // 1094
	LOAD r6 "rentalEnd" // 1099
	PUT $literalexpression266 r5 r6 // 1112
	COPY $rentalUser r7 // 1116
	LOAD r6 "rentalUser" // 1119
	PUT r7 r5 r6 // 1133
	COPY $oldRentalData r7 // 1137
	LOAD r8 "rentalOwner" // 1140
	GET r7 r7 r8 // 1155
	LOAD r6 "rentalOwner" // 1159
	PUT r7 r5 r6 // 1174
	COPY r5 $newRentalData // 1178
// Line 54:    rentals.set(id,newRentalData);
	ALIAS r5 $methodcallexpression272 // 1181
	COPY $newRentalData r6 // 1181
	PUSH r6 // 1184
	COPY $id r6 // 1186
	PUSH r6 // 1189
	ALIAS r6 $literalexpression278 // 1191
	LOAD $literalexpression278 "rentals" // 1191
	PUSH $literalexpression278 // 1202
	LOAD $methodcallexpression272 "Map.Set" // 1204
	EXTCALL $methodcallexpression272 // 1215
@exit_RentNft: // 1217
RET // 1218
// Line 55:   
// Line 56:
// Line 57:  }

// ********* RentNftOnBehalf Method ***********
@entry_RentNftOnBehalf: // 1219
// Line 58:
// Line 59:  //Allows a user to rent an NFT for another user. Similar to Gifting.
// Line 60:  public RentNftOnBehalf(from:address,to:address,id:number){
ALIAS r1 $from // 1220
POP $from // 1220
PUSH $from // 1222
EXTCALL "Address()" // 1224
POP $from // 1239
ALIAS r2 $to // 1241
POP $to // 1241
PUSH $to // 1243
EXTCALL "Address()" // 1245
POP $to // 1260
ALIAS r3 $id // 1262
POP $id // 1262
CAST $id $id #Number // 1264
// Line 61:    
// Line 62:    Runtime.expect(rentals.has(id),"There is no such rental associated with the supplied ID");
	LOAD r4 6 // field type // 1268
	PUSH r4 // 1273
	COPY $id r5 // 1275
	PUSH r5 // 1278
	ALIAS r5 $literalexpression297 // 1280
	LOAD $literalexpression297 "rentals" // 1280
	PUSH $literalexpression297 // 1291
	LOAD $literalexpression297 "rentaltest" // contract name // 1293
	PUSH $literalexpression297 // 1307
	LOAD r4 "Map.Has" // 1309
	EXTCALL r4 // 1320
	POP r4 // 1322
	JMPIF r4 @expect_methodcallexpression290 // 1324
	ALIAS r5 $literalexpression299 // 1328
	LOAD $literalexpression299 "There is no such rental associated with the supplied ID" // 1328
	THROW $literalexpression299 // 1387
	@expect_methodcallexpression290: NOP // 1390
// Line 63:    local oldRentalData: rentalData = rentals.get(id);
	ALIAS r4 $oldRentalData // 1390
	LOAD r5 1 // field type // 1390
	PUSH r5 // 1395
	COPY $id r6 // 1397
	PUSH r6 // 1400
	ALIAS r6 $literalexpression304 // 1402
	LOAD $literalexpression304 "rentals" // 1402
	PUSH $literalexpression304 // 1413
	LOAD $literalexpression304 "rentaltest" // contract name // 1415
	PUSH $literalexpression304 // 1429
	LOAD r5 "Map.Get" // 1431
	EXTCALL r5 // 1442
	POP r5 // 1444
	UNPACK r5 r5 // 1446
	COPY r5 $oldRentalData // 1449
// Line 64:    Runtime.expect(oldRentalData.active,"NFT is not available for rental");//active must be true for a user to rent
	COPY $oldRentalData r5 // 1452
	LOAD r6 "active" // 1455
	GET r5 r5 r6 // 1465
	JMPIF r5 @expect_methodcallexpression309 // 1469
	ALIAS r6 $literalexpression313 // 1473
	LOAD $literalexpression313 "NFT is not available for rental" // 1473
	THROW $literalexpression313 // 1508
	@expect_methodcallexpression309: NOP // 1511
// Line 65:    Runtime.expect(!oldRentalData.rented,"NFT is already being rented");
	COPY $oldRentalData r5 // 1511
	LOAD r6 "rented" // 1514
	GET r5 r5 r6 // 1524
	NOT r5 r5 // 1528
	JMPIF r5 @expect_methodcallexpression315 // 1531
	ALIAS r6 $literalexpression320 // 1535
	LOAD $literalexpression320 "NFT is already being rented" // 1535
	THROW $literalexpression320 // 1566
	@expect_methodcallexpression315: NOP // 1569
// Line 66:    Runtime.expect(Runtime.isWitness(from),"Must be user gifting the NFT");
	ALIAS r5 $methodcallexpression325 // 1569
	COPY $from r6 // 1569
	PUSH r6 // 1572
	LOAD $methodcallexpression325 "Runtime.IsWitness" // 1574
	EXTCALL $methodcallexpression325 // 1595
	POP $methodcallexpression325 // 1597
	JMPIF $methodcallexpression325 @expect_methodcallexpression322 // 1599
	ALIAS r6 $literalexpression328 // 1603
	LOAD $literalexpression328 "Must be user gifting the NFT" // 1603
	THROW $literalexpression328 // 1635
	@expect_methodcallexpression322: NOP // 1638
// Line 67:    local newRentalData: rentalData = Struct.rentalData(oldRentalData.active,true,oldRentalData.timesRented+1,0,0,to,oldRentalData.rentalOwner);
	ALIAS r5 $newRentalData // 1638
	CLEAR r6 // 1638
	COPY $oldRentalData r8 // 1640
	LOAD r9 "active" // 1643
	GET r8 r8 r9 // 1653
	LOAD r7 "active" // 1657
	PUT r8 r6 r7 // 1667
	ALIAS r8 $literalexpression338 // 1671
	LOAD $literalexpression338 true // 1671
	LOAD r7 "rented" // 1676
	PUT $literalexpression338 r6 r7 // 1686
	COPY $oldRentalData r8 // 1690
	LOAD r9 "timesRented" // 1693
	GET r8 r8 r9 // 1708
	ALIAS r9 $literalexpression340 // 1712
	LOAD $literalexpression340 1 // 1712
	ADD r8 $literalexpression340 r10 // 1717
	LOAD r7 "timesRented" // 1721
	PUT r10 r6 r7 // 1736
	ALIAS r8 $literalexpression342 // 1740
	LOAD $literalexpression342 0 // 1740
	LOAD r7 "rentalStart" // 1745
	PUT $literalexpression342 r6 r7 // 1760
	ALIAS r8 $literalexpression343 // 1764
	LOAD $literalexpression343 0 // 1764
	LOAD r7 "rentalEnd" // 1769
	PUT $literalexpression343 r6 r7 // 1782
	COPY $to r8 // 1786
	LOAD r7 "rentalUser" // 1789
	PUT r8 r6 r7 // 1803
	COPY $oldRentalData r8 // 1807
	LOAD r9 "rentalOwner" // 1810
	GET r8 r8 r9 // 1825
	LOAD r7 "rentalOwner" // 1829
	PUT r8 r6 r7 // 1844
	COPY r6 $newRentalData // 1848
// Line 68:    rentals.set(id,newRentalData);
	ALIAS r6 $methodcallexpression349 // 1851
	COPY $newRentalData r7 // 1851
	PUSH r7 // 1854
	COPY $id r7 // 1856
	PUSH r7 // 1859
	ALIAS r7 $literalexpression355 // 1861
	LOAD $literalexpression355 "rentals" // 1861
	PUSH $literalexpression355 // 1872
	LOAD $methodcallexpression349 "Map.Set" // 1874
	EXTCALL $methodcallexpression349 // 1885
@exit_RentNftOnBehalf: // 1887
RET // 1888
// Line 69:    
// Line 70:  }

// ********* RentalEnded Method ***********
@entry_RentalEnded: // 1889
// Line 71:
// Line 72:    /************************************************************************
// Line 73:     For test purposes anyone can end the rental
// Line 74:     - When ready for production this should change to the contract owner
// Line 75:    ***********************************************************************/
// Line 76:  public RentalEnded(id: number){
ALIAS r1 $id // 1890
POP $id // 1890
CAST $id $id #Number // 1892
// Line 77:
// Line 78:    //Runtime.expect(Runtime.isWitness(_owner),"Must have admin privileges to access this function");
// Line 79:    Runtime.expect(rentals.has(id),"There is no such rental associated with the supplied ID");
	LOAD r2 6 // field type // 1896
	PUSH r2 // 1901
	COPY $id r3 // 1903
	PUSH r3 // 1906
	ALIAS r3 $literalexpression370 // 1908
	LOAD $literalexpression370 "rentals" // 1908
	PUSH $literalexpression370 // 1919
	LOAD $literalexpression370 "rentaltest" // contract name // 1921
	PUSH $literalexpression370 // 1935
	LOAD r2 "Map.Has" // 1937
	EXTCALL r2 // 1948
	POP r2 // 1950
	JMPIF r2 @expect_methodcallexpression363 // 1952
	ALIAS r3 $literalexpression372 // 1956
	LOAD $literalexpression372 "There is no such rental associated with the supplied ID" // 1956
	THROW $literalexpression372 // 2015
	@expect_methodcallexpression363: NOP // 2018
// Line 80:    local oldRentalData: rentalData = rentals.get(id);
	ALIAS r2 $oldRentalData // 2018
	LOAD r3 1 // field type // 2018
	PUSH r3 // 2023
	COPY $id r4 // 2025
	PUSH r4 // 2028
	ALIAS r4 $literalexpression377 // 2030
	LOAD $literalexpression377 "rentals" // 2030
	PUSH $literalexpression377 // 2041
	LOAD $literalexpression377 "rentaltest" // contract name // 2043
	PUSH $literalexpression377 // 2057
	LOAD r3 "Map.Get" // 2059
	EXTCALL r3 // 2070
	POP r3 // 2072
	UNPACK r3 r3 // 2074
	COPY r3 $oldRentalData // 2077
// Line 81:    local newRentalData: rentalData = Struct.rentalData(true,false,oldRentalData.timesRented,0,0,oldRentalData.rentalOwner,oldRentalData.rentalOwner);
	ALIAS r3 $newRentalData // 2080
	CLEAR r4 // 2080
	ALIAS r6 $literalexpression389 // 2082
	LOAD $literalexpression389 true // 2082
	LOAD r5 "active" // 2087
	PUT $literalexpression389 r4 r5 // 2097
	ALIAS r6 $literalexpression390 // 2101
	LOAD $literalexpression390 false // 2101
	LOAD r5 "rented" // 2106
	PUT $literalexpression390 r4 r5 // 2116
	COPY $oldRentalData r6 // 2120
	LOAD r7 "timesRented" // 2123
	GET r6 r6 r7 // 2138
	LOAD r5 "timesRented" // 2142
	PUT r6 r4 r5 // 2157
	ALIAS r6 $literalexpression392 // 2161
	LOAD $literalexpression392 0 // 2161
	LOAD r5 "rentalStart" // 2166
	PUT $literalexpression392 r4 r5 // 2181
	ALIAS r6 $literalexpression393 // 2185
	LOAD $literalexpression393 0 // 2185
	LOAD r5 "rentalEnd" // 2190
	PUT $literalexpression393 r4 r5 // 2203
	COPY $oldRentalData r6 // 2207
	LOAD r7 "rentalOwner" // 2210
	GET r6 r6 r7 // 2225
	LOAD r5 "rentalUser" // 2229
	PUT r6 r4 r5 // 2243
	COPY $oldRentalData r6 // 2247
	LOAD r7 "rentalOwner" // 2250
	GET r6 r6 r7 // 2265
	LOAD r5 "rentalOwner" // 2269
	PUT r6 r4 r5 // 2284
	COPY r4 $newRentalData // 2288
// Line 82:    rentals.set(id,newRentalData);
	ALIAS r4 $methodcallexpression399 // 2291
	COPY $newRentalData r5 // 2291
	PUSH r5 // 2294
	COPY $id r5 // 2296
	PUSH r5 // 2299
	ALIAS r5 $literalexpression405 // 2301
	LOAD $literalexpression405 "rentals" // 2301
	PUSH $literalexpression405 // 2312
	LOAD $methodcallexpression399 "Map.Set" // 2314
	EXTCALL $methodcallexpression399 // 2325
@exit_RentalEnded: // 2327
RET // 2328
// Line 83:  }

// ********* getRentalInfo Method ***********
@entry_getRentalInfo: // 2329
// Line 84:
// Line 85:  public getRentalInfo(id:number): rentalData {
ALIAS r1 $id // 2330
POP $id // 2330
CAST $id $id #Number // 2332
// Line 86:
// Line 87:        Runtime.expect(rentals.has(id), "ID is not valid");
	LOAD r2 6 // field type // 2336
	PUSH r2 // 2341
	COPY $id r3 // 2343
	PUSH r3 // 2346
	ALIAS r3 $literalexpression420 // 2348
	LOAD $literalexpression420 "rentals" // 2348
	PUSH $literalexpression420 // 2359
	LOAD $literalexpression420 "rentaltest" // contract name // 2361
	PUSH $literalexpression420 // 2375
	LOAD r2 "Map.Has" // 2377
	EXTCALL r2 // 2388
	POP r2 // 2390
	JMPIF r2 @expect_methodcallexpression413 // 2392
	ALIAS r3 $literalexpression422 // 2396
	LOAD $literalexpression422 "ID is not valid" // 2396
	THROW $literalexpression422 // 2415
	@expect_methodcallexpression413: NOP // 2418
// Line 88:        local oldRentalData: rentalData = rentals.get(id);
	ALIAS r2 $oldRentalData // 2418
	LOAD r3 1 // field type // 2418
	PUSH r3 // 2423
	COPY $id r4 // 2425
	PUSH r4 // 2428
	ALIAS r4 $literalexpression427 // 2430
	LOAD $literalexpression427 "rentals" // 2430
	PUSH $literalexpression427 // 2441
	LOAD $literalexpression427 "rentaltest" // contract name // 2443
	PUSH $literalexpression427 // 2457
	LOAD r3 "Map.Get" // 2459
	EXTCALL r3 // 2470
	POP r3 // 2472
	UNPACK r3 r3 // 2474
	COPY r3 $oldRentalData // 2477
// Line 89:        return oldRentalData;
	COPY $oldRentalData r3 // 2480
	PUSH r3 // 2483
	JMP @exit_getRentalInfo // 2485
@exit_getRentalInfo: // 2488
RET // 2489
// Line 90:  }

// ********* RemoveRental Method ***********
@entry_RemoveRental: // 2490
// Line 91:
// Line 92:  //When owner wants to permanently remove rental from storage map, will have to add it back with stats reset to 0 if this is called
// Line 93:  public RemoveRental(id:number){
ALIAS r1 $id // 2491
POP $id // 2491
CAST $id $id #Number // 2493
// Line 94:
// Line 95:    /*********************************************************************************************
// Line 96:    Design Choice: Personally for optimization I want to expect a user to verify they
// Line 97:        are the owner of the nft before loading in the rental data.However, psychologically
// Line 98:        it would please the user to know once they sign then everything is okay, versus signing
// Line 99:        and then finding out that the nft is being rented.
// Line 100:    *********************************************************************************************/
// Line 101:    Runtime.expect(rentals.has(id),"No such ID exist in the rental database");
	LOAD r2 6 // field type // 2497
	PUSH r2 // 2502
	COPY $id r3 // 2504
	PUSH r3 // 2507
	ALIAS r3 $literalexpression445 // 2509
	LOAD $literalexpression445 "rentals" // 2509
	PUSH $literalexpression445 // 2520
	LOAD $literalexpression445 "rentaltest" // contract name // 2522
	PUSH $literalexpression445 // 2536
	LOAD r2 "Map.Has" // 2538
	EXTCALL r2 // 2549
	POP r2 // 2551
	JMPIF r2 @expect_methodcallexpression438 // 2553
	ALIAS r3 $literalexpression447 // 2557
	LOAD $literalexpression447 "No such ID exist in the rental database" // 2557
	THROW $literalexpression447 // 2600
	@expect_methodcallexpression438: NOP // 2603
// Line 102:    local oldRentalData: rentalData = rentals.get(id);
	ALIAS r2 $oldRentalData // 2603
	LOAD r3 1 // field type // 2603
	PUSH r3 // 2608
	COPY $id r4 // 2610
	PUSH r4 // 2613
	ALIAS r4 $literalexpression452 // 2615
	LOAD $literalexpression452 "rentals" // 2615
	PUSH $literalexpression452 // 2626
	LOAD $literalexpression452 "rentaltest" // contract name // 2628
	PUSH $literalexpression452 // 2642
	LOAD r3 "Map.Get" // 2644
	EXTCALL r3 // 2655
	POP r3 // 2657
	UNPACK r3 r3 // 2659
	COPY r3 $oldRentalData // 2662
// Line 103:    Runtime.expect(!oldRentalData.rented,"Cannot remove an NFT that is being rented");
	COPY $oldRentalData r3 // 2665
	LOAD r4 "rented" // 2668
	GET r3 r3 r4 // 2678
	NOT r3 r3 // 2682
	JMPIF r3 @expect_methodcallexpression457 // 2685
	ALIAS r4 $literalexpression462 // 2689
	LOAD $literalexpression462 "Cannot remove an NFT that is being rented" // 2689
	THROW $literalexpression462 // 2734
	@expect_methodcallexpression457: NOP // 2737
// Line 104:    Runtime.expect(Runtime.isWitness(oldRentalData.rentalOwner), "Must be owner of NFT to permanently remove rental");
	ALIAS r3 $methodcallexpression467 // 2737
	COPY $oldRentalData r4 // 2737
	LOAD r5 "rentalOwner" // 2740
	GET r4 r4 r5 // 2755
	PUSH r4 // 2759
	LOAD $methodcallexpression467 "Runtime.IsWitness" // 2761
	EXTCALL $methodcallexpression467 // 2782
	POP $methodcallexpression467 // 2784
	JMPIF $methodcallexpression467 @expect_methodcallexpression464 // 2786
	ALIAS r4 $literalexpression470 // 2790
	LOAD $literalexpression470 "Must be owner of NFT to permanently remove rental" // 2790
	THROW $literalexpression470 // 2843
	@expect_methodcallexpression464: NOP // 2846
// Line 105:    rentals.remove(id);
	ALIAS r3 $methodcallexpression472 // 2846
	COPY $id r4 // 2846
	PUSH r4 // 2849
	ALIAS r4 $literalexpression476 // 2851
	LOAD $literalexpression476 "rentals" // 2851
	PUSH $literalexpression476 // 2862
	LOAD $methodcallexpression472 "Map.Remove" // 2864
	EXTCALL $methodcallexpression472 // 2878
@exit_RemoveRental: // 2880
RET // 2881
// Line 106:    }

// ********* DeactivateOrActivateRental Method ***********
@entry_DeactivateOrActivateRental: // 2882
// Line 107:
// Line 108:  //In the case that an owner wants to deactivate his/her nft from being rented
// Line 109:  public DeactivateOrActivateRental(activate:bool,id: number){
ALIAS r1 $activate // 2883
POP $activate // 2883
ALIAS r2 $id // 2885
POP $id // 2885
CAST $id $id #Number // 2887
// Line 110:
// Line 111:    Runtime.expect(rentals.has(id),"NFT is not a part of Available Rentals");
	LOAD r3 6 // field type // 2891
	PUSH r3 // 2896
	COPY $id r4 // 2898
	PUSH r4 // 2901
	ALIAS r4 $literalexpression492 // 2903
	LOAD $literalexpression492 "rentals" // 2903
	PUSH $literalexpression492 // 2914
	LOAD $literalexpression492 "rentaltest" // contract name // 2916
	PUSH $literalexpression492 // 2930
	LOAD r3 "Map.Has" // 2932
	EXTCALL r3 // 2943
	POP r3 // 2945
	JMPIF r3 @expect_methodcallexpression485 // 2947
	ALIAS r4 $literalexpression494 // 2951
	LOAD $literalexpression494 "NFT is not a part of Available Rentals" // 2951
	THROW $literalexpression494 // 2993
	@expect_methodcallexpression485: NOP // 2996
// Line 112:    local oldRentalData: rentalData = rentals.get(id);
	ALIAS r3 $oldRentalData // 2996
	LOAD r4 1 // field type // 2996
	PUSH r4 // 3001
	COPY $id r5 // 3003
	PUSH r5 // 3006
	ALIAS r5 $literalexpression499 // 3008
	LOAD $literalexpression499 "rentals" // 3008
	PUSH $literalexpression499 // 3019
	LOAD $literalexpression499 "rentaltest" // contract name // 3021
	PUSH $literalexpression499 // 3035
	LOAD r4 "Map.Get" // 3037
	EXTCALL r4 // 3048
	POP r4 // 3050
	UNPACK r4 r4 // 3052
	COPY r4 $oldRentalData // 3055
// Line 113:    Runtime.expect(!oldRentalData.rented,"Cannot deactivate an NFT that is being rented");
	COPY $oldRentalData r4 // 3058
	LOAD r5 "rented" // 3061
	GET r4 r4 r5 // 3071
	NOT r4 r4 // 3075
	JMPIF r4 @expect_methodcallexpression504 // 3078
	ALIAS r5 $literalexpression509 // 3082
	LOAD $literalexpression509 "Cannot deactivate an NFT that is being rented" // 3082
	THROW $literalexpression509 // 3131
	@expect_methodcallexpression504: NOP // 3134
// Line 114:    Runtime.expect(oldRentalData.active != activate, "active state is already: " + oldRentalData.active); //using oldRentalData.active if an error is present with this logic the user can compare what they entered vs the oldRental State
	COPY $oldRentalData r4 // 3134
	LOAD r5 "active" // 3137
	GET r4 r4 r5 // 3147
	COPY $activate r5 // 3151
	EQUAL r4 r5 r6 // 3154
	NOT r6 r6 // 3158
	JMPIF r6 @expect_methodcallexpression511 // 3161
	ALIAS r4 $literalexpression518 // 3165
	LOAD $literalexpression518 "active state is already: " // 3165
	COPY $oldRentalData r5 // 3194
	LOAD r7 "active" // 3197
	GET r5 r5 r7 // 3207
	CAST r5 r5 #String // 3211
	ADD $literalexpression518 r5 r7 // 3215
	THROW r7 // 3219
	@expect_methodcallexpression511: NOP // 3222
// Line 115:    Runtime.expect(Runtime.isWitness(oldRentalData.rentalOwner), "Must be owner of NFT to change active state");
	ALIAS r4 $methodcallexpression526 // 3222
	COPY $oldRentalData r5 // 3222
	LOAD r6 "rentalOwner" // 3225
	GET r5 r5 r6 // 3240
	PUSH r5 // 3244
	LOAD $methodcallexpression526 "Runtime.IsWitness" // 3246
	EXTCALL $methodcallexpression526 // 3267
	POP $methodcallexpression526 // 3269
	JMPIF $methodcallexpression526 @expect_methodcallexpression523 // 3271
	ALIAS r5 $literalexpression529 // 3275
	LOAD $literalexpression529 "Must be owner of NFT to change active state" // 3275
	THROW $literalexpression529 // 3322
	@expect_methodcallexpression523: NOP // 3325
// Line 116:    local newRentalData: rentalData = Struct.rentalData(activate,oldRentalData.rented,oldRentalData.timesRented,oldRentalData.rentalStart,oldRentalData.rentalEnd,oldRentalData.rentalOwner,oldRentalData.rentalOwner); //reset rental user to owner of nft
	ALIAS r4 $newRentalData // 3325
	CLEAR r5 // 3325
	COPY $activate r7 // 3327
	LOAD r6 "active" // 3330
	PUT r7 r5 r6 // 3340
	COPY $oldRentalData r7 // 3344
	LOAD r8 "rented" // 3347
	GET r7 r7 r8 // 3357
	LOAD r6 "rented" // 3361
	PUT r7 r5 r6 // 3371
	COPY $oldRentalData r7 // 3375
	LOAD r8 "timesRented" // 3378
	GET r7 r7 r8 // 3393
	LOAD r6 "timesRented" // 3397
	PUT r7 r5 r6 // 3412
	COPY $oldRentalData r7 // 3416
	LOAD r8 "rentalStart" // 3419
	GET r7 r7 r8 // 3434
	LOAD r6 "rentalStart" // 3438
	PUT r7 r5 r6 // 3453
	COPY $oldRentalData r7 // 3457
	LOAD r8 "rentalEnd" // 3460
	GET r7 r7 r8 // 3473
	LOAD r6 "rentalEnd" // 3477
	PUT r7 r5 r6 // 3490
	COPY $oldRentalData r7 // 3494
	LOAD r8 "rentalOwner" // 3497
	GET r7 r7 r8 // 3512
	LOAD r6 "rentalUser" // 3516
	PUT r7 r5 r6 // 3530
	COPY $oldRentalData r7 // 3534
	LOAD r8 "rentalOwner" // 3537
	GET r7 r7 r8 // 3552
	LOAD r6 "rentalOwner" // 3556
	PUT r7 r5 r6 // 3571
	COPY r5 $newRentalData // 3575
// Line 117:    rentals.set(id,newRentalData);
	ALIAS r5 $methodcallexpression548 // 3578
	COPY $newRentalData r6 // 3578
	PUSH r6 // 3581
	COPY $id r6 // 3583
	PUSH r6 // 3586
	ALIAS r6 $literalexpression554 // 3588
	LOAD $literalexpression554 "rentals" // 3588
	PUSH $literalexpression554 // 3599
	LOAD $methodcallexpression548 "Map.Set" // 3601
	EXTCALL $methodcallexpression548 // 3612
@exit_DeactivateOrActivateRental: // 3614
RET // 3615
