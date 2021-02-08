# 1
SELECT `department_id`, COUNT(*) AS `Numbers of employees` FROM `employees`
GROUP BY `department_id`
ORDER BY `department_id`;

# 2
SELECT `department_id`, ROUND(AVG(`salary`), 2) AS 'Average Salary' FROM `employees`
GROUP BY `department_id`
ORDER BY `department_id`;

# 3
SELECT `department_id`, ROUND(MIN(`salary`), 2) AS 'Min Salary' FROM `employees`
GROUP BY `department_id`
HAVING MIN(`salary`) > 800;

# 4
SELECT COUNT(`category_id`) AS `Appetizers` FROM `products`
WHERE `category_id` = 2 and `price` > 8
GROUP BY `category_id`;

# 5
SELECT `category_id`, 
ROUND(AVG(`price`), 2) AS 'Average Price',
ROUND(MIN(`price`), 2) AS 'Cheapest  Product',
ROUND(MAX(`price`), 2) AS 'Most Expensive  Product'
FROM `products`
GROUP BY `category_id`;

