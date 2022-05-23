create database ecommerce;
use ecommerce;

/* creating different tables */
create table supplier(supp_id int primary key,supp_name varchar(50) not NULL, supp_city varchar(50) not NULL, supp_phone varchar(50) not NULL);
create table customer(cus_id int primary key,cus_name varchar(20) not NULL,cus_phone varchar(10) not NULL,cus_city varchar(30) not NULL,cus_gender char);
create table category(cat_id int primary key,cat_name varchar(20) not NULL);
create table product(pro_id int primary key,pro_name varchar(20) not NULL default "Dummy",pro_desc varchar(60),cat_id int,foreign key(cat_id) references category(cat_id));
create table supplier_pricing(pricing_id int primary key,pro_id int,supp_id int,supp_price int default 0,foreign key(pro_id) references product(pro_id),foreign key(supp_id) references supplier(supp_id)); 
create table orders(ord_id int primary key,ord_amount int not NULL,ord_date date not NULL,cus_id int,pricing_id int,foreign key(cus_id) references customer(cus_id),foreign key(pricing_id) references supplier_pricing(pricing_id));
create table rating(rat_id int primary key,ord_id int,rat_ratstars int not NULL,foreign key(ord_id) references orders(ord_id));

/* inserting data into supplier table */
insert into supplier values(1,'Rajesh Retails','Delhi','1234567890');
insert into supplier values(2,'Appario Ltd.','Mumbai','2589631470');
insert into supplier values(3,'Knome products','Banglore','9785462315');
insert into supplier values(4,'Bansal Retails','Kochi','8975463285');
insert into supplier values(5,'Mittal Ltd.','Lucknow','7898456532');

/* inserting data into customer table */
insert into customer values(1,'AAKASH','9999999999','DELHI','M');
insert into customer values(2,'AMAN','9785463215','NOIDA','M');
insert into customer values(3,'NEHA','9999999999','MUMBAI','F');
insert into customer values(4,'MEGHA','9994562399','KOLKATA','F');
insert into customer values(5,'PULKIT','7895999999','LUCKNOW','M');

/* inserting data into category table */
insert into category values(1,'BOOKS');
insert into category values(2,'GAMES');
insert into category values(3,'GROCERIES');
insert into category values(4,'ELECTRONICS');
insert into category values(5,'CLOTHES');

/* inserting data into product table */
insert into product values(1,'GTA V','Windows 7 and above with i5 processor and 8 GB RAM',2);
insert into product values(2,'TSHIRT','SIZE-L with Black, Blue and White variations',5);
insert into product values(3,'ROG LAPTOP','Windows 10 with 15inch screen, i7 processor, 1TB SSD',4);
insert into product values(4,'OATS','Highly Nutritious from Nestle',3);
insert into product values(5,'HARRY POTTER','Best Collection of all time by J.K Rowling',1);
insert into product values(6,'MILK','1L Toned Milk',3);
insert into product values(7,'Boat Earphones','1.5 Meter long Dolby Atmos',4);
insert into product values(8,'Jeans','Stretchable Denim Jeans with various sizes and color',5);
insert into product values(9,'Project IGI','compatible with windows 7 nad above',2);
insert into product values(10,'Hoodie','Black GUCCI for 13 yrs and above',5);
insert into product values(11,'Rich Dad Poor Dad','Written by Robert Kiyosaki',1);
insert into product values(12,'Train Your Brain','By Shireen Stephen',1);

/* inserting data into supplier_pricing table */
insert into supplier_pricing values(1,1,2,1500);
insert into supplier_pricing values(2,3,5,30000);
insert into supplier_pricing values(3,5,1,3000);
insert into supplier_pricing values(4,2,3,2500);
insert into supplier_pricing values(5,4,1,1000);

/* inserting data into orders table */
insert into orders values(101,1500,'2021-10-06',2,1);
insert into orders values(102,1000,'2021-10-12',3,5);
insert into orders values(103,30000,'2021-09-16',5,2);
insert into orders values(104,1500,'2021-10-05',1,1);
insert into orders values(105,3000,'2021-08-16',4,3);
insert into orders values(106,1450,'2021-08-18',1,9);
insert into orders values(107,789,'2021-09-01',3,7);
insert into orders values(108,780,'2021-09-07',5,6);
insert into orders values(109,3000,'2021-00-10',5,3);
insert into orders values(110,2500,'2021-09-10',2,4);
insert into orders values(111,1000,'2021-09-15',4,5);
insert into orders values(112,789,'2021-09-16',4,7);
insert into orders values(113,31000,'2021-09-16',1,8);
insert into orders values(114,1000,'2021-09-16',3,5);
insert into orders values(115,3000,'2021-09-16',5,3);
insert into orders values(116,99,'2021-09-17',2,14);

/* inserting data into rating table */
insert into rating values(1,101,4);
insert into rating values(2,102,3);
insert into rating values(3,103,1);
insert into rating values(4,104,2);
insert into rating values(5,105,4);
insert into rating values(6,106,3);
insert into rating values(7,107,4);
insert into rating values(8,108,4);
insert into rating values(9,109,3);
insert into rating values(10,110,5);
insert into rating values(11,111,3);
insert into rating values(12,112,4);
insert into rating values(13,113,2);
insert into rating values(14,114,1);
insert into rating values(15,115,1);
insert into rating values(16,116,0);

/* Que 3 */
select c.cus_gender,count(*) 
from customer c 
join orders o 
on c.cus_id=o.cus_id 
where o.ord_amount>=3000 
group by c.cus_gender;

/* Que 4 */
select p.pro_name,o.ord_amount,o.ord_date
from orders o
join supplier_pricing sp
on o.pricing_id=sp.pricing_id
join product p
on sp.pro_id=p.pro_id
where o.cus_id=2;

/* Que 5 */
select * from supplier
where supp_id in (
select supp_id
from supplier_pricing
group by supp_id
having count(supp_id)>1);

/* Que 6 */
select c.cat_id,MIN(t2.supp_price) as PRICE from category c inner join
(select * from product p inner join (select pro_id as id,supp_price from supplier_pricing group by id having MIN(supp_price)) as t1 on t1.id=p.pro_id)
as t2 on t2.cat_id=c.cat_id group by c.cat_id;

/* Que 7 */
select p.pro_name,p.pro_desc from product as p inner join
(select pro_id from orders as ord inner join supplier_pricing as sp on ord.pricing_id = sp.pricing_id where ord.ord_date>='2021-10-05') as p1 on p.pro_id=p1.pro_id;

/* Que 8 */
select cus_name,cus_gender from customer where cus_name like 'A%' or cus_name like '%A';

/* Que 9 */
DELIMITER &&
CREATE PROCEDURE proc()
BEGIN
select report.supp_id,report.supp_name,report.Average,
CASE
when report.Average = 5 THEN 'Excellent Service'
when report.Average > 4 THEN 'Good Service'
when report.Average >2 THEN 'Average Service'
ELSE "Poor Service"
END AS Type_of_Service from
(select final.supp_id,supplier.supp_name,final.Average from
(select test2.supp_id,sum(test2.rat_ratstars)/count(test2.rat_ratstars) as Average from
(select supplier_Pricing.supp_id,test.ord_id,test.rat_ratstars from supplier_pricing inner join
(select orders.pricing_id,rating.ord_id,rating.rat_ratstars
from orders inner join rating on rating.ord_id=orders.ord_id
) as test on test.pricing_id = supplier_pricing.pricing_id)
as test2 group by supplier_pricing.supp_id)
as final inner join supplier where final.supp_id = supplier.supp_id) as report;
END &&
DELIMITER ;
call proc();




