/*
SQLyog Community v13.1.2 (64 bit)
MySQL - 10.4.17-MariaDB : Database - singing_contest
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`singing_contest` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `singing_contest`;

/*Table structure for table `contest_judges` */

DROP TABLE IF EXISTS `contest_judges`;

CREATE TABLE `contest_judges` (
                                `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
                                `judge_id` int(11) NOT NULL,
                                `judge_name` varchar(50) NOT NULL,
                                `inserted_at` timestamp NOT NULL DEFAULT current_timestamp(),
                                `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
                                `contest_id` int(11) NOT NULL,
                                PRIMARY KEY (`id`),
                                KEY `index_contest_judges` (`judge_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

/*Data for the table `contest_judges` */

/*Table structure for table `contest_rounds` */

DROP TABLE IF EXISTS `contest_rounds`;

CREATE TABLE `contest_rounds` (
                                `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
                                `contest_id` int(11) NOT NULL,
                                `contest_round` int(5) NOT NULL,
                                `round_genre` varchar(30) NOT NULL,
                                `finished` tinyint(1) NOT NULL,
                                `inserted_at` timestamp NOT NULL DEFAULT current_timestamp(),
                                `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                                PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

/*Data for the table `contest_rounds` */

/*Table structure for table `contestants` */

DROP TABLE IF EXISTS `contestants`;

CREATE TABLE `contestants` (
                             `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
                             `contest_id` int(11) NOT NULL,
                             `name` varchar(50) NOT NULL,
                             `score` float NOT NULL,
                             `winner` tinyint(1) NOT NULL DEFAULT 0,
                             `inserted_at` timestamp NOT NULL DEFAULT current_timestamp(),
                             `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                             PRIMARY KEY (`id`),
                             KEY `contest_id_and_winner` (`contest_id`,`winner`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

/*Data for the table `contestants` */

/*Table structure for table `contests` */

DROP TABLE IF EXISTS `contests`;

CREATE TABLE `contests` (
                          `id` int(6) unsigned NOT NULL AUTO_INCREMENT,
                          `inserted_at` timestamp NOT NULL DEFAULT current_timestamp(),
                          `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
                          `finished` tinyint(1) DEFAULT 0,
                          PRIMARY KEY (`id`),
                          KEY `finished` (`finished`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

/*Data for the table `contests` */

/*Table structure for table `genre_streangth` */

DROP TABLE IF EXISTS `genre_streangth`;

CREATE TABLE `genre_streangth` (
                                 `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
                                 `contest_id` int(11) NOT NULL,
                                 `contestant_id` int(11) NOT NULL,
                                 `genre_id` int(11) NOT NULL,
                                 `streangth` int(2) NOT NULL,
                                 `inserted_at` timestamp NOT NULL DEFAULT current_timestamp(),
                                 `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                                 PRIMARY KEY (`id`),
                                 KEY `index_judge_score` (`contest_id`,`contestant_id`,`genre_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

/*Data for the table `genre_streangth` */

/*Table structure for table `genres` */

DROP TABLE IF EXISTS `genres`;

CREATE TABLE `genres` (
                        `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
                        `genre` varchar(30) NOT NULL,
                        `inserted_at` timestamp NOT NULL DEFAULT current_timestamp(),
                        `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                        PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

/*Data for the table `genres` */

insert  into `genres`(`id`,`genre`,`inserted_at`,`updated_at`) values
(20,'Rock','2022-03-24 20:24:42','2022-03-24 20:24:42'),
(21,'Country','2022-03-24 20:24:42','2022-03-24 20:24:42'),
(22,'Pop','2022-03-24 20:24:42','2022-03-24 20:24:42'),
(23,'Disco','2022-03-24 20:24:42','2022-03-24 20:24:42'),
(24,'Jazz','2022-03-24 20:24:42','2022-03-24 20:24:42'),
(25,'The Blues','2022-03-24 20:24:42','2022-03-24 20:24:42');

/*Table structure for table `judges` */

DROP TABLE IF EXISTS `judges`;

CREATE TABLE `judges` (
                        `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
                        `name` varchar(30) NOT NULL,
                        `inserted_at` timestamp NOT NULL DEFAULT current_timestamp(),
                        `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                        PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

/*Data for the table `judges` */

insert  into `judges`(`id`,`name`,`inserted_at`,`updated_at`) values
(11,'RandomJudge','2022-03-22 20:24:42','2022-03-22 20:24:42'),
(12,'HonestJudge','2022-03-22 20:24:42','2022-03-22 20:24:42'),
(13,'MeanJudge','2022-03-22 20:24:42','2022-03-22 20:24:42'),
(14,'RockJudge','2022-03-22 20:24:42','2022-03-22 20:24:42'),
(15,'FriendlyJudge','2022-03-22 20:24:42','2022-03-22 20:24:42');

/*Table structure for table `judges_score` */

DROP TABLE IF EXISTS `judges_score`;

CREATE TABLE `judges_score` (
                              `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
                              `contest_id` int(11) NOT NULL,
                              `round_id` int(11) NOT NULL,
                              `contestant_id` int(11) NOT NULL,
                              `judge_id` int(11) NOT NULL,
                              `judge_score` int(2) NOT NULL,
                              `inserted_at` timestamp NOT NULL DEFAULT current_timestamp(),
                              `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                              PRIMARY KEY (`id`),
                              KEY `index_judge_score` (`contest_id`,`round_id`,`contestant_id`,`judge_id`,`judge_score`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

/*Data for the table `judges_score` */

/*Table structure for table `round_score` */

DROP TABLE IF EXISTS `round_score`;

CREATE TABLE `round_score` (
                             `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
                             `contest_id` int(11) NOT NULL,
                             `round_id` int(11) NOT NULL,
                             `contest_round` tinyint(1) NOT NULL,
                             `contestant_id` int(11) NOT NULL,
                             `contestant_score` float(3,1) NOT NULL,
  `judge_score` int(2) NOT NULL,
  `is_sick` tinyint(1) NOT NULL,
  `inserted_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                                                                 PRIMARY KEY (`id`),
                                                                 KEY `index_round_score` (`contest_id`,`round_id`,`contest_round`,`contestant_id`,`contestant_score`,`judge_score`,`is_sick`)
                                                                 ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

/*Data for the table `round_score` */

/*Table structure for table `rounds_log` */

DROP TABLE IF EXISTS `rounds_log`;

CREATE TABLE `rounds_log` (
                            `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
                            `contest_id` int(11) NOT NULL,
                            `round_id` int(11) NOT NULL,
                            `round` tinyint(1) NOT NULL,
                            `json_data` text NOT NULL,
                            `inserted_at` timestamp NOT NULL DEFAULT current_timestamp(),
                            `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
                            PRIMARY KEY (`id`),
                            KEY `index_rounds_log` (`contest_id`,`round_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;

/*Data for the table `rounds_log` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
