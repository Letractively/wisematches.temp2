CREATE TABLE `account_personality` (
  `id`           BIGINT(20)   NOT NULL AUTO_INCREMENT,
  `email`        VARCHAR(150) DEFAULT NULL,
  `password`     VARCHAR(100) DEFAULT NULL,
  `username`     VARCHAR(100) NOT NULL,
  `language`     CHAR(2)      NOT NULL DEFAULT 'RU',
  `timezone`     VARCHAR(245) NOT NULL DEFAULT 'GMT+00:00',
  `lastActivity` DATETIME DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `email_INDEX` (`email`)
)
  ENGINE =InnoDB
  AUTO_INCREMENT =122
  DEFAULT CHARSET =utf8
  COMMENT ='The base table that contains information about a player';

CREATE TABLE `account_blacknames` (
  `username` VARCHAR(100) NOT NULL,
  `reason`   VARCHAR(255) NOT NULL,
  PRIMARY KEY (`username`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

CREATE TABLE `account_lock` (
  `account`       BIGINT(20)   NOT NULL,
  `publicReason`  VARCHAR(145) NOT NULL,
  `privateReason` VARCHAR(145) NOT NULL,
  `lockDate`      DATETIME     NOT NULL,
  `unlockDate`    DATETIME     NOT NULL,
  PRIMARY KEY (`account`),
  CONSTRAINT `fk_account_lock_account_personality1` FOREIGN KEY (`account`) REFERENCES `account_personality` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

CREATE TABLE `account_recovery` (
  `account`   BIGINT(20)  NOT NULL,
  `token`     VARCHAR(45) NOT NULL,
  `generated` DATETIME    NOT NULL,
  PRIMARY KEY (`account`),
  CONSTRAINT `fk_account_recovery_account_personality1` FOREIGN KEY (`account`) REFERENCES `account_personality` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

CREATE TABLE `account_role` (
  `account` BIGINT(20)                 NOT NULL,
  `role`    ENUM('admin', 'moderator') NOT NULL,
  PRIMARY KEY (`account`, `role`),
  CONSTRAINT `fk_account_role_account_personality` FOREIGN KEY (`account`) REFERENCES `account_personality` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

CREATE TABLE `account_userconnection` (
  `userId`         VARCHAR(255) NOT NULL,
  `providerId`     VARCHAR(255) NOT NULL,
  `providerUserId` VARCHAR(255) NOT NULL DEFAULT '',
  `rank`           INT(11)      NOT NULL,
  `displayName`    VARCHAR(255) DEFAULT NULL,
  `profileUrl`     VARCHAR(512) DEFAULT NULL,
  `imageUrl`       VARCHAR(512) DEFAULT NULL,
  `accessToken`    VARCHAR(255) NOT NULL,
  `secret`         VARCHAR(255) DEFAULT NULL,
  `refreshToken`   VARCHAR(255) DEFAULT NULL,
  `expireTime`     BIGINT(20) DEFAULT NULL,
  PRIMARY KEY (`userId`, `providerId`, `providerUserId`),
  UNIQUE KEY `UserConnectionRank` (`userId`, `providerId`, `rank`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

CREATE TABLE `paypal_ipn_message` (
  `id`                  BIGINT(20) NOT NULL AUTO_INCREMENT,
  `txn_id`              VARCHAR(245) DEFAULT NULL,
  `txn_type`            VARCHAR(245) DEFAULT NULL,
  `verify_sign`         VARCHAR(245) DEFAULT NULL,
  `business`            VARCHAR(245) DEFAULT NULL,
  `charset`             VARCHAR(245) DEFAULT NULL,
  `custom`              VARCHAR(245) DEFAULT NULL,
  `ipn_track_id`        VARCHAR(245) DEFAULT NULL,
  `notify_version`      VARCHAR(245) DEFAULT NULL,
  `parent_txn_id`       VARCHAR(245) DEFAULT NULL,
  `receipt_id`          VARCHAR(245) DEFAULT NULL,
  `receiver_email`      VARCHAR(245) DEFAULT NULL,
  `receiver_id`         VARCHAR(245) DEFAULT NULL,
  `resend`              VARCHAR(245) DEFAULT NULL,
  `residence_country`   VARCHAR(245) DEFAULT NULL,
  `test_ipn`            VARCHAR(5) DEFAULT NULL,
  `transaction_subject` VARCHAR(245) DEFAULT NULL,
  `message`             MEDIUMTEXT,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

CREATE TABLE `paypal_transaction` (
  `id`                  BIGINT(20)     NOT NULL AUTO_INCREMENT,
  `token`               CHAR(20) DEFAULT NULL,
  `orderId`             BIGINT(20)     NOT NULL,
  `amount`              DECIMAL(10, 4) NOT NULL,
  `shipment`            DECIMAL(10, 4) NOT NULL,
  `phase`               TINYINT(4) DEFAULT NULL,
  `resolution`          TINYINT(4) DEFAULT NULL,
  `payer`               VARCHAR(127) DEFAULT NULL,
  `payerId`             VARCHAR(13) DEFAULT NULL,
  `payerNote`           VARCHAR(255) DEFAULT NULL,
  `payerPhone`          VARCHAR(45) DEFAULT NULL,
  `payerLastName`       VARCHAR(25) DEFAULT NULL,
  `payerFirstName`      VARCHAR(25) DEFAULT NULL,
  `payerCountry`        CHAR(2) DEFAULT NULL,
  `checkoutStatus`      VARCHAR(45) DEFAULT NULL,
  `transactionId`       VARCHAR(20) DEFAULT NULL,
  `transactionType`     VARCHAR(15) DEFAULT NULL,
  `parentTransactionId` VARCHAR(20) DEFAULT NULL,
  `paymentType`         VARCHAR(7) DEFAULT NULL,
  `paymentStatus`       VARCHAR(45) DEFAULT NULL,
  `paymentRequestId`    VARCHAR(45) DEFAULT NULL,
  `paymentDate`         DATETIME DEFAULT NULL,
  `feeAmount`           DECIMAL(10, 4) DEFAULT NULL,
  `grossAmount`         DECIMAL(10, 4) DEFAULT NULL,
  `settleAmount`        DECIMAL(10, 4) DEFAULT NULL,
  `taxAmount`           DECIMAL(10, 4) DEFAULT NULL,
  `exchangeRate`        VARCHAR(17) DEFAULT NULL,
  `reasonCode`          VARCHAR(20) DEFAULT NULL,
  `pendingReason`       VARCHAR(20) DEFAULT NULL,
  `holdDecision`        VARCHAR(45) DEFAULT NULL,
  `insuranceAmount`     VARCHAR(45) DEFAULT NULL,
  `creationTime`        DATETIME DEFAULT NULL,
  `invoicingTime`       DATETIME DEFAULT NULL,
  `verificationTime`    DATETIME DEFAULT NULL,
  `confirmationTime`    DATETIME DEFAULT NULL,
  `finalizationTime`    DATETIME DEFAULT NULL,
  `errorAck`            VARCHAR(45) DEFAULT NULL,
  `errorCode`           VARCHAR(45) DEFAULT NULL,
  `errorSeverity`       VARCHAR(45) DEFAULT NULL,
  `shortMessage`        VARCHAR(127) DEFAULT NULL,
  `longMessage`         VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `INDEX_token` (`token`),
  KEY `INDEX_orderId` (`orderId`)
)
  ENGINE =InnoDB
  AUTO_INCREMENT =101
  DEFAULT CHARSET =utf8;

CREATE TABLE `persistent_logins` (
  `series`    VARCHAR(64)  NOT NULL,
  `username`  VARCHAR(150) NOT NULL,
  `token`     VARCHAR(64)  NOT NULL,
  `last_used` TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`series`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

CREATE TABLE `privacy_address_book` (
  `id`             BIGINT(20) NOT NULL,
  `primaryAddress` INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

CREATE TABLE `privacy_address_record` (
  `id`          INT(11)      NOT NULL AUTO_INCREMENT,
  `addressBook` BIGINT(20)   NOT NULL,
  `firstName`   VARCHAR(145) NOT NULL,
  `lastName`    VARCHAR(245) NOT NULL,
  `postcode`    VARCHAR(10)  NOT NULL,
  `region`      VARCHAR(145) NOT NULL,
  `city`        VARCHAR(145) NOT NULL,
  `location`    VARCHAR(250) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `addressBook_idx` (`addressBook`),
  CONSTRAINT `addressBook` FOREIGN KEY (`addressBook`) REFERENCES `privacy_address_book` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE =InnoDB
  AUTO_INCREMENT =14
  DEFAULT CHARSET =utf8;

CREATE TABLE `privacy_wishlist` (
  `person`  BIGINT(20) NOT NULL,
  `product` INT(11)    NOT NULL,
  PRIMARY KEY (`person`, `product`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

CREATE TABLE `service_exchange` (
  `id`           INT(11)        NOT NULL AUTO_INCREMENT,
  `timestamp`    DATETIME       NOT NULL,
  `exchangeRate` DECIMAL(10, 4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `timestamp_index` (`timestamp`)
)
  ENGINE =InnoDB
  AUTO_INCREMENT =7
  DEFAULT CHARSET =utf8;

CREATE TABLE `service_validation` (
  `id`        INT(11)  NOT NULL AUTO_INCREMENT,
  `productId` INT(11)  NOT NULL,
  `timestamp` DATETIME NOT NULL,
  `op`        DECIMAL(10, 4) DEFAULT NULL,
  `opp`       DECIMAL(10, 4) DEFAULT NULL,
  `osp`       DECIMAL(10, 4) DEFAULT NULL,
  `ospp`      DECIMAL(10, 4) DEFAULT NULL,
  `np`        DECIMAL(10, 4) DEFAULT NULL,
  `npp`       DECIMAL(10, 4) DEFAULT NULL,
  `nsp`       DECIMAL(10, 4) DEFAULT NULL,
  `nspp`      DECIMAL(10, 4) DEFAULT NULL,
  `oa`        INT(11) DEFAULT NULL,
  `ord`       DATE DEFAULT NULL,
  `na`        INT(11) DEFAULT NULL,
  `nrd`       DATE DEFAULT NULL,
  `errMsg`    VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  AUTO_INCREMENT =8700
  DEFAULT CHARSET =utf8;

CREATE TABLE `store_attribute` (
  `id`          INT(11)     NOT NULL AUTO_INCREMENT,
  `name`        VARCHAR(50) NOT NULL,
  `unit`        VARCHAR(10) DEFAULT NULL,
  `description` VARCHAR(255) DEFAULT NULL,
  `type`        TINYINT(4) DEFAULT NULL,
  `priority`    TINYINT(4) DEFAULT '0',
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  AUTO_INCREMENT =28
  DEFAULT CHARSET =utf8;

CREATE TABLE `store_basket` (
  `pid`            BIGINT(20) NOT NULL,
  `creationTime`   DATETIME   NOT NULL,
  `updatingTime`   DATETIME   NOT NULL,
  `coupon`         VARCHAR(10) DEFAULT NULL,
  `expirationDays` INT(11) DEFAULT NULL,
  PRIMARY KEY (`pid`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

CREATE TABLE `store_category` (
  `id`          INT(11)      NOT NULL AUTO_INCREMENT,
  `name`        VARCHAR(100) NOT NULL,
  `symbolic`    VARCHAR(155) DEFAULT NULL,
  `description` TEXT,
  `parent`      INT(11) DEFAULT NULL,
  `position`    TINYINT(4)   NOT NULL,
  `active`      INT(1) DEFAULT '0',
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  AUTO_INCREMENT =25
  DEFAULT CHARSET =utf8;

CREATE TABLE `store_category_attribute` (
  `id`          INT(11) NOT NULL AUTO_INCREMENT,
  `categoryId`  INT(11) NOT NULL,
  `attributeId` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_store_category_attribute_store_category1_idx` (`categoryId`),
  KEY `fk_store_category_attribute_store_attribute1_idx` (`attributeId`),
  CONSTRAINT `fk_store_category_attribute_store_attribute1` FOREIGN KEY (`attributeId`) REFERENCES `store_attribute` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_store_category_attribute_store_category1` FOREIGN KEY (`categoryId`) REFERENCES `store_category` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
  ENGINE =InnoDB
  AUTO_INCREMENT =41
  DEFAULT CHARSET =utf8;

CREATE TABLE `store_category_parameter` (
  `id`          INT(11) NOT NULL AUTO_INCREMENT,
  `categoryId`  INT(11) DEFAULT NULL,
  `attributeId` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_idx` (`categoryId`),
  KEY `attribute_idx` (`attributeId`),
  CONSTRAINT `attribute` FOREIGN KEY (`attributeId`) REFERENCES `store_attribute` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `category` FOREIGN KEY (`categoryId`) REFERENCES `store_category` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
  ENGINE =InnoDB
  AUTO_INCREMENT =52
  DEFAULT CHARSET =utf8;

CREATE TABLE `store_category_parameter_value` (
  `id`          INT(11)     NOT NULL AUTO_INCREMENT,
  `parameterId` INT(11)     NOT NULL,
  `value`       VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `parameter_idx` (`parameterId`),
  CONSTRAINT `parameter` FOREIGN KEY (`parameterId`) REFERENCES `store_category_parameter` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
  ENGINE =InnoDB
  AUTO_INCREMENT =122
  DEFAULT CHARSET =utf8;

CREATE TABLE `store_coupon` (
  `code`            VARCHAR(10) NOT NULL,
  `creation`        DATETIME    NOT NULL,
  `termination`     DATETIME DEFAULT NULL,
  `amount`          DOUBLE      NOT NULL,
  `amountType`      TINYINT(4)  NOT NULL,
  `reference`       INT(11) DEFAULT NULL,
  `referenceType`   TINYINT(4)  NOT NULL,
  `utilizedCount`   SMALLINT(6) DEFAULT '0',
  `allocatedCount`  SMALLINT(6) DEFAULT '0',
  `lastUtilization` DATETIME DEFAULT NULL,
  PRIMARY KEY (`code`),
  KEY `reference_index` (`reference`),
  KEY `reference_type_index` (`referenceType`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

CREATE TABLE `store_group` (
  `id`         INT(11)      NOT NULL AUTO_INCREMENT,
  `name`       VARCHAR(145) NOT NULL,
  `type`       INT(2)       NOT NULL DEFAULT '0',
  `categoryId` INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_foreign_idx` (`categoryId`),
  CONSTRAINT `category_foreign` FOREIGN KEY (`categoryId`) REFERENCES `store_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE =InnoDB
  AUTO_INCREMENT =153
  DEFAULT CHARSET =utf8;

CREATE TABLE `store_order` (
  `id`                    BIGINT(20)     NOT NULL AUTO_INCREMENT,
  `buyer`                 BIGINT(20) DEFAULT NULL,
  `token`                 VARCHAR(20) DEFAULT NULL,
  `amount`                DECIMAL(10, 4) NOT NULL,
  `discount`              DECIMAL(10, 4) NOT NULL DEFAULT '0.0000',
  `shipment`              DECIMAL(10, 4) NOT NULL,
  `shipmentType`          TINYINT(4)     NOT NULL,
  `coupon`                VARCHAR(10) DEFAULT NULL,
  `created`               DATETIME       NOT NULL,
  `shipped`               DATETIME DEFAULT NULL,
  `closed`                DATETIME DEFAULT NULL,
  `payer`                 VARCHAR(127) DEFAULT NULL,
  `payerName`             VARCHAR(255) DEFAULT NULL,
  `payerNote`             VARCHAR(255) DEFAULT NULL,
  `paymentId`             VARCHAR(20) DEFAULT NULL,
  `tracking`              INT(1)         NOT NULL,
  `firstName`             VARCHAR(120) DEFAULT NULL,
  `lastName`              VARCHAR(245) DEFAULT NULL,
  `region`                VARCHAR(120) DEFAULT NULL,
  `city`                  VARCHAR(120) DEFAULT NULL,
  `postcode`              VARCHAR(10) DEFAULT NULL,
  `location`              VARCHAR(250) DEFAULT NULL,
  `state`                 INT(11)        NOT NULL,
  `referenceTracking`     VARCHAR(45) DEFAULT NULL,
  `chinaMailTracking`     VARCHAR(45) DEFAULT NULL,
  `internationalTracking` VARCHAR(45) DEFAULT NULL,
  `exceptedResume`        DATETIME DEFAULT NULL,
  `refundToken`           VARCHAR(45) DEFAULT NULL,
  `commentary`            VARCHAR(255) DEFAULT NULL,
  `timestamp`             DATETIME       NOT NULL,
  PRIMARY KEY (`id`),
  KEY `INDEX_state` (`state`),
  KEY `INDEX_token` (`token`)
)
  ENGINE =InnoDB
  AUTO_INCREMENT =96
  DEFAULT CHARSET =utf8;

CREATE TABLE `store_product` (
  `id`                 INT(11)      NOT NULL AUTO_INCREMENT,
  `name`               VARCHAR(100) NOT NULL,
  `symbolic`           VARCHAR(155) DEFAULT NULL,
  `description`        LONGTEXT     NOT NULL,
  `categoryId`         INT(11)      NOT NULL,
  `weight`             DOUBLE       NOT NULL,
  `price`              DOUBLE       NOT NULL,
  `primordialPrice`    DOUBLE DEFAULT NULL,
  `registrationDate`   DATETIME     NOT NULL,
  `soldCount`          INT(11)      NOT NULL DEFAULT '0',
  `stockLeftovers`     INT(11) DEFAULT NULL,
  `stockRestockDate`   DATE DEFAULT NULL,
  `buyPrice`           DOUBLE       NOT NULL,
  `buyPrimordialPrice` DOUBLE DEFAULT NULL,
  `wholesaler`         TINYINT(4) DEFAULT NULL,
  `referenceUri`       VARCHAR(255) DEFAULT NULL,
  `referenceCode`      VARCHAR(50) DEFAULT NULL,
  `validationDate`     DATETIME DEFAULT NULL,
  `previewImageId`     VARCHAR(45) DEFAULT NULL,
  `comment`            VARCHAR(100) DEFAULT NULL,
  `state`              SMALLINT(6)  NOT NULL,
  `recommended`        INT(1)       NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `state_global_index` (`state`),
  KEY `price_global_index` (`price`),
  KEY `fk_store_product_store_category1_idx` (`categoryId`),
  KEY `registration_global_index` (`registrationDate`),
  KEY `stock_sold_index` (`soldCount`),
  KEY `recommended_index` (`recommended`),
  FULLTEXT KEY `name` (`name`, `description`),
  CONSTRAINT `fk_store_product_store_category1` FOREIGN KEY (`categoryId`) REFERENCES `store_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE =InnoDB
  AUTO_INCREMENT =10414
  DEFAULT CHARSET =utf8;

CREATE TABLE `store_product_image` (
  `id`        INT(11)     NOT NULL AUTO_INCREMENT,
  `productId` INT(11)     NOT NULL,
  `imageId`   VARCHAR(45) NOT NULL,
  `position`  TINYINT(4)  NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_store_product_image_store_product1_idx` (`productId`),
  KEY `position_order_index` (`position`)
    COMMENT 'Used in order by',
  CONSTRAINT `fk_store_product_image_store_product1` FOREIGN KEY (`productId`) REFERENCES `store_product` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
  ENGINE =InnoDB
  AUTO_INCREMENT =49250
  DEFAULT CHARSET =utf8;

CREATE TABLE `store_product_option` (
  `id`          INT(11)    NOT NULL AUTO_INCREMENT,
  `productId`   INT(11)    NOT NULL,
  `attributeId` INT(11)    NOT NULL,
  `value`       VARCHAR(45) DEFAULT NULL,
  `position`    TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_store_product_option_store_product1_idx` (`productId`),
  KEY `fk_store_product_option_store_attribute1_idx` (`attributeId`),
  KEY `position_order_index` (`position`)
    COMMENT 'Used in order by',
  CONSTRAINT `fk_store_product_option_store_attribute1` FOREIGN KEY (`attributeId`) REFERENCES `store_attribute` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_store_product_option_store_product1` FOREIGN KEY (`productId`) REFERENCES `store_product` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
  ENGINE =InnoDB
  AUTO_INCREMENT =1375
  DEFAULT CHARSET =utf8;

CREATE TABLE `store_product_property` (
  `id`          INT(11)    NOT NULL AUTO_INCREMENT,
  `productId`   INT(11)    NOT NULL,
  `attributeId` INT(11)    NOT NULL,
  `svalue`      VARCHAR(45) DEFAULT NULL,
  `ivalue`      INT(11) DEFAULT NULL,
  `bvalue`      INT(1) DEFAULT NULL,
  `position`    TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `position_order_index` (`position`)
    COMMENT 'used in order by',
  KEY `fk_store_product_property_store_product1` (`productId`),
  KEY `fk_store_product_property_store_attribute1` (`attributeId`),
  KEY `property_value_index` (`svalue`),
  CONSTRAINT `fk_store_product_property_store_attribute1` FOREIGN KEY (`attributeId`) REFERENCES `store_attribute` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_store_product_property_store_product1` FOREIGN KEY (`productId`) REFERENCES `store_product` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
  ENGINE =InnoDB
  AUTO_INCREMENT =10238
  DEFAULT CHARSET =utf8;

CREATE TABLE `store_product_relationship` (
  `productId` INT(11)     NOT NULL,
  `groupId`   INT(11)     NOT NULL,
  `type`      SMALLINT(6) NOT NULL,
  PRIMARY KEY (`productId`, `groupId`, `type`),
  KEY `fk_store_product_relationship_store_group1_idx` (`groupId`),
  CONSTRAINT `fk_store_product_relationship_store_group1` FOREIGN KEY (`groupId`) REFERENCES `store_group` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_store_product_relationship_store_product1` FOREIGN KEY (`productId`) REFERENCES `store_product` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

CREATE TABLE `store_product_tracking` (
  `id`           INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `registration` DATETIME         NOT NULL,
  `productId`    INT(11)          NOT NULL,
  `type`         INT(2)           NOT NULL,
  `personId`     BIGINT(20) DEFAULT NULL,
  `personEmail`  VARCHAR(145) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `email_index` (`personEmail`),
  KEY `product_foreign_idx` (`productId`),
  KEY `person_foreign_idx` (`personId`),
  CONSTRAINT `person_foreign` FOREIGN KEY (`personId`) REFERENCES `account_personality` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `product_foreign` FOREIGN KEY (`productId`) REFERENCES `store_product` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
  ENGINE =InnoDB
  AUTO_INCREMENT =55
  DEFAULT CHARSET =utf8;

CREATE TABLE `store_showcase` (
  `section`       INT(11) NOT NULL,
  `position`      INT(11) NOT NULL,
  `name`          VARCHAR(45) DEFAULT NULL,
  `uri`           VARCHAR(145) DEFAULT NULL,
  `category`      INT(11) DEFAULT NULL,
  `arrival`       TINYINT(4) DEFAULT NULL,
  `subcategories` TINYINT(4) DEFAULT NULL,
  PRIMARY KEY (`position`, `section`),
  KEY `fk_store_showcase_store_category1_idx` (`category`),
  CONSTRAINT `fk_store_showcase_store_category1` FOREIGN KEY (`category`) REFERENCES `store_category` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

CREATE TABLE `report_mistake` (
  `id`          INT(11)    NOT NULL AUTO_INCREMENT,
  `productId`   INT(11)    NOT NULL,
  `description` TEXT       NOT NULL,
  `scope`       TINYINT(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_idx` (`productId`),
  CONSTRAINT `product` FOREIGN KEY (`productId`) REFERENCES `store_product` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

CREATE TABLE `store_basket_item` (
  `number`   INT(11)    NOT NULL,
  `basket`   BIGINT(20) NOT NULL,
  `product`  INT(11)    NOT NULL,
  `quantity` INT(11)    NOT NULL,
  PRIMARY KEY (`number`, `basket`),
  KEY `fk_store_basket_item_store_basket1_idx` (`basket`),
  KEY `fk_store_basket_item_store_product1_idx` (`product`),
  CONSTRAINT `fk_store_basket_item_store_basket1` FOREIGN KEY (`basket`) REFERENCES `store_basket` (`pid`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_store_basket_item_store_product1` FOREIGN KEY (`product`) REFERENCES `store_product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

CREATE TABLE `store_basket_option` (
  `basketId`     BIGINT(20) NOT NULL,
  `basketItemId` INT(11)    NOT NULL,
  `attributeId`  INT(11)    NOT NULL,
  `value`        VARCHAR(45) DEFAULT NULL,
  `position`     TINYINT(4) NOT NULL,
  PRIMARY KEY (`basketId`, `basketItemId`, `attributeId`),
  KEY `fk_store_basket_option_store_basket_item1_idx` (`basketItemId`),
  KEY `fk_store_basket_option_store_attribute1_idx` (`attributeId`),
  CONSTRAINT `fk_store_basket_option_store_attribute1` FOREIGN KEY (`attributeId`) REFERENCES `store_attribute` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_store_basket_option_store_basket1` FOREIGN KEY (`basketId`) REFERENCES `store_basket` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_store_basket_option_store_basket_item1` FOREIGN KEY (`basketItemId`) REFERENCES `store_basket_item` (`number`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

CREATE TABLE `store_group_item` (
  `groupId`   INT(11) NOT NULL,
  `productId` INT(11) NOT NULL,
  PRIMARY KEY (`groupId`, `productId`),
  KEY `fk_store_group_item_store_product1_idx` (`productId`),
  CONSTRAINT `fk_store_group_item_store_group1` FOREIGN KEY (`groupId`) REFERENCES `store_group` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_store_group_item_store_product1` FOREIGN KEY (`productId`) REFERENCES `store_product` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

CREATE TABLE `store_order_item` (
  `orderId`  BIGINT(20)     NOT NULL,
  `number`   INT(11)        NOT NULL,
  `product`  INT(11)        NOT NULL,
  `quantity` INT(11)        NOT NULL,
  `amount`   DECIMAL(10, 4) NOT NULL,
  `weight`   DECIMAL(10, 4) NOT NULL,
  `options`  VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`orderId`, `number`),
  KEY `fk_store_order_item_store_product1_idx` (`product`),
  CONSTRAINT `fk_store_order_item_store_order1` FOREIGN KEY (`orderId`) REFERENCES `store_order` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_store_order_item_store_product1` FOREIGN KEY (`product`) REFERENCES `store_product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;

CREATE TABLE `store_order_log` (
  `id`         BIGINT(20) NOT NULL AUTO_INCREMENT,
  `orderId`    BIGINT(20) NOT NULL,
  `timestamp`  DATETIME   NOT NULL,
  `orderState` TINYINT(4) NOT NULL,
  `parameter`  VARCHAR(255) DEFAULT NULL,
  `commentary` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_store_order_log_store_order1` (`orderId`),
  CONSTRAINT `fk_store_order_log_store_order1` FOREIGN KEY (`orderId`) REFERENCES `store_order` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
)
  ENGINE =InnoDB
  AUTO_INCREMENT =227
  DEFAULT CHARSET =utf8;


CREATE TABLE `system_version` (
  `version`      INT(11)   NOT NULL,
  `modification` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`version`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8;
