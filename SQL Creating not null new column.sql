alter table customers /*creating not null new column*/
	add Note varchar(30) null; --step 1
go
update Customers set
	updated = GETDATE(),
	Note = 'no note';--step 2
go
alter table customers
	alter column Note varchar(30) not null;--step 3