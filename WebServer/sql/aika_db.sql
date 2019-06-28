/*
 Navicat Premium Data Transfer

 Source Server         : local_server
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost:3306
 Source Schema         : aika_db

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 27/06/2019 19:33:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for accounts
-- ----------------------------
DROP TABLE IF EXISTS `accounts`;
CREATE TABLE `accounts`  (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `username` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `password` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `password_hash` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `mail` varchar(254) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `last_token` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `last_token_creation_time` varchar(32) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nation` int(1) NOT NULL,
  `isactive` int(1) NOT NULL,
  `account_status` int(1) NOT NULL,
  `account_type` int(1) NOT NULL,
  `storage_gold` int(8) NOT NULL,
  `cash` int(4) NOT NULL,
  `ip_created` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `time_created` int(8) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of accounts
-- ----------------------------
INSERT INTO `accounts` VALUES (7, 'adminst', 'adminst', '5ec2f53a2d2317daca044ac775463440', '', '5852e0d78158d304b4ebf4b338fd427f', '27/06/2019 19:25:18', 1, 0, 8, 1, 0, 0, '192.168.2.103', 1555177399);

-- ----------------------------
-- Table structure for buffs
-- ----------------------------
DROP TABLE IF EXISTS `buffs`;
CREATE TABLE `buffs`  (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `index` int(4) NOT NULL,
  `time` varchar(24) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `owner_charid` int(4) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id_UNIQUE`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 486 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of buffs
-- ----------------------------
INSERT INTO `buffs` VALUES (1, 50, '08/12/2018 15:45:50', 1);
INSERT INTO `buffs` VALUES (2, 6498, '08/12/2018 15:45:48', 1);
INSERT INTO `buffs` VALUES (3, 34, '08/12/2018 15:45:49', 1);
INSERT INTO `buffs` VALUES (4, 6499, '08/12/2018 15:45:48', 1);
INSERT INTO `buffs` VALUES (66, 7895, '08/12/2018 15:56:36', 3);
INSERT INTO `buffs` VALUES (67, 513, '08/12/2018 16:05:30', 3);
INSERT INTO `buffs` VALUES (68, 498, '08/12/2018 16:05:35', 3);
INSERT INTO `buffs` VALUES (69, 6498, '08/12/2018 15:56:46', 3);
INSERT INTO `buffs` VALUES (70, 6499, '08/12/2018 15:56:46', 3);
INSERT INTO `buffs` VALUES (71, 6499, '08/12/2018 15:56:46', 3);
INSERT INTO `buffs` VALUES (72, 513, '08/12/2018 16:05:30', 4);
INSERT INTO `buffs` VALUES (73, 498, '08/12/2018 16:05:35', 4);
INSERT INTO `buffs` VALUES (168, 50, '18/05/2019 19:42:22', 5);
INSERT INTO `buffs` VALUES (169, 34, '18/05/2019 19:42:21', 5);
INSERT INTO `buffs` VALUES (481, 7895, '21/06/2019 23:55:34', 6);
INSERT INTO `buffs` VALUES (482, 50, '22/06/2019 00:33:29', 6);
INSERT INTO `buffs` VALUES (483, 6498, '21/06/2019 23:55:43', 6);
INSERT INTO `buffs` VALUES (484, 34, '22/06/2019 00:34:04', 6);
INSERT INTO `buffs` VALUES (485, 6499, '21/06/2019 23:55:43', 6);

-- ----------------------------
-- Table structure for characters
-- ----------------------------
DROP TABLE IF EXISTS `characters`;
CREATE TABLE `characters`  (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `owner_accid` int(8) NOT NULL,
  `name` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `slot` int(1) NOT NULL,
  `numeric_token` varchar(4) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `numeric_errors` int(1) NOT NULL,
  `deleted` int(1) NOT NULL,
  `speedmove` int(2) NOT NULL,
  `rotation` int(2) NOT NULL,
  `lastlogin` int(4) NOT NULL,
  `loggedtime` int(4) NOT NULL,
  `playerkill` int(1) NOT NULL,
  `classinfo` int(1) NOT NULL,
  `firstlogin` int(4) NOT NULL,
  `strength` int(2) NOT NULL,
  `agility` int(2) NOT NULL,
  `intelligence` int(2) NOT NULL,
  `constitution` int(2) NOT NULL,
  `luck` int(2) NOT NULL,
  `status` int(2) NOT NULL,
  `altura` int(1) NOT NULL,
  `tronco` int(1) NOT NULL,
  `perna` int(1) NOT NULL,
  `corpo` int(1) NOT NULL,
  `curhp` int(4) NOT NULL,
  `curmp` int(4) NOT NULL,
  `honor` int(4) NOT NULL,
  `killpoint` int(4) NOT NULL,
  `infamia` int(2) NOT NULL,
  `skillpoint` int(2) NOT NULL,
  `experience` int(8) NOT NULL,
  `level` int(2) NOT NULL,
  `guildindex` int(2) NOT NULL,
  `gold` int(8) NOT NULL,
  `posx` int(4) NOT NULL,
  `posy` int(4) NOT NULL,
  `creationtime` int(4) NOT NULL,
  `delete_time` varchar(16) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `logintime` int(4) NOT NULL,
  `active_title` int(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of characters
-- ----------------------------
INSERT INTO `characters` VALUES (1, 5, '[Admin] TheMu', 0, '9999', 0, 0, 0, 198, -10800, 0, 0, 1, 0, 15, 9, 5, 16, 0, 0, 7, 119, 119, 0, 550, 110, 0, 0, 0, 0, 1, 1, 0, 0, 3379, 663, 1544283790, '', 0, 0);
INSERT INTO `characters` VALUES (2, 5, 'ADMIN', 1, '9999', 0, 0, 0, 150, -2147483648, 0, 0, 11, 0, 14, 10, 6, 14, 0, 0, 7, 119, 119, 0, 830, 388, 0, 0, 0, 10, 35515, 11, 0, 0, 3453, 692, 1544284171, '', 0, 0);
INSERT INTO `characters` VALUES (3, 5, 'OPORA', 2, '9999', 0, 0, 0, 307, 2147472848, 0, 0, 2, 0, 15, 9, 5, 16, 0, 0, 7, 119, 119, 0, 12400, 8800, 0, 0, 0, 73, 1347961511, 80, 0, 24423744, 3447, 691, 1544284288, '', 0, 0);
INSERT INTO `characters` VALUES (4, 1, 'VAI Se FUFU', 0, '9999', 0, 0, 0, 0, -2147483648, 0, 0, 1, 0, 15, 9, 5, 16, 0, 0, 7, 119, 119, 0, 550, 110, 0, 0, 0, 0, 1, 1, 0, 0, 3450, 690, 1544284980, '', 0, 0);
INSERT INTO `characters` VALUES (5, 7, 'TheMu', 0, '9999', 0, 0, 0, 52, 2147408048, 0, 0, 2, 0, 15, 9, 5, 16, 0, 0, 7, 119, 119, 0, 12730, 9210, 0, 0, 0, 109, 1347961511, 80, 0, 0, 3434, 892, 1557055748, '', 0, 0);
INSERT INTO `characters` VALUES (6, 7, 'TheMu32', 1, '9999', 0, 0, 0, 174, 2147364848, 0, 0, 1, 0, 15, 9, 5, 16, 0, 0, 7, 119, 119, 0, 2050, 1210, 0, 0, 0, 20, 35515, 11, 0, 0, 3452, 678, 1561116652, '', 0, 0);

-- ----------------------------
-- Table structure for guilds
-- ----------------------------
DROP TABLE IF EXISTS `guilds`;
CREATE TABLE `guilds`  (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(19) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nation` int(4) NOT NULL,
  `experience` int(4) NOT NULL,
  `level` int(4) NOT NULL,
  `totalmembers` int(4) NOT NULL,
  `bravurepoints` int(4) NOT NULL,
  `skillpoints` int(4) NOT NULL,
  `promote` int(1) NOT NULL,
  `notice1` varchar(34) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `notice2` varchar(34) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `notice3` varchar(34) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `site` varchar(38) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `rank1` int(1) NOT NULL,
  `rank2` int(1) NOT NULL,
  `rank3` int(1) NOT NULL,
  `rank4` int(1) NOT NULL,
  `rank5` int(1) NOT NULL,
  `ally_leader` int(4) NOT NULL,
  `guild_ally1_index` int(4) NOT NULL,
  `guild_ally1_name` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `guild_ally2_index` int(4) NOT NULL,
  `guild_ally2_name` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `guild_ally3_index` int(4) NOT NULL,
  `guild_ally3_name` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `guild_ally4_index` int(4) NOT NULL,
  `guild_ally4_name` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `storage_gold` int(8) NOT NULL,
  `member_in_chest` int(4) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for guilds_players
-- ----------------------------
DROP TABLE IF EXISTS `guilds_players`;
CREATE TABLE `guilds_players`  (
  `id` int(8) NOT NULL,
  `guild_index` int(4) NOT NULL,
  `char_index` int(8) NOT NULL,
  `name` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `rank` int(1) NOT NULL,
  `classinfo` int(1) NOT NULL,
  `level` int(1) NOT NULL,
  `logged` int(1) NOT NULL,
  `last_login` int(4) NOT NULL,
  `guilds_playerscol` varchar(45) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for itembars
-- ----------------------------
DROP TABLE IF EXISTS `itembars`;
CREATE TABLE `itembars`  (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `owner_charid` int(8) NOT NULL,
  `slot` int(2) NOT NULL,
  `item` int(2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 711 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of itembars
-- ----------------------------
INSERT INTO `itembars` VALUES (16, 1, 0, 34);
INSERT INTO `itembars` VALUES (17, 1, 1, 1570);
INSERT INTO `itembars` VALUES (18, 1, 2, 546);
INSERT INTO `itembars` VALUES (19, 1, 3, 802);
INSERT INTO `itembars` VALUES (20, 1, 7, 290);
INSERT INTO `itembars` VALUES (48, 2, 0, 15378);
INSERT INTO `itembars` VALUES (49, 2, 1, 16914);
INSERT INTO `itembars` VALUES (50, 2, 2, 15890);
INSERT INTO `itembars` VALUES (51, 2, 7, 15634);
INSERT INTO `itembars` VALUES (157, 3, 0, 34);
INSERT INTO `itembars` VALUES (158, 3, 1, 1570);
INSERT INTO `itembars` VALUES (159, 3, 7, 290);
INSERT INTO `itembars` VALUES (160, 3, 8, 546);
INSERT INTO `itembars` VALUES (161, 3, 9, 802);
INSERT INTO `itembars` VALUES (162, 3, 11, 8210);
INSERT INTO `itembars` VALUES (163, 3, 12, 7970);
INSERT INTO `itembars` VALUES (164, 3, 13, 7730);
INSERT INTO `itembars` VALUES (165, 4, 0, 34);
INSERT INTO `itembars` VALUES (166, 4, 1, 1570);
INSERT INTO `itembars` VALUES (167, 4, 2, 546);
INSERT INTO `itembars` VALUES (168, 4, 3, 802);
INSERT INTO `itembars` VALUES (169, 4, 7, 290);
INSERT INTO `itembars` VALUES (374, 5, 1, 1570);
INSERT INTO `itembars` VALUES (375, 5, 7, 290);
INSERT INTO `itembars` VALUES (376, 5, 8, 546);
INSERT INTO `itembars` VALUES (377, 5, 9, 802);
INSERT INTO `itembars` VALUES (707, 6, 1, 1570);
INSERT INTO `itembars` VALUES (708, 6, 7, 290);
INSERT INTO `itembars` VALUES (709, 6, 8, 546);
INSERT INTO `itembars` VALUES (710, 6, 9, 802);

-- ----------------------------
-- Table structure for items
-- ----------------------------
DROP TABLE IF EXISTS `items`;
CREATE TABLE `items`  (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `slot_type` int(2) NOT NULL,
  `owner_id` int(8) NOT NULL,
  `slot` int(2) NOT NULL,
  `item_id` int(2) NOT NULL,
  `app` int(2) NOT NULL,
  `identific` int(4) NOT NULL,
  `effect1_index` int(1) NOT NULL,
  `effect1_value` int(1) NOT NULL,
  `effect2_index` int(1) NOT NULL,
  `effect2_value` int(1) NOT NULL,
  `effect3_index` int(1) NOT NULL,
  `effect3_value` int(1) NOT NULL,
  `min` int(1) NOT NULL,
  `max` int(1) NOT NULL,
  `refine` int(2) NOT NULL,
  `time` int(2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2867 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of items
-- ----------------------------
INSERT INTO `items` VALUES (31, 0, 1, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (32, 0, 1, 1, 7712, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (33, 0, 1, 3, 1719, 1719, 0, 0, 0, 0, 0, 0, 0, 100, 100, 0, 0);
INSERT INTO `items` VALUES (34, 0, 1, 5, 1779, 1779, 0, 0, 0, 0, 0, 0, 0, 100, 100, 0, 0);
INSERT INTO `items` VALUES (35, 0, 1, 6, 1069, 1069, 0, 0, 0, 0, 0, 0, 0, 160, 160, 0, 0);
INSERT INTO `items` VALUES (36, 1, 1, 0, 4350, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0);
INSERT INTO `items` VALUES (37, 1, 1, 1, 4390, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0);
INSERT INTO `items` VALUES (38, 1, 1, 3, 5284, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO `items` VALUES (39, 1, 1, 4, 8025, 8025, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (40, 1, 1, 5, 1611, 1611, 0, 0, 0, 0, 0, 0, 0, 0, 0, 63233, 23567);
INSERT INTO `items` VALUES (41, 1, 1, 6, 10045, 10045, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO `items` VALUES (42, 1, 1, 60, 5300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (110, 0, 2, 0, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (111, 0, 2, 1, 7710, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (112, 0, 2, 3, 1839, 1839, 0, 0, 0, 0, 0, 0, 0, 120, 120, 0, 0);
INSERT INTO `items` VALUES (113, 0, 2, 5, 1899, 1899, 0, 0, 0, 0, 0, 0, 0, 120, 120, 0, 0);
INSERT INTO `items` VALUES (114, 0, 2, 6, 1034, 1034, 0, 0, 0, 0, 0, 0, 0, 140, 140, 0, 0);
INSERT INTO `items` VALUES (115, 0, 2, 7, 1309, 1309, 0, 0, 0, 0, 0, 0, 0, 120, 120, 0, 0);
INSERT INTO `items` VALUES (116, 1, 2, 0, 4350, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0);
INSERT INTO `items` VALUES (117, 1, 2, 1, 4390, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0);
INSERT INTO `items` VALUES (118, 1, 2, 2, 8027, 8027, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (119, 1, 2, 3, 5284, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO `items` VALUES (120, 1, 2, 4, 8025, 8025, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (121, 1, 2, 5, 1611, 1611, 0, 0, 0, 0, 0, 0, 0, 0, 0, 63745, 23567);
INSERT INTO `items` VALUES (122, 1, 2, 7, 1612, 1612, 0, 0, 0, 0, 0, 0, 0, 0, 0, 63745, 23567);
INSERT INTO `items` VALUES (123, 1, 2, 8, 4514, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50, 0);
INSERT INTO `items` VALUES (124, 1, 2, 9, 8189, 8189, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50, 0);
INSERT INTO `items` VALUES (125, 1, 2, 11, 10046, 10046, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO `items` VALUES (126, 1, 2, 60, 5300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (127, 2, 2, 80, 5310, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (374, 0, 3, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (375, 0, 3, 1, 7712, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (376, 0, 3, 3, 1719, 1719, 0, 0, 0, 0, 0, 0, 0, 100, 100, 0, 0);
INSERT INTO `items` VALUES (377, 0, 3, 5, 1779, 1779, 0, 0, 0, 0, 0, 0, 0, 100, 100, 0, 0);
INSERT INTO `items` VALUES (378, 0, 3, 6, 1069, 1069, 0, 0, 0, 0, 0, 0, 0, 160, 160, 0, 0);
INSERT INTO `items` VALUES (379, 1, 3, 0, 4350, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0);
INSERT INTO `items` VALUES (380, 1, 3, 1, 4390, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0);
INSERT INTO `items` VALUES (381, 1, 3, 2, 8027, 8027, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (382, 1, 3, 3, 5284, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO `items` VALUES (383, 1, 3, 4, 4350, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0);
INSERT INTO `items` VALUES (384, 1, 3, 5, 8007, 8007, 0, 0, 0, 0, 0, 0, 0, 0, 0, 64001, 23567);
INSERT INTO `items` VALUES (385, 1, 3, 6, 8025, 8025, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (386, 1, 3, 7, 1611, 1611, 0, 0, 0, 0, 0, 0, 0, 0, 0, 64001, 23567);
INSERT INTO `items` VALUES (387, 1, 3, 9, 1612, 1612, 0, 0, 0, 0, 0, 0, 0, 0, 0, 64001, 23567);
INSERT INTO `items` VALUES (388, 1, 3, 10, 4514, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, 49, 0);
INSERT INTO `items` VALUES (389, 1, 3, 11, 8189, 8189, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50, 0);
INSERT INTO `items` VALUES (390, 1, 3, 12, 4438, 4438, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO `items` VALUES (391, 1, 3, 13, 10046, 10046, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO `items` VALUES (392, 1, 3, 60, 5300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (393, 2, 3, 80, 5310, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (394, 0, 4, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (395, 0, 4, 1, 7715, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (396, 0, 4, 3, 1719, 1719, 0, 0, 0, 0, 0, 0, 0, 100, 100, 0, 0);
INSERT INTO `items` VALUES (397, 0, 4, 5, 1779, 1779, 0, 0, 0, 0, 0, 0, 0, 100, 100, 0, 0);
INSERT INTO `items` VALUES (398, 0, 4, 6, 1069, 1069, 0, 0, 0, 0, 0, 0, 0, 160, 160, 0, 0);
INSERT INTO `items` VALUES (399, 1, 4, 0, 4350, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0);
INSERT INTO `items` VALUES (400, 1, 4, 1, 4390, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0);
INSERT INTO `items` VALUES (401, 1, 4, 2, 10044, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO `items` VALUES (402, 1, 4, 3, 5284, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO `items` VALUES (403, 1, 4, 60, 5300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (404, 2, 4, 80, 5310, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (1372, 0, 5, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (1373, 0, 5, 1, 7707, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (1374, 0, 5, 3, 1719, 1719, 0, 0, 0, 0, 0, 0, 0, 100, 100, 0, 0);
INSERT INTO `items` VALUES (1375, 0, 5, 5, 1779, 1779, 0, 0, 0, 0, 0, 0, 0, 100, 100, 0, 0);
INSERT INTO `items` VALUES (1376, 0, 5, 6, 1069, 1069, 0, 0, 0, 0, 0, 0, 0, 160, 160, 0, 0);
INSERT INTO `items` VALUES (1377, 0, 5, 11, 1611, 1611, 0, 0, 0, 0, 0, 0, 0, 0, 0, 55553, 23762);
INSERT INTO `items` VALUES (1378, 1, 5, 0, 4350, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0);
INSERT INTO `items` VALUES (1379, 1, 5, 1, 4390, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0);
INSERT INTO `items` VALUES (1380, 1, 5, 2, 4362, 4362, 0, 0, 0, 0, 0, 0, 0, 0, 0, 500, 0);
INSERT INTO `items` VALUES (1381, 1, 5, 3, 8027, 8027, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (1382, 1, 5, 4, 8025, 8025, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (1383, 1, 5, 5, 1612, 1612, 0, 0, 0, 0, 0, 0, 0, 0, 0, 55809, 23762);
INSERT INTO `items` VALUES (1384, 1, 5, 6, 20054, 20054, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO `items` VALUES (1385, 1, 5, 7, 4400, 4400, 0, 0, 0, 0, 0, 0, 0, 0, 0, 500, 0);
INSERT INTO `items` VALUES (1386, 1, 5, 8, 4514, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, 48, 0);
INSERT INTO `items` VALUES (1387, 1, 5, 9, 8189, 8189, 0, 0, 0, 0, 0, 0, 0, 0, 0, 48, 0);
INSERT INTO `items` VALUES (1388, 1, 5, 10, 20053, 20053, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO `items` VALUES (1389, 1, 5, 11, 10046, 10046, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO `items` VALUES (1390, 1, 5, 12, 20052, 20052, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO `items` VALUES (1391, 1, 5, 13, 11286, 11286, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0);
INSERT INTO `items` VALUES (1392, 1, 5, 60, 5300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (1393, 2, 5, 80, 5310, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (2851, 0, 6, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (2852, 0, 6, 1, 7713, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (2853, 0, 6, 3, 1719, 1719, 0, 0, 0, 0, 0, 0, 0, 100, 100, 0, 0);
INSERT INTO `items` VALUES (2854, 0, 6, 5, 1779, 1779, 0, 0, 0, 0, 0, 0, 0, 100, 100, 0, 0);
INSERT INTO `items` VALUES (2855, 0, 6, 6, 1069, 1069, 0, 0, 0, 0, 0, 0, 0, 160, 160, 0, 0);
INSERT INTO `items` VALUES (2856, 1, 6, 0, 4350, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0);
INSERT INTO `items` VALUES (2857, 1, 6, 1, 4390, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0);
INSERT INTO `items` VALUES (2858, 1, 6, 2, 8027, 8027, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (2859, 1, 6, 4, 8025, 8025, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO `items` VALUES (2860, 1, 6, 5, 4362, 4362, 0, 0, 0, 0, 0, 0, 0, 0, 0, 499, 0);
INSERT INTO `items` VALUES (2861, 1, 6, 6, 4400, 4400, 0, 0, 0, 0, 0, 0, 0, 0, 0, 499, 0);
INSERT INTO `items` VALUES (2862, 1, 6, 8, 4514, 4514, 0, 0, 0, 0, 0, 0, 0, 0, 0, 46, 0);
INSERT INTO `items` VALUES (2863, 1, 6, 9, 8189, 8189, 0, 0, 0, 0, 0, 0, 0, 0, 0, 44, 0);
INSERT INTO `items` VALUES (2864, 1, 6, 10, 4438, 4438, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO `items` VALUES (2865, 1, 6, 11, 10046, 10046, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0);
INSERT INTO `items` VALUES (2866, 1, 6, 60, 5300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- ----------------------------
-- Table structure for server
-- ----------------------------
DROP TABLE IF EXISTS `server`;
CREATE TABLE `server`  (
  `nation_id` int(4) NOT NULL AUTO_INCREMENT,
  `nation_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nation_player_on` int(4) NOT NULL,
  PRIMARY KEY (`nation_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of server
-- ----------------------------
INSERT INTO `server` VALUES (1, 'astur-pvp', 0);
INSERT INTO `server` VALUES (2, 'astur-pve', 0);
INSERT INTO `server` VALUES (3, 'nation2pvp', -1);
INSERT INTO `server` VALUES (4, 'nation2pve', -1);
INSERT INTO `server` VALUES (5, 'nation3pvp', -1);
INSERT INTO `server` VALUES (6, 'nation3pve', -1);
INSERT INTO `server` VALUES (7, 'nation4pvp', -1);
INSERT INTO `server` VALUES (8, 'nation4pve', -1);
INSERT INTO `server` VALUES (9, 'nation5pvp', -1);
INSERT INTO `server` VALUES (10, 'nation5pve', -1);
INSERT INTO `server` VALUES (11, 'leopold', -1);
INSERT INTO `server` VALUES (12, 'karena', -1);

-- ----------------------------
-- Table structure for skills
-- ----------------------------
DROP TABLE IF EXISTS `skills`;
CREATE TABLE `skills`  (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `owner_charid` int(8) NOT NULL,
  `slot` int(2) NOT NULL,
  `item` int(2) NOT NULL,
  `level` int(2) NOT NULL,
  `type` int(2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5836 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of skills
-- ----------------------------
INSERT INTO `skills` VALUES (323, 2, 0, 961, 1, 1);
INSERT INTO `skills` VALUES (324, 2, 1, 977, 1, 1);
INSERT INTO `skills` VALUES (325, 2, 2, 993, 1, 1);
INSERT INTO `skills` VALUES (326, 2, 3, 1009, 1, 1);
INSERT INTO `skills` VALUES (327, 2, 4, 1025, 0, 1);
INSERT INTO `skills` VALUES (328, 2, 5, 1041, 0, 1);
INSERT INTO `skills` VALUES (329, 2, 0, 1057, 1, 2);
INSERT INTO `skills` VALUES (330, 2, 1, 1073, 0, 2);
INSERT INTO `skills` VALUES (331, 2, 2, 1089, 0, 2);
INSERT INTO `skills` VALUES (332, 2, 3, 1105, 0, 2);
INSERT INTO `skills` VALUES (333, 2, 4, 1121, 0, 2);
INSERT INTO `skills` VALUES (334, 2, 5, 1137, 0, 2);
INSERT INTO `skills` VALUES (335, 2, 6, 1153, 0, 2);
INSERT INTO `skills` VALUES (336, 2, 7, 1169, 0, 2);
INSERT INTO `skills` VALUES (337, 2, 8, 1185, 0, 2);
INSERT INTO `skills` VALUES (338, 2, 9, 1201, 0, 2);
INSERT INTO `skills` VALUES (339, 2, 10, 1217, 0, 2);
INSERT INTO `skills` VALUES (340, 2, 11, 1233, 0, 2);
INSERT INTO `skills` VALUES (341, 2, 12, 1249, 0, 2);
INSERT INTO `skills` VALUES (342, 2, 13, 1265, 0, 2);
INSERT INTO `skills` VALUES (343, 2, 14, 1281, 0, 2);
INSERT INTO `skills` VALUES (344, 2, 15, 1297, 0, 2);
INSERT INTO `skills` VALUES (345, 2, 16, 1313, 0, 2);
INSERT INTO `skills` VALUES (346, 2, 17, 1329, 0, 2);
INSERT INTO `skills` VALUES (347, 2, 18, 1345, 0, 2);
INSERT INTO `skills` VALUES (348, 2, 19, 1361, 0, 2);
INSERT INTO `skills` VALUES (349, 2, 20, 1377, 0, 2);
INSERT INTO `skills` VALUES (350, 2, 21, 1393, 0, 2);
INSERT INTO `skills` VALUES (351, 2, 22, 1409, 0, 2);
INSERT INTO `skills` VALUES (352, 2, 23, 1425, 0, 2);
INSERT INTO `skills` VALUES (353, 2, 24, 1441, 0, 2);
INSERT INTO `skills` VALUES (354, 2, 25, 1457, 0, 2);
INSERT INTO `skills` VALUES (355, 2, 26, 1473, 0, 2);
INSERT INTO `skills` VALUES (356, 2, 27, 1489, 0, 2);
INSERT INTO `skills` VALUES (357, 2, 28, 1505, 0, 2);
INSERT INTO `skills` VALUES (358, 2, 29, 1521, 0, 2);
INSERT INTO `skills` VALUES (359, 2, 30, 1537, 0, 2);
INSERT INTO `skills` VALUES (360, 2, 31, 1553, 0, 2);
INSERT INTO `skills` VALUES (361, 2, 32, 1569, 0, 2);
INSERT INTO `skills` VALUES (362, 2, 33, 1585, 0, 2);
INSERT INTO `skills` VALUES (363, 2, 34, 1601, 0, 2);
INSERT INTO `skills` VALUES (364, 2, 35, 1617, 0, 2);
INSERT INTO `skills` VALUES (365, 2, 36, 1633, 0, 2);
INSERT INTO `skills` VALUES (366, 2, 37, 1649, 0, 2);
INSERT INTO `skills` VALUES (367, 2, 38, 1665, 0, 2);
INSERT INTO `skills` VALUES (368, 2, 39, 1681, 0, 2);
INSERT INTO `skills` VALUES (1059, 3, 0, 2, 1, 1);
INSERT INTO `skills` VALUES (1060, 3, 1, 18, 1, 1);
INSERT INTO `skills` VALUES (1061, 3, 2, 34, 1, 1);
INSERT INTO `skills` VALUES (1062, 3, 3, 50, 1, 1);
INSERT INTO `skills` VALUES (1063, 3, 4, 66, 0, 1);
INSERT INTO `skills` VALUES (1064, 3, 5, 82, 0, 1);
INSERT INTO `skills` VALUES (1065, 3, 0, 98, 1, 2);
INSERT INTO `skills` VALUES (1066, 3, 1, 114, 0, 2);
INSERT INTO `skills` VALUES (1067, 3, 2, 130, 0, 2);
INSERT INTO `skills` VALUES (1068, 3, 3, 146, 0, 2);
INSERT INTO `skills` VALUES (1069, 3, 4, 162, 0, 2);
INSERT INTO `skills` VALUES (1070, 3, 5, 178, 0, 2);
INSERT INTO `skills` VALUES (1071, 3, 6, 194, 0, 2);
INSERT INTO `skills` VALUES (1072, 3, 7, 210, 0, 2);
INSERT INTO `skills` VALUES (1073, 3, 8, 226, 0, 2);
INSERT INTO `skills` VALUES (1074, 3, 9, 242, 0, 2);
INSERT INTO `skills` VALUES (1075, 3, 10, 258, 0, 2);
INSERT INTO `skills` VALUES (1076, 3, 11, 274, 0, 2);
INSERT INTO `skills` VALUES (1077, 3, 12, 290, 0, 2);
INSERT INTO `skills` VALUES (1078, 3, 13, 306, 0, 2);
INSERT INTO `skills` VALUES (1079, 3, 14, 322, 0, 2);
INSERT INTO `skills` VALUES (1080, 3, 15, 338, 0, 2);
INSERT INTO `skills` VALUES (1081, 3, 16, 354, 0, 2);
INSERT INTO `skills` VALUES (1082, 3, 17, 370, 0, 2);
INSERT INTO `skills` VALUES (1083, 3, 18, 386, 0, 2);
INSERT INTO `skills` VALUES (1084, 3, 19, 402, 0, 2);
INSERT INTO `skills` VALUES (1085, 3, 20, 418, 0, 2);
INSERT INTO `skills` VALUES (1086, 3, 21, 434, 0, 2);
INSERT INTO `skills` VALUES (1087, 3, 22, 450, 0, 2);
INSERT INTO `skills` VALUES (1088, 3, 23, 466, 0, 2);
INSERT INTO `skills` VALUES (1089, 3, 24, 482, 3, 2);
INSERT INTO `skills` VALUES (1090, 3, 25, 498, 2, 2);
INSERT INTO `skills` VALUES (1091, 3, 26, 514, 1, 2);
INSERT INTO `skills` VALUES (1092, 3, 27, 530, 0, 2);
INSERT INTO `skills` VALUES (1093, 3, 28, 546, 0, 2);
INSERT INTO `skills` VALUES (1094, 3, 29, 562, 0, 2);
INSERT INTO `skills` VALUES (1095, 3, 30, 578, 0, 2);
INSERT INTO `skills` VALUES (1096, 3, 31, 594, 0, 2);
INSERT INTO `skills` VALUES (1097, 3, 32, 610, 0, 2);
INSERT INTO `skills` VALUES (1098, 3, 33, 626, 0, 2);
INSERT INTO `skills` VALUES (1099, 3, 34, 642, 0, 2);
INSERT INTO `skills` VALUES (1100, 3, 35, 658, 0, 2);
INSERT INTO `skills` VALUES (1101, 3, 36, 674, 0, 2);
INSERT INTO `skills` VALUES (1102, 3, 37, 690, 0, 2);
INSERT INTO `skills` VALUES (1103, 3, 38, 706, 0, 2);
INSERT INTO `skills` VALUES (1104, 3, 39, 722, 0, 2);
INSERT INTO `skills` VALUES (1105, 4, 0, 2, 1, 1);
INSERT INTO `skills` VALUES (1106, 4, 1, 18, 1, 1);
INSERT INTO `skills` VALUES (1107, 4, 2, 34, 1, 1);
INSERT INTO `skills` VALUES (1108, 4, 3, 50, 1, 1);
INSERT INTO `skills` VALUES (1109, 4, 4, 66, 0, 1);
INSERT INTO `skills` VALUES (1110, 4, 5, 82, 0, 1);
INSERT INTO `skills` VALUES (1111, 4, 0, 98, 1, 2);
INSERT INTO `skills` VALUES (1112, 4, 1, 114, 0, 2);
INSERT INTO `skills` VALUES (1113, 4, 2, 130, 0, 2);
INSERT INTO `skills` VALUES (1114, 4, 3, 146, 0, 2);
INSERT INTO `skills` VALUES (1115, 4, 4, 162, 0, 2);
INSERT INTO `skills` VALUES (1116, 4, 5, 178, 0, 2);
INSERT INTO `skills` VALUES (1117, 4, 6, 194, 0, 2);
INSERT INTO `skills` VALUES (1118, 4, 7, 210, 0, 2);
INSERT INTO `skills` VALUES (1119, 4, 8, 226, 0, 2);
INSERT INTO `skills` VALUES (1120, 4, 9, 242, 0, 2);
INSERT INTO `skills` VALUES (1121, 4, 10, 258, 0, 2);
INSERT INTO `skills` VALUES (1122, 4, 11, 274, 0, 2);
INSERT INTO `skills` VALUES (1123, 4, 12, 290, 0, 2);
INSERT INTO `skills` VALUES (1124, 4, 13, 306, 0, 2);
INSERT INTO `skills` VALUES (1125, 4, 14, 322, 0, 2);
INSERT INTO `skills` VALUES (1126, 4, 15, 338, 0, 2);
INSERT INTO `skills` VALUES (1127, 4, 16, 354, 0, 2);
INSERT INTO `skills` VALUES (1128, 4, 17, 370, 0, 2);
INSERT INTO `skills` VALUES (1129, 4, 18, 386, 0, 2);
INSERT INTO `skills` VALUES (1130, 4, 19, 402, 0, 2);
INSERT INTO `skills` VALUES (1131, 4, 20, 418, 0, 2);
INSERT INTO `skills` VALUES (1132, 4, 21, 434, 0, 2);
INSERT INTO `skills` VALUES (1133, 4, 22, 450, 0, 2);
INSERT INTO `skills` VALUES (1134, 4, 23, 466, 0, 2);
INSERT INTO `skills` VALUES (1135, 4, 24, 482, 0, 2);
INSERT INTO `skills` VALUES (1136, 4, 25, 498, 0, 2);
INSERT INTO `skills` VALUES (1137, 4, 26, 514, 0, 2);
INSERT INTO `skills` VALUES (1138, 4, 27, 530, 0, 2);
INSERT INTO `skills` VALUES (1139, 4, 28, 546, 0, 2);
INSERT INTO `skills` VALUES (1140, 4, 29, 562, 0, 2);
INSERT INTO `skills` VALUES (1141, 4, 30, 578, 0, 2);
INSERT INTO `skills` VALUES (1142, 4, 31, 594, 0, 2);
INSERT INTO `skills` VALUES (1143, 4, 32, 610, 0, 2);
INSERT INTO `skills` VALUES (1144, 4, 33, 626, 0, 2);
INSERT INTO `skills` VALUES (1145, 4, 34, 642, 0, 2);
INSERT INTO `skills` VALUES (1146, 4, 35, 658, 0, 2);
INSERT INTO `skills` VALUES (1147, 4, 36, 674, 0, 2);
INSERT INTO `skills` VALUES (1148, 4, 37, 690, 0, 2);
INSERT INTO `skills` VALUES (1149, 4, 38, 706, 0, 2);
INSERT INTO `skills` VALUES (1150, 4, 39, 722, 0, 2);
INSERT INTO `skills` VALUES (3405, 5, 0, 2, 1, 1);
INSERT INTO `skills` VALUES (3406, 5, 1, 18, 1, 1);
INSERT INTO `skills` VALUES (3407, 5, 2, 34, 1, 1);
INSERT INTO `skills` VALUES (3408, 5, 3, 50, 1, 1);
INSERT INTO `skills` VALUES (3409, 5, 4, 66, 0, 1);
INSERT INTO `skills` VALUES (3410, 5, 5, 82, 0, 1);
INSERT INTO `skills` VALUES (3411, 5, 0, 98, 1, 2);
INSERT INTO `skills` VALUES (3412, 5, 1, 114, 0, 2);
INSERT INTO `skills` VALUES (3413, 5, 2, 130, 0, 2);
INSERT INTO `skills` VALUES (3414, 5, 3, 146, 0, 2);
INSERT INTO `skills` VALUES (3415, 5, 4, 162, 0, 2);
INSERT INTO `skills` VALUES (3416, 5, 5, 178, 0, 2);
INSERT INTO `skills` VALUES (3417, 5, 6, 194, 0, 2);
INSERT INTO `skills` VALUES (3418, 5, 7, 210, 0, 2);
INSERT INTO `skills` VALUES (3419, 5, 8, 226, 0, 2);
INSERT INTO `skills` VALUES (3420, 5, 9, 242, 0, 2);
INSERT INTO `skills` VALUES (3421, 5, 10, 258, 0, 2);
INSERT INTO `skills` VALUES (3422, 5, 11, 274, 0, 2);
INSERT INTO `skills` VALUES (3423, 5, 12, 290, 0, 2);
INSERT INTO `skills` VALUES (3424, 5, 13, 306, 0, 2);
INSERT INTO `skills` VALUES (3425, 5, 14, 322, 0, 2);
INSERT INTO `skills` VALUES (3426, 5, 15, 338, 0, 2);
INSERT INTO `skills` VALUES (3427, 5, 16, 354, 0, 2);
INSERT INTO `skills` VALUES (3428, 5, 17, 370, 0, 2);
INSERT INTO `skills` VALUES (3429, 5, 18, 386, 0, 2);
INSERT INTO `skills` VALUES (3430, 5, 19, 402, 0, 2);
INSERT INTO `skills` VALUES (3431, 5, 20, 418, 0, 2);
INSERT INTO `skills` VALUES (3432, 5, 21, 434, 0, 2);
INSERT INTO `skills` VALUES (3433, 5, 22, 450, 0, 2);
INSERT INTO `skills` VALUES (3434, 5, 23, 466, 0, 2);
INSERT INTO `skills` VALUES (3435, 5, 24, 482, 0, 2);
INSERT INTO `skills` VALUES (3436, 5, 25, 498, 0, 2);
INSERT INTO `skills` VALUES (3437, 5, 26, 514, 0, 2);
INSERT INTO `skills` VALUES (3438, 5, 27, 530, 0, 2);
INSERT INTO `skills` VALUES (3439, 5, 28, 546, 0, 2);
INSERT INTO `skills` VALUES (3440, 5, 29, 562, 0, 2);
INSERT INTO `skills` VALUES (3441, 5, 30, 578, 0, 2);
INSERT INTO `skills` VALUES (3442, 5, 31, 594, 0, 2);
INSERT INTO `skills` VALUES (3443, 5, 32, 610, 0, 2);
INSERT INTO `skills` VALUES (3444, 5, 33, 626, 0, 2);
INSERT INTO `skills` VALUES (3445, 5, 34, 642, 0, 2);
INSERT INTO `skills` VALUES (3446, 5, 35, 658, 0, 2);
INSERT INTO `skills` VALUES (3447, 5, 36, 674, 0, 2);
INSERT INTO `skills` VALUES (3448, 5, 37, 690, 0, 2);
INSERT INTO `skills` VALUES (3449, 5, 38, 706, 0, 2);
INSERT INTO `skills` VALUES (3450, 5, 39, 722, 0, 2);
INSERT INTO `skills` VALUES (5827, 6, 0, 2, 1, 1);
INSERT INTO `skills` VALUES (5828, 6, 1, 18, 1, 1);
INSERT INTO `skills` VALUES (5829, 6, 2, 34, 1, 1);
INSERT INTO `skills` VALUES (5830, 6, 3, 50, 1, 1);
INSERT INTO `skills` VALUES (5831, 6, 4, 66, 0, 1);
INSERT INTO `skills` VALUES (5832, 6, 5, 82, 0, 1);
INSERT INTO `skills` VALUES (5833, 6, 0, 98, 1, 2);
INSERT INTO `skills` VALUES (5834, 6, 1, 114, 0, 2);
INSERT INTO `skills` VALUES (5835, 6, 2, 130, 0, 2);

-- ----------------------------
-- Table structure for titles
-- ----------------------------
DROP TABLE IF EXISTS `titles`;
CREATE TABLE `titles`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_charid` int(8) NOT NULL,
  `title_index` int(2) NOT NULL,
  `title_level` int(2) NOT NULL DEFAULT 1,
  `title_progress` int(2) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
