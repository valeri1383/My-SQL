CREATE DATABASE gamebar;

USE GAMEBAR;

CREATE TABLE employees(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL
);

CREATE TABLE categories(
id INT PRIMARY KEY auto_increment,
name VARCHAR(50) NOT NULL
);

CREATE TABLE products(
id INT PRIMARY KEY auto_increment,
name VARCHAR(50) NOT NULL,
category_id INT NOT NULL
);

INSERT INTO employees(first_name, last_name) VALUES ('Peter', 'Petrov'), ('Ivan', 'Ivanov'), ('Ico', 'Icov');

ALTER TABLE employees ADD COLUMN middle_name VARCHAR(50) NOT NULL;

ALTER TABLE products ADD constraint fk_products_category foreign key (category_id) REFERENCES categories(id);

ALTER TABLE employees MODIfy column middle_name VARCHAR(100);

DROP DATABASE gamebar;


