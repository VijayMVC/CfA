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

GRANT EXECUTE ON PacebyProgram_get TO PUBLIC;

GO

alter proc [dbo].[PacebyProgram_get] as

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
COUNT(c.Years_to_complete_at_current_pace__c)/SUM(1./c.Years_to_complete_at_current_pace__c) Pace
FROM [dbo].[Contact] c
   LEFT JOIN [Account] a ON a.Id = c.[AccountId]
WHERE a.[Name] not like 'SW%'
AND c.Active_Student_Program_Status__c IN ('Enrolled' ,'Pending Grad Review')
AND [Colleague_ID__c] is not null
AND  c.ASP_Start_Date__c < DATEADD(M, -1, (GETDATE())) 
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