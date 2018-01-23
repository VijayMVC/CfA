create procedure FactPersonFiscalYearGet as

IF OBJECT_ID('tempdb..#AccountFiscalYear') IS NOT NULL 
	DROP TABLE #AccountFiscalYear;

select fpx.AccountID, dbo.ReturnFiscalYear (min(x.TermStartDate)) AccountStartDate
into #AccountFiscalYear
from sf.factPerson fpx
left join (SELECT st.[StudentColleagueID], t.[TermStartDate] 
			FROM [COCE-LSTNR,50333].AARDW.AARPL.StudentTerm as st
			JOIN [COCE-LSTNR,50333].AARDW.AARPL.Term t ON t.[Term_SK] = st.[Term_SK]
														and t.[TermTypeCode] = 'cfa' 
			left join [COCE-LSTNR,50333].AARDW.AARPL.[StudentCourseSection] [scs] ON scs.[StudentTerm_SK] = st.[StudentTerm_SK]
			JOIN (SELECT st.[StudentColleagueID], MIN(t.[TermStartDate]) AS FirstNewEnrollmentDate
					FROM [COCE-LSTNR,50333].AARDW.AARPL.StudentTerm AS st
					JOIN [COCE-LSTNR,50333].AARDW.AARPL.Term t ON t.[Term_SK] = st.[Term_SK]
					JOIN [COCE-LSTNR,50333].AARDW.AARPL.[StudentCourseSection] AS [scs] ON scs.[StudentTerm_SK] = st.[StudentTerm_SK]
					WHERE t.[TermTypeCode] = 'cfa'
					AND scs.Course IN ('CFA-001', 'CFA-000', 'CFA-002') AND scs.[HasMaintainedEnrollment] = 1 
					GROUP BY [st].[StudentColleagueID]) x ON x.[StudentColleagueID] = st.[StudentColleagueID] 
														AND t.[TermStartDate] = x.FirstNewEnrollmentDate
			WHERE scs.Course IN ('CFA-001', 'CFA-000', 'CFA-002')) x on fpx.ContactColleague_ID__c = x.StudentColleagueID
group by fpx.AccountId;

SELECT
sf.[LeadId]
,sf.[ContactId]
,sf.[AccountId]
,sf.[LeadRecordTypeId]
,dateadd(dd, datediff(dd,0,sf.[LeadCreatedDate]),0) AS [LeadCreatedDate]
,sf.[ContactApp_Accepted_Sent__c] AS [Accepted Flag]
,sf.[ContactApp_Accepted_Sent_Date__c] AS [Accepted Date]
,sf.[ContactApp_Forms_Received__c] AS [Application Forms Received]
,sf.[ContactApp_Forms_Sent__c] AS [Application Forms Sent]
,sf.[ContactApp_Submitted_Online__c] AS [Application Submitted]
,dateadd(dd, datediff(dd,0,sf.[ContactApp_Submitted_Online_Date__c]),0)  AS [App Date]
,sf.[ContactApplication_Status__c] AS [Application Status]
,sf.[ContactAttestation_Returned__c] AS [Attestation Returned]
,sf.[ContactCFA_Transcript_Request_Date__c] AS [CFA Transcript Request Date]
--,[ContactColleague_Current_Term_Start_Date_Code__c] AS [Colleague Current Term Start Date Code]
,sf.[ContactColleague_ID__c] AS [Colleague ID]

,sf.[ContactEnrollment_Agreement_Returned__c] AS [Enrollment Agreement Returned]
,sf.[ContactEnrollment_Agreement_Sent__c] AS [Enrollment Agreement Sent]
,sf.[ContactEstimated_Time_Zone__c] AS [Estimated Time Zone]
,sf.[ContactFERPA_Permission_Last_Received__c] AS [FERPA Permission Last Received]
,sf.[ContactFERPA_Status__c] AS [FERPA Status]
,sf.[ContactISQ_Received__c] AS [ISQ Received]
--,sf.[ContactLeave_Reason__c] AS [Leave Reason]
--,sf.[ContactLeave_Reason_Other__c] AS [Leave Reason Comments]
--,sf.[ContactNext_Term_Start_Date__c] AS [Next Term Start Date]
,sf.[ContactOnboarding_Status__c] AS [Onboarding Status]
,sf.[ContactPersonal_Email__c] AS [Personal Email]
,sf.[ContactPreferred_Email__c] AS [Preferred Email]
,sf.[ContactPreferred_Phone__c] AS [Preferred Phone]
,sf.[ContactPrimary_Coach__c] AS [Primary Coach]
,sf.[ContactSNHU_Email_Address__c] AS [SNHU Email Address]
,sf.[ContactStudent_Work_Phone__c] AS [Work Phone]
--,sf.[ContactTotal_Competencies_Mastered__c] AS [Total Competencies Mastered]
--,dateadd(dd, datediff(dd,0,[ConvertedDate]),0) AS [Converted Date]
,sf.[Country] AS [Country]
,sf.[CountryCode] AS [Country Code]
,sf.[Email] AS [Email]
,sf.[FirstName] AS [First Name]
,sf.[HomePhone] AS [Home Phone]
,sf.[Industry] AS [Industry]
,sf.[LastName] AS [Last Name]
,sf.[LeadAttended_In_Person_Info_Session__c] AS [Attended In Person Info Session]
,sf.[LeadDate_of_Info_Session__c] AS [Date of Info Session]
,sf.[LeadStatus] AS [Lead Status]
,sf.[LeadSuspect_Type__c] AS [Lead Suspect Type]
,sf.[Leadurl_code_leads__c] AS [Lead URL code]
,sf.[LeadWatched_Info_Session__c] AS [Watched Info Session]
,sf.[Name] AS [Name]
,sf.[OtherPhone] AS [Other Phone]
,sf.[Phone] AS [Phone]
,sf.[PostalCode] AS [Postal Code]
,sf.[StateCode] AS [State Code]
,sf.[Username] AS [User Name]
,sf.[UserType] AS [User Type]
,r.Name AS [RecordType]
,sf.[RecordTypeDetail]
--Begin Date Selects.
--Lead Date things
  ,DATEADD(wk, DATEDIFF(wk,0,sf.[LeadCreatedDate]), 0) AS LeadWeekOf
  ,YEAR(sf.[LeadCreatedDate])*100 + MONTH(sf.[LeadCreatedDate])AS LeadMonthKey
  ,Convert(char(3), sf.[LeadCreatedDate], 0) AS LeadMonthName
  ,Convert(char(3), sf.[LeadCreatedDate], 0) + ' ' + CONVERT(CHAR(4), YEAR(sf.[LeadCreatedDate])) AS LeadMonthYearName
  ,MONTH(sf.[LeadCreatedDate]) AS LeadMonthNum
  ,YEar (sf.[LeadCreatedDate]) AS LeadYear
  --Lead Date Quick Filters
  ,CASE WHEN MONTH(GETDATE()) = MONTH(sf.[LeadCreatedDate]) AND YEAR(GETDATE())= YEAR(sf.[LeadCreatedDate]) THEN 1 ELSE 0 END AS LeadIsCurrentMonth
  ,CASE WHEN MONTH(DATEADD(MONTH, -1, GETDATE())) = MONTH(sf.[LeadCreatedDate]) AND YEAR(DATEADD(MONTH, -1, GETDATE()))= YEAR(sf.[LeadCreatedDate]) THEN 1 ELSE 0 END as LeadIsPriorMonth
  ,CASE WHEN MONTH(GETDATE()) = MONTH(sf.[LeadCreatedDate]) AND YEAR(DATEADD(YEAR, -1, GETDATE()))= YEAR(sf.[LeadCreatedDate]) THEN 1 ELSE 0 END AS LeadIsCurrentMonthPriorYear
  ,CASE WHEN MONTH(sf.[LeadCreatedDate]) = MONTH(DATEADD(MONTH, -1, GETDATE())) AND YEAR(DATEADD(YEAR, -1, GETDATE()))= YEAR(sf.[LeadCreatedDate]) THEN 1 ELSE 0 END AS LeadIsPriorMonthPriorYear
  ,CASE WHEN dateadd(dd, datediff(dd,0,sf.[LeadCreatedDate]),0) = dateadd(dd, datediff(dd,0,GETDATE()),0) THEN 1 ELSE 0 END AS LeadIsToday
  ,CASE WHEN dateadd(dd, datediff(dd,0,sf.[LeadCreatedDate]),0) = dateadd(day,datediff(day,1,GETDATE()),0) THEN 1 ELSE 0 END AS LeadIsYesterday
  ,CASE WHEN dateadd(dd, datediff(dd,0,sf.[LeadCreatedDate]),0) >= DATEADD(wk, DATEDIFF(wk,0,DATEADD(wk, -13, GETDATE())), 0) THEN 1 ELSE 0 END AS LeadIsLast12Weeks


  --App Date thing
  ,DATEADD(wk, DATEDIFF(wk,0,sf.[ContactApp_Submitted_Online_Date__c]), 0) AS AppWeekOf
  ,YEAR(sf.[ContactApp_Submitted_Online_Date__c])*100 + MONTH(sf.[ContactApp_Submitted_Online_Date__c])AS AppMonthKey
  ,Convert(char(3), sf.[ContactApp_Submitted_Online_Date__c], 0) AS AppMonthName
  ,Convert(char(3), sf.[ContactApp_Submitted_Online_Date__c], 0) + ' ' + CONVERT(CHAR(4), YEAR(sf.[ContactApp_Submitted_Online_Date__c])) AS AppMonthYearName
  ,MONTH(sf.[ContactApp_Submitted_Online_Date__c]) AS AppMonthNum
  ,YEar (sf.[ContactApp_Submitted_Online_Date__c]) AS AppYear
  ,CASE WHEN MONTH(GETDATE()) = MONTH(sf.[ContactApp_Submitted_Online_Date__c]) AND YEAR(GETDATE())= YEAR(sf.[ContactApp_Submitted_Online_Date__c]) THEN 1 ELSE 0 END AS AppIsCurrentMonth
  ,CASE WHEN MONTH(DATEADD(MONTH, -1, GETDATE())) = MONTH(sf.[ContactApp_Submitted_Online_Date__c]) AND YEAR(DATEADD(MONTH, -1, GETDATE()))= YEAR(sf.[ContactApp_Submitted_Online_Date__c]) THEN 1 ELSE 0 END as AppIsPriorMonth
  ,CASE WHEN MONTH(GETDATE()) = MONTH(sf.[ContactApp_Submitted_Online_Date__c]) AND YEAR(DATEADD(YEAR, -1, GETDATE()))= YEAR(sf.[ContactApp_Submitted_Online_Date__c]) THEN 1 ELSE 0 END AS AppIsCurrentMonthPriorYear
  ,CASE WHEN MONTH(GETDATE()) = MONTH(DATEADD(MONTH, -1, GETDATE())) AND YEAR(DATEADD(YEAR, -1, GETDATE()))= YEAR(sf.[ContactApp_Submitted_Online_Date__c]) THEN 1 ELSE 0 END AS AppIsPriorMonthPriorYear
  ,CASE WHEN dateadd(dd, datediff(dd,0,sf.[ContactApp_Submitted_Online_Date__c]),0) = dateadd(dd, datediff(dd,0,GETDATE()),0) THEN 1 ELSE 0 END AS AppIsToday
  ,CASE WHEN dateadd(dd, datediff(dd,0,sf.[ContactApp_Submitted_Online_Date__c]),0) = dateadd(day,datediff(day,1,GETDATE()),0) THEN 1 ELSE 0 END AS AppIsYesterday
  ,CASE WHEN dateadd(dd, datediff(dd,0,sf.[ContactApp_Submitted_Online_Date__c]),0) >= DATEADD(wk, DATEDIFF(wk,0,DATEADD(wk, -13, GETDATE())), 0) THEN 1 ELSE 0 END AS AppIsLast12Weeks

  --Accept Date things
  
  ,DATEADD(wk, DATEDIFF(wk,0,sf.[ContactApp_Accepted_Sent_Date__c]), 0) AS AcptWeekOf
  ,YEAR(sf.[ContactApp_Accepted_Sent_Date__c])*100 + MONTH(sf.[ContactApp_Accepted_Sent_Date__c])AS AcptMonthKey
  ,Convert(char(3), sf.[ContactApp_Accepted_Sent_Date__c], 0) AS AcptMonthName
  ,Convert(char(3), sf.[ContactApp_Accepted_Sent_Date__c], 0) + ' ' + CONVERT(CHAR(4), YEAR(sf.[ContactApp_Accepted_Sent_Date__c])) AS AcptMonthYearName
  ,MONTH(sf.[ContactApp_Accepted_Sent_Date__c]) AS AcptMonthNum
  ,YEar (sf.[ContactApp_Accepted_Sent_Date__c]) AS AcptYear
  ,CASE WHEN MONTH(GETDATE()) = MONTH(sf.[ContactApp_Accepted_Sent_Date__c]) AND YEAR(GETDATE())= YEAR(sf.[ContactApp_Accepted_Sent_Date__c]) THEN 1 ELSE 0 END AS AcptIsCurrentMonth
  ,CASE WHEN MONTH(DATEADD(MONTH, -1, GETDATE())) = MONTH(sf.[ContactApp_Accepted_Sent_Date__c]) AND YEAR(DATEADD(MONTH, -1, GETDATE()))= YEAR(sf.[ContactApp_Accepted_Sent_Date__c]) THEN 1 ELSE 0 END as AcptIsPriorMonth
  ,CASE WHEN MONTH(GETDATE()) = MONTH(sf.[ContactApp_Accepted_Sent_Date__c]) AND YEAR(DATEADD(YEAR, -1, GETDATE()))= YEAR(sf.[ContactApp_Accepted_Sent_Date__c]) THEN 1 ELSE 0 END AS AcptIsCurrentMonthPriorYear
  ,CASE WHEN MONTH(sf.[ContactApp_Accepted_Sent_Date__c]) = MONTH(DATEADD(MONTH, -1, GETDATE())) AND YEAR(DATEADD(YEAR, -1, GETDATE()))= YEAR(sf.[ContactApp_Accepted_Sent_Date__c]) THEN 1 ELSE 0 END AS AcptIsPriorMonthPriorYear
  ,CASE WHEN dateadd(dd, datediff(dd,0,sf.[ContactApp_Accepted_Sent_Date__c]),0) = dateadd(dd, datediff(dd,0,GETDATE()),0) THEN 1 ELSE 0 END AS AcptIsToday
  ,CASE WHEN dateadd(dd, datediff(dd,0,sf.[ContactApp_Accepted_Sent_Date__c]),0) = dateadd(day,datediff(day,1,GETDATE()),0) THEN 1 ELSE 0 END AS AcptIsYesterday
  ,CASE WHEN dateadd(dd, datediff(dd,0,sf.[ContactApp_Accepted_Sent_Date__c]),0) >= DATEADD(wk, DATEDIFF(wk,0,DATEADD(wk, -13, GETDATE())), 0) THEN 1 ELSE 0 END AS AcptIsLast12Weeks



  --Enrollment Stuff
  ,CASE WHEN x.[TermStartDate] IS NOT NULL THEN 1 ELSE 0 END AS NewEnrollment
  ,YEAR(x.[TermStartDate])*100 + MONTH( x.[TermStartDate]) AS EnrMonthKey
  ,Convert(char(3), x.[TermStartDate], 0) AS EnrMonthName
  ,Convert(char(3), x.[TermStartDate], 0) + ' ' + CONVERT(CHAR(4), YEAR([TermStartDate])) AS EnrMonthYearName
  ,RIGHT(CAST(YEAR(x.[TermStartDate]) AS VARCHAR), 2) + 'CFA' + 
    RIGHT ('00' + CAST(MONTH(x.[TermStartDate]) AS VARCHAR), 2) AS EnrTerm
  --Enroll Date things
  ,CASE WHEN MONTH(GETDATE()) = MONTH(x.[TermStartDate]) AND YEAR(GETDATE())= YEAR(x.[TermStartDate]) THEN 1 ELSE 0 END AS EnrIsCurrentMonth
  ,CASE WHEN MONTH(DATEADD(MONTH, -1, GETDATE())) = MONTH(x.[TermStartDate]) AND YEAR(DATEADD(MONTH, -1, GETDATE()))= YEAR(x.[TermStartDate]) THEN 1 ELSE 0 END as EnrIsPriorMonth
  ,CASE WHEN MONTH(GETDATE()) = MONTH(x.[TermStartDate]) AND YEAR(DATEADD(YEAR, -1, GETDATE()))= YEAR(x.[TermStartDate]) THEN 1 ELSE 0 END AS EnrIsCurrentMonthPriorYear
  ,CASE WHEN MONTH(x.[TermStartDate]) = MONTH(DATEADD(MONTH, -1, GETDATE())) AND YEAR(DATEADD(YEAR, -1, GETDATE()))= YEAR(x.[TermStartDate]) THEN 1 ELSE 0 END AS EnrIsPriorMonthPriorYear
  ,CASE WHEN dateadd(dd, datediff(dd,0,x.[TermStartDate]),0) = dateadd(dd, datediff(dd,0,GETDATE()),0) THEN 1 ELSE 0 END AS EnrIsToday
  ,CASE WHEN dateadd(dd, datediff(dd,0,x.[TermStartDate]),0) = dateadd(day,datediff(day,1,GETDATE()),0) THEN 1 ELSE 0 END AS EnrIsYesterday
  ,CASE WHEN dateadd(dd, datediff(dd,0,x.[TermStartDate]),0) >= DATEADD(wk, DATEDIFF(wk,0,DATEADD(wk, -13, GETDATE())), 0) THEN 1 ELSE 0 END AS EnrIsLast12Weeks
  ,o.Name AS LeadOwner
  ,case when dbo.ReturnFiscalYear (x.[TermStartDate]) = dbo.ReturnFiscalYear ((dateadd(year, -1, getdate()))) then 1 else 0 end LastFiscalYearNewEnrollment
  ,case when dbo.ReturnFiscalYear (x.[TermStartDate]) = dbo.ReturnFiscalYear (getdate()) 
	 	 --and dbo.ReturnFiscalYear (x.[TermStartDate]) > y.AccountStartDate 
		 then 1 else 0 end CurrentFiscalYearNewEnrollment,
		 y.AccountStartDate 
FROM [sf].[FactPerson] sf
LEFT JOIN (SELECT  st.[StudentColleagueID], t.[TermStartDate]
		   FROM [COCE-LSTNR,50333].AARDW.AARPL.StudentTerm as st
		   JOIN [COCE-LSTNR,50333].AARDW.AARPL.Term t ON t.[Term_SK] = st.[Term_SK]
													  and t.[TermTypeCode] = 'cfa' 
		   left join [COCE-LSTNR,50333].AARDW.AARPL.[StudentCourseSection] [scs] ON scs.[StudentTerm_SK] = st.[StudentTerm_SK]
		   JOIN (SELECT st.[StudentColleagueID], MIN(t.[TermStartDate]) AS FirstNewEnrollmentDate
				 FROM [COCE-LSTNR,50333].AARDW.AARPL.StudentTerm AS st
			     JOIN [COCE-LSTNR,50333].AARDW.AARPL.Term t ON t.[Term_SK] = st.[Term_SK]
			     JOIN [COCE-LSTNR,50333].AARDW.AARPL.[StudentCourseSection] AS [scs] ON scs.[StudentTerm_SK] = st.[StudentTerm_SK]
			     WHERE t.[TermTypeCode] = 'cfa'
			     AND scs.Course IN ('CFA-001', 'CFA-000', 'CFA-002') AND scs.[HasMaintainedEnrollment] = 1 
			     GROUP BY [st].[StudentColleagueID]) x ON x.[StudentColleagueID] = st.[StudentColleagueID] 
													   AND t.[TermStartDate] = x.FirstNewEnrollmentDate
		   WHERE scs.Course IN ('CFA-001', 'CFA-000', 'CFA-002')
		   GROUP BY st.[StudentColleagueID], t.[TermStartDate])  AS x ON sf.[ContactColleague_ID__c] = x.[StudentColleagueID]
LEFT JOIN sf.[FactPerson] AS [o] ON o.UserId = sf.LeadOwnerId
LEFT JOIN sf.RecordType AS r ON r.Id = sf.LeadRecordTypeId
left join #AccountFiscalYear y on y.AccountId = sf.AccountId
WHERE (sf.LeadID IS NOT NULL OR sf.ContactID IS NOT Null)
order by x.termstartdate desc;

IF OBJECT_ID('tempdb..#AccountFiscalYear') IS NOT NULL 
	DROP TABLE #AccountFiscalYear;
