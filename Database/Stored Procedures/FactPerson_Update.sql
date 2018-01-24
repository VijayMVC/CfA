if exists (select 1 from sys.objects where object_id = object_id('dbo.FactPerson_Update'))
   set noexec on
go
create procedure FactPerson_Update as
begin
   select 1 as [not yet implemented]
end
go
set noexec off
go

alter procedure [dbo].[FactPerson_Update] as

exec ETL_Log_Set @Operation = 'FactPerson_Lead_Update'
	exec FactPerson_Lead_Update;
exec ETL_Log_Set @Operation = 'FactPerson_Lead_Update'

exec ETL_Log_Set @Operation = 'FactPerson_Contact_Update'
	exec FactPerson_contact_update;	
exec ETL_Log_Set @Operation = 'FactPerson_Contact_Update'

exec ETL_Log_Set @Operation = 'FactPerson_User_Update'
	exec FactPerson_User_Update;
exec ETL_Log_Set @Operation = 'FactPerson_User_Update'

exec ETL_Log_Set @Operation = 'FactPerson_AARPL_Update'
	exec FactPerson_AARPL_Update;
exec ETL_Log_Set @Operation = 'FactPerson_AARPL_Update'
