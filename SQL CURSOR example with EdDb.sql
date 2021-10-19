Create or Alter procedure StudentGpaAdjustment
As
Begin
	Declare @firstname varchar(30);
	Declare @lastname varchar(30);
	Declare @gpadelta decimal(5,2);
	Declare cur Cursor for
		select firstname, lastname, gpadelta
		from adjustments 
			where completed = 0;
	Open cur;
				
		Fetch Next from cur into @firstname, @lastname, @gpadelta; --Must be same order as select above!!!
		while @@FETCH_STATUS = 0
	Begin
		Update Student set
			GPA = GPA + @gpadelta
			where firstname = @firstname and Lastname = @lastname;
		
		/*select firstname, lastname, gpa, @gpadelta 'delta',(GPA + @gpadelta) 'new gpa'
			from Student
				where firstname=@firstname and lastname=@lastname;*/

		Fetch Next from cur into @firstname, @lastname, @gpadelta;
	End
	Close cur;
	Deallocate cur;

	Update Adjustments set
		Completed = 1
		where Completed = 0;
End
go
EXEC StudentGpaAdjustment

/*Declare mycur CURSOR for
	select * from Student;
		Open mycur;
			Declare @id int, @name varchar(30)
				FETCH first from mycur into @id, @name;
		Close mycur;
DEALLOCATE mycur;*/