update ControlTable
set SourceObject = 'Program__c'
where SourceObject = 'Program';

update ControlTable
set SourceObject = 'Program_Goal__c'
where SourceObject = 'Program_Goal';

update ControlTable
set SourceObject = 'Student_Project__c'
where SourceObject = 'Student_Project';

update ControlTable
set SourceObject = 'Student_Project_Action__c'
where SourceObject = 'Student_Project_Action';