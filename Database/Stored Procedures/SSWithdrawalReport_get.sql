if exists (select 1 from sys.objects where object_id = object_id('dbo.SSWithdrawalReport_get'))
   set noexec on
go
create procedure dbo.[SSWithdrawalReport_get] as
begin
   select 1 as [not yet implemented]
end
go
set noexec off
go

alter procedure [dbo].[SSWithdrawalReport_get]
AS

-- CFA_60%TERM_WITHDRAWAL_REPORT

SELECT [ColleagueID] ,
        WithdrawalDate ,
       SCS.Term ,
       t.[TermStartDate]
FROM [COCE-LSTNR,50333].[AARDW].[AARPL].[StudentCourseSection] SCS
JOIN [COCE-LSTNR,50333].[AARDW].[AARPL].[Student] STUD ON STUD.Student_SK = SCS.[Student_SK]
JOIN [COCE-LSTNR,50333].[AARDW].[AARPL].[Term] AS [t] ON t.[Term_SK] = SCS.[Term_SK]
WHERE SCS.AcademicLevelCode = 'CFA'
AND SCS.[CurrentRegistrationStatusCode] = 'W'
AND SCS.CourseNumber IN ( '000', '001' )
AND SCS.Term = RIGHT(CAST(YEAR(DATEADD(DAY ,1 ,EOMONTH(DATEADD(MONTH, -7, GETDATE())))) AS VARCHAR), 2) + 'CFA' + RIGHT('000' + CAST(MONTH(DATEADD(DAY ,1 ,EOMONTH(DATEADD(MONTH ,-7, GETDATE())))) AS VARCHAR), 2)
AND DATEDIFF(DAY, t.[TermStartDate], [SCS].[WithdrawalDate]) < .60 * DATEDIFF(DAY ,t.termStartDate,DATEADD(MONTH ,6 ,t.[TermStartDate]));
GO


