CREATE TABLE IF NOT EXISTS `user_vehicle_keys` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `player_id` INT NOT NULL,
    `vehicle_plate` VARCHAR(15) NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`player_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
