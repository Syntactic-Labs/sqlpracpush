declare @oh varchar(2) = 'oh'
declare @in varchar(2) = 'in'
declare @ky varchar(2) = 'ky'

declare @midwest varchar(max) = @ky + @oh + @in


select *
	from student
		where StateCode = @midwest;
