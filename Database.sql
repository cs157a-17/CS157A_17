-- ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password123';

-- SELECT * FROM users;
-- SELECT * FROM suppliers;
-- SELECT * FROM supply;
-- SELECT * FROM payingusers;
-- SELECT * FROM items;
-- SELECT * FROM carts;
-- SELECT * FROM addresses;
-- SELECT * FROM HaveU;
-- SELECT * FROM HavePU;
-- SELECT * FROM HaveS;
-- SELECT * FROM BuyIn;
-- SELECT * FROM Buy;
-- SELECT * FROM Search;

use cs157a;

/*create table*/
CREATE TABLE `cs157a`.`users` (
  `UserID` VARCHAR(255) NOT NULL,
  `Password` VARCHAR(255) NOT NULL,
  `FirstName` VARCHAR(255) NOT NULL,
  `LastName` VARCHAR(255) NOT NULL,
  `PhoneNumber` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`UserID`));
  
CREATE TABLE `cs157a`.`items` (
  `ItemID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Description` VARCHAR(2550) NULL,
  `image` BLOB NULL,
  `Category` VARCHAR(255) NULL,
  `Stock` INT NOT NULL,
  `Price` DOUBLE NOT NULL,
  `Shipping Days` DATE NULL,
  PRIMARY KEY (`ItemID`)); 

CREATE TABLE `cs157a`.`payingusers` (
  `CardNumber` INT NOT NULL,
  `CardHolderName` VARCHAR(255) NOT NULL,
  `Expiration` DATE NOT NULL,
  `CardsAccepted` VARCHAR(45) NULL,
  PRIMARY KEY (`CardNumber`));
  
CREATE TABLE `cs157a`.`addresses` (
  `ID` INT NOT NULL,
  `Street` VARCHAR(255) NOT NULL,
  `City` VARCHAR(255) NOT NULL,
  `State` VARCHAR(255) NOT NULL,
  `Zip` INT NOT NULL,
  PRIMARY KEY (`ID`));
  
CREATE TABLE `cs157a`.`suppliers` (
  `SupplierID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,  
  PRIMARY KEY (`SupplierID`));

CREATE TABLE `cs157a`.`supply` (
  `ItemID` INT NOT NULL,
  `Supplier` INT NOT NULL,
  `DeliveryDelays` DATE NOT NULL,
  PRIMARY KEY (`Item`));
  
CREATE TABLE `cs157a`.`carts` (
  `CartID` INT NOT NULL,
  `Items` VARCHAR(255) NOT NULL,
  `Quantity` INT NOT NULL,
  `Total price` INT NOT NULL,
  PRIMARY KEY (`CartID`));

CREATE TABLE `cs157a`.`HaveU` (
  `UserID` VARCHAR(255) NOT NULL,
  `AddressesID` INT NOT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE INDEX `addressesID_UNIQUE` (`addressesID` ASC) VISIBLE);

CREATE TABLE `cs157a`.`HavePU` (
  `PayingUsersCardNumber` INT NOT NULL,
  `AddressesID` INT NOT NULL,
  PRIMARY KEY (`PayingUsersCardNumber`),
  UNIQUE INDEX `AddressesID_UNIQUE` (`AddressesID` ASC) VISIBLE);

CREATE TABLE `cs157a`.`HaveS` (
  `SupplierID` INT NOT NULL,
  `AddressesID` INT NOT NULL,
  PRIMARY KEY (`SupplierID`),
  UNIQUE INDEX `AddressesID_UNIQUE` (`AddressesID` ASC) VISIBLE);

CREATE TABLE `cs157a`.`BuyIn` (
  `itermID` INT NOT NULL,
  `cartID` INT NOT NULL,
  PRIMARY KEY (`itermID`),
  UNIQUE INDEX `cartID_UNIQUE` (`cartID` ASC) VISIBLE);

CREATE TABLE `cs157a`.`Buy` (
  `cartID` INT NOT NULL,
  `PayingUsersCardNumber` INT NOT NULL,
  PRIMARY KEY (`cartID`),
  UNIQUE INDEX `PayingUsersCardNumber_UNIQUE` (`PayingUsersCardNumber` ASC) VISIBLE);

CREATE TABLE `cs157a`.`Search` (
  `userID` VARCHAR(255) NOT NULL,
  `itermID` INT NOT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE INDEX `itermID_UNIQUE` (`itermID` ASC) VISIBLE);
  

  /*insert data to table*/
insert into users values 
('lucky001', 'qwert1234', 'Sophia', 'Smith', 1234567890),
('lucky002', 'yuiop1234', 'Jacob', 'Johnson', 1234567891), 
('lucky003', 'asdfg5678', 'Emma', 'Williams', 1234567892), 
('lucky004', 'hjklm5678', 'Mia', 'Jones', 1234567893), 
('lucky005', 'qwert1234', 'Addison', 'Brown', 1234567894), 
('lucky006', 'yuiop1234', 'Lily', 'Davis', 1234567895), 
('lucky007', 'asdfg5678', 'Grace', 'Miller', 1234567896), 
('lucky008', 'yuiop1234', 'Avery', 'Wilson', 1234567897), 
('lucky009', 'asdfg5678', 'Sofia', 'Thomas', 1234567898), 
('lucky010', 'yuiop1234', 'Aubrey', 'White', 1234567899), 
('lucky011', 'asdfg5678', 'Lillian', 'Harris', 1234567880), 
('lucky012', 'hjklm5678', 'Zoey', 'Martin', 1234567881), 
('lucky013', 'hjklm5678', 'Leah', 'Baker', 1234567882), 
('lucky014', 'yuiop1234', 'Anna', 'Adams', 1234567883), 
('lucky015', 'hjklm5678', 'Ashley', 'Cooper', 1234567884);
  
insert into suppliers values 
(11111, 'Tincidunt Limited'), (11112, 'Nullam Vitae Diam Institute'), 
(11113, 'Natoque Limited'), (11114, 'Nam LLP'), 
(11115, 'Lorem Idsum Associates'), (11116, 'A Tortor Nunc Company'), 
(11117, 'Accumsan Laoreet LLP'), (11118, 'Non Foundation'), 
(11119, 'Molex Inc.'), (11120, 'NEC Corporation'), 
(11121, 'Prent Corporation'), (11122, 'NVIDIA Coporation'), 
(11123, 'Multek Corporation'), (11124, 'Nan Ya Printed Circuit Board Corporation'), 
(11125, 'Nippon Mektron, Ltd.');

insert into supply values 
(1111, 11111, '2019-11-20'), (1112, 11112, '2019-11-20'), (1113, 11113, '2019-11-20'), (1114, 11114, '2019-11-20'), (1115, 11115, '2019-11-20'), 
(1116, 11116, '2019-11-20'), (1117, 11117, '2019-11-20'), (1118, 11118, '2019-11-20'), (1119, 11119, '2019-11-20'), (1120, 11120, '2019-11-20'), 
(1121, 11121, '2019-11-20'), (1122, 11122, '2019-11-20'), (1123, 11123, '2019-11-20'), (1124, 11124, '2019-11-20'), (1125, 11125, '2019-11-20');

insert into payingusers values 
(1234, 'Sophia Smith', '2020-10-12', 'VISA'), (3123, 'Jacob Johnson', '2020-10-12', 'VISA'), 
(1111, 'Emma Williams', '2020-10-12', 'VISA'), (2222, 'Mia Jones', '2020-10-12', 'VISA'), 
(3333, 'Addison Brown', '2020-10-12', 'VISA'), (4567, 'Lily Davis', '2020-10-12', 'VISA'), 
(2345, 'Grace Miller', '2020-10-12', 'VISA'), (1345, 'Avery Wilson', '2020-10-12', 'VISA'), 
(7777, 'Sofia Thomas', '2020-10-12', 'VISA'), (4444, 'Aubrey White', '2020-10-12', 'VISA'),
(7890, 'Lillian Harris', '2020-10-12', 'VISA'), (1789, 'Zoey Martin', '2020-10-12', 'VISA'), 
(1567, 'Leah Baker', '2020-10-12', 'VISA'), (6666, 'Anna Adams', '2020-10-12', 'VISA'), 
(5555, 'Ashley Cooper', '2020-10-12', 'VISA');

insert into cs157a.items values 
(1111, 'Cut and Run', 
'Twin sisters separated by the past are reunited by unspeakable 
crimes in New York Times bestselling author Mary Burton’s throat-clutching
 novel of suspense…', NULL, 'BOOK', 100, 10.99, NULL),
(1112, 'My big Fat Fake Wedding',
'Now a Washington Post and Amazon Charts Bestseller.
#1 in the Spartan Store.
He needs a wife.
I need a husband.', NULL, 'BOOK', 199, 2.99, NULL),
(1113, 'Winter Cottage', 'An Amazon Charts bestseller.
A gripping novel about family secrets…and coming home for the first time.',
 NULL, 'BOOK', 100, 1.99, NULL),
(1114, 'Room to Breathe', 
'A funny, emotional novel full of southern charm about a mother and 
daughter ready to start over. Liz Talley delivers. Her dialogue is crisp 
and smart, her characters are vivid and real, her stories are unputdownable. 
—Robyn Carr, New York Times bestselling author', NULL, 'BOOK', 100, 4.99, NULL),
(1115, 'The Vine Witch', 
'A young witch emerges from a curse to find her world upended in this 
gripping fantasy of betrayal, vengeance, and self-discovery set in 
turn-of-the-century France.', NULL, 'BOOK', 100, 6.99, NULL),
(1116, 'Under Lying', 
'In this gripping novel of suspense, the disappearance of a couple''s 
baby daughter leaves everyone a suspect.', NULL, 'BOOK', 100, 7.99, NULL),
(1117, 'Pour Judgment', 
'A week of tits, booze, and fun in the sun? Where do I sign up?', NULL, 'BOOK', 100, 10.99, NULL),
(1118, 'Hello, Darkness', 
'From the #1 New York Times bestselling author of Seeing Red comes Hello, 
Darkness, a brilliant, fast-paced tale about a woman haunted by her past 
and caught in a nightmare that threatens to destroy her future.', NULL, 'BOOK', 100, 3.99, NULL),
(1119, 'The Dutch House: A Novel', 'Audiobook performed by Tom Hanks.
From the New York Times best-selling author of Commonwealth and State of 
Wonder comes Ann Patchett''s most powerful novel to date: a richly moving 
story that explores the indelible bond between two siblings, 
the house of their childhood, and a past that will not let them go. 
The Dutch House is the story of a paradise lost, a tour de force that 
digs deeply into questions of inheritance, love, and forgiveness, 
of how we want to see ourselves, and of who we really are.', NULL, 'BOOK', 100, 5.99, NULL),
(1120, 'Lisianthus Women Belt Buckle Fedora Hat', 'Imported
Material: 65% cotton, 35% polyester
Adjustable strap inside; Hat Circumference: 56-58cm/22-22.8"; Brim Width: 6cm/2.36"
Breathable, lightweight and comfortable for all-day wear
Classic design with belt will make you so fashion, elegant and charming
Perfect for lounging at the beach, clubbing, or simply casual everyday wear; 
Makes a great gift for that fashionable on-trend friend of yours', NULL, 'CLOTHING', 100, 16.45, NULL),
(1121, 'Tommy Hilfiger Mens Ardin Dad Hat', '100% Cotton
Imported
Adjustable closure
Hand Wash
Tommy Hilfiger hat featuring our iconic flag logo
Chain stitch embroidered logo flag
Adjustable metal buckle closure
Six-panel construction with ventilating grommets
Comfort and style make this Tommy Hilfiger hat perfect for every day wear. 
This tommy cap is an essential that''s hard to beat', NULL, 'CLOTHING', 100, 19.99, NULL),
(1122, 'Kangol Unisex Tropic 504 Ventair', '100% Polyester
Made in the USA and Imported
No Closure closure
Hand Wash
Mixed-knit flat cap featuring contrast logo embroidery at back', NULL, 'CLOTHING', 100, 33.15, NULL),
(1123, 'Carhartt Womens Odessa Cap', '100% Cotton
Imported
Hook and Loop closure
Hand Wash
100 percent cotton washed canvas
Carhartt force sweatband fights odors and features fast dry technology for quick wicking
Light-structured, medium-profile cap with pre-curved visor
Adjustable fit with hook-and-loop closure
Leatherette Carhartt label sewn on front', NULL, 'CLOTHING', 100, 14.99, NULL),
(1124, 'Funky Junque Solid Ribbed Beanie Slouchy Soft Stretch Cable Knit Warm Skull Cap', 
'UNISEX: Great for both women and men. The classic knit beanie cap is extremely cool
PERFECT FIT: One size fits most, combines plenty of stretch and a snug fit. This hat measures 8” long by 9” wide lying flat
WHEN TO WEAR: Can be worn indoors or out. This beanie will keep your head and ears warm, even if it’s brutal outside.
GREAT QUALITY: This beanie is very thick and 100% soft acrylic. It’s machine washable and should be hung to dry
FUNKY JUNQUE: We carry many great items on Amazon like winter beanies, gloves, sun hats, baseball caps, scarves and more!', NULL, 'CLOTHING', 100, 10.99, NULL),
(1125, 'Tommy Hilfiger Mens Dad Hat Avery', 
'100% Cotton
Imported
Adjustable closure
Hand Wash
0.7" high
14" wide
Tommy Hilfiger hat featuring our iconic flag logo
Logo flag embroidery
Adjustable strap closure
Six-panel construction with ventilating grommets
Comfort and style make this Tommy Hilfiger cap perfect for every day wear. 
This tommy hat is an essential that is hard to beat', NULL, 'CLOTHING', 100, 19.99, NULL);

insert into addresses values 
(2150, 'Monterey Hwy', 'San Jose', 'CA', 95112), 
(989, 'Story Rd', 'San Jose', 'CA', 95122), 
(979, 'Story Rd', 'San Jose', 'CA', 95122), 
(969, 'Story Rd', 'San Jose', 'CA', 95122), 
(959, 'Story Rd', 'San Jose', 'CA', 95122), 
(949, 'Story Rd', 'San Jose', 'CA', 95122), 
(939, 'Story Rd', 'San Jose', 'CA', 95122), 
(929, 'Story Rd', 'San Jose', 'CA', 95122), 
(2191, 'Monterey Hwy', 'San Jose', 'CA', 95125), 
(2131, 'Monterey Hwy', 'San Jose', 'CA', 95112), 
(2121, 'Monterey Hwy', 'San Jose', 'CA', 95112), 
(2011, 'Monterey Hwy', 'San Jose', 'CA', 95112),
(370, 'Umbarger Rd', 'San Jose', 'CA', 95111), 
(354, 'Umbarger Rd', 'San Jose', 'CA', 95111), 
(230, 'Umbarger Rd', 'San Jose', 'CA', 95111);

insert into carts values 
(1, 'Cut and Run', 1, 10.99),
(2, 'My big Fat Fake Wedding', 1, 2.99),
(3, 'Winter Cottage', 1, 1.99),
(4, 'Room to Breathe', 1, 4.99),
(5, 'The Vine Witch', 1, 6.99),
(6, 'Under Lying', 10, 79.9),
(7, 'Pour Judgment', 10, 109.9),
(8, 'Hello, Darkness', 10, 39.9),
(9, 'The Dutch House: A Novel', 100, 599),
(10, 'Lisianthus Women Belt Buckle Fedora Hat', 10, 164.5),
(11, 'Tommy Hilfiger Mens Ardin Dad Hat', 1, 19.99),
(12, 'Kangol Unisex Tropic 504 Ventair', 1, 33.15),
(13, 'Carhartt Womens Odessa Cap', 1, 14.99),
(14, 'TGD Hat Unisex Beanie Warmer Wind Guard Cap', 1, 10.99),
(15, 'Tommy Hilfiger Mens Dad Hat Avery', 1, 19.99);

insert into HaveU values 
('lucky001', 2150),
('lucky002', 989),
('lucky003', 979),
('lucky004', 969),
('lucky005', 959),
('lucky006', 949),
('lucky007', 939),
('lucky008', 929),
('lucky009', 2191),
('lucky010', 2131),
('lucky011', 2121),
('lucky012', 370),
('lucky013', 354),
('lucky014', 230),
('lucky015', 2151);

insert into HavePU values 
(1234, 2150), (3123,989), (1111, 979), (2222, 969), 
(3333, 959), (4567, 949), 
(2345, 2151), (1345, 939), 
(7777, 929), (4444, 919),
(7890, 899), (1789, 370), 
(1567, 355), (6666, 354), 
(5555, 371);

insert into HaveS values (11111, 2150), (11112,989), (11113, 979), (11114, 969), 
(11120, 959), (11115, 949), 
(11116, 2151), (11117, 899), 
(11118, 939), (11121, 929),
(11119, 919), (11122, 370), 
(11123, 355), (11124, 354), 
(11125, 371);

insert into BuyIn values (1111, 1),(1112, 2),(1113, 3),(1114, 4),(1115, 5),
(1116, 6),(1117, 7),(1118, 8),(1119, 9),(1120, 10),(1121, 11),(1122, 12),
(1123, 13),(1124, 14),(1125, 15);

insert into Buy values (1, 1234), (2, 3123), (3, 1111), (4, 2222), 
(5, 3333), (6, 4567), 
(7, 2345), (8, 1345), 
(9, 7777), (10, 4444),
(11, 7890), (12, 1789), 
(13, 1567), (14, 6666), 
(15, 5555);

insert into Search values 
('lucky001', 1111),
('lucky002', 1112), 
('lucky003', 1113), 
('lucky004', 1114), 
('lucky005', 1115), 
('lucky006', 1116), 
('lucky007', 1117), 
('lucky008', 1118), 
('lucky009', 1119), 
('lucky010', 1120), 
('lucky011', 1121), 
('lucky012', 1122), 
('lucky013', 1123), 
('lucky014', 1124), 
('lucky015', 1125);
