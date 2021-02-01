use WFA3DotNet

create table TbCustomer(
CustomerId varchar(20) not null primary key ,
Name varchar(20) not null,
Dob date not null,
city varchar(20) not null
)


select * from tbCustomer

create table TbAccountType
(
TypeCode int not null primary key,
TypeDesc varchar(20) not null
)

create table TAccount(
CustomerId varchar(20) not null foreign key references TbCustomer(CustomerId),
AccountNumber varchar(20) not null,
AccountTypeCode int not null foreign key references TbAccountType(TypeCode),
DateOpened date default getdate(),
Balance float
)
insert into tbAccountType values (1, 'Checking'); 

insert into tbAccountType values (2, 'Saving'); 

insert into tbAccountType values (3, 'Money Market'); 

insert into tbAccountType values (4, 'Super Checking'); 


insert into TbCustomer values ('123456', 'David Letterman', '04-Apr-1949', 'Hartford'); 

insert into TbCustomer values ('123457', 'Barry Sanders', '12-Dec-1967','Detroit'); 

insert into TbCustomer values ('123458', 'Jean-Luc Picard', '9-Sep-1940', 'San Francisco'); 

insert into TbCustomer values ('123459', 'Jerry Seinfeld', '23-Nov-1965','New York City'); 

insert into TbCustomer values ('123460', 'Fox Mulder', '05-Nov-1962', 'Langley'); 

insert into TbCustomer values ('123461', 'Bruce Springsteen', '29-Dec-1960','Camden'); 

insert into TbCustomer values ('123462', 'Barry Sanders', '05-Aug-1974','Martha''s Vineyard'); 

insert into TbCustomer values ('123463', 'Benjamin Sisko', '23-Nov-1955','San Francisco'); 

insert into TbCustomer values ('123464', 'Barry Sanders', '19-Mar-1966','Langley'); 

insert into TbCustomer values ('123465', 'Martha Vineyard', '19-Mar-1963','Martha''s Vineyard'); 

insert into tAccount values 

('123456', '123456-1', 1, '04-Apr-1993', 2200.33); 

insert into tAccount values 

('123456', '123456-2', 2, '04-Apr-1993', 12200.99); 

 

insert into tAccount values 

('123457', '123457-1', 3, '01-JAN-1998', 50000.00); 

 

insert into tAccount values 

('123458', '123458-1', 1, '19-FEB-1991', 9203.56); 

 

insert into tAccount values 

('123459', '123459-1', 1, '09-SEP-1990', 9999.99); 

insert into tAccount values 

('123459', '123459-2', 1, '12-MAR-1992', 5300.33); 

insert into tAccount values 

('123459', '123459-3', 2, '12-MAR-1992', 17900.42); 

insert into tAccount values 

('123459', '123459-4', 3, '09-SEP-1998', 500000.00); 

 

insert into tAccount values 

('123460', '123460-1', 1, '12-OCT-1997', 510.12); 

insert into tAccount values 

('123460', '123460-2', 2, '12-OCT-1997', 3412.33); 

 

insert into tAccount values 

('123461', '123461-1', 1, '09-MAY-1978', 1000.33); 

insert into tAccount values 

('123461', '123461-2', 2, '09-MAY-1978', 32890.33); 

insert into tAccount values 

('123461', '123461-3', 3, '13-JUN-1981', 51340.67); 

 

insert into tAccount values 

('123462', '123462-1', 1, '23-JUL-1981', 340.67); 

insert into tAccount values 

('123462', '123462-2', 2, '23-JUL-1981', 5340.67); 

 

insert into tAccount values 

('123463', '123463-1', 1, '1-MAY-1998', 513.90); 

insert into tAccount values 

('123463', '123463-2', 2, '1-MAY-1998', 1538.90); 

 

insert into tAccount values 

('123464', '123464-1', 1, '19-AUG-1994', 1533.47); 

insert into tAccount values 

('123464', '123464-2', 2, '19-AUG-1994', 8456.47); 
select * from TbCustomer
 select * from TbAccountType
 select * from TAccount

 --1.Print customer id and balance of customers who have
--at least $5000 in any of their accounts.
select customerid,balance from TAccount where balance>=5000

 --2.Print names of customers whose names begin with a ‘B’. 
 select name from TbCustomer where name like 'B%'

 --3.Print all the cities where the customers of this bank live.
 select city from TbCustomer t1,TAccount t2 where t1.CustomerId=t2.CustomerId

 --4.Use IN [and NOT IN] clauses to list customers who live in [and don’t live in] San Francisco or Hartford.  
--with in
select * from TbCustomer where city in ('San Francisco','Hartford')
--with not in
select * from TbCustomer where city not in ('San Francisco','Hartford')

--5.Show name and city of customers whose names contain the letter 'r' and who live in Langley.  
select name,city from TbCustomer where name like '%r%' and city like 'Langley'

--6.How many account types does the bank provide? 
select count(TypeCode) as TotalAcct from TbAccountType

--7.Show a list of accounts and their balance for account numbers that end in '-1'
select accountnumber,balance from TAccount where AccountNumber like '%-1'

--8..Show a list of accounts and their balance for accounts opened on or after July 1, 1990. 
select accountnumber,balance from TAccount where DateOpened>='01-JUL-1990'

--9.If all the customers decided to withdraw their money, how much cash would the bank need?  
select sum(balance) as TotalMoney from TAccount

--10.List account number(s) and balance in accounts held by ‘David Letterman’.  
select t1.accountnumber,t1.balance from TAccount t1,TbCustomer t2 where t2.Name 
like 'David Letterman' and t1.CustomerId=t2.CustomerId

--11.List the name of the customer who has the largest balance (in any account).
select name
	from TbCustomer where CustomerID= (select customerid
	from TAccount where Balance =(select Max(Balance) from TAccount))

select * from TbAccountType

--12.List customers who have a ‘Money Market’ account.
select * from TbCustomer where CustomerId in
(select t1.customerid from
TAccount t1,TbAccountType t2
where t2.TypeDesc like 'Money Market' and t1.AccountTypeCode=t2.TypeCode)

--13.Produce a listing that shows the city and the number 
--of people who live in that city.
select city,count(customerid) as NoOfPeople from TbCustomer group by city

--14.Produce a listing showing customer name, the type of 
--account they hold and the balance in that account. (Make use of Joins)
select 
TbCustomer.name,
TbAccountType.TypeCode,
TAccount.balance from 
TAccount
join TbCustomer
on TbCustomer.CustomerId=TAccount.CustomerId 
join TbAccountType
on
Tbaccounttype.typecode=TAccount.AccountTypeCode

--15.Produce a listing that shows the customer name and
--the number of accounts they hold.(Make use of Joins)
select TbCustomer.name,TAccount.AccountNumber 
from TAccount
join TbCustomer
on TbCustomer.CustomerId=TAccount.CustomerId

--16.Produce a listing that shows an account type and
--the average balance in accounts of that type.
--(Make use of Joins)
select TbAccountType.TypeCode,avg(TAccount.Balance) as AVG
from TAccount

join TbAccountType
on 
Tbaccounttype.typecode=TAccount.AccountTypeCode
group by TbAccountType.TypeCode
