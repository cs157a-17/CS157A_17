ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';

SELECT * FROM users;
SELECT * FROM suppliers;
SELECT * FROM supply;
SELECT * FROM payingusers;
SELECT * FROM items;
SELECT * FROM carts;
SELECT * FROM addresses;
SELECT * FROM HaveU;
SELECT * FROM HavePU;
SELECT * FROM HaveS;
SELECT * FROM BuyIn;
SELECT * FROM Buy;
SELECT * FROM Search;



/*create table*/
CREATE TABLE `cs157a`.`users` (
  `User ID` VARCHAR(255) NOT NULL,
  `Password` VARCHAR(255) NOT NULL,
  `First Name` VARCHAR(255) NOT NULL,
  `Last Name` VARCHAR(255) NOT NULL,
  `Phone Number` INT NOT NULL,
  PRIMARY KEY (`User ID`));
  
CREATE TABLE `cs157a`.`items` (
  `Item ID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Description` VARCHAR(255) NULL,
  `Category` VARCHAR(255) NULL,
  `Stock` INT NOT NULL,
  `Price` DOUBLE NOT NULL,
  `Shipping Days` DATE NULL,
  PRIMARY KEY (`Item ID`)); 

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
  `Supplier ID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,  
  PRIMARY KEY (`Supplier ID`));

CREATE TABLE `cs157a`.`supply` (
  `Item` INT NOT NULL,
  `Supplier` INT NOT NULL,
  `Delivery Delays` DATE NOT NULL,
  PRIMARY KEY (`Item`));
  
CREATE TABLE `cs157a`.`carts` (
  `Cart ID` INT NOT NULL,
  `Items` VARCHAR(255) NOT NULL,
  `Quantity` INT NOT NULL,
  `Total price` INT NOT NULL,
  PRIMARY KEY (`Cart ID`));

CREATE TABLE `cs157a`.`HaveU` (
  `User ID` VARCHAR(255) NOT NULL,
  `AddressesID` INT NOT NULL,
  PRIMARY KEY (`User ID`),
  UNIQUE INDEX `addressesID_UNIQUE` (`addressesID` ASC) VISIBLE);

CREATE TABLE `cs157a`.`HavePU` (
  `PayingUsersCardNumber` INT NOT NULL,
  `AddressesID` INT NOT NULL,
  PRIMARY KEY (`PayingUsersCardNumber`),
  UNIQUE INDEX `AddressesID_UNIQUE` (`AddressesID` ASC) VISIBLE);

CREATE TABLE `cs157a`.`HaveS` (
  `SuppliserID` INT NOT NULL,
  `AddressesID` INT NOT NULL,
  PRIMARY KEY (`SppliserID`),
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
(1, 'a'), (2, 'b'), (3, 'c'), (4, 'd'), (5, 'e'), 
(6, 'f'), (7, 'g'), (8, 'h'), (9, 'j'), (10, 'i'), 
(11, 'k'), (12, 'l'), (13, 'm'), (14, 'n'), (15, 'o');

insert into payingusers values 
(1234, 'Sophia Smith', '2020-10-12', 'VISA'), (3123, 'Jacob Johnson', '2020-10-12', 'VISA'), 
(1111, 'Emma Williams', '2020-10-12', 'VISA'), (2222, 'Mia Jones', '2020-10-12', 'VISA'), 
(3333, 'Addison Brown', '2020-10-12', 'VISA'), (4567, 'Lily Davis', '2020-10-12', 'VISA'), 
(2345, 'Grace Miller', '2020-10-12', 'VISA'), (1345, 'Avery Wilson', '2020-10-12', 'VISA'), 
(7777, 'Sofia Thomas', '2020-10-12', 'VISA'), (4444, 'Aubrey White', '2020-10-12', 'VISA'),
(7890, 'Lillian Harris', '2020-10-12', 'VISA'), (1789, 'Zoey Martin', '2020-10-12', 'VISA'), 
(1567, 'Leah Baker', '2020-10-12', 'VISA'), (6666, 'Anna Adams', '2020-10-12', 'VISA'), 
(5555, 'Ashley Cooper', '2020-10-12', 'VISA');

insert into items values 
(1111, 'Cut and Run', NULL, NULL, 100, 10.99, NULL),
(1112, 'My big Fat Fake Wedding', NULL, NULL, 199, 2.99, NULL),
(1113, 'Winter Cottage', NULL, NULL, 100, 1.99, NULL),
(1114, 'Room to Breathe', NULL, NULL, 100, 4.99, NULL),
(1115, 'The Vine Witch', NULL, NULL, 100, 6.99, NULL),
(1116, 'Under Lying', NULL, NULL, 100, 7.99, NULL),
(1117, 'Pour Judgment', NULL, NULL, 100, 10.99, NULL),
(1118, 'Hello, Darkness', NULL, NULL, 100, 3.99, NULL),
(1119, 'The Dutch House: A Novel', NULL, NULL, 100, 5.99, NULL),
(1120, 'Lisianthus Women Belt Buckle Fedora Hat', NULL, NULL, 100, 16.45, NULL),
(1121, 'Tommy Hilfiger Mens Ardin Dad Hat', NULL, NULL, 100, 19.99, NULL),
(1122, 'Kangol Unisex Tropic 504 Ventair', NULL, NULL, 100, 33.15, NULL),
(1123, 'Carhartt Womens Odessa Cap', NULL, NULL, 100, 14.99, NULL),
(1124, 'TGD Hat Unisex Beanie Warmer Wind Guard Cap', NULL, NULL, 100, 10.99, NULL),
(1125, 'Tommy Hilfiger Mens Dad Hat Avery', NULL, NULL, 100, 19.99, NULL);

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

insert into HavePU values ();

insert into HaveS values ();

insert into BuyIn values ();

insert into Buy values ();

insert into Search values ();