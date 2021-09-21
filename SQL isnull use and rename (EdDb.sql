select s.lastname, isnull(m.Description, 'Undeclared') Major
from Student s
	left join Major m
	on m.Id = s.MajorId
	where StateCode = 'MI'
	order by Lastname

