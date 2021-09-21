declare @uppergpa decimal(5,1) = 3.5;
declare @lowergpa decimal(5,1) = 2.3;

select *
	from Student
		where GPA >= @uppergpa or GPA <= @lowergpa
			order by GPA asc;

select *
	from Student
		where GPA <= @lowergpa
			order by GPA asc;