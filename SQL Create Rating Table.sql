create table Rating (
	Id int not null primary key identity(1,1),
	Stars int not null check (Stars >= 1 and Stars <= 5),
	Comment varchar(300) null,
	StudentId int not null		/*foreign key must be same data type as primary key*/
		foreign key references Students(Id),
	TopicId int not null 
		foreign key references Topics(Id),

);