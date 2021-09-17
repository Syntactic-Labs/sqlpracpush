declare @oh varchar(2) = 'oh'
declare @in varchar(2) = 'in'
declare @ky varchar(2) = 'ky'
declare @midwest varchar(6)
set @midwest = concat(@oh, @in, @ky)

select *
	from student
		where StateCode = @midwest;