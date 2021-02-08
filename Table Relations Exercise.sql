# 1
CREATE TABLE `persons` (
    `person_id` INT PRIMARY KEY,
    `first_name` VARCHAR(30) NOT NULL,
    `salary` DECIMAL(10 , 2 ) NOT NULL,
    `passport_id` INT UNIQUE NOT NULL,
    CONSTRAINT `fk_persons_passports` FOREIGN KEY (`passport_id`)
        REFERENCES `passports` (`passport_id`)
);

CREATE TABLE `passports` (
    `passport_id` INT UNIQUE PRIMARY KEY,
    `passport_number` VARCHAR(8) NOT NULL
);

INSERT INTO `persons` VALUES 
(1, 'Roberto', 43300.00, 102),
(2, 'Tom', 56100.00, 103),
(3, 'Yana', 60200.00, 101);

INSERT INTO `passports` VALUES
(101, 'N34FG21B'),
(102, 'K65LO4R7'),
(103, 'ZE657QP2');


# 2
CREATE TABLE `manufacturers` (
    `manufacturer_id` INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    `name` VARCHAR(30) NOT NULL,
    `established_on` DATE NOT NULL
);

CREATE TABLE `models` (
    `model_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(30) NOT NULL,
    `manufacturer_id` INT NOT NULL,
    CONSTRAINT `fk_models_manufacturers` FOREIGN KEY (`manufacturer_id`)
        REFERENCES `manufacturers` (`manufacturer_id`)
);

INSERT 
	INTO `manufacturers` (`name`, `established_on`)
	VALUES 
		('BMW', '1916-03-01'),
		('Tesla', '2003-01-01'),
		('Lada', '1966-05-01');

INSERT
	INTO `models` (`name`, `manufacturer_id`)
    VALUES
		('X1', 1),
		('i6', 1),
		('Model S', 2),
		('Model X', 2),
		('Model 3', 2),
		('Nova', 3);


# 3
CREATE TABLE `students` (
    `student_id` INT PRIMARY KEY NOT NULL UNIQUE,
    `name` VARCHAR(30) NOT NULL
    );
    
CREATE TABLE `exams` (
    `exam_id` INT PRIMARY KEY UNIQUE NOT NULL ,
    `name` VARCHAR(30) NOT NULL
    );

CREATE TABLE `students_exams`(
	`student_id` INT NOT NULL ,
    `exam_id` INT NOT NULL ,
    CONSTRAINT `pk_student_exam`
    PRIMARY KEY (`student_id`, `exam_id`)
);

INSERT 
	INTO `students` 
	VALUES 
		(1,'Mila'), 
        (2,'Toni'), 
        (3,'Ron');

INSERT 
	INTO `exams` 
	VALUES 
		(101,'Spring MVC'), 
        (102,'Neo4j'), 
        (103,'Oracle 11g');

INSERT 
	INTO `students_exams`
    VALUES  
		(1, 101),
		(1, 102),
		(2, 101),
		(3, 103),
		(2, 102),
		(2, 103);

ALTER TABLE `students_exams`
ADD CONSTRAINT `fk_students`
    FOREIGN KEY (`student_id`) REFERENCES `students`(`student_id`),
ADD CONSTRAINT `fk_exams`
    FOREIGN KEY (`exam_id`) REFERENCES `exams`(`exam_id`);


# 4
CREATE TABLE `teachers` (
    `teacher_id` INT PRIMARY KEY NOT NULL,
    `name` VARCHAR(30) NOT NULL,
    `manager_id` INT,
    CONSTRAINT `fk_manager_teacher` FOREIGN KEY (`manager_id`)
        REFERENCES `teachers` (`teacher_id`)
);


# 5
CREATE TABLE `cities` (
    `city_id` INT(11) PRIMARY KEY NOT NULL,
    `name` VARCHAR(50)
);

CREATE TABLE `customers` (
    `customer_id` INT(11) PRIMARY KEY NOT NULL,
    `name` VARCHAR(50),
    `birthday` DATE,
    `city_id` INT(11),
    CONSTRAINT `fk_customers_cities` FOREIGN KEY (`city_id`)
        REFERENCES `cities` (`city_id`)
);

CREATE TABLE `orders` (
    `order_id` INT(11) PRIMARY KEY NOT NULL,
    `customer_id` INT(11),
    CONSTRAINT `fk_orders_customers` FOREIGN KEY (`customer_id`)
        REFERENCES `customers` (`customer_id`)
);

CREATE TABLE `item_type` (
    `item_type_id` INT(11) PRIMARY KEY NOT NULL,
    `name` VARCHAR(50)
);

CREATE TABLE `items` (
    `item_id` INT(11) PRIMARY KEY NOT NULL,
    `name` VARCHAR(50),
    `item_type_id` INT(11),
    CONSTRAINT `fk_items_item_types` FOREIGN KEY (`item_type_id`)
        REFERENCES `item_type` (`item_type_id`)
);

CREATE TABLE `order_items` (
    `order_id` INT(11) NOT NULL,
    `item_id` INT(11) NOT NULL,
    CONSTRAINT `pk_order_item_id` PRIMARY KEY (`order_id` , `item_id`),
    CONSTRAINT `fk_order_item_items` FOREIGN KEY (`item_id`)
        REFERENCES `items` (`item_id`),
    CONSTRAINT `fk_order_item_orders` FOREIGN KEY (`order_id`)
        REFERENCES `orders` (`order_id`)
);


# 6
CREATE DATABASE `university_practice`;
USE `university_practice`;

CREATE TABLE `majors` (
    `major_id` INT(11) PRIMARY KEY NOT NULL,
    `name` VARCHAR(50)
);

CREATE TABLE `students` (
    `student_id` INT(11) PRIMARY KEY NOT NULL,
    `student_number` VARCHAR(12),
    `student_name` VARCHAR(50),
    `major_id` INT(11) NOT NULL,
    CONSTRAINT `fk_students_majors` FOREIGN KEY (`major_id`)
        REFERENCES `majors` (`major_id`)
);

CREATE TABLE `payments` (
    `payment_id` INT(11) PRIMARY KEY NOT NULL,
    `payment_date` DATE,
    `payment_amounte` DECIMAL(8,2),
    `student_id` INT(11) NOT NULL,
    CONSTRAINT `fk_payments_students` FOREIGN KEY (`student_id`)
        REFERENCES `students` (`student_id`)
);

CREATE TABLE `subjects` (
    `subject_id` INT(11) PRIMARY KEY NOT NULL,
    `subject_name` VARCHAR(50)
);

CREATE TABLE `agenda` (
    `student_id` INT(11) NOT NULL,
    `subject_id` INT(11) NOT NULL,
    CONSTRAINT `pk_agenda`
    PRIMARY KEY (`student_id` , `subject_id`),
    CONSTRAINT `fk_agenda_students`
    FOREIGN KEY (`student_id`)
        REFERENCES `students` (`student_id`),
    CONSTRAINT `fk_agenda_subjects` FOREIGN KEY (`subject_id`)
        REFERENCES `subjects` (`subject_id`)
);


# 9
SELECT `mountain_range`, `peak_name`, `elevation` FROM `peaks` AS `p`
JOIN `mountains` AS `m`
ON `p`.`mountain_id` = `m`.`id`
WHERE `m`.`mountain_range` = 'Rila'
ORDER BY `p`.`elevation` DESC ;
