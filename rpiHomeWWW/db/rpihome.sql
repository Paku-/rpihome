-- phpMyAdmin SQL Dump
-- version 4.3.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 30, 2015 at 11:05 AM
-- Server version: 5.5.43-0+deb7u1-log
-- PHP Version: 5.4.39-0+deb7u2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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
(1, 2, 0, 0, 10);

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
CREATE TABLE IF NOT EXISTS `log` (
  `id` int(11) NOT NULL,
  `severity` int(11) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data` varchar(100) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2054 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `log`
--

INSERT INTO `log` (`id`, `severity`, `time`, `data`) VALUES
(1, 0, '2015-01-16 15:46:59', 'Log Test Entry 1'),
(2, 0, '2015-01-16 15:48:28', 'Log Test Entry 2'),
(3, 0, '2015-01-16 15:48:28', 'Log Test Entry 3'),
(4, 0, '2015-01-16 15:48:39', 'Log Test Entry 2'),
(5, 0, '2015-01-16 15:48:39', 'Log Test Entry 3'),
(6, 1, '2015-05-27 18:46:06', 'PIN 26 set to OFF'),
(7, 1, '2015-05-27 18:46:53', 'PIN 19 set to ON'),
(8, 1, '2015-05-27 18:46:55', 'PIN 20 set to ON'),
(9, 1, '2015-05-27 19:10:38', 'PIN 19 OFF'),
(10, 1, '2015-05-27 19:10:38', 'PIN 20 OFF'),
(11, 1, '2015-05-27 19:11:00', 'PIN 19 OFF'),
(12, 1, '2015-05-27 19:11:39', 'PIN 19 ON'),
(13, 1, '2015-05-27 19:11:56', 'PIN 26 ON'),
(14, 1, '2015-05-27 19:12:23', 'PIN 16 ON'),
(15, 1, '2015-05-27 19:12:51', 'PIN 19 OFF'),
(16, 1, '2015-05-27 19:12:51', 'PIN 26 OFF'),
(17, 0, '2015-05-27 19:40:16', 'PIN 19 OFF'),
(18, 0, '2015-05-27 19:43:03', 'PIN 20 OFF'),
(19, 0, '2015-05-27 20:15:32', 'PIN 16 OFF'),
(20, 0, '2015-05-27 20:16:01', 'PIN 19 ON'),
(21, 0, '2015-05-27 20:16:16', 'PIN 16 ON'),
(22, 0, '2015-05-27 20:16:16', 'PIN 20 ON'),
(23, 0, '2015-05-27 20:18:16', 'PIN 19 OFF'),
(24, 0, '2015-05-27 20:18:16', 'PIN 20 OFF'),
(25, 0, '2015-05-28 08:03:32', 'PIN 16 ON'),
(26, 0, '2015-05-28 08:03:32', 'PIN 26 ON'),
(27, 0, '2015-05-28 11:50:21', '23125'),
(28, 0, '2015-05-28 11:50:30', 'PIN 16 OFF'),
(29, 0, '2015-05-28 11:50:30', '23125'),
(30, 0, '2015-05-28 11:56:33', '23125'),
(31, 0, '2015-05-28 11:56:57', '28750'),
(32, 3, '2015-05-28 12:00:42', '23375'),
(33, 3, '2015-05-28 12:01:17', '23312'),
(34, 3, '2015-05-28 12:01:22', '23312'),
(35, 3, '2015-05-28 12:10:02', '23125'),
(36, 3, '2015-05-28 12:11:03', '23125'),
(37, 3, '2015-05-28 12:12:02', '23125'),
(38, 3, '2015-05-28 12:13:02', '23187'),
(39, 3, '2015-05-28 12:14:02', '23125'),
(40, 3, '2015-05-28 12:15:02', '23125'),
(41, 3, '2015-05-28 12:16:03', '23125'),
(42, 3, '2015-05-28 12:17:03', '23125'),
(43, 3, '2015-05-28 12:18:02', '23187'),
(44, 3, '2015-05-28 12:19:02', '23187'),
(45, 3, '2015-05-28 12:20:02', '23125'),
(46, 3, '2015-05-28 12:21:02', '23187'),
(47, 3, '2015-05-28 12:22:02', '23187'),
(48, 3, '2015-05-28 12:23:03', '23187'),
(49, 3, '2015-05-28 12:24:03', '23250'),
(50, 3, '2015-05-28 12:25:03', '23187'),
(51, 3, '2015-05-28 12:26:02', '23187'),
(52, 3, '2015-05-28 12:27:03', '23187'),
(53, 3, '2015-05-28 12:28:03', '23187'),
(54, 3, '2015-05-28 12:29:02', '23187'),
(55, 3, '2015-05-28 12:30:02', '23187'),
(56, 3, '2015-05-28 12:31:03', '23125'),
(57, 3, '2015-05-28 12:32:02', '23125'),
(58, 3, '2015-05-28 12:33:03', '23187'),
(59, 3, '2015-05-28 12:34:02', '23125'),
(60, 3, '2015-05-28 12:35:03', '23062'),
(61, 3, '2015-05-28 12:36:03', '26250'),
(62, 3, '2015-05-28 12:37:03', '23312'),
(63, 3, '2015-05-28 12:38:03', '23250'),
(64, 3, '2015-05-28 12:39:03', '23250'),
(65, 3, '2015-05-28 12:40:03', '23187'),
(66, 3, '2015-05-28 12:41:02', '23250'),
(67, 3, '2015-05-28 12:42:02', '23187'),
(68, 3, '2015-05-28 12:43:02', '23187'),
(69, 3, '2015-05-28 12:44:02', '23187'),
(70, 3, '2015-05-28 12:45:02', '23187'),
(71, 3, '2015-05-28 12:46:02', '23187'),
(72, 3, '2015-05-28 12:47:02', '23187'),
(73, 3, '2015-05-28 12:48:02', '23187'),
(74, 3, '2015-05-28 12:49:02', '23250'),
(75, 3, '2015-05-28 12:50:02', '23187'),
(76, 3, '2015-05-28 12:51:02', '23187'),
(77, 3, '2015-05-28 12:52:03', '23250'),
(78, 3, '2015-05-28 12:53:02', '23187'),
(79, 3, '2015-05-28 12:54:02', '23250'),
(80, 3, '2015-05-28 12:55:03', '23250'),
(81, 3, '2015-05-28 12:56:02', '23250'),
(82, 3, '2015-05-28 12:57:02', '23187'),
(83, 3, '2015-05-28 12:58:02', '23250'),
(84, 3, '2015-05-28 12:59:02', '23250'),
(85, 3, '2015-05-28 13:00:02', '23250'),
(86, 3, '2015-05-28 13:01:02', '23250'),
(87, 3, '2015-05-28 13:02:02', '23250'),
(88, 3, '2015-05-28 13:03:02', '23250'),
(89, 3, '2015-05-28 13:04:02', '23250'),
(90, 3, '2015-05-28 13:05:03', '23250'),
(91, 3, '2015-05-28 13:06:03', '23250'),
(92, 3, '2015-05-28 13:07:03', '23250'),
(93, 3, '2015-05-28 13:08:03', '23250'),
(94, 3, '2015-05-28 13:09:02', '23250'),
(95, 3, '2015-05-28 13:10:02', '23250'),
(96, 3, '2015-05-28 13:11:03', '23250'),
(97, 3, '2015-05-28 13:12:03', '23250'),
(98, 3, '2015-05-28 13:13:02', '23312'),
(99, 3, '2015-05-28 13:14:02', '23250'),
(100, 3, '2015-05-28 13:15:02', '23250'),
(101, 3, '2015-05-28 13:16:03', '23312'),
(102, 3, '2015-05-28 13:17:04', '23250'),
(103, 3, '2015-05-28 16:21:59', '23625'),
(104, 3, '2015-05-28 17:06:18', '23625'),
(105, 0, '2015-05-28 17:07:01', 'PIN 19 OFF'),
(106, 3, '2015-05-28 17:07:53', '23562');

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
(37, 26, 25, 'GPIO 26/25', 1, 1, 1),
(38, 20, 28, 'GPIO 20/28', 1, 0, 1),
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
  ADD PRIMARY KEY (`id`), ADD KEY `severity` (`severity`), ADD KEY `time` (`time`);

--
-- Indexes for table `pinState`
--
ALTER TABLE `pinState`
  ADD PRIMARY KEY (`ID`), ADD KEY `Output` (`Output`), ADD KEY `State` (`State`), ADD KEY `Enabled` (`Enabled`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`), ADD UNIQUE KEY `user` (`user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2054;
--
-- AUTO_INCREMENT for table `pinState`
--
ALTER TABLE `pinState`
  MODIFY `ID` tinyint(1) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=41;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(2) NOT NULL AUTO_INCREMENT;