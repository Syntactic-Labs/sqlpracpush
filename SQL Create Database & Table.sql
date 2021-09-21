/*new databases are made in master*/
/*creating a table*/

/*CREATE TABLE Students (
	Id int not null primary key identity(1,1), /*(1,1) first one is the starting number. second intervals it goes up by.*/
	Name varchar(50) not null,
	FavNumber int not null,
	FavColor varchar(20) null default 'Grey',
	Milk bit null default 0
);
go
INSERT into Students
	(Name, FavNumber, FavColor, Milk)
	values
	('Matt', 144, 'Green', 1);
go
INSERT into Students
	(Name, FavNumber, FavColor, Milk)
	values
	('Parth', 84, 'Blue', 1);
go
INSERT into Students
	(Name, FavNumber, FavColor, Milk)
	values
	('Caroline', 25, null, 0);


CREATE TABLE Topics (
	Id int not null primary key identity(1,1),
	Description varchar(30) not null,
	Sequence int not null unique,
	TooEasy bit not null default 1,

)
go
insert into Topics
	(Description, Sequence, TooEasy)
	values
	('Git/Github', 1, 1),
	('SQL Server', 2, 1),
	('C#', 3, 1),
	('EntityFrameworkCore', 4, 1),
	('Java', 5, 1),
	('Spring', 6, 1),
	('HTML', 7, 1),
	('CSS', 8, 1),
	('JavaScript', 9, 1),
	('Bootstrap', 10, 1),
	('jQuery', 11, 1),
	('Typescript', 12, 1),
	('Angular', 13, 1)
go

select * from Topics*/
	