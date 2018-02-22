-- Need to create Performance monitoring before adding these indexes.

DROP INDEX [IX_FactPerson_ContactColleague_ID__c_FirstProgramDegreeCode]				ON [CfA].[dbo].[FactPerson];
CREATE INDEX [IX_FactPerson_UserId]														ON [CfA].[dbo].[FactPerson] ([UserId]) INCLUDE ([Name]);
CREATE INDEX [IX_FactPerson_Name]														ON [CfA].[dbo].[FactPerson] ([Name]) INCLUDE ([UserId]);
CREATE INDEX [IX_FactPerson_ContactColleague_ID__c_FirstProgramDegreeCode]				ON [CfA].[dbo].[FactPerson] ([ContactColleague_ID__c] ASC,[FirstProgramDegreeCode] ASC) INCLUDE ([AccountId]);

DROP INDEX [IX_Student_Project__c_Date_Mastered__c]										ON [CfA].[dbo].[Student_Project__c]; 
DROP INDEX [IX_Student_Project__c_Date_Submitted__c]									ON [CfA].[dbo].[Student_Project__c];
DROP INDEX [IX_Student_Project__c_Program_Goal__c]										ON [CfA].[dbo].[Student_Project__c];
CREATE INDEX [IX_Student_Project__c_Program_Goal__c_Date_Mastered__c_Date_Submitted__c] ON [CfA].[dbo].[Student_Project__c] ([Program_Goal__c],[Date_Mastered__c], [Date_Submitted__c]) INCLUDE ([Student__c], [Project__c], [SFDC_Student_Project_ID__c], [Number_Submitted__c], [Id])
CREATE INDEX [IX_Student_Project__c_Date_Mastered__c_Date_Submitted__c]					ON [CfA].[dbo].[Student_Project__c] ([Date_Mastered__c], [Date_Submitted__c]) INCLUDE ([Student__c], [Project__c], [SFDC_Student_Project_ID__c], [Program_Goal__c], [Number_Submitted__c],	[studentId_projectId__c])
CREATE INDEX [IX_Student_Project__c_Date_Submitted__c]									ON [CfA].[dbo].[Student_Project__c] ([Date_Submitted__c]) INCLUDE ([Student__c], [Goal_ID__c], [Program_Goal__c])

DROP INDEX [IX_Contact_Colleague_ID__c]													ON [CfA].[dbo].[Contact]
CREATE INDEX [IX_Contact_AccountId_Colleague_ID__c]										ON [CfA].[dbo].[Contact] ([AccountId],[Colleague_ID__c]) INCLUDE ([Primary_Coach_Fullname_Text__c], [Previous_Advisor__c])
CREATE INDEX [IX_Contact_Colleague_ID__c]												ON [CfA].[dbo].[Contact] ([Colleague_ID__c]) INCLUDE ([AccountId], [Primary_Coach_Fullname_Text__c], [Previous_Advisor__c])
CREATE INDEX [IX_Contact_AccountId]														ON [CfA].[dbo].[Contact] ([AccountId]) INCLUDE ([Id], [Colleague_ID__c])

CREATE INDEX [IX_Academic_Plan__c_Student_Program__c]									ON [CfA].[dbo].[Academic_Plan__c] ([Student_Program__c]) INCLUDE ([AP_Completed_Date__c], [Intent_to_Enroll_Status__c], [Start_Term_Code__c], [Term_Start_Date__c], [Type__c], [Registered_Competencies__c], [Colleague_Student_ID__c])

CREATE INDEX [IX_lead_ConvertedContactId]												ON [CfA].[dbo].[lead] ([ConvertedContactId]) INCLUDE ([Id], [CreatedDate])

CREATE INDEX [IX_Event_EndDateTime]														ON [CfA].[dbo].[Event] ([EndDateTime]) INCLUDE ([WhatId], [Subject], [OwnerId], [Event_Status__c], [WhoId])

CREATE INDEX [IX_task_RecordTypeId_WhatId]												ON [CfA].[dbo].[task] ([RecordTypeId],[WhatId])
CREATE INDEX [IX_task_WhatId]															ON [CfA].[dbo].[task] ([WhatId]) INCLUDE ([RecordTypeId])

CREATE INDEX [IX_Student_Goal_Transcript__c_Student_Program__c]							ON [CfA].[dbo].[Student_Goal_Transcript__c] ([Student_Program__c]) INCLUDE ([Date_Mastered__c], [Goal__c], [Goal_Start_Date__c], [Program_Goal__c])

CREATE INDEX [IX_Student_Project__History_Field]										ON [CfA].[dbo].[Student_Project__History] ([Field]) INCLUDE ([CreatedDate], [ParentId])
CREATE INDEX [IX_Student_Project__History_ParentId_Field]								ON [CfA].[dbo].[Student_Project__History] ([ParentId], [Field]) INCLUDE ([CreatedDate])




