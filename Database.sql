-- ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';

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

DROP SCHEMA IF EXISTS cs157a;
CREATE SCHEMA cs157a;
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
  `Image` VARCHAR(255) NULL,
  `Category` VARCHAR(255) NULL,
  `Stock` INT NOT NULL,
  `Price` DOUBLE NOT NULL,
  PRIMARY KEY (`ItemID`)); 

CREATE TABLE `cs157a`.`payingusers` (
  `CardNumber` INT NOT NULL,
  `CardHolderName` VARCHAR(255) NOT NULL,
  `Expiration` DATE NOT NULL,
  `CardsAccepted` VARCHAR(45) NULL,
  PRIMARY KEY (`CardNumber`));
  
CREATE TABLE `cs157a`.`addresses` (
  `AddressID` INT NOT NULL AUTO_INCREMENT,
  `Street` VARCHAR(255) NOT NULL,
  `City` VARCHAR(255) NOT NULL,
  `State` VARCHAR(2) NOT NULL,
  `Zip` INT NOT NULL,
  PRIMARY KEY (`AddressID`));
  
CREATE TABLE `cs157a`.`suppliers` (
  `SupplierID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,  
  PRIMARY KEY (`SupplierID`));

CREATE TABLE `cs157a`.`supply` (
  `ItemID` INT NOT NULL REFERENCES items(ItemID),
  `SupplierID` INT NOT NULL REFERENCES suppliers(supplierID),
  PRIMARY KEY (`ItemID`, `SupplierID`));
  
CREATE TABLE `cs157a`.`haveu` (
  `UserID` VARCHAR(255) NOT NULL references users(UserID),
  `AddressID` INT NOT NULL references addresses(AddressID),
  PRIMARY KEY (`UserID`, `addressID`));

CREATE TABLE `cs157a`.`havepu` (
  `CardNumber` INT NOT NULL references payingusers(CardNumber),
  `AddressID` INT NOT NULL references addresses(AddressID),
  PRIMARY KEY (`CardNumber`, `AddressID`));

CREATE TABLE `cs157a`.`haveS` (
  `SupplierID` INT NOT NULL REFERENCES suppliers(supplierID),
  `AddressID` INT NOT NULL references addresses(AddressID),
  PRIMARY KEY (`SupplierID`, `AddressID`));

CREATE TABLE `cs157a`.`carts` (
  `UserID` VARCHAR(255) NOT NULL references users(UserID),
  `ItemID` INT NOT NULL REFERENCES items(ItemID),
  `Quantity` INT NOT NULL,
  `TotalPrice` DOUBLE NOT NULL,
  PRIMARY KEY (`UserID`, `ItemID`));
  
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
('lucky015', 'hjklm5678', 'Ashley', 'Cooper', 1234567884),
('tien', 'tien', 'Tien', 'Ly', 4086678102);
  
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
(1111, 11111), (1112, 11112), (1113, 11113), (1114, 11114), (1115, 11115), 
(1116, 11116), (1117, 11117), (1118, 11118), (1119, 11119), (1120, 11120), 
(1121, 11121), (1122, 11122), (1123, 11123), (1124, 11124), (1125, 11125);

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
 novel of suspense…', '1.png', 'BOOK', 100, 10.99),
(1112, 'My big Fat Fake Wedding',
'Now a Washington Post and Amazon Charts Bestseller.
#1 in the Spartan Store.
He needs a wife.
I need a husband.', '2.png', 'BOOK', 199, 2.99),
(1113, 'Winter Cottage', 'An Amazon Charts bestseller.
A gripping novel about family secrets…and coming home for the first time.',
 '3.png', 'BOOK', 100, 1.99),
(1114, 'Room to Breathe', 
'A funny, emotional novel full of southern charm about a mother and 
daughter ready to start over. Liz Talley delivers. Her dialogue is crisp 
and smart, her characters are vivid and real, her stories are unputdownable. 
—Robyn Carr, New York Times bestselling author', '4.png', 'BOOK', 100, 4.99),
(1115, 'The Vine Witch', 
'A young witch emerges from a curse to find her world upended in this 
gripping fantasy of betrayal, vengeance, and self-discovery set in 
turn-of-the-century France.', '5.png', 'BOOK', 100, 6.99),
(1116, 'Under Lying', 
'In this gripping novel of suspense, the disappearance of a couple''s 
baby daughter leaves everyone a suspect.', '6.png', 'BOOK', 100, 7.99),
(1117, 'Pour Judgment', 
'A week of tits, booze, and fun in the sun? Where do I sign up?', '7.png', 'BOOK', 100, 10.99),
(1118, 'Hello, Darkness', 
'From the #1 New York Times bestselling author of Seeing Red comes Hello, 
Darkness, a brilliant, fast-paced tale about a woman haunted by her past 
and caught in a nightmare that threatens to destroy her future.', '8.png', 'BOOK', 100, 3.99),
(1119, 'The Dutch House: A Novel', 'Audiobook performed by Tom Hanks.
From the New York Times best-selling author of Commonwealth and State of 
Wonder comes Ann Patchett''s most powerful novel to date: a richly moving 
story that explores the indelible bond between two siblings, 
the house of their childhood, and a past that will not let them go. 
The Dutch House is the story of a paradise lost, a tour de force that 
digs deeply into questions of inheritance, love, and forgiveness, 
of how we want to see ourselves, and of who we really are.', '9.png', 'BOOK', 100, 5.99),
(1120, 'Lisianthus Women Belt Buckle Fedora Hat', 'Imported
Material: 65% cotton, 35% polyester
Adjustable strap inside; Hat Circumference: 56-58cm/22-22.8"; Brim Width: 6cm/2.36"
Breathable, lightweight and comfortable for all-day wear
Classic design with belt will make you so fashion, elegant and charming
Perfect for lounging at the beach, clubbing, or simply casual everyday wear; 
Makes a great gift for that fashionable on-trend friend of yours', '10.png', 'STATIONERY', 100, 16.45),
(1121, 'Tommy Hilfiger Mens Ardin Dad Hat', '100% Cotton
Imported
Adjustable closure
Hand Wash
Tommy Hilfiger hat featuring our iconic flag logo
Chain stitch embroidered logo flag
Adjustable metal buckle closure
Six-panel construction with ventilating grommets
Comfort and style make this Tommy Hilfiger hat perfect for every day wear. 
This tommy cap is an essential that''s hard to beat', '11.png', 'WOMEN', 100, 19.99),
(1122, 'Kangol Unisex Tropic 504 Ventair', '100% Polyester
Made in the USA and Imported
No Closure closure
Hand Wash
Mixed-knit flat cap featuring contrast logo embroidery at back', '12.png', 'MEN', 100, 33.15),
(1123, 'Carhartt Womens Odessa Cap', '100% Cotton
Imported
Hook and Loop closure
Hand Wash
100 percent cotton washed canvas
Carhartt force sweatband fights odors and features fast dry technology for quick wicking
Light-structured, medium-profile cap with pre-curved visor
Adjustable fit with hook-and-loop closure
Leatherette Carhartt label sewn on front', '13.png', 'CLOTHING', 100, 14.99),
(1124, 'Funky Junque Solid Ribbed Beanie Slouchy Soft Stretch Cable Knit Warm Skull Cap', 
'UNISEX: Great for both women and men. The classic knit beanie cap is extremely cool
PERFECT FIT: One size fits most, combines plenty of stretch and a snug fit. This hat measures 8” long by 9” wide lying flat
WHEN TO WEAR: Can be worn indoors or out. This beanie will keep your head and ears warm, even if it’s brutal outside.
GREAT QUALITY: This beanie is very thick and 100% soft acrylic. It’s machine washable and should be hung to dry
FUNKY JUNQUE: We carry many great items on Amazon like winter beanies, gloves, sun hats, baseball caps, scarves and more!', '14.png', 'WOMEN', 100, 10.99),
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
This tommy hat is an essential that is hard to beat', '15.png', 'MEN', 100, 19.99);

insert into addresses values 
(1, '2150 Monterey Hwy', 'San Jose', 'CA', 95112),
(2, '989 Story Rd', 'San Jose', 'CA', 95122), 
(3, '979 Story Rd', 'San Jose', 'CA', 95122), 
(4, '969 Story Rd', 'San Jose', 'CA', 95122), 
(5, '959 Story Rd', 'San Jose', 'CA', 95122), 
(6, '949 Story Rd', 'San Jose', 'CA', 95122), 
(7, '939 Story Rd', 'San Jose', 'CA', 95122), 
(8, '929 Story Rd', 'San Jose', 'CA', 95122), 
(9, '2191 Monterey Hwy', 'San Jose', 'CA', 95125), 
(10, '2131 Monterey Hwy', 'San Jose', 'CA', 95112), 
(11, '2121 Monterey Hwy', 'San Jose', 'CA', 95112), 
(12, '2011 Monterey Hwy', 'San Jose', 'CA', 95112),
(13, '370 Umbarger Rd', 'San Jose', 'CA', 95111), 
(14, '354 Umbarger Rd', 'San Jose', 'CA', 95111), 
(15, '230 Umbarger Rd', 'San Jose', 'CA', 95111);

insert into carts values 
('lucky001', 1111, 1, 10.99),
('lucky002', 1112, 1, 2.99),
('lucky003', 1113, 1, 1.99),
('lucky004', 1114, 1, 4.99),
('lucky005', 1115, 1, 6.99),
('lucky006', 1116, 10, 79.9),
('lucky007', 1117, 10, 109.9),
('lucky008', 1118, 10, 39.9),
('lucky009', 1119, 100, 599),
('lucky010', 1120, 10, 164.5),
('lucky011', 1121, 1, 19.99),
('lucky012', 1122, 1, 33.15),
('lucky013', 1123, 1, 14.99),
('lucky014', 1124, 1, 10.99),
('lucky015', 1125, 1, 19.99);

insert into haveu values 
('lucky001', 1),
('lucky002', 2),
('lucky003', 3),
('lucky004', 4),
('lucky005', 5),
('lucky006', 6),
('lucky007', 7),
('lucky008', 8),
('lucky009', 9),
('lucky010', 10),
('lucky011', 11),
('lucky012', 12),
('lucky013', 13),
('lucky014', 14),
('lucky015', 15);

insert into havepu values 
(1234, 1), (3123,2), (1111, 3), (2222, 4), 
(3333, 5), (4567, 6), 
(2345, 7), (1345, 8), 
(7777, 9), (4444, 10),
(7890, 11), (1789, 12), 
(1567, 13), (6666, 14), 
(5555, 15);

insert into haves values (11111, 15), (11112,14), (11113, 13), (11114, 12), 
(11120, 11), (11115, 10), 
(11116, 9), (11117, 8), 
(11118, 7), (11121, 6),
(11119, 5), (11122, 4), 
(11123, 3), (11124, 2), 
(11125, 1);
