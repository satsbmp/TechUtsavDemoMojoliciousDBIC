-- create user techutsav identified by 'abcd';
-- grant all on techutsav.* to 'techutsav'@localhost identified by 'abcd';

-- drop database if exists techutsav;

-- create database techutsav;

-- use techutsav;
--tables :12
--drop table employee,roles,employee_role,location,taclist,tacrequest,stationary_items,stationary_request,laptop_entry,visitor_entry
--drop table 'employee','roles',employee_role,location,taclist,tacrequest,stationary_items,stationary_request,laptop_entry,visitor_entry
-- insert into location(office_location ) values ('vv'),('bb2'),('bb1');
-- INTEGER AUTOINCREMENT
create table employee
( employee_id INTEGER primary key AUTOINCREMENT,
  emp_name VARCHAR(50),
  emp_password  VARCHAR(50)
);

create table roles
(role_id INTEGER primary key AUTOINCREMENT,
 role_name varchar(50)
);

create table employee_role
(emp_role_id int auto_increment primary key,
 employee_id int,
 role_id int
);

create table location
(location_id INTEGER primary key AUTOINCREMENT,
office_location varchar(50)
);

create table taclist
(tacid INTEGER primary key AUTOINCREMENT,
 location_id varchar(30)
);

drop table IF EXISTS tacrequest;
create table tacrequest
(tacrequest_id INTEGER primary key AUTOINCREMENT,
 issuer_emp_id int,
 tacid int,
 employee_id int,
 tacrequest_date TIMESTAMP default CURRENT_TIMESTAMP,
 tac_returned boolean default 0,
 tac_returned_date timestamp
);

create table stationary_items
(stationary_id INTEGER primary key AUTOINCREMENT,
item_name varchar(50)
);

create table stationary_request
(employee_id int,
stationary_id int,
stationary_request_date TIMESTAMP default CURRENT_TIMESTAMP,
stationary_item_count int
);
-- create table laptop_records
create table laptop_record
(laptop_id INTEGER primary key AUTOINCREMENT,
employee_id int ,
laptop_serial_id int,
laptop_company_name varchar(50),
laptoptype varchar(50),
created_date TIMESTAMP default CURRENT_TIMESTAMP
);
create table laptop_entry(
id INTEGER primary key AUTOINCREMENT,
employee_id int,
laptop_id int,
check_in_datetime TIMESTAMP default CURRENT_TIMESTAMP,
check_out_datetime timestamp
);

--drop table visitor_entry
create table visitor_entry
(id INTEGER primary key AUTOINCREMENT,
vistor_badge_id int,
check_in_datetime TIMESTAMP default CURRENT_TIMESTAMP,
check_out_datetime timestamp,
vsitor_name varchar,
visit_purpose varchar,
contact int,
remarks varchar,
address varchar,
tomeet varchar
);
--create view laptop_details1 AS select a.laptop_id,a.employee_id,a.check_in_datetime,a.check_out_datetime,b.laptop_serial_id,b.laptop_company_name,b.laptoptype from laptop_entry a JOIN laptop_record b on a.laptop_id=b.laptop_id
create view laptop_details AS select a.laptop_id,a.employee_id,a.check_in_datetime,a.check_out_datetime,b.laptop_serial_id,b.laptop_company_name,b.laptoptype from laptop_entry a JOIN laptop_record b on a.employee_id=b.employee_id; -- where a.employee_id=5743 ;
create view laptop_details AS select a.laptop_id,a.employee_id,a.check_in_datetime,a.check_out_datetime,b.laptop_serial_id,b.laptop_company_name,b.laptoptype from laptop_entry a JOIN laptop_record b on a.employee_id=b.employee_id and a.laptop_id=b.laptop_id;
