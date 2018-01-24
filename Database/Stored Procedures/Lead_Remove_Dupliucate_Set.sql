if exists (select 1 from sys.objects where object_id = object_id('dbo.Lead_Remove_Duplicate_Set'))
   set noexec on
go
create procedure Lead_Remove_Duplicate_Set as
begin
   select 1 as [not yet implemented]
end
go
set noexec off
go

alter procedure Lead_Remove_Duplicate_Set as

delete from lead
where ID in (select id
			 from (select id, row_number() OVER(PARTITION BY ConvertedContactID ORDER BY CreatedDate) AS RowNum
				   from Lead
				   where ConvertedContactID in (select ConvertedContactId
											    from Lead
											    where ConvertedContactId is not null
											    group by ConvertedContactId
											    having count(1) > 1)) x
				    where RowNum != 1)


