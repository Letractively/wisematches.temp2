#14.02.14
ALTER TABLE `ekoshka`.`store_order`
ADD COLUMN `phone` VARCHAR(20) NULL DEFAULT NULL
AFTER `city`;

ALTER TABLE `ekoshka`.`privacy_address_record`
CHANGE COLUMN `postcode` `postcode` VARCHAR(10) NULL DEFAULT NULL,
CHANGE COLUMN `region` `region` VARCHAR(145) NULL DEFAULT NULL,
CHANGE COLUMN `city` `city` VARCHAR(145) NULL DEFAULT NULL,
ADD COLUMN `phone` VARCHAR(20) NULL DEFAULT NULL
AFTER `lastName`;


INSERT INTO `billiongoods`.`system_version` (`version`) VALUES ('140214');