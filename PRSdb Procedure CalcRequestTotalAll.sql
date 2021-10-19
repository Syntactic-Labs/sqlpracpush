Create or Alter procedure CalculateRequestTotalAll
As
Begin
	Declare @Id varchar(30);
	Declare cur Cursor for
		select Id
		from Requests 
			where Total = 0;
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