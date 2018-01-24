if exists (select 1 from sys.objects where object_id = object_id('dbo.FactPerson_insert'))
   set noexec on
go
create procedure FactPerson_insert as
begin
   select 1 as [not yet implemented]
end
go
set noexec off
go

alter procedure [dbo].[FactPerson_insert] as

exec ETL_Log_Set @Operation = 'FactPerson_Lead_Insert'
	exec FactPerson_Lead_Insert;
exec ETL_Log_Set @Operation = 'FactPerson_Lead_Insert'

exec ETL_Log_Set @Operation = 'FactPerson_Contact_Insert'
	exec FactPerson_Contact_Insert;	
exec ETL_Log_Set @Operation = 'FactPerson_Contact_Insert'

exec ETL_Log_Set @Operation = 'FactPerson_User_Insert'
	exec FactPerson_User_Insert;
exec ETL_Log_Set @Operation = 'FactPerson_User_Insert'