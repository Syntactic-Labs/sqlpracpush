--Procedure for user adding Request with Parachecks

Create or Alter Procedure AddRequestLine
	@RequestId int = null,
	@ProductName varchar(30) = null,
	@Quantity int = null
AS Begin
	--check for all data entered/Parameter check
	IF @RequestId is null or @ProductName is null or @Quantity is null
	Begin
		Print 'All parameters must be entered';
		Return -1;
	End
	If not exists(Select 1 from Requests Where Id = @RequestId)
	Begin
		Print 'Request not Found';
		Return -2;	
	End
	If not exists(Select 1 from Products where Description = @ProductName)
	Begin
		Print 'Name not found';
		Return -3;
	End
	If @Quantity < 1
	Begin
		Print 'Quantity must be greater than 0';
		Return -4;
	End  --End of Parameter check
	Declare @ProductId int;
	Select @ProductId = Id from Products where Description = @ProductId
	--Insert
	Insert Requestlines (RequestId, ProductId, Quantity)
		Values (@RequestId, @ProductId, @Quantity);
	print 'Insert Success!!';
	Return 0;
End 
go                             --Reference your Data to fill. :D
exec AddRequestLine @requestid = ?, @productname = ?, @Quantity = ?