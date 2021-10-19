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
			('FredFredders', 'fred', 'Fred', 'Fredders', 123-123-1234, 'FredFredders@gmail.com', 1, 1), /*admin & review*/
			('ScottScotters', 'scott', 'Scott', 'Scotters', 123-123-1234, 'ScottScotters@gmail.com', 1, 0), /*admin*/
			('ToddTodders', 'todd', 'Todd', 'Todders', 123-123-1234, 'ToddTodders@gmail.com', 0, 0) /*review*/
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
			('Dell', 'Dell', '1 Dell Way', 'Round Rock', 'TX', 78682, 877-717-3355,'Dell@gmail.com'),
			('Uline', 'Uline', '12575 Uline Drive', 'Pleasant Prairie', 'WI', 53158, 800-295-5510,'Uline@gmail.com'),
			('Micro', 'Micro Center', '11755 Mosteller Rd', 'Sharonville', 'OH', 45241, 513-782-8500, 'MicroCenter@gmail.com'),
			('Cost', 'Costco', '9691 Waterstone Blvd', 'Cincinnati', 'OH', 45249, 513-774-0024, 'Costco@gmail.com')
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
			('DL14LAT', 'Laptop 14', 650.00, (SELECT Id From Vendors where Code = 'Dell')),
			('DL15LAT', 'Laptop 15', 750.00, (SELECT Id From Vendors where Code = 'Dell')),
			('DM24OLED', 'Monitor 24', 320.00, (SELECT Id From Vendors where Code = 'Dell')),
			('UP12', 'Pencils', 3.99, (SELECT Id From Vendors where Code = 'Uline')),
			('UDO', 'Desk Organizer', 12.50, (SELECT Id From Vendors where Code = 'Uline')),
			('UNP', 'Note Pad', 0.99, (SELECT Id From Vendors where Code = 'Uline')),
			('UBP12', 'Black Pens', 4.99, (SELECT Id From Vendors where Code = 'Uline')),
			('MMP', 'Mouse Pad', 12.99, (SELECT Id From Vendors where Code = 'Micro')),
			('MMO', 'Mouse', 12.99, (SELECT Id From Vendors where Code = 'Micro')),
			('MUSB32', '32 GB USB', 9.99, (SELECT Id From Vendors where Code = 'Micro')),
			('MUSB64', '64 GB USB', 27.99, (SELECT Id From Vendors where Code = 'Micro')),
			('CSC', 'Chips', 0.99, (SELECT Id From Vendors where Code = 'Cost')),
			('CSA', 'Apple', 0.50, (SELECT Id From Vendors where Code = 'Cost')),
			('CSB', 'Beef Jerky', 12.99, (SELECT Id From Vendors where Code = 'Cost'))
			
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
			('Desk Supplies','Productivity', 856.99, (select Id from Users where Username = 'FredFredders')),
			('Snacks', 'Hungry', 6.62, (select Id from Users where Username = 'ScottScotters')),
			('Storage', 'Current Project', 22.34, (select Id from Users where Username = 'ToddTodders')),
			('Pens and Pencils', 'Need to take notes', 22.34, (select Id from Users where Username = 'ScottScotters')),
			('Some Pens and Pencils', 'For my hellokitty note pad', 22.34, (select Id from Users where Username = 'FredFredders'))
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
			(3,(select Id from Requests where Description = 'Desk Supplies'),(select Id from Products where PartNbr = 'DL15LAT')),
			(10,(select Id from Requests where Description = 'Snacks'),(select Id from Products where PartNbr = 'CSC')),
			(1,(select Id from Requests where Description = 'Storage'),(select Id from Products where PartNbr = 'MUSB64')),
			(2,(select Id from Requests where Description = 'Pens and Pencils'),(select Id from Products where PartNbr = 'UP12')),
			(2,(select Id from Requests where Description = 'Pens and Pencils'),(select Id from Products where PartNbr = 'UBP12')),
			(2,(select Id from Requests where Description = 'Some Pens and Pencils'),(select Id from Products where PartNbr = 'UP12')),
			(1,(select Id from Requests where Description = 'Some Pens and Pencils'),(select Id from Products where PartNbr = 'UBP12')),
			(1,(select Id from Requests where Description = 'Desk Supplies'),(select Id from Products where PartNbr = 'DM24OLED')),
			(1,(select Id from Requests where Description = 'Desk Supplies'),(select Id from Products where PartNbr = 'MMP')),
			(1,(select Id from Requests where Description = 'Desk Supplies'),(select Id from Products where PartNbr = 'MMO'))
; 
go
