select *
	from Student
	where GPA < (select avg(GPA)
					from Student)
						order by GPA desc;