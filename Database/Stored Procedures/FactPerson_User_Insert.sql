if exists (select 1 from sys.objects where object_id = object_id('dbo.FactPerson_User_Insert'))
   set noexec on
go
create procedure FactPerson_User_Insert as
begin
   select 1 as [not yet implemented]
end
go
set noexec off
go

alter procedure [dbo].[FactPerson_User_Insert] as

insert into FactPerson (UserID 
	  ,UserRoleID
	  ,UserManagerId
      ,UserCallCenterId
      ,Username
      ,UserType
	  ,UserCreatedDate
      ,UserCreatedById
      ,UserLastModifiedDate
      ,UserLastModifiedById
	  ,UserLastLoginDate
	  ,LastName
	  ,FirstName
	  ,Name
	  ,Email
	  )
select u.id, 
	   u.UserRoleId
      ,u.ManagerId
      ,u.CallCenterId
      ,u.Username
      ,u.UserType
	  ,u.CreatedDate
      ,u.CreatedById
      ,u.LastModifiedDate
      ,u.LastModifiedById
	  ,u.LastLoginDate
	  ,u.LastName
	  ,u.FirstName
	  ,u.Name
	  ,u.Email
from [user] u
left join FactPerson fp on u.ContactID = fp.ContactID
where u.ContactID is null
and u.CreatedDate > (select max(UserCreatedDate) from FactPerson)


GO

