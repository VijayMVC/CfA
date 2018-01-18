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
