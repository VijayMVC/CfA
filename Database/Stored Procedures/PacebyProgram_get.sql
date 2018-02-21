if exists (select 1 from sys.objects where object_id = object_id('PacebyProgram_get'))
   set noexec on
go
create procedure dbo.[PacebyProgram_get] as
begin
   select 1 as [not yet implemented]
end
go
set noexec off
go

GRANT EXECUTE ON [PacebyProgram_get] TO PUBLIC;

GO

alter proc [dbo].[PacebyProgram_get] as

select SGT.[Goal_Start_Date__c], SGT.[Student_Goal_Transcript_Unique_ID__c],p.[Colleague_Course_Program_Code__c],SGT.Date_Mastered__c, [Goal_Name__c],pg.[Program_Title__c],SGT.[Colleague_ID_From_Student__c],datediff (d,[Goal_Start_Date__c],SGT.Date_Mastered__c) 'Number of Days to Mastery',SGT.Level_3_Mastery__c as 'Purple Path'

from [Student_Goal_Transcript__c]SGT
inner join Program_Goal__c pg on pg.id = SGT.[Program_Goal__c]
inner join [Program__c] p on p.[SFDC_Program_ID__c] = pg.[SFDC_Program_ID__c]                                                                                                                                    
left join  [Contact] c on c.[Colleague_ID__c]= SGT.[Colleague_ID_From_Student__c]
inner join Account A on a.Id = c.[AccountId]

where SGT.[Goal_Start_Date__c] is not null 
and SGT.Colleague_ID_From_Student__C is not null
and SGT.[Transfer__c] = '0'
AND a.[Name] not like 'SW%' 