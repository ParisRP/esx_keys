CREATE TABLE IF NOT EXISTS `keys_inventory_items` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `inventory_name` VARCHAR(100) NOT NULL,    -- Nom de l'inventaire ('vehicle_keys' ou 'property_keys')
    `name` VARCHAR(100) NOT NULL,               -- Nom de la clé (ex : 'car_key_ABC123')
    `plate` VARCHAR(20) NOT NULL,               -- Plaque du véhicule (si applicable)
    `count` INT NOT NULL,                       -- Nombre d'exemplaires (généralement 1)
    `owner` VARCHAR(60) DEFAULT NULL,           -- ID du joueur propriétaire de la clé
    `shared_with` TEXT DEFAULT NULL,            -- Liste des joueurs avec qui la clé est partagée (stockée sous forme de chaîne séparée par des virgules)
    PRIMARY KEY (`id`),
    INDEX `index_keys_inventory_items_inventory_name_name_plate` (`inventory_name`, `name`, `plate`),
    INDEX `index_keys_inventory_items_inventory_name_name_owner` (`inventory_name`, `name`, `owner`),
    INDEX `index_keys_inventory_inventory_name` (`inventory_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
