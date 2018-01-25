CREATE INDEX [IX_FactPerson_ContactId_ContactActive_Student_Program__c]    ON [CfA].[dbo].[FactPerson] ([ContactId], [ContactActive_Student_Program__c]) INCLUDE ([Id]);
CREATE INDEX [IX_FactPerson_LeadId]										   ON [CfA].[dbo].[FactPerson] ([LeadId]) INCLUDE ([Id]);
CREATE INDEX [IX_FactPerson_ContactColleague_ID__c_FirstProgramDegreeCode] ON [CfA].[dbo].[FactPerson] ([ContactColleague_ID__c], [FirstProgramDegreeCode]) INCLUDE ([Id]);
CREATE INDEX [IX_FactPerson_FirstProgramDegreeCode]						   ON [CfA].[dbo].[FactPerson] ([FirstProgramDegreeCode]) INCLUDE ([Id], [ContactColleague_ID__c]);

CREATE INDEX [IX_task_CreatedDate_WhoId_Next_Steps__c] ON [CfA].[dbo].[task] ([CreatedDate], [WhoId], [Next_Steps__c]);
CREATE INDEX [IX_task_CallObject]					   ON [CfA].[dbo].[task] ([CallObject]) INCLUDE ([OwnerId], [CreatedDate], [WhoId]);

CREATE INDEX [IX_User_ContactId_CreatedDate] ON [CfA].[dbo].[User] ([ContactId],[CreatedDate]) INCLUDE ([Id], [LastName], [FirstName], [Name], [Email], [CreatedById], [LastModifiedDate], [LastModifiedById], [Username], [UserRoleId], [UserType], [ManagerId], [LastLoginDate], [CallCenterId]);
CREATE INDEX [IX_User_LastModifiedDate]		 ON [CfA].[dbo].[User] ([LastModifiedDate]) INCLUDE ([Id], [CreatedDate], [CreatedById], [LastModifiedById], [Username], [UserRoleId], [UserType], [ManagerId], [LastLoginDate], [ContactId], [CallCenterId]);

CREATE INDEX [IX_Student_Project__c_Date_Submitted__c]						 ON [CfA].[dbo].[Student_Project__c] ([Date_Submitted__c]) INCLUDE ([Student__c]);
CREATE INDEX [IX_Student_Project__c_Student__c_Date_Submitted__c]			 ON [CfA].[dbo].[Student_Project__c] ([Student__c],[Date_Submitted__c]);
CREATE INDEX [IX_Student_Project__c_Date_Mastered__c]						 ON [CfA].[dbo].[Student_Project__c] ([Date_Mastered__c]) INCLUDE ([Student__c], [studentId_projectId__c], [Number_Submitted__c]);

CREATE INDEX [IX_Student_Project_Action__c_Status_End__c]					 ON [CfA].[dbo].[Student_Project_Action__c] ([Status_End__c]) INCLUDE ([Student_Project__c]);
CREATE INDEX [IX_Student_Project_Action__c_Student_Project__c_Status_End__c] ON [CfA].[dbo].[Student_Project_Action__c] ([Student_Project__c], [Status_End__c]);

CREATE INDEX [IX_task_CreatedDate_WhoId_CallObject] ON [CfA].[dbo].[task] ([CreatedDate], [WhoId],[CallObject]) INCLUDE ([Description], [CallDisposition], [Call_Duration_in_Minutes__c]);
CREATE INDEX [IX_task_CallObject_desc]					ON [CfA].[dbo].[task] ([CallObject]) INCLUDE ([Description], [CreatedDate], [WhoId], [CallDisposition], [Call_Duration_in_Minutes__c]);

CREATE INDEX [IX_Contact_Colleague_ID__c] ON [CfA].[dbo].[Contact] ([Colleague_ID__c]);

