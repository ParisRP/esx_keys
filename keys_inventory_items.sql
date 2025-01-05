CREATE TABLE IF NOT EXISTS `keys_inventory_items` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `inventory_name` VARCHAR(100) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `count` INT NOT NULL,
    `owner` VARCHAR(60) NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `index_keys_inventory_items_inventory_name_name` (`inventory_name`, `name`),
    INDEX `index_keys_inventory_items_inventory_name_name_owner` (`inventory_name`, `name`, `owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
