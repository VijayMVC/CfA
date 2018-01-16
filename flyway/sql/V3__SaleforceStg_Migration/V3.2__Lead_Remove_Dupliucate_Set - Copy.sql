Create procedure Lead_Remove_Duplicate_Set as

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


