if exists (select 1 from sys.objects where object_id = object_id('DaystoProjectMastry'))
   set noexec on
go
create procedure dbo.[DaystoProjectMastry]  as
begin
   select 1 as [not yet implemented]
end
go
set noexec off
go

GRANT EXECUTE ON [DaystoProjectMastry]  TO PUBLIC;

GO

alter proc [dbo].[DaystoProjectMastry] as

select c.Colleague_Id__C,p.[Colleague_Course_Program_Code__c],sp.[Number_Submitted__c],sp.Date_Submitted__c,sp.Date_Mastered__c as 'Date Mastered', sp.[SFDC_Student_Project_ID__c],proj.[Project_Name__c],pg.[Path_Type__c] AS 'Path', pg.[Program_Title__c],datediff (d,sp.Date_Submitted__c,sp.Date_Mastered__c) 'Number of Days to Mastery'
from [Student_Project__c] sp
inner join [Program_Goal__c] pg on pg.id = sp.Program_Goal__C
inner join [Program__c] p on p.[SFDC_Program_ID__c] = pg.[SFDC_Program_ID__c]
inner join [Contact] c on c.id = sp.student__c
inner join Account A on a.Id = c.[AccountId]
inner join [Project__c] Proj on Proj.id = sp.[Project__c]
                                                                                              
where sp.Date_Mastered__c is not null
and sp.Date_Submitted__c is not null
and p.[Colleague_Course_Program_Code__c] is not null
and a.[Name] not like 'SW%'