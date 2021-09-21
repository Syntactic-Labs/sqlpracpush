--createing a procedure!

create or alter procedure CountToTwenty
as
Begin
	declare @index int = 1;
	declare @stop int = 20;

	while @index <= @stop
	Begin
		print '@index is ' + cast(@index as varchar(5));
		if @index = 10
		begin
			print 'Half way there!!!'
		
		end
		set @index = @index + 1;
	End
End;
go
exec CountToTwenty