-- restaurant database

-- 5 tables
-- write 3-5 queries
-- 1x WITH
-- 1x SUBQUERY
-- 1x Aggregate Function

.open pizza.db

--CREATE & INSERT--
--TABLE 1 MENU--
drop table menu;
create table if not exists menu (
  menu_id int not null primary key,
  name text,
  price real);

insert into menu values
  (1,'pizza',100),
  (2,'chicken wing',70),
  (3,'french fries',50),
  (4,'coca cola',15),
  (5,'water',10);

--TABLE 2 MENU--
drop table staff;
create table if not exists staff (
    staff_id int not null primary key,
    name text,
    position);

insert into staff values
  (1,'pond','chef'),
  (2,'may','chef'),
  (3,'aum','casher'),
  (4,'tar','waiter');

--TABLE 3 CUSTOMER--
drop table customer;
create table if not exists customer (
  cust_id int not null primary key,
  name text,
  gender text);

insert into customer values
  (1,'som','f'),
  (2,'bill','m'),
  (3,'big','m'),
  (4,'ant','f'),
  (5,'olive','f');

--TABLE 4 ORDERS--
drop table orders;
create table if not exists orders (
  order_id int not null primary key,
  staff_id int, --foreign key references staff(staff_id),
  cust_id int, --foreign key references customer(cust_id),
  menu_id int, --foreign key references menu(menu_id),
  date date);

insert into orders values
  (1,3,5,1,'2023-01-07'),
  (2,3,3,2,'2023-01-07'),
  (3,3,2,3,'2023-01-08'),
  (4,3,1,1,'2023-01-10'),
  (5,3,4,2,'2023-01-10'),
  (6,3,3,3,'2023-01-10');

--TABLE 5 PAYMENT--
drop table payment;
create table if not exists payment (
  pay_id int not null primary key,
  cust_id int,
  order_id int,
  amount int,
  date date);

insert into payment values
  (1,1,1,100,'2023-01-07'),
  (2,3,2,70,'2023-01-07'), --foreign key references customer(cust_id),
  (3,2,3,50,'2023-01-08'), --foreign key references oders(order_id),
  (4,5,4,100,'2023-01-10'),
  (5,4,5,70,'2023-01-10'),
  (6,3,6,50,'2023-01-10');

.mode column
.header on

select * from menu;
select * from staff;
select * from customer;
select * from orders;
select * from payment;

-- Query 1 menu sell report
select 
  menu.name as mune,
  count(*) as count,
  sum(payment.amount) as amount
  from menu
join orders on menu.menu_id = orders.menu_id
join customer on orders.cust_id = customer.cust_id
join payment on customer.cust_id = payment.cust_id
join staff on orders.staff_id = staff.staff_id
group by menu.name;

-- Query 2 who buy in 2023-01-07
with cust as (
  select * from customer),
  d07 as (
  select * from orders
where date = '2023-01-07')

select name
from cust
join d07 on cust.cust_id = d07.cust_id;

--Query 3 Who buy pizza
with pizza as (
  select * from menu
  where name = 'pizza'),
  cust as (
  select * from customer),
  ord as (select * from orders)

select cust.name, count(*)
from pizza
join ord on pizza.menu_id = ord.order_id
join cust on ord.cust_id = cust.cust_id;

--Query 4 Customer Buy detail
with cust as (
  select * from customer),
      pay as (
select * from payment)

select 
  cust.name,
  cust.gender,
  count(*) as count,
  sum(pay.amount) as sum,
  avg(pay.amount) as avg
from pay
join cust on pay.cust_id = cust.cust_id
group by cust.name, cust.gender
order by cust.name desc;
