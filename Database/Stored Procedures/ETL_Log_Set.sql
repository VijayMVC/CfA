create procedure ETL_Log_Set @Operation sysname as

declare @DateStarted datetime;
declare @DateCompleted datetime;
declare @Duration int;
declare @ID int;

select @DateStarted = getdate(), @DateCompleted = getdate()

set @ID = (select top 1 ID
		   from ETL_Log
		   where Operation = @Operation
		   and DateCompleted is null
		   order by DateStarted desc);

if @ID is null 
		insert into ETL_Log (Operation, DateStarted)
		values
		(@Operation, @DateStarted)
else
	update ETL_Log 
	set DateCompleted = @DateCompleted,
	    Duration = datediff(s, DateStarted, @DateCompleted)
	where ID = @ID;

