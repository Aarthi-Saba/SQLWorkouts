/****** Question-3,Max Currency Using Country Code  ******/
WITH Max_Salary AS (SELECT AP.Country_Code AS Country,MAX(Current_Salary) AS Highest_Salary
  FROM [JobPortal_Local].[dbo].[Applicant_Profiles] AS AP
  GROUP BY AP.Country_Code),
Login_Details AS (
SELECT AP.Login AS LoginId ,MS.Country AS Country,MS.Highest_Salary AS Salary
  FROM [JobPortal_Local].[dbo].[Applicant_Profiles] AS AP
  INNER JOIN Max_Salary AS MS ON (MS.Country = AP.Country_Code) AND (MS.Highest_Salary = AP.Current_Salary))
SELECT SL.Full_Name as "Applicant Name",LD.Country AS Country,LD.Salary AS Salary
  FROM [JobPortal_Local].[dbo].[Security_Logins] AS SL
  INNER JOIN Login_Details AS LD
  ON LD.LoginId = SL.Id
  ORDER BY Country

  WITH Max_Salary AS (SELECT AP.Country_Code AS Country,MAX(Current_Salary) AS Highest_Salary
  FROM [JobPortal_Local].[dbo].[Applicant_Profiles] AS AP
  GROUP BY AP.Country_Code)
SELECT AP.Login AS LoginId ,MS.Country AS Country,MS.Highest_Salary AS Salary
  FROM [JobPortal_Local].[dbo].[Applicant_Profiles] AS AP
  INNER JOIN Max_Salary AS MS ON (MS.Country = AP.Country_Code) AND (MS.Highest_Salary = AP.Current_Salary)


WITH SC AS
(
 SELECT Max(AP.Current_Salary) AS Salary,AP.Currency AS Currency
   FROM [JobPortal_Local].[dbo].[Applicant_Profiles] AS AP
   GROUP BY AP.Currency),
Salary_Details AS
(
SELECT AP1.Login AS Id,SC.Salary,SC.Currency
 FROM [JobPortal_Local].[dbo].[Applicant_Profiles] AS AP1
 INNER JOIN SC ON (AP1.Currency = SC.Currency) AND (AP1.Current_Salary = SC.Salary) 
)
SELECT SL.Full_Name AS ApplicantName ,SD.Salary AS CurrentSalary,SD.Currency AS Currency
FROM [JobPortal_Local].[dbo].[Security_Logins] AS SL
INNER JOIN Salary_Details AS SD
ON SL.Id = SD.Id
ORDER BY Currency


/*PROBLEM -2
Identify the companies where applicants applied for the job 10 or more times. Eliminate duplicate lines from your output.
Output Colums : Company Name (English only)
Order by: Company Name */
SELECT CD.Company_Name AS CompanyName
  FROM [JobPortal_Local].[dbo].[Company_Descriptions] AS CD
  WHERE CD.Company IN(
SELECT CJ.Company
  FROM [JobPortal_Local].[dbo].[Company_Jobs] AS CJ
  WHERE CJ.Id IN
  (SELECT AJ.Job
  FROM [JobPortal_Local].[dbo].[Applicant_Job_Applications] AS AJ
  GROUP BY AJ.Job
  HAVING COUNT(AJ.Job) >= 10)) AND CD.LanguageID = 'EN'
  ORDER BY Company_Name;

  /* PROBLEM1 WRONG SOLUTION FIRST CREATED*/
SELECT distinct LO.Login AS UserLogin,LO.Full_Name AS UserName,LO.Phone_Number AS UserPhone
FROM [JobPortal_Local].[dbo].[Security_Logins_Log] AS LL
INNER JOIN
[JobPortal_Local].[dbo].[Security_Logins] AS LO
ON LL.Login = LO.Id
WHERE Year(LL.Logon_Date) < 2017
order by LO.Login;
/* Correct solution */
SELECT SL.Login,SL.Full_Name,SL.Phone_Number
 FROM [JobPortal_Local].[dbo].[Security_Logins] AS SL
 WHERE SL.Id IN(
SELECT DISTINCT LL.Login
  FROM [JobPortal_Local].[dbo].[Security_Logins_Log] AS LL
  WHERE LL.Logon_Date < '20170101' AND LL.Is_Succesful = 1 
EXCEPT
SELECT DISTINCT LL.Login
  FROM [JobPortal_Local].[dbo].[Security_Logins_Log] AS LL
  WHERE (LL.Logon_Date >='20170101' AND LL.Is_Succesful = 1))