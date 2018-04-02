if exists (select 1 from sys.objects where object_id = object_id('dbo.AdvisorCaseLoad_get'))
   set noexec on
go
create procedure dbo.[AdvisorCaseLoad_get] as
begin
   select 1 as [not yet implemented]
end
go
set noexec off
go

alter PROCEDURE [dbo].[AdvisorCaseLoad_get]
AS

-- GetCFAADVISORCASELOAD

	SET NOCOUNT ON	

		
	/*----------------------------------------------------------------------------------------------------
	     Author:        SNHU\s.boyer1
	     Description:   
	  
	     Notes:
	  
	     Modification Log:
	         Date:        Made by:        Description:
	         10/25/2017    Faby			Report used by CFA Coaches and Dan P.'s team to assign students to advisors
	  
	 ----------------------------------------------------------------------------------------------------*/



DECLARE @CFANextTerm VARCHAR(10),
		@CFANextTermStartDate DATETIME2


SELECT @CFANextTerm = RIGHT(CAST(YEAR(DATEADD(d,1,EOMONTH(GETDATE()))) AS VARCHAR),2) + 'CFA' + RIGHT('00' + CAST(MONTH(DATEADD(d,1,EOMONTH(GETDATE()))) AS VARCHAR), 2),
       @CFANextTermStartDate = DATEADD(d,1,EOMONTH(GETDATE()))

SELECT [C].[Primary_Coach_Fullname_Text__c] [ADVISOR]
	  ,[C].[Active_Student_Program_Status__c] 'Active Student Program Status'
	  ,[C].[Colleague_ID__c] 'Colleague ID'
	  ,[C].[Colleague_Next_Term_Start_Date_Code__c] 'Next Term'
	  ,CONVERT(VARCHAR,[C].[ASP_Start_Date__c],101) 'ASP Start Date'
	  ,[C].[LastName] 'Last Name'
	  ,[C].[FirstName] 'First Name'
	  ,[U].[Manager_Full_Name__c] 'Team Lead'
	  ,CASE	WHEN [C].[Colleague_Next_Term_Start_Date_Code__c] = @CFANextTerm THEN 1
			ELSE 0
		END AS 'Possible ReEnroll Next Month'
	  ,CASE	WHEN [C].[ASP_Start_Date__c] = @CFANextTermStartDate THEN 1
			ELSE 0
		END AS 'OnBoarding Next Month'
	  ,CASE	WHEN [C].[ASP_Start_Date__c] = @CFANextTermStartDate THEN 'OnBoarding Next Month'
			WHEN [C].[Colleague_Next_Term_Start_Date_Code__c] = @CFANextTerm THEN 'Possible Renrolls Next Month'
			ELSE 'Continuing Student'
	   END AS 'Description'
FROM [Contact] [C]
LEFT JOIN [SalesforceStg].[dbo].[User] [U] ON [C].[Primary_Coach__c] = [U].[Id]
LEFT JOIN [SalesforceStg].[dbo].[Account] [A] ON [C].[AccountId] = [A].[Id]
WHERE [C].[Active_Student_Program_Status__c] IN ('Registered','Enrolled','Pending Grad Review') 
AND [A].[Name] <> 'SW Test' 
AND [C].[Colleague_ID__c] IS NOT NULL 
AND [C].[App_ISQ_Received__c] <> 'False' 
AND [U].[Manager_Full_Name__c] IN ('Michael Miller','Andrea Bruneau','Chantel Freeman','Nathan Szydlo') 
AND @CFANextTermStartDate >= [C].[ASP_Start_Date__c]
ORDER BY [C].[Primary_Coach_Fullname_Text__c];


