USE tempdb
GO

--Create a table for test
CREATE TABLE [dbo].[Employees](
[id] CHAR(10) PRIMARY KEY,
[name] VARCHAR(50)
)
GO

--Create a dummy INSTEAD OF DELETE trigger on the table
CREATE Trigger trIOD_Employees on [dbo].[Employees]
instead of delete
AS
BEGIN
	SELECT 'Hello World!'
END
GO

--Fill the table with sample records
INSERT INTO [dbo].[Employees] VALUES('0000000001','John')
INSERT INTO [dbo].[Employees] VALUES('0000000002','Robert')
INSERT INTO [dbo].[Employees] VALUES('0000000003','Donald')
GO

--Check if table is filled
select * from [dbo].[Employees]
GO

--Delete all record from the table
delete from [dbo].[Employees]
GO

--Check if table is empty. As you see nothing has been deleted
select * from [dbo].[Employees]
GO

DROP table [dbo].[Employees]
GO