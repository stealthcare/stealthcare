-- phpMyAdmin SQL Dump
-- version 2.11.11.3
-- http://www.phpmyadmin.net
--
-- Host: 182.50.133.173
-- Generation Time: Jun 21, 2017 at 01:00 AM
-- Server version: 5.5.43
-- PHP Version: 5.1.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `stealthcaredb`
--

-- --------------------------------------------------------

--
-- Table structure for table `SCP_AccessLevel`
--

CREATE TABLE `SCP_AccessLevel` (
  `AccessLevelID` int(11) NOT NULL AUTO_INCREMENT,
  `AccessLevelName` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`AccessLevelID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `SCP_AccessLevel`
--

INSERT INTO `SCP_AccessLevel` VALUES(1, 'ALL', '2017-03-01 18:14:00', '2017-03-01 18:14:00', 1);
INSERT INTO `SCP_AccessLevel` VALUES(2, 'WEB,TABLET,MOBILE', '2017-03-01 18:14:00', '2017-03-01 18:14:00', 1);
INSERT INTO `SCP_AccessLevel` VALUES(3, 'TABLET', '2017-03-01 18:14:00', '2017-03-01 18:14:00', 1);
INSERT INTO `SCP_AccessLevel` VALUES(4, 'MOBILE', '2017-03-01 18:14:00', '2017-03-01 18:14:00', 1);
INSERT INTO `SCP_AccessLevel` VALUES(5, 'NOACCESS', '2017-03-01 00:00:00', '2017-03-01 00:00:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Alert`
--

CREATE TABLE `SCP_Alert` (
  `AlertID` int(11) NOT NULL AUTO_INCREMENT,
  `Priority` varchar(150) DEFAULT NULL,
  `Severity` varchar(150) DEFAULT NULL,
  `TaskID` int(11) DEFAULT NULL,
  `StaffID` int(11) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`AlertID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `SCP_Alert`
--


-- --------------------------------------------------------

--
-- Table structure for table `SCP_AssessmentAllocation`
--

CREATE TABLE `SCP_AssessmentAllocation` (
  `AssessmentAllocationID` int(11) NOT NULL AUTO_INCREMENT,
  `EnquiryID` int(11) DEFAULT NULL,
  `StaffID` int(11) DEFAULT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`AssessmentAllocationID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `SCP_AssessmentAllocation`
--


-- --------------------------------------------------------

--
-- Table structure for table `SCP_CareOrg`
--

CREATE TABLE `SCP_CareOrg` (
  `OrgID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(150) DEFAULT NULL,
  `CQCRegNo` varchar(156) NOT NULL,
  `CQCLocNo` varchar(156) NOT NULL,
  `AdminName` varchar(156) NOT NULL,
  `PlanID` int(11) DEFAULT NULL,
  `Address` varchar(150) DEFAULT NULL,
  `Address2` varchar(156) NOT NULL,
  `City` varchar(156) NOT NULL,
  `PostCode` varchar(9) NOT NULL,
  `ContactNo` varchar(150) DEFAULT NULL,
  `ContactNo2` varchar(150) DEFAULT NULL,
  `FaxNo` varchar(150) DEFAULT NULL,
  `WebSite` varchar(150) DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  `OtherDetails` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`OrgID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=35 ;

--
-- Dumping data for table `SCP_CareOrg`
--

INSERT INTO `SCP_CareOrg` VALUES(3, 'rest', '', '', '', 4, 'Hi', '', '', '', '7415850336', '7415850336', '7415850336', 'http://localhost/SCPProject/create_care_orga', 12, 'rest', '2017-03-27 17:32:53', '2017-04-03 16:55:25', 2);
INSERT INTO `SCP_CareOrg` VALUES(4, 'rest', '', '', '', 2, 'Hi', '', '', '', '7415850336', '7415850336', '7415850336', 'http://localhost/SCPProject/#/create_care_orga', 2, 'rest', '2017-03-27 17:32:53', '2017-04-03 12:43:20', 1);
INSERT INTO `SCP_CareOrg` VALUES(5, 'Anil Banwar', '', '', '', 3, 'Test data', '', '', '', '7415850336', '7415850336', '7415850336', 'http://localhost/SCPProject/organizer/abanwar', 13, 'Test Data Better', '2017-03-30 12:43:14', '2017-04-04 20:40:32', 2);
INSERT INTO `SCP_CareOrg` VALUES(7, 'Test User', '', '', '', 2, 'TestUser', '', '', 'AA9A 9AB', '7415850336', '7415850336', '7415850336', 'http://localhost/SCPProject/', 15, 'TestUser', '2017-04-03 13:52:49', '2017-04-05 16:11:34', 1);
INSERT INTO `SCP_CareOrg` VALUES(8, 'iziss', '', '', '', 1, 'izissA', '', '', 'AA9A 9AA', '7415850336', '7415850336', '7415850336', 'http://localhost/SCPProject/organizer/abanwar', 16, 'izissA', '2017-04-05 17:46:32', '2017-04-05 17:46:32', 2);
INSERT INTO `SCP_CareOrg` VALUES(9, 'Test Organiser', 'REG12345', 'LOC123', 'Test Org', 2, '302 Anmol Spaces Indore2', 'India', 'Indore', 'S5A5 AT7', '7415850336', '7415850336', '7415850336', 'http://localhost/SCPProject/', 17, 'Test Me Best', '2017-04-19 18:43:28', '2017-04-19 19:01:32', 0);
INSERT INTO `SCP_CareOrg` VALUES(10, 'Permjeet', '0101100', '11010', 'perm', 4, '12 test road', '', 'London', 'SW14 1111', '222222222', '', '', '', 24, '', '2017-05-27 14:57:50', '2017-05-27 14:57:50', 1);
INSERT INTO `SCP_CareOrg` VALUES(11, 'test', 'abc123', 'abc123', 'tester', 2, 'indore', '', 'indore', '1010 1010', '123456789812', '', '', '', 25, '', '2017-05-29 13:07:31', '2017-05-29 13:07:31', 2);
INSERT INTO `SCP_CareOrg` VALUES(12, 'organisation  for fire fox organisation  for fire fox organisation  for fire fox organisation  for fire fox organisation  for fire fox organisation  f', 'organisation  for fire fox 1', 'organisation  for fire fox 1', 'organisation  for fire fox', 2, 'organisation  for fire fox 1', '', 'organisation  for fire fox', 'ORGA ORGA', '123456789', '', '', '', 38, '', '2017-06-08 11:59:17', '2017-06-08 11:59:17', 1);
INSERT INTO `SCP_CareOrg` VALUES(13, 'organisation  for fire fox', 'organisation  for fire fox', 'organisation  for fire fox', 'organisation  for fire fox', 1, 'organisation  for fire fox', 'organisation  for fire fox', 'organisation  for fire fox', 'ORGA ORGA', '123456789', '', '', '', 39, '', '2017-06-08 12:03:37', '2017-06-08 12:03:37', 1);
INSERT INTO `SCP_CareOrg` VALUES(14, 'Organisation for IE', 'Organisation for IE', 'Organisation for IE', 'Organisation for IE', 1, 'Organisation for IE', '', 'Organisation for IE', 'ORGA ORGA', '12345678', '', '', '', 40, '', '2017-06-08 12:37:57', '2017-06-08 12:37:57', 1);
INSERT INTO `SCP_CareOrg` VALUES(15, 'Organisation for IE', 'Organisation for IE', 'Organisation for IE', 'Organisation for IE', 1, 'Organisation for IE', '', 'Organisation for IE', 'ORGA ORGA', '12345678', '', '', '', 41, '', '2017-06-08 12:42:33', '2017-06-08 12:42:33', 1);
INSERT INTO `SCP_CareOrg` VALUES(16, 'organisation for chrome', 'organisation for chrome', 'organisation for chrome', 'organisation for chrome', 1, 'organisation for chromeorganisation for chrome', '', 'organisation for chrome', 'ORGA ORGA', '8109781053', '', '', '', 42, '', '2017-06-08 12:50:55', '2017-06-08 12:50:55', 1);
INSERT INTO `SCP_CareOrg` VALUES(17, 'Organisation for safari', 'Organisation for safari', 'Organisation for safariOrganisation for safariOrganisation for safariOrganisation for safari', 'Organisation for safariOrganisation for safari', 1, 'Organisation for safari', '', 'Organisation for safari', 'ORGA ORGA', '12345678', '', '', '', 43, '', '2017-06-08 13:47:19', '2017-06-08 13:47:19', 1);
INSERT INTO `SCP_CareOrg` VALUES(18, 'Organisation for safari', 'Organisation for safari', 'Organisation for safariOrganisation for safariOrganisation for safariOrganisation for safari', 'Organisation for safariOrganisation for safari', 1, 'Organisation for safari', '', 'Organisation for safari', 'ORGA ORGA', '12345678', '', '', '', 44, '', '2017-06-08 13:47:19', '2017-06-08 13:47:19', 1);
INSERT INTO `SCP_CareOrg` VALUES(19, 'Organisation for safari', 'Organisation for safari', 'Organisation for safariOrganisation for safariOrganisation for safariOrganisation for safari', 'Organisation for safariOrganisation for safari', 1, 'Organisation for safari', '', 'Organisation for safari', 'ORGA ORGA', '12345678', '', '', '', 45, '', '2017-06-08 13:47:19', '2017-06-08 13:47:19', 1);
INSERT INTO `SCP_CareOrg` VALUES(20, 'Organisation for safari', 'Organisation for safari', 'Organisation for safariOrganisation for safariOrganisation for safariOrganisation for safari', 'Organisation for safariOrganisation for safari', 1, 'Organisation for safari', '', 'Organisation for safari', 'ORGA ORGA', '12345678', '', '', '', 46, '', '2017-06-08 13:47:48', '2017-06-08 13:47:48', 1);
INSERT INTO `SCP_CareOrg` VALUES(21, 'Organisation for safari', 'Organisation for safari', 'Organisation for safariOrganisation for safariOrganisation for safariOrganisation for safari', 'Organisation for safariOrganisation for safari', 1, 'Organisation for safari', '', 'Organisation for safari', 'ORGA ORGA', '12345678', '', '', '', 47, '', '2017-06-08 13:47:48', '2017-06-08 13:47:48', 1);
INSERT INTO `SCP_CareOrg` VALUES(22, 'Organisation for safari', 'Organisation for safari', 'Organisation for safariOrganisation for safariOrganisation for safariOrganisation for safari', 'Organisation for safariOrganisation for safari', 1, 'Organisation for safari', '', 'Organisation for safari', 'ORGA ORGA', '12345678', '', '', '', 48, '', '2017-06-08 13:47:48', '2017-06-08 13:47:48', 1);
INSERT INTO `SCP_CareOrg` VALUES(23, 'Organisation for safari', 'Organisation for safari', 'Organisation for safariOrganisation for safariOrganisation for safariOrganisation for safari', 'Organisation for safariOrganisation for safari', 1, 'Organisation for safari', '', 'Organisation for safari', 'ORGA ORGA', '12345678', '', '', '', 49, '', '2017-06-08 13:47:48', '2017-06-08 13:47:48', 1);
INSERT INTO `SCP_CareOrg` VALUES(24, 'Organisation for safari', 'Organisation for safari', 'Organisation for safariOrganisation for safariOrganisation for safariOrganisation for safari', 'Organisation for safariOrganisation for safari', 2, 'Organisation for safari', '', 'Organisation for safari', 'ORGA ORGA', '12345678', '', '', '', 50, '', '2017-06-08 13:47:48', '2017-06-08 13:47:48', 1);
INSERT INTO `SCP_CareOrg` VALUES(25, 'Organisation for safari', 'Organisation for safari', 'Organisation for safariOrganisation for safariOrganisation for safariOrganisation for safari', 'Organisation for safariOrganisation for safari', 1, 'Organisation for safari', '', 'Organisation for safari', 'ORGA ORGA', '12345678', '', '', '', 51, '', '2017-06-08 13:47:48', '2017-06-08 13:47:48', 1);
INSERT INTO `SCP_CareOrg` VALUES(26, 'Organisation for safari', 'Organisation for safari', 'Organisation for safariOrganisation for safariOrganisation for safariOrganisation for safari', 'Organisation for safariOrganisation for safari', 2, 'Organisation for safari', '', 'Organisation for safari', 'ORGA ORGA', '12345678', '', '', '', 52, '', '2017-06-08 13:47:56', '2017-06-08 13:47:56', 1);
INSERT INTO `SCP_CareOrg` VALUES(27, 'Organisation for safari', 'Organisation for safari', 'Organisation for safariOrganisation for safariOrganisation for safariOrganisation for safari', 'Organisation for safariOrganisation for safari', 2, 'Organisation for safari', '', 'Organisation for safari', 'ORGA ORGA', '12345678', '', '', '', 53, '', '2017-06-08 13:47:56', '2017-06-08 13:47:56', 1);
INSERT INTO `SCP_CareOrg` VALUES(28, 'Organisation for safari', 'Organisation for safari', 'Organisation for safariOrganisation for safariOrganisation for safariOrganisation for safari', 'Organisation for safariOrganisation for safari', 2, 'Organisation for safari', '', 'Organisation for safari', 'ORGA ORGA', '12345678', '', '', '', 54, '', '2017-06-08 13:47:56', '2017-06-08 13:47:56', 1);
INSERT INTO `SCP_CareOrg` VALUES(29, 'Organisation for safari', 'Organisation for safari', 'Organisation for safariOrganisation for safariOrganisation for safariOrganisation for safari', 'Organisation for safariOrganisation for safari', 2, 'Organisation for safari', '', 'Organisation for safari', 'ORGA ORGA', '12345678', '', '', '', 55, '', '2017-06-08 13:47:56', '2017-06-08 13:47:56', 1);
INSERT INTO `SCP_CareOrg` VALUES(30, 'Organisation for safari', 'Organisation for safari', 'Organisation for safariOrganisation for safariOrganisation for safariOrganisation for safari', 'Organisation for safariOrganisation for safari', 2, 'Organisation for safari', '', 'Organisation for safari', 'ORGA ORGA', '12345678', '', '', '', 56, '', '2017-06-08 13:47:56', '2017-06-08 13:47:56', 1);
INSERT INTO `SCP_CareOrg` VALUES(31, 'Organisation for safari', 'Organisation for safari', 'Organisation for safariOrganisation for safariOrganisation for safariOrganisation for safari', 'Organisation for safariOrganisation for safari', 2, 'Organisation for safari', '', 'Organisation for safari', 'ORGA ORGA', '12345678', '', '', '', 57, '', '2017-06-08 13:47:56', '2017-06-08 13:47:56', 1);
INSERT INTO `SCP_CareOrg` VALUES(32, 'Organisation for safari', 'Organisation for safari', 'Organisation for safariOrganisation for safariOrganisation for safariOrganisation for safari', 'Organisation for safariOrganisation for safari', 2, 'Organisation for safari', '', 'Organisation for safari', 'ORGA ORGA', '12345678', '', '', '', 58, '', '2017-06-08 13:47:59', '2017-06-08 13:47:59', 1);
INSERT INTO `SCP_CareOrg` VALUES(33, 'Organisation for safari', 'Organisation for safari', 'Organisation for safariOrganisation for safariOrganisation for safariOrganisation for safari', 'Organisation for safariOrganisation for safari', 2, 'Organisation for safari', '', 'Organisation for safari', 'ORGA ORGA', '12345678', '', '', '', 59, '', '2017-06-08 13:47:59', '2017-06-08 13:47:59', 1);
INSERT INTO `SCP_CareOrg` VALUES(34, 'Organisation for safari', 'Organisation for safari', 'Organisation for safariOrganisation for safariOrganisation for safariOrganisation for safari', 'Organisation for safariOrganisation for safari', 2, 'Organisation for safari', '', 'Organisation for safari', 'ORGA ORGA', '12345678', '', '', '', 60, '', '2017-06-08 13:47:59', '2017-06-08 13:47:59', 1);

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Checks`
--

CREATE TABLE `SCP_Checks` (
  `ChecksID` int(11) NOT NULL AUTO_INCREMENT,
  `Checks` varchar(150) NOT NULL,
  `Description` varchar(150) NOT NULL,
  `OrgID` int(11) NOT NULL DEFAULT '0' COMMENT '0=created by super admin',
  `StatusID` int(11) NOT NULL,
  `CreatedDateTime` datetime NOT NULL,
  `ModifyDateTime` datetime NOT NULL,
  PRIMARY KEY (`ChecksID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `SCP_Checks`
--

INSERT INTO `SCP_Checks` VALUES(1, 'Test Check', 'Test Check', 4, 1, '2017-06-14 00:08:30', '2017-06-14 00:08:30');
INSERT INTO `SCP_Checks` VALUES(2, 'test chk admin', 'test chk admin', 0, 1, '2017-06-15 18:25:29', '2017-06-15 18:25:29');
INSERT INTO `SCP_Checks` VALUES(3, 'DBS', 'Police record', 9, 1, '2017-06-15 14:12:58', '2017-06-15 14:12:58');
INSERT INTO `SCP_Checks` VALUES(4, 'Superadmin DBS', 'superadmin', 0, 1, '2017-06-16 02:45:57', '2017-06-16 02:45:57');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Checks_Staff`
--

CREATE TABLE `SCP_Checks_Staff` (
  `ChecksAssignID` int(11) NOT NULL AUTO_INCREMENT,
  `StaffID` int(11) NOT NULL,
  `ChecksID` int(11) NOT NULL,
  `StatusID` int(11) NOT NULL,
  `OrgID` int(11) NOT NULL,
  `CreatedDateTime` datetime NOT NULL,
  `ModifyDateTime` datetime NOT NULL,
  PRIMARY KEY (`ChecksAssignID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `SCP_Checks_Staff`
--

INSERT INTO `SCP_Checks_Staff` VALUES(2, 35, 3, 1, 9, '2017-06-18 16:16:20', '2017-06-18 16:16:20');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Country`
--

CREATE TABLE `SCP_Country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sortname` varchar(3) NOT NULL,
  `country` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=247 ;

--
-- Dumping data for table `SCP_Country`
--

INSERT INTO `SCP_Country` VALUES(1, 'AF', 'Afghanistan');
INSERT INTO `SCP_Country` VALUES(2, 'AL', 'Albania');
INSERT INTO `SCP_Country` VALUES(3, 'DZ', 'Algeria');
INSERT INTO `SCP_Country` VALUES(4, 'AS', 'American Samoa');
INSERT INTO `SCP_Country` VALUES(5, 'AD', 'Andorra');
INSERT INTO `SCP_Country` VALUES(6, 'AO', 'Angola');
INSERT INTO `SCP_Country` VALUES(7, 'AI', 'Anguilla');
INSERT INTO `SCP_Country` VALUES(8, 'AQ', 'Antarctica');
INSERT INTO `SCP_Country` VALUES(9, 'AG', 'Antigua And Barbuda');
INSERT INTO `SCP_Country` VALUES(10, 'AR', 'Argentina');
INSERT INTO `SCP_Country` VALUES(11, 'AM', 'Armenia');
INSERT INTO `SCP_Country` VALUES(12, 'AW', 'Aruba');
INSERT INTO `SCP_Country` VALUES(13, 'AU', 'Australia');
INSERT INTO `SCP_Country` VALUES(14, 'AT', 'Austria');
INSERT INTO `SCP_Country` VALUES(15, 'AZ', 'Azerbaijan');
INSERT INTO `SCP_Country` VALUES(16, 'BS', 'Bahamas The');
INSERT INTO `SCP_Country` VALUES(17, 'BH', 'Bahrain');
INSERT INTO `SCP_Country` VALUES(18, 'BD', 'Bangladesh');
INSERT INTO `SCP_Country` VALUES(19, 'BB', 'Barbados');
INSERT INTO `SCP_Country` VALUES(20, 'BY', 'Belarus');
INSERT INTO `SCP_Country` VALUES(21, 'BE', 'Belgium');
INSERT INTO `SCP_Country` VALUES(22, 'BZ', 'Belize');
INSERT INTO `SCP_Country` VALUES(23, 'BJ', 'Benin');
INSERT INTO `SCP_Country` VALUES(24, 'BM', 'Bermuda');
INSERT INTO `SCP_Country` VALUES(25, 'BT', 'Bhutan');
INSERT INTO `SCP_Country` VALUES(26, 'BO', 'Bolivia');
INSERT INTO `SCP_Country` VALUES(27, 'BA', 'Bosnia and Herzegovina');
INSERT INTO `SCP_Country` VALUES(28, 'BW', 'Botswana');
INSERT INTO `SCP_Country` VALUES(29, 'BV', 'Bouvet Island');
INSERT INTO `SCP_Country` VALUES(30, 'BR', 'Brazil');
INSERT INTO `SCP_Country` VALUES(31, 'IO', 'British Indian Ocean Territory');
INSERT INTO `SCP_Country` VALUES(32, 'BN', 'Brunei');
INSERT INTO `SCP_Country` VALUES(33, 'BG', 'Bulgaria');
INSERT INTO `SCP_Country` VALUES(34, 'BF', 'Burkina Faso');
INSERT INTO `SCP_Country` VALUES(35, 'BI', 'Burundi');
INSERT INTO `SCP_Country` VALUES(36, 'KH', 'Cambodia');
INSERT INTO `SCP_Country` VALUES(37, 'CM', 'Cameroon');
INSERT INTO `SCP_Country` VALUES(38, 'CA', 'Canada');
INSERT INTO `SCP_Country` VALUES(39, 'CV', 'Cape Verde');
INSERT INTO `SCP_Country` VALUES(40, 'KY', 'Cayman Islands');
INSERT INTO `SCP_Country` VALUES(41, 'CF', 'Central African Republic');
INSERT INTO `SCP_Country` VALUES(42, 'TD', 'Chad');
INSERT INTO `SCP_Country` VALUES(43, 'CL', 'Chile');
INSERT INTO `SCP_Country` VALUES(44, 'CN', 'China');
INSERT INTO `SCP_Country` VALUES(45, 'CX', 'Christmas Island');
INSERT INTO `SCP_Country` VALUES(46, 'CC', 'Cocos (Keeling) Islands');
INSERT INTO `SCP_Country` VALUES(47, 'CO', 'Colombia');
INSERT INTO `SCP_Country` VALUES(48, 'KM', 'Comoros');
INSERT INTO `SCP_Country` VALUES(49, 'CG', 'Congo');
INSERT INTO `SCP_Country` VALUES(50, 'CD', 'Congo The Democratic Republic Of The');
INSERT INTO `SCP_Country` VALUES(51, 'CK', 'Cook Islands');
INSERT INTO `SCP_Country` VALUES(52, 'CR', 'Costa Rica');
INSERT INTO `SCP_Country` VALUES(53, 'CI', 'Cote D''Ivoire (Ivory Coast)');
INSERT INTO `SCP_Country` VALUES(54, 'HR', 'Croatia (Hrvatska)');
INSERT INTO `SCP_Country` VALUES(55, 'CU', 'Cuba');
INSERT INTO `SCP_Country` VALUES(56, 'CY', 'Cyprus');
INSERT INTO `SCP_Country` VALUES(57, 'CZ', 'Czech Republic');
INSERT INTO `SCP_Country` VALUES(58, 'DK', 'Denmark');
INSERT INTO `SCP_Country` VALUES(59, 'DJ', 'Djibouti');
INSERT INTO `SCP_Country` VALUES(60, 'DM', 'Dominica');
INSERT INTO `SCP_Country` VALUES(61, 'DO', 'Dominican Republic');
INSERT INTO `SCP_Country` VALUES(62, 'TP', 'East Timor');
INSERT INTO `SCP_Country` VALUES(63, 'EC', 'Ecuador');
INSERT INTO `SCP_Country` VALUES(64, 'EG', 'Egypt');
INSERT INTO `SCP_Country` VALUES(65, 'SV', 'El Salvador');
INSERT INTO `SCP_Country` VALUES(66, 'GQ', 'Equatorial Guinea');
INSERT INTO `SCP_Country` VALUES(67, 'ER', 'Eritrea');
INSERT INTO `SCP_Country` VALUES(68, 'EE', 'Estonia');
INSERT INTO `SCP_Country` VALUES(69, 'ET', 'Ethiopia');
INSERT INTO `SCP_Country` VALUES(70, 'XA', 'External Territories of Australia');
INSERT INTO `SCP_Country` VALUES(71, 'FK', 'Falkland Islands');
INSERT INTO `SCP_Country` VALUES(72, 'FO', 'Faroe Islands');
INSERT INTO `SCP_Country` VALUES(73, 'FJ', 'Fiji Islands');
INSERT INTO `SCP_Country` VALUES(74, 'FI', 'Finland');
INSERT INTO `SCP_Country` VALUES(75, 'FR', 'France');
INSERT INTO `SCP_Country` VALUES(76, 'GF', 'French Guiana');
INSERT INTO `SCP_Country` VALUES(77, 'PF', 'French Polynesia');
INSERT INTO `SCP_Country` VALUES(78, 'TF', 'French Southern Territories');
INSERT INTO `SCP_Country` VALUES(79, 'GA', 'Gabon');
INSERT INTO `SCP_Country` VALUES(80, 'GM', 'Gambia The');
INSERT INTO `SCP_Country` VALUES(81, 'GE', 'Georgia');
INSERT INTO `SCP_Country` VALUES(82, 'DE', 'Germany');
INSERT INTO `SCP_Country` VALUES(83, 'GH', 'Ghana');
INSERT INTO `SCP_Country` VALUES(84, 'GI', 'Gibraltar');
INSERT INTO `SCP_Country` VALUES(85, 'GR', 'Greece');
INSERT INTO `SCP_Country` VALUES(86, 'GL', 'Greenland');
INSERT INTO `SCP_Country` VALUES(87, 'GD', 'Grenada');
INSERT INTO `SCP_Country` VALUES(88, 'GP', 'Guadeloupe');
INSERT INTO `SCP_Country` VALUES(89, 'GU', 'Guam');
INSERT INTO `SCP_Country` VALUES(90, 'GT', 'Guatemala');
INSERT INTO `SCP_Country` VALUES(91, 'XU', 'Guernsey and Alderney');
INSERT INTO `SCP_Country` VALUES(92, 'GN', 'Guinea');
INSERT INTO `SCP_Country` VALUES(93, 'GW', 'Guinea-Bissau');
INSERT INTO `SCP_Country` VALUES(94, 'GY', 'Guyana');
INSERT INTO `SCP_Country` VALUES(95, 'HT', 'Haiti');
INSERT INTO `SCP_Country` VALUES(96, 'HM', 'Heard and McDonald Islands');
INSERT INTO `SCP_Country` VALUES(97, 'HN', 'Honduras');
INSERT INTO `SCP_Country` VALUES(98, 'HK', 'Hong Kong S.A.R.');
INSERT INTO `SCP_Country` VALUES(99, 'HU', 'Hungary');
INSERT INTO `SCP_Country` VALUES(100, 'IS', 'Iceland');
INSERT INTO `SCP_Country` VALUES(101, 'IN', 'India');
INSERT INTO `SCP_Country` VALUES(102, 'ID', 'Indonesia');
INSERT INTO `SCP_Country` VALUES(103, 'IR', 'Iran');
INSERT INTO `SCP_Country` VALUES(104, 'IQ', 'Iraq');
INSERT INTO `SCP_Country` VALUES(105, 'IE', 'Ireland');
INSERT INTO `SCP_Country` VALUES(106, 'IL', 'Israel');
INSERT INTO `SCP_Country` VALUES(107, 'IT', 'Italy');
INSERT INTO `SCP_Country` VALUES(108, 'JM', 'Jamaica');
INSERT INTO `SCP_Country` VALUES(109, 'JP', 'Japan');
INSERT INTO `SCP_Country` VALUES(110, 'XJ', 'Jersey');
INSERT INTO `SCP_Country` VALUES(111, 'JO', 'Jordan');
INSERT INTO `SCP_Country` VALUES(112, 'KZ', 'Kazakhstan');
INSERT INTO `SCP_Country` VALUES(113, 'KE', 'Kenya');
INSERT INTO `SCP_Country` VALUES(114, 'KI', 'Kiribati');
INSERT INTO `SCP_Country` VALUES(115, 'KP', 'Korea North');
INSERT INTO `SCP_Country` VALUES(116, 'KR', 'Korea South');
INSERT INTO `SCP_Country` VALUES(117, 'KW', 'Kuwait');
INSERT INTO `SCP_Country` VALUES(118, 'KG', 'Kyrgyzstan');
INSERT INTO `SCP_Country` VALUES(119, 'LA', 'Laos');
INSERT INTO `SCP_Country` VALUES(120, 'LV', 'Latvia');
INSERT INTO `SCP_Country` VALUES(121, 'LB', 'Lebanon');
INSERT INTO `SCP_Country` VALUES(122, 'LS', 'Lesotho');
INSERT INTO `SCP_Country` VALUES(123, 'LR', 'Liberia');
INSERT INTO `SCP_Country` VALUES(124, 'LY', 'Libya');
INSERT INTO `SCP_Country` VALUES(125, 'LI', 'Liechtenstein');
INSERT INTO `SCP_Country` VALUES(126, 'LT', 'Lithuania');
INSERT INTO `SCP_Country` VALUES(127, 'LU', 'Luxembourg');
INSERT INTO `SCP_Country` VALUES(128, 'MO', 'Macau S.A.R.');
INSERT INTO `SCP_Country` VALUES(129, 'MK', 'Macedonia');
INSERT INTO `SCP_Country` VALUES(130, 'MG', 'Madagascar');
INSERT INTO `SCP_Country` VALUES(131, 'MW', 'Malawi');
INSERT INTO `SCP_Country` VALUES(132, 'MY', 'Malaysia');
INSERT INTO `SCP_Country` VALUES(133, 'MV', 'Maldives');
INSERT INTO `SCP_Country` VALUES(134, 'ML', 'Mali');
INSERT INTO `SCP_Country` VALUES(135, 'MT', 'Malta');
INSERT INTO `SCP_Country` VALUES(136, 'XM', 'Man (Isle of)');
INSERT INTO `SCP_Country` VALUES(137, 'MH', 'Marshall Islands');
INSERT INTO `SCP_Country` VALUES(138, 'MQ', 'Martinique');
INSERT INTO `SCP_Country` VALUES(139, 'MR', 'Mauritania');
INSERT INTO `SCP_Country` VALUES(140, 'MU', 'Mauritius');
INSERT INTO `SCP_Country` VALUES(141, 'YT', 'Mayotte');
INSERT INTO `SCP_Country` VALUES(142, 'MX', 'Mexico');
INSERT INTO `SCP_Country` VALUES(143, 'FM', 'Micronesia');
INSERT INTO `SCP_Country` VALUES(144, 'MD', 'Moldova');
INSERT INTO `SCP_Country` VALUES(145, 'MC', 'Monaco');
INSERT INTO `SCP_Country` VALUES(146, 'MN', 'Mongolia');
INSERT INTO `SCP_Country` VALUES(147, 'MS', 'Montserrat');
INSERT INTO `SCP_Country` VALUES(148, 'MA', 'Morocco');
INSERT INTO `SCP_Country` VALUES(149, 'MZ', 'Mozambique');
INSERT INTO `SCP_Country` VALUES(150, 'MM', 'Myanmar');
INSERT INTO `SCP_Country` VALUES(151, 'NA', 'Namibia');
INSERT INTO `SCP_Country` VALUES(152, 'NR', 'Nauru');
INSERT INTO `SCP_Country` VALUES(153, 'NP', 'Nepal');
INSERT INTO `SCP_Country` VALUES(154, 'AN', 'Netherlands Antilles');
INSERT INTO `SCP_Country` VALUES(155, 'NL', 'Netherlands The');
INSERT INTO `SCP_Country` VALUES(156, 'NC', 'New Caledonia');
INSERT INTO `SCP_Country` VALUES(157, 'NZ', 'New Zealand');
INSERT INTO `SCP_Country` VALUES(158, 'NI', 'Nicaragua');
INSERT INTO `SCP_Country` VALUES(159, 'NE', 'Niger');
INSERT INTO `SCP_Country` VALUES(160, 'NG', 'Nigeria');
INSERT INTO `SCP_Country` VALUES(161, 'NU', 'Niue');
INSERT INTO `SCP_Country` VALUES(162, 'NF', 'Norfolk Island');
INSERT INTO `SCP_Country` VALUES(163, 'MP', 'Northern Mariana Islands');
INSERT INTO `SCP_Country` VALUES(164, 'NO', 'Norway');
INSERT INTO `SCP_Country` VALUES(165, 'OM', 'Oman');
INSERT INTO `SCP_Country` VALUES(166, 'PK', 'Pakistan');
INSERT INTO `SCP_Country` VALUES(167, 'PW', 'Palau');
INSERT INTO `SCP_Country` VALUES(168, 'PS', 'Palestinian Territory Occupied');
INSERT INTO `SCP_Country` VALUES(169, 'PA', 'Panama');
INSERT INTO `SCP_Country` VALUES(170, 'PG', 'Papua new Guinea');
INSERT INTO `SCP_Country` VALUES(171, 'PY', 'Paraguay');
INSERT INTO `SCP_Country` VALUES(172, 'PE', 'Peru');
INSERT INTO `SCP_Country` VALUES(173, 'PH', 'Philippines');
INSERT INTO `SCP_Country` VALUES(174, 'PN', 'Pitcairn Island');
INSERT INTO `SCP_Country` VALUES(175, 'PL', 'Poland');
INSERT INTO `SCP_Country` VALUES(176, 'PT', 'Portugal');
INSERT INTO `SCP_Country` VALUES(177, 'PR', 'Puerto Rico');
INSERT INTO `SCP_Country` VALUES(178, 'QA', 'Qatar');
INSERT INTO `SCP_Country` VALUES(179, 'RE', 'Reunion');
INSERT INTO `SCP_Country` VALUES(180, 'RO', 'Romania');
INSERT INTO `SCP_Country` VALUES(181, 'RU', 'Russia');
INSERT INTO `SCP_Country` VALUES(182, 'RW', 'Rwanda');
INSERT INTO `SCP_Country` VALUES(183, 'SH', 'Saint Helena');
INSERT INTO `SCP_Country` VALUES(184, 'KN', 'Saint Kitts And Nevis');
INSERT INTO `SCP_Country` VALUES(185, 'LC', 'Saint Lucia');
INSERT INTO `SCP_Country` VALUES(186, 'PM', 'Saint Pierre and Miquelon');
INSERT INTO `SCP_Country` VALUES(187, 'VC', 'Saint Vincent And The Grenadines');
INSERT INTO `SCP_Country` VALUES(188, 'WS', 'Samoa');
INSERT INTO `SCP_Country` VALUES(189, 'SM', 'San Marino');
INSERT INTO `SCP_Country` VALUES(190, 'ST', 'Sao Tome and Principe');
INSERT INTO `SCP_Country` VALUES(191, 'SA', 'Saudi Arabia');
INSERT INTO `SCP_Country` VALUES(192, 'SN', 'Senegal');
INSERT INTO `SCP_Country` VALUES(193, 'RS', 'Serbia');
INSERT INTO `SCP_Country` VALUES(194, 'SC', 'Seychelles');
INSERT INTO `SCP_Country` VALUES(195, 'SL', 'Sierra Leone');
INSERT INTO `SCP_Country` VALUES(196, 'SG', 'Singapore');
INSERT INTO `SCP_Country` VALUES(197, 'SK', 'Slovakia');
INSERT INTO `SCP_Country` VALUES(198, 'SI', 'Slovenia');
INSERT INTO `SCP_Country` VALUES(199, 'XG', 'Smaller Territories of the UK');
INSERT INTO `SCP_Country` VALUES(200, 'SB', 'Solomon Islands');
INSERT INTO `SCP_Country` VALUES(201, 'SO', 'Somalia');
INSERT INTO `SCP_Country` VALUES(202, 'ZA', 'South Africa');
INSERT INTO `SCP_Country` VALUES(203, 'GS', 'South Georgia');
INSERT INTO `SCP_Country` VALUES(204, 'SS', 'South Sudan');
INSERT INTO `SCP_Country` VALUES(205, 'ES', 'Spain');
INSERT INTO `SCP_Country` VALUES(206, 'LK', 'Sri Lanka');
INSERT INTO `SCP_Country` VALUES(207, 'SD', 'Sudan');
INSERT INTO `SCP_Country` VALUES(208, 'SR', 'Suriname');
INSERT INTO `SCP_Country` VALUES(209, 'SJ', 'Svalbard And Jan Mayen Islands');
INSERT INTO `SCP_Country` VALUES(210, 'SZ', 'Swaziland');
INSERT INTO `SCP_Country` VALUES(211, 'SE', 'Sweden');
INSERT INTO `SCP_Country` VALUES(212, 'CH', 'Switzerland');
INSERT INTO `SCP_Country` VALUES(213, 'SY', 'Syria');
INSERT INTO `SCP_Country` VALUES(214, 'TW', 'Taiwan');
INSERT INTO `SCP_Country` VALUES(215, 'TJ', 'Tajikistan');
INSERT INTO `SCP_Country` VALUES(216, 'TZ', 'Tanzania');
INSERT INTO `SCP_Country` VALUES(217, 'TH', 'Thailand');
INSERT INTO `SCP_Country` VALUES(218, 'TG', 'Togo');
INSERT INTO `SCP_Country` VALUES(219, 'TK', 'Tokelau');
INSERT INTO `SCP_Country` VALUES(220, 'TO', 'Tonga');
INSERT INTO `SCP_Country` VALUES(221, 'TT', 'Trinidad And Tobago');
INSERT INTO `SCP_Country` VALUES(222, 'TN', 'Tunisia');
INSERT INTO `SCP_Country` VALUES(223, 'TR', 'Turkey');
INSERT INTO `SCP_Country` VALUES(224, 'TM', 'Turkmenistan');
INSERT INTO `SCP_Country` VALUES(225, 'TC', 'Turks And Caicos Islands');
INSERT INTO `SCP_Country` VALUES(226, 'TV', 'Tuvalu');
INSERT INTO `SCP_Country` VALUES(227, 'UG', 'Uganda');
INSERT INTO `SCP_Country` VALUES(228, 'UA', 'Ukraine');
INSERT INTO `SCP_Country` VALUES(229, 'AE', 'United Arab Emirates');
INSERT INTO `SCP_Country` VALUES(230, 'GB', 'United Kingdom');
INSERT INTO `SCP_Country` VALUES(231, 'US', 'United States');
INSERT INTO `SCP_Country` VALUES(232, 'UM', 'United States Minor Outlying Islands');
INSERT INTO `SCP_Country` VALUES(233, 'UY', 'Uruguay');
INSERT INTO `SCP_Country` VALUES(234, 'UZ', 'Uzbekistan');
INSERT INTO `SCP_Country` VALUES(235, 'VU', 'Vanuatu');
INSERT INTO `SCP_Country` VALUES(236, 'VA', 'Vatican City State (Holy See)');
INSERT INTO `SCP_Country` VALUES(237, 'VE', 'Venezuela');
INSERT INTO `SCP_Country` VALUES(238, 'VN', 'Vietnam');
INSERT INTO `SCP_Country` VALUES(239, 'VG', 'Virgin Islands (British)');
INSERT INTO `SCP_Country` VALUES(240, 'VI', 'Virgin Islands (US)');
INSERT INTO `SCP_Country` VALUES(241, 'WF', 'Wallis And Futuna Islands');
INSERT INTO `SCP_Country` VALUES(242, 'EH', 'Western Sahara');
INSERT INTO `SCP_Country` VALUES(243, 'YE', 'Yemen');
INSERT INTO `SCP_Country` VALUES(244, 'YU', 'Yugoslavia');
INSERT INTO `SCP_Country` VALUES(245, 'ZM', 'Zambia');
INSERT INTO `SCP_Country` VALUES(246, 'ZW', 'Zimbabwe');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Customer`
--

CREATE TABLE `SCP_Customer` (
  `CustomerID` int(11) NOT NULL AUTO_INCREMENT,
  `CustomerTitle` varchar(150) NOT NULL,
  `CustomerName` varchar(150) DEFAULT NULL,
  `CustomerSurname` varchar(150) NOT NULL,
  `CustomerMiddleName` varchar(150) NOT NULL,
  `DateOfBirth` varchar(40) NOT NULL,
  `NHSNumber` varchar(150) NOT NULL,
  `Gender` varchar(40) NOT NULL,
  `Ethnicity` varchar(150) NOT NULL,
  `Address1` varchar(150) NOT NULL,
  `Address2` varchar(150) NOT NULL,
  `PostCode` varchar(9) NOT NULL,
  `City` varchar(150) NOT NULL,
  `Landline` varchar(150) NOT NULL,
  `UserID` int(11) DEFAULT NULL,
  `ContactNo` varchar(150) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `OtherDetails` varchar(150) DEFAULT NULL,
  `CareInfo` varchar(150) NOT NULL,
  `OutcomesInfo` varchar(150) NOT NULL,
  `SupportInfo` varchar(150) NOT NULL,
  `MakeEnq` varchar(150) NOT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `SCP_Customer`
--

INSERT INTO `SCP_Customer` VALUES(8, 'Mr', 'Martin', 'Martin', 'Martin', '2017-09-28T18:30:00.000Z', '123', 'Male', '', 'Indore', '', '4AA5 5AQ5', 'Indore', '1234567890', 18, '1234567890', 1, 'Hi', 'Hi', 'Hi', 'Medication', 'self', '2017-05-15 16:13:58', '2017-05-15 16:13:58');
INSERT INTO `SCP_Customer` VALUES(9, 'Mr', 'kn', 'nk', 'm', '2017-06-06T23:00:00.000Z', '0909090', 'Male', '', 'mmm', '', 'U8UU U', 'll', '', 84, '9999999999', 1, 'nklnk', 'kj', 'm', 'Medication', 'Other', '2017-06-18 16:12:20', '2017-06-18 16:12:20');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Documents`
--

CREATE TABLE `SCP_Documents` (
  `DocumentID` int(11) NOT NULL AUTO_INCREMENT,
  `CustomerID` int(11) DEFAULT NULL,
  `DocumentTypeID` int(11) DEFAULT NULL,
  `DocumentUrl` varchar(150) DEFAULT NULL,
  `StaffID` int(11) DEFAULT NULL,
  `Version` varchar(150) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`DocumentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `SCP_Documents`
--


-- --------------------------------------------------------

--
-- Table structure for table `SCP_DocumentType`
--

CREATE TABLE `SCP_DocumentType` (
  `DocumentTypeID` int(11) NOT NULL,
  `Typename` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`DocumentTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SCP_DocumentType`
--


-- --------------------------------------------------------

--
-- Table structure for table `SCP_Enquiry`
--

CREATE TABLE `SCP_Enquiry` (
  `EnquiryID` int(11) NOT NULL AUTO_INCREMENT,
  `OrgID` int(11) NOT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`EnquiryID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `SCP_Enquiry`
--

INSERT INTO `SCP_Enquiry` VALUES(1, 9, 1, 1, '2017-04-24 12:34:17', '2017-04-24 12:34:17');
INSERT INTO `SCP_Enquiry` VALUES(2, 9, 2, 1, '2017-04-24 12:34:19', '2017-04-24 12:34:19');
INSERT INTO `SCP_Enquiry` VALUES(3, 9, 3, 1, '2017-04-24 12:34:24', '2017-04-24 12:34:24');
INSERT INTO `SCP_Enquiry` VALUES(4, 9, 4, 1, '2017-04-24 12:34:27', '2017-04-24 12:34:27');
INSERT INTO `SCP_Enquiry` VALUES(5, 9, 5, 1, '2017-04-24 12:34:30', '2017-04-24 12:34:30');
INSERT INTO `SCP_Enquiry` VALUES(6, 9, 6, 1, '2017-04-24 12:34:34', '2017-04-24 12:34:34');
INSERT INTO `SCP_Enquiry` VALUES(7, 9, 7, 1, '2017-04-24 12:34:42', '2017-04-24 12:34:42');
INSERT INTO `SCP_Enquiry` VALUES(8, 9, 8, 1, '2017-05-15 16:13:58', '2017-05-15 16:13:58');
INSERT INTO `SCP_Enquiry` VALUES(9, 9, 9, 1, '2017-05-15 16:14:09', '2017-05-15 16:14:09');
INSERT INTO `SCP_Enquiry` VALUES(10, 9, 10, 1, '2017-05-15 16:14:54', '2017-05-15 16:14:54');
INSERT INTO `SCP_Enquiry` VALUES(11, 13, 11, 1, '2017-06-08 02:40:11', '2017-06-08 02:40:11');
INSERT INTO `SCP_Enquiry` VALUES(12, 4, 12, 1, '2017-06-08 02:54:11', '2017-06-08 02:54:11');
INSERT INTO `SCP_Enquiry` VALUES(13, 9, 9, 1, '2017-06-18 16:12:20', '2017-06-18 16:12:20');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Equipments`
--

CREATE TABLE `SCP_Equipments` (
  `EquipmentID` int(11) NOT NULL AUTO_INCREMENT,
  `Equipment` varchar(150) NOT NULL,
  `Description` varchar(150) NOT NULL,
  `OrgID` int(11) NOT NULL DEFAULT '0' COMMENT '0=created by super admin',
  `StatusID` int(11) NOT NULL,
  `CreatedDateTime` datetime NOT NULL,
  `ModifyDateTime` datetime NOT NULL,
  PRIMARY KEY (`EquipmentID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

--
-- Dumping data for table `SCP_Equipments`
--

INSERT INTO `SCP_Equipments` VALUES(1, 'safari equipment', 'safari equipment1', 4, 1, '2017-06-10 02:14:56', '2017-06-10 02:14:56');
INSERT INTO `SCP_Equipments` VALUES(2, 'Safari2', 'safari2', 4, 1, '2017-06-10 02:35:06', '2017-06-10 02:35:06');
INSERT INTO `SCP_Equipments` VALUES(3, 'safari2', 'safari2', 4, 1, '2017-06-10 02:35:22', '2017-06-10 02:35:22');
INSERT INTO `SCP_Equipments` VALUES(4, 'fire fox equipment1', 'fire fox equipment1', 5, 1, '2017-06-10 03:13:14', '2017-06-10 03:13:36');
INSERT INTO `SCP_Equipments` VALUES(5, 'fire fox equipment2', 'fire fox equipment2', 5, 1, '2017-06-10 03:14:22', '2017-06-10 03:14:22');
INSERT INTO `SCP_Equipments` VALUES(6, '1', '2', 4, 1, '2017-06-10 03:17:00', '2017-06-10 03:17:00');
INSERT INTO `SCP_Equipments` VALUES(7, 'ie1', 'ie1', 4, 1, '2017-06-10 03:33:15', '2017-06-10 03:33:15');
INSERT INTO `SCP_Equipments` VALUES(8, 'ie2', 'ie2', 4, 2, '2017-06-10 03:34:27', '2017-06-10 03:34:27');
INSERT INTO `SCP_Equipments` VALUES(9, 'abc123', '12345', 4, 1, '2017-06-11 22:13:56', '2017-06-11 22:13:56');
INSERT INTO `SCP_Equipments` VALUES(10, 'abc', '12345', 4, 1, '2017-06-11 22:14:14', '2017-06-11 22:14:23');
INSERT INTO `SCP_Equipments` VALUES(11, 'sdfsdf', 'cvzxvxvcv', 4, 1, '2017-06-11 22:42:31', '2017-06-11 22:42:31');
INSERT INTO `SCP_Equipments` VALUES(12, 'final', 'final', 4, 1, '2017-06-14 00:18:23', '2017-06-14 00:18:23');
INSERT INTO `SCP_Equipments` VALUES(13, 'final', 'final', 4, 1, '2017-06-14 00:18:30', '2017-06-14 00:18:30');
INSERT INTO `SCP_Equipments` VALUES(14, 'final', 'final', 4, 1, '2017-06-14 00:19:24', '2017-06-14 00:19:24');
INSERT INTO `SCP_Equipments` VALUES(15, 'test eq admin', 'test eq admin', 0, 1, '2017-06-15 18:24:55', '2017-06-15 18:24:55');
INSERT INTO `SCP_Equipments` VALUES(16, 'Mobile', 'Sony', 9, 1, '2017-06-15 14:12:33', '2017-06-15 14:12:33');
INSERT INTO `SCP_Equipments` VALUES(17, 'DBS superadmin', 'superadmin', 0, 1, '2017-06-16 02:45:34', '2017-06-16 02:45:34');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Equipments_Staff`
--

CREATE TABLE `SCP_Equipments_Staff` (
  `EquipmentsAssignID` int(11) NOT NULL AUTO_INCREMENT,
  `StaffID` int(11) NOT NULL,
  `EquipmentID` int(11) NOT NULL,
  `StatusID` int(11) NOT NULL,
  `OrgID` int(11) NOT NULL,
  `CreatedDateTime` datetime NOT NULL,
  `ModifyDateTime` datetime NOT NULL,
  PRIMARY KEY (`EquipmentsAssignID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

--
-- Dumping data for table `SCP_Equipments_Staff`
--

INSERT INTO `SCP_Equipments_Staff` VALUES(14, 33, 0, 1, 9, '2017-06-12 08:25:35', '2017-06-12 08:25:35');
INSERT INTO `SCP_Equipments_Staff` VALUES(11, 32, 7, 2, 4, '2017-06-11 22:42:19', '2017-06-11 22:42:19');
INSERT INTO `SCP_Equipments_Staff` VALUES(17, 29, 11, 1, 4, '2017-06-14 00:16:49', '2017-06-14 00:16:49');
INSERT INTO `SCP_Equipments_Staff` VALUES(9, 5, 0, 1, 11, '2017-06-10 15:26:00', '2017-06-10 15:26:00');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_FormBuilder`
--

CREATE TABLE `SCP_FormBuilder` (
  `FormID` int(11) NOT NULL AUTO_INCREMENT,
  `FormDataID` varchar(156) NOT NULL,
  `FormName` varchar(156) NOT NULL,
  `FormDataJson` longtext NOT NULL,
  `FormDataJsonValue` longtext NOT NULL,
  `UserID` int(11) NOT NULL,
  `UserTypeID` int(11) NOT NULL,
  `StatusID` int(11) NOT NULL,
  `CreatedDateTime` datetime NOT NULL,
  `ModifyDateTime` datetime NOT NULL,
  PRIMARY KEY (`FormID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=61 ;

--
-- Dumping data for table `SCP_FormBuilder`
--

INSERT INTO `SCP_FormBuilder` VALUES(12, 'FORM1494333149', 'My Form', '[{"component":"header","editable":true,"index":0,"label":"My Form","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Single line input","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textArea","editable":true,"index":2,"label":"Multi line input","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"select","editable":true,"index":3,"label":"Dropdown","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false},{"component":"radio","editable":true,"index":4,"label":"Radio","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false},{"component":"checkbox","editable":true,"index":5,"label":"Checkbox","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false},{"component":"date","editable":true,"index":6,"label":"Date","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"file","editable":true,"index":7,"label":"Image","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"postCode","editable":true,"index":8,"label":"Postal Code","value":"","description":"","placeholder":"","options":[],"required":false}]', '[{"label":"My Form","value":""},{"label":"Image","value":""},{"label":"Postal Code","value":""},{"label":"Dropdown","value":"value one"}]', 1, 4, 1, '2017-05-09 18:02:29', '2017-06-06 15:30:51');
INSERT INTO `SCP_FormBuilder` VALUES(49, 'FORM1496906752', 'Form 1', '[{"component":"header","editable":true,"index":0,"label":"Form 1","value":"","description":"","placeholder":"Title","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Single Line Input","value":"","description":"Form for chrome Form for chrome Form for chrome Form for chrome Form for chrome","placeholder":"Single line input","options":[],"required":true},{"component":"textArea","editable":true,"index":2,"label":"Multi line input","value":"","description":"Form for Form for chrome Form for chrome Form for chrome Form for chrome Form for chrome","placeholder":"Multi line Form","options":[],"required":true},{"component":"select","editable":true,"index":3,"label":"Dropdown","value":"","description":"","placeholder":"Dropdown","options":["value one","value two","value three","value four"],"required":false},{"component":"radio","editable":true,"index":4,"label":"Radio","value":"","description":"Form for chrome","placeholder":"Radio","options":["value one","value two","chrome Form"],"required":false},{"component":"checkbox","editable":true,"index":5,"label":"Checkbox","value":"","description":"","placeholder":"Checkbox","options":["value one","value two","chrome Form"],"required":true},{"component":"date","editable":true,"index":6,"label":"Date Form","value":"","description":"","placeholder":"dd-mm-yyyy","options":[],"required":true},{"component":"signature","editable":true,"index":7,"label":"Signature","value":"","description":"","placeholder":"Signature","options":[],"required":true},{"component":"file","editable":true,"index":8,"label":"File","value":"","description":"","placeholder":"File","options":[],"required":true},{"component":"postCode","editable":true,"index":9,"label":"Postal Code","value":"","description":"","placeholder":"","options":[],"required":true}]', '[{"label":"Form for chrome Form for chrome Form for chrome Form for chrome Form for chrome Form for chrome Form","value":""},{"label":"Single line input Form for chrome Form for chrome Form for chrome Form for chrome Form for chrome Fo","value":""},{"label":"Multi line input Form for chrome Form for chrome Form for chrome Form for chrome Form for chrome","value":""},{"label":"Dropdown Form for chrome Form for chrome Form for chrome Form for chrome Form for chrome Form for ch","value":"value one"},{"label":"Radio","value":"value one"},{"label":"CheckboxForm for chrome Form for chrome Form for chrome Form for chrome Form for chrome Form for chr","value":""},{"label":"Date Form for chrome Form for chrome Form for chrome Form for chrome Form for chrome Form for chrome","value":""},{"label":"Signature Form for chrome Form for chrome Form for chrome Form for chrome Form for chrome Form for c","value":""},{"label":"File Form for chrome Form for chrome Form for chrome Form for chrome Form for chrome Form for chrome","value":""},{"label":"Postal Code Form for chrome Form for chrome Form for chrome Form for chrome Form for chrome Form for","value":""}]', 1, 4, 1, '2017-06-08 12:55:52', '2017-06-12 13:45:18');
INSERT INTO `SCP_FormBuilder` VALUES(59, 'FORM1497385997', 'Confirmation for Service User', '[{"component":"header","editable":true,"index":0,"label":"Confirmation for Service User","value":"","description":"","placeholder":"Title","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Who is giving permission","value":"","description":"","placeholder":"","options":[],"required":false},{"component":"date","editable":true,"index":2,"label":"Date","value":"","description":"","placeholder":"dd-mm-yyyy","options":[],"required":false},{"component":"signature","editable":true,"index":3,"label":"Signature","value":"","description":"","placeholder":"Signature","options":[],"required":false},{"component":"radio","editable":true,"index":4,"label":"Was NOK present","value":"","description":"","placeholder":"Radio","options":["YES","NO"],"required":false}]', '[{"label":"Confirmation for Service User","value":""},{"label":"Who is giving permission","value":""},{"label":"Date","value":""},{"label":"Signature","value":""},{"label":"Was NOK present","value":"value one"}]', 1, 4, 1, '2017-06-14 02:03:17', '2017-06-14 02:03:17');
INSERT INTO `SCP_FormBuilder` VALUES(60, 'FORM1497386533', 'Incident form', '[{"component":"header","editable":true,"index":0,"label":"Incident form","value":"","description":"","placeholder":"Title","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"The following form will be required for completion in case of emergency","value":"","description":"","placeholder":"Please complete","options":[],"required":false}]', '[{"label":"Incident form","value":""},{"label":"The following form will be required for completion in case of emergency","value":""}]', 1, 5, 1, '2017-06-14 02:12:13', '2017-06-14 02:12:13');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Groups`
--

CREATE TABLE `SCP_Groups` (
  `GroupID` int(11) NOT NULL AUTO_INCREMENT,
  `GroupName` varchar(150) NOT NULL,
  `OrgID` int(11) NOT NULL,
  `StatusID` int(11) NOT NULL,
  `CreatedDateTime` datetime NOT NULL,
  `ModifyDateTime` datetime NOT NULL,
  PRIMARY KEY (`GroupID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `SCP_Groups`
--

INSERT INTO `SCP_Groups` VALUES(1, 'tests group', 9, 1, '2017-06-14 06:44:38', '2017-06-14 06:45:27');
INSERT INTO `SCP_Groups` VALUES(2, 'testing group', 4, 1, '2017-06-14 06:46:13', '2017-06-14 06:46:13');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Groups_Staff`
--

CREATE TABLE `SCP_Groups_Staff` (
  `GroupAssignID` int(11) NOT NULL AUTO_INCREMENT,
  `StaffID` int(11) NOT NULL,
  `GroupID` int(11) NOT NULL,
  `StatusID` int(11) NOT NULL,
  `OrgID` int(11) NOT NULL,
  `CreatedDateTime` datetime NOT NULL,
  `ModifyDateTime` datetime NOT NULL,
  PRIMARY KEY (`GroupAssignID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `SCP_Groups_Staff`
--

INSERT INTO `SCP_Groups_Staff` VALUES(1, 29, 2, 1, 4, '2017-06-14 06:46:34', '2017-06-14 06:46:34');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Licenses`
--

CREATE TABLE `SCP_Licenses` (
  `LicenseID` int(11) NOT NULL AUTO_INCREMENT,
  `LicenseKey` varchar(150) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `OrgID` int(11) DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`LicenseID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=97 ;

--
-- Dumping data for table `SCP_Licenses`
--

INSERT INTO `SCP_Licenses` VALUES(1, 'A0B91B95F60B96C5AD1679EF21EE865F', 1, 4, 13, '2017-04-03 10:50:50', '2017-04-03 14:09:00');
INSERT INTO `SCP_Licenses` VALUES(2, 'C5F244AAC866E5C9621CCE1F805BFA85', 1, 5, 14, '2017-04-03 10:50:50', '2017-04-04 13:12:54');
INSERT INTO `SCP_Licenses` VALUES(3, '75965C9E626C07D38A729B57562C98FA', 1, 6, 15, '2017-04-03 10:50:50', '2017-04-04 13:15:12');
INSERT INTO `SCP_Licenses` VALUES(4, 'A92E74051E2A902203A604E48959A2CE', 2, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50');
INSERT INTO `SCP_Licenses` VALUES(5, '058FA88D2581BFD30324728A6D6AA589', 2, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50');
INSERT INTO `SCP_Licenses` VALUES(6, '1B44B241C852ECDB1C5730C0F0D72569', 1, 8, 16, '2017-04-03 10:50:50', '2017-04-05 17:46:32');
INSERT INTO `SCP_Licenses` VALUES(7, 'F6A97F0A8F6CC552993A05888886B997', 1, 9, 17, '2017-04-03 10:50:50', '2017-04-19 18:43:28');
INSERT INTO `SCP_Licenses` VALUES(8, '33FA172C28175FEFFCF302C3954779B1', 1, 9, 21, '2017-04-03 10:50:50', '2017-04-03 10:50:50');
INSERT INTO `SCP_Licenses` VALUES(9, '1FA414DD5DAEBD4CF325A965A1B4924E', 1, 10, 24, '2017-04-03 10:50:50', '2017-05-27 14:57:50');
INSERT INTO `SCP_Licenses` VALUES(10, 'E6B703C25D137F6492EF6E56FA5918AF', 1, 11, 25, '2017-04-03 10:50:50', '2017-05-29 13:07:31');
INSERT INTO `SCP_Licenses` VALUES(11, '3A083B958D1F3E18917DD394C136F185', 1, 11, 26, '2017-04-03 10:50:50', '2017-04-03 10:50:50');
INSERT INTO `SCP_Licenses` VALUES(12, '266EF60AAD3898B2FE553C0E0A3D90ED', 1, 11, 27, '2017-04-03 10:50:50', '2017-04-03 10:50:50');
INSERT INTO `SCP_Licenses` VALUES(31, '69AC9D31B9EA95A917BCB2F136E9C575', 1, 20, 46, '2017-04-03 10:50:50', '2017-06-08 13:47:48');
INSERT INTO `SCP_Licenses` VALUES(32, '0FAEFEB5E9B702C4DB1AFF968B4788AD', 1, 21, 47, '2017-04-03 10:50:50', '2017-06-08 13:47:48');
INSERT INTO `SCP_Licenses` VALUES(33, '7EE12BC78B8799F8FB1C14BBF1D51C34', 1, 22, 48, '2017-04-03 10:50:50', '2017-06-08 13:47:48');
INSERT INTO `SCP_Licenses` VALUES(34, '01D92E75809C780BF61C50E35235AB5E', 1, 23, 49, '2017-04-03 10:50:50', '2017-06-08 13:47:48');
INSERT INTO `SCP_Licenses` VALUES(35, '8BECC72E7237DC7767EF60F6B91378B0', 1, 24, 50, '2017-04-03 10:50:50', '2017-06-08 13:47:48');
INSERT INTO `SCP_Licenses` VALUES(36, 'FE8C75A2AAC8EAEB63E0A5970E9E7003', 1, 25, 51, '2017-04-03 10:50:50', '2017-06-08 13:47:48');
INSERT INTO `SCP_Licenses` VALUES(37, 'AE4DAC10F9AAA500869E604E6EBFA3FA', 1, 26, 52, '2017-04-03 10:50:50', '2017-06-08 13:47:56');
INSERT INTO `SCP_Licenses` VALUES(38, '9BF95029F214D21E188B9B626C1BE16D', 1, 27, 53, '2017-04-03 10:50:50', '2017-06-08 13:47:56');
INSERT INTO `SCP_Licenses` VALUES(39, 'D5BA2747ABDB2E37756B8FA00AF4C0F0', 1, 28, 54, '2017-04-03 10:50:50', '2017-06-08 13:47:56');
INSERT INTO `SCP_Licenses` VALUES(40, 'A696AA5B2AFEE673451720299D35ADB7', 1, 29, 55, '2017-04-03 10:50:50', '2017-06-08 13:47:56');
INSERT INTO `SCP_Licenses` VALUES(41, 'FCB3E237A106953EF785507AD082E8BF', 1, 30, 56, '2017-04-03 10:50:50', '2017-06-08 13:47:56');
INSERT INTO `SCP_Licenses` VALUES(42, '3A963AED0B8A6399DAF41ABA1DE689D3', 1, 31, 57, '2017-04-03 10:50:50', '2017-06-08 13:47:56');
INSERT INTO `SCP_Licenses` VALUES(43, 'AAA3E05F3F251121DF217C7F74F76E57', 1, 32, 58, '2017-04-03 10:50:50', '2017-06-08 13:47:59');
INSERT INTO `SCP_Licenses` VALUES(44, '6808BB3B207C6E66434493A831BCD21E', 1, 33, 59, '2017-04-03 10:50:50', '2017-06-08 13:47:59');
INSERT INTO `SCP_Licenses` VALUES(47, '0AE4082488240323F1AED54D64FFDCF1', 1, 13, 64, '2017-04-03 10:50:50', '2017-04-03 10:50:50');
INSERT INTO `SCP_Licenses` VALUES(49, '10EB56A974434381CAFD7AF5A1A89A9F', 1, 4, 66, '2017-04-03 10:50:50', '2017-04-03 10:50:50');
INSERT INTO `SCP_Licenses` VALUES(50, 'C8522BE870B2567BF01E19A25468152E', 1, 4, 67, '2017-04-03 10:50:50', '2017-04-03 10:50:50');
INSERT INTO `SCP_Licenses` VALUES(57, '7DF02C8D815E6341DCDBAE1D140CB5E4', 1, 4, 74, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(58, 'E585B85E4819B9BF5A8E53A5CDFA1EBA', 1, 4, 75, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(59, '442025BAC38ED2FECFFD3059B6B448F8', 1, 4, 76, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(60, 'E0CA0428C0D56C8973A4F9BC7B239A78', 1, 4, 77, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(61, 'BB39301BD93EAF1AED8413C3D374C508', 1, 4, 78, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(62, 'DD52925A6094FE97E3DE4B700ACAF466', 1, 4, 79, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(63, '1A01A9234EB31D58583ED5D751C995CF', 1, 9, 80, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(64, '108188D3D52E48764264B2C863D310C6', 1, 4, 81, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(65, 'C1258F2524A2529F77C92FB4918891A1', 1, 9, 82, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(66, '618B3697BA884B7E51DF6577949BA106', 1, 10, 83, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(67, '3BD2C996FDC5EECCE06E239DEA606004', 1, 4, 85, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(68, 'DE132E97A62A9581D0836ABCB57E7A36', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(69, '56A62ADE6E6EBDF4AE238CD559157ADC', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(70, '95ADC6BB69B3810B5446BD5354503D6D', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(71, 'B2C4D9C8C30FE2A5331EE38E87997008', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(72, '7FC938035512816A5FAC75B0C12AB0AA', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(73, 'C90743FF06570A3DD0877B7235F6D7EB', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(74, 'D6A59B5FFE8117682A6FEDCA93786E09', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(75, '6F8BF5F9A474AF00BCDC6534B49E1C4A', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(76, '109BA0862894EAC8B821876AD84D7519', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(77, '2FD4C5BE9FC85044A6C654C2D2877AB0', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(78, '124D6BD763A6AC54D5597C6AAC04D977', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(79, '573061DE6FB6A9870E08418479EC9D06', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(80, 'A7F1DD7B5180E7DDBD54B5612D8ED507', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(81, 'C08F2CD51E9708ED807BCCB573A006A4', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(82, 'FB2D8A4FA995131357BA99BB003AA243', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(83, '2F9745A2EB9C9B7AB9D4884A0FC8371A', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(84, '8D6D1FA2668E5E0ED394CDBF29784BA9', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(85, '9716C517B5ADCD218C0B6CF3B295AFF2', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(86, '2AD32B8847D0E28D54F48A219ECE9AEC', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(87, '2C2BB797ACD4278480694825E2CC7FF4', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(88, '3AE5E677DCD92DC3D07573CA7929F61E', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(89, '502FD2B0D7B6E9DB8D818078E487579F', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(90, '222ABE780893FE19A3CECB876BF2C7E7', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(91, '34DF6AB8C2DDE147676ADAD9E7CD5B61', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(92, '48C02C185ED6ABABCEEDC4652A5908B4', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(93, '8BA03ED03FAD9DAC52FFD8144A50DDB7', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(94, 'C251269E73D8CFBA55DEC11B18AD8B80', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(95, 'FC923334A0538DA8481F1271DEB08FA8', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');
INSERT INTO `SCP_Licenses` VALUES(96, 'CAE68F00CD967842CD41CC4C49BF481F', 1, NULL, NULL, '2017-06-10 17:50:56', '2017-06-10 17:50:56');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_LicensesPlan`
--

CREATE TABLE `SCP_LicensesPlan` (
  `PlanID` int(11) NOT NULL AUTO_INCREMENT,
  `PlanName` varchar(156) NOT NULL,
  `MinQty` int(11) NOT NULL,
  `MaxQty` int(11) NOT NULL,
  `Price` int(11) NOT NULL,
  `StatusID` int(11) NOT NULL,
  `CreatedDateTime` datetime NOT NULL,
  `ModifyDateTime` datetime NOT NULL,
  PRIMARY KEY (`PlanID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `SCP_LicensesPlan`
--

INSERT INTO `SCP_LicensesPlan` VALUES(1, 'BRONZE', 0, 25, 100, 1, '2017-03-20 07:13:18', '2017-03-20 07:13:18');
INSERT INTO `SCP_LicensesPlan` VALUES(2, 'SILVER', 0, 50, 150, 1, '2017-03-20 07:13:18', '2017-03-20 07:13:18');
INSERT INTO `SCP_LicensesPlan` VALUES(3, 'GOLD', 0, 100, 200, 1, '2017-03-20 07:13:18', '2017-03-20 07:13:18');
INSERT INTO `SCP_LicensesPlan` VALUES(4, 'PLATINUM', 0, 1000, 300, 1, '2017-03-20 07:13:18', '2017-03-20 07:13:18');
INSERT INTO `SCP_LicensesPlan` VALUES(5, 'GOLD', 0, 10, 200, 2, '2017-04-05 19:02:52', '2017-04-05 19:02:52');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_MedicationForm`
--

CREATE TABLE `SCP_MedicationForm` (
  `FormID` int(11) NOT NULL AUTO_INCREMENT,
  `FormName` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`FormID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `SCP_MedicationForm`
--


-- --------------------------------------------------------

--
-- Table structure for table `SCP_MedicationRoute`
--

CREATE TABLE `SCP_MedicationRoute` (
  `RouteID` int(11) NOT NULL,
  `RouteName` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`RouteID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SCP_MedicationRoute`
--


-- --------------------------------------------------------

--
-- Table structure for table `SCP_MedicationTaskDetails`
--

CREATE TABLE `SCP_MedicationTaskDetails` (
  `MedicationTaskID` int(11) NOT NULL AUTO_INCREMENT,
  `TaskID` int(11) DEFAULT NULL,
  `MedicationFormID` int(11) DEFAULT NULL,
  `MedicationRouteID` int(11) DEFAULT NULL,
  `Location` varchar(150) DEFAULT NULL,
  `Dosage` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`MedicationTaskID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `SCP_MedicationTaskDetails`
--


-- --------------------------------------------------------

--
-- Table structure for table `SCP_Messaging`
--

CREATE TABLE `SCP_Messaging` (
  `MessagingID` int(11) NOT NULL AUTO_INCREMENT,
  `FromID` int(11) DEFAULT NULL,
  `ToID` int(11) DEFAULT NULL,
  `Text` longtext,
  `DateTime` datetime DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`MessagingID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `SCP_Messaging`
--


-- --------------------------------------------------------

--
-- Table structure for table `SCP_OrgFormBuilder`
--

CREATE TABLE `SCP_OrgFormBuilder` (
  `FormID` int(11) NOT NULL AUTO_INCREMENT,
  `FormDataID` varchar(156) NOT NULL,
  `FormName` varchar(156) NOT NULL,
  `FormDataJson` longtext NOT NULL,
  `FormDataJsonValue` longtext NOT NULL,
  `UserID` int(11) NOT NULL,
  `OrgID` int(11) NOT NULL,
  `StatusID` int(11) NOT NULL,
  `FromType` varchar(156) NOT NULL COMMENT '0=>new form,1=>custom form',
  `UserTypeID` int(11) NOT NULL,
  `CreatedDateTime` datetime NOT NULL,
  `ModifyDateTime` datetime NOT NULL,
  PRIMARY KEY (`FormID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=75 ;

--
-- Dumping data for table `SCP_OrgFormBuilder`
--

INSERT INTO `SCP_OrgFormBuilder` VALUES(14, 'FORM1494400775', 'Testing Form', '[{"component":"header","editable":true,"index":0,"label":"Testing Form","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Single line input","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"select","editable":true,"index":2,"label":"Dropdown","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false},{"component":"radio","editable":true,"index":3,"label":"Radio","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false},{"component":"checkbox","editable":true,"index":4,"label":"Checkbox","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false},{"component":"radio","editable":true,"index":5,"label":"Radio","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false}]', '[{"label":"Testing Form","value":""},{"label":"Single line input","value":""},{"label":"Dropdown","value":"value one"}]', 1, 9, 1, '1', 5, '2017-05-10 13:23:30', '2017-05-22 20:06:28');
INSERT INTO `SCP_OrgFormBuilder` VALUES(23, 'FORM1495465224', 'Heading', '[{"component":"header","editable":true,"index":0,"label":"Heading","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Single line input","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"select","editable":true,"index":2,"label":"Dropdown","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false}]', '[{"label":"Heading","value":""},{"label":"Single line input","value":""},{"label":"Dropdown","value":"value one"}]', 1, 8, 1, '0', 4, '2017-05-22 20:30:24', '2017-05-22 20:30:24');
INSERT INTO `SCP_OrgFormBuilder` VALUES(28, 'FORM1495535110', 'Form for care worker', '[{"component":"header","editable":true,"index":0,"label":"Form for care worker","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Single line input value","value":"","description":"hi this is testing team","placeholder":"Placeholder for holding some value","options":[],"required":true},{"component":"textArea","editable":true,"index":2,"label":"Multi line input for testing","value":"","description":"hi this is testing","placeholder":"Placeholder for holding some value","options":[],"required":true},{"component":"select","editable":true,"index":3,"label":"Dropdown","value":"","description":"","placeholder":"Placeholder","options":["value one","value two","third value"],"required":false},{"component":"radio","editable":true,"index":4,"label":"Radio","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"checkbox","editable":true,"index":5,"label":"Checkbox","value":"","description":"","placeholder":"Placeholder","options":["value one","value two","fourth"],"required":true},{"component":"signature","editable":true,"index":6,"label":"ram","value":"","description":"hi this is testing team","placeholder":"Placeholder","options":[],"required":true},{"component":"postCode","editable":true,"index":7,"label":"Postal","value":"","description":"","placeholder":"","options":[],"required":false},{"component":"file","editable":true,"index":8,"label":"File upload","value":"","description":"gfdgdg","placeholder":"Placeholder","options":[],"required":true},{"component":"date","editable":true,"index":9,"label":"Datege","value":"","description":"gffdgfdgdfg","placeholder":"Placeholder vfdfgfggeg","options":[],"required":true}]', '[{"label":"Form for care worker","value":""},{"label":"Single line input value","value":""},{"label":"Multi line input for testing","value":""},{"label":"Dropdown","value":"value one"},{"label":"Radio","value":"value one"},{"label":"Checkbox","value":""},{"label":"ram","value":""},{"label":"Postal","value":""},{"label":"File upload","value":""},{"label":"Datege","value":""}]', 1, 4, 1, '0', 5, '2017-05-23 15:55:10', '2017-05-23 15:57:52');
INSERT INTO `SCP_OrgFormBuilder` VALUES(30, 'FORM1495535558', 'Test Form', '[{"component":"header","editable":true,"index":0,"label":"Test Form","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"date","editable":true,"index":1,"label":"Date","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"checkbox","editable":true,"index":2,"label":"Sex","value":"","description":"","placeholder":"Placeholder","options":["Baahubali","Bhalla"],"required":true},{"component":"select","editable":true,"index":3,"label":"Dropdown","value":"","description":"","placeholder":"Placeholder","options":["Baahubali","Bhalla"],"required":false}]', '[{"label":"Test Form","value":""},{"label":"Date","value":""},{"label":"Sex","value":""},{"label":"Dropdown","value":"Baahubali"}]', 1, 4, 1, '0', 5, '2017-05-23 16:02:38', '2017-05-23 16:02:38');
INSERT INTO `SCP_OrgFormBuilder` VALUES(33, 'FORM1495536879', 'Heading', '[{"component":"header","editable":true,"index":0,"label":"Walk Form","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Name","value":"","description":"","placeholder":"Name","options":[],"required":true},{"component":"header","editable":true,"index":2,"label":"Heading","value":"","description":"","placeholder":"Placeholder","options":[],"required":false}]', '[{"label":"Walk Form","value":""},{"label":"Name","value":""},{"label":"Heading","value":""}]', 1, 3, 1, '0', 4, '2017-05-23 16:24:39', '2017-05-23 16:24:39');
INSERT INTO `SCP_OrgFormBuilder` VALUES(34, 'FORM1495536911', 'Heading', '[{"component":"header","editable":true,"index":0,"label":"Walk Form","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Name","value":"","description":"","placeholder":"Name","options":[],"required":true},{"component":"header","editable":true,"index":2,"label":"Heading","value":"","description":"","placeholder":"Placeholder","options":[],"required":false}]', '[{"label":"Walk Form","value":""},{"label":"Name","value":""},{"label":"Heading","value":""}]', 1, 3, 1, '0', 4, '2017-05-23 16:25:11', '2017-05-23 16:25:11');
INSERT INTO `SCP_OrgFormBuilder` VALUES(36, 'FORM1495537380', 'Rest Form 1', '[{"component":"header","editable":true,"index":0,"label":"Rest Form 1","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"My Name tester","value":"","description":"","placeholder":"My Name","options":[],"required":true},{"component":"file","editable":true,"index":2,"label":"Profile Image","value":"","description":"","placeholder":"Placeholder","options":[],"required":true},{"component":"postCode","editable":true,"index":3,"label":"DZFSFS","value":"","description":"","placeholder":"","options":[],"required":false}]', '[{"label":"Rest Form 1","value":""},{"label":"My Name","value":""},{"label":"Profile Image","value":""},{"label":"DZFSFS","value":""}]', 1, 3, 1, '0', 5, '2017-05-23 16:33:00', '2017-05-23 16:33:30');
INSERT INTO `SCP_OrgFormBuilder` VALUES(37, 'FORM1495538327', 'Heading', '[{"component":"header","editable":true,"index":0,"label":"Heading","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Single line input","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textArea","editable":true,"index":2,"label":"Multi line input","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"select","editable":true,"index":3,"label":"Dropdown","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false},{"component":"checkbox","editable":true,"index":4,"label":"Checkbox","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false},{"component":"file","editable":true,"index":5,"label":"File","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"postCode","editable":true,"index":6,"label":"Postal Code","value":"","description":"","placeholder":"","options":[],"required":false},{"component":"signature","editable":true,"index":7,"label":"Signature","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"date","editable":true,"index":8,"label":"Date","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"radio","editable":true,"index":9,"label":"Radio","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false}]', '[{"label":"Heading","value":""},{"label":"Single line input","value":""},{"label":"Multi line input","value":""},{"label":"Dropdown","value":"value one"},{"label":"Checkbox","value":""},{"label":"File","value":""},{"label":"Postal Code","value":""},{"label":"Signature","value":""},{"label":"Date","value":""},{"label":"Radio","value":"value one"}]', 1, 3, 1, '0', 4, '2017-05-23 16:48:47', '2017-05-23 16:48:47');
INSERT INTO `SCP_OrgFormBuilder` VALUES(38, 'FORM1495538461', 'Heading', '[{"component":"header","editable":true,"index":0,"label":"Walk Form","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Name","value":"","description":"","placeholder":"Name","options":[],"required":true},{"component":"header","editable":true,"index":2,"label":"Heading","value":"","description":"","placeholder":"Placeholder","options":[],"required":false}]', '[{"label":"Walk Form","value":""},{"label":"Name","value":""},{"label":"Heading","value":""}]', 1, 3, 1, '0', 4, '2017-05-23 16:51:01', '2017-05-23 16:51:01');
INSERT INTO `SCP_OrgFormBuilder` VALUES(39, 'FORM1495538593', 'Heading', '[{"component":"header","editable":true,"index":0,"label":"Rest Form","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"My Name","value":"","description":"","placeholder":"My Name","options":[],"required":true},{"component":"file","editable":true,"index":2,"label":"Profile Image","value":"","description":"","placeholder":"Placeholder","options":[],"required":true},{"component":"header","editable":true,"index":3,"label":"Heading","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textInput","editable":true,"index":4,"label":"Single line input","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"select","editable":true,"index":5,"label":"Dropdown","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false},{"component":"date","editable":true,"index":6,"label":"Date","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"file","editable":true,"index":7,"label":"File","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"postCode","editable":true,"index":8,"label":"Postal Code","value":"","description":"","placeholder":"","options":[],"required":false},{"component":"signature","editable":true,"index":9,"label":"Signature","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"checkbox","editable":true,"index":10,"label":"Checkbox","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false},{"component":"radio","editable":true,"index":11,"label":"Radio","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false},{"component":"textArea","editable":true,"index":12,"label":"Multi line input","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"postCode","editable":true,"index":13,"label":"DZFSFS","value":"","description":"","placeholder":"","options":[],"required":false}]', '[{"label":"Rest Form","value":""},{"label":"My Name","value":""},{"label":"Profile Image","value":""},{"label":"Heading","value":""},{"label":"Single line input","value":""},{"label":"Dropdown","value":"value one"},{"label":"Date","value":""},{"label":"File","value":""},{"label":"Postal Code","value":""},{"label":"Signature","value":""},{"label":"Checkbox","value":""},{"label":"Radio","value":"value one"},{"label":"Multi line input","value":""},{"label":"DZFSFS","value":""}]', 1, 3, 1, '0', 5, '2017-05-23 16:53:13', '2017-05-23 16:53:13');
INSERT INTO `SCP_OrgFormBuilder` VALUES(40, 'FORM1495538650', 'Heading', '[{"component":"header","editable":true,"index":0,"label":"Walk Form","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Name","value":"","description":"","placeholder":"Name","options":[],"required":true},{"component":"header","editable":true,"index":2,"label":"Heading","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textInput","editable":true,"index":3,"label":"Single line input","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textArea","editable":true,"index":4,"label":"Multi line input","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"date","editable":true,"index":5,"label":"Date","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"checkbox","editable":true,"index":6,"label":"Checkbox","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false},{"component":"radio","editable":true,"index":7,"label":"Radio","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false}]', '[{"label":"Walk Form","value":""},{"label":"Name","value":""},{"label":"Heading","value":""},{"label":"Single line input","value":""},{"label":"Multi line input","value":""},{"label":"Date","value":""},{"label":"Checkbox","value":""},{"label":"Radio","value":"value one"}]', 1, 3, 1, '0', 4, '2017-05-23 16:54:10', '2017-05-23 16:54:10');
INSERT INTO `SCP_OrgFormBuilder` VALUES(41, 'FORM1495539286', 'Rest Form 1', '[{"component":"header","editable":true,"index":0,"label":"Rest Form 1","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"My Name tester123","value":"","description":"","placeholder":"My Name","options":[],"required":true},{"component":"file","editable":true,"index":2,"label":"Profile Image","value":"","description":"","placeholder":"Placeholder","options":[],"required":true},{"component":"postCode","editable":true,"index":3,"label":"DZFSFS","value":"","description":"","placeholder":"","options":[],"required":false}]', '[{"label":"Rest Form 1","value":""},{"label":"My Name tester123","value":""},{"label":"Profile Image","value":""},{"label":"DZFSFS","value":""}]', 1, 3, 1, '0', 5, '2017-05-23 17:04:46', '2017-05-23 17:04:46');
INSERT INTO `SCP_OrgFormBuilder` VALUES(45, 'FORM1495982667', 'This form is for CARE WORKER IN TEST ORG', '[{"component":"header","editable":true,"index":0,"label":"This form is for CARE WORKER IN TEST ORG","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Single line input","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"select","editable":true,"index":2,"label":"Dropdown","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false}]', '[{"label":"This form is for CARE WORKER IN TEST ORG","value":""}]', 1, 9, 1, '0', 5, '2017-05-28 20:14:27', '2017-05-29 13:32:56');
INSERT INTO `SCP_OrgFormBuilder` VALUES(46, 'FORM1496041719', '', '[]', '[]', 1, 4, 1, '0', 5, '2017-05-29 12:38:39', '2017-05-29 12:38:39');
INSERT INTO `SCP_OrgFormBuilder` VALUES(49, 'FORM1496041224', 'testing form', '[{"component":"header","editable":true,"index":0,"label":"testing form","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textArea","editable":true,"index":1,"label":"Multi line input","value":"","description":"","placeholder":"Placeholder","options":[],"required":false}]', '', 1, 4, 1, '1', 4, '2017-05-29 12:45:51', '2017-05-29 12:45:51');
INSERT INTO `SCP_OrgFormBuilder` VALUES(50, 'FORM1496042178', 'testing form', '[{"component":"header","editable":true,"index":0,"label":"testing form","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textArea","editable":true,"index":1,"label":"Multi line input","value":"","description":"","placeholder":"Placeholder","options":[],"required":false}]', '[{"label":"testing form","value":""},{"label":"Multi line input","value":""}]', 1, 4, 1, '0', 4, '2017-05-29 12:46:18', '2017-05-29 12:46:18');
INSERT INTO `SCP_OrgFormBuilder` VALUES(52, 'FORM1496042414', 'Heading', '[{"component":"header","editable":true,"index":0,"label":"Heading","value":"","description":"","placeholder":"Placeholder","options":[],"required":false}]', '[]', 1, 4, 1, '0', 4, '2017-05-29 12:50:14', '2017-05-29 13:02:15');
INSERT INTO `SCP_OrgFormBuilder` VALUES(53, 'FORM1496043883', 'This is a form for all organisations Care workers', '[{"component":"header","editable":true,"index":0,"label":"Central form","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"header","editable":true,"index":1,"label":"This is a form for all organisations Care workers","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"select","editable":true,"index":2,"label":"Please select a value","value":"","description":"","placeholder":"Placeholder","options":["Male","Female"],"required":false},{"component":"radio","editable":true,"index":3,"label":"Please select an option","value":"","description":"","placeholder":"Placeholder","options":["Yes","No"],"required":false},{"component":"signature","editable":true,"index":4,"label":"Please enter signature in tablet","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"date","editable":true,"index":5,"label":"Enter the review date","value":"","description":"","placeholder":"Placeholder","options":[],"required":false}]', '[{"label":"Central form","value":""},{"label":"This is a form for all organisations Care workers","value":""},{"label":"Please select a value","value":"Male"},{"label":"Please select an option","value":"Yes"},{"label":"Please enter signature in tablet","value":""},{"label":"Enter the review date","value":""}]', 1, 0, 1, '0', 4, '2017-05-29 13:14:43', '2017-05-29 13:14:43');
INSERT INTO `SCP_OrgFormBuilder` VALUES(54, 'FORM1496043956', 'This is a form for all organisations Care workers', '[{"component":"header","editable":true,"index":0,"label":"Central form","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"header","editable":true,"index":1,"label":"This is a form for all organisations Care workers","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"select","editable":true,"index":2,"label":"Please select a value","value":"","description":"","placeholder":"Placeholder","options":["Male","Female"],"required":false},{"component":"radio","editable":true,"index":3,"label":"Please select an option","value":"","description":"","placeholder":"Placeholder","options":["Yes","No"],"required":false},{"component":"signature","editable":true,"index":4,"label":"Please enter signature in tablet","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"date","editable":true,"index":5,"label":"Enter the review date","value":"","description":"","placeholder":"Placeholder","options":[],"required":false}]', '[{"label":"Central form","value":""},{"label":"This is a form for all organisations Care workers","value":""},{"label":"Please select a value","value":"Male"},{"label":"Please select an option","value":"Yes"},{"label":"Please enter signature in tablet","value":""},{"label":"Enter the review date","value":""}]', 1, 4, 1, '0', 4, '2017-05-29 13:15:56', '2017-05-29 13:15:56');
INSERT INTO `SCP_OrgFormBuilder` VALUES(55, 'FORM1496045043', 'safari form 1', '[{"component":"header","editable":true,"index":0,"label":"safari form 1","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Single line input fdgdgdfgd","value":"","description":"gdgdf","placeholder":"Placeholdergdfgdfdffdfdgfdgfdf","options":[],"required":true},{"component":"textArea","editable":true,"index":2,"label":"Multi line input gfdggdfg","value":"","description":"gfdgfgdgdf","placeholder":"Placeholderbcvbvcbvb","options":[],"required":false},{"component":"select","editable":true,"index":3,"label":"Dropdown","value":"","description":"fdgfdgdfgdgdggdgd","placeholder":"Placeholder","options":["value one","value two","gfdggdgg"],"required":false},{"component":"radio","editable":true,"index":4,"label":"Radio gfdgdfgcxssd","value":"","description":"sgfdgfdgfdgdg","placeholder":"Placeholder","options":["value one","value two","fgsdgsggsdfg"],"required":false},{"component":"postCode","editable":true,"index":5,"label":"Postal Code gfdgdfzggdgd","value":"","description":"","placeholder":"","options":[],"required":true},{"component":"file","editable":true,"index":6,"label":"file gdfgfdgdg","value":"","description":"cbvbcbcbcbc","placeholder":"Placeholder","options":[],"required":true},{"component":"signature","editable":true,"index":7,"label":"Signature gfddfgd","value":"","description":"dgdggdg","placeholder":"Placeholder","options":[],"required":true},{"component":"date","editable":true,"index":8,"label":"Date dfgfdgdg","value":"","description":"gfdgdfgdfg","placeholder":"Placeholder gfdgdfgdfgdfggd","options":[],"required":true},{"component":"checkbox","editable":true,"index":9,"label":"Checkbox","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false}]', '[{"label":"safari form 1","value":""},{"label":"Single line input fdgdgdfgd","value":""},{"label":"Multi line input gfdggdfg","value":""},{"label":"Dropdown","value":"value one"},{"label":"Radio gfdgdfgcxssd","value":"value one"},{"label":"Postal Code gfdgdfzggdgd","value":""},{"label":"file gdfgfdgdg","value":""},{"label":"Signature gfddfgd","value":""},{"label":"Date dfgfdgdg","value":""},{"label":"Checkbox","value":""}]', 1, 4, 1, '0', 4, '2017-05-29 13:34:03', '2017-05-29 13:34:03');
INSERT INTO `SCP_OrgFormBuilder` VALUES(56, 'FORM1496044979', 'safari form1', '[{"component":"header","editable":true,"index":0,"label":"safari form1","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Single line input fdgdgdfgd","value":"","description":"gdgdf","placeholder":"Placeholdergdfgdfdffdfdgfdgfdf","options":[],"required":true},{"component":"textArea","editable":true,"index":2,"label":"Multi line input gfdggdfg","value":"","description":"gfdgfgdgdf","placeholder":"Placeholderbcvbvcbvb","options":[],"required":false},{"component":"select","editable":true,"index":3,"label":"Dropdown","value":"","description":"fdgfdgdfgdgdggdgd","placeholder":"Placeholder","options":["value one","value two","gfdggdgg"],"required":false},{"component":"radio","editable":true,"index":4,"label":"Radio gfdgdfgcxssd","value":"","description":"sgfdgfdgfdgdg","placeholder":"Placeholder","options":["value one","value two","fgsdgsggsdfg"],"required":false},{"component":"postCode","editable":true,"index":5,"label":"Postal Code gfdgdfzggdgd","value":"","description":"","placeholder":"","options":[],"required":true},{"component":"file","editable":true,"index":6,"label":"file gdfgfdgdg","value":"","description":"cbvbcbcbcbc","placeholder":"Placeholder","options":[],"required":true},{"component":"signature","editable":true,"index":7,"label":"Signature gfddfgd","value":"","description":"dgdggdg","placeholder":"Placeholder","options":[],"required":true},{"component":"date","editable":true,"index":8,"label":"Date dfgfdgdg","value":"","description":"gfdgdfgdfg","placeholder":"Placeholder gfdgdfgdfgdfggd","options":[],"required":true},{"component":"checkbox","editable":true,"index":9,"label":"Checkbox","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false}]', '', 1, 4, 1, '1', 4, '2017-05-29 13:34:56', '2017-05-29 13:34:56');
INSERT INTO `SCP_OrgFormBuilder` VALUES(57, 'FORM1496045110', 'safari form1', '[{"component":"header","editable":true,"index":0,"label":"safari form1","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Single line input fdgdgdfgd","value":"","description":"gdgdf","placeholder":"Placeholdergdfgdfdffdfdgfdgfdf","options":[],"required":true},{"component":"textArea","editable":true,"index":2,"label":"Multi line input gfdggdfg","value":"","description":"gfdgfgdgdf","placeholder":"Placeholderbcvbvcbvb","options":[],"required":false},{"component":"select","editable":true,"index":3,"label":"Dropdown","value":"","description":"fdgfdgdfgdgdggdgd","placeholder":"Placeholder","options":["value one","value two","gfdggdgg"],"required":false},{"component":"radio","editable":true,"index":4,"label":"Radio gfdgdfgcxssd","value":"","description":"sgfdgfdgfdgdg","placeholder":"Placeholder","options":["value one","value two","fgsdgsggsdfg"],"required":false},{"component":"postCode","editable":true,"index":5,"label":"Postal Code gfdgdfzggdgd","value":"","description":"","placeholder":"","options":[],"required":true},{"component":"file","editable":true,"index":6,"label":"file gdfgfdgdg","value":"","description":"cbvbcbcbcbc","placeholder":"Placeholder","options":[],"required":true},{"component":"signature","editable":true,"index":7,"label":"Signature gfddfgd","value":"","description":"dgdggdg","placeholder":"Placeholder","options":[],"required":true},{"component":"date","editable":true,"index":8,"label":"Date dfgfdgdg","value":"","description":"gfdgdfgdfg","placeholder":"Placeholder gfdgdfgdfgdfggd","options":[],"required":true},{"component":"checkbox","editable":true,"index":9,"label":"Checkbox","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false}]', '[{"label":"safari form1","value":""},{"label":"Single line input fdgdgdfgd","value":""},{"label":"Multi line input gfdggdfg","value":""},{"label":"Dropdown","value":"value one"},{"label":"Radio gfdgdfgcxssd","value":"value one"},{"label":"Postal Code gfdgdfzggdgd","value":""},{"label":"file gdfgfdgdg","value":""},{"label":"Signature gfddfgd","value":""},{"label":"Date dfgfdgdg","value":""},{"label":"Checkbox","value":""}]', 1, 4, 1, '0', 4, '2017-05-29 13:35:10', '2017-05-29 13:35:10');
INSERT INTO `SCP_OrgFormBuilder` VALUES(63, 'FORM1496813375', 'Heading', '[{"component":"header","editable":true,"index":0,"label":"Heading","value":"","description":"","placeholder":"Title","options":[],"required":false}]', '[{"label":"Heading","value":""}]', 1, 4, 1, '0', 4, '2017-06-07 10:59:35', '2017-06-07 10:59:35');
INSERT INTO `SCP_OrgFormBuilder` VALUES(64, 'FORM1496813671', 'izisstesting form  izisstesting form  izisstesting form  izisstesting form  izisstesting form  izis', '[{"component":"header","editable":true,"index":0,"label":"izisstesting form  izisstesting form  izisstesting form  izisstesting form  izisstesting form  izis","value":"","description":"","placeholder":"Title","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"izisstesting form  izisstesting form  izisstesting form  izisstesting form  izisstesting form  izis","value":"","description":"izisstesting form  izisstesting form  izisstesting form  izisstesting form  izisstesting form  izisstesting form  izisstesting form  izisstesting form","placeholder":"Single line input izisstesting form  izisstesting form  izisstesting form  izisstesting form  izisstesting form  izisstesting form  izisstesting form  izisstesting form","options":[],"required":true},{"component":"textArea","editable":true,"index":2,"label":"Multi line input Multi line input Multi line input Multi line input Multi line input Multi line inpu","value":"","description":"Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input","placeholder":"Multi line inputMulti line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input Multi line input","options":[],"required":true},{"component":"postCode","editable":true,"index":3,"label":"Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Post","value":"","description":"","placeholder":"","options":[],"required":true},{"component":"date","editable":true,"index":4,"label":"Date Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code","value":"","description":"Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code","placeholder":"dd-mm-yyyyPostal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code","options":[],"required":true},{"component":"file","editable":true,"index":5,"label":"File Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code","value":"","description":"Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code","placeholder":"File","options":[],"required":true},{"component":"signature","editable":true,"index":6,"label":"Signature Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal","value":"","description":"Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code","placeholder":"Signature","options":[],"required":true},{"component":"checkbox","editable":true,"index":7,"label":"CheckboxPostal Code Postal Code Postal Code Postal Code Postal Code Postal Code","value":"","description":"Postal Code Postal Code Postal Code Postal Code","placeholder":"Checkbox","options":["value onePostal Code Postal Code Postal Code Postal Code ","value twoPostal Code Postal Code Postal Code Postal Code Postal Code"],"required":true},{"component":"radio","editable":true,"index":8,"label":"Radio Postal Code Postal Code Postal Code Postal Code","value":"","description":"Postal Code Postal Code Postal Code Postal Code","placeholder":"Radio","options":["value one","value twoPostal Code Postal Code Postal Code Postal Code Postal Code"],"required":false},{"component":"select","editable":true,"index":9,"label":"Dropdown","value":"","description":"","placeholder":"Dropdown","options":["value one","value two","Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code"],"required":false}]', '[{"label":"izisstesting form  izisstesting form  izisstesting form  izisstesting form  izisstesting form  izis","value":""},{"label":"izisstesting form  izisstesting form  izisstesting form  izisstesting form  izisstesting form  izis","value":""},{"label":"Multi line input Multi line input Multi line input Multi line input Multi line input Multi line inpu","value":""},{"label":"Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Post","value":""},{"label":"Date Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code","value":""},{"label":"File Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code","value":""},{"label":"Signature Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal Code Postal","value":""},{"label":"CheckboxPostal Code Postal Code Postal Code Postal Code Postal Code Postal Code","value":""},{"label":"Radio Postal Code Postal Code Postal Code Postal Code","value":"value one"},{"label":"Dropdown","value":"value one"}]', 1, 4, 1, '0', 4, '2017-06-07 11:04:31', '2017-06-07 11:06:32');
INSERT INTO `SCP_OrgFormBuilder` VALUES(65, 'FORM1496814079', 'care worker care worker care worker care worker care worker care worker care worker care worker care', '[{"component":"header","editable":true,"index":0,"label":"care worker care worker care worker care worker care worker care worker care worker care worker care","value":"","description":"","placeholder":"Title","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Single line input Single line input Single line input Single line input Single line input Single lin","value":"","description":"Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input","placeholder":"Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input","options":[],"required":true},{"component":"textArea","editable":true,"index":2,"label":"Multi line input Single line input Single line input Single line input Single line input Single line","value":"","description":"Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input","placeholder":"Multi line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input","options":[],"required":true},{"component":"radio","editable":true,"index":3,"label":"Radio Single line input Single line input Single line input Single line input Single line input Sing","value":"","description":"Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input","placeholder":"Radio","options":["value one","value two","Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input"],"required":false},{"component":"postCode","editable":true,"index":4,"label":"Postal Code Single line input Single line input Single line input Single line input Single line inpu","value":"","description":"","placeholder":"","options":[],"required":true},{"component":"file","editable":true,"index":5,"label":"File Single line input Single line input Single line input Single line input Single line input Singl","value":"","description":"Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input","placeholder":"File","options":[],"required":true},{"component":"signature","editable":true,"index":6,"label":"SignatureSingle line input Single line input Single line input Single line input Single line input","value":"","description":"Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input","placeholder":"Signature","options":[],"required":true},{"component":"date","editable":true,"index":7,"label":"Date Single line input Single line input Single line input Single line input Single line input Singl","value":"","description":"Single line input Single line input Single line input Single line input Single line input Single line input","placeholder":"dd-mm-yyyySingle line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input","options":[],"required":true},{"component":"checkbox","editable":true,"index":8,"label":"Checkbox Single line input Single line input Single line input Single line input Single line input S","value":"","description":"Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input","placeholder":"Checkbox","options":["value one","value two","Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input"],"required":true},{"component":"select","editable":true,"index":9,"label":"Dropdown","value":"","description":"Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input","placeholder":"Dropdown","options":["value one","value two","Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input"],"required":false}]', '[{"label":"care worker care worker care worker care worker care worker care worker care worker care worker care","value":""},{"label":"Single line input Single line input Single line input Single line input Single line input Single lin","value":""},{"label":"Multi line input Single line input Single line input Single line input Single line input Single line","value":""},{"label":"Radio Single line input Single line input Single line input Single line input Single line input Sing","value":"value one"},{"label":"Postal Code Single line input Single line input Single line input Single line input Single line inpu","value":""},{"label":"File Single line input Single line input Single line input Single line input Single line input Singl","value":""},{"label":"SignatureSingle line input Single line input Single line input Single line input Single line input","value":""},{"label":"Date Single line input Single line input Single line input Single line input Single line input Singl","value":""},{"label":"Checkbox Single line input Single line input Single line input Single line input Single line input S","value":""},{"label":"Dropdown","value":"value one"}]', 1, 4, 1, '0', 5, '2017-06-07 11:11:19', '2017-06-07 11:11:19');
INSERT INTO `SCP_OrgFormBuilder` VALUES(66, 'FORM1496814381', 'this is fire fox browser this is fire fox browser this is fire fox browser this is fire fox browser', '[{"component":"header","editable":true,"index":0,"label":"this is fire fox browser this is fire fox browser this is fire fox browser this is fire fox browser","value":"","description":"","placeholder":"Title","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Single line input","value":"","description":"","placeholder":"Single line input","options":[],"required":false},{"component":"textArea","editable":true,"index":2,"label":"Multi line input","value":"","description":"","placeholder":"Multi line input","options":[],"required":false},{"component":"date","editable":true,"index":3,"label":"Date","value":"","description":"","placeholder":"dd-mm-yyyy","options":[],"required":false},{"component":"file","editable":true,"index":4,"label":"File","value":"","description":"","placeholder":"File","options":[],"required":false},{"component":"postCode","editable":true,"index":5,"label":"Postal Code","value":"","description":"","placeholder":"","options":[],"required":false},{"component":"checkbox","editable":true,"index":6,"label":"Checkbox","value":"","description":"","placeholder":"Checkbox","options":["value one","value two"],"required":false},{"component":"signature","editable":true,"index":7,"label":"Signature","value":"","description":"","placeholder":"Signature","options":[],"required":false},{"component":"radio","editable":true,"index":8,"label":"Radio","value":"","description":"","placeholder":"Radio","options":["value one","value two"],"required":false},{"component":"select","editable":true,"index":9,"label":"Dropdown","value":"","description":"","placeholder":"Dropdown","options":["value one","value two"],"required":false}]', '[{"label":"this is fire fox browser this is fire fox browser this is fire fox browser this is fire fox browser","value":""},{"label":"Single line input","value":""},{"label":"Multi line input","value":""},{"label":"Date","value":""},{"label":"File","value":""},{"label":"Postal Code","value":""},{"label":"Checkbox","value":""},{"label":"Signature","value":""},{"label":"Radio","value":"value one"},{"label":"Dropdown","value":"value one"}]', 1, 4, 1, '0', 4, '2017-06-07 11:16:21', '2017-06-07 11:16:21');
INSERT INTO `SCP_OrgFormBuilder` VALUES(67, 'FORM1496814445', 'this is fire fox browser this is fire fox browser this is fire fox browser this is fire fox browser', '[{"component":"header","editable":true,"index":0,"label":"this is fire fox browser this is fire fox browser this is fire fox browser this is fire fox browser","value":"","description":"","placeholder":"Title","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Single line input","value":"","description":"","placeholder":"Single line input","options":[],"required":false},{"component":"textArea","editable":true,"index":2,"label":"Multi line input","value":"","description":"","placeholder":"Multi line input","options":[],"required":false},{"component":"date","editable":true,"index":3,"label":"Date","value":"","description":"","placeholder":"dd-mm-yyyy","options":[],"required":false},{"component":"file","editable":true,"index":4,"label":"File","value":"","description":"","placeholder":"File","options":[],"required":false},{"component":"postCode","editable":true,"index":5,"label":"Postal Code","value":"","description":"","placeholder":"","options":[],"required":false},{"component":"checkbox","editable":true,"index":6,"label":"Checkbox","value":"","description":"","placeholder":"Checkbox","options":["value one","value two"],"required":false},{"component":"signature","editable":true,"index":7,"label":"Signature","value":"","description":"","placeholder":"Signature","options":[],"required":false},{"component":"radio","editable":true,"index":8,"label":"Radio","value":"","description":"","placeholder":"Radio","options":["value one","value two"],"required":false},{"component":"select","editable":true,"index":9,"label":"Dropdown","value":"","description":"","placeholder":"Dropdown","options":["value one","value two"],"required":false}]', '[{"label":"this is fire fox browser this is fire fox browser this is fire fox browser this is fire fox browser","value":""},{"label":"Single line input","value":""},{"label":"Multi line input","value":""},{"label":"Date","value":""},{"label":"File","value":""},{"label":"Postal Code","value":""},{"label":"Checkbox","value":""},{"label":"Signature","value":""},{"label":"Radio","value":"value one"},{"label":"Dropdown","value":"value one"}]', 1, 4, 1, '0', 4, '2017-06-07 11:17:25', '2017-06-07 11:17:25');
INSERT INTO `SCP_OrgFormBuilder` VALUES(68, 'FORM1496814483', 'safari form1', '[{"component":"header","editable":true,"index":0,"label":"safari form1","value":"","description":"","placeholder":"Placeholder","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Single line input fdgdgdfgd","value":"","description":"gdgdf","placeholder":"Placeholdergdfgdfdffdfdgfdgfdf","options":[],"required":true},{"component":"textArea","editable":true,"index":2,"label":"Multi line input gfdggdfg","value":"","description":"gfdgfgdgdf","placeholder":"Placeholderbcvbvcbvb","options":[],"required":false},{"component":"select","editable":true,"index":3,"label":"Dropdown","value":"","description":"fdgfdgdfgdgdggdgd","placeholder":"Placeholder","options":["value one","value two","gfdggdgg"],"required":false},{"component":"radio","editable":true,"index":4,"label":"Radio gfdgdfgcxssd","value":"","description":"sgfdgfdgfdgdg","placeholder":"Placeholder","options":["value one","value two","fgsdgsggsdfg"],"required":false},{"component":"postCode","editable":true,"index":5,"label":"Postal Code gfdgdfzggdgd","value":"","description":"","placeholder":"","options":[],"required":true},{"component":"file","editable":true,"index":6,"label":"file gdfgfdgdg","value":"","description":"cbvbcbcbcbc","placeholder":"Placeholder","options":[],"required":true},{"component":"signature","editable":true,"index":7,"label":"Signature gfddfgd","value":"","description":"dgdggdg","placeholder":"Placeholder","options":[],"required":true},{"component":"date","editable":true,"index":8,"label":"Date dfgfdgdg","value":"","description":"gfdgdfgdfg","placeholder":"Placeholder gfdgdfgdfgdfggd","options":[],"required":true},{"component":"checkbox","editable":true,"index":9,"label":"Checkbox","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false}]', '[{"label":"safari form1","value":""},{"label":"Single line input fdgdgdfgd","value":""},{"label":"Multi line input gfdggdfg","value":""},{"label":"Dropdown","value":"value one"},{"label":"Radio gfdgdfgcxssd","value":"value one"},{"label":"Postal Code gfdgdfzggdgd","value":""},{"label":"file gdfgfdgdg","value":""},{"label":"Signature gfddfgd","value":""},{"label":"Date dfgfdgdg","value":""},{"label":"Checkbox","value":""}]', 1, 4, 1, '0', 4, '2017-06-07 11:18:03', '2017-06-07 11:18:03');
INSERT INTO `SCP_OrgFormBuilder` VALUES(69, 'FORM1496823279', 'chrome client', '[{"component":"textInput","editable":true,"index":0,"label":"Single line input Single line input Single line input Single line input Single line input Single lin","value":"","description":"Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input","placeholder":"Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input","options":[],"required":true},{"component":"header","editable":true,"index":1,"label":"chrome client","value":"","description":"","placeholder":"Title","options":[],"required":false},{"component":"textArea","editable":true,"index":2,"label":"Multi line input Single line input Single line input Single line input Single line input Single line","value":"","description":"Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input","placeholder":"Multi line inSingle line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input put","options":[],"required":false},{"component":"checkbox","editable":true,"index":3,"label":"Single line input Single line input Single line input Single line input Single line input Single lin","value":"","description":"Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input","placeholder":"Checkbox","options":["value Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input Single line input ","value Single line input two"],"required":false},{"component":"date","editable":true,"index":4,"label":"Date","value":"","description":"","placeholder":"dd-mm-yyyy","options":[],"required":false},{"component":"postCode","editable":true,"index":5,"label":"Postal Code","value":"","description":"","placeholder":"","options":[],"required":false},{"component":"signature","editable":true,"index":6,"label":"Signature","value":"","description":"","placeholder":"Signature","options":[],"required":false},{"component":"radio","editable":true,"index":7,"label":"Radio","value":"","description":"","placeholder":"Radio","options":["value one","value two"],"required":false},{"component":"select","editable":true,"index":8,"label":"Dropdown","value":"","description":"","placeholder":"Dropdown","options":["value one","value two"],"required":false}]', '[{"label":"Single line input Single line input Single line input Single line input Single line input Single lin","value":""},{"label":"chrome client","value":""},{"label":"Multi line input Single line input Single line input Single line input Single line input Single line","value":""},{"label":"Single line input Single line input Single line input Single line input Single line input Single lin","value":""},{"label":"Date","value":""},{"label":"Postal Code","value":""},{"label":"Signature","value":""},{"label":"Radio","value":"value one"},{"label":"Dropdown","value":"value one"}]', 1, 3, 1, '0', 4, '2017-06-07 13:44:39', '2017-06-07 13:44:39');
INSERT INTO `SCP_OrgFormBuilder` VALUES(71, 'FORM1496904812', 'client  fire fox browser', '[{"component":"header","editable":true,"index":0,"label":"client  fire fox browser","value":"","description":"","placeholder":"Title","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Single line input client  fire fox browser client  fire fox browser client  fire fox browser client","value":"","description":"client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser","placeholder":"Single line input client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser","options":[],"required":true},{"component":"textArea","editable":true,"index":2,"label":"Multi line input client  fire fox browser client  fire fox browser client  fire fox browser client","value":"","description":"client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser","placeholder":"Multi line input client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser","options":[],"required":true},{"component":"select","editable":true,"index":3,"label":"client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser","value":"","description":"client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser","placeholder":"Dropdown","options":["value one","value two","client  fire fox browser"],"required":false},{"component":"radio","editable":true,"index":4,"label":"Radio","value":"","description":"","placeholder":"Radio","options":["value one","value two"],"required":false},{"component":"checkbox","editable":true,"index":5,"label":"Checkbox","value":"","description":"","placeholder":"Checkbox","options":["value one","value two"],"required":false},{"component":"date","editable":true,"index":6,"label":"Date","value":"","description":"","placeholder":"dd-mm-yyyy","options":[],"required":false},{"component":"signature","editable":true,"index":7,"label":"Signature","value":"","description":"","placeholder":"Signature","options":[],"required":false},{"component":"file","editable":true,"index":8,"label":"File","value":"","description":"","placeholder":"File","options":[],"required":false},{"component":"postCode","editable":true,"index":9,"label":"Postal Code","value":"","description":"","placeholder":"","options":[],"required":false}]', '[{"label":"client  fire fox browser","value":""},{"label":"Single line input client  fire fox browser client  fire fox browser client  fire fox browser client","value":""},{"label":"Multi line input client  fire fox browser client  fire fox browser client  fire fox browser client","value":""},{"label":"client  fire fox browser client  fire fox browser client  fire fox browser client  fire fox browser","value":"value one"},{"label":"Radio","value":"value one"},{"label":"Checkbox","value":""},{"label":"Date","value":""},{"label":"Signature","value":""},{"label":"File","value":""},{"label":"Postal Code","value":""}]', 1, 12, 1, '0', 4, '2017-06-08 12:23:32', '2017-06-08 12:23:32');
INSERT INTO `SCP_OrgFormBuilder` VALUES(72, 'FORM1496906752', 'Form 1', '[{"component":"header","editable":true,"index":0,"label":"Form 1","value":"","description":"","placeholder":"Title","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Single Line Input","value":"","description":"This is test input fields","placeholder":"Single line input","options":[],"required":true},{"component":"textArea","editable":true,"index":2,"label":"Multi line input","value":"","description":"Form for Form for chrome Form for chrome Form for chrome Form for chrome Form for chrome","placeholder":"Multi line Form","options":[],"required":true},{"component":"select","editable":true,"index":3,"label":"Dropdown","value":"","description":"","placeholder":"Dropdown","options":["value one","value two","value three","value four"],"required":false},{"component":"radio","editable":true,"index":4,"label":"Radio","value":"","description":"Form for chrome","placeholder":"Radio","options":["value one","value two"],"required":false},{"component":"date","editable":true,"index":5,"label":"Date Form","value":"","description":"","placeholder":"dd-mm-yyyy","options":[],"required":true},{"component":"postCode","editable":true,"index":6,"label":"Postal Code","value":"","description":"","placeholder":"","options":[],"required":true}]', '', 1, 9, 1, '1', 4, '2017-06-12 15:21:25', '2017-06-13 16:24:38');
INSERT INTO `SCP_OrgFormBuilder` VALUES(73, 'FORM1497262155', 'Simple Form', '[{"component":"header","editable":true,"index":0,"label":"Simple Form","value":"","description":"","placeholder":"Title","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Single line input","value":"","description":"","placeholder":"Single line input","options":[],"required":false},{"component":"textArea","editable":true,"index":2,"label":"Multi line input","value":"","description":"","placeholder":"Multi line input","options":[],"required":false},{"component":"checkbox","editable":true,"index":3,"label":"Checkbox","value":"","description":"","placeholder":"Checkbox","options":["value one","value two","value three","value four","value five","value six","value seven","value eight"],"required":false},{"component":"signature","editable":true,"index":4,"label":"Signature","value":"","description":"","placeholder":"Signature","options":[],"required":false},{"component":"radio","editable":true,"index":5,"label":"Radio","value":"","description":"","placeholder":"Radio","options":["value one","value two"],"required":false}]', '[{"label":"Simple Form","value":""},{"label":"Single line input","value":""},{"label":"Multi line input","value":""},{"label":"Checkbox","value":""}]', 1, 9, 1, '0', 4, '2017-06-12 15:39:15', '2017-06-14 19:56:36');
INSERT INTO `SCP_OrgFormBuilder` VALUES(74, 'FORM1497349501', 'Heading', '[{"component":"header","editable":true,"index":0,"label":"Heading","value":"","description":"","placeholder":"Title","options":[],"required":false},{"component":"textInput","editable":true,"index":1,"label":"Single line input","value":"","description":"","placeholder":"Single line input","options":[],"required":false},{"component":"select","editable":true,"index":2,"label":"Dropdown","value":"","description":"","placeholder":"Dropdown","options":["value one","value two"],"required":false}]', '[{"label":"Heading","value":""},{"label":"Single line input","value":""},{"label":"Dropdown","value":"value one"}]', 1, 9, 1, '0', 4, '2017-06-13 15:55:01', '2017-06-13 15:55:01');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_OrgFormBuilderDataAction`
--

CREATE TABLE `SCP_OrgFormBuilderDataAction` (
  `FormID` int(11) NOT NULL AUTO_INCREMENT,
  `FormName` varchar(156) NOT NULL,
  `FormValueData` longtext NOT NULL,
  `UserID` int(11) NOT NULL,
  `CustomerID` int(11) NOT NULL,
  `FormDataID` varchar(156) NOT NULL,
  `FormCompletedDateTime` varchar(156) NOT NULL,
  `StatusID` int(11) NOT NULL,
  `CreatedDateTime` datetime NOT NULL,
  `ModifyDateTime` datetime NOT NULL,
  PRIMARY KEY (`FormID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `SCP_OrgFormBuilderDataAction`
--

INSERT INTO `SCP_OrgFormBuilderDataAction` VALUES(1, '', 'O:8:"stdClass":9:{s:1:"0";s:0:"";s:1:"1";s:5:"somil";s:1:"2";s:0:"";s:1:"3";s:0:"";s:1:"4";s:0:"";s:1:"5";s:0:"";s:1:"6";s:0:"";s:1:"7";s:23:"IMG_20170519_174926.jpg";s:1:"8";s:0:"";}', 21, 18, 'FORM1494333149', '', 1, '2017-05-16 17:33:50', '2017-05-30 07:03:31');
INSERT INTO `SCP_OrgFormBuilderDataAction` VALUES(5, '', 'O:8:"stdClass":6:{s:1:"0";s:0:"";s:1:"1";s:4:"test";s:1:"2";s:8:"ABC text";s:1:"3";s:19:"value one,value two";s:1:"4";s:21:"SIG-1497593482152.png";s:1:"5";s:9:"value two";}', 21, 18, 'null', '', 1, '2017-06-12 04:31:32', '2017-06-15 23:11:49');
INSERT INTO `SCP_OrgFormBuilderDataAction` VALUES(6, '', 'O:8:"stdClass":6:{s:1:"0";s:0:"";s:1:"1";s:5:"Somil";s:1:"2";s:16:"Multilinear text";s:1:"3";s:21:"value four,value five";s:1:"4";s:21:"SIG-1497600789801.png";s:1:"5";s:9:"value two";}', 21, 18, '73', '', 1, '2017-06-15 23:29:57', '2017-06-16 01:13:26');
INSERT INTO `SCP_OrgFormBuilderDataAction` VALUES(7, '', 'O:8:"stdClass":9:{s:1:"0";s:0:"";s:1:"1";s:5:"somil";s:1:"2";s:0:"";s:1:"3";s:0:"";s:1:"4";s:0:"";s:1:"5";s:0:"";s:1:"6";s:0:"";s:1:"7";s:10:"Avatar.PNG";s:1:"8";s:0:"";}', 21, 18, '12', '', 1, '2017-06-15 23:41:07', '2017-06-16 00:57:25');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_OutComes`
--

CREATE TABLE `SCP_OutComes` (
  `OutComeID` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(150) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`OutComeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `SCP_OutComes`
--


-- --------------------------------------------------------

--
-- Table structure for table `SCP_Qualification`
--

CREATE TABLE `SCP_Qualification` (
  `QualificationID` int(11) NOT NULL AUTO_INCREMENT,
  `Qualification` varchar(150) NOT NULL,
  `Slug` varchar(150) NOT NULL,
  `OrgID` int(11) NOT NULL DEFAULT '0' COMMENT '0=created by super admin',
  `StatusID` int(11) NOT NULL,
  `CreatedDateTime` datetime NOT NULL,
  `ModifyDateTime` datetime NOT NULL,
  PRIMARY KEY (`QualificationID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `SCP_Qualification`
--

INSERT INTO `SCP_Qualification` VALUES(1, 'First Aid', 'first-aid', 0, 1, '2017-06-07 02:38:35', '2017-06-07 02:38:35');
INSERT INTO `SCP_Qualification` VALUES(2, 'BE', 'be', 0, 1, '2017-06-12 10:48:52', '2017-06-12 10:48:52');
INSERT INTO `SCP_Qualification` VALUES(3, 'BE', 'be', 0, 1, '2017-06-12 10:49:23', '2017-06-12 10:49:23');
INSERT INTO `SCP_Qualification` VALUES(4, 'BE', 'be', 0, 2, '2017-06-12 11:12:47', '2017-06-12 11:12:47');
INSERT INTO `SCP_Qualification` VALUES(5, 'safari  1', 'safari', 0, 2, '2017-06-12 11:22:36', '2017-06-12 11:22:36');
INSERT INTO `SCP_Qualification` VALUES(6, 'Wash and Bathe', 'wash-and-bathe', 0, 1, '2017-06-12 21:13:04', '2017-06-12 21:13:04');
INSERT INTO `SCP_Qualification` VALUES(7, 'Food and Hygeine', 'food-and-hygeine', 0, 1, '2017-06-12 21:13:43', '2017-06-12 21:13:43');
INSERT INTO `SCP_Qualification` VALUES(8, 'Double up', 'double-up', 0, 1, '2017-06-13 01:11:43', '2017-06-13 01:11:43');
INSERT INTO `SCP_Qualification` VALUES(9, 'Medication supervision', 'medication-supervision', 0, 1, '2017-06-13 01:12:57', '2017-06-13 01:12:57');
INSERT INTO `SCP_Qualification` VALUES(10, 'BCA', '', 9, 1, '2017-06-15 05:54:23', '2017-06-15 05:54:23');
INSERT INTO `SCP_Qualification` VALUES(11, 'First Aid', '', 3, 2, '2017-06-15 23:29:58', '2017-06-15 23:29:58');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Qualification_Staff`
--

CREATE TABLE `SCP_Qualification_Staff` (
  `QualificationAssignID` int(11) NOT NULL AUTO_INCREMENT,
  `StaffID` int(11) NOT NULL,
  `QualificationID` int(11) NOT NULL,
  `StatusID` int(11) NOT NULL,
  `OrgID` int(11) NOT NULL,
  `CreatedDateTime` datetime NOT NULL,
  `ModifyDateTime` datetime NOT NULL,
  PRIMARY KEY (`QualificationAssignID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=50 ;

--
-- Dumping data for table `SCP_Qualification_Staff`
--

INSERT INTO `SCP_Qualification_Staff` VALUES(35, 29, 0, 1, 4, '2017-06-12 22:50:05', '2017-06-12 22:50:05');
INSERT INTO `SCP_Qualification_Staff` VALUES(47, 35, 6, 1, 9, '2017-06-15 14:11:50', '2017-06-15 14:11:50');
INSERT INTO `SCP_Qualification_Staff` VALUES(46, 35, 1, 1, 9, '2017-06-15 14:11:50', '2017-06-15 14:11:50');
INSERT INTO `SCP_Qualification_Staff` VALUES(45, 33, 9, 1, 9, '2017-06-15 09:24:29', '2017-06-15 09:24:29');
INSERT INTO `SCP_Qualification_Staff` VALUES(17, 15, 8, 1, 9, '2017-06-12 12:45:29', '2017-06-12 12:45:29');
INSERT INTO `SCP_Qualification_Staff` VALUES(16, 15, 7, 1, 9, '2017-06-12 12:45:29', '2017-06-12 12:45:29');
INSERT INTO `SCP_Qualification_Staff` VALUES(15, 15, 6, 1, 9, '2017-06-12 12:45:29', '2017-06-12 12:45:29');
INSERT INTO `SCP_Qualification_Staff` VALUES(14, 15, 1, 1, 9, '2017-06-12 12:45:29', '2017-06-12 12:45:29');
INSERT INTO `SCP_Qualification_Staff` VALUES(44, 33, 8, 1, 9, '2017-06-15 09:24:29', '2017-06-15 09:24:29');
INSERT INTO `SCP_Qualification_Staff` VALUES(43, 33, 7, 1, 9, '2017-06-15 09:24:29', '2017-06-15 09:24:29');
INSERT INTO `SCP_Qualification_Staff` VALUES(42, 33, 6, 1, 9, '2017-06-15 09:24:29', '2017-06-15 09:24:29');
INSERT INTO `SCP_Qualification_Staff` VALUES(41, 33, 1, 1, 9, '2017-06-15 09:24:29', '2017-06-15 09:24:29');
INSERT INTO `SCP_Qualification_Staff` VALUES(48, 35, 7, 1, 9, '2017-06-15 14:11:50', '2017-06-15 14:11:50');
INSERT INTO `SCP_Qualification_Staff` VALUES(49, 35, 8, 1, 9, '2017-06-15 14:11:50', '2017-06-15 14:11:50');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Rights`
--

CREATE TABLE `SCP_Rights` (
  `RightsID` int(11) NOT NULL AUTO_INCREMENT,
  `RightsType` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`RightsID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `SCP_Rights`
--

INSERT INTO `SCP_Rights` VALUES(1, 'ALL', '2017-03-01 18:14:00', '2017-03-01 18:14:00', 1);
INSERT INTO `SCP_Rights` VALUES(2, 'ADD,EDIT,DELETE', '2017-03-01 18:14:00', '2017-03-01 18:14:00', 1);
INSERT INTO `SCP_Rights` VALUES(3, 'EDIT,DELETE', '2017-03-01 18:14:00', '2017-03-01 18:14:00', 1);
INSERT INTO `SCP_Rights` VALUES(4, 'EDIT', '2017-03-01 18:14:00', '2017-03-01 18:14:00', 1);
INSERT INTO `SCP_Rights` VALUES(5, 'ADD', '2017-03-01 00:00:00', '2017-03-01 18:14:00', 1);
INSERT INTO `SCP_Rights` VALUES(6, 'DELETE', '2017-03-01 00:00:00', '2017-03-01 00:00:00', 1);
INSERT INTO `SCP_Rights` VALUES(7, 'ADD,EDIT', '2017-03-01 00:00:00', '2017-03-01 00:00:00', 1);
INSERT INTO `SCP_Rights` VALUES(8, 'VIEWONLY', '2017-03-01 00:00:00', '2017-03-01 00:00:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Settings`
--

CREATE TABLE `SCP_Settings` (
  `SettingID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) DEFAULT NULL,
  `SettingsTypeID` int(11) DEFAULT NULL,
  `TypeName` varchar(150) DEFAULT NULL,
  `Value` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`SettingID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `SCP_Settings`
--


-- --------------------------------------------------------

--
-- Table structure for table `SCP_SettingsValue`
--

CREATE TABLE `SCP_SettingsValue` (
  `SettingsTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `SettingsValues` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`SettingsTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `SCP_SettingsValue`
--


-- --------------------------------------------------------

--
-- Table structure for table `SCP_Staff`
--

CREATE TABLE `SCP_Staff` (
  `StaffID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` varchar(150) NOT NULL,
  `Name` varchar(150) DEFAULT NULL,
  `Surname` varchar(150) NOT NULL,
  `MiddleName` varchar(150) NOT NULL,
  `DateOfBirth` varchar(40) NOT NULL,
  `Gender` varchar(40) NOT NULL,
  `Ethnicity` varchar(150) NOT NULL,
  `HouseNumber` varchar(150) NOT NULL,
  `Address1` varchar(150) NOT NULL,
  `Address2` varchar(150) NOT NULL,
  `City` varchar(150) NOT NULL,
  `Country` varchar(150) NOT NULL,
  `PostCode` varchar(9) NOT NULL,
  `Mobile` varchar(150) NOT NULL,
  `ProfilePhoto` varchar(256) NOT NULL,
  `NOKName` varchar(150) NOT NULL,
  `NOKMobile` varchar(150) NOT NULL,
  `NOKEmail` varchar(150) NOT NULL,
  `OrgID` int(11) NOT NULL,
  `UserAccessID` int(11) DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  `LicenseID` int(11) DEFAULT NULL,
  `ArchiveUser` int(11) NOT NULL DEFAULT '0' COMMENT '0=not archive,1=archive',
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `QualificationID` int(11) NOT NULL,
  PRIMARY KEY (`StaffID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=38 ;

--
-- Dumping data for table `SCP_Staff`
--

INSERT INTO `SCP_Staff` VALUES(1, 'Mr', 'John', 'Smith', '', '2017-05-14T18:30:00.000Z', 'Male', '123', '12', 'test', '', 'test', '101', '45A4 5A45', '1234567890', '', 'test', '1234567890', 'aban@gmail.com', 9, 12, 21, 8, 0, '2017-05-15 16:20:47', '2017-06-06 14:09:45', 1, 0);
INSERT INTO `SCP_Staff` VALUES(2, 'Mr', 'John Smith', 'Smith', '', '2017-05-17T18:30:00.000Z', 'Male', '123', '12', 'test', '', 'test', '101', '45A4 5A45', '1234567890', '', 'test', '1234567890', 'aban@gmail.com', 9, 14, 22, 8, 1, '2017-05-15 16:20:47', '2017-06-10 15:32:57', 2, 0);
INSERT INTO `SCP_Staff` VALUES(3, 'Mr', 'John', 'Smith', '', '2017-05-14T18:30:00.000Z', 'Male', '123', '12', 'test', '', 'test', '101', '45A4 5A45', '1234567890', '', 'test', '1234567890', 'aban@gmail.com', 9, 21, 21, 8, 0, '2017-05-15 16:20:47', '2017-05-15 16:20:47', 1, 0);
INSERT INTO `SCP_Staff` VALUES(4, 'Mr', 'test 29 may', 'test', 'testhere', '2017-05-28T18:30:00.000Z', 'Male', 'test', '12', 'indore', 'india', 'indore', '101', '453 A44', '9179148851', 'http://stealthcare.izisstechnology.in/uploads/user3test29mayuserer.jpeg', 'nok name test', '9179148852', 'test@test.com', 11, 26, 26, 11, 0, '2017-05-29 02:47:58', '2017-05-29 02:47:58', 1, 0);
INSERT INTO `SCP_Staff` VALUES(5, 'Mr', 'amit', 'amit', '', '2017-05-28T18:30:00.000Z', 'Male', 'dasdas', 'dasd', 'dasdsad', '', 'asdasd', '2', 'SADD ASDA', '12345678', '', 'asd', '56464654', 'abc@gmail.com', 11, 27, 27, 12, 0, '2017-05-29 03:14:53', '2017-05-29 03:14:53', 1, 0);
INSERT INTO `SCP_Staff` VALUES(9, 'Mr', 'ashish', 'kushwah', '', '2017-05-30T18:30:00.000Z', 'Male', 'fsdfds', 'dasdasd', 'dasda', '', 'dasd', '4', 'DADA SASD', '465464646544', '', 'sdfsd', '56464654556454', 'abc@gmail.com', 11, 31, 31, 16, 0, '2017-05-29 03:30:04', '2017-05-29 03:30:04', 1, 0);
INSERT INTO `SCP_Staff` VALUES(10, 'Mr', 'ashish', 'kushwah', '', '2017-05-30T18:30:00.000Z', 'Male', 'fsdfds', 'dasdasd', 'dasda', '', 'dasd', '4', 'DADA SASD', '465464646544', '', 'sdfsd', '56464654556454', 'abc@gmail.com', 11, 32, 32, 17, 0, '2017-05-29 03:30:04', '2017-05-29 03:30:04', 1, 0);
INSERT INTO `SCP_Staff` VALUES(11, 'Mr', 'ashish', 'kushwah', '', '2017-05-30T18:30:00.000Z', 'Male', 'fsdfds', 'dasdasd', 'dasda', '', 'dasd', '4', 'DADA SASD', '465464646544', '', 'sdfsd', '56464654556454', 'abc@gmail.com', 11, 33, 33, 18, 0, '2017-05-29 03:30:04', '2017-05-29 03:30:04', 1, 0);
INSERT INTO `SCP_Staff` VALUES(12, 'Mr', 'ashish', 'kushwah', '', '2017-05-30T18:30:00.000Z', 'Male', 'fsdfds', 'dasdasd', 'dasda', '', 'dasd', '4', 'DADA SASD', '465464646544', '', 'sdfsd', '56464654556454', 'abc@gmail.com', 11, 34, 34, 19, 0, '2017-05-29 03:30:04', '2017-05-29 03:30:04', 1, 0);
INSERT INTO `SCP_Staff` VALUES(13, 'Mr', 'ashish', 'kushwah', '', '2017-05-30T18:30:00.000Z', 'Male', 'fsdfds', 'dasdasd', 'dasda', '', 'dasd', '4', 'DADA SASD', '465464646544', '', 'sdfsd', '56464654556454', 'abc@gmail.com', 11, 35, 35, 20, 0, '2017-05-29 03:30:32', '2017-05-29 03:30:32', 1, 0);
INSERT INTO `SCP_Staff` VALUES(14, 'Mr', 'ashish', 'kushwah', '', '2017-05-30T18:30:00.000Z', 'Male', 'fsdfds', 'dasdasd', 'dasda', '', 'dasd', '4', 'DADA SASD', '465464646544', '', 'sdfsd', '56464654556454', 'abc@gmail.com', 11, 36, 36, 21, 0, '2017-05-29 03:30:46', '2017-05-29 03:30:46', 1, 0);
INSERT INTO `SCP_Staff` VALUES(15, 'Mr', 'Anil', 'Iziss', '', '2017-06-14T18:30:00.000Z', 'Male', '123', '12', 'Indore', '', 'Indore', '101', 'HAGA GGGG', '1234567890', '', 'Test', '7415850336', 'aban@gmail.com', 9, 37, 37, 22, 0, '2017-06-01 07:07:41', '2017-06-01 07:07:41', 1, 0);
INSERT INTO `SCP_Staff` VALUES(17, 'Mr', 'perm', 'perm', '', '2017-06-14T23:00:00.000Z', 'Male', 'asian', '25', '12', '', 'london', '230', 'SW 1111', '2222222222', '', 'p', '001001111', 'p.singh@gmail.com', 13, 64, 64, 47, 0, '2017-06-09 01:15:30', '2017-06-09 01:15:30', 1, 0);
INSERT INTO `SCP_Staff` VALUES(27, 'Mr', 'rahul', 'Sharmaji', 'ray', '2016-11-01T18:30:00.000Z', 'Male', 'ethen', '12', 'andheri', 'tdstst', 'indore', '101', 'AAAA 4545', '9179148851', 'http://stealthcare.izisstechnology.in/uploads/userrahulraoy.jpeg', 'test', '1234567890', 'fd@dsdsd.com', 4, 74, 74, 57, 1, '2017-06-10 05:23:30', '2017-06-10 05:35:46', 2, 1);
INSERT INTO `SCP_Staff` VALUES(28, 'Mr', 'Frontend user for fire fox', 'fire fox', '', '2017-06-08T18:30:00.000Z', 'Female', 'fire fox', 'indore', 'indore', '', 'indore', '', 'VXCV XCZV', '123456789', 'http://stealthcare.izisstechnology.in/uploads/userFrontend user for chrome.jpeg', 'indore', '123456789', 'user1@mailinator.com', 4, 75, 75, 58, 1, '2017-06-10 05:27:10', '2017-06-10 05:30:17', 2, 0);
INSERT INTO `SCP_Staff` VALUES(29, 'Mr', 'Frontend user for fire fox', 'fire fox', '', '2017-06-09T18:30:00.000Z', 'Female', 'fire fox', 'indore', 'indore', '', 'indore', '', 'JKLH HJKH', '123456789', '', 'indore', '123456789', 'user1@mailinator.com', 4, 76, 76, 59, 0, '2017-06-10 05:39:29', '2017-06-19 03:43:07', 2, 0);
INSERT INTO `SCP_Staff` VALUES(30, 'Mr', 'Frontend user for fire fox', 'fire fox', '', '2017-06-09T18:30:00.000Z', 'Male', 'chrome', 'indore', 'indore', '', 'indore', '2', 'INDO ASDA', '123456789', '', 'indore', '123456789', 'user1@mailinator.com', 4, 77, 77, 60, 0, '2017-06-10 05:41:56', '2017-06-19 03:42:04', 2, 0);
INSERT INTO `SCP_Staff` VALUES(31, 'Mr', 'raju', 'abc', '', '2017-06-05T18:30:00.000Z', 'Female', 'fire fox', 'indore', 'indore', 'tdstst', 'indore', '2', 'INDO INDO', '123456789', 'http://stealthcare.izisstechnology.in/uploads/userFrontend user for chrome 1.jpeg', 'indore', '123456789', 'user1@mailinator.com', 4, 78, 78, 61, 1, '2017-06-11 22:11:10', '2017-06-11 22:16:02', 2, 0);
INSERT INTO `SCP_Staff` VALUES(32, 'Mr', 'ram', 'ram', '', '2017-06-11T18:30:00.000Z', 'Male', 'chrome', 'jaipur', 'jaipur', '', 'organisat', '5', 'CZCF CDSF', '12345678', 'http://stealthcare.izisstechnology.in/uploads/usergvdsfds.jpeg', 'jaipur', '12345678', 'frontenduser@mailinator.com', 4, 79, 79, 62, 0, '2017-06-11 22:34:29', '2017-06-12 00:12:33', 2, 2);
INSERT INTO `SCP_Staff` VALUES(33, 'Mr', 'Mukul', 'Kothari', 'Vijay', '1988-03-01T18:30:00.000Z', 'Male', 'Indian', '109 lokmanya nagar', 'indore', 'indore', 'indore', '101', '4532 3132', '9826400568', 'http://stealthcare.izisstechnology.in/uploads/userMukulKothari.png', 'Test', '9999999999', 'test@mail.com', 9, 80, 80, 63, 0, '2017-06-11 23:05:02', '2017-06-14 00:15:08', 1, 0);
INSERT INTO `SCP_Staff` VALUES(34, 'Mr', 'rohan', 'gupta', '', '2017-06-05T18:30:00.000Z', 'Male', 'fire fox', 'indore', 'indore', 'tdstst', 'indore', '4', 'FDSD INDO', '123456789', 'http://stealthcare.izisstechnology.in/uploads/user123 Frontend user for chrome.jpeg', 'indore', '123456789', 'user1@mailinator.com', 4, 81, 81, 64, 0, '2017-06-12 00:16:26', '2017-06-19 03:42:51', 1, 0);
INSERT INTO `SCP_Staff` VALUES(35, 'Mr', 'Perm', 'Singh', '', '2017-06-04T23:00:00.000Z', 'Male', 'Asian', '12', 'test Road', '', 'London', '230', 'SQQ 111', '078282828822', 'http://stealthcare.izisstechnology.in/uploads/userpermjeet.jpeg', 'Perm', '0101010101', 'p.si@gmail.com', 9, 82, 82, 65, 0, '2017-06-15 14:08:23', '2017-06-15 14:11:36', 1, 0);
INSERT INTO `SCP_Staff` VALUES(36, 'Mr', 'PermPerm', 'Singh', '', '2017-06-14T23:00:00.000Z', 'Male', 'Asian', '12', '11', '', 'London', '230', 'SW1 S', '0202020202', '', 'pp', '01001010101', 'p.sifkffkf@gmail.com', 10, 83, 83, 66, 0, '2017-06-15 14:19:54', '2017-06-15 14:19:54', 1, 0);
INSERT INTO `SCP_Staff` VALUES(37, 'Mr', 'shubham', 'gupta', '', '2017-06-15T18:30:00.000Z', 'Male', 'abcd', 'adad', 'dadasd', '', 'dadsad', '101', '0122 2112', '246465454654', '', 'tester', '123456789', 'abc@gmail.com', 4, 85, 85, 67, 0, '2017-06-19 03:40:30', '2017-06-19 03:42:24', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Status`
--

CREATE TABLE `SCP_Status` (
  `StatusID` int(11) NOT NULL,
  `StatusName` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`StatusID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SCP_Status`
--

INSERT INTO `SCP_Status` VALUES(1, 'ACTIVE', '2017-03-01 18:10:00', '2017-03-01 18:10:00');
INSERT INTO `SCP_Status` VALUES(2, 'DEACTIVE', '2017-03-01 18:10:00', '2017-03-01 18:10:00');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Task`
--

CREATE TABLE `SCP_Task` (
  `TaskID` int(11) NOT NULL AUTO_INCREMENT,
  `TaskDesc` varchar(150) DEFAULT NULL,
  `TaskTypeID` int(11) DEFAULT NULL,
  `TaskStartDate` date DEFAULT NULL,
  `TaskEndDate` date DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `CreatedByStaffID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`TaskID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `SCP_Task`
--

INSERT INTO `SCP_Task` VALUES(1, 'Please can you help with shopping', 1, '2017-05-19', '2017-07-20', 1, 9, 17, '2017-03-01 18:14:00', '2017-03-01 18:14:00');
INSERT INTO `SCP_Task` VALUES(2, 'Wash and bath', 1, '2017-05-19', '2017-05-31', 1, 10, 17, '2017-03-20 07:13:18', '2017-03-01 18:14:00');
INSERT INTO `SCP_Task` VALUES(3, 'E45', 2, '2017-05-09', '2017-06-20', 1, 8, 17, '2017-05-01 18:14:00', '2017-06-01 18:14:00');
INSERT INTO `SCP_Task` VALUES(4, 'Breakfast', 3, '2017-05-11', '2017-06-15', 1, 10, 17, '2017-05-20 07:13:18', '2017-07-01 18:14:00');
INSERT INTO `SCP_Task` VALUES(5, 'Water', 4, '2017-04-19', '2017-06-10', 1, 9, 17, '2017-05-20 07:13:18', '2017-07-01 18:14:00');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Task2OtherRelations`
--

CREATE TABLE `SCP_Task2OtherRelations` (
  `Task2RelationID` int(11) NOT NULL AUTO_INCREMENT,
  `TaskID` int(11) DEFAULT NULL,
  `ToID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`Task2RelationID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `SCP_Task2OtherRelations`
--


-- --------------------------------------------------------

--
-- Table structure for table `SCP_TaskType`
--

CREATE TABLE `SCP_TaskType` (
  `TaskTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `TaskTypeName` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`TaskTypeID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `SCP_TaskType`
--

INSERT INTO `SCP_TaskType` VALUES(1, 'General', '2017-03-01 18:14:00', '2017-03-01 18:14:00', 1);
INSERT INTO `SCP_TaskType` VALUES(2, 'Medication', '2017-03-01 00:00:00', '2017-03-01 00:00:00', 1);
INSERT INTO `SCP_TaskType` VALUES(3, 'Nutrition', '2017-03-01 18:14:00', '2017-03-01 18:14:00', 1);
INSERT INTO `SCP_TaskType` VALUES(4, 'Hydration', '2017-03-01 00:00:00', '2017-03-01 00:00:00', 1);

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Test`
--

CREATE TABLE `SCP_Test` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Data` longtext NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `SCP_Test`
--

INSERT INTO `SCP_Test` VALUES(1, 'Test');
INSERT INTO `SCP_Test` VALUES(2, '');
INSERT INTO `SCP_Test` VALUES(3, '');
INSERT INTO `SCP_Test` VALUES(4, '');
INSERT INTO `SCP_Test` VALUES(5, 'Test');
INSERT INTO `SCP_Test` VALUES(6, '');
INSERT INTO `SCP_Test` VALUES(7, '');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_UserAccess`
--

CREATE TABLE `SCP_UserAccess` (
  `UserAccessID` int(11) NOT NULL AUTO_INCREMENT,
  `RightsID` int(11) DEFAULT NULL,
  `AccessLevelID` int(11) DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  `UserTypeID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`UserAccessID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=86 ;

--
-- Dumping data for table `SCP_UserAccess`
--

INSERT INTO `SCP_UserAccess` VALUES(1, 1, 1, 1, 1, '2017-03-01 18:14:00', '2017-03-01 18:14:00', 1);
INSERT INTO `SCP_UserAccess` VALUES(2, 2, 1, 2, 2, '2017-03-01 18:14:00', '2017-03-01 18:14:00', 1);
INSERT INTO `SCP_UserAccess` VALUES(3, 2, 2, 12, 2, '2017-03-27 17:32:53', '2017-03-27 17:32:53', 2);
INSERT INTO `SCP_UserAccess` VALUES(4, 2, 2, 13, 2, '2017-03-30 12:43:14', '2017-03-30 12:43:14', 2);
INSERT INTO `SCP_UserAccess` VALUES(6, 2, 2, 15, 2, '2017-04-03 13:52:49', '2017-04-03 13:52:49', 1);
INSERT INTO `SCP_UserAccess` VALUES(7, 2, 2, 16, 2, '2017-04-05 17:46:32', '2017-04-05 17:46:32', 2);
INSERT INTO `SCP_UserAccess` VALUES(8, 2, 2, 17, 2, '2017-04-19 18:43:28', '2017-04-19 18:43:28', 1);
INSERT INTO `SCP_UserAccess` VALUES(12, 9, 5, 21, 4, '2017-04-24 12:34:27', '2017-04-24 12:34:27', 1);
INSERT INTO `SCP_UserAccess` VALUES(14, 9, 5, 22, 5, '2017-04-24 12:34:34', '2017-04-24 12:34:34', 1);
INSERT INTO `SCP_UserAccess` VALUES(15, 9, 5, 24, 6, '2017-04-24 12:34:42', '2017-04-24 12:34:42', 1);
INSERT INTO `SCP_UserAccess` VALUES(16, 8, 5, 25, 6, '2017-05-11 13:51:26', '2017-05-11 13:51:26', 2);
INSERT INTO `SCP_UserAccess` VALUES(17, 8, 5, 26, 6, '2017-05-11 13:59:35', '2017-05-11 13:59:35', 1);
INSERT INTO `SCP_UserAccess` VALUES(18, 8, 5, 18, 6, '2017-05-15 16:13:58', '2017-05-15 16:13:58', 1);
INSERT INTO `SCP_UserAccess` VALUES(22, 4, 4, 21, 5, '2017-05-15 16:21:04', '2017-05-15 16:21:04', 1);
INSERT INTO `SCP_UserAccess` VALUES(24, 2, 2, 24, 2, '2017-05-27 14:57:50', '2017-05-27 14:57:50', 1);
INSERT INTO `SCP_UserAccess` VALUES(25, 2, 2, 25, 2, '2017-05-29 13:07:31', '2017-05-29 13:07:31', 2);
INSERT INTO `SCP_UserAccess` VALUES(37, 3, 3, 37, 4, '2017-06-01 07:07:41', '2017-06-01 07:07:41', 1);
INSERT INTO `SCP_UserAccess` VALUES(64, 2, 2, 64, 3, '2017-06-09 01:15:30', '2017-06-09 01:15:30', 1);
INSERT INTO `SCP_UserAccess` VALUES(74, 2, 2, 74, 3, '2017-06-10 05:23:30', '2017-06-10 05:23:30', 1);
INSERT INTO `SCP_UserAccess` VALUES(75, 2, 2, 75, 3, '2017-06-10 05:27:10', '2017-06-10 05:27:10', 1);
INSERT INTO `SCP_UserAccess` VALUES(76, 2, 2, 76, 3, '2017-06-10 05:39:29', '2017-06-19 03:43:07', 2);
INSERT INTO `SCP_UserAccess` VALUES(77, 2, 2, 77, 3, '2017-06-10 05:41:56', '2017-06-19 03:42:04', 2);
INSERT INTO `SCP_UserAccess` VALUES(78, 2, 2, 78, 3, '2017-06-11 22:11:10', '2017-06-11 22:11:10', 1);
INSERT INTO `SCP_UserAccess` VALUES(79, 2, 2, 79, 3, '2017-06-11 22:34:29', '2017-06-12 00:12:33', 2);
INSERT INTO `SCP_UserAccess` VALUES(80, 3, 3, 80, 4, '2017-06-11 23:05:02', '2017-06-14 00:15:08', 1);
INSERT INTO `SCP_UserAccess` VALUES(81, 2, 2, 81, 3, '2017-06-12 00:16:26', '2017-06-19 03:42:51', 1);
INSERT INTO `SCP_UserAccess` VALUES(82, 2, 2, 82, 3, '2017-06-15 14:08:23', '2017-06-15 14:11:36', 1);
INSERT INTO `SCP_UserAccess` VALUES(83, 2, 2, 83, 3, '2017-06-15 14:19:54', '2017-06-15 14:19:54', 1);
INSERT INTO `SCP_UserAccess` VALUES(84, 8, 5, 84, 6, '2017-06-18 16:12:20', '2017-06-18 16:12:20', 1);
INSERT INTO `SCP_UserAccess` VALUES(85, 3, 3, 85, 4, '2017-06-19 03:40:30', '2017-06-19 03:42:24', 1);

-- --------------------------------------------------------

--
-- Table structure for table `SCP_UserLogin`
--

CREATE TABLE `SCP_UserLogin` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(150) DEFAULT NULL,
  `EmailID` varchar(150) DEFAULT NULL,
  `Password` varchar(150) DEFAULT NULL,
  `ProfilePhoto` varchar(256) NOT NULL,
  `DashboardLogo` varchar(256) NOT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `LoginStatus` int(11) NOT NULL DEFAULT '0' COMMENT '0=offline,1=online',
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=86 ;

--
-- Dumping data for table `SCP_UserLogin`
--

INSERT INTO `SCP_UserLogin` VALUES(1, 'scpAdmin', 'admin@gmail.com', '2bdd3604cd9755bec86999d30666994e', 'http://stealthcare.izisstechnology.in/uploads/user1.jpeg', 'http://stealthcare.izisstechnology.in/uploads/logo1.png', 1, 0, '2017-03-01 18:10:00', '2017-03-01 18:10:00');
INSERT INTO `SCP_UserLogin` VALUES(2, 'IzissTech', 'anil.banwar@izisstechnology.com', '2bdd3604cd9755bec86999d30666994e', '', '', 1, 0, '2017-03-01 18:10:00', '2017-04-03 12:43:20');
INSERT INTO `SCP_UserLogin` VALUES(12, 'rest', 'abanwar@gmail.com', 'df6d2338b2b8fce1ec2f6dda0a630eb0', '', '', 2, 0, '2017-03-27 17:32:53', '2017-04-03 16:55:25');
INSERT INTO `SCP_UserLogin` VALUES(13, 'testData', 'abanwar1@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', '', '', 2, 0, '2017-03-30 12:43:14', '2017-04-04 20:40:32');
INSERT INTO `SCP_UserLogin` VALUES(15, 'TestUser', 'aashkothari@yahoo.co.in', '202cb962ac59075b964b07152d234b70', '', '', 1, 0, '2017-04-03 13:52:49', '2017-04-05 16:11:34');
INSERT INTO `SCP_UserLogin` VALUES(16, 'izissA', 'ashish.kushwah@izisstechnology.com', 'e10adc3949ba59abbe56e057f20f883e', '', '', 2, 0, '2017-04-05 17:46:32', '2017-04-05 17:46:32');
INSERT INTO `SCP_UserLogin` VALUES(17, 'abanwar', 'abanwar2407@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', '', 'http://stealthcare.izisstechnology.in/uploads/logo1.png', 1, 0, '2017-04-19 18:43:28', '2017-04-19 18:43:28');
INSERT INTO `SCP_UserLogin` VALUES(18, 'testClient', 'client@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', '', '', 1, 0, '2017-05-15 16:13:58', '2017-05-15 16:13:58');
INSERT INTO `SCP_UserLogin` VALUES(21, 'assasor', 'assasor@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', '', '', 1, 0, '2017-05-15 16:20:47', '2017-05-15 16:20:47');
INSERT INTO `SCP_UserLogin` VALUES(22, 'careworker', 'careworker@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', '', '', 2, 0, '2017-05-15 16:21:04', '2017-05-15 16:21:04');
INSERT INTO `SCP_UserLogin` VALUES(23, 'careworker1', 'careworker1@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', '', '', 1, 0, '2017-05-15 16:21:07', '2017-05-15 16:21:07');
INSERT INTO `SCP_UserLogin` VALUES(24, 'perm', 'pc4your@gmail.com', 'ca659200663cf654dc4410ed494451ee', 'http://stealthcare.izisstechnology.in/uploads/user24.jpeg', 'http://stealthcare.izisstechnology.in/uploads/logo24.png', 1, 0, '2017-05-27 14:57:50', '2017-05-27 14:57:50');
INSERT INTO `SCP_UserLogin` VALUES(25, 'user100', 'user100@mailinator.com', '25d55ad283aa400af464c76d713c07ad', '', '', 2, 0, '2017-05-29 13:07:31', '2017-05-29 13:07:31');
INSERT INTO `SCP_UserLogin` VALUES(37, 'aiziss', 'test@phpzag.com', 'b05138681b2595d8e0651fe759643f57', '', '', 1, 0, '2017-06-01 07:07:41', '2017-06-01 07:07:41');
INSERT INTO `SCP_UserLogin` VALUES(64, 'perm', 'pc4your@fmail.com', 'ca659200663cf654dc4410ed494451ee', '', '', 1, 0, '2017-06-09 01:15:30', '2017-06-09 01:15:30');
INSERT INTO `SCP_UserLogin` VALUES(74, 'rahulraoy', 'rahul@test.com', '25d55ad283aa400af464c76d713c07ad', 'http://stealthcare.izisstechnology.in/uploads/userrahulraoy.jpeg', '', 2, 0, '2017-06-10 05:23:30', '2017-06-10 05:23:30');
INSERT INTO `SCP_UserLogin` VALUES(75, 'Frontend user for chrome', 'user1@mailinator.com', '25d55ad283aa400af464c76d713c07ad', 'http://stealthcare.izisstechnology.in/uploads/userFrontend user for chrome.jpeg', '', 2, 0, '2017-06-10 05:27:10', '2017-06-10 05:27:10');
INSERT INTO `SCP_UserLogin` VALUES(76, 'user1@mailinator.com', 'user2@mailinator.com', '25d55ad283aa400af464c76d713c07ad', '', '', 2, 0, '2017-06-10 05:39:29', '2017-06-10 05:39:29');
INSERT INTO `SCP_UserLogin` VALUES(77, 'user1@mailinator.com', 'user3@mailinator.com', '25d55ad283aa400af464c76d713c07ad', '', '', 2, 0, '2017-06-10 05:41:56', '2017-06-10 05:41:56');
INSERT INTO `SCP_UserLogin` VALUES(78, 'Frontend user for chrome 1', 'user11@mailinator.com', '25d55ad283aa400af464c76d713c07ad', 'http://stealthcare.izisstechnology.in/uploads/userFrontend user for chrome 1.jpeg', '', 2, 0, '2017-06-11 22:11:10', '2017-06-11 22:11:10');
INSERT INTO `SCP_UserLogin` VALUES(79, 'gvdsfds', 'frontenduser@mailinator.com', '2bdd3604cd9755bec86999d30666994e', 'http://stealthcare.izisstechnology.in/uploads/usergvdsfds.jpeg', '', 2, 0, '2017-06-11 22:34:29', '2017-06-11 22:34:29');
INSERT INTO `SCP_UserLogin` VALUES(80, 'MukulKothari', 'mukul.kothari88@gmail.com', '25f9e794323b453885f5181f1b624d0b', 'http://stealthcare.izisstechnology.in/uploads/userMukulKothari.png', '', 1, 0, '2017-06-11 23:05:02', '2017-06-11 23:05:02');
INSERT INTO `SCP_UserLogin` VALUES(81, '123 Frontend user for chrome', 'user12@mailinator.com', '25d55ad283aa400af464c76d713c07ad', 'http://stealthcare.izisstechnology.in/uploads/user123 Frontend user for chrome.jpeg', '', 1, 0, '2017-06-12 00:16:26', '2017-06-12 00:16:26');
INSERT INTO `SCP_UserLogin` VALUES(82, 'permjeet', 'p.is@gmail.com', '964b0f6e08891c2c15706ef182f49ec7', 'http://stealthcare.izisstechnology.in/uploads/userpermjeet.jpeg', '', 1, 0, '2017-06-15 14:08:23', '2017-06-15 14:08:23');
INSERT INTO `SCP_UserLogin` VALUES(83, 'test', 'p.si@gmail.com', '05a671c66aefea124cc08b76ea6d30bb', '', '', 1, 0, '2017-06-15 14:19:54', '2017-06-15 14:19:54');
INSERT INTO `SCP_UserLogin` VALUES(84, NULL, NULL, NULL, '', '', 1, 0, '2017-06-18 16:12:20', '2017-06-18 16:12:20');
INSERT INTO `SCP_UserLogin` VALUES(85, 'tester', 'abc@gmail.com', '25d55ad283aa400af464c76d713c07ad', '', '', 1, 0, '2017-06-19 03:40:30', '2017-06-19 03:40:30');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_UserType`
--

CREATE TABLE `SCP_UserType` (
  `UserTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `UserTypeName` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`UserTypeID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `SCP_UserType`
--

INSERT INTO `SCP_UserType` VALUES(1, 'SUPERADMIN', '2017-03-01 18:14:00', '2017-03-01 18:14:00', 1);
INSERT INTO `SCP_UserType` VALUES(2, 'ADMIN', '2017-03-01 18:14:00', '2017-03-01 18:14:00', 1);
INSERT INTO `SCP_UserType` VALUES(3, 'FRONTENDUSER', '2017-03-01 18:14:00', '2017-03-01 18:14:00', 1);
INSERT INTO `SCP_UserType` VALUES(4, 'SUPERVISOR', '2017-03-01 18:14:00', '2017-03-01 18:14:00', 1);
INSERT INTO `SCP_UserType` VALUES(5, 'CAREWORKER', '2017-03-01 18:14:00', '2017-03-01 18:14:00', 1);
INSERT INTO `SCP_UserType` VALUES(6, 'PORTALUSER', '2017-03-01 18:14:00', '2017-03-20 07:13:18', 1);

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Visits`
--

CREATE TABLE `SCP_Visits` (
  `VisitID` int(11) NOT NULL AUTO_INCREMENT,
  `StaffID` int(11) DEFAULT NULL,
  `VisitTitle` varchar(150) DEFAULT NULL,
  `TimeOfDay` varchar(150) DEFAULT NULL,
  `VisitTypeID` int(11) DEFAULT NULL,
  `VisitStartDate` date DEFAULT NULL,
  `VisitEndDate` date DEFAULT NULL,
  `IsFixed` tinyint(4) DEFAULT NULL,
  `VisitDays` varchar(150) DEFAULT NULL,
  `VisitStartTime` time DEFAULT NULL,
  `VisitEndTime` time DEFAULT NULL,
  `CareWorkerID` int(11) NOT NULL,
  `TaskIDs` varchar(256) NOT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `OtherDetails` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`VisitID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `SCP_Visits`
--

INSERT INTO `SCP_Visits` VALUES(1, 21, 'Wash', 'Morning', 1, '2017-05-16', '2017-05-18', 1, 'Sunday,Tuesday,Friday,Saturday', '12:30:00', '14:30:00', 0, '', 1, 8, NULL, '2017-04-20 01:00:00', '2017-04-20 00:00:09');
INSERT INTO `SCP_Visits` VALUES(2, 21, 'Wash', 'Morning', 1, '2017-05-16', '2017-05-18', 1, 'Sunday,Monday,Tuesday,Thursday,Friday', '09:00:00', '09:30:00', 0, '', 1, 9, NULL, '2017-03-01 18:14:00', '2017-03-01 18:14:00');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_VisitType`
--

CREATE TABLE `SCP_VisitType` (
  `VisitTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `VisitTypeName` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`VisitTypeID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `SCP_VisitType`
--

INSERT INTO `SCP_VisitType` VALUES(1, 'Care visit', '2017-03-01 18:14:00', '2017-03-01 18:14:00', 1);
INSERT INTO `SCP_VisitType` VALUES(2, 'Sleep in', '2017-03-01 18:14:00', '2017-03-20 07:13:18', 1);
INSERT INTO `SCP_VisitType` VALUES(3, 'Live in', '2017-03-01 18:14:00', '2017-03-01 18:14:00', 1);
INSERT INTO `SCP_VisitType` VALUES(4, 'Waking night', '2017-03-01 18:14:00', '2017-03-20 07:13:18', 1);
