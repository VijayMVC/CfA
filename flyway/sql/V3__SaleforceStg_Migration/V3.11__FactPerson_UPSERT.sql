CREATE procedure FactPerson_Upsert as

-- Lead Source
exec ETL_Log_Set @Operation = 'FactPerson_Lead_Insert'
	exec FactPerson_Lead_Insert;
exec ETL_Log_Set @Operation = 'FactPerson_Lead_Insert'

exec ETL_Log_Set @Operation = 'FactPerson_Lead_Update'
	exec FactPerson_Lead_Update;
exec ETL_Log_Set @Operation = 'FactPerson_Lead_Update'

-- Contact Source
exec ETL_Log_Set @Operation = 'FactPerson_Contact_Insert'
	exec FactPerson_Contact_Insert;	
exec ETL_Log_Set @Operation = 'FactPerson_Contact_Insert'

exec ETL_Log_Set @Operation = 'FactPerson_Contact_Update'
	exec FactPerson_contact_update;	
exec ETL_Log_Set @Operation = 'FactPerson_Contact_Update'

-- User Source
exec ETL_Log_Set @Operation = 'FactPerson_User_Insert'
	exec FactPerson_User_Insert;
exec ETL_Log_Set @Operation = 'FactPerson_User_Insert'

exec ETL_Log_Set @Operation = 'FactPerson_User_Update'
	exec FactPerson_User_Update;
exec ETL_Log_Set @Operation = 'FactPerson_User_Update'


-- AARPL Source
exec ETL_Log_Set @Operation = 'FactPerson_AARPL_Update'
	exec FactPerson_AARPL_Update;
exec ETL_Log_Set @Operation = 'FactPerson_AARPL_Update'



