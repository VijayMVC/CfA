if exists (select 1 from sys.objects where object_id = object_id('dbo.CFA_ENDOFTERMSTATEMENT_ALLPARTNERS'))
   set noexec on
go
create procedure dbo.CFA_ENDOFTERMSTATEMENT_ALLPARTNERS as
begin
   select 1 as [not yet implemented]
end
go
set noexec off
go

ALTER PROCEDURE [CFA_ENDOFTERMSTATEMENT_ALLPARTNERS]
AS
SELECT STUD.[ColleagueID] ,
        SCS.Term ,
        t.[TermStartDate] ,
        a.Name AS [Account Name] ,
        c.[CfA_Invoicing_Type__c] AS [CfA Invoicing Type] ,
        c.[LastName] ,
        c.[FirstName] ,
        c.[CfA_Email__c] ,
        c.[SNHU_Email_Address__c] ,
        c.[Personal_Email__c] ,
        [FERPA_Permission_Last_Received__c] ,
        [FERPA_Status__c] ,
        c.Primary_Coach_Fullname_Text__c ,
        c.PC_Email__c ,
        [Active_Student_Program_Title__c] ,
        c.[Active_Student_Program_Status__c] ,
        [Active_Student_Program_Start__c] ,
        [Active_Student_Program_End__c] ,
        SUM(CASE WHEN SCS.Grade = 'MA' THEN 1
                ELSE 0
            END) AS [Term Comps MA] ,
        SUM(CASE WHEN SCS.Grade <> 'MA' THEN 1
                ELSE 0
            END) AS [Term Comps NOT MA] ,
        SUM(CASE WHEN SCS.course IN ( 'CFA-000', 'CFA-001', 'CFA-002' )
                    AND SCS.[CurrentRegistrationStatusCode] = 'W' THEN 1
                ELSE 0
            END) AS [Withdrew from Term]
FROM [COCE-LSTNR,50333].[AARDW].[AARPL].[StudentCourseSection] SCS
JOIN [COCE-LSTNR,50333].[AARDW].[AARPL].[Student] STUD ON STUD.Student_SK = SCS.[Student_SK]
JOIN [COCE-LSTNR,50333].[AARDW].[AARPL].[Term] AS [t] ON t.[Term_SK] = SCS.[Term_SK]
LEFT JOIN [Contact] c ON c.[Colleague_ID__c] = STUD.ColleagueID
LEFT JOIN [Account] a ON a.Id = c.[AccountId]
WHERE SCS.AcademicLevelCode = 'CFA'
AND SCS.[CurrentRegistrationStatusCode] IN ( 'A', 'N', 'W' )
AND SCS.Term = RIGHT(CAST(YEAR(DATEADD(DAY, 1, EOMONTH(DATEADD(MONTH, -7, GETDATE())))) AS VARCHAR), 2) + 'CFA' + RIGHT('000' + CAST(MONTH(DATEADD(DAY ,1 ,EOMONTH(DATEADD(MONTH ,-7, GETDATE())))) AS VARCHAR), 2)
GROUP BY STUD.[ColleagueID] ,
        SCS.Term ,
        t.[TermStartDate] ,
        a.Name ,
        c.[CfA_Invoicing_Type__c] ,
        c.[LastName] ,
        c.[FirstName] ,
        c.[CfA_Email__c] ,
        c.[SNHU_Email_Address__c] ,
        c.[Personal_Email__c] ,
        [FERPA_Permission_Last_Received__c] ,
        [FERPA_Status__c] ,
        c.Primary_Coach_Fullname_Text__c ,
        c.PC_Email__c ,
        [Active_Student_Program_Title__c] ,
        c.[Active_Student_Program_Status__c] ,
        [Active_Student_Program_Start__c] ,
        [Active_Student_Program_End__c];
GO


