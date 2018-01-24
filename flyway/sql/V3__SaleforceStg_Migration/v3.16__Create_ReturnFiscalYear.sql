create function ReturnFiscalYear (@Date datetime)
returns int
as
Begin
	declare @FiscalYear int

	set @FiscalYear = (select (CASE WHEN DATEPART(MM, @date) > 6 THEN DATEPART(YY, @date) + 1 
								WHEN DATEPART(MM, @date) <=6 THEN DATEPART(YY, @date) END));

	RETURN(@FiscalYear)									
End;
GO


