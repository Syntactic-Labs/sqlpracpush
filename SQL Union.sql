select *,'A' 'ABC'
	from student
	where sat > 1200
union
select *,'B' 'ABC'
	from student
	where sat <= 1200 and sat >= 1000
union
select *,'C' 'ABC'
	from student
	where sat < 1000
		order by ABC