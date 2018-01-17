-- phpMyAdmin SQL Dump
-- version 4.4.8
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 21, 2015 at 01:53 PM
-- Server version: 5.5.43-0+deb7u1-log
-- PHP Version: 5.4.41-0+deb7u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";

--
-- Database: `rpihome`
--
CREATE DATABASE IF NOT EXISTS `rpihome` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `rpihome`;

-- --------------------------------------------------------

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
CREATE TABLE IF NOT EXISTS `config` (
  `configVersion` tinyint(4) NOT NULL DEFAULT '1',
  `boardRev` tinyint(1) NOT NULL,
  `debugMode` tinyint(1) NOT NULL DEFAULT '0',
  `showDisabledPins` tinyint(1) NOT NULL DEFAULT '0',
  `logPageSize` int(11) NOT NULL DEFAULT '10'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='System wide configuration table, one row a time.';

--
-- Dumping data for table `config`
--

INSERT INTO `config` (`configVersion`, `boardRev`, `debugMode`, `showDisabledPins`, `logPageSize`) VALUES
(1, 2, 1, 0, 10);

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
CREATE TABLE IF NOT EXISTS `log` (
  `id` int(11) NOT NULL,
  `source` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `action` int(11) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `message` varchar(100) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2068 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `log`
--

INSERT INTO `log` (`id`, `source`, `action`, `time`, `message`) VALUES
(2054, 'RELAY', 5, '2015-06-21 11:48:01', 'PIN 19 OFF'),
(2055, 'RELAY', 4, '2015-06-21 11:48:03', 'PIN 16 ON'),
(2056, 'TEMP_CPU', 3, '2015-06-21 11:48:03', '41160'),
(2057, 'TEMP_10-00', 3, '2015-06-21 11:48:04', '23250'),
(2058, 'TEMP_CPU', 3, '2015-06-21 11:49:02', '42236'),
(2059, 'TEMP_10-00', 3, '2015-06-21 11:49:03', '23250'),
(2060, 'TEMP_CPU', 3, '2015-06-21 11:50:02', '42236'),
(2061, 'TEMP_10-00', 3, '2015-06-21 11:50:03', '23250'),
(2062, 'TEMP_CPU', 3, '2015-06-21 11:51:02', '41698'),
(2063, 'TEMP_10-00', 3, '2015-06-21 11:51:03', '23187'),
(2064, 'TEMP_CPU', 3, '2015-06-21 11:52:01', '42236'),
(2065, 'TEMP_10-00', 3, '2015-06-21 11:52:02', '23250'),
(2066, 'TEMP_CPU', 3, '2015-06-21 11:53:02', '42774'),
(2067, 'TEMP_10-00', 3, '2015-06-21 11:53:02', '23187');

-- --------------------------------------------------------

--
-- Table structure for table `pinState`
--

DROP TABLE IF EXISTS `pinState`;
CREATE TABLE IF NOT EXISTS `pinState` (
  `ID` tinyint(1) NOT NULL,
  `BCM` tinyint(1) NOT NULL,
  `WPi` tinyint(1) NOT NULL,
  `Name` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Pin',
  `Output` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 -out 0- in',
  `State` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 - high 0 -low',
  `Enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 - enabled 0 -disabled'
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `pinState`
--

INSERT INTO `pinState` (`ID`, `BCM`, `WPi`, `Name`, `Output`, `State`, `Enabled`) VALUES
(1, -1, -1, '3.3V', 1, 0, 0),
(2, -1, -1, '5V', 1, 0, 0),
(3, 2, 8, 'SDA.1', 0, 0, 0),
(4, -1, -1, '5V', 1, 0, 0),
(5, 3, 9, 'SCL.1', 0, 0, 0),
(6, -1, -1, 'GND', 1, 0, 0),
(7, 4, 7, 'GPIO 4/7', 1, 1, 0),
(8, 14, 15, 'TxD', 1, 0, 0),
(9, -1, -1, 'GND', 1, 0, 0),
(10, 15, 16, 'RxD', 0, 0, 0),
(11, 17, 0, 'GPIO 17/0', 1, 1, 0),
(12, 18, 1, 'GPIO 18/1', 1, 1, 0),
(13, 27, 2, 'GPIO 27/2', 1, 1, 0),
(14, -1, -1, 'GND', 1, 0, 0),
(15, 22, 3, 'GPIO 22/3', 1, 1, 0),
(16, 23, 4, 'GPIO 23/4', 1, 1, 0),
(17, -1, -1, '3.3V', 1, 0, 0),
(18, 24, 5, 'GPIO 24/5', 1, 1, 0),
(19, 10, 12, 'MOSI', 0, 0, 0),
(20, -1, -1, 'GND', 1, 0, 0),
(21, 9, 13, 'MISO', 1, 0, 0),
(22, 25, 6, 'GPIO 25/6', 1, 1, 0),
(23, 11, 14, 'SCLK', 1, 0, 0),
(24, 8, 10, 'CE0', 0, 0, 0),
(25, -1, -1, 'GND', 1, 0, 0),
(26, 7, 11, 'CE1', 0, 0, 0),
(27, 0, 30, 'SDA.0', 0, 0, 0),
(28, 1, 31, 'SCL.0', 0, 0, 0),
(29, 5, 21, 'GPIO 5/21', 1, 1, 0),
(30, -1, -1, 'GND', 1, 0, 0),
(31, 6, 22, 'GPIO 6/22', 1, 1, 0),
(32, 12, 26, 'GPIO 12/26', 1, 1, 0),
(33, 13, 23, 'GPIO 13/23', 1, 1, 0),
(34, -1, -1, 'GND', 1, 0, 0),
(35, 19, 24, 'GPIO 19/24', 1, 0, 1),
(36, 16, 27, 'GPIO 16/27', 1, 1, 1),
(37, 26, 25, 'GPIO 26/25', 1, 0, 1),
(38, 20, 28, 'GPIO 20/28', 1, 1, 1),
(39, -1, -1, 'GND', 1, 0, 0),
(40, 21, 29, 'GPIO 21/29', 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `ID` int(2) NOT NULL,
  `user` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `pass` varchar(20) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `config`
--
ALTER TABLE `config`
  ADD PRIMARY KEY (`configVersion`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `time` (`time`),
  ADD KEY `source` (`source`),
  ADD KEY `action` (`action`);

--
-- Indexes for table `pinState`
--
ALTER TABLE `pinState`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Output` (`Output`),
  ADD KEY `State` (`State`),
  ADD KEY `Enabled` (`Enabled`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `user` (`user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2068;
--
-- AUTO_INCREMENT for table `pinState`
--
ALTER TABLE `pinState`
  MODIFY `ID` tinyint(1) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=41;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(2) NOT NULL AUTO_INCREMENT;COMMIT;
