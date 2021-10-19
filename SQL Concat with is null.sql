select s.Id, concat(lastname, ' ', firstname) 'Name', isnull(description, 'undecided') 'Major'
	from student s
	left join major m
		on m.id = s.MajorId
			order by Lastname;
