if exists (select 1 from sys.objects where object_id = object_id('dbo.FactPerson_lead_insert'))
   set noexec on
go
create procedure FactPerson_lead_insert as
begin
   select 1 as [not yet implemented]
end
go
set noexec off
go

alter procedure [dbo].[FactPerson_lead_insert] as

insert into FactPerson 
(LeadId, 
AccountId,
ContactID,
Address,
City,
Company,
ConvertedDate,
Country,
CountryCode,
Email,
FirstName,
LastName,
Industry,
Lead_Source_Detail__c,
LeadAdditional_Educational_Interest__c,
LeadAlternate_Email__c,
LeadAttended_In_Person_Info_Session__c,
LeadCompleted_OCPP__c,
LeadConvertedOpportunityId,
LeadCreatedById,
LeadCreatedDate,
LeadDate_of_Info_Session__c,
LeadDate_Set_to_Survey_Completed__c,
LeadDate_Status_to_Info_Session_Attended__c,
LeadDate_Status_to_Info_Session_Registered__c,
LeadDescription,
LeadEducation_Level__c,
LeadGeneral_Type__c,
LeadHow_did_you_hear_about_CfA__c,
LeadLastModifiedById,
LeadLastModifiedDate,
LeadMasterRecordId,
LeadOwnerId,
LeadRating,
LeadRecordTypeId,
LeadStatus,
LeadSucessfully_completed_online_course__c,
LeadSuspect_Type__c,
Leadurl_code_leads__c,
LeadWatched_Info_Session__c)
select l.id,
l.ConvertedAccountId,
l.ConvertedContactID,
l.Address,
l.City,
l.Company,
l.ConvertedDate,
l.Country,
l.CountryCode,
l.Email,
l.FirstName,
l.LastName,
l.Industry,
l.Lead_Source_Detail__c,
l.Additional_Educational_Interest__c,
l.Alternate_Email__c,
l.Attended_In_Person_Info_Session__c,
l.Completed_OCPP__c,
l.ConvertedOpportunityId,
l.CreatedById,
l.CreatedDate,
l.Date_of_Info_Session__c,
l.Date_Set_to_Survey_Completed__c,
l.Date_Status_to_Info_Session_Attended__c,
l.Date_Status_to_Info_Session_Registered__c,
l.Description,
l.Education_Level__c,
l.General_Type__c,
l.How_did_you_hear_about_CfA__c,
l.LastModifiedById,
l.LastModifiedDate,
l.MasterRecordId ,
l.OwnerId,
l.Rating ,
l.RecordTypeId,
l.Status,
l.Sucessfully_completed_online_course__c,
l.Suspect_Type__c,
l.url_code_leads__c,
l.Watched_Info_Session__c
from lead l
left join FactPerson fp on fp.LeadID = l.id
where fp.LeadId is null
and l.CreatedDate > (select max(LeadCreatedDate) from FactPerson)
GO

