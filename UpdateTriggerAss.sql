use WFA3DotNet
alter trigger trgAfterUp on Employee
after update 
as 
declare 
@empid int,
@ename varchar(20),
@esal float,
@dol datetime
select @empid=deleted.empid,@ename=deleted.empname,@esal=deleted.Salary,@dol=getdate() from deleted

insert into PastEmpTable(empid,ename,esal,dol) values(@empid,@ename,@esal,@dol)
print 'After update trigger fired on EmpTable'



select * from Employee

select * from PastEmpTable
truncate table Employee 

update Employee set Empname='shivani',Salary=20000.4 where empid=103