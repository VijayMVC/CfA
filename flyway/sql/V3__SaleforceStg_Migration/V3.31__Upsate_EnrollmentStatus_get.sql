if exists (select 1 from sys.objects where object_id = object_id('dbo.EnrollmentStatus_get'))
   set noexec on
go
create procedure dbo.[EnrollmentStatus_get] as
begin
   select 1 as [not yet implemented]
end
go
set noexec off
go

alter proc [dbo].[EnrollmentStatus_get] as

select Colleague_ID__c [Colleague ID]
,x.term
,u.name
,HasMaintainedEnrollment
,x.TermStartDate
,x.FirstNewEnrollmentDate
,a.name
,a.segment__c
,fp.[FirstAcademicProgram]
,fp.[FirstProgramDegreeCode] 
,case when HasMaintainedEnrollment = 1 and x.FirstNewEnrollmentDate = x.TermStartDate then 0
      when HasMaintainedEnrollment = 0 and isnull(x.FirstNewEnrollmentDate, getdate()) >= x.TermStartDate then 1 
         else NULL end NewStartMelt
,case when HasMaintainedEnrollment = 1 and x.FirstNewEnrollmentDate < x.TermStartDate then 0 
         when HasMaintainedEnrollment = 0 and x.FirstNewEnrollmentDate < x.TermStartDate then 1 
         end ReEnrollment
FROM [Contact] sf
LEFT OUTER JOIN (SELECT st.[StudentColleagueID], t.[TermStartDate], FirstNewEnrollmentDate, t.Term, max(cast(scs.[HasMaintainedEnrollment] as int)) HasMaintainedEnrollment
			   FROM [COCE-LSTNR,50333].AARDW.AARPL.StudentTerm as st
			   JOIN [COCE-LSTNR,50333].AARDW.AARPL.Term t ON t.[Term_SK] = st.[Term_SK]
										and t.[TermTypeCode] = 'cfa' 
			   left join [COCE-LSTNR,50333].AARDW.AARPL.[StudentCourseSection] [scs] ON scs.[StudentTerm_SK] = st.[StudentTerm_SK]
			   left JOIN (SELECT st.[StudentColleagueID], MIN(t.[TermStartDate]) AS FirstNewEnrollmentDate
						  FROM [COCE-LSTNR,50333].AARDW.AARPL.StudentTerm AS st
						  JOIN [COCE-LSTNR,50333].AARDW.AARPL.Term t ON t.[Term_SK] = st.[Term_SK]
						  JOIN [COCE-LSTNR,50333].AARDW.AARPL.[StudentCourseSection] AS [scs] ON scs.[StudentTerm_SK] = st.[StudentTerm_SK]
						  WHERE t.[TermTypeCode] = 'cfa'
						  AND scs.Course IN ('CFA-001', 'CFA-000', 'CFA-002') 
						  AND scs.[HasMaintainedEnrollment] = 1 
						  GROUP BY [st].[StudentColleagueID]) x ON x.[StudentColleagueID] = st.[StudentColleagueID]
				WHERE t.[TermTypeCode] = 'cfa'
				and scs.Course IN ('CFA-001', 'CFA-000', 'CFA-002')
				and HasMaintainedEnrollment is not null
				GROUP BY st.[StudentColleagueID], t.[TermStartDate], t.Term, FirstNewEnrollmentDate) x ON sf.[Colleague_ID__c] = x.[StudentColleagueID]
LEFT JOIN Account a on a.id = sf.AccountId
LEFT JOIN [User] u on u.[Id] = a.[OwnerId]
LEFT JOIN [FactPerson] fp on fp.[ContactColleague_ID__c]=Colleague_ID__c 
where sf.Colleague_ID__c is not null
and a.name <> 'SW test Account'

GO


