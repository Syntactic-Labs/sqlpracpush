--Createing a procedure for PRSdb

CREATE or ALTER Procedure CalculateRequestTotal
	@RequestId int = null
AS
BEGIN                  --Data Check/Filter
	--Check for missing RequestId
	If @RequestId is null
	BEGIN
		Print 'RequestId is required';
		RETURN -1;
	END
	--Check the RequestId exists
	If NOT Exists (select 1 from Requests where Id = @RequestId)
	BEGIN
		Print 'Request not found';
		Return -2;
	END
	--outline for equation
	DECLARE @Total decimal(9,2);
	--puts total calculated by the query into variable called @total
	Select @Total = sum(rl.quantity * p.price)
		from Requests r
		join Requestlines rl
			on rl.RequestId = r.Id
		join Products p
			on p.Id = rl.ProductId
		where r.Id = @RequestId;
END
GO
Declare @rc int;
EXEC @rc CalculateRequestTotal @RequestId = 1;
Print @rc
GO