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
// Line 20:contract rentaltest01{
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
	LOAD $literalexpression167 "rentaltest01" // contract name // 232
	PUSH $literalexpression167 // 248
	LOAD r3 "Map.Has" // 250
	EXTCALL r3 // 261
	POP r3 // 263
	NOT r3 r3 // 265
	JMPIF r3 @expect_methodcallexpression148 // 268
	ALIAS r4 $literalexpression170 // 272
	LOAD $literalexpression170 "Nft is already in the pool of rentals." // 272
	THROW $literalexpression170 // 314
	@expect_methodcallexpression148: NOP // 317
// Line 40:    Runtime.expect(Runtime.isWitness(owner),"Must own NFT to rent it out");
	ALIAS r3 $methodcallexpression175 // 317
	COPY $owner r4 // 317
	PUSH r4 // 320
	LOAD $methodcallexpression175 "Runtime.IsWitness" // 322
	EXTCALL $methodcallexpression175 // 343
	POP $methodcallexpression175 // 345
	JMPIF $methodcallexpression175 @expect_methodcallexpression172 // 347
	ALIAS r4 $literalexpression178 // 351
	LOAD $literalexpression178 "Must own NFT to rent it out" // 351
	THROW $literalexpression178 // 382
	@expect_methodcallexpression172: NOP // 385
// Line 41:    local newRentalData: rentalData = Struct.rentalData(true,false,0,0,0,owner,owner);
	ALIAS r3 $newRentalData // 385
	CLEAR r4 // 385
	ALIAS r6 $literalexpression187 // 387
	LOAD $literalexpression187 true // 387
	LOAD r5 "active" // 392
	PUT $literalexpression187 r4 r5 // 402
	ALIAS r6 $literalexpression188 // 406
	LOAD $literalexpression188 false // 406
	LOAD r5 "rented" // 411
	PUT $literalexpression188 r4 r5 // 421
	ALIAS r6 $literalexpression189 // 425
	LOAD $literalexpression189 0 // 425
	LOAD r5 "timesRented" // 430
	PUT $literalexpression189 r4 r5 // 445
	ALIAS r6 $literalexpression190 // 449
	LOAD $literalexpression190 0 // 449
	LOAD r5 "rentalStart" // 454
	PUT $literalexpression190 r4 r5 // 469
	ALIAS r6 $literalexpression191 // 473
	LOAD $literalexpression191 0 // 473
	LOAD r5 "rentalEnd" // 478
	PUT $literalexpression191 r4 r5 // 491
	COPY $owner r6 // 495
	LOAD r5 "rentalUser" // 498
	PUT r6 r4 r5 // 512
	COPY $owner r6 // 516
	LOAD r5 "rentalOwner" // 519
	PUT r6 r4 r5 // 534
	COPY r4 $newRentalData // 538
// Line 42:    rentals.set(id,newRentalData);
	ALIAS r4 $methodcallexpression197 // 541
	COPY $newRentalData r5 // 541
	PUSH r5 // 544
	COPY $id r5 // 546
	PUSH r5 // 549
	ALIAS r5 $literalexpression203 // 551
	LOAD $literalexpression203 "rentals" // 551
	PUSH $literalexpression203 // 562
	LOAD $methodcallexpression197 "Map.Set" // 564
	EXTCALL $methodcallexpression197 // 575
@exit_AddRental: // 577
RET // 578
// Line 43:
// Line 44:  }

// ********* RentNft Method ***********
@entry_RentNft: // 579
// Line 45:  
// Line 46:  public RentNft(rentalUser:address, id:number){
ALIAS r1 $rentalUser // 580
POP $rentalUser // 580
PUSH $rentalUser // 582
EXTCALL "Address()" // 584
POP $rentalUser // 599
ALIAS r2 $id // 601
POP $id // 601
CAST $id $id #Number // 603
// Line 47:    
// Line 48:    Runtime.expect(rentals.has(id),"There is no such rental associated with the supplied ID");
	LOAD r3 6 // field type // 607
	PUSH r3 // 612
	COPY $id r4 // 614
	PUSH r4 // 617
	ALIAS r4 $literalexpression220 // 619
	LOAD $literalexpression220 "rentals" // 619
	PUSH $literalexpression220 // 630
	LOAD $literalexpression220 "rentaltest01" // contract name // 632
	PUSH $literalexpression220 // 648
	LOAD r3 "Map.Has" // 650
	EXTCALL r3 // 661
	POP r3 // 663
	JMPIF r3 @expect_methodcallexpression213 // 665
	ALIAS r4 $literalexpression222 // 669
	LOAD $literalexpression222 "There is no such rental associated with the supplied ID" // 669
	THROW $literalexpression222 // 728
	@expect_methodcallexpression213: NOP // 731
// Line 49:    local oldRentalData: rentalData = rentals.get(id);
	ALIAS r3 $oldRentalData // 731
	LOAD r4 1 // field type // 731
	PUSH r4 // 736
	COPY $id r5 // 738
	PUSH r5 // 741
	ALIAS r5 $literalexpression227 // 743
	LOAD $literalexpression227 "rentals" // 743
	PUSH $literalexpression227 // 754
	LOAD $literalexpression227 "rentaltest01" // contract name // 756
	PUSH $literalexpression227 // 772
	LOAD r4 "Map.Get" // 774
	EXTCALL r4 // 785
	POP r4 // 787
	UNPACK r4 r4 // 789
	COPY r4 $oldRentalData // 792
// Line 50:    Runtime.expect(oldRentalData.active,"NFT is not available for rental");//active must be true for a user to rent
	COPY $oldRentalData r4 // 795
	LOAD r5 "active" // 798
	GET r4 r4 r5 // 808
	JMPIF r4 @expect_methodcallexpression232 // 812
	ALIAS r5 $literalexpression236 // 816
	LOAD $literalexpression236 "NFT is not available for rental" // 816
	THROW $literalexpression236 // 851
	@expect_methodcallexpression232: NOP // 854
// Line 51:    Runtime.expect(!oldRentalData.rented,"NFT is already being rented");
	COPY $oldRentalData r4 // 854
	LOAD r5 "rented" // 857
	GET r4 r4 r5 // 867
	NOT r4 r4 // 871
	JMPIF r4 @expect_methodcallexpression238 // 874
	ALIAS r5 $literalexpression243 // 878
	LOAD $literalexpression243 "NFT is already being rented" // 878
	THROW $literalexpression243 // 909
	@expect_methodcallexpression238: NOP // 912
// Line 52:    Runtime.expect(Runtime.isWitness(rentalUser),"Must be renter of NFT");
	ALIAS r4 $methodcallexpression248 // 912
	COPY $rentalUser r5 // 912
	PUSH r5 // 915
	LOAD $methodcallexpression248 "Runtime.IsWitness" // 917
	EXTCALL $methodcallexpression248 // 938
	POP $methodcallexpression248 // 940
	JMPIF $methodcallexpression248 @expect_methodcallexpression245 // 942
	ALIAS r5 $literalexpression251 // 946
	LOAD $literalexpression251 "Must be renter of NFT" // 946
	THROW $literalexpression251 // 971
	@expect_methodcallexpression245: NOP // 974
// Line 53:    local newRentalData: rentalData = Struct.rentalData(oldRentalData.active,true,oldRentalData.timesRented+1,0,0,rentalUser,oldRentalData.rentalOwner);
	ALIAS r4 $newRentalData // 974
	CLEAR r5 // 974
	COPY $oldRentalData r7 // 976
	LOAD r8 "active" // 979
	GET r7 r7 r8 // 989
	LOAD r6 "active" // 993
	PUT r7 r5 r6 // 1003
	ALIAS r7 $literalexpression261 // 1007
	LOAD $literalexpression261 true // 1007
	LOAD r6 "rented" // 1012
	PUT $literalexpression261 r5 r6 // 1022
	COPY $oldRentalData r7 // 1026
	LOAD r8 "timesRented" // 1029
	GET r7 r7 r8 // 1044
	ALIAS r8 $literalexpression263 // 1048
	LOAD $literalexpression263 1 // 1048
	ADD r7 $literalexpression263 r9 // 1053
	LOAD r6 "timesRented" // 1057
	PUT r9 r5 r6 // 1072
	ALIAS r7 $literalexpression265 // 1076
	LOAD $literalexpression265 0 // 1076
	LOAD r6 "rentalStart" // 1081
	PUT $literalexpression265 r5 r6 // 1096
	ALIAS r7 $literalexpression266 // 1100
	LOAD $literalexpression266 0 // 1100
	LOAD r6 "rentalEnd" // 1105
	PUT $literalexpression266 r5 r6 // 1118
	COPY $rentalUser r7 // 1122
	LOAD r6 "rentalUser" // 1125
	PUT r7 r5 r6 // 1139
	COPY $oldRentalData r7 // 1143
	LOAD r8 "rentalOwner" // 1146
	GET r7 r7 r8 // 1161
	LOAD r6 "rentalOwner" // 1165
	PUT r7 r5 r6 // 1180
	COPY r5 $newRentalData // 1184
// Line 54:    rentals.set(id,newRentalData);
	ALIAS r5 $methodcallexpression272 // 1187
	COPY $newRentalData r6 // 1187
	PUSH r6 // 1190
	COPY $id r6 // 1192
	PUSH r6 // 1195
	ALIAS r6 $literalexpression278 // 1197
	LOAD $literalexpression278 "rentals" // 1197
	PUSH $literalexpression278 // 1208
	LOAD $methodcallexpression272 "Map.Set" // 1210
	EXTCALL $methodcallexpression272 // 1221
@exit_RentNft: // 1223
RET // 1224
// Line 55:   
// Line 56:
// Line 57:  }

// ********* RentNftOnBehalf Method ***********
@entry_RentNftOnBehalf: // 1225
// Line 58:
// Line 59:  //Allows a user to rent an NFT for another user. Similar to Gifting.
// Line 60:  public RentNftOnBehalf(from:address,to:address,id:number){
ALIAS r1 $from // 1226
POP $from // 1226
PUSH $from // 1228
EXTCALL "Address()" // 1230
POP $from // 1245
ALIAS r2 $to // 1247
POP $to // 1247
PUSH $to // 1249
EXTCALL "Address()" // 1251
POP $to // 1266
ALIAS r3 $id // 1268
POP $id // 1268
CAST $id $id #Number // 1270
// Line 61:    
// Line 62:    Runtime.expect(rentals.has(id),"There is no such rental associated with the supplied ID");
	LOAD r4 6 // field type // 1274
	PUSH r4 // 1279
	COPY $id r5 // 1281
	PUSH r5 // 1284
	ALIAS r5 $literalexpression297 // 1286
	LOAD $literalexpression297 "rentals" // 1286
	PUSH $literalexpression297 // 1297
	LOAD $literalexpression297 "rentaltest01" // contract name // 1299
	PUSH $literalexpression297 // 1315
	LOAD r4 "Map.Has" // 1317
	EXTCALL r4 // 1328
	POP r4 // 1330
	JMPIF r4 @expect_methodcallexpression290 // 1332
	ALIAS r5 $literalexpression299 // 1336
	LOAD $literalexpression299 "There is no such rental associated with the supplied ID" // 1336
	THROW $literalexpression299 // 1395
	@expect_methodcallexpression290: NOP // 1398
// Line 63:    local oldRentalData: rentalData = rentals.get(id);
	ALIAS r4 $oldRentalData // 1398
	LOAD r5 1 // field type // 1398
	PUSH r5 // 1403
	COPY $id r6 // 1405
	PUSH r6 // 1408
	ALIAS r6 $literalexpression304 // 1410
	LOAD $literalexpression304 "rentals" // 1410
	PUSH $literalexpression304 // 1421
	LOAD $literalexpression304 "rentaltest01" // contract name // 1423
	PUSH $literalexpression304 // 1439
	LOAD r5 "Map.Get" // 1441
	EXTCALL r5 // 1452
	POP r5 // 1454
	UNPACK r5 r5 // 1456
	COPY r5 $oldRentalData // 1459
// Line 64:    Runtime.expect(oldRentalData.active,"NFT is not available for rental");//active must be true for a user to rent
	COPY $oldRentalData r5 // 1462
	LOAD r6 "active" // 1465
	GET r5 r5 r6 // 1475
	JMPIF r5 @expect_methodcallexpression309 // 1479
	ALIAS r6 $literalexpression313 // 1483
	LOAD $literalexpression313 "NFT is not available for rental" // 1483
	THROW $literalexpression313 // 1518
	@expect_methodcallexpression309: NOP // 1521
// Line 65:    Runtime.expect(!oldRentalData.rented,"NFT is already being rented");
	COPY $oldRentalData r5 // 1521
	LOAD r6 "rented" // 1524
	GET r5 r5 r6 // 1534
	NOT r5 r5 // 1538
	JMPIF r5 @expect_methodcallexpression315 // 1541
	ALIAS r6 $literalexpression320 // 1545
	LOAD $literalexpression320 "NFT is already being rented" // 1545
	THROW $literalexpression320 // 1576
	@expect_methodcallexpression315: NOP // 1579
// Line 66:    Runtime.expect(Runtime.isWitness(from),"Must be user gifting the NFT");
	ALIAS r5 $methodcallexpression325 // 1579
	COPY $from r6 // 1579
	PUSH r6 // 1582
	LOAD $methodcallexpression325 "Runtime.IsWitness" // 1584
	EXTCALL $methodcallexpression325 // 1605
	POP $methodcallexpression325 // 1607
	JMPIF $methodcallexpression325 @expect_methodcallexpression322 // 1609
	ALIAS r6 $literalexpression328 // 1613
	LOAD $literalexpression328 "Must be user gifting the NFT" // 1613
	THROW $literalexpression328 // 1645
	@expect_methodcallexpression322: NOP // 1648
// Line 67:    local newRentalData: rentalData = Struct.rentalData(oldRentalData.active,true,oldRentalData.timesRented+1,0,0,to,oldRentalData.rentalOwner);
	ALIAS r5 $newRentalData // 1648
	CLEAR r6 // 1648
	COPY $oldRentalData r8 // 1650
	LOAD r9 "active" // 1653
	GET r8 r8 r9 // 1663
	LOAD r7 "active" // 1667
	PUT r8 r6 r7 // 1677
	ALIAS r8 $literalexpression338 // 1681
	LOAD $literalexpression338 true // 1681
	LOAD r7 "rented" // 1686
	PUT $literalexpression338 r6 r7 // 1696
	COPY $oldRentalData r8 // 1700
	LOAD r9 "timesRented" // 1703
	GET r8 r8 r9 // 1718
	ALIAS r9 $literalexpression340 // 1722
	LOAD $literalexpression340 1 // 1722
	ADD r8 $literalexpression340 r10 // 1727
	LOAD r7 "timesRented" // 1731
	PUT r10 r6 r7 // 1746
	ALIAS r8 $literalexpression342 // 1750
	LOAD $literalexpression342 0 // 1750
	LOAD r7 "rentalStart" // 1755
	PUT $literalexpression342 r6 r7 // 1770
	ALIAS r8 $literalexpression343 // 1774
	LOAD $literalexpression343 0 // 1774
	LOAD r7 "rentalEnd" // 1779
	PUT $literalexpression343 r6 r7 // 1792
	COPY $to r8 // 1796
	LOAD r7 "rentalUser" // 1799
	PUT r8 r6 r7 // 1813
	COPY $oldRentalData r8 // 1817
	LOAD r9 "rentalOwner" // 1820
	GET r8 r8 r9 // 1835
	LOAD r7 "rentalOwner" // 1839
	PUT r8 r6 r7 // 1854
	COPY r6 $newRentalData // 1858
// Line 68:    rentals.set(id,newRentalData);
	ALIAS r6 $methodcallexpression349 // 1861
	COPY $newRentalData r7 // 1861
	PUSH r7 // 1864
	COPY $id r7 // 1866
	PUSH r7 // 1869
	ALIAS r7 $literalexpression355 // 1871
	LOAD $literalexpression355 "rentals" // 1871
	PUSH $literalexpression355 // 1882
	LOAD $methodcallexpression349 "Map.Set" // 1884
	EXTCALL $methodcallexpression349 // 1895
@exit_RentNftOnBehalf: // 1897
RET // 1898
// Line 69:    
// Line 70:  }

// ********* RentalEnded Method ***********
@entry_RentalEnded: // 1899
// Line 71:
// Line 72:    /************************************************************************
// Line 73:     For test purposes anyone can end the rental
// Line 74:     - When ready for production this should change to the contract owner
// Line 75:    ***********************************************************************/
// Line 76:  public RentalEnded(id: number){
ALIAS r1 $id // 1900
POP $id // 1900
CAST $id $id #Number // 1902
// Line 77:
// Line 78:    //Runtime.expect(Runtime.isWitness(_owner),"Must have admin privileges to access this function");
// Line 79:    Runtime.expect(rentals.has(id),"There is no such rental associated with the supplied ID");
	LOAD r2 6 // field type // 1906
	PUSH r2 // 1911
	COPY $id r3 // 1913
	PUSH r3 // 1916
	ALIAS r3 $literalexpression370 // 1918
	LOAD $literalexpression370 "rentals" // 1918
	PUSH $literalexpression370 // 1929
	LOAD $literalexpression370 "rentaltest01" // contract name // 1931
	PUSH $literalexpression370 // 1947
	LOAD r2 "Map.Has" // 1949
	EXTCALL r2 // 1960
	POP r2 // 1962
	JMPIF r2 @expect_methodcallexpression363 // 1964
	ALIAS r3 $literalexpression372 // 1968
	LOAD $literalexpression372 "There is no such rental associated with the supplied ID" // 1968
	THROW $literalexpression372 // 2027
	@expect_methodcallexpression363: NOP // 2030
// Line 80:    local oldRentalData: rentalData = rentals.get(id);
	ALIAS r2 $oldRentalData // 2030
	LOAD r3 1 // field type // 2030
	PUSH r3 // 2035
	COPY $id r4 // 2037
	PUSH r4 // 2040
	ALIAS r4 $literalexpression377 // 2042
	LOAD $literalexpression377 "rentals" // 2042
	PUSH $literalexpression377 // 2053
	LOAD $literalexpression377 "rentaltest01" // contract name // 2055
	PUSH $literalexpression377 // 2071
	LOAD r3 "Map.Get" // 2073
	EXTCALL r3 // 2084
	POP r3 // 2086
	UNPACK r3 r3 // 2088
	COPY r3 $oldRentalData // 2091
// Line 81:    local newRentalData: rentalData = Struct.rentalData(true,false,oldRentalData.timesRented,0,0,oldRentalData.rentalOwner,oldRentalData.rentalOwner);
	ALIAS r3 $newRentalData // 2094
	CLEAR r4 // 2094
	ALIAS r6 $literalexpression389 // 2096
	LOAD $literalexpression389 true // 2096
	LOAD r5 "active" // 2101
	PUT $literalexpression389 r4 r5 // 2111
	ALIAS r6 $literalexpression390 // 2115
	LOAD $literalexpression390 false // 2115
	LOAD r5 "rented" // 2120
	PUT $literalexpression390 r4 r5 // 2130
	COPY $oldRentalData r6 // 2134
	LOAD r7 "timesRented" // 2137
	GET r6 r6 r7 // 2152
	LOAD r5 "timesRented" // 2156
	PUT r6 r4 r5 // 2171
	ALIAS r6 $literalexpression392 // 2175
	LOAD $literalexpression392 0 // 2175
	LOAD r5 "rentalStart" // 2180
	PUT $literalexpression392 r4 r5 // 2195
	ALIAS r6 $literalexpression393 // 2199
	LOAD $literalexpression393 0 // 2199
	LOAD r5 "rentalEnd" // 2204
	PUT $literalexpression393 r4 r5 // 2217
	COPY $oldRentalData r6 // 2221
	LOAD r7 "rentalOwner" // 2224
	GET r6 r6 r7 // 2239
	LOAD r5 "rentalUser" // 2243
	PUT r6 r4 r5 // 2257
	COPY $oldRentalData r6 // 2261
	LOAD r7 "rentalOwner" // 2264
	GET r6 r6 r7 // 2279
	LOAD r5 "rentalOwner" // 2283
	PUT r6 r4 r5 // 2298
	COPY r4 $newRentalData // 2302
// Line 82:    rentals.set(id,newRentalData);
	ALIAS r4 $methodcallexpression399 // 2305
	COPY $newRentalData r5 // 2305
	PUSH r5 // 2308
	COPY $id r5 // 2310
	PUSH r5 // 2313
	ALIAS r5 $literalexpression405 // 2315
	LOAD $literalexpression405 "rentals" // 2315
	PUSH $literalexpression405 // 2326
	LOAD $methodcallexpression399 "Map.Set" // 2328
	EXTCALL $methodcallexpression399 // 2339
@exit_RentalEnded: // 2341
RET // 2342
// Line 83:  }

// ********* getRentalInfo Method ***********
@entry_getRentalInfo: // 2343
// Line 84:
// Line 85:  public getRentalInfo(id:number): rentalData {
ALIAS r1 $id // 2344
POP $id // 2344
CAST $id $id #Number // 2346
// Line 86:
// Line 87:        Runtime.expect(rentals.has(id), "ID is not valid");
	LOAD r2 6 // field type // 2350
	PUSH r2 // 2355
	COPY $id r3 // 2357
	PUSH r3 // 2360
	ALIAS r3 $literalexpression420 // 2362
	LOAD $literalexpression420 "rentals" // 2362
	PUSH $literalexpression420 // 2373
	LOAD $literalexpression420 "rentaltest01" // contract name // 2375
	PUSH $literalexpression420 // 2391
	LOAD r2 "Map.Has" // 2393
	EXTCALL r2 // 2404
	POP r2 // 2406
	JMPIF r2 @expect_methodcallexpression413 // 2408
	ALIAS r3 $literalexpression422 // 2412
	LOAD $literalexpression422 "ID is not valid" // 2412
	THROW $literalexpression422 // 2431
	@expect_methodcallexpression413: NOP // 2434
// Line 88:        local oldRentalData: rentalData = rentals.get(id);
	ALIAS r2 $oldRentalData // 2434
	LOAD r3 1 // field type // 2434
	PUSH r3 // 2439
	COPY $id r4 // 2441
	PUSH r4 // 2444
	ALIAS r4 $literalexpression427 // 2446
	LOAD $literalexpression427 "rentals" // 2446
	PUSH $literalexpression427 // 2457
	LOAD $literalexpression427 "rentaltest01" // contract name // 2459
	PUSH $literalexpression427 // 2475
	LOAD r3 "Map.Get" // 2477
	EXTCALL r3 // 2488
	POP r3 // 2490
	UNPACK r3 r3 // 2492
	COPY r3 $oldRentalData // 2495
// Line 89:        return oldRentalData;
	COPY $oldRentalData r3 // 2498
	PUSH r3 // 2501
	JMP @exit_getRentalInfo // 2503
@exit_getRentalInfo: // 2506
RET // 2507
// Line 90:  }

// ********* RemoveRental Method ***********
@entry_RemoveRental: // 2508
// Line 91:
// Line 92:  //When owner wants to permanently remove rental from storage map, will have to add it back with stats reset to 0 if this is called
// Line 93:  public RemoveRental(id:number){
ALIAS r1 $id // 2509
POP $id // 2509
CAST $id $id #Number // 2511
// Line 94:
// Line 95:    /*********************************************************************************************
// Line 96:    Design Choice: Personally for optimization I want to expect a user to verify they
// Line 97:        are the owner of the nft before loading in the rental data.However, psychologically
// Line 98:        it would please the user to know once they sign then everything is okay, versus signing
// Line 99:        and then finding out that the nft is being rented.
// Line 100:    *********************************************************************************************/
// Line 101:    Runtime.expect(rentals.has(id),"No such ID exist in the rental database");
	LOAD r2 6 // field type // 2515
	PUSH r2 // 2520
	COPY $id r3 // 2522
	PUSH r3 // 2525
	ALIAS r3 $literalexpression445 // 2527
	LOAD $literalexpression445 "rentals" // 2527
	PUSH $literalexpression445 // 2538
	LOAD $literalexpression445 "rentaltest01" // contract name // 2540
	PUSH $literalexpression445 // 2556
	LOAD r2 "Map.Has" // 2558
	EXTCALL r2 // 2569
	POP r2 // 2571
	JMPIF r2 @expect_methodcallexpression438 // 2573
	ALIAS r3 $literalexpression447 // 2577
	LOAD $literalexpression447 "No such ID exist in the rental database" // 2577
	THROW $literalexpression447 // 2620
	@expect_methodcallexpression438: NOP // 2623
// Line 102:    local oldRentalData: rentalData = rentals.get(id);
	ALIAS r2 $oldRentalData // 2623
	LOAD r3 1 // field type // 2623
	PUSH r3 // 2628
	COPY $id r4 // 2630
	PUSH r4 // 2633
	ALIAS r4 $literalexpression452 // 2635
	LOAD $literalexpression452 "rentals" // 2635
	PUSH $literalexpression452 // 2646
	LOAD $literalexpression452 "rentaltest01" // contract name // 2648
	PUSH $literalexpression452 // 2664
	LOAD r3 "Map.Get" // 2666
	EXTCALL r3 // 2677
	POP r3 // 2679
	UNPACK r3 r3 // 2681
	COPY r3 $oldRentalData // 2684
// Line 103:    Runtime.expect(!oldRentalData.rented,"Cannot remove an NFT that is being rented");
	COPY $oldRentalData r3 // 2687
	LOAD r4 "rented" // 2690
	GET r3 r3 r4 // 2700
	NOT r3 r3 // 2704
	JMPIF r3 @expect_methodcallexpression457 // 2707
	ALIAS r4 $literalexpression462 // 2711
	LOAD $literalexpression462 "Cannot remove an NFT that is being rented" // 2711
	THROW $literalexpression462 // 2756
	@expect_methodcallexpression457: NOP // 2759
// Line 104:    Runtime.expect(Runtime.isWitness(oldRentalData.rentalOwner), "Must be owner of NFT to permanently remove rental");
	ALIAS r3 $methodcallexpression467 // 2759
	COPY $oldRentalData r4 // 2759
	LOAD r5 "rentalOwner" // 2762
	GET r4 r4 r5 // 2777
	PUSH r4 // 2781
	LOAD $methodcallexpression467 "Runtime.IsWitness" // 2783
	EXTCALL $methodcallexpression467 // 2804
	POP $methodcallexpression467 // 2806
	JMPIF $methodcallexpression467 @expect_methodcallexpression464 // 2808
	ALIAS r4 $literalexpression470 // 2812
	LOAD $literalexpression470 "Must be owner of NFT to permanently remove rental" // 2812
	THROW $literalexpression470 // 2865
	@expect_methodcallexpression464: NOP // 2868
// Line 105:    rentals.remove(id);
	ALIAS r3 $methodcallexpression472 // 2868
	COPY $id r4 // 2868
	PUSH r4 // 2871
	ALIAS r4 $literalexpression476 // 2873
	LOAD $literalexpression476 "rentals" // 2873
	PUSH $literalexpression476 // 2884
	LOAD $methodcallexpression472 "Map.Remove" // 2886
	EXTCALL $methodcallexpression472 // 2900
@exit_RemoveRental: // 2902
RET // 2903
// Line 106:    }

// ********* DeactivateOrActivateRental Method ***********
@entry_DeactivateOrActivateRental: // 2904
// Line 107:
// Line 108:  //In the case that an owner wants to deactivate his/her nft from being rented
// Line 109:  public DeactivateOrActivateRental(activate:bool,id: number){
ALIAS r1 $activate // 2905
POP $activate // 2905
ALIAS r2 $id // 2907
POP $id // 2907
CAST $id $id #Number // 2909
// Line 110:    local sval: string = activate;
	ALIAS r3 $sval // 2913
	COPY $activate r4 // 2913
	COPY r4 $sval // 2916
// Line 111:    
// Line 112:    if(sval != "true" && sval != "1" && sval != "false" && sval != "0"){
	COPY $sval r4 // 2919
	ALIAS r5 $literalexpression489 // 2922
	LOAD $literalexpression489 "true" // 2922
	EQUAL r4 $literalexpression489 r6 // 2930
	NOT r6 r6 // 2934
	COPY $sval r4 // 2937
	ALIAS r5 $literalexpression493 // 2940
	LOAD $literalexpression493 "1" // 2940
	EQUAL r4 $literalexpression493 r7 // 2945
	NOT r7 r7 // 2949
	COPY $sval r4 // 2952
	ALIAS r5 $literalexpression497 // 2955
	LOAD $literalexpression497 "false" // 2955
	EQUAL r4 $literalexpression497 r8 // 2964
	NOT r8 r8 // 2968
	COPY $sval r4 // 2971
	ALIAS r5 $literalexpression501 // 2974
	LOAD $literalexpression501 "0" // 2974
	EQUAL r4 $literalexpression501 r9 // 2979
	NOT r9 r9 // 2983
	AND r8 r9 r4 // 2986
	AND r7 r4 r5 // 2990
	AND r6 r5 r4 // 2994
		JMPNOT r4 @then_ifstatement487 // 2998
// Line 113:        
// Line 114:        throw "Value entered is not valid: " +sval;
		ALIAS r5 $literalexpression508 // 3002
		LOAD $literalexpression508 "Value entered is not valid: " // 3002
		COPY $sval r6 // 3034
		ADD $literalexpression508 r6 r7 // 3037
		THROW r7 // 3041
		@then_ifstatement487: NOP // 3044
// Line 115:
// Line 116:    }
// Line 117:    // no need to waste a variable if the above throws an error
// Line 118:    local bval: bool;
// Line 119:    if(sval == "true" || sval == "1"){
	COPY $sval r4 // 3044
	ALIAS r5 $literalexpression515 // 3047
	LOAD $literalexpression515 "true" // 3047
	EQUAL r4 $literalexpression515 r6 // 3055
	COPY $sval r4 // 3059
	ALIAS r5 $literalexpression518 // 3062
	LOAD $literalexpression518 "1" // 3062
	EQUAL r4 $literalexpression518 r7 // 3067
	OR r6 r7 r4 // 3071
		JMPNOT r4 @else_ifstatement513 // 3075
		ALIAS r5 $bval // 3079
// Line 120:        bval = true;
		ALIAS r6 $literalexpression523 // 3079
		LOAD $literalexpression523 true // 3079
		COPY $literalexpression523 $bval // 3084
		JMP @then_ifstatement513 // 3087
		@else_ifstatement513: NOP // 3091
// Line 121:    }
// Line 122:    else{
// Line 123:        bval = false;
		ALIAS r6 $literalexpression526 // 3091
		LOAD $literalexpression526 false // 3091
		COPY $literalexpression526 $bval // 3096
		@then_ifstatement513: NOP // 3100
// Line 124:    }
// Line 125:
// Line 126:    Runtime.expect(rentals.has(id),"NFT is not a part of Available Rentals");
	LOAD r4 6 // field type // 3100
	PUSH r4 // 3105
	COPY $id r6 // 3107
	PUSH r6 // 3110
	ALIAS r6 $literalexpression535 // 3112
	LOAD $literalexpression535 "rentals" // 3112
	PUSH $literalexpression535 // 3123
	LOAD $literalexpression535 "rentaltest01" // contract name // 3125
	PUSH $literalexpression535 // 3141
	LOAD r4 "Map.Has" // 3143
	EXTCALL r4 // 3154
	POP r4 // 3156
	JMPIF r4 @expect_methodcallexpression528 // 3158
	ALIAS r6 $literalexpression537 // 3162
	LOAD $literalexpression537 "NFT is not a part of Available Rentals" // 3162
	THROW $literalexpression537 // 3204
	@expect_methodcallexpression528: NOP // 3207
// Line 127:    local oldRentalData: rentalData = rentals.get(id);
	ALIAS r4 $oldRentalData // 3207
	LOAD r6 1 // field type // 3207
	PUSH r6 // 3212
	COPY $id r7 // 3214
	PUSH r7 // 3217
	ALIAS r7 $literalexpression542 // 3219
	LOAD $literalexpression542 "rentals" // 3219
	PUSH $literalexpression542 // 3230
	LOAD $literalexpression542 "rentaltest01" // contract name // 3232
	PUSH $literalexpression542 // 3248
	LOAD r6 "Map.Get" // 3250
	EXTCALL r6 // 3261
	POP r6 // 3263
	UNPACK r6 r6 // 3265
	COPY r6 $oldRentalData // 3268
// Line 128:    Runtime.expect(!oldRentalData.rented,"Cannot deactivate an NFT that is being rented");
	COPY $oldRentalData r6 // 3271
	LOAD r7 "rented" // 3274
	GET r6 r6 r7 // 3284
	NOT r6 r6 // 3288
	JMPIF r6 @expect_methodcallexpression547 // 3291
	ALIAS r7 $literalexpression552 // 3295
	LOAD $literalexpression552 "Cannot deactivate an NFT that is being rented" // 3295
	THROW $literalexpression552 // 3344
	@expect_methodcallexpression547: NOP // 3347
// Line 129:    Runtime.expect(oldRentalData.active != bval, "active state is already: " + oldRentalData.active); //using oldRentalData.active if an error is present with this logic the user can compare what they entered vs the oldRental State
	COPY $oldRentalData r6 // 3347
	LOAD r7 "active" // 3350
	GET r6 r6 r7 // 3360
	COPY $bval r7 // 3364
	EQUAL r6 r7 r8 // 3367
	NOT r8 r8 // 3371
	JMPIF r8 @expect_methodcallexpression554 // 3374
	ALIAS r6 $literalexpression561 // 3378
	LOAD $literalexpression561 "active state is already: " // 3378
	COPY $oldRentalData r7 // 3407
	LOAD r9 "active" // 3410
	GET r7 r7 r9 // 3420
	CAST r7 r7 #String // 3424
	ADD $literalexpression561 r7 r9 // 3428
	THROW r9 // 3432
	@expect_methodcallexpression554: NOP // 3435
// Line 130:    Runtime.expect(Runtime.isWitness(oldRentalData.rentalOwner), "Must be owner of NFT to change active state");
	ALIAS r6 $methodcallexpression569 // 3435
	COPY $oldRentalData r7 // 3435
	LOAD r8 "rentalOwner" // 3438
	GET r7 r7 r8 // 3453
	PUSH r7 // 3457
	LOAD $methodcallexpression569 "Runtime.IsWitness" // 3459
	EXTCALL $methodcallexpression569 // 3480
	POP $methodcallexpression569 // 3482
	JMPIF $methodcallexpression569 @expect_methodcallexpression566 // 3484
	ALIAS r7 $literalexpression572 // 3488
	LOAD $literalexpression572 "Must be owner of NFT to change active state" // 3488
	THROW $literalexpression572 // 3535
	@expect_methodcallexpression566: NOP // 3538
// Line 131:    local newRentalData: rentalData = Struct.rentalData(bval,oldRentalData.rented,oldRentalData.timesRented,oldRentalData.rentalStart,oldRentalData.rentalEnd,oldRentalData.rentalOwner,oldRentalData.rentalOwner); //reset rental user to owner of nft
	ALIAS r6 $newRentalData // 3538
	CLEAR r7 // 3538
	COPY $bval r9 // 3540
	LOAD r8 "active" // 3543
	PUT r9 r7 r8 // 3553
	COPY $oldRentalData r9 // 3557
	LOAD r10 "rented" // 3560
	GET r9 r9 r10 // 3570
	LOAD r8 "rented" // 3574
	PUT r9 r7 r8 // 3584
	COPY $oldRentalData r9 // 3588
	LOAD r10 "timesRented" // 3591
	GET r9 r9 r10 // 3606
	LOAD r8 "timesRented" // 3610
	PUT r9 r7 r8 // 3625
	COPY $oldRentalData r9 // 3629
	LOAD r10 "rentalStart" // 3632
	GET r9 r9 r10 // 3647
	LOAD r8 "rentalStart" // 3651
	PUT r9 r7 r8 // 3666
	COPY $oldRentalData r9 // 3670
	LOAD r10 "rentalEnd" // 3673
	GET r9 r9 r10 // 3686
	LOAD r8 "rentalEnd" // 3690
	PUT r9 r7 r8 // 3703
	COPY $oldRentalData r9 // 3707
	LOAD r10 "rentalOwner" // 3710
	GET r9 r9 r10 // 3725
	LOAD r8 "rentalUser" // 3729
	PUT r9 r7 r8 // 3743
	COPY $oldRentalData r9 // 3747
	LOAD r10 "rentalOwner" // 3750
	GET r9 r9 r10 // 3765
	LOAD r8 "rentalOwner" // 3769
	PUT r9 r7 r8 // 3784
	COPY r7 $newRentalData // 3788
// Line 132:    rentals.set(id,newRentalData);
	ALIAS r7 $methodcallexpression591 // 3791
	COPY $newRentalData r8 // 3791
	PUSH r8 // 3794
	COPY $id r8 // 3796
	PUSH r8 // 3799
	ALIAS r8 $literalexpression597 // 3801
	LOAD $literalexpression597 "rentals" // 3801
	PUSH $literalexpression597 // 3812
	LOAD $methodcallexpression591 "Map.Set" // 3814
	EXTCALL $methodcallexpression591 // 3825
@exit_DeactivateOrActivateRental: // 3827
RET // 3828
// Line 133:  }

// ********* onUpgrade Trigger ***********
@entry_onUpgrade: // 3829
ALIAS r1 $dataGet // 3830
LOAD $dataGet "Data.Get" // 3830
ALIAS r2 $contractName // 3842
LOAD $contractName "rentaltest01" // 3842
ALIAS r3 $_owner // 3858
// reading global: _owner
LOAD r0 8 // 3858
PUSH r0 // 3863
LOAD r0 "_owner" // 3865
PUSH r0 // 3875
PUSH $contractName // 3877
EXTCALL $dataGet // 3879
POP $_owner // 3881
PUSH $_owner // 3883
EXTCALL "Address()" // 3885
POP $_owner // 3900
// Line 134:
// Line 135:   trigger onUpgrade(from:address)
ALIAS r1 $from // 3902
POP $from // 3902
PUSH $from // 3904
EXTCALL "Address()" // 3906
POP $from // 3921
// Line 136:    {
// Line 137:        Runtime.expect(Runtime.isWitness(_owner), "Only the owner can update");
	ALIAS r2 $methodcallexpression608 // 3923
	COPY $_owner r4 // 3923
	PUSH r4 // 3926
	LOAD $methodcallexpression608 "Runtime.IsWitness" // 3928
	EXTCALL $methodcallexpression608 // 3949
	POP $methodcallexpression608 // 3951
	JMPIF $methodcallexpression608 @expect_methodcallexpression605 // 3953
	ALIAS r4 $literalexpression611 // 3957
	LOAD $literalexpression611 "Only the owner can update" // 3957
	THROW $literalexpression611 // 3986
	@expect_methodcallexpression605: NOP // 3989
// Line 138:        return;
	JMP @exit_onUpgrade // 3989
@exit_onUpgrade: // 3992
RET // 3993
// Line 139:    }

// ********* onKill Trigger ***********
@entry_onKill: // 3994
ALIAS r1 $dataGet // 3995
LOAD $dataGet "Data.Get" // 3995
ALIAS r2 $contractName // 4007
LOAD $contractName "rentaltest01" // 4007
ALIAS r3 $_owner // 4023
// reading global: _owner
LOAD r0 8 // 4023
PUSH r0 // 4028
LOAD r0 "_owner" // 4030
PUSH r0 // 4040
PUSH $contractName // 4042
EXTCALL $dataGet // 4044
POP $_owner // 4046
PUSH $_owner // 4048
EXTCALL "Address()" // 4050
POP $_owner // 4065
// Line 140:    
// Line 141:    trigger onKill(from:address){
ALIAS r1 $from // 4067
POP $from // 4067
PUSH $from // 4069
EXTCALL "Address()" // 4071
POP $from // 4086
// Line 142:        Runtime.expect(Runtime.isWitness(_owner), "Only the owner can delete");
	ALIAS r2 $methodcallexpression621 // 4088
	COPY $_owner r4 // 4088
	PUSH r4 // 4091
	LOAD $methodcallexpression621 "Runtime.IsWitness" // 4093
	EXTCALL $methodcallexpression621 // 4114
	POP $methodcallexpression621 // 4116
	JMPIF $methodcallexpression621 @expect_methodcallexpression618 // 4118
	ALIAS r4 $literalexpression624 // 4122
	LOAD $literalexpression624 "Only the owner can delete" // 4122
	THROW $literalexpression624 // 4151
	@expect_methodcallexpression618: NOP // 4154
// Line 143:        return;
	JMP @exit_onKill // 4154
@exit_onKill: // 4157
RET // 4158
