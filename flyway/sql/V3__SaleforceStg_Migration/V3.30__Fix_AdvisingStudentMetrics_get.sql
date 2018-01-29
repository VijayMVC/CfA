if exists (select 1 from sys.objects where object_id = object_id('dbo.AdvisingStudentMetrics_get'))
   set noexec on
go
create procedure dbo.[AdvisingStudentMetrics_get] as
begin
   select 1 as [not yet implemented]
end
go
set noexec off
go

alter Procedure [dbo].[AdvisingStudentMetrics_get] as

-- CFA_Student_Metrics

SET NOCOUNT ON;

IF OBJECT_ID('tempdb.dbo.#ODS', 'U') IS NOT NULL
  DROP TABLE #ODS;

IF OBJECT_ID('tempdb.dbo.#WHOID', 'U') IS NOT NULL
  DROP TABLE #WHOID;

IF OBJECT_ID('tempdb.dbo.#LastCall', 'U') IS NOT NULL
  DROP TABLE #LastCall;

IF OBJECT_ID('tempdb.dbo.#NextStep', 'U') IS NOT NULL
  DROP TABLE #NextStep;

IF OBJECT_ID('tempdb.dbo.#Sixified', 'U') IS NOT NULL
  DROP TABLE #Sixified;

IF OBJECT_ID('tempdb.dbo.#SUB', 'U') IS NOT NULL
  DROP TABLE #SUB;

IF OBJECT_ID('tempdb.dbo.#STUD', 'U') IS NOT NULL
  DROP TABLE #STUD;

IF OBJECT_ID('tempdb.dbo.#AARPL', 'U') IS NOT NULL
  DROP TABLE #AARPL;

IF OBJECT_ID('tempdb.dbo.#SF', 'U') IS NOT NULL
  DROP TABLE #SF;

IF OBJECT_ID('tempdb.dbo.#XSF', 'U') IS NOT NULL
  DROP TABLE #XSF;

IF OBJECT_ID('tempdb.dbo.#ZSF', 'U') IS NOT NULL
  DROP TABLE #ZSF;

IF OBJECT_ID('tempdb.dbo.#YSF', 'U') IS NOT NULL
  DROP TABLE #YSF;

IF OBJECT_ID('tempdb.dbo.#Purple', 'U') IS NOT NULL
  DROP TABLE #Purple;

IF OBJECT_ID('tempdb.dbo.#FA', 'U') IS NOT NULL
  DROP TABLE #FA;

SELECT STUDENTS_ID COLLATE SQL_Latin1_General_CP1_CI_AS STUDENTS_ID ,
           COUNT(DISTINCT SE1.STC_COURSE_NAME) AS TERMCOMPSMA ,
           COUNT(DISTINCT SE2.STC_COURSE_NAME) AS TERMGOALSMA
into #ODS
FROM [COCE-ODS-LS].ODS_production.dbo.ODS_STUDENTS S
LEFT JOIN [COCE-ODS-LS].ODS_production.dbo.ODS_STUDENT_ENROLLMENT SE1 ON S.STUDENTS_ID = SE1.STC_PERSON_ID
                                                                      AND SE1.STC_GRADE = 'MA'
                                                                                                                      AND SE1.N19_SCS_ACTIVE_TERM = '1'
                                                                      AND SE1.STC_ACAD_LEVEL = 'CFA'
LEFT JOIN [COCE-ODS-LS].ODS_production.dbo.ODS_STUDENT_ENROLLMENT SE2 ON S.STUDENTS_ID = SE2.STC_PERSON_ID
                                                                      AND SE2.STC_GRADE = 'MA'
                                                                      AND SE2.N19_SCS_ACTIVE_TERM = '1'
                                                                      AND SE2.STC_CRED = 3 
WHERE S.STU_CURRENT_HOME_LOCATION = 'CFA'
GROUP BY S.STUDENTS_ID;


SELECT t.WhoId ,
       t.OwnerId ,
       MAX(t.CreatedDate) AS CreatedDate
INTO #WHOID
FROM task t
WHERE t.CallObject IS NOT NULL
GROUP BY t.WhoId,
           t.OwnerId;


SELECT t.WhoId ,
       datediff(d, MAX(t.CreatedDate), getdate()) AS DaysSinceLastCall
into #LastCall
FROM task t
WHERE t.CallObject IS NOT NULL
GROUP BY t.WhoId;
       

select t.WhoID, t.Next_Steps__C, X.NextStepCreatedDate
into #NextStep
FROM task t
inner join (Select WhoID, max(Createddate) NextStepCreatedDate
            FROM task t
            where Next_Steps__C is not null
            group by WhoID) x on x.WhoID = t.WhoID
                              and x.NextStepCreatedDate =  t.CreatedDate
where Next_Steps__C is not null;
       

SELECT Student__C, case when Version_Number__C in ('2.0','1.0') and Is_Most_Recent_Version__c = 'Yes'
then 'Yes' else 'No' end Sixified
into #Sixified
FROM [Program__c] p
left join Student_Program__C sp on p.id = sp.Program__C
inner join FactPerson fp on fp.ContactActive_Student_Program__C = sp.id
														and fp.Contactid = sp.student__c
where p.degree_type__c like 'Associates%'
group by Student__C, case when Version_Number__C in ('2.0','1.0') and Is_Most_Recent_Version__c = 'Yes' then 'Yes' else 'No' end;

select sp.Student__C, count(1) Number_of_Purple_Projects_Completed
into #Purple
from Student_Project_Action__c spa
inner join Student_Project__c sp on sp.id = spa.Student_Project__C
inner join Program_Goal__c pg on pg.id = sp.Program_Goal__C
                              and pg.Path_Type__c = 'Purple'
where spa.Status_End__C = 'Mastered'
group by sp.Student__C;

SELECT SPROJ.[Student__c] ,
       AVG([Number_Submitted__c]) AS AVGSUBMA
into #SUB
FROM [Student_Project__c] SPROJ
WHERE SPROJ.[Date_Mastered__c] IS NOT NULL
AND SPROJ.studentId_projectId__c NOT LIKE '%TEAM%'
GROUP BY SPROJ.[Student__c];

SELECT ST.ColleagueID ,
            ST.CurrentAccountsReceivableBalance ,
            ST.SatisfactoryAcademicProgressResultCode
into #STUD
FROM [COCE-LSTNR,50333].[AARDW].[AARPL].[Student] ST;

create nonclustered index IDX_#STUD_ColleagueID on #STUD (ColleagueID) include (CurrentAccountsReceivableBalance, SatisfactoryAcademicProgressResultCode);

SELECT '=HYPERLINK("https://cfa.my.salesforce.com/' + left(c.ID, 15) + '", "' + c.Name + '")' Hyperlink ,
            c.Colleague_ID__c ,
            CASE WHEN SR.RestrictionCode = 'CFAW'
                      AND RestrictionEndDate IS NULL THEN 'CFAW'
                 ELSE NULL
            END AS RestrictionCode ,
            CallDisposition ,
            t.[Description] ,
                     ns.Next_Steps__C,
                     ns.NextStepCreatedDate,
                     s.Sixified,
            ou.Name ,
            t.Call_Duration_in_Minutes__c ,
                     Years_to_complete_at_current_pace__c ,
                     lc.DaysSinceLastCall,
            t.CreatedDate
       into #AARPL
    FROM task t
    LEFT JOIN Contact c ON c.Id = t.WhoId
                                          AND c.Name IS NOT NULL
    INNER JOIN #WHOID x ON x.WhoId = t.WhoId
                        AND x.OwnerId = c.Primary_Coach__c
                        AND x.CreatedDate = t.CreatedDate
    LEFT JOIN #NextStep ns on ns.WhoId = t.WhoId
    LEFT JOIN #Sixified s on s.Student__C = t.WhoId
    LEFT JOIN #LastCall lc on lc.WhoID = t.WHoID
    LEFT JOIN [User] ou ON ou.Id = c.Primary_Coach__c
    LEFT JOIN [COCE-LSTNR,50333].AARDW.AARPL.BusinessEntity be ON c.Colleague_ID__c = be.ColleagueID
    LEFT JOIN [COCE-LSTNR,50333].AARDW.AARPL.StudentRestriction SR ON be.BusinessEntity_SK = SR.Student_SK
                                                AND SR.RestrictionCode IN ('CFAW','CFAAS')
                                                AND SR.IsActiveRestriction = 1
     WHERE t.CallObject IS NOT NULL
     
SELECT C.Id ,
C.LastName,
C.FirstName,
A.Signature_Initiative_Type__c ,
U.Manager_Full_Name__c ,
C.Primary_Coach_Fullname_Text__c Advisor ,
C.PC_Email__c ,
C.Colleague_ID__c ,
C.SFDC_Contact_ID__c ,
C.Last_First_Name__c ,
C.Estimated_Time_Zone__c ,
C.MailingState ,
C.SNHU_Email_Address__c ,
SPT.Status__c ,
C.Active_Student_Program_Status__c ,
C.Current_Term_Start_Date__c ,
SP.Next_Term_Start_Date__c ,
C.ASP_Start_Date__c ,
SP.Active_Term_Start_Date__c,
(DATEDIFF(m, CONVERT(DATETIME, SP.Active_Term_Start_Date__c), CONVERT(DATETIME, CURRENT_TIMESTAMP))) + 1 Month_of_Term ,
SP.Program_Title__c ,
AP.Term_Start_Date__c ,
AP.AP_Submission_Status__c ,
AP.AP_Completed_Date__c ,
AP.Registered_Competencies__c ,
AP.Intent_to_Enroll_Status__c ,
C.[Days_Since_Last_Log_In__c] ,
C.Last_Login_Date_From_Portal_User__c ,
C.Days_Since_Last_Project_Submitted__c ,
C.Last_Project_Submitted_Date__c ,
C.Total_Competencies_Mastered__c ,
SP.Program_Prior_Status__c ,
C.Financial_Hold__c ,
SP.Had_Restart__c ,
SP.Is_First_Term__c ,
SP.Is_Readmission__c ,
stud.CurrentAccountsReceivableBalance ,
stud.SatisfactoryAcademicProgressResultCode ,
SPT.[Competencies_Mastered__c] ,
A.Name ,
A.Competency_Minimum__c ,
S.AVGSUBMA ,
CASE WHEN C.[Colleague_Next_Term_Start_Date_Code__c] = RIGHT(CAST(YEAR(
                                                                        DATEADD(
                                                                            d ,
                                                                            1 ,
                                                                            EOMONTH(
                                                                                GETDATE()))) AS VARCHAR), 2)
                                                        + 'CFA'
                                                        + RIGHT('00'
                                                                + CAST(MONTH(
                                                                            DATEADD(
                                                                                d ,
                                                                                1 ,
                                                                                EOMONTH(
                                                                                    GETDATE()))) AS VARCHAR), 2) THEN
            1
        ELSE 0
END AS Possible_ReEnroll_Next_Month ,
CASE WHEN C.ASP_Start_Date__c = DATEADD(d, 1, EOMONTH(GETDATE())) THEN
            1
        ELSE 0
END AS OnBoarding_Next_Month ,
CASE WHEN C.ASP_Start_Date__c = DATEADD(d, 1, EOMONTH(GETDATE())) THEN 'OnBoarding Next Month'
     WHEN C.[Colleague_Next_Term_Start_Date_Code__c] = RIGHT(CAST(YEAR(DATEADD(d, 1, EOMONTH(GETDATE()))) AS VARCHAR), 2)
                                                        + 'CFA' + RIGHT('00' + CAST(MONTH(DATEADD(d, 1, EOMONTH(GETDATE()))) AS VARCHAR), 2) THEN 'Possible Renrolls Next Month'
     WHEN datediff(m, C.ASP_Start_date__C,getdate()) = 0 and sp.is_readmission__c = 0 then '1st Month Student'
       WHEN C.ASP_Start_date__C > DATEADD(d, 1, EOMONTH(GETDATE())) then 'Future Student'
       ELSE 'Continuing Student'
END AS 'Description'
into #SF
FROM Student_Program__c SP
LEFT JOIN Academic_Plan__c AP ON SP.Id = AP.Student_Program__c
                                            AND AP.Term_Start_Date__c = SP.Active_Term_Start_Date__c
                                            AND (Type__c = 'New' OR Type__c IS NULL)
INNER JOIN Contact C ON SP.Student__c = C.Id
INNER JOIN [User] U ON C.Primary_Coach__c = U.Id
INNER JOIN Account A ON C.AccountId = A.Id
LEFT JOIN [Student_Program_Term__c] SPT ON SP.Id = SPT.[Student_Program__c]
                                                        AND SPT.Start_Date__c > DATEADD(mm, -6, GETDATE())
                                                        AND (SPT.Status__c = 'In Progress'
                                                        OR SPT.Status__c IS NULL )
LEFT JOIN #SUB S ON SP.Student__c = S.[Student__c]
LEFT JOIN #STUD stud ON stud.ColleagueID = C.Colleague_ID__c
WHERE SP.Status__c IN ( 'Enrolled', 'Pending Grad Review', 'Registered' )
AND C.Active_Student_Program_Status__c IN ( 'Enrolled', 'Pending Grad Review', 'Registered' )
AND U.Manager_Full_Name__c IN ( 'Michael Miller', 'Andrea Bruneau', 'Chantel Freeman' ,'Nathan Szydlo' )
AND A.Name != 'SW test Account'
--AND C.Colleague_ID__c = '1458021'

     
SELECT   SPROJ.Student__c ,
              MIN(Date_Submitted__c) min_Date_Submitted__c
into #XSF
     FROM     [Student_Project__c] SPROJ
     WHERE    Date_Submitted__c IS NOT NULL
     GROUP BY SPROJ.Student__c 
     
SELECT   SPROJ.Student__c ,
            MIN(Date_Submitted__c) min_ASP_Date_Submitted__c
into #YSF
FROM [Student_Project__c] SPROJ
LEFT JOIN #SF sf ON SPROJ.Student__c = sf.Id
WHERE Date_Submitted__c IS NOT NULL
AND Date_Submitted__c >= sf.ASP_Start_Date__c
GROUP BY SPROJ.Student__c
     
SELECT SPROJ.Student__c ,
       MAX(Date_Mastered__c) max_Date_Mastered__c ,
       DATEDIFF(d, MAX(Date_Mastered__c), GETDATE()) NumberOfDaysSinceMastered
into #ZSF
FROM     [Student_Project__c] SPROJ
WHERE    Date_Mastered__c IS NOT NULL
GROUP BY SPROJ.Student__c

SELECT sf.Colleague_ID__c 'Colleague ID',
       sf.Last_First_Name__c 'Last First Name' ,
       AARPL.Hyperlink,
       sf.LastName,
       sf.FirstName,
       sf.Estimated_Time_Zone__c 'Estimated Time Zone' ,
       sf.MailingState 'Mailing State', 
       AARPL.CreatedDate 'Last Call' ,
          case when datediff(d, AARPL.CreatedDate, getdate()) > 30 then 'over 30 days'
               when datediff(d, AARPL.CreatedDate, getdate()) > 14 then '15 - 30 days'
               when datediff(d, AARPL.CreatedDate, getdate()) > 9 then '9 - 14 days'
               when datediff(d, AARPL.CreatedDate, getdate()) > -1 then '0 - 9 days'      
			   Else 'no call'
              end  'Last Call Categories', 
       ( DATEDIFF(d , CONVERT(DATETIME, AARPL.CreatedDate), CONVERT(DATETIME, CURRENT_TIMESTAMP))) 'Number of Days Since Last Call', 
          AARPL.CallDisposition 'Call Disposition' ,
       AARPL.Next_Steps__C 'Next Steps',
       AARPL.NextStepCreatedDate 'Next Steps Created Date',
       CONVERT(VARCHAR, sf.Active_Term_Start_Date__c, 101) 'Active Term Start Date' ,
       CONVERT(VARCHAR, sf.Current_Term_Start_Date__c, 101) 'Current Term Start Date',
       sf.Month_of_Term 'Month of Term' ,
       CONVERT(VARCHAR, sf.Next_Term_Start_Date__c, 101) 'Next Term Start Date' ,
       sf.[Competencies_Mastered__c] 'Term Comps MA (SF)' , 
       CASE WHEN ODS.TERMCOMPSMA = 0 THEN NULL
            ELSE ODS.TERMCOMPSMA END AS 'Term Comps MA (Colleague)' ,
          CASE WHEN sf.[Competencies_Mastered__c] = ODS.TERMCOMPSMA THEN 'Yes' ELSE 'No' end 'System Match',
          CASE WHEN ODS.TERMGOALSMA = 0 THEN NULL ELSE ODS.TERMGOALSMA END AS 'Term Goals MA (Colleague)' ,     
          sf.Name 'Account Name' ,
       sf.Competency_Minimum__c 'Partner Competency Minimum' ,
          AARPL.RestrictionCode 'Scholastic Standing Code' ,
          sf.SatisfactoryAcademicProgressResultCode 'SAP' ,
          sf.Total_Competencies_Mastered__c 'Total Competencies Mastered' ,
          sf.AVGSUBMA 'Average Attempts to Mastery' ,
       datediff(d, sf.Last_Project_Submitted_Date__c, getdate())   'Days Since Last Project Submitted' ,
       sf.Last_Project_Submitted_Date__c 'Last Project Submitted Date' ,
          sf.[Days_Since_Last_Log_In__c] 'Number of Days Since Last Log In' ,
       sf.Last_Login_Date_From_Portal_User__c 'Last Login Date From Portal User' ,
          CONVERT(VARCHAR, ZSF.max_Date_Mastered__c, 101) 'Last Date Mastered' ,
       ZSF.NumberOfDaysSinceMastered 'Days Since Last Project Mastered' ,
       CONVERT(VARCHAR, sf.ASP_Start_Date__c, 101) 'Active Program Start Date' ,
          sf.Program_Title__c 'Program Title' ,
          AARPL.Sixified,
          sf.Active_Student_Program_Status__c 'Active Student Program Status' ,
          sf.Financial_Hold__c 'Financial Hold Flag' ,
          case when isnull(sf.CurrentAccountsReceivableBalance, 0) <= 0 then 'No' else 'Yes' end 'Current Balance',
       sf.SNHU_Email_Address__c 'SNHU Email Address' ,
          AARPL.Years_to_complete_at_current_pace__c 'Pace/Years to Complete',
          sf.Is_First_Term__c 'Is First Term' ,
       sf.Is_Readmission__c 'Is Readmission' ,
       sf.Had_Restart__c 'Had Restart' ,  
          sf.Program_Prior_Status__c 'Program Prior Status' ,
          CASE WHEN sf.Total_Competencies_Mastered__c > 109 THEN 'TRUE' ELSE 'FALSE' END AS 'Petition to Graduate' ,
          sf.Intent_to_Enroll_Status__c 'Intent to Enroll Status' ,
          sf.AP_Submission_Status__c 'New AP Submission Status' ,
          CONVERT(VARCHAR, sf.Term_Start_Date__c, 101) 'AP Term Start Date' ,
          sf.AP_Completed_Date__c 'New AP Completed Date',
          sf.Registered_Competencies__c 'Number Registered Competencies on New AP' ,  
       sf.Manager_Full_Name__c 'Team Lead' ,
       sf.Advisor ,
       sf.PC_Email__c 'Advisor Email', 
       sf.SFDC_Contact_ID__c 'SFDC Contact ID' ,
          sf.Possible_ReEnroll_Next_Month ,
       sf.OnBoarding_Next_Month ,
          AARPL.Call_Duration_in_Minutes__c 'Call Duration in Minutes' ,
       sf.Description,
          p.Number_of_Purple_Projects_Completed
          -- ,isnull(fa.HasFincialAidCurrentTerm, 'No')  HasFincialAidCurrentTerm
FROM   #SF sf
LEFT JOIN #ODS ODS ON sf.Colleague_ID__c = ODS.STUDENTS_ID
LEFT JOIN #AARPL AARPL ON sf.Colleague_ID__c = AARPL.Colleague_ID__c
LEFT JOIN #XSF XSF ON XSF.Student__c = sf.Id
LEFT JOIN #YSF YSF ON YSF.Student__c = sf.Id
LEFT JOIN #ZSF ZSF ON ZSF.Student__c = sf.Id
LEFT JOIN #Purple p on p.Student__C = sf.Id;
--LEFT JOIN #FA fa on fa.ColleagueID = sf.Colleague_ID__c

IF OBJECT_ID('tempdb.dbo.#ODS', 'U') IS NOT NULL
  DROP TABLE #ODS;

IF OBJECT_ID('tempdb.dbo.#WHOID', 'U') IS NOT NULL
  DROP TABLE #WHOID;

IF OBJECT_ID('tempdb.dbo.#LastCall', 'U') IS NOT NULL
  DROP TABLE #LastCall;

IF OBJECT_ID('tempdb.dbo.#NextStep', 'U') IS NOT NULL
  DROP TABLE #NextStep;

IF OBJECT_ID('tempdb.dbo.#Sixified', 'U') IS NOT NULL
  DROP TABLE #Sixified;

IF OBJECT_ID('tempdb.dbo.#SUB', 'U') IS NOT NULL
  DROP TABLE #SUB;

IF OBJECT_ID('tempdb.dbo.#STUD', 'U') IS NOT NULL
  DROP TABLE #STUD;

IF OBJECT_ID('tempdb.dbo.#AARPL', 'U') IS NOT NULL
  DROP TABLE #AARPL;

IF OBJECT_ID('tempdb.dbo.#SF', 'U') IS NOT NULL
  DROP TABLE #SF;

IF OBJECT_ID('tempdb.dbo.#XSF', 'U') IS NOT NULL
  DROP TABLE #XSF;

IF OBJECT_ID('tempdb.dbo.#ZSF', 'U') IS NOT NULL
  DROP TABLE #ZSF;

IF OBJECT_ID('tempdb.dbo.#YSF', 'U') IS NOT NULL
  DROP TABLE #YSF;

IF OBJECT_ID('tempdb.dbo.#Purple', 'U') IS NOT NULL
  DROP TABLE #Purple;

IF OBJECT_ID('tempdb.dbo.#FA', 'U') IS NOT NULL
  DROP TABLE #FA;