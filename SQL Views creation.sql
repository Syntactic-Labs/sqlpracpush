Create View ClassesforMajorincInstuctor as


select m.Description, m.MinSAT, c.Code, i.Firstname, i.Lastname
from major m
	join MajorClass mc
	on mc.MajorId = m.Id
	join class c
	on c.Id = mc.ClassId
	join Instructor i
	on i.Id = c.InstructorId

select * from ClassesforMajorincInstuctor