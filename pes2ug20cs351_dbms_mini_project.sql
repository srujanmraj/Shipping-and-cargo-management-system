-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 16, 2022 at 02:06 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pes2ug20cs351_dbms_mini_project`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `cancel_order` (IN `cust_id` INT, IN `order_id1` INT)   BEGIN
 update Order_details set order_status='Cancelled' where order_id=order_id1 and customer_id=cust_id;
 #update Order_tracker set order_status='Cancelled' where order_id=order_id1 and customer_id=cust_id;
 
 select 'ORDER CANCELLED' as order_stat;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `create_order` (IN `cust_id` INT, IN `sch_id` INT, IN `capacity` INT, IN `val` INT, IN `shipaddress1` VARCHAR(255), IN `shipaddress2` VARCHAR(255), IN `shipcity` VARCHAR(255), IN `shipstate` VARCHAR(255), IN `shipcountry` VARCHAR(255), IN `zip1` INT, IN `conaddress1` VARCHAR(255), IN `conaddress2` VARCHAR(255), IN `concity` VARCHAR(255), IN `constate` VARCHAR(255), IN `concount` VARCHAR(255), IN `zip2` INT)   BEGIN
declare bill int;
case 
when ( select available_capacity from schedule_with_capacity where schedule_id=sch_id
)>capacity

then
set bill=(select (rate*capacity) from Schedule  where schedule_id=sch_id);


INSERT INTO `shipping_management_system`.`Order_details`
(`customer_id`,
`schedule_id`,
`order_capacity`,
`order_value`,
`shipping_address_line_1`,
`shipping_address_line_2`,
`shipping_city`,
`shipping_state`,
`shipping_country`,
`shipping_zip_code`,
`consignee_address_line_1`,
`consignee_address_line_2`,
`consignee_city`,
`consignee_state`,
`consignee_country`,
`consignee_zip_code`,`order_billing`
)
VALUES(cust_id,sch_id,capacity,val,shipaddress1,shipaddress2,shipcity,shipstate,shipcountry,zip1,conaddress1,
conaddress2,concity,constate,concount,zip2,bill);
 
 SELECT 'Order Placed Successfully' as 'Order_Status';
 else
 
 SELECT 'Order Cannot be placed!!Capacity Exceed more than Available capacity!!' as 'Order_Status';
  end case;
 END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email_id` varchar(255) NOT NULL,
  `contact_no` int(10) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `first_name`, `last_name`, `email_id`, `contact_no`, `password`) VALUES
(2, 'Michael', 'Scott', 'michael1234@dmf.com', 1212121214, 'isntthiscool'),
(3, 'Pam', 'Beesley', 'beesley@gmail.com', 2147483647, 'password'),
(4, 'Jim', 'Harper', 'jim_harper@gmail.com', 2147483647, '123abc'),
(5, 'Dwight', 'Schrute', 'dschrute@dmf.com', 2147483647, '#1cnlsy'),
(9, 'srujan m ', 'raj', 'sruju16@gmail.com', 2147483647, 'srujan');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `schedule_id` int(11) DEFAULT NULL,
  `order_capacity` int(11) DEFAULT NULL,
  `order_value` float DEFAULT NULL,
  `shipping_address_line_1` varchar(255) NOT NULL,
  `shipping_address_line_2` varchar(255) DEFAULT NULL,
  `shipping_city` varchar(255) DEFAULT NULL,
  `shipping_state` varchar(255) DEFAULT NULL,
  `shipping_country` varchar(255) DEFAULT NULL,
  `shipping_zip_code` int(10) NOT NULL,
  `consignee_address_line_1` varchar(255) NOT NULL,
  `consignee_address_line_2` varchar(255) DEFAULT NULL,
  `consignee_city` varchar(255) DEFAULT NULL,
  `consignee_state` varchar(255) DEFAULT NULL,
  `consignee_country` varchar(255) DEFAULT NULL,
  `consignee_zip_code` int(10) NOT NULL,
  `order_status` varchar(255) DEFAULT 'Placed'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`order_id`, `customer_id`, `schedule_id`, `order_capacity`, `order_value`, `shipping_address_line_1`, `shipping_address_line_2`, `shipping_city`, `shipping_state`, `shipping_country`, `shipping_zip_code`, `consignee_address_line_1`, `consignee_address_line_2`, `consignee_city`, `consignee_state`, `consignee_country`, `consignee_zip_code`, `order_status`) VALUES
(1, 1, 63, 500, 200, '9515 University Terrace Drive Apt D', '', 'Charlotte', 'NC', 'US', 28262, '9509 University Terrace Drive Apt K', '', 'Houston', 'TX', 'US', 312213, 'Cancelled'),
(2, 1, 65, 5000, 20000, '9515 University Terrace Drive Apt D', '', 'Charlotte', 'NC', 'US', 28262, '9509 University Terrace Drive Apt K', '', 'Houston', 'TX', 'US', 312213, 'Placed'),
(3, 5, 70, 300, 500, '806, Hillview Society', 'Riverdale', 'Seattle', 'Washington', 'USA', 554123, '50 street', 'apt 20', 'Los Angeles', 'Cali', 'USA', 456847, 'Cancelled'),
(4, 6, 72, 800, 200, '50 high street', 'Higher avenue', 'Long Beach', 'New Jersey', 'USA', 586012, '111, North drive', 'Tyron Street', 'London', 'BreExit', 'England', 456847, 'Placed'),
(10, 1, 66, 200, 200, '9509 UTD Dallas', '', 'Houston', 'Texas', 'US', 21354, '285 Lexington Drive', '', 'New York', 'NYC', 'US', 27612, 'Placed'),
(14, 2, 63, 500, 1000, '9971B Green Boulevard', 'Spring Valley Lane', 'New York City', 'New York', 'USA', 10006, 'East Deck 2', 'University City Boulevard', 'Houston', 'Texas', 'USA', 77006, 'Placed'),
(16, 2, 70, 200, 1000, '123 Matador House', '10th Avenue ', 'New York', 'New York', 'USA', 10001, 'Garment Factory', '12th Lane ', 'Houston', 'Texas', 'USA', 70001, 'Placed'),
(22, 4, 75, 805, 10000, '20, Graduate Lane', 'East Avenue', 'Los Angeles', 'California', 'USA', 102546, '13B, Baker Street', 'Lexington avenue', 'Seattle', 'Washington', 'USA', 100254, 'Cancelled'),
(26, 4, 69, 720, 3000, '20, Ashford Green ', 'North Tyron Street', 'Los Angeles', 'California', 'USA', 102546, '101, Lake View Apartments', 'Parkgreen drive', 'Seattle', 'Washington', 'USA', 520146, 'Placed'),
(27, 1, 63, 600, 1000, '12 Garden View ', '', 'New York', 'NY', 'USA', 100001, '9th Street', '', 'Houston', 'TX', 'USA', 98101, 'Cancelled'),
(28, 1, 70, 500, 1000, '9509 University Terrace Drive', 'Apt C', 'Seattle', 'Washington', 'US', 312213, '246 Lexington Avenue', '', 'Los Angeles', 'California', 'US', 512211, 'Placed'),
(29, 1, 70, 500, 1000, '9509 University Terrace Drive', 'Apt C', 'Seattle', 'Washington', 'US', 312213, '246 Lexington Avenue', '', 'Los Angeles', 'California', 'US', 512211, 'Cancelled'),
(30, 1, 70, 100, 1000, '9509 University Terrace Drive', 'Apt C', 'Seattle', 'Washington', 'US', 312213, '246 Lexington Avenue', '', 'Los Angeles', 'California', 'US', 512211, 'Cancelled'),
(31, 2, 75, 100, 1000, '9th Street ', '', 'Los Angeles', 'CA', 'USA', 61901, '5th Avenue ', 'Irish House', 'Seattle', 'Wa', 'USA', 90001, 'Placed');

-- --------------------------------------------------------

--
-- Table structure for table `port`
--

CREATE TABLE `port` (
  `port_id` int(11) NOT NULL,
  `port_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `port`
--

INSERT INTO `port` (`port_id`, `port_name`) VALUES
(5, 'Beaumont'),
(8, 'Charleston'),
(12, 'Georgia Ports'),
(6, 'Houston'),
(7, 'London'),
(3, 'Long beach'),
(2, 'Los Angeles'),
(11, 'New Jersey'),
(1, 'New York'),
(9, 'Pondicherry'),
(4, 'Seattle'),
(13, 'Vancouver'),
(14, 'Virginia');

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `schedule_id` int(11) NOT NULL,
  `vessel_id` int(11) DEFAULT NULL,
  `departing_time` time NOT NULL,
  `departing_date` date NOT NULL,
  `arriving_time` time NOT NULL,
  `arriving_date` date NOT NULL,
  `current_port_id` int(11) DEFAULT NULL,
  `destination_port_id` int(11) DEFAULT NULL,
  `rate` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`schedule_id`, `vessel_id`, `departing_time`, `departing_date`, `arriving_time`, `arriving_date`, `current_port_id`, `destination_port_id`, `rate`) VALUES
(63, 1, '23:00:00', '2022-11-01', '11:00:00', '2022-12-01', 1, 5, 25),
(64, 1, '23:00:00', '2022-11-02', '11:00:00', '2022-12-03', 6, 7, 25),
(65, 3, '23:00:00', '2022-12-03', '11:00:00', '2022-12-04', 1, 6, 25),
(66, 4, '23:00:00', '2022-12-04', '11:00:00', '2022-12-05', 7, 1, 25),
(67, 2, '22:00:00', '2022-12-01', '10:00:00', '2022-12-02', 2, 4, 25),
(68, 2, '22:00:00', '2022-12-02', '10:00:00', '2022-12-03', 12, 14, 25),
(69, 5, '22:00:00', '2022-12-03', '10:00:00', '2022-12-04', 2, 4, 25),
(70, 6, '22:00:00', '2022-12-04', '10:00:00', '2022-12-05', 8, 1, 25),
(71, 3, '13:00:00', '2022-06-05', '23:00:00', '2022-06-06', 2, 9, 50),
(72, 8, '14:00:00', '2022-11-02', '21:00:00', '2022-11-04', 3, 13, 20);

-- --------------------------------------------------------

--
-- Table structure for table `ship`
--

CREATE TABLE `ship` (
  `vessel_id` int(11) NOT NULL,
  `vessel_name` varchar(255) NOT NULL,
  `vessel_capacity` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ship`
--

INSERT INTO `ship` (`vessel_id`, `vessel_name`, `vessel_capacity`) VALUES
(1, 'Elizabeth', '5000'),
(2, 'Queenmary', '2000'),
(3, 'Eclipse', '20000'),
(4, 'Titanic', '150000'),
(5, 'Olympic', '120000'),
(6, 'Arizona', '150000'),
(8, 'American Dream', '7500');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `email_id` (`email_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `schedule_id` (`schedule_id`);

--
-- Indexes for table `port`
--
ALTER TABLE `port`
  ADD PRIMARY KEY (`port_id`),
  ADD KEY `port_name` (`port_name`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`schedule_id`),
  ADD KEY `vessel_id` (`vessel_id`),
  ADD KEY `current_port_id` (`current_port_id`),
  ADD KEY `destination_port_id` (`destination_port_id`);

--
-- Indexes for table `ship`
--
ALTER TABLE `ship`
  ADD PRIMARY KEY (`vessel_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `port`
--
ALTER TABLE `port`
  MODIFY `port_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `schedule`
--
ALTER TABLE `schedule`
  MODIFY `schedule_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `ship`
--
ALTER TABLE `ship`
  MODIFY `vessel_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `Schedule_ibfk_1` FOREIGN KEY (`vessel_id`) REFERENCES `ship` (`vessel_id`),
  ADD CONSTRAINT `Schedule_ibfk_2` FOREIGN KEY (`current_port_id`) REFERENCES `port` (`port_id`),
  ADD CONSTRAINT `Schedule_ibfk_3` FOREIGN KEY (`destination_port_id`) REFERENCES `port` (`port_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
