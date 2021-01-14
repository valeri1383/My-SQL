# 1 
SELECT `title` FROM `books`
WHERE substring(`title`, 1, 3) = 'The'
ORDER BY `id`;

# 2
SELECT replace(`title`, 'The','***') AS `title` FROM `books`
WHERE substring(`title`, 1, 3) = 'The'
ORDER BY `id`; 

# 3
SELECT round(SUM(`cost`), 2) AS `Cost` FROM `books`;

# 4
SELECT concat(`first_name`,' ', `last_name`) AS `Full Name`,
TIMESTAMPDIFF (DAY,`born`,`died`) AS `Days Lived`
FROM `authors`;

# 5
SELECT `title` FROM `books`
WHERE `title` LIKE ('Harry Potter%')
ORDER BY `id`;