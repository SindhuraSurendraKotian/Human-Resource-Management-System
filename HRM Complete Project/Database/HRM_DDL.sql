/*
SQLyog Community v11.31 (64 bit)
MySQL - 5.1.54-community : Database - hrm_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `admin_name` varchar(20) DEFAULT NULL,
  `userid` varchar(20) NOT NULL,
  `password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `employee` */

DROP TABLE IF EXISTS `employee`;

CREATE TABLE `employee` (
  `name` varchar(20) DEFAULT NULL,
  `emp_id` varchar(20) NOT NULL,
  `gender` varchar(45) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `contact_no` varchar(10) DEFAULT NULL,
  `designation` varchar(20) DEFAULT NULL,
  `department` varchar(20) DEFAULT NULL,
  `hire_date` date DEFAULT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`emp_id`,`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `hr` */

DROP TABLE IF EXISTS `hr`;

CREATE TABLE `hr` (
  `hr_name` varchar(20) DEFAULT NULL,
  `c_id` varchar(10) NOT NULL,
  `username` varchar(20) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL,
  `contact_no` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `payroll` */

DROP TABLE IF EXISTS `payroll`;

CREATE TABLE `payroll` (
  `emp_id` varchar(20) NOT NULL,
  `basic_salary` int(11) DEFAULT NULL,
  `hra` double DEFAULT NULL,
  `ta` double DEFAULT NULL,
  `medical` double DEFAULT NULL,
  `loan` double DEFAULT NULL,
  `advance_pay` double DEFAULT NULL,
  `b_type` varchar(45) DEFAULT NULL,
  `b_amt` int(11) DEFAULT NULL,
  `net_salary` mediumtext,
  PRIMARY KEY (`emp_id`),
  UNIQUE KEY `emp_id_UNIQUE` (`emp_id`),
  CONSTRAINT `empidfk2` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `projects` */

DROP TABLE IF EXISTS `projects`;

CREATE TABLE `projects` (
  `project_id` varchar(10) NOT NULL,
  `p_name` varchar(20) DEFAULT NULL,
  `eligibility` varchar(40) DEFAULT NULL,
  `availability` int(11) DEFAULT NULL,
  `emp_id` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`project_id`),
  KEY `empid_fk1` (`emp_id`),
  CONSTRAINT `empid_fk1` FOREIGN KEY (`emp_id`) REFERENCES `employee` (`emp_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/* Trigger structure for table `employee` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `GENERATE_EMPLOYEE_PASSWORD` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `GENERATE_EMPLOYEE_PASSWORD` BEFORE INSERT ON `employee` FOR EACH ROW BEGIN
           IF NEW.PASSWORD IS NULL THEN
               SET NEW.PASSWORD = CONCAT(SUBSTR(NEW.NAME,1,4),SUBSTR(NEW.CONTACT_NO,-4,4));
           END IF;
       END */$$


DELIMITER ;

/* Procedure structure for procedure `EMPLOYEE_TAKE_HOME_SALARY` */

/*!50003 DROP PROCEDURE IF EXISTS  `EMPLOYEE_TAKE_HOME_SALARY` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `EMPLOYEE_TAKE_HOME_SALARY`()
select NAME as EMPLOYEE_NAME,e.emp_id as EMPLOYEE_ID,e.contact_no as CONTACT_NO,
e.designation as DESIGNATION,(basic_salary+hra+ta+medical+b_amt) AS GROSS_SALARY
from EMPLOYEE E,PAYROLL P
where E.emp_id = P.emp_id */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
