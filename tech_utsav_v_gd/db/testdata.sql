-- TestData --
insert into employee (emp_name,emp_password) values('satish','satish');
insert into employee (emp_name,emp_password) values('abcd','abcd');
insert into employee (emp_name,emp_password) values('test','test');
insert into employee (employee_id,emp_name,emp_password) values(5743,'satish','satish');
insert into employee (employee_id,emp_name,emp_password) values(1234,'test','test');

-- tacrequest location --
insert into location (office_location ) values('vv'),('BB2'),('BB1');

-- tacrequest table --
insert into tacrequest (issuer_emp_id, tacid, employee_id,tacrequest_date,tac_returned) values(1234,4321,5743,'2014-07-04 15:09:02',1);
insert into tacrequest (issuer_emp_id, tacid, employee_id,tacrequest_date,tac_returned) values(1234,4321,5743,'2014-07-04 15:09:02',1);
insert into tacrequest (issuer_emp_id, tacid, employee_id,tac_returned) values(1234,4321,5743,1);
insert into tacrequest (issuer_emp_id, tacid, employee_id) values(1234,4321,1234);
insert into tacrequest (issuer_emp_id, tacid, employee_id,tacrequest_date,tac_returned) values(1234,4321,1234,'2014-07-04 15:09:02',1);
insert into tacrequest (issuer_emp_id, tacid, employee_id,tacrequest_date,tac_returned) values(1234,4321,1234,'2014-07-04 15:09:02',1);

-- stationary_item table --
insert into stationary_items (item_name) values ('pen');
insert into stationary_items (item_name) values ('book');
insert into stationary_items (item_name) values ('marker');
insert into stationary_items (item_name) values ('duster');

--stationary table --
insert into stationary_request (employee_id, stationary_id, stationary_request_date, stationary_item_count) values(5743,1,'2014-07-04 15:09:02',1);
insert into stationary_request (employee_id, stationary_id, stationary_request_date, stationary_item_count) values(1234,2,'2014-07-04 15:09:02',1);

--laptop_entry table -- 
insert into laptop_entry (employee_id, laptop_serial_id, laptop_company_name, check_in_datetime, check_out_datetime, laptoptype) values (1234,12345,'Dell','2014-07-04 08:09:02','2014-07-04 15:09:02', 'office');
insert into laptop_entry (employee_id, laptop_serial_id, laptop_company_name, check_in_datetime, check_out_datetime, laptoptype) values (5743,11111,'HP','2014-07-04 08:09:02','2014-07-04 15:09:02', 'office');
insert into laptop_entry (employee_id, laptop_serial_id, laptop_company_name, laptoptype) values (5743,12345,'HP','personal');


insert into laptop_entry (employee_id, laptop_id, check_in_datetime, check_out_datetime) values (1234,3,'2014-07-04 08:09:02',CURRENT_TIMESTAMP);
insert into laptop_entry (employee_id, laptop_id, check_in_datetime, check_out_datetime) values (1234,3,'2014-07-04 08:09:02',DateTime('now'));

insert into laptop_entry (employee_id, laptop_id ) values (5743,1);
insert into laptop_entry (employee_id, laptop_id ) values (5743,2);
insert into laptop_entry (employee_id, laptop_id ) values (1234,3);
insert into laptop_entry (employee_id, laptop_id ) values (1234,4);

--insert into laptop_entry (employee_id, laptop_id, check_in_datetime, check_out_datetime) values (1234,3,'2014-07-04 08:09:02',date('NOW()'));
insert into laptop_record (laptop_id, employee_id, laptop_serial_id, laptop_company_name, laptoptype) values (1,5743,123456789,'HP','official');
insert into laptop_record (laptop_id, employee_id, laptop_serial_id, laptop_company_name, laptoptype) values (2,5743,987654321,'HP','personal');
insert into laptop_record (laptop_id, employee_id, laptop_serial_id, laptop_company_name, laptoptype) values (3,1234,123450000,'HP','official');
insert into laptop_record (laptop_id, employee_id, laptop_serial_id, laptop_company_name, laptoptype) values (4,1234,123455123,'HP','personal');