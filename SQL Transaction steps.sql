select * from Student s
	join Major m
	on S.MajorId = m.Id;

Begin Transaction;

Insert Student (Firstname,Lastname,StateCode,SAT,GPA,MajorId)
	Values('Donald','Duck','NY', 1208, 2.9, 1),
		  ('Alfie', 'Grimlock', 'KY', 1189, 3.4, 4);

If @@ERROR != 0
		Rollback Transaction
	else
		Commit Transaction;