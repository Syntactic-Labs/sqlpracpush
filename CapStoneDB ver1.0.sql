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
	Phone varchar(12) not null,
	Email varchar(255) not null,
);
go
Insert into Vendors
	(Code, Name, Address, City, State, Zip, Phone, Email)
		Values
			('AMZ', 'Amazon', '469 Jeff st.', 'Manhatten', 'NY', 10001, 9171111111),
			('Micro', 'Microsoft', '4445 Lake Forest Dr # 100', 'Blueash', 'OH', 45242, 5130000000),
			('IBM', 'International Business Machines', '1 Orchard Rd', 'Armonk', 'NY', 10504, 9172222222)
;
go
CREATE TABLE Products(
	Id int not null primary key identity(1,1),
	PartNbr varchar(30) not null unique,
	Name varchar(30) not null,
	Price decimal(9,2) not null default 0,
	Unit varchar(30) not null default 'Each',
	PhotoPath varchar(255) null,
	VendorsId int not null
					foreign key references Vendors(Id)
	
);
go
INSERT into Products
	(PartNbr,Name,Price)
		VALUES
			('n5j4k32', 'Iphone', 856.99),
			('9f842', 'Crackers', 12.87),
			('9sfwa', 'Peanutbutter', 6.62),
			('aw394', 'DoggyBall', 22.34),
			('w98rau', 'Waffles', 9.99),
			('sife75', 'Speedo', 2.99),
			('aw894', 'HondaCivic', 27895.67)
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
	UserId int not null 
				foreign key references Users(Id)
);
go
CREATE TABLE Requestlines(
	Id int primary key identity(1,1),
	Quantity int not null default 1
		check (Quantity > 0),
	RequestId int not null foreign key references requests(Id),
	ProductId int not null foreign key references products(Id)
);