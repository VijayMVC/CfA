CREATE TABLE [Student_Project__History] (
    [Id] nvarchar(18),
    [CreatedDate] datetime,
    [CreatedById] nvarchar(18),
    [IsDeleted] bit,
    [ParentId] nvarchar(18),
    [Field] nvarchar(255),
    [OldValue] nvarchar(255),
    [NewValue] nvarchar(255)
)