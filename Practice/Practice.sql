CREATE SCHEMA IF NOT EXISTS `Practice`;
USE `Practice`;
CREATE TABLE EMPLOYEE
(
	employee_id numeric primary key,
    first_name varchar(20),
    last_name varchar(20),
    email varchar(30),
    position varchar(50),
    salary numeric (10,2)
);
describe employee;

create table new_employee as
select employee_id, first_name
from employee;

alter table `new_employee` drop column `employee_id`;
create schema if not exists `bank`;
use `bank`;
drop schema `bank`;
use `Practice`;
ALTER TABLE `EMPLOYEE` modify COLUMN `first_name` VARCHAR(20) NOT NULL;
use `PRACTICE`;