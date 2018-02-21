if exists (select 1 from sys.objects where object_id = object_id('DaystoGoalMastery_get'))
   set noexec on
go
create procedure dbo.[DaystoGoalMastery_get] as
begin
   select 1 as [not yet implemented]
end
go
set noexec off
go

GRANT EXECUTE ON DaystoGoalMastery_get TO PUBLIC;

GO

alter proc [dbo].[DaystoGoalMastery_get] as

SELECT SGT.[SFDC_SGT_ID__c],SGT.Level_3_Mastery__c as 'Purple Path', SGT.[Transfer__c] ,p.[Colleague_Course_Program_Code__c],SGT.[Colleague_ID_From_Student__c], SGT.[Goal_Name__c],pg.[Program_Title__c],SGT.[Goal_Start_Date__c],SGT.Date_Mastered__c as 'Date Mastered',datediff (d,[Goal_Start_Date__c],SGT.Date_Mastered__c) 'Number of Days to Mastery'
FROM [Student_Goal_Transcript__c]SGT
inner join Program_Goal__c pg on pg.id = SGT.[Program_Goal__c]
left join  [Contact] c on c.[Colleague_ID__c]= SGT.[Colleague_ID_From_Student__c]
inner join [Program__c] p on p.[SFDC_Program_ID__c] = pg.[SFDC_Program_ID__c]
inner join Account A on a.Id = c.[AccountId]
                                                                                                                               
WHERE SGT.[Date_Mastered__c] is not null
AND SGT.[Goal_Start_Date__c] is not null
AND SGT.[Colleague_ID_From_Student__c] is not null 
And SGT.[Transfer__c] = '0'
AND a.[Name] not like 'SW%' 