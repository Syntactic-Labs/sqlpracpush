select concat(lastname, ' ', firstname) 'name', isnull(description, 'undecided') 'major'
	from student s
	left join major m
		on m.id = s.MajorId
			order by Lastname;
