-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 05, 2017 at 08:51 PM
-- Server version: 5.6.14
-- PHP Version: 5.5.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `SCP`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `createEnquiry`(IN `iOrgID` varchar(150),IN `iCustomerTitle` varchar(150),IN `iCustomerName` varchar(150),IN `iCustomerSurname` varchar(150),IN `iCustomerMiddleName` varchar(150),IN `iDateOfBirth` varchar(40),IN `iNHSNumber` varchar(150),IN `iGender` varchar(40),IN `iEthnicity` varchar(150),IN `iAddress1` varchar(150),IN `iAddress2` varchar(150),IN `iPostCode` varchar(9),IN `iCity` varchar(150),IN `iLandline` varchar(150),IN `iContactNo` varchar(150),IN `iOtherDetails` varchar(150),IN `iCareInfo` varchar(150),IN `iOutcomesInfo` varchar(150),IN `iSupportInfo` varchar(150),IN `iMakeEnq` varchar(150),IN `iRightsID` int(11), IN `iAccessLevelID` int(11),IN `iUserTypeID` int(11),`iCreatedDateTime` datetime(3),`iModifyDateTime` datetime(3),`iStatusID` int(11))
BEGIN
DECLARE UID int;
insert into SCP_UserLogin (StatusID,CreatedDateTime,ModifyDateTime) values (iStatusID,iCreatedDateTime,iModifyDateTime);
SET UID = LAST_INSERT_ID();
insert into SCP_UserAccess (RightsID,AccessLevelID,UserID,UserTypeID,CreatedDateTime,ModifyDateTime,StatusID) values (iRightsID,iAccessLevelID,UID,iUserTypeID,iCreatedDateTime,iModifyDateTime,iStatusID);

insert into SCP_Customer (CustomerTitle,CustomerName,CustomerSurname,CustomerMiddleName,DateOfBirth,NHSNumber,Gender,Ethnicity,Address1,Address2,PostCode,City,Landline,ContactNo,OtherDetails,CareInfo,OutcomesInfo,SupportInfo,MakeEnq,UserID,StatusID,CreatedDateTime,ModifyDateTime) values (iCustomerTitle,iCustomerName,iCustomerSurname,iCustomerMiddleName,iDateOfBirth,iNHSNumber,iGender,iEthnicity,iAddress1,iAddress2,iPostCode,iCity,iLandline,iContactNo,iOtherDetails,iCareInfo,iOutcomesInfo,iSupportInfo,iMakeEnq,UID,iStatusID,iCreatedDateTime,iModifyDateTime);
SET UID = LAST_INSERT_ID();
insert into SCP_Enquiry (OrgID,CustomerID,StatusID,CreatedDateTime,ModifyDateTime) values (iOrgID,UID,iStatusID,iCreatedDateTime,iModifyDateTime);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loadAllCountry`()
BEGIN
SELECT *
FROM `SCP_Country`;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loadAllOrgniserForms`(IN `iOrgID` INT(11))
BEGIN
SELECT *
FROM `SCP_FormBuilder`
WHERE SCP_FormBuilder.StatusID=1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loginWithUsername`(IN `iUsername` VARCHAR(150), IN `iPassword` VARCHAR(150))
BEGIN
SELECT U.*
FROM `SCP_UserLogin` AS U, SCP_Status AS S
WHERE U.UserName=iUsername AND U.Password= iPassword AND S.StatusID=U.StatusID ;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `SCP_AccessLevel`
--

CREATE TABLE IF NOT EXISTS `SCP_AccessLevel` (
  `AccessLevelID` int(11) NOT NULL AUTO_INCREMENT,
  `AccessLevelName` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`AccessLevelID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `SCP_AccessLevel`
--

INSERT INTO `SCP_AccessLevel` (`AccessLevelID`, `AccessLevelName`, `CreatedDateTime`, `ModifyDateTime`, `StatusID`) VALUES
(1, 'ALL', '2017-03-01 18:14:00.000', '2017-03-01 18:14:00.000', 1),
(2, 'WEB,TABLET,MOBILE', '2017-03-01 18:14:00.000', '2017-03-01 18:14:00.000', 1),
(3, 'TABLET', '2017-03-01 18:14:00.000', '2017-03-01 18:14:00.000', 1),
(4, 'MOBILE', '2017-03-01 18:14:00.000', '2017-03-01 18:14:00.000', 1),
(5, 'NOACCESS', '2017-03-01 00:00:00.000', '2017-03-01 00:00:00.000', 1);

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Alert`
--

CREATE TABLE IF NOT EXISTS `SCP_Alert` (
  `AlertID` int(11) NOT NULL AUTO_INCREMENT,
  `Priority` varchar(150) DEFAULT NULL,
  `Severity` varchar(150) DEFAULT NULL,
  `TaskID` int(11) DEFAULT NULL,
  `StaffID` int(11) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`AlertID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `SCP_AssessmentAllocation`
--

CREATE TABLE IF NOT EXISTS `SCP_AssessmentAllocation` (
  `AssessmentAllocationID` int(11) NOT NULL AUTO_INCREMENT,
  `EnquiryID` int(11) DEFAULT NULL,
  `StaffID` int(11) DEFAULT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`AssessmentAllocationID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `SCP_CareOrg`
--

CREATE TABLE IF NOT EXISTS `SCP_CareOrg` (
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
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`OrgID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `SCP_CareOrg`
--

INSERT INTO `SCP_CareOrg` (`OrgID`, `Name`, `CQCRegNo`, `CQCLocNo`, `AdminName`, `PlanID`, `Address`, `Address2`, `City`, `PostCode`, `ContactNo`, `ContactNo2`, `FaxNo`, `WebSite`, `UserID`, `OtherDetails`, `CreatedDateTime`, `ModifyDateTime`, `StatusID`) VALUES
(3, 'rest', '', '', '', 4, 'Hi', '', '', '', '7415850336', '7415850336', '7415850336', 'http://localhost/SCPProject/create_care_orga', 12, 'rest', '2017-03-27 17:32:53.000', '2017-04-03 16:55:25.000', 2),
(4, 'rest', '', '', '', 2, 'Hi', '', '', '', '7415850336', '7415850336', '7415850336', 'http://localhost/SCPProject/#/create_care_orga', 2, 'rest', '2017-03-27 17:32:53.000', '2017-04-03 12:43:20.000', 1),
(5, 'Anil Banwar', '', '', '', 3, 'Test data', '', '', '', '7415850336', '7415850336', '7415850336', 'http://localhost/SCPProject/organizer/abanwar', 13, 'Test Data Better', '2017-03-30 12:43:14.000', '2017-04-04 20:40:32.000', 2),
(7, 'Test User', '', '', '', 2, 'TestUser', '', '', 'AA9A 9AB', '7415850336', '7415850336', '7415850336', 'http://localhost/SCPProject/', 15, 'TestUser', '2017-04-03 13:52:49.000', '2017-04-05 16:11:34.000', 1),
(8, 'iziss', '', '', '', 1, 'izissA', '', '', 'AA9A 9AA', '7415850336', '7415850336', '7415850336', 'http://localhost/SCPProject/organizer/abanwar', 16, 'izissA', '2017-04-05 17:46:32.000', '2017-04-05 17:46:32.000', 2),
(9, 'Test Organiser', 'REG12345', 'LOC123', 'Test Org', 2, '302 Anmol Spaces Indore2', 'India', 'Indore', 'S5A5 AT7', '7415850336', '7415850336', '7415850336', 'http://localhost/SCPProject/', 17, 'Test Me Best', '2017-04-19 18:43:28.000', '2017-04-19 19:01:32.000', 0);

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Country`
--

CREATE TABLE IF NOT EXISTS `SCP_Country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sortname` varchar(3) NOT NULL,
  `country` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=247 ;

--
-- Dumping data for table `SCP_Country`
--

INSERT INTO `SCP_Country` (`id`, `sortname`, `country`) VALUES
(1, 'AF', 'Afghanistan'),
(2, 'AL', 'Albania'),
(3, 'DZ', 'Algeria'),
(4, 'AS', 'American Samoa'),
(5, 'AD', 'Andorra'),
(6, 'AO', 'Angola'),
(7, 'AI', 'Anguilla'),
(8, 'AQ', 'Antarctica'),
(9, 'AG', 'Antigua And Barbuda'),
(10, 'AR', 'Argentina'),
(11, 'AM', 'Armenia'),
(12, 'AW', 'Aruba'),
(13, 'AU', 'Australia'),
(14, 'AT', 'Austria'),
(15, 'AZ', 'Azerbaijan'),
(16, 'BS', 'Bahamas The'),
(17, 'BH', 'Bahrain'),
(18, 'BD', 'Bangladesh'),
(19, 'BB', 'Barbados'),
(20, 'BY', 'Belarus'),
(21, 'BE', 'Belgium'),
(22, 'BZ', 'Belize'),
(23, 'BJ', 'Benin'),
(24, 'BM', 'Bermuda'),
(25, 'BT', 'Bhutan'),
(26, 'BO', 'Bolivia'),
(27, 'BA', 'Bosnia and Herzegovina'),
(28, 'BW', 'Botswana'),
(29, 'BV', 'Bouvet Island'),
(30, 'BR', 'Brazil'),
(31, 'IO', 'British Indian Ocean Territory'),
(32, 'BN', 'Brunei'),
(33, 'BG', 'Bulgaria'),
(34, 'BF', 'Burkina Faso'),
(35, 'BI', 'Burundi'),
(36, 'KH', 'Cambodia'),
(37, 'CM', 'Cameroon'),
(38, 'CA', 'Canada'),
(39, 'CV', 'Cape Verde'),
(40, 'KY', 'Cayman Islands'),
(41, 'CF', 'Central African Republic'),
(42, 'TD', 'Chad'),
(43, 'CL', 'Chile'),
(44, 'CN', 'China'),
(45, 'CX', 'Christmas Island'),
(46, 'CC', 'Cocos (Keeling) Islands'),
(47, 'CO', 'Colombia'),
(48, 'KM', 'Comoros'),
(49, 'CG', 'Congo'),
(50, 'CD', 'Congo The Democratic Republic Of The'),
(51, 'CK', 'Cook Islands'),
(52, 'CR', 'Costa Rica'),
(53, 'CI', 'Cote D''Ivoire (Ivory Coast)'),
(54, 'HR', 'Croatia (Hrvatska)'),
(55, 'CU', 'Cuba'),
(56, 'CY', 'Cyprus'),
(57, 'CZ', 'Czech Republic'),
(58, 'DK', 'Denmark'),
(59, 'DJ', 'Djibouti'),
(60, 'DM', 'Dominica'),
(61, 'DO', 'Dominican Republic'),
(62, 'TP', 'East Timor'),
(63, 'EC', 'Ecuador'),
(64, 'EG', 'Egypt'),
(65, 'SV', 'El Salvador'),
(66, 'GQ', 'Equatorial Guinea'),
(67, 'ER', 'Eritrea'),
(68, 'EE', 'Estonia'),
(69, 'ET', 'Ethiopia'),
(70, 'XA', 'External Territories of Australia'),
(71, 'FK', 'Falkland Islands'),
(72, 'FO', 'Faroe Islands'),
(73, 'FJ', 'Fiji Islands'),
(74, 'FI', 'Finland'),
(75, 'FR', 'France'),
(76, 'GF', 'French Guiana'),
(77, 'PF', 'French Polynesia'),
(78, 'TF', 'French Southern Territories'),
(79, 'GA', 'Gabon'),
(80, 'GM', 'Gambia The'),
(81, 'GE', 'Georgia'),
(82, 'DE', 'Germany'),
(83, 'GH', 'Ghana'),
(84, 'GI', 'Gibraltar'),
(85, 'GR', 'Greece'),
(86, 'GL', 'Greenland'),
(87, 'GD', 'Grenada'),
(88, 'GP', 'Guadeloupe'),
(89, 'GU', 'Guam'),
(90, 'GT', 'Guatemala'),
(91, 'XU', 'Guernsey and Alderney'),
(92, 'GN', 'Guinea'),
(93, 'GW', 'Guinea-Bissau'),
(94, 'GY', 'Guyana'),
(95, 'HT', 'Haiti'),
(96, 'HM', 'Heard and McDonald Islands'),
(97, 'HN', 'Honduras'),
(98, 'HK', 'Hong Kong S.A.R.'),
(99, 'HU', 'Hungary'),
(100, 'IS', 'Iceland'),
(101, 'IN', 'India'),
(102, 'ID', 'Indonesia'),
(103, 'IR', 'Iran'),
(104, 'IQ', 'Iraq'),
(105, 'IE', 'Ireland'),
(106, 'IL', 'Israel'),
(107, 'IT', 'Italy'),
(108, 'JM', 'Jamaica'),
(109, 'JP', 'Japan'),
(110, 'XJ', 'Jersey'),
(111, 'JO', 'Jordan'),
(112, 'KZ', 'Kazakhstan'),
(113, 'KE', 'Kenya'),
(114, 'KI', 'Kiribati'),
(115, 'KP', 'Korea North'),
(116, 'KR', 'Korea South'),
(117, 'KW', 'Kuwait'),
(118, 'KG', 'Kyrgyzstan'),
(119, 'LA', 'Laos'),
(120, 'LV', 'Latvia'),
(121, 'LB', 'Lebanon'),
(122, 'LS', 'Lesotho'),
(123, 'LR', 'Liberia'),
(124, 'LY', 'Libya'),
(125, 'LI', 'Liechtenstein'),
(126, 'LT', 'Lithuania'),
(127, 'LU', 'Luxembourg'),
(128, 'MO', 'Macau S.A.R.'),
(129, 'MK', 'Macedonia'),
(130, 'MG', 'Madagascar'),
(131, 'MW', 'Malawi'),
(132, 'MY', 'Malaysia'),
(133, 'MV', 'Maldives'),
(134, 'ML', 'Mali'),
(135, 'MT', 'Malta'),
(136, 'XM', 'Man (Isle of)'),
(137, 'MH', 'Marshall Islands'),
(138, 'MQ', 'Martinique'),
(139, 'MR', 'Mauritania'),
(140, 'MU', 'Mauritius'),
(141, 'YT', 'Mayotte'),
(142, 'MX', 'Mexico'),
(143, 'FM', 'Micronesia'),
(144, 'MD', 'Moldova'),
(145, 'MC', 'Monaco'),
(146, 'MN', 'Mongolia'),
(147, 'MS', 'Montserrat'),
(148, 'MA', 'Morocco'),
(149, 'MZ', 'Mozambique'),
(150, 'MM', 'Myanmar'),
(151, 'NA', 'Namibia'),
(152, 'NR', 'Nauru'),
(153, 'NP', 'Nepal'),
(154, 'AN', 'Netherlands Antilles'),
(155, 'NL', 'Netherlands The'),
(156, 'NC', 'New Caledonia'),
(157, 'NZ', 'New Zealand'),
(158, 'NI', 'Nicaragua'),
(159, 'NE', 'Niger'),
(160, 'NG', 'Nigeria'),
(161, 'NU', 'Niue'),
(162, 'NF', 'Norfolk Island'),
(163, 'MP', 'Northern Mariana Islands'),
(164, 'NO', 'Norway'),
(165, 'OM', 'Oman'),
(166, 'PK', 'Pakistan'),
(167, 'PW', 'Palau'),
(168, 'PS', 'Palestinian Territory Occupied'),
(169, 'PA', 'Panama'),
(170, 'PG', 'Papua new Guinea'),
(171, 'PY', 'Paraguay'),
(172, 'PE', 'Peru'),
(173, 'PH', 'Philippines'),
(174, 'PN', 'Pitcairn Island'),
(175, 'PL', 'Poland'),
(176, 'PT', 'Portugal'),
(177, 'PR', 'Puerto Rico'),
(178, 'QA', 'Qatar'),
(179, 'RE', 'Reunion'),
(180, 'RO', 'Romania'),
(181, 'RU', 'Russia'),
(182, 'RW', 'Rwanda'),
(183, 'SH', 'Saint Helena'),
(184, 'KN', 'Saint Kitts And Nevis'),
(185, 'LC', 'Saint Lucia'),
(186, 'PM', 'Saint Pierre and Miquelon'),
(187, 'VC', 'Saint Vincent And The Grenadines'),
(188, 'WS', 'Samoa'),
(189, 'SM', 'San Marino'),
(190, 'ST', 'Sao Tome and Principe'),
(191, 'SA', 'Saudi Arabia'),
(192, 'SN', 'Senegal'),
(193, 'RS', 'Serbia'),
(194, 'SC', 'Seychelles'),
(195, 'SL', 'Sierra Leone'),
(196, 'SG', 'Singapore'),
(197, 'SK', 'Slovakia'),
(198, 'SI', 'Slovenia'),
(199, 'XG', 'Smaller Territories of the UK'),
(200, 'SB', 'Solomon Islands'),
(201, 'SO', 'Somalia'),
(202, 'ZA', 'South Africa'),
(203, 'GS', 'South Georgia'),
(204, 'SS', 'South Sudan'),
(205, 'ES', 'Spain'),
(206, 'LK', 'Sri Lanka'),
(207, 'SD', 'Sudan'),
(208, 'SR', 'Suriname'),
(209, 'SJ', 'Svalbard And Jan Mayen Islands'),
(210, 'SZ', 'Swaziland'),
(211, 'SE', 'Sweden'),
(212, 'CH', 'Switzerland'),
(213, 'SY', 'Syria'),
(214, 'TW', 'Taiwan'),
(215, 'TJ', 'Tajikistan'),
(216, 'TZ', 'Tanzania'),
(217, 'TH', 'Thailand'),
(218, 'TG', 'Togo'),
(219, 'TK', 'Tokelau'),
(220, 'TO', 'Tonga'),
(221, 'TT', 'Trinidad And Tobago'),
(222, 'TN', 'Tunisia'),
(223, 'TR', 'Turkey'),
(224, 'TM', 'Turkmenistan'),
(225, 'TC', 'Turks And Caicos Islands'),
(226, 'TV', 'Tuvalu'),
(227, 'UG', 'Uganda'),
(228, 'UA', 'Ukraine'),
(229, 'AE', 'United Arab Emirates'),
(230, 'GB', 'United Kingdom'),
(231, 'US', 'United States'),
(232, 'UM', 'United States Minor Outlying Islands'),
(233, 'UY', 'Uruguay'),
(234, 'UZ', 'Uzbekistan'),
(235, 'VU', 'Vanuatu'),
(236, 'VA', 'Vatican City State (Holy See)'),
(237, 'VE', 'Venezuela'),
(238, 'VN', 'Vietnam'),
(239, 'VG', 'Virgin Islands (British)'),
(240, 'VI', 'Virgin Islands (US)'),
(241, 'WF', 'Wallis And Futuna Islands'),
(242, 'EH', 'Western Sahara'),
(243, 'YE', 'Yemen'),
(244, 'YU', 'Yugoslavia'),
(245, 'ZM', 'Zambia'),
(246, 'ZW', 'Zimbabwe');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Customer`
--

CREATE TABLE IF NOT EXISTS `SCP_Customer` (
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
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `SCP_Customer`
--

INSERT INTO `SCP_Customer` (`CustomerID`, `CustomerTitle`, `CustomerName`, `CustomerSurname`, `CustomerMiddleName`, `DateOfBirth`, `NHSNumber`, `Gender`, `Ethnicity`, `Address1`, `Address2`, `PostCode`, `City`, `Landline`, `UserID`, `ContactNo`, `StatusID`, `OtherDetails`, `CareInfo`, `OutcomesInfo`, `SupportInfo`, `MakeEnq`, `CreatedDateTime`, `ModifyDateTime`) VALUES
(1, 'Mr', '', '', '', '', '', 'Male', '', '', '', ' ', '', '', 18, '', 1, '', '', '', 'Personal Care', 'self', '2017-04-24 12:34:17.000', '2017-04-24 12:34:17.000'),
(2, 'Mr', '', '', '', '', '', 'Male', '', '', '', ' ', '', '', 19, '', 1, '', '', '', 'Personal Care', 'self', '2017-04-24 12:34:19.000', '2017-04-24 12:34:19.000'),
(3, 'Mr', '', '', '', '', '', 'Male', '', '', '', ' ', '', '', 20, '', 1, '', '', '', 'Personal Care', 'self', '2017-04-24 12:34:24.000', '2017-04-24 12:34:24.000'),
(4, 'Mr', '', '', '', '', '', 'Male', '', '', '', ' ', '', '', 21, '', 1, '', '', '', 'Personal Care', 'self', '2017-04-24 12:34:27.000', '2017-04-24 12:34:27.000'),
(5, 'Mr', '', '', '', '', '', 'Male', '', '', '', ' ', '', '', 22, '', 1, '', '', '', 'Personal Care', 'self', '2017-04-24 12:34:30.000', '2017-04-24 12:34:30.000'),
(6, 'Mr', '', '', '', '', '', 'Male', '', '', '', ' ', '', '', 23, '', 1, '', '', '', 'Personal Care', 'self', '2017-04-24 12:34:34.000', '2017-04-24 12:34:34.000'),
(7, 'Mr', '', '', '', '', '', 'Male', '', '', '', ' ', '', '', 24, '', 1, '', '', '', 'Personal Care', 'self', '2017-04-24 12:34:42.000', '2017-04-24 12:34:42.000');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Documents`
--

CREATE TABLE IF NOT EXISTS `SCP_Documents` (
  `DocumentID` int(11) NOT NULL AUTO_INCREMENT,
  `CustomerID` int(11) DEFAULT NULL,
  `DocumentTypeID` int(11) DEFAULT NULL,
  `DocumentUrl` varchar(150) DEFAULT NULL,
  `StaffID` int(11) DEFAULT NULL,
  `Version` varchar(150) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`DocumentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `SCP_DocumentType`
--

CREATE TABLE IF NOT EXISTS `SCP_DocumentType` (
  `DocumentTypeID` int(11) NOT NULL,
  `Typename` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`DocumentTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Enquiry`
--

CREATE TABLE IF NOT EXISTS `SCP_Enquiry` (
  `EnquiryID` int(11) NOT NULL AUTO_INCREMENT,
  `OrgID` int(11) NOT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`EnquiryID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `SCP_Enquiry`
--

INSERT INTO `SCP_Enquiry` (`EnquiryID`, `OrgID`, `CustomerID`, `StatusID`, `CreatedDateTime`, `ModifyDateTime`) VALUES
(1, 9, 1, 1, '2017-04-24 12:34:17.000', '2017-04-24 12:34:17.000'),
(2, 9, 2, 1, '2017-04-24 12:34:19.000', '2017-04-24 12:34:19.000'),
(3, 9, 3, 1, '2017-04-24 12:34:24.000', '2017-04-24 12:34:24.000'),
(4, 9, 4, 1, '2017-04-24 12:34:27.000', '2017-04-24 12:34:27.000'),
(5, 9, 5, 1, '2017-04-24 12:34:30.000', '2017-04-24 12:34:30.000'),
(6, 9, 6, 1, '2017-04-24 12:34:34.000', '2017-04-24 12:34:34.000'),
(7, 9, 7, 1, '2017-04-24 12:34:42.000', '2017-04-24 12:34:42.000');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_FormBuilder`
--

CREATE TABLE IF NOT EXISTS `SCP_FormBuilder` (
  `FormID` int(11) NOT NULL AUTO_INCREMENT,
  `FormDataID` varchar(156) NOT NULL,
  `FormName` varchar(156) NOT NULL,
  `FormDataJson` longtext NOT NULL,
  `UserID` int(11) NOT NULL,
  `StatusID` int(11) NOT NULL,
  `CreatedDateTime` datetime NOT NULL,
  `ModifyDateTime` datetime NOT NULL,
  PRIMARY KEY (`FormID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `SCP_FormBuilder`
--

INSERT INTO `SCP_FormBuilder` (`FormID`, `FormDataID`, `FormName`, `FormDataJson`, `UserID`, `StatusID`, `CreatedDateTime`, `ModifyDateTime`) VALUES
(1, 'FORM01', 'Form1', '[{"component":"header","editable":true,"index":0,"label":"Heading","value":"","description":"","placeholder":"Placeholder","options":[],"required":false,"validation":"/.*/"},{"component":"textInput","editable":true,"index":1,"label":"Single line input","value":"","description":"","placeholder":"Placeholder","options":[],"required":false,"validation":"/.*/"},{"component":"textArea","editable":true,"index":2,"label":"Multi line input","value":"","description":"","placeholder":"Placeholder","options":[],"required":false,"validation":"/.*/"},{"component":"select","editable":true,"index":3,"label":"Dropdown","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false,"validation":"/.*/"},{"component":"radio","editable":true,"index":4,"label":"Radio","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false,"validation":"/.*/"},{"component":"checkbox","editable":true,"index":5,"label":"Checkbox","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false,"validation":"/.*/"},{"component":"date","editable":true,"index":6,"label":"Date","value":"","description":"","placeholder":"Placeholder","options":[],"required":false,"validation":"/.*/"},{"component":"file","editable":true,"index":7,"label":"Image","value":"","description":"","placeholder":"Placeholder","options":[],"required":false,"validation":"/.*/"},{"component":"postCode","editable":true,"index":8,"label":"Postal Code","value":"","description":"","placeholder":"","options":[],"required":false,"validation":"/.*/"}]', 1, 1, '2017-04-20 01:00:00', '2017-04-20 00:00:09'),
(2, 'FORM02', 'Form2', '[{"component":"header","editable":true,"index":0,"label":"Heading","value":"","description":"","placeholder":"Placeholder","options":[],"required":false,"validation":"/.*/"},{"component":"textInput","editable":true,"index":1,"label":"Single line input","value":"","description":"","placeholder":"Placeholder","options":[],"required":false,"validation":"/.*/"},{"component":"textArea","editable":true,"index":2,"label":"Multi line input","value":"","description":"","placeholder":"Placeholder","options":[],"required":false,"validation":"/.*/"},{"component":"select","editable":true,"index":3,"label":"Dropdown","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false,"validation":"/.*/"},{"component":"radio","editable":true,"index":4,"label":"Radio","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false,"validation":"/.*/"},{"component":"checkbox","editable":true,"index":5,"label":"Checkbox","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false,"validation":"/.*/"},{"component":"date","editable":true,"index":6,"label":"Date","value":"","description":"","placeholder":"Placeholder","options":[],"required":false,"validation":"/.*/"},{"component":"file","editable":true,"index":7,"label":"Image","value":"","description":"","placeholder":"Placeholder","options":[],"required":false,"validation":"/.*/"},{"component":"postCode","editable":true,"index":8,"label":"Postal Code","value":"","description":"","placeholder":"","options":[],"required":false,"validation":"/.*/"}]', 1, 1, '2017-03-20 07:13:18', '2017-03-01 18:14:00'),
(3, 'FORM03', 'Form3', '[{"component":"header","editable":true,"index":0,"label":"Heading","value":"","description":"","placeholder":"Placeholder","options":[],"required":false,"validation":"/.*/"},{"component":"textInput","editable":true,"index":1,"label":"Single line input","value":"","description":"","placeholder":"Placeholder","options":[],"required":false,"validation":"/.*/"},{"component":"textArea","editable":true,"index":2,"label":"Multi line input","value":"","description":"","placeholder":"Placeholder","options":[],"required":false,"validation":"/.*/"},{"component":"select","editable":true,"index":3,"label":"Dropdown","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false,"validation":"/.*/"},{"component":"radio","editable":true,"index":4,"label":"Radio","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false,"validation":"/.*/"},{"component":"checkbox","editable":true,"index":5,"label":"Checkbox","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false,"validation":"/.*/"},{"component":"date","editable":true,"index":6,"label":"Date","value":"","description":"","placeholder":"Placeholder","options":[],"required":false,"validation":"/.*/"},{"component":"file","editable":true,"index":7,"label":"Image","value":"","description":"","placeholder":"Placeholder","options":[],"required":false,"validation":"/.*/"},{"component":"postCode","editable":true,"index":8,"label":"Postal Code","value":"","description":"","placeholder":"","options":[],"required":false,"validation":"/.*/"}]', 1, 1, '2017-04-20 01:00:00', '2017-04-20 00:00:09'),
(4, 'FORM04', 'Form4', '[{"component":"header","editable":true,"index":0,"label":"Heading","value":"","description":"","placeholder":"Placeholder","options":[],"required":false,"validation":"/.*/"},{"component":"textInput","editable":true,"index":1,"label":"Single line input","value":"","description":"","placeholder":"Placeholder","options":[],"required":false,"validation":"/.*/"},{"component":"textArea","editable":true,"index":2,"label":"Multi line input","value":"","description":"","placeholder":"Placeholder","options":[],"required":false,"validation":"/.*/"},{"component":"select","editable":true,"index":3,"label":"Dropdown","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false,"validation":"/.*/"},{"component":"radio","editable":true,"index":4,"label":"Radio","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false,"validation":"/.*/"},{"component":"checkbox","editable":true,"index":5,"label":"Checkbox","value":"","description":"","placeholder":"Placeholder","options":["value one","value two"],"required":false,"validation":"/.*/"},{"component":"date","editable":true,"index":6,"label":"Date","value":"","description":"","placeholder":"Placeholder","options":[],"required":false,"validation":"/.*/"},{"component":"file","editable":true,"index":7,"label":"Image","value":"","description":"","placeholder":"Placeholder","options":[],"required":false,"validation":"/.*/"},{"component":"postCode","editable":true,"index":8,"label":"Postal Code","value":"","description":"","placeholder":"","options":[],"required":false,"validation":"/.*/"}]', 1, 1, '2017-03-20 07:13:18', '2017-03-01 18:14:00');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Licenses`
--

CREATE TABLE IF NOT EXISTS `SCP_Licenses` (
  `LicenseID` int(11) NOT NULL AUTO_INCREMENT,
  `LicenseKey` varchar(150) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `OrgID` int(11) DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`LicenseID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=51 ;

--
-- Dumping data for table `SCP_Licenses`
--

INSERT INTO `SCP_Licenses` (`LicenseID`, `LicenseKey`, `StatusID`, `OrgID`, `UserID`, `CreatedDateTime`, `ModifyDateTime`) VALUES
(1, 'A0B91B95F60B96C5AD1679EF21EE865F', 1, 4, 13, '2017-04-03 10:50:50', '2017-04-03 14:09:00'),
(2, 'C5F244AAC866E5C9621CCE1F805BFA85', 1, 5, 14, '2017-04-03 10:50:50', '2017-04-04 13:12:54'),
(3, '75965C9E626C07D38A729B57562C98FA', 1, 6, 15, '2017-04-03 10:50:50', '2017-04-04 13:15:12'),
(4, 'A92E74051E2A902203A604E48959A2CE', 2, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(5, '058FA88D2581BFD30324728A6D6AA589', 2, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(6, '1B44B241C852ECDB1C5730C0F0D72569', 1, 8, 16, '2017-04-03 10:50:50', '2017-04-05 17:46:32'),
(7, 'F6A97F0A8F6CC552993A05888886B997', 1, 9, 17, '2017-04-03 10:50:50', '2017-04-19 18:43:28'),
(8, '33FA172C28175FEFFCF302C3954779B1', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(9, '1FA414DD5DAEBD4CF325A965A1B4924E', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(10, 'E6B703C25D137F6492EF6E56FA5918AF', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(11, '3A083B958D1F3E18917DD394C136F185', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(12, '266EF60AAD3898B2FE553C0E0A3D90ED', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(13, '0D075D965BFD4ABC689A57F025054C77', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(14, '399FF1E7F6BC0A8890ECFB3F8B3376CF', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(15, '8D55D3A62E3DBB143596D67543E15E43', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(16, '79EBDD9478C6E9C67355337BE27DC33F', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(17, 'E5B562F3FACB8F2883E4597110B5350B', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(18, 'B5ED9604CCF736E7C2CD6E911C504129', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(19, 'AAA589ACE3330FB20A75E4987AA71C8D', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(20, 'FA8F66F40636020D024029242C90957F', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(21, '03F867363BF09801DC59347220D09BDB', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(22, 'C031079CEE4D6D319A3442B9529E94EC', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(23, '222BBA7B56FEFB8F6CF9C2A095D4BED2', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(24, '1EBCD7E61678574EFA899934AF04242A', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(25, 'AFF455863BCD7675AF815EB5AB86179C', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(26, '367CE7FE95F4F08E20436F01A22E865F', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(27, '69650D3B2B5309A8DD0882089713662F', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(28, '8C3742FB9B9F94736E6DD01FFAB70978', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(29, '38783F7B4D226C71DF002EFB21A35219', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(30, 'D7009DEA889528F06CD2052A87FC3200', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(31, '69AC9D31B9EA95A917BCB2F136E9C575', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(32, '0FAEFEB5E9B702C4DB1AFF968B4788AD', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(33, '7EE12BC78B8799F8FB1C14BBF1D51C34', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(34, '01D92E75809C780BF61C50E35235AB5E', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(35, '8BECC72E7237DC7767EF60F6B91378B0', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(36, 'FE8C75A2AAC8EAEB63E0A5970E9E7003', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(37, 'AE4DAC10F9AAA500869E604E6EBFA3FA', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(38, '9BF95029F214D21E188B9B626C1BE16D', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(39, 'D5BA2747ABDB2E37756B8FA00AF4C0F0', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(40, 'A696AA5B2AFEE673451720299D35ADB7', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(41, 'FCB3E237A106953EF785507AD082E8BF', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(42, '3A963AED0B8A6399DAF41ABA1DE689D3', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(43, 'AAA3E05F3F251121DF217C7F74F76E57', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(44, '6808BB3B207C6E66434493A831BCD21E', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(45, '6A88AD414C85619BA86AF9B71FE0252E', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(46, '3637EA41CBCD27EF5B60738B3C7840A6', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(47, '0AE4082488240323F1AED54D64FFDCF1', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(48, '54671848643196095020B6B39F008BD9', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(49, '10EB56A974434381CAFD7AF5A1A89A9F', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50'),
(50, 'C8522BE870B2567BF01E19A25468152E', 1, NULL, NULL, '2017-04-03 10:50:50', '2017-04-03 10:50:50');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_LicensesPlan`
--

CREATE TABLE IF NOT EXISTS `SCP_LicensesPlan` (
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

INSERT INTO `SCP_LicensesPlan` (`PlanID`, `PlanName`, `MinQty`, `MaxQty`, `Price`, `StatusID`, `CreatedDateTime`, `ModifyDateTime`) VALUES
(1, 'BRONZE', 0, 25, 100, 1, '2017-03-20 07:13:18', '2017-03-20 07:13:18'),
(2, 'SILVER', 0, 50, 150, 1, '2017-03-20 07:13:18', '2017-03-20 07:13:18'),
(3, 'GOLD', 0, 100, 200, 1, '2017-03-20 07:13:18', '2017-03-20 07:13:18'),
(4, 'PLATINUM', 0, 1000, 300, 1, '2017-03-20 07:13:18', '2017-03-20 07:13:18'),
(5, 'GOLD', 0, 10, 200, 2, '2017-04-05 19:02:52', '2017-04-05 19:02:52');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_MedicationForm`
--

CREATE TABLE IF NOT EXISTS `SCP_MedicationForm` (
  `FormID` int(11) NOT NULL AUTO_INCREMENT,
  `FormName` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`FormID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `SCP_MedicationRoute`
--

CREATE TABLE IF NOT EXISTS `SCP_MedicationRoute` (
  `RouteID` int(11) NOT NULL,
  `RouteName` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`RouteID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `SCP_MedicationTaskDetails`
--

CREATE TABLE IF NOT EXISTS `SCP_MedicationTaskDetails` (
  `MedicationTaskID` int(11) NOT NULL AUTO_INCREMENT,
  `TaskID` int(11) DEFAULT NULL,
  `MedicationFormID` int(11) DEFAULT NULL,
  `MedicationRouteID` int(11) DEFAULT NULL,
  `Location` varchar(150) DEFAULT NULL,
  `Dosage` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`MedicationTaskID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Messaging`
--

CREATE TABLE IF NOT EXISTS `SCP_Messaging` (
  `MessagingID` int(11) NOT NULL AUTO_INCREMENT,
  `FromID` int(11) DEFAULT NULL,
  `ToID` int(11) DEFAULT NULL,
  `Text` longtext,
  `DateTime` datetime(3) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`MessagingID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `SCP_OutComes`
--

CREATE TABLE IF NOT EXISTS `SCP_OutComes` (
  `OutComeID` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(150) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`OutComeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Rights`
--

CREATE TABLE IF NOT EXISTS `SCP_Rights` (
  `RightsID` int(11) NOT NULL AUTO_INCREMENT,
  `RightsType` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`RightsID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `SCP_Rights`
--

INSERT INTO `SCP_Rights` (`RightsID`, `RightsType`, `CreatedDateTime`, `ModifyDateTime`, `StatusID`) VALUES
(1, 'ALL', '2017-03-01 18:14:00.000', '2017-03-01 18:14:00.000', 1),
(2, 'ADD,EDIT,DELETE', '2017-03-01 18:14:00.000', '2017-03-01 18:14:00.000', 1),
(3, 'EDIT,DELETE', '2017-03-01 18:14:00.000', '2017-03-01 18:14:00.000', 1),
(4, 'EDIT', '2017-03-01 18:14:00.000', '2017-03-01 18:14:00.000', 1),
(5, 'ADD', '2017-03-01 00:00:00.000', '2017-03-01 18:14:00.000', 1),
(6, 'DELETE', '2017-03-01 00:00:00.000', '2017-03-01 00:00:00.000', 1),
(7, 'ADD,EDIT', '2017-03-01 00:00:00.000', '2017-03-01 00:00:00.000', 1),
(8, 'VIEWONLY', '2017-03-01 00:00:00.000', '2017-03-01 00:00:00.000', 1);

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Settings`
--

CREATE TABLE IF NOT EXISTS `SCP_Settings` (
  `SettingID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) DEFAULT NULL,
  `SettingsTypeID` int(11) DEFAULT NULL,
  `TypeName` varchar(150) DEFAULT NULL,
  `Value` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`SettingID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `SCP_SettingsValue`
--

CREATE TABLE IF NOT EXISTS `SCP_SettingsValue` (
  `SettingsTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `SettingsValues` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`SettingsTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Staff`
--

CREATE TABLE IF NOT EXISTS `SCP_Staff` (
  `StaffID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(150) DEFAULT NULL,
  `OrgID` int(11) DEFAULT NULL,
  `UserAccessID` int(11) DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  `LicenseID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`StaffID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Status`
--

CREATE TABLE IF NOT EXISTS `SCP_Status` (
  `StatusID` int(11) NOT NULL,
  `StatusName` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime DEFAULT NULL,
  `ModifyDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`StatusID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SCP_Status`
--

INSERT INTO `SCP_Status` (`StatusID`, `StatusName`, `CreatedDateTime`, `ModifyDateTime`) VALUES
(1, 'ACTIVE', '2017-03-01 18:10:00', '2017-03-01 18:10:00'),
(2, 'DEACTIVE', '2017-03-01 18:10:00', '2017-03-01 18:10:00');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Task`
--

CREATE TABLE IF NOT EXISTS `SCP_Task` (
  `TaskID` int(11) NOT NULL AUTO_INCREMENT,
  `TaskDesc` varchar(150) DEFAULT NULL,
  `TaskTypeID` int(11) DEFAULT NULL,
  `TaskStartDate` date DEFAULT NULL,
  `TaskEndDate` date DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `CreatedByStaffID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`TaskID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Task2OtherRelations`
--

CREATE TABLE IF NOT EXISTS `SCP_Task2OtherRelations` (
  `Task2RelationID` int(11) NOT NULL AUTO_INCREMENT,
  `TaskID` int(11) DEFAULT NULL,
  `ToID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`Task2RelationID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `SCP_TaskType`
--

CREATE TABLE IF NOT EXISTS `SCP_TaskType` (
  `TaskTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `TaskTypeName` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`TaskTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Test`
--

CREATE TABLE IF NOT EXISTS `SCP_Test` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Data` longtext NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `SCP_Test`
--

INSERT INTO `SCP_Test` (`ID`, `Data`) VALUES
(1, 'Test'),
(2, ''),
(3, ''),
(4, ''),
(5, 'Test'),
(6, ''),
(7, '');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_UserAccess`
--

CREATE TABLE IF NOT EXISTS `SCP_UserAccess` (
  `UserAccessID` int(11) NOT NULL AUTO_INCREMENT,
  `RightsID` int(11) DEFAULT NULL,
  `AccessLevelID` int(11) DEFAULT NULL,
  `UserID` int(11) DEFAULT NULL,
  `UserTypeID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`UserAccessID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `SCP_UserAccess`
--

INSERT INTO `SCP_UserAccess` (`UserAccessID`, `RightsID`, `AccessLevelID`, `UserID`, `UserTypeID`, `CreatedDateTime`, `ModifyDateTime`, `StatusID`) VALUES
(1, 1, 1, 1, 1, '2017-03-01 18:14:00.000', '2017-03-01 18:14:00.000', 1),
(2, 2, 1, 2, 2, '2017-03-01 18:14:00.000', '2017-03-01 18:14:00.000', 1),
(3, 2, 2, 12, 2, '2017-03-27 17:32:53.000', '2017-03-27 17:32:53.000', 2),
(4, 2, 2, 13, 2, '2017-03-30 12:43:14.000', '2017-03-30 12:43:14.000', 2),
(6, 2, 2, 15, 2, '2017-04-03 13:52:49.000', '2017-04-03 13:52:49.000', 1),
(7, 2, 2, 16, 2, '2017-04-05 17:46:32.000', '2017-04-05 17:46:32.000', 2),
(8, 2, 2, 17, 2, '2017-04-19 18:43:28.000', '2017-04-19 18:43:28.000', 1),
(9, 9, 5, 18, 6, '2017-04-24 12:34:17.000', '2017-04-24 12:34:17.000', 1),
(10, 9, 5, 19, 6, '2017-04-24 12:34:19.000', '2017-04-24 12:34:19.000', 1),
(11, 9, 5, 20, 6, '2017-04-24 12:34:24.000', '2017-04-24 12:34:24.000', 1),
(12, 9, 5, 21, 6, '2017-04-24 12:34:27.000', '2017-04-24 12:34:27.000', 1),
(13, 9, 5, 22, 6, '2017-04-24 12:34:30.000', '2017-04-24 12:34:30.000', 1),
(14, 9, 5, 23, 6, '2017-04-24 12:34:34.000', '2017-04-24 12:34:34.000', 1),
(15, 9, 5, 24, 6, '2017-04-24 12:34:42.000', '2017-04-24 12:34:42.000', 1);

-- --------------------------------------------------------

--
-- Table structure for table `SCP_UserLogin`
--

CREATE TABLE IF NOT EXISTS `SCP_UserLogin` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(150) DEFAULT NULL,
  `EmailID` varchar(150) DEFAULT NULL,
  `Password` varchar(150) DEFAULT NULL,
  `ProfilePhoto` varchar(256) NOT NULL,
  `DashboardLogo` varchar(256) NOT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=25 ;

--
-- Dumping data for table `SCP_UserLogin`
--

INSERT INTO `SCP_UserLogin` (`UserID`, `UserName`, `EmailID`, `Password`, `ProfilePhoto`, `DashboardLogo`, `StatusID`, `CreatedDateTime`, `ModifyDateTime`) VALUES
(1, 'scpAdmin', 'abanwar2407@gmail.com', '2bdd3604cd9755bec86999d30666994e', 'http://localhost/stealthcare/uploads/user1.jpeg', 'http://localhost/stealthcare/uploads/logo1.png', 1, '2017-03-01 18:10:00.000', '2017-03-01 18:10:00.000'),
(2, 'IzissTech', 'anil.banwar@izisstechnology.com', '2bdd3604cd9755bec86999d30666994e', '', '', 1, '2017-03-01 18:10:00.000', '2017-04-03 12:43:20.000'),
(12, 'rest', 'abanwar@gmail.com', 'df6d2338b2b8fce1ec2f6dda0a630eb0', '', '', 2, '2017-03-27 17:32:53.000', '2017-04-03 16:55:25.000'),
(13, 'testData', 'abanwar1@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', '', '', 2, '2017-03-30 12:43:14.000', '2017-04-04 20:40:32.000'),
(15, 'TestUser', 'aashkothari@yahoo.co.in', '202cb962ac59075b964b07152d234b70', '', '', 1, '2017-04-03 13:52:49.000', '2017-04-05 16:11:34.000'),
(16, 'izissA', 'ashish.kushwah@izisstechnology.com', 'e10adc3949ba59abbe56e057f20f883e', '', '', 2, '2017-04-05 17:46:32.000', '2017-04-05 17:46:32.000'),
(17, 'abanwar', 'abanwar24071@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', '', '', 1, '2017-04-19 18:43:28.000', '2017-04-19 18:43:28.000'),
(18, NULL, NULL, NULL, '', '', 1, '2017-04-24 12:34:17.000', '2017-04-24 12:34:17.000'),
(19, NULL, NULL, NULL, '', '', 1, '2017-04-24 12:34:19.000', '2017-04-24 12:34:19.000'),
(20, NULL, NULL, NULL, '', '', 1, '2017-04-24 12:34:24.000', '2017-04-24 12:34:24.000'),
(21, NULL, NULL, NULL, '', '', 1, '2017-04-24 12:34:27.000', '2017-04-24 12:34:27.000'),
(22, NULL, NULL, NULL, '', '', 1, '2017-04-24 12:34:30.000', '2017-04-24 12:34:30.000'),
(23, NULL, NULL, NULL, '', '', 1, '2017-04-24 12:34:34.000', '2017-04-24 12:34:34.000'),
(24, NULL, NULL, NULL, '', '', 1, '2017-04-24 12:34:42.000', '2017-04-24 12:34:42.000');

-- --------------------------------------------------------

--
-- Table structure for table `SCP_UserType`
--

CREATE TABLE IF NOT EXISTS `SCP_UserType` (
  `UserTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `UserTypeName` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`UserTypeID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `SCP_UserType`
--

INSERT INTO `SCP_UserType` (`UserTypeID`, `UserTypeName`, `CreatedDateTime`, `ModifyDateTime`, `StatusID`) VALUES
(1, 'SUPERADMIN', '2017-03-01 18:14:00.000', '2017-03-01 18:14:00.000', 1),
(2, 'ADMIN', '2017-03-01 18:14:00.000', '2017-03-01 18:14:00.000', 1),
(3, 'FRONTENDUSER', '2017-03-01 18:14:00.000', '2017-03-01 18:14:00.000', 1),
(4, 'SUPERVISOR', '2017-03-01 18:14:00.000', '2017-03-01 18:14:00.000', 1),
(5, 'CAREWORKER', '2017-03-01 18:14:00.000', '2017-03-01 18:14:00.000', 1),
(6, 'PORTALUSER', '2017-03-01 18:14:00.000', '2017-03-20 07:13:18.000', 1);

-- --------------------------------------------------------

--
-- Table structure for table `SCP_Visits`
--

CREATE TABLE IF NOT EXISTS `SCP_Visits` (
  `VisitID` int(11) NOT NULL,
  `StaffID` int(11) DEFAULT NULL,
  `VisitTitle` varchar(150) DEFAULT NULL,
  `TimeOfDay` varchar(150) DEFAULT NULL,
  `VisitTypeID` int(11) DEFAULT NULL,
  `VisitStartDate` date DEFAULT NULL,
  `VisitEndDate` date DEFAULT NULL,
  `IsFixed` tinyint(4) DEFAULT NULL,
  `VisitDays` varchar(150) DEFAULT NULL,
  `VisitStartTime` time(6) DEFAULT NULL,
  `VisitEndTime` time(6) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `OtherDetails` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`VisitID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `SCP_VisitType`
--

CREATE TABLE IF NOT EXISTS `SCP_VisitType` (
  `VisitTypeID` int(11) NOT NULL AUTO_INCREMENT,
  `VisitTypeName` varchar(150) DEFAULT NULL,
  `CreatedDateTime` datetime(3) DEFAULT NULL,
  `ModifyDateTime` datetime(3) DEFAULT NULL,
  `StatusID` int(11) DEFAULT NULL,
  PRIMARY KEY (`VisitTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
