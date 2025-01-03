create database insurance_cs064; 
use insurance_cs064; 
create table insurance_cs064.person( 
driver_id varchar(20), 
name varchar(30), 
address varchar(50), 
PRIMARY KEY(driver_id) 
); 

create table insurance_cs064.car( 
reg_num varchar(15), 
model varchar(10), 
year int, 
PRIMARY KEY(reg_num) 
); 

create table insurance_cs064.owns( 
driver_id varchar(20), 
reg_num varchar(10), 
PRIMARY KEY(driver_id, reg_num), 
FOREIGN KEY(driver_id) REFERENCES person(driver_id), 
FOREIGN KEY(reg_num) REFERENCES car(reg_num) 
); 

create table insurance_cs064.accident( 
report_num int, 
accident_date date, 
location varchar(50), 
PRIMARY KEY(report_num) 
); 

create table insurance_cs064.participated( 
driver_id varchar(20), 
reg_num varchar(10), 
report_num int, 
damage_amount int, 
PRIMARY KEY(driver_id,reg_num,report_num), 
FOREIGN KEY(driver_id) REFERENCES person(driver_id), 
FOREIGN KEY(reg_num) REFERENCES car(reg_num), 
FOREIGN KEY(report_num) REFERENCES accident(report_num) 
); 

--Structure of the table 
desc person; 
desc accident; 
desc participated; 
desc car; 
desc owns; 

--Inserting Values to the table 
insert into person values("A01","Richard", "Srinivas nagar"); 
insert into person values("A02","Pradeep", "Rajaji nagar"); 
insert into person values("A03","Smith", "Ashok nagar"); 
insert into person values("A04","Venu", "N R Colony"); 
insert into person values("A05","John", "Hanumanth nagar"); 

insert into car values("KA052250","Indica", "1990"); 
insert into car values("KA031181","Lancer", "1957"); 
insert into car values("KA095477","Toyota", "1998"); 
insert into car values("KA053408","Honda", "2008"); 
insert into car values("KA041702","Audi", "2005"); 

insert into owns values("A01","KA052250"); 
insert into owns values("A02","KA031181"); 
insert into owns values("A03","KA095477"); 
insert into owns values("A04","KA053408"); 
insert into owns values("A05","KA041702"); 

insert into accident values(11,'2003-01-01',"Mysore Road"); 
insert into accident values(12,'2004-02-02',"South end Circle"); 
insert into accident values(13,'2003-01-21',"Bull temple Road"); 
insert into accident values(14,'2008-02-17',"Mysore Road"); 
insert into accident values(15,'2004-03-05',"Kanakpura Road"); 

insert into participated values("A01","KA052250",11,10000); 
insert into participated values("A02","KA053408",12,50000); 
insert into participated values("A03","KA095477",13,25000); 
insert into participated values("A04","KA031181",14,3000); 
insert into participated values("A05","KA041702",15,5000); 

--Queries 
--Update the damage amount to 25000 for the car with a specific reg-num (example 'KA053408' ) for which the accident report number was 12. 
update participated 
set damage_amount=25000 
where reg_num='KA053408' and report_num=12; 
--Find the total number of people who owned cars that were involved in accidents in 2008. 
select count(distinct driver_id) CNT 
from participated a, accident b 
where a.report_num=b.report_num and b.accident_date like '2008%'; 
--Add a new accident to the database. 
insert into accident values(16,'2008-03-08',"Domlur"); select * from accident; 
--Display Accident date and location 
select accident_date ,location from accident;
--Display driver id who did accident with damage amount greater than or equal to Rs.25000 
select driver_id from participated 
where damage_amount>=25000;
