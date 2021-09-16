Select *
	from student s
	join major m
		on m.id = s.majorid
	join majorclass mc
		on mc.majorid = m.id
	join class c
		on c.id = mc.classid;