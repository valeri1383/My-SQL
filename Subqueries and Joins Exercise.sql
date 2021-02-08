# 1
SELECT e.employee_id, e.job_title, a.address_id, a.address_text FROM employees AS e
JOIN addresses AS a
ON e.address_id = a.address_id
ORDER BY a.address_id
LIMIT 5;


# 2
SELECT e.first_name, e.last_name, t.name , a.address_text FROM employees AS e
JOIN addresses AS a
ON e.address_id = a.address_id
JOIN towns AS t
ON a.town_id = t.town_id
ORDER BY e.first_name, e.last_name
LIMIT 5;


# 3
SELECT e.employee_id, e.first_name, e.last_name, d.name  FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
WHERE d.name = 'Sales'
ORDER BY e.employee_id DESC;


# 4
SELECT e.employee_id, e.first_name, e.salary, d.name  FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
WHERE e.salary > 15000
ORDER BY d.department_id DESC
LIMIT 5;

# 5
SELECT e.employee_id, e.first_name FROM  employees AS e
LEFT JOIN employees_projects AS ep
ON e.employee_id = ep.employee_id
WHERE ep.project_id is NULL
ORDER BY ep.employee_id DESC
LIMIT 3;


# 6
SELECT e.first_name, e.last_name, e.hire_date, d.name AS 'dept_name'  FROM employees AS e
JOIN departments AS d
ON e.department_id = d.department_id
WHERE hire_date > '1999-01-01' AND d.name IN ('Sales', 'Finance')
ORDER BY e.hire_date;


# 7
SELECT e.employee_id, e.first_name, p.name AS 'project_name' FROM employees AS e
JOIN employees_projects AS ep
ON e.employee_id = ep.employee_id
JOIN projects AS p
ON ep.project_id = p.project_id
WHERE p.start_date > '2002-09-13' and p.end_date IS NULL
ORDER BY e.first_name, p.name
LIMIT 5;


# 8
SELECT e.employee_id, e.first_name, IF(YEAR(p.start_date) >= 2005, NULL, p.name) AS 'project_name' FROM employees AS e
JOIN employees_projects AS ep
ON e.employee_id = ep.employee_id
JOIN projects AS p
ON ep.project_id = p.project_id
WHERE e.employee_id = 24
ORDER BY p.name;


# 9
SELECT e.employee_id, e.first_name, e.manager_id, e2.first_name FROM employees AS e
JOIN employees AS e2
ON e.manager_id = e2.employee_id
WHERE e2.employee_id in (3,7)
ORDER BY e.first_name;


# 10
SELECT e.employee_id, concat(e.first_name, ' ' ,e.last_name) AS 'employee_name' ,
concat(m.first_name, ' ' , m.last_name) AS 'manager_name', 
d.name AS 'department_name' FROM employees AS e
JOIN employees AS m
ON e.manager_id = m.employee_id
JOIN departments AS d
ON e.department_id = d.department_id
ORDER BY e.employee_id
LIMIT 5;


# 11
SELECT AVG(salary) FROM employees
GROUP BY department_id
ORDER BY AVG(salary)
LIMIT 1;


# 12
SELECT c.country_code, m.mountain_range, p.peak_name, p.elevation FROM countries AS c
JOIN mountains_countries AS mc
ON c.country_code = mc.country_code
JOIN mountains AS m
ON mc.mountain_id = m.id
JOIN peaks AS p
ON m.id = p.mountain_id
WHERE c.country_name = 'Bulgaria' AND p.elevation > 2835
ORDER BY p.elevation DESC;


# 13
SELECT 
    c.country_code, COUNT(mc.mountain_id) AS 'mountain_range'
FROM
    `countries` AS c
        JOIN
    `mountains_countries` AS mc ON c.country_code = mc.country_code
WHERE
    c.country_name IN ('United States' , 'Russia', 'Bulgaria')
GROUP BY c.country_code
ORDER BY `mountain_range` DESC;


# 14
SELECT c.country_name, r.river_name FROM countries AS c
LEFT JOIN countries_rivers AS cr
ON c.country_code = cr.country_code
LEFT JOIN rivers AS r
ON cr.river_id = r.id
WHERE c.continent_code = 'AF'
ORDER BY c.country_name
LIMIT 5;














