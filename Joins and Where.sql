select Description, c.Code
	from major m
	join MajorClass mc
		on m.Id = mc.MajorId
	join class c
		on c.Id = mc.ClassId
			where m.code = 'genb';
