/*select * from Students
select * from rating				(Name of data, type of data, and not null/null) *optional default
select * from topics*/
insert Rating
	(Stars,StudentId,TopicId)
	values (5,(select Id from Students where Name = 'Matt'),
			  (select Id from Topics where Description like '%Git%')
);