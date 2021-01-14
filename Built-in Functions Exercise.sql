# 1
SELECT `first_name`, `last_name` FROM `employees`
WHERE `first_name` LIKE ('Sa%')
ORDER BY `employee_id`;

# 2
SELECT `first_name`, `last_name` FROM `employees`
WHERE `last_name` LIKE ('%ei%')
ORDER BY `employee_id`;

# 3
SELECT `first_name` FROM `employees`
WHERE `department_id` in(3, 10) AND
YEAR(`hire_date`) >= 1995 AND
YEAR(`hire_date`) <= 2005
ORDER BY `employee_id`;

# 4
SELECT `first_name`, `last_name` FROM `employees`
WHERE `job_title` NOT LIKE ('%engineer%')
ORDER BY `employee_id`;

# 5
SELECT `name` FROM `towns`
WHERE char_length(`name`) BETWEEN 5 AND 6
ORDER BY `name`;

# 6
SELECT `name` FROM `towns`
WHERE `name` LIKE ('M%') OR
`name` LIKE ('K%') OR
`name` LIKE ('B%') OR
`name` LIKE ('E%')
ORDER BY `name`;

# 7
SELECT `town_id`,`name` FROM `towns`
WHERE `name` NOT LIKE ('R%') AND
`name` NOT LIKE ('B%') AND
`name` NOT LIKE ('D%')
ORDER BY `name`;

# 8
CREATE VIEW `v_employees_hired_after_2000` AS
SELECT `first_name`, `last_name` from `employees`
WHERE YEAR(`hire_date`) > 2000;

SELECT * FROM  `v_employees_hired_after_2000`;

# 9
SELECT `first_name`, `last_name` FROM `employees`
WHERE length(`last_name`) = 5;

# 10
SELECT `country_name`, `iso_code` FROM `countries`
WHERE (CHAR_LENGTH(`country_name`) - CHAR_LENGTH(REPLACE(LOWER(`country_name`), 'a', ''))) >= 3
ORDER BY `iso_code`;

# 11
SELECT `peak_name`, `river_name`, LOWER(CONCAT(`peak_name`, SUBSTRING(`river_name`, 2))) AS 'mix'
FROM `peaks`, `rivers`
WHERE LOWER(RIGHT(`peak_name`, 1)) = LOWER(LEFT(`river_name`, 1))
ORDER BY `mix`

# 12
SELECT `name`, DATE_FORMAT(`start`, '%Y-%m-%d') AS 'start' FROM `games`
WHERE YEAR(`start`) between 2011 AND 2012
ORDER BY `start`, `name`
LIMIT 50;

# 13
SELECT `user_name`, SUBSTRING_INDEX(`email`, '@', -1) AS 'Email Provider'
FROM `users`
ORDER BY `Email Provider`, `user_name`;


# 14
SELECT `user_name`, `ip_address` FROM `users`
WHERE `ip_address` LIKE ('%___.1%.%.___')
ORDER BY `user_name`;

# 15
SELECT `name` AS 'game',
CASE
WHEN HOUR(`start`) BETWEEN 0 AND 11 THEN 'Morning'
WHEN HOUR(`start`) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END AS 'Part of the day',
CASE 
WHEN `duration` <= 3 THEN 'Extra Short'
WHEN `duration` BETWEEN 4 AND 6 THEN 'Short'
WHEN `duration` BETWEEN 7 AND 10 THEN 'Lond'
ELSE 'Extra Long'
END 'Duration'
FROM `games`
ORDER BY `name`;

# 16
SELECT `product_name`, `order_date`,
DATE_ADD(`order_date`, INTERVAL 3 DAY) AS 'pay_due',
DATE_ADD(`order_date`, INTERVAL 1 MONTH) AS 'deliver_due'
FROM `orders`;









