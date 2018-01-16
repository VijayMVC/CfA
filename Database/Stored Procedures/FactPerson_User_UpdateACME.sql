create procedure [dbo].[FactPerson_User_Update] as

update FactPerson
set UserID = u.id,
UserRoleID = u.UserRoleId,
UserManagerId = u.ManagerId,
UserCallCenterId = u.CallCenterId,
Username = u.Username,
UserType = u.UserType,
UserCreatedDate = u.CreatedDate,
UserCreatedById = u.CreatedById,
UserLastModifiedDate = u.LastModifiedDate,
UserLastModifiedById = u.LastModifiedById,
UserLastLoginDate = u.LastLoginDate
from [user] u
where u.ContactID = FactPerson.ContactID
and u.LastModifiedDate > (select max(UserLastModifiedDate) from FactPerson);
GO

