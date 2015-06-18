-- create user techutsav identified by 'abcd';
-- grant all on techutsav.* to 'techutsav'@localhost identified by 'abcd';

-- drop database if exists techutsav;

-- create database techutsav;

-- use techutsav;
--tables :12
--employee,roles,employee_role,location,taclist,tacrequest,stationary_items,stationary_request,laptop_entry,visitor_entry
-- insert into location(office_location ) values ('vv'),('bb2'),('bb1');
-- INTEGER AUTOINCREMENT
create table employee
( employee_id int auto_increment primary key,
  emp_name VARCHAR(50),
  emp_password  VARCHAR(50)
);

create table roles
(role_id int auto_increment primary key,
 role_name varchar(50)
);

create table employee_role
(emp_role_id int auto_increment primary key,
 employee_id int,
 role_id int
);

create table location
(location_id int AUTO_INCREMENT primary key NOT NULL,
office_location varchar(50)
);

create table taclist
(tacid int primary key,
 location_id varchar(30)
);

create table tacrequest
(tacrequest_id int auto_increment primary key,
 issuer_emp_id int,
 tacid int,
 employee_id int,
 tacrequest_date TIMESTAMP default now(),
 tac_returned_date timestamp
);

create table stationary_items
(stationary_id int auto_increment primary key,
item_name varchar(50)
);

create table stationary_request
(employee_id int,
stationary_id int,
stationary_request_date TIMESTAMP default now(),
stationary_item_count int
);
-- create table laptop_records

create table laptop_entry
(id int auto_increment primary key,
employee_id int ,
laptop_serial_id int,
laptop_company_name varchar(50),
check_in_datetime TIMESTAMP default now(),
check_out_datetime timestamp,
laptoptype varchar(50)
);

create table visitor_entry
(id int auto_increment primary key,
vistor_badge_id int,
check_in_datetime TIMESTAMP default now(),
check_out_datetime timestamp
);