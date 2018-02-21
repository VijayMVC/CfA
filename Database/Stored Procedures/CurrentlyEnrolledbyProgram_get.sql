if exists (select 1 from sys.objects where object_id = object_id('CurrentlyEnrolledbyProgram_get'))
   set noexec on
go
create procedure dbo.CurrentlyEnrolledbyProgram_get as
begin
   select 1 as [not yet implemented]
end
go
set noexec off
go

GRANT EXECUTE ON CurrentlyEnrolledbyProgram_get TO PUBLIC;

GO

alter proc [dbo].[CurrentlyEnrolledbyProgram_get] as

Select 
Case When c.[ASP_Program_Title__c] in ('Associate of Arts in General Studies', 'Associates - General Studies (MET)', 'Associate of Arts in General Studies with a Specialization in Business') then 'AA.GST' 
     when c.[ASP_Program_Title__c] = 'Associate of Arts in General Studies with a Specialization in Transforming the Customer Experience' then 'AA.GST.CUT'
     when c.[ASP_Program_Title__c] = 'Associate of Arts in Healthcare Management' then 'AA.HMA'
     when c.[ASP_Program_Title__c] = 'Bachelor of Arts in Communications, Concentration in Business' then 'BA.CMM.BU'
     when c.[ASP_Program_Title__c] = 'Bachelor of Arts in Communications, Concentration in Healthcare' then 'BA.CMM.HC'
     when c.[ASP_Program_Title__c] = 'Bachelor of Arts in Healthcare Management, Concentration in Communications' then 'BA.HMA.COM'
     when c.[ASP_Program_Title__c] = 'Bachelor of Arts in Healthcare Management, Concentration in Global Perspectives' then 'BA.HMA.GPE'
     when c.[ASP_Program_Title__c] = 'Bachelor of Arts in Management, Concentration in Insurance Services' then 'BA.MAN.ISE'
     when c.[ASP_Program_Title__c] = 'Bachelor of Arts in Management, Concentration in Logistics and Operations' then 'BA.MAN.LOP'
     when c.[ASP_Program_Title__c] = 'Bachelor of Arts in Management, Concentration in Public Administration' then 'BA.MAN.PAD'
     when c.[ASP_Program_Title__c] = 'Certificate in Healthcare Management Fundamentals' then 'CERT.HMF' End AS 'Program Title',
		count(c.[Colleague_ID__c]) 'Number of Currently Enrolled Students'
 FROM [dbo].[Contact] c
 LEFT JOIN [Account] a ON a.Id = c.[AccountId]
 Left Join [COCE-LSTNR,50333].AARDW.[AARPL].[BusinessEntity] BE ON BE.[ColleagueID]= c.[Colleague_ID__c]
 Left JOIN [COCE-LSTNR,50333].AARDW.[AARPL].[Person] P ON P.[Person_SK] = BE.[BusinessEntity_SK]
 WHERE a.[Name] not like 'SW%'
 AND c.Active_Student_Program_Status__c IN ('Enrolled' ,'Pending Grad Review')
 AND [Colleague_ID__c] is not null
 AND c.ASP_Start_Date__c <= (GETDATE())
GROUP BY 
Case When c.[ASP_Program_Title__c] in ('Associate of Arts in General Studies', 'Associates - General Studies (MET)', 'Associate of Arts in General Studies with a Specialization in Business') then 'AA.GST' 
     when c.[ASP_Program_Title__c] = 'Associate of Arts in General Studies with a Specialization in Transforming the Customer Experience' then 'AA.GST.CUT'
     when c.[ASP_Program_Title__c] = 'Associate of Arts in Healthcare Management' then 'AA.HMA'
     when c.[ASP_Program_Title__c] = 'Bachelor of Arts in Communications, Concentration in Business' then 'BA.CMM.BU'
     when c.[ASP_Program_Title__c] = 'Bachelor of Arts in Communications, Concentration in Healthcare' then 'BA.CMM.HC'
     when c.[ASP_Program_Title__c] = 'Bachelor of Arts in Healthcare Management, Concentration in Communications' then 'BA.HMA.COM'
     when c.[ASP_Program_Title__c] = 'Bachelor of Arts in Healthcare Management, Concentration in Global Perspectives' then 'BA.HMA.GPE'
     when c.[ASP_Program_Title__c] = 'Bachelor of Arts in Management, Concentration in Insurance Services' then 'BA.MAN.ISE'
     when c.[ASP_Program_Title__c] = 'Bachelor of Arts in Management, Concentration in Logistics and Operations' then 'BA.MAN.LOP'
     when c.[ASP_Program_Title__c] = 'Bachelor of Arts in Management, Concentration in Public Administration' then 'BA.MAN.PAD'
     when c.[ASP_Program_Title__c] = 'Certificate in Healthcare Management Fundamentals' then 'CERT.HMF' End 