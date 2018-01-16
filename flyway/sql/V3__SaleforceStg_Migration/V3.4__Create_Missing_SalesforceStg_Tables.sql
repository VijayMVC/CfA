create table [Academic_Plan] (  [Id] varchar(18)  NOT NULL ,   [IsDeleted] bit  NULL ,   [Name] varchar(80)  NULL ,   [CreatedDate] datetime2  NULL ,   [CreatedById] varchar(18)  NULL ,   [LastModifiedDate] datetime2  NULL ,   [LastModifiedById] varchar(18)  NULL ,   [SystemModstamp] datetime2  NULL ,   [LastActivityDate] datetime2  NULL ,   [ConnectionReceivedId] varchar(18)  NULL ,   [ConnectionSentId] varchar(18)  NULL ,   [Student__c] varchar(18)  NULL ,   [AP_Completed_Date__c] datetime2  NULL ,   [AP_Submission_Status__c] varchar(255)  NULL ,   [Days_Since_Term_Start__c] numeric  NULL ,   [Days_Since__c] numeric  NULL ,   [Intent_to_Enroll_Last_Submitted__c] datetime2  NULL ,   [Intent_to_Enroll_Status__c] varchar(255)  NULL ,   [Start_Term_Code__c] varchar(1300)  NULL ,   [Student_Program__c] varchar(18)  NULL ,   [Term_Start_Date__c] datetime2  NULL ,   [Term__c] numeric  NULL ,   [Type__c] varchar(255)  NULL ,   [Registered_Competencies__c] numeric  NULL ,   [Total_Competencies__c] numeric  NULL ,   [Account_Name__c] varchar(1300)  NULL ,   [Colleague_Student_ID__c] varchar(1300)  NULL ,   [Student_Colleague_Start_Term_Code__c] varchar(1300)  NULL ,   [Closed__c] bit  NULL ,   [Allow_Adds__c] bit  NULL ,   [Program_Title__c] varchar(1300)  NULL ,   [Student_Program_Term__c] varchar(18)  NULL ,   [DWCreated] datetime2  NULL ,   [DWEffectiveStart] datetime2  NOT NULL ,   [DWEffectiveEnd] datetime2  NOT NULL ,   [RowHash] nvarchar(64)  NULL , )
ALTER TABLE Academic_Plan ADD CONSTRAINT PK_Academic_Plan__c_SK PRIMARY KEY  ([Id]);

create table [Competency] (  [Id] varchar(18)  NOT NULL ,   [OwnerId] varchar(18)  NULL ,   [IsDeleted] bit  NULL ,   [Name] varchar(80)  NULL ,   [CreatedDate] datetime2  NULL ,   [CreatedById] varchar(18)  NULL ,   [LastModifiedDate] datetime2  NULL ,   [LastModifiedById] varchar(18)  NULL ,   [SystemModstamp] datetime2  NULL ,   [LastActivityDate] datetime2  NULL ,   [LastViewedDate] datetime2  NULL ,   [LastReferencedDate] datetime2  NULL ,   [ConnectionReceivedId] varchar(18)  NULL ,   [ConnectionSentId] varchar(18)  NULL ,   [Cluster__c] varchar(18)  NULL ,   [Description__c] varchar(255)  NULL ,   [Competency_Id__c] varchar(1300)  NULL ,   [Legacy_Id__c] varchar(20)  NULL ,   [Source_1__c] varchar(18)  NULL ,   [Competency_Count__c] numeric  NULL ,   [SFDC_Competency_ID__c] varchar(1300)  NULL ,   [Cluster_Name__c] varchar(1300)  NULL ,   [Colleague_Course_ID__c] varchar(10)  NULL ,   [Colleague_Course_Short_Title__c] varchar(50)  NULL ,   [Colleague_Course_Key__c] varchar(1300)  NULL ,   [Competency_Notes__c] varchar(MAX)  NULL ,   [Colleague_CfA_Course_Code__c] varchar(20)  NULL ,   [Academic_Level__c] varchar(255)  NULL ,   [DWCreated] datetime2  NULL ,   [DWEffectiveStart] datetime2  NOT NULL ,   [DWEffectiveEnd] datetime2  NOT NULL ,   [RowHash] nvarchar(64)  NULL , )
ALTER TABLE Competency ADD CONSTRAINT PK_Competency__c_SK PRIMARY KEY  ([Id]);

create table [RecordType] (  [Id] varchar(18)  NOT NULL ,   [Name] varchar(80)  NULL ,   [DeveloperName] varchar(80)  NULL ,   [NamespacePrefix] varchar(15)  NULL ,   [Description] varchar(255)  NULL ,   [BusinessProcessId] varchar(18)  NULL ,   [SobjectType] varchar(40)  NULL ,   [IsActive] bit  NULL ,   [CreatedById] varchar(18)  NULL ,   [CreatedDate] datetime2  NULL ,   [LastModifiedById] varchar(18)  NULL ,   [LastModifiedDate] datetime2  NULL ,   [SystemModstamp] datetime2  NULL ,   [DWCreated] datetime2  NULL ,   [DWEffectiveStart] datetime2  NOT NULL ,   [DWEffectiveEnd] datetime2  NOT NULL ,   [RowHash] nvarchar(64)  NULL , )
ALTER TABLE RecordType ADD CONSTRAINT PK_RecordType_SK PRIMARY KEY  ([Id]);

create table [Student_Competency_Transcript] (  [Id] varchar(18)  NOT NULL ,   [Account_Name__c] varchar(1300)  NULL ,   [Date_Mastered__c] datetime2  NULL ,   [Colleague_ID_From_Student__c] varchar(1300)  NULL ,   [Colleague_Term_Code__c] varchar(1300)  NULL ,   [Student_Status__c] varchar(1300)  NULL ,   [Last_Academic_Activity_Date__c] datetime2  NULL ,   [DWCreated] datetime2  NULL ,   [DWEffectiveStart] datetime2  NOT NULL ,   [DWEffectiveEnd] datetime2  NOT NULL ,   [RowHash] nvarchar(64)  NULL , )
ALTER TABLE Student_Competency_Transcript ADD CONSTRAINT PK_Student_Competency_Transcript__c_SK PRIMARY KEY  ([Id]);

create table [Student_Goal_Term] (  [Id] varchar(18)  NOT NULL ,   [IsDeleted] bit  NULL ,   [Name] varchar(80)  NULL ,   [CreatedDate] datetime2  NULL ,   [CreatedById] varchar(18)  NULL ,   [LastModifiedDate] datetime2  NULL ,   [LastModifiedById] varchar(18)  NULL ,   [SystemModstamp] datetime2  NULL ,   [LastActivityDate] datetime2  NULL ,   [LastViewedDate] datetime2  NULL ,   [LastReferencedDate] datetime2  NULL ,   [ConnectionReceivedId] varchar(18)  NULL ,   [ConnectionSentId] varchar(18)  NULL ,   [Student_Goal_Transcript__c] varchar(18)  NULL ,   [Student_Program_Term__c] varchar(18)  NULL ,   [Colleague_Term_Code__c] varchar(1300)  NULL ,   [Competencies_Dropped__c] numeric  NULL ,   [Competencies_Mastered__c] numeric  NULL ,   [Competencies_Not_Mastered__c] numeric  NULL ,   [Competencies_Previously_Mastered__c] numeric  NULL ,   [Competencies_Registered__c] numeric  NULL ,   [Competencies_Remaining__c] numeric  NULL ,   [Competencies_Started__c] numeric  NULL ,   [Date_Mastered__c] datetime2  NULL ,   [Goal_Competency_Total__c] numeric  NULL ,   [Goal_Name__c] varchar(1300)  NULL ,   [Goal_Start_Date__c] datetime2  NULL ,   [Goal__c] varchar(18)  NULL ,   [Is_Mastered_In_Term__c] bit  NULL ,   [Is_Started_In_Term__c] bit  NULL ,   [Last_Academic_Activity_Date__c] datetime2  NULL ,   [Level_3_Mastery__c] bit  NULL ,   [Program_Title__c] varchar(1300)  NULL ,   [Status__c] varchar(255)  NULL ,   [Student_Program__c] varchar(18)  NULL ,   [Student__c] varchar(18)  NULL ,   [Term_End_Date__c] datetime2  NULL ,   [Term_Start_Date__c] datetime2  NULL ,   [Term_Status__c] varchar(1300)  NULL ,   [Unique_Id__c] varchar(46)  NULL ,   [DWCreated] datetime2  NULL ,   [DWEffectiveStart] datetime2  NOT NULL ,   [DWEffectiveEnd] datetime2  NOT NULL ,   [RowHash] nvarchar(64)  NULL , )
ALTER TABLE Student_Goal_Term ADD CONSTRAINT PK_Student_Goal_Term__c_SK PRIMARY KEY  ([Id]);

create table [Student_Goal_Transcript] (  [Id] varchar(18)  NOT NULL ,   [OwnerId] varchar(18)  NULL ,   [IsDeleted] bit  NULL ,   [Name] varchar(80)  NULL ,   [CreatedDate] datetime2  NULL ,   [CreatedById] varchar(18)  NULL ,   [LastModifiedDate] datetime2  NULL ,   [LastModifiedById] varchar(18)  NULL ,   [SystemModstamp] datetime2  NULL ,   [LastActivityDate] datetime2  NULL ,   [LastViewedDate] datetime2  NULL ,   [LastReferencedDate] datetime2  NULL ,   [ConnectionReceivedId] varchar(18)  NULL ,   [ConnectionSentId] varchar(18)  NULL ,   [Competency_Current__c] numeric  NULL ,   [Competency_Total__c] numeric  NULL ,   [Date_Mastered__c] datetime2  NULL ,   [Goal__c] varchar(18)  NULL ,   [Goal_Name__c] varchar(1300)  NULL ,   [Goal_Start_Date__c] datetime2  NULL ,   [Level_3_Mastery__c] bit  NULL ,   [Student__c] varchar(18)  NULL ,   [Student_Goal_Transcript_Unique_ID__c] varchar(40)  NULL ,   [Complete__c] numeric  NULL ,   [Goal_Prefix__c] varchar(1300)  NULL ,   [Locked__c] bit  NULL ,   [Student_Goal_Transcript_Count__c] numeric  NULL ,   [Is_Mastered_Formula__c] varchar(1300)  NULL ,   [Mastered_Count__c] numeric  NULL ,   [SFDC_SGT_ID__c] varchar(1300)  NULL ,   [Goal_Prefix_with_Two_Digits__c] numeric  NULL ,   [Program_Goal__c] varchar(18)  NULL ,   [Suggested_Grouping__c] numeric  NULL ,   [SFDC_Program_GoalID__c] varchar(1300)  NULL ,   [Student_Pilot_to_Pay_Confirmed__c] bit  NULL ,   [Student_Partner__c] varchar(1300)  NULL ,   [Student_CfA_Start_Date__c] datetime2  NULL ,   [Student_Current_Program__c] varchar(1300)  NULL ,   [X_PGRT__c] varchar(1300)  NULL ,   [Colleague_Course_Name__c] varchar(1300)  NULL ,   [Colleague_Course_Section_ID__c] varchar(25)  NULL ,   [Colleague_Student_Academic_Cred_ID__c] varchar(25)  NULL ,   [Colleague_Full_Section_Name__c] varchar(15)  NULL ,   [Transfer__c] bit  NULL ,   [Program_Title__c] varchar(1300)  NULL ,   [SNTS_Date__c] datetime2  NULL ,   [Financial_Aid__c] bit  NULL ,   [ReEnrollment_SCT_Report__c] varchar(1300)  NULL ,   [Student_Status__c] varchar(1300)  NULL ,   [Student_Desired_Degree_Title__c] varchar(1300)  NULL ,   [Student_Account_Name__c] varchar(1300)  NULL ,   [SFDC_GoalID__c] varchar(1300)  NULL ,   [STGR_Colleague_Colleague_Course_Section__c] varchar(25)  NULL ,   [STGR_Colleague_Colleague_Grade__c] varchar(5)  NULL ,   [STGR_Colleague_Colleague_Start_Term_Code__c] varchar(7)  NULL ,   [STGR_Colleague_Colleague_STC_Status__c] varchar(5)  NULL ,   [StudentID_Concat_ColleagueCourseID__c] varchar(25)  NULL ,   [Update_StudentID_Contact_Course_ID__c] bit  NULL ,   [Colleague_ID_From_Student__c] varchar(1300)  NULL ,   [Suggested_Term__c] numeric  NULL ,   [Active_Term_Start_Date__c] datetime2  NULL ,   [Active_Term__c] varchar(18)  NULL ,   [All_Competencies_Started__c] bit  NULL ,   [Competencies_Started__c] numeric  NULL ,   [Is_In_Current_Academic_Plan__c] bit  NULL ,   [Is_Mastered__c] bit  NULL ,   [Is_Started__c] bit  NULL ,   [Last_Academic_Activity_Date__c] datetime2  NULL ,   [Mastered_Term__c] varchar(18)  NULL ,   [Prerequisites_Met__c] bit  NULL ,   [Started_Term__c] varchar(18)  NULL ,   [Status__c] varchar(1300)  NULL ,   [Student_Program__c] varchar(18)  NULL ,   [Transferred_From__c] varchar(18)  NULL ,   [Waive_Prerequisites__c] bit  NULL ,   [DWCreated] datetime2  NULL ,   [DWEffectiveStart] datetime2  NOT NULL ,   [DWEffectiveEnd] datetime2  NOT NULL ,   [RowHash] nvarchar(64)  NULL , )
ALTER TABLE Student_Goal_Transcript ADD CONSTRAINT PK_Student_Goal_Transcript__c_SK PRIMARY KEY  ([Id]);

create table [Student_Program] (  [Id] varchar(18)  NOT NULL ,   [IsDeleted] bit  NULL ,   [Name] varchar(80)  NULL ,   [CreatedDate] datetime2  NULL ,   [CreatedById] varchar(18)  NULL ,   [LastModifiedDate] datetime2  NULL ,   [LastModifiedById] varchar(18)  NULL ,   [SystemModstamp] datetime2  NULL ,   [LastActivityDate] datetime2  NULL ,   [LastViewedDate] datetime2  NULL ,   [LastReferencedDate] datetime2  NULL ,   [ConnectionReceivedId] varchar(18)  NULL ,   [ConnectionSentId] varchar(18)  NULL ,   [Competencies_Mastered__c] numeric  NULL ,   [End_Date__c] datetime2  NULL ,   [Program__c] varchar(18)  NULL ,   [Program_Competency__c] numeric  NULL ,   [Created_by_Admissions_Portal__c] bit  NULL ,   [Percentage_Complete__c] numeric  NULL ,   [Program_Prior__c] varchar(18)  NULL ,   [Start_Date__c] datetime2  NULL ,   [Status__c] varchar(255)  NULL ,   [Student__c] varchar(18)  NULL ,   [Student_Program_UniqueID__c] varchar(37)  NULL ,   [AA_Transfer_Status__c] varchar(255)  NULL ,   [Program_Next__c] varchar(18)  NULL ,   [SFDC_Student_Program_ID__c] varchar(1300)  NULL ,   [SFDC_Student_ID__c] varchar(1300)  NULL ,   [SFDC_Program_ID__c] varchar(1300)  NULL ,   [Program_Title__c] varchar(1300)  NULL ,   [SFDC_PP_StudentProgramID__c] varchar(1300)  NULL ,   [Program_Enrolled_Trigger_Fired__c] datetime2  NULL ,   [Student_Status__c] varchar(1300)  NULL ,   [Had_Restart__c] bit  NULL ,   [Decline_Reason__c] varchar(255)  NULL ,   [Credit_Amount__c] numeric  NULL ,   [Days_in_Current_Program__c] numeric  NULL ,   [Active_Term_Start_Date__c] datetime2  NULL ,   [Years_to_Complete_at_Current_Pace__c] numeric  NULL ,   [Admissions_Forms_Completed__c] bit  NULL ,   [Graduation_Date__c] datetime2  NULL ,   [Degree_Type__c] varchar(1300)  NULL ,   [Active_Term_Status__c] varchar(1300)  NULL ,   [Active_Term__c] varchar(18)  NULL ,   [Competencies_Started__c] numeric  NULL ,   [Current_Academic_Plan__c] varchar(18)  NULL ,   [Degree_Start_Date__c] datetime2  NULL ,   [Exit_Survey_Received_Date__c] datetime2  NULL ,   [Exit_Survey_Received__c] bit  NULL ,   [Goals_Mastered__c] numeric  NULL ,   [Goals_Started__c] numeric  NULL ,   [Is_Academic_Plan_Pending__c] bit  NULL ,   [Is_First_Term__c] bit  NULL ,   [Is_Lms_Initialized__c] bit  NULL ,   [Is_Program_Started__c] bit  NULL ,   [Is_Readmission__c] bit  NULL ,   [Last_Academic_Activity_Date__c] datetime2  NULL ,   [Leave_Reason_Other__c] varchar(2500)  NULL ,   [Leave_Reason__c] varchar(255)  NULL ,   [Next_Term_Start_Date__c] datetime2  NULL ,   [Original_Degree_Start_Date__c] datetime2  NULL ,   [Original_Start_Date__c] datetime2  NULL ,   [Program_Changed_From_Title__c] varchar(1300)  NULL ,   [Program_Changed_From__c] varchar(18)  NULL ,   [Program_Changed_To_Title__c] varchar(1300)  NULL ,   [Program_Changed_To__c] varchar(18)  NULL ,   [Program_Goals__c] numeric  NULL ,   [Program_Next_Status__c] varchar(1300)  NULL ,   [Program_Prior_Active_Term_Start_Date__c] datetime2  NULL ,   [Program_Prior_Status__c] varchar(1300)  NULL ,   [Readmission_Date__c] datetime2  NULL ,   [Student_Withdraw_Option__c] varchar(255)  NULL ,   [Student_Withdrawl_Type__c] varchar(255)  NULL ,   [Welcome_Call__c] bit  NULL ,   [Account__c] varchar(1300)  NULL ,   [DWCreated] datetime2  NULL ,   [DWEffectiveStart] datetime2  NOT NULL ,   [DWEffectiveEnd] datetime2  NOT NULL ,   [RowHash] nvarchar(64)  NULL , )
ALTER TABLE Student_Program ADD CONSTRAINT PK_Student_Program__c_SK PRIMARY KEY  ([Id]);

create table [Student_Program_Term] (  [Id] varchar(18)  NOT NULL ,   [OwnerId] varchar(18)  NULL ,   [IsDeleted] bit  NULL ,   [Name] varchar(80)  NULL ,   [CreatedDate] datetime2  NULL ,   [CreatedById] varchar(18)  NULL ,   [LastModifiedDate] datetime2  NULL ,   [LastModifiedById] varchar(18)  NULL ,   [SystemModstamp] datetime2  NULL ,   [LastActivityDate] datetime2  NULL ,   [LastViewedDate] datetime2  NULL ,   [LastReferencedDate] datetime2  NULL ,   [ConnectionReceivedId] varchar(18)  NULL ,   [ConnectionSentId] varchar(18)  NULL ,   [Colleague_Term_Code__c] varchar(7)  NULL ,   [Current_Academic_Plan__c] varchar(18)  NULL ,   [End_Date__c] datetime2  NULL ,   [Is_Academic_Plan_Pending__c] bit  NULL ,   [Is_First_Term__c] bit  NULL ,   [Is_Trial_Period_Complete__c] bit  NULL ,   [Program_Term_Start_Date__c] datetime2  NULL ,   [Program_Title__c] varchar(1300)  NULL ,   [Program__c] varchar(18)  NULL ,   [Start_Date__c] datetime2  NULL ,   [Status__c] varchar(255)  NULL ,   [Student_Program__c] varchar(18)  NULL ,   [Student__c] varchar(18)  NULL ,   [Unique_Id__c] varchar(46)  NULL ,   [Competencies_Mastered__c] numeric  NULL ,   [Competencies_Registered__c] numeric  NULL ,   [Competencies_Started__c] numeric  NULL ,   [Goals_Mastered__c] numeric  NULL ,   [Goals_Registered__c] numeric  NULL ,   [Goals_Started__c] numeric  NULL ,   [Last_Academic_Activity_Date__c] datetime2  NULL ,   [On_Scholastic_Standing_Warning__c] bit  NULL ,   [DWCreated] datetime2  NULL ,   [DWEffectiveStart] datetime2  NOT NULL ,   [DWEffectiveEnd] datetime2  NOT NULL ,   [RowHash] nvarchar(64)  NULL , )
ALTER TABLE Student_Program_Term ADD CONSTRAINT PK_Student_Program_Term__c_SK PRIMARY KEY  ([Id]);

create table [Student_Project_Rubric] (  [Id] varchar(18)  NOT NULL ,   [IsDeleted] bit  NULL ,   [Name] varchar(255)  NULL ,   [CreatedDate] datetime2  NULL ,   [CreatedById] varchar(18)  NULL ,   [LastModifiedDate] datetime2  NULL ,   [LastModifiedById] varchar(18)  NULL ,   [SystemModstamp] datetime2  NULL ,   [LastActivityDate] datetime2  NULL ,   [LastViewedDate] datetime2  NULL ,   [LastReferencedDate] datetime2  NULL ,   [ConnectionReceivedId] varchar(18)  NULL ,   [ConnectionSentId] varchar(18)  NULL ,   [Criteria__c] varchar(MAX)  NULL ,   [Date_Mastered__c] datetime2  NULL ,   [Description__c] varchar(MAX)  NULL ,   [Mastered__c] varchar(255)  NULL ,   [Rubric__c] varchar(18)  NULL ,   [Student__c] varchar(18)  NULL ,   [Student_Project__c] varchar(18)  NULL ,   [Student_Project_Rubric_UniqueID__c] varchar(58)  NULL ,   [Temp_Mastered__c] varchar(255)  NULL ,   [Sequence_Number__c] numeric  NULL ,   [Team__c] bit  NULL ,   [Project_Goal__c] varchar(1300)  NULL ,   [AutoReview__c] bit  NULL ,   [Project_Name__c] varchar(1300)  NULL ,   [Student_Project_Status__c] varchar(1300)  NULL ,   [Project_Path_Color__c] varchar(1300)  NULL ,   [SFDC_SPR_ID__c] varchar(1300)  NULL ,   [SFDC_Student_ID__c] varchar(1300)  NULL ,   [SFDC_Rubric_ID__c] varchar(1300)  NULL ,   [SFDC_Student_Project_ID__c] varchar(1300)  NULL ,   [Mastered_Submission_Number__c] numeric  NULL ,   [Time_To_Mastery__c] numeric  NULL ,   [DWCreated] datetime2  NULL ,   [DWEffectiveStart] datetime2  NOT NULL ,   [DWEffectiveEnd] datetime2  NOT NULL ,   [RowHash] nvarchar(64)  NULL , )
ALTER TABLE Student_Project_Rubric ADD CONSTRAINT PK_Student_Project_Rubric__c_SK PRIMARY KEY  ([Id]);