.open basketballRent.db
.mode column
.header on


--CREATE TABLE--
drop table court;
create table if not exists court (
    courtID integer primary key,
    courtName varchar(50),
    location varchar(50),
    pricePerHour decimal
);

-- Customers table
drop table customer;
create table customer (
    customerID integer primary key,
    name varchar(50),
    email varchar(50),
    phone varchar(50)
);

-- Reservation table
drop table reservation;
create table reservation (
    reservationID integer primary key,
    courtID integer,
    customerID integer,
    reservationDate date,
    startTime time,
    endTime time,
    foreign key (courtID) references court(courtID),
    foreign key (customerID) references customers(customerID)
  );

--INSERT--
insert into court (courtID, courtName, location, pricePerHour)
values
    (1, 'Court 1', 'B01', 1400.00),
    (2, 'Court 2', 'B01', 1400.00),
    (3, 'Court 1', 'B02', 1400.00),
    (4, 'Court 2', 'B02', 2000.00);
select * from court;

insert into customer (customerID, name, email, phone)
values
    (1, 'Patrick Ewing', 'patrick.e@nyknick.com', '7536421598'),
    (2, 'Larry Bird', 'larry.b@boston.com', '9812467501'),
    (3, 'Magic Johnson', 'magic.j@laker.com', '6412305576');
select * from customer;

insert into reservation (reservationID, courtID, customerID, reservationDate, startTime, endTime)
values
    (1, 1, 1, '2023-05-10', '10:00', '12:00'),
    (2, 2, 2, '2023-05-10', '14:00', '16:00'),
    (3, 1, 3, '2023-05-11', '09:00', '11:00'),
    (4, 2, 1, '2023-05-11', '13:00', '15:00'),
    (5, 3, 2, '2023-05-12', '11:00', '14:00'),
    (6, 4, 3, '2023-05-12', '16:00', '18:00'),
    (7, 1, 1, '2023-05-13', '14:00', '16:00'),
    (8, 2, 2, '2023-05-13', '18:00', '20:00'),
    (9, 3, 3, '2023-05-14', '10:00', '12:00'),
    (10, 4, 1, '2023-05-14', '13:00', '15:00');
select * from reservation;

--QUERY--
--Full reservation--
select 
  c.location,
  c.courtName,
  cu.name,
  reservationDate as date,
  re.startTime,
  re.endTime,
  strftime('%H:%M', re.endTime, '-' || re.startTime) as duration
from court as c
join reservation as re on c.courtID = re.courtID
join customer as cu on re.customerID = cu.customerID
order by c.location, c.courtName, date, re.startTime;

--Customer Sale detail--
select cu.name, 
  count(*) as frequency,
  sum(strftime('%H:%M', re.endTime, '-' || re.startTime)) as total_duration
from court as c
join reservation as re on c.courtID = re.courtID
join customer as cu on re.customerID = cu.customerID
group by cu.name
order by total_duration desc;


select sum(strftime('%H:%M', endTime, '-' || startTime)) as duration
from reservation;

select c.location, re.reservationDate as date
from court as c
join reservation as re on c.courtID = re.courtID
where c.location = 'B01';

select c.location,
  c.courtName,
  sum(strftime('%H:%M', endTime, '-' || startTime)) as duration
from court as c
join reservation as re on c.courtID = re.courtID
group by c.courtName, c.location
order by c.location, c.courtName;
