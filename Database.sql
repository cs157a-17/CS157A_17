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
  `userID` INT NOT NULL,
  `addressesID` INT NOT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE INDEX `addressesID_UNIQUE` (`addressesID` ASC) VISIBLE);

CREATE TABLE `cs157a`.`HavePU` (
  `PayingUsersCardNumber` INT NOT NULL,
  `AddressesID` INT NOT NULL,
  PRIMARY KEY (`PayingUsersCardNumber`),
  UNIQUE INDEX `AddressesID_UNIQUE` (`AddressesID` ASC) VISIBLE);

CREATE TABLE `cs157a`.`HaveS` (
  `SppliserID` INT NOT NULL,
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
  `User ID` VARCHAR(255) NOT NULL,
  `Item ID` INT NOT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE INDEX `itermID_UNIQUE` (`itermID` ASC) VISIBLE);
  
  /*insert data to table*/
insert into users values ('a', 'pw', 'a', 'a', 1234567890), ('b', 'pw', 'b', 'b', 1234567890), ('c', 'pw', 'c', 'c', 1234567890), ('d', 'pw', 'd', 'd', 1234567890), ('e', 'pw', 'e', 'e', 1234567890), 
('f', 'pw', 'f', 'f', 1234567890), ('g', 'pw', 'g', 'g', 1234567890), ('h', 'pw', 'h', 'h', 1234567890), ('j', 'pw', 'j', 'j', 1234567890), ('i', 'pw', 'i', 'i', 1234567890), 
('k', 'pw', 'k', 'k', 1234567890), ('l', 'pw', 'l', 'l', 1234567890), ('m', 'pw', 'm', 'm', 1234567890), ('n', 'pw', 'n', 'n', 1234567890), ('o', 'pw', 'o', 'o', 1234567890);
  
insert into suppliers values (1, 'a'), (2, 'b'), (3, 'c'), (4, 'd'), (5, 'e'), (6, 'f'), (7, 'g'), (8, 'h'), (9, 'j'), (10, 'i'), (11, 'k'), (12, 'l'), (13, 'm'), (14, 'n'), (15, 'o');

insert into supply values (1, 'a'), (2, 'b'), (3, 'c'), (4, 'd'), (5, 'e'), (6, 'f'), (7, 'g'), (8, 'h'), (9, 'j'), (10, 'i'), (11, 'k'), (12, 'l'), (13, 'm'), (14, 'n'), (15, 'o');

insert into payingusers values (1234, 'a', '2020-10-12', 'VISA'), (3123, 'a', '2020-10-12', 'VISA'), (1111, 'a', '2020-10-12', 'VISA'), (2222, 'a', '2020-10-12', 'VISA'), (3333, 'a', '2020-10-12', 'VISA'),
(4567, 'a', '2020-10-12', 'VISA'), (2345, 'a', '2020-10-12', 'VISA'), (1345, 'a', '2020-10-12', 'VISA'), (7777, 'a', '2020-10-12', 'VISA'), (4444, 'a', '2020-10-12', 'VISA'),
(7890, 'a', '2020-10-12', 'VISA'), (1789, 'a', '2020-10-12', 'VISA'), (1567, 'a', '2020-10-12', 'VISA'), (6666, 'a', '2020-10-12', 'VISA'), (5555, 'a', '2020-10-12', 'VISA');

insert into itemns values ();

insert into addresses values ();

insert into HaveU values ();

insert into HavePU values ();

insert into HaveS values ();

insert into BuyIn values ();

insert into Buy values ();

insert into Search values ();