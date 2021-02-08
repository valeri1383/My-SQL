# 1
CREATE TABLE `mountains` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(40) NOT NULL
);

CREATE TABLE `peaks` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(40) NOT NULL,
    `mountain_id` INT NOT NULL,
    CONSTRAINT `fk_peaks_mountains` FOREIGN KEY (`mountain_id`)
        REFERENCES `mountains` (`id`)
);


# 2
SELECT 
    `driver_id`,
    `vehicle_type`,
    CONCAT(`first_name`, ' ', `last_name`) AS 'driver_name'
FROM
    `vehicles` AS `v`
        JOIN
    `campers` AS `c` ON `v`.`driver_id` = `c`.`id`


# 3
SELECT 
    `starting_point` AS 'route_starting_point',
    `end_point` AS 'route_ending_point',
    `leader_id`,
    CONCAT(`c`.`first_name`, ' ', `c`.`last_name`) AS `leader_name`
FROM
    `routes` AS `r`
        JOIN
    `campers` AS `c` ON `r`.`leader_id` = `c`.`id`;


# 4
CREATE TABLE `mountains` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(40) NOT NULL
    
);

CREATE TABLE `peaks` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(40) NOT NULL,
    `mountain_id` INT NOT NULL,
    CONSTRAINT `fk_peaks_mountains` FOREIGN KEY (`mountain_id`)
        REFERENCES `mountains` (`id`)
        ON DELETE CASCADE
);


# 5
CREATE TABLE `clients` (
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `client_name` VARCHAR(100),
    `project_id` INT(11)
);

CREATE TABLE `projects` (
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `client_id` INT(11),
    `project_lead_id` INT(11)
);

CREATE TABLE `employees` (
    `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(30),
    `last_name` VARCHAR(30),
    `project_id` INT(11)
);

ALTER TABLE `projects` 
ADD CONSTRAINT `fk_projects_clients`
FOREIGN KEY (`client_id`) REFERENCES `clients`(`id`),
ADD CONSTRAINT `fk_projects_employees`
FOREIGN KEY (`project_lead_id`) REFERENCES `employees`(`id`);

ALTER TABLE `clients` 
ADD CONSTRAINT `fk_clients_projects`
FOREIGN KEY (`project_id`) REFERENCES `projects`(`id`);

ALTER TABLE `employees` 
ADD CONSTRAINT `fk_employees_projects`
FOREIGN KEY (`project_id`) REFERENCES `projects`(`id`);