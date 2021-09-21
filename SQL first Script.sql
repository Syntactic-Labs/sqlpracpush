use master;
go
drop database if exists BcDb;
go
create database BcDb;
go
use BcDb;
go
CREATE TABLE Customers (
	Id int not null primary key identity(1,1),
	Active bit not null default 1,
	FirstName varchar(50) not null,
	LastName varchar(30) not null,
	Statecode varchar(2) not null,
	Milk bit not null, 
	Sales decimal(9,2) not null default 0,
	created DateTime not null default GETDATE()
	);
go
insert into Customers
	(Active, FirstName, LastName, Statecode, Milk)
		values
		(1, 'Chad', 'Puck', 'KY', 1),
		(1, 'David', 'Stooley', 'OH', 0),
		(1, 'Ashley', 'Clobs', 'AL', 1),
		(1, 'Stephon', 'Teeneytoes', 'CA', 0),
		(1, 'Devonyah', 'Davids', 'OH', 1),
		(1, 'Ottus', 'Flapjacks', 'KY', 1)

go
select * from Customers