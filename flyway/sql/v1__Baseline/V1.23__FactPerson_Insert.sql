create procedure [dbo].[FactPerson_insert] as

exec ETL_Log_Set @Operation = 'FactPerson_Lead_Insert'
	exec FactPerson_Lead_Insert;
exec ETL_Log_Set @Operation = 'FactPerson_Lead_Insert'

exec ETL_Log_Set @Operation = 'FactPerson_Contact_Insert'
	exec FactPerson_Contact_Insert;	
exec ETL_Log_Set @Operation = 'FactPerson_Contact_Insert'

exec ETL_Log_Set @Operation = 'FactPerson_User_Insert'
	exec FactPerson_User_Insert;
exec ETL_Log_Set @Operation = 'FactPerson_User_Insert'