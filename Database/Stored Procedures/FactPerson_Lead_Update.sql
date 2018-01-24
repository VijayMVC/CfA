if exists (select 1 from sys.objects where object_id = object_id('dbo.FactPerson_lead_update'))
   set noexec on
go
create procedure FactPerson_lead_update as
begin
   select 1 as [not yet implemented]
end
go
set noexec off
go

alter procedure [dbo].[FactPerson_lead_update] as

update FactPerson 		
set LeadId = l.id,
AccountId = l.ConvertedAccountId,
ContactID = l.ConvertedContactID,
Address = l.Address,
City = l.City,
Company = l.Company,
ConvertedDate = l.ConvertedDate,
Country = l.Country,
CountryCode = l.CountryCode,
Email = l.Email,
FirstName = l.FirstName,
LastName = l.LastName,
Industry = l.Industry,
Lead_Source_Detail__c = l.Lead_Source_Detail__c,
LeadAdditional_Educational_Interest__c = l.Additional_Educational_Interest__c,
LeadAlternate_Email__c = l.Alternate_Email__c,
LeadAttended_In_Person_Info_Session__c = l.Attended_In_Person_Info_Session__c,
LeadCompleted_OCPP__c = l.Completed_OCPP__c,
LeadConvertedOpportunityId = l.ConvertedOpportunityId,
LeadCreatedById = l.CreatedById,
LeadCreatedDate = l.CreatedDate,
LeadDate_of_Info_Session__c = l.Date_of_Info_Session__c,
LeadDate_Set_to_Survey_Completed__c = l.Date_Set_to_Survey_Completed__c,
LeadDate_Status_to_Info_Session_Attended__c = l.Date_Status_to_Info_Session_Attended__c,
LeadDate_Status_to_Info_Session_Registered__c = l.Date_Status_to_Info_Session_Registered__c,
LeadDescription = l.Description,
LeadEducation_Level__c = l.Education_Level__c,
LeadGeneral_Type__c = l.General_Type__c,
LeadHow_did_you_hear_about_CfA__c = l.How_did_you_hear_about_CfA__c,
LeadLastModifiedById = l.LastModifiedById,
LeadLastModifiedDate = l.LastModifiedDate,
LeadMasterRecordId = l.MasterRecordId ,
LeadOwnerId = l.OwnerId,
LeadRating = l.Rating ,
LeadRecordTypeId = l.RecordTypeId,
LeadStatus = l.Status,
LeadSucessfully_completed_online_course__c = l.Sucessfully_completed_online_course__c,
LeadSuspect_Type__c = l.Suspect_Type__c,
Leadurl_code_leads__c = l.url_code_leads__c,
LeadWatched_Info_Session__c	=	l.Watched_Info_Session__c
from lead l		
where FactPerson.LeadID = l.id		
and LastModifiedDate > (select max(LeadLastModifiedDate) from FactPerson)
GO

