if exists (select 1 from sys.objects where object_id = object_id('FirstAttemptDuration_get')
   set noexec on
go
create procedure dbo.[FirstAttemptDuration_get] as
begin
   select 1 as [not yet implemented]
end
go
set noexec off
go

GRANT EXECUTE ON [FirstAttemptDuration_get] TO PUBLIC;

GO

alter proc [dbo].[FirstAttemptDuration_get] as


select p.Colleague_Course_Program_Code__c, sp.[Account__c], sp.id, pro.[Project_Name__c], sp.Date_Submitted__c, sph_s.CreatedDate 'Date Resource Viewed', sph_e.CreatedDate 'Date Submitted', pg.Path_Type__c 'Path', datediff(dd, sph_s.CreatedDate, sph_e.CreatedDate) 'DAYS to First Attempt'
from Student_Project__History sph_s
inner join Student_Project__History sph_e on sph_s.ParentID = sph_e.ParentID
                                                                       and sph_e.field = 'Date_Submitted__c'
left join Student_project__c sp on sp.id = sph_s.ParentID
left join Program_goal__c pg on sp.Program_goal__c = pg.id
left join Program__c p on pg.SFDC_Program_ID__c = p.id
left join Project__c pro on pro.id = sp.Project__c
where sph_s.field = 'Resource_Viewed__c'
and sp.[Account__c] not like 'SW%' 