create procedure FactPerson_AARPL_Update as

update FactPerson
set FirstAcademicProgram = y.FirstAcademicProgram,
FirstProgramDegreeCode = y.FirstProgramDegreeCode
from (select ColleagueID, 
 FirstAcademicProgram, 
FirstProgramDegreeCode
from (select s.ColleagueID, 
	  sapt.AcademicProgram FirstAcademicProgram, 
	  ap.ProgramDegreeCode FirstProgramDegreeCode,
	  sapt.IsProgramGraduationTerm,
	  ROW_NUMBER () OVER (PARTITION BY s.ColleagueID ORDER BY sapt.IsProgramGraduationTerm DESC) RowNum
	  from [COCE-LSTNR,50333].AARDW.AARPL.Student s
	  left join [COCE-LSTNR,50333].AARDW.AARPL.StudentAcademicProgramTerm sapt on s.Student_SK = sapt.Student_SK
																			   and sapt.TermTypeCode = 'CFA'
	  left join [COCE-LSTNR,50333].AARDW.AARPL.AcademicProgram ap on ap.AcademicProgram_SK = sapt.AcademicProgram_SK
	  left join [COCE-LSTNR,50333].AARDW.AARPL.Term t on t.Term_SK = sapt.Term_SK
													  and t.TermTypeCode = 'CFA'
	  inner join (select sapt.student_SK, min(TermStartDate) FirstCfATermStartDate
				  from [COCE-LSTNR,50333].AARDW.AARPL.StudentAcademicProgramTerm sapt 
				  left join [COCE-LSTNR,50333].AARDW.AARPL.Term t on t.Term_SK = sapt.Term_SK
				  where sapt.TermTypeCode = 'CFA'
				  group by sapt.student_SK) x on x.student_SK= s.Student_SK
											  and x.FirstCfATermStartDate = t.TermStartDate
	inner join sf.FactPerson fp on fp.ContactColleague_ID__c = s.ColleagueID
								and fp.FirstProgramDegreeCode is null) x
where  RowNum = 1) y
where factPerson.ContactColleague_ID__c = y.ColleagueID
and FactPerson.FirstProgramDegreeCode is null