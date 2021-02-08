# 1
SELECT e.employee_id, concat(e.first_name, ' ' , e.last_name) AS 'full_name', d.department_id, d.name AS 'department_name' 
FROM departments AS d
JOIN employees AS e
ON e.employee_id = d.manager_id
ORDER BY e.employee_id
LIMIT 5;


# 2
SELECT t.town_id, t.name, a.address_text FROM towns AS t
JOIN addresses AS a
ON t.town_id = a.town_id
WHERE t.name in ('San Francisco', 'Sofia', 'Carnation')
ORDER BY t.town_id, a.address_id;


# 3
SELECT employee_id, first_name, last_name, department_id, salary FROM employees AS e
WHERE manager_id is NULL;

 
 # 4
 SELECT COUNT(employee_id) AS 'count' FROM employees
 WHERE salary > (SELECT AVG(salary) FROM employees);



















