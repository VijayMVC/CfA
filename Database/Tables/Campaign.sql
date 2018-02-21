CREATE TABLE [dbo].[Campaign] (
    [Id] nvarchar(18),
    [Name] nvarchar(121),
    [CreatedDate] datetime,
    [CreatedById] nvarchar(18),
    [LastModifiedDate] datetime,
    [LastModifiedById] nvarchar(18),
    [SystemModstamp] datetime,
    [LastViewedDate] datetime,
    [LastReferencedDate] datetime,
    [IsActive] bit,
    [IsDeleted] bit,
    [ParentId] nvarchar(18),
    [Type] nvarchar(40),
    [RecordTypeId] nvarchar(18),
    [Status] nvarchar(40),
    [StartDate] date,
    [EndDate] date,
    [ExpectedRevenue] float,
    [BudgetedCost] float,
    [ActualCost] float,
    [ExpectedResponse] float,
    [NumberSent] float,
    [Description] nvarchar(max),
    [NumberOfLeads] int,
    [NumberOfConvertedLeads] int,
    [NumberOfContacts] int,
    [NumberOfResponses] int,
    [NumberOfOpportunities] int,
    [NumberOfWonOpportunities] int,
    [AmountAllOpportunities] float,
    [AmountWonOpportunities] float,
    [OwnerId] nvarchar(18),
    [LastActivityDate] date,
    [CampaignMemberRecordTypeId] nvarchar(18),
    [Shipping_State__c] nvarchar(255),
    [City__c] nvarchar(255),
    [Primary_Attendee__c] nvarchar(18),
    [Conference_Notes__c] nvarchar(1000),
    [Industry__c] nvarchar(255),
    [Audience_Roles__c] nvarchar(255),
    [Audience_Levels__c] nvarchar(255),
    [Number_of_Attendees__c] float,
    [Cost_to_Exhibit__c] float,
    [Cost_to_Present__c] float,
    [Attendee_Passes_Included__c] float,
    [Cost_for_Addl_Attendees__c] float,
    [Location_and_Travel_Info__c] nvarchar(max),
    [Total_Conference_Cost__c] float,
    [Presentation_App_Due_Date__c] date,
    [Game_Plan__c] nvarchar(max),
    [Materials__c] nvarchar(max),
    [Shipping_Address__c] nvarchar(255),
    [Shipping_City__c] nvarchar(255),
    [Shipping_Zip_Code__c] nvarchar(10),
    [Shipping_Date__c] date,
    [Five9__Five9CallNow__c] bit,
    [Other_Marketing_Benefit__c] nvarchar(255),
    [Presentation_Due_Date__c] date,
    [Other_Materials_Due_Date__c] date,
    [Five9__Five9Endpoint__c] nvarchar(255),
    [Five9__Five9Password__c] nvarchar(50),
    [New_Contact_Goals__c] float,
    [Actual_Contacts__c] float,
    [Cost_for_Travel__c] float,
    [Other_Costs__c] float,
    [Post_conference_Notes__c] nvarchar(max),
    [Early_Bird_Registration__c] date,
    [Registration_Complete__c] bit,
    [Shipping_Complete__c] bit,
    [Presentation_App_Complete__c] bit,
    [Presentation_Complete__c] bit,
    [Other_Materials_Complete__c] bit,
    [Presentation_Available__c] bit,
    [Secondary_Attendee__c] nvarchar(18),
    [Alternate_Attendee__c] nvarchar(18),
    [Five9__Five9ReportEmail__c] nvarchar(80),
    [Five9__Five9User__c] nvarchar(50),
    [Five9__Five9list__c] nvarchar(50),
    [Campaign_Identifier__c] nvarchar(60)
 CONSTRAINT [Campaign_PK] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
