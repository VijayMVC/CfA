if exists (select 1 from sys.objects where object_id = object_id('dbo.FADisbursement_get'))
   set noexec on
go
create procedure dbo.[FADisbursement_get] as
begin
   select 1 as [not yet implemented]
end
go
set noexec off
go

alter PROC [dbo].[FADisbursement_get]
AS

-- CFA_Project_Submission_Report_FA_Disbursement

SELECT Colleague_ID__c [Colleague ID] ,
	   t.[TermStartDate],
       LastName ,
       FirstName ,
       t.Term ,
       Active_Student_Program_Status__c [Active Student Program Status] ,
       Active_Student_Program_Start__c [Active Student Program Start] ,
       Active_Student_Program_Title__c [Active Student Program Title] ,
       cast(Last_Project_Submitted_Date__c as date) [Last Project Submitted Date] ,
       cast(MIN(SCT.Last_Academic_Activity_Date__c) as date) [First Academic Activity Date In Term] ,
       cast(MAX(SCT.Last_Academic_Activity_Date__c) as date) [Last Academic Activity Date In Term]
FROM Contact C
INNER JOIN [COCE-LSTNR,50333].AARDW.AARPL.Term t ON t.Term = C.Colleague_Current_Term_Start_Date_Code__C
LEFT JOIN Student_Competency_Transcript__c SCT ON SCT.Colleague_ID_From_Student__c = C.Colleague_ID__c
                                               AND t.TermStartDate <= SCT.Last_Academic_Activity_Date__c
                                               AND t.TermEndDate > SCT.Last_Academic_Activity_Date__c
                                               AND SCT.Account_Name__c != 'SW test Account'
WHERE C.Active_Student_Program_Status__c IN ( 'Enrolled', 'Pending Grad Review', 'Withdrew' , 'Trial Period Drop', 'Graduated' )
AND Colleague_ID__c IS NOT NULL
AND TermTypeCode = 'CFA'
AND (TermStartDate > DATEADD(M, -7, (GETDATE())) and TermStartDate <=  (GETDATE()))
GROUP BY Colleague_ID__c ,
         LastName ,
         FirstName ,
		 t.[TermStartDate],
         t.Term ,
         Active_Student_Program_Status__c ,
         Active_Student_Program_Start__c ,
         Last_Project_Submitted_Date__c ,
         Active_Student_Program_Title__c
ORDER BY t.Term, Colleague_ID__c;
GO


