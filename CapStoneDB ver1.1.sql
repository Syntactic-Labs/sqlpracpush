use master;
go
drop database if exists PRSdb;
go
create database PRSdb;
go
use PRSdb;
go
CREATE TABLE Users(
	Id int not null primary key identity(1,1),
	Username varchar(100) not null unique,
	Password varchar(30) not null,
	Firstname varchar(30) not null,
	Lastname varchar(30) not null,
	Phone varchar(12) null,
	Email varchar(255) null,
	IsReviewer bit not null default 0,
	IsAdmin bit not null default 0,
); 
go
INSERT into Users
	(Username, Password, Firstname, Lastname, Phone, Email, IsReviewer, IsAdmin)
		VALUES
			('SneakyPete123', 'prsdb', 'Todd', 'Fergles', 5131111111, 'SneakyPete123@gmail.com', 1, 1), /*admin & review*/
			('DragonSlayer123', 'prsdb', 'Nathan', 'Dougly', 5132222222, 'DragonSlayer123@gmail.com', 0, 1), /*admin*/
			('LoveDisney123', 'prsdb', 'Garret', 'Funk', 5133333333, 'Lovedisney123@gmail.com', 1, 0), /*review*/
			('RolexStyle123', 'prsdb', 'Ashley', 'Manker', 5134444444, 'RolexStyle123@gmail.com', 0, 0),
			('BobsEmail123', 'prsdb', 'Bob', 'Bobber', 5135555555, 'BobsEmail123@gmail.com', 0, 0)
; 
go
CREATE TABLE Vendors(
	Id int not null primary key identity(1,1),
	Code varchar(30) not null unique,
	Name varchar(30) not null,
	Address varchar(30) not null,
	City varchar(30) not null,
	State varchar(2) not null,
	Zip varchar(5) not null,
	Phone varchar(12) null,
	Email varchar(255) null,
); 
go
Insert into Vendors
	(Code, Name, Address, City, State, Zip, Phone, Email)
		Values
			('AMZ', 'Amazon', '469 Jeff st.', 'Manhatten', 'NY', 10001, 9171111111,'Amazon@gmail.com'),
			('Micro', 'Microsoft', '4445 Lake Forest Dr # 100', 'Blueash', 'OH', 45242, 5130000000,'Microsoft@gmail.com'),
			('IBM', 'InternationalBusinessMachines', '1 Orchard Rd', 'Armonk', 'NY', 10504, 9172222222,'IBM@gmail.com')
; 
go
CREATE TABLE Products(
	Id int not null primary key identity(1,1),
	PartNbr varchar(30) not null unique,
	Description varchar(30) not null,
	Price decimal(9,2) not null default 0,
	Unit varchar(30) not null default 'Each',
	PhotoPath varchar(255) null,
	VendorsId int not null foreign key references Vendors(Id)	
); 
go
INSERT into Products
	(PartNbr,Description,Price, VendorsId)
		VALUES
			('n5j4k32', 'Iphone', 856.99, (SELECT Id From Vendors where Code = 'Micro')),
			('9f842', 'Crackers', 12.87, (SELECT Id From Vendors where Code = 'AMZ')),
			('9sfwa', 'Peanutbutter', 6.62, (SELECT Id From Vendors where Code = 'AMZ')),
			('aw394', 'DoggyBall', 22.34, (SELECT Id From Vendors where Code = 'AMZ')),
			('w98rau', 'Waffles', 9.99, (SELECT Id From Vendors where Code = 'AMZ')),
			('sife75', 'Speedo', 2.99, (SELECT Id From Vendors where Code = 'AMZ')),
			('aw894', 'HondaCivic', 27895.67, (SELECT Id From Vendors where Code = 'IBM'))
; 
go
CREATE TABLE Requests(
	Id int primary key identity(1,1),
	Description varchar(80) not null,
	Justification varchar(80) not null,
	RejectionReason varchar(80) null,
	DeliveryMode varchar(20) not null default 'Pickup',
	Status varchar(10) not null default 'NEW',
	Total decimal(11,2) not null default 0,
	UserId int not null foreign key references Users(Id)
); 
go
Insert into Requests
	(Description, Justification, Total, UserId)
		Values
			('Iphone','Always wanted one', 856.99, (select Id from Users where Username = 'SneakyPete123')),
			('Peanutbutter', 'Hungry!!!', 6.62, (select Id from Users where Username = 'DragonSlayer123')),
			('DoggyBall', 'Bored', 22.34, (select Id from Users where Username = 'LoveDisney123'))
; 
go
CREATE TABLE Requestlines(
	Id int primary key identity(1,1),
	Quantity int not null default 1
		check (Quantity > 0),
	RequestId int not null foreign key references requests(Id),
	ProductId int not null foreign key references products(Id)
); 
go
Insert into Requestlines
	(Quantity, RequestId, ProductId)
		Values
			(1,(select Id from Requests where Description = 'Iphone'),(select Id from Products where PartNbr = 'n5j4k32')),
			(2,(select Id from Requests where Description = 'Peanutbutter'),(select Id from Products where PartNbr = '9sfwa')),
			(1,(select Id from Requests where Description = 'DoggyBall'),(select Id from Products where PartNbr = 'aw394'))
; 
go
