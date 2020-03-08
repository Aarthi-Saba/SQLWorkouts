
/* Create Table Customer (
CustomerID INT NOT NULL,
FirstName Nvarchar(50 ) NOT NULL,
LastName Nvarchar(50) NOT NULL) */

/* Create Table Orders(
OrderID INT Not NULL,
CustomerID INT NOT NULL,
OrderDate datetime Not NULL) */
USE [db_Aarthi]
GO
INSERT INTO [dbo].[Customer]
           ([CustomerID]
           ,[FirstName]
           ,[LastName])
     VALUES
           (1,'Alex','Hazen'),(2,'Bob','Michael'),(3,'Henry','joe'),
		   (4,'Tom','Hanks'),(5,'John','Kim'),(6,'Lucy','Max'),
		   (7,'Goerge','Mike'),(8,'Frank','Jones'),(9,'Rob','Jones')
		   --(10,'Kale','Sam')
		   --(11,'Peter','Mike')
GO


USE [db_Aarthi]
GO

INSERT INTO [dbo].[Orders]
           ([OrderID]
           ,[CustomerID]
           ,[OrderDate])
     VALUES (100,4,'2018-12-9')
          (121,2,'2019-10-11'),(120,1,'2019-04-03'),(100,4,'2018-12-9'),
		  (105,8,'2019-09-08'),(112,5,'2019-12-01')
		 -- (130,10,'2019-04-30')
GO

SELECT [CustomerID]
      ,[FirstName]
      ,[LastName]
  FROM [dbo].[Customer]
  ORDER BY CustomerID
GO
SELECT [OrderID]
      ,[CustomerID]
      ,[OrderDate]
  FROM [dbo].[Orders]
  ORDER BY OrderID
GO
SELECT [Id]
      ,[Old_CustID]
      ,[New_CustID]
      ,[Old_Fname]
      ,[New_Fname]
      ,[Old_Lname]
      ,[New_Lname]
      ,[Date_Time]
      ,[Login_name]
  FROM [dbo].[CusAudit]
GO
DELETE Orders Where OrderID > 120
USE [db_Aarthi]
GO
UPDATE [dbo].[Customer]
   SET [CustomerID] = 10
 WHERE [CustomerID] = 11
GO 
UPDATE [dbo].[Orders] SET [CustomerID] = 3
 WHERE [CustomerID] =12
Use db_Aarthi
GO
CREATE TABLE CusAudit(
Id INT IDENTITY(1,1),
Old_CustID INT,
New_CustID INT,
Old_Fname varchar(50),
New_Fname varchar(50),
Old_Lname varchar(50),
New_Lname varchar(50),
Date_Time DateTime2,
Login_name varchar(20))

USE [db_Aarthi]
GO

