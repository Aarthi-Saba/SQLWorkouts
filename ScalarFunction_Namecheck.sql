Create function [dbo].fn_CheckName(@FirstName as varchar(50),@LastName as varchar(50))
RETURNS Varchar(35)
AS
BEGIN
  Declare @OutputText varchar(35)
  IF (@FirstName = @LastName)
  BEGIN
    SELECT @OutputText = 'First and Last name are same'
  END
  ELSE
  BEGIN
   SELECT @OutputText = 'First and Last name are different'
  END
  RETURN @OutputText
END
GO

SELECT [dbo].fn_CheckName('Franck','Alex');