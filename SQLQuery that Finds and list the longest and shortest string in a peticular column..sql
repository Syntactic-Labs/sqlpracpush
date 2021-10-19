select top 1 Firstname, len(Firstname) as 'length' from Student
order by len(Firstname),Firstname asc ;
select top 1 firstname, len(firstname) as 'length' from student
order by len(firstname) desc;