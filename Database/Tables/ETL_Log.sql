create table ETL_Log (
ID int IDENTITY(1,1),
Operation sysname,
DateStarted datetime,
DateCompleted datetime,
Duration int);

create nonclustered index IDX_ETL_LOG_Operation on ETL_Log (Operation, DateStarted);