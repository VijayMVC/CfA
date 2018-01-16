CREATE TABLE [dbo].[OpportunityHistory](
	[Id] [nvarchar](18) NULL,
	[IsDeleted] [bit] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedById] [nvarchar](18) NULL,
	[SystemModstamp] [datetime] NULL,
	[StageName] [nvarchar](40) NULL,
	[Amount] [float] NULL,
	[Probability] [float] NULL,
	[CloseDate] [date] NULL,
	[ForecastCategory] [nvarchar](40) NULL,
	[OpportunityId] [nvarchar](18) NULL,
	[ExpectedRevenue] [float] NULL
) ON [PRIMARY]
GO

