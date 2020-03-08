/****** Assignment Problems:  ******/
/* PROBLEM -1
Identify the users who logon before 2017 but never logon during 2017. Eliminate duplicate lines from your output.
Output Colums: User Login, User Name, User Phone
Order by: User Login */
SELECT SL.Login,SL.Full_Name,SL.Phone_Number
 FROM [JobPortal_Local].[dbo].[Security_Logins] AS SL
 WHERE SL.Id IN(
SELECT DISTINCT LL.Login
  FROM [JobPortal_Local].[dbo].[Security_Logins_Log] AS LL
  WHERE LL.Logon_Date < '20170101' AND LL.Is_Succesful = 1 
EXCEPT
SELECT DISTINCT LL.Login
  FROM [JobPortal_Local].[dbo].[Security_Logins_Log] AS LL
  WHERE (LL.Logon_Date >='20170101' AND LL.Is_Succesful = 1));

/* Resulted in 44 distinct rows,with 3 null values for Phone */

/*PROBLEM -2
Identify the companies where applicants applied for the job 10 or more times. Eliminate duplicate lines from your output.
Output Colums : Company Name (English only)
Order by: Company Name */
WITH Company_Applied AS(
SELECT CJ.Company AS Company_Id
  FROM [JobPortal_Local].[dbo].[Applicant_Job_Applications] AJ
  INNER JOIN [JobPortal_Local].[dbo].[Company_Jobs] AS CJ
  ON AJ.Job = CJ.Id
  GROUP BY CJ.Company
  HAVING Count(CJ.Company)>=10)
SELECT CD.Company_Name
  FROM [JobPortal_Local].[dbo].[Company_Descriptions] AS CD
  INNER JOIN Company_Applied AS CA
  ON CA.Company_Id = CD.Company
  WHERE CD.LanguageID='EN'
  ORDER BY CD.Company_Name;

/*PROBLEM -3
3. Identify the Applicants with highest current salary for each Currency.

             Output Colums : Applicant Name, Current Salary, Currency */

/****** Script for SelectTopNRows command from SSMS  ******/
With Salary_details AS (
SELECT * FROM
(SELECT AP.Login AS Id,RANK() OVER (PARTITION BY AP.Currency ORDER BY AP.Current_Salary DESC) AS Salary_Rank,AP.Current_Salary AS Salary,
      AP.Currency AS Currency
  FROM [JobPortal_Local].[dbo].[Applicant_Profiles] AS AP)tmp
WHERE Salary_Rank =1)
SELECT SL.Full_Name,SD.Salary,SD.Currency
 FROM  [JobPortal_Local].[dbo].[Security_Logins] AS SL
 INNER JOIN Salary_details AS SD
 ON SL.Id = SD.Id
 ORDER BY SD.Currency;

/*PROBLEM -4
4. For each company, determine the number of jobs posted. If a company doesn't have posted jobs, show 0 for that company.
   Output Colums : Company Name,  #Jobs Posted (show 0 if none)
   Order by: #Jobs Posted */
WITH Company_Details AS
(
SELECT CD.Company AS Id,CD.Company_Name AS Company_Name
FROM [JobPortal_Local].[dbo].[Company_Descriptions] AS CD
WHERE LanguageID='EN'),
Company_Job_Counts AS (
SELECT CJ.Company,Count(CJ.Company) AS Jobs_Posted
  FROM [JobPortal_Local].[dbo].[Company_Jobs] AS CJ
  GROUP BY CJ.Company),
Company_Jobs_Posted AS (
SELECT CD.Company_Name AS CName,CJ.Jobs_Posted AS Job_Count
  FROM Company_Details AS CD
  LEFT JOIN Company_Job_Counts AS CJ
  ON CD.Id = CJ.Company)
SELECT JP.CName AS "Company Name",COALESCE(JP.Job_Count,0) AS "No Of Jobs Posted" FROM Company_Jobs_Posted AS JP
ORDER BY JP.Job_Count DESC,JP.CName;

/*PROBLEM -5
5. Determine the total number of companies that have posted jobs and the total number of companies that has 
never posted jobs in one data set with 2 rows like the one below:
Clients with Posted Jobs:	 NNN
Clients without Posted Jobs:	 NNN
*/
SELECT 'Clients With Posted Jobs',COUNT (*)
  FROM [JobPortal_Local].[dbo].[Company_Profiles] AS CP
  WHERE CP.Id IN(SELECT DISTINCT CJ.Company
  FROM [JobPortal_Local].[dbo].[Company_Jobs] AS CJ
  GROUP BY CJ.Company)
UNION ALL
SELECT 'Clients Without Posted Jobs',COUNT(*)
  FROM [JobPortal_Local].[dbo].[Company_Profiles] AS CP
  WHERE CP.Id NOT IN(SELECT DISTINCT CJ.Company
  FROM [JobPortal_Local].[dbo].[Company_Jobs] AS CJ
  GROUP BY CJ.Company);