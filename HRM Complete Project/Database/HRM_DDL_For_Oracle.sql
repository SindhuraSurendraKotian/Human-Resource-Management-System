CONN SYSTEM AS SYSDBA
PASSWORD : SYSTEM

CREATE USER HRM IDENTIFIED BY hrm;

GRANT ALL PRIVILEGES TO HRM;

CONN HRM
PASSWORD : hrm

DROP TABLE IF EXISTS admin;

CREATE TABLE admin (
  admin_name varchar2(20) DEFAULT NULL,
  userid varchar2(20) NOT NULL,
  password varchar2(20) DEFAULT NULL,
  PRIMARY KEY (userid)
);

DROP TABLE IF EXISTS employee;

CREATE TABLE employee (
  name varchar2(20) DEFAULT NULL,
  emp_id varchar2(20) NOT NULL,
  gender varchar2(45) DEFAULT NULL,
  dob date DEFAULT NULL,
  contact_no varchar2(10) DEFAULT NULL,
  designation varchar2(20) DEFAULT NULL,
  department varchar2(20) DEFAULT NULL,
  hire_date date DEFAULT NULL,
  username varchar2(20) NOT NULL,
  password varchar2(20) DEFAULT NULL,
  PRIMARY KEY (emp_id,username)
);

DROP TABLE IF EXISTS hr;

CREATE TABLE hr (
  hr_name varchar2(20) DEFAULT NULL,
  c_id varchar2(10) NOT NULL,
  username varchar2(20) DEFAULT NULL,
  password varchar2(30) DEFAULT NULL,
  contact_no varchar2(10) DEFAULT NULL,
  PRIMARY KEY (c_id)
);

DROP TABLE IF EXISTS payroll;

CREATE TABLE payroll (
  emp_id varchar2(20) NOT NULL,
  basic_salary number(11) DEFAULT NULL,
  hra double DEFAULT NULL,
  ta double DEFAULT NULL,
  medical double DEFAULT NULL,
  loan double DEFAULT NULL,
  advance_pay double DEFAULT NULL,
  b_type varchar2(45) DEFAULT NULL,
  b_amt number(11) DEFAULT NULL,
  net_salary mediumtext,
  PRIMARY KEY (emp_id),
  UNIQUE KEY emp_id_UNIQUE (emp_id),
  CONSTRAINT empidfk2 FOREIGN KEY (emp_id) REFERENCES employee (emp_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS projects;

CREATE TABLE projects (
  project_id varchar2(10) NOT NULL,
  p_name varchar2(20) DEFAULT NULL,
  eligibility varchar2(40) DEFAULT NULL,
  availability number(11) DEFAULT NULL,
  emp_id varchar2(25) DEFAULT NULL,
  PRIMARY KEY (project_id),
  KEY empid_fk1 (emp_id),
  CONSTRAINT empid_fk1 FOREIGN KEY (emp_id) REFERENCES employee (emp_id) ON DELETE CASCADE
);

--Create Trigger
DELIMITER $$

DROP TRIGGER IF EXISTS GENERATE_EMPLOYEE_PASSWORD 

CREATE TRIGGER GENERATE_EMPLOYEE_PASSWORD BEFORE INSERT ON employee FOR EACH ROW BEGIN
           IF NEW.PASSWORD IS NULL THEN
               SET NEW.PASSWORD = CONCAT(SUBSTR(NEW.NAME,1,4),SUBSTR(NEW.CONTACT_NO,-4,4));
           END IF;
       END 


DELIMITER ;

--Create Stored procedure
CREATE PROCEDURE EMPLOYEE_TAKE_HOME_SALARY()
select NAME as EMPLOYEE_NAME,e.emp_id as EMPLOYEE_ID,e.contact_no as CONTACT_NO,
e.designation as DESIGNATION,(basic_salary+hra+ta+medical+b_amt) AS GROSS_SALARY
from EMPLOYEE E,PAYROLL P
where E.emp_id = P.emp_id 

