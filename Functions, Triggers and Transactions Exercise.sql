# 1
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
SELECT e.first_name, e.last_name FROM employees AS e
WHERE e.salary > 35000
ORDER BY e.first_name , e.last_name, e.employee_id;
END $$
DELIMITER ;

CALL usp_get_employees_salary_above_35000;

DROP PROCEDURE usp_get_employees_salary_above_35000;


# 2
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above(u_number INT)
BEGIN
SELECT e.first_name, e.last_name FROM employees AS e
WHERE e.salary >= u_number
ORDER BY e.first_name , e.last_name, e.employee_id;
END $$
DELIMITER ;

CALL usp_get_employees_salary_above(48100);
DROP PROCEDURE usp_get_employees_salary_above;

# 3
DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with(u_text VARCHAR(20))
BEGIN
SELECT t.name FROM `towns` AS t
WHERE t.name LIKE concat(u_text, '%')
ORDER BY t.name;
END $$
DELIMITER ;

CALL usp_get_towns_starting_with('b');
DROP PROCEDURE usp_get_towns_starting_with;


# 4
DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(20))
BEGIN
SELECT e.first_name, e.last_name FROM employees AS e
JOIN addresses AS a
ON e.address_id = a.address_id
JOIN towns AS t
ON a.town_id = t.town_id
WHERE t.name = town_name
ORDER BY e.first_name , e.last_name, e.employee_id;
END $$
DELIMITER ;

CALL usp_get_employees_from_town('Sofia');
DROP PROCEDURE usp_get_employees_from_town;


# 5
CREATE FUNCTION ufn_get_salary_level(salary DOUBLE(19,4)) 
RETURNS VARCHAR(10) 
RETURN(
CASE
	WHEN salary < 30000 THEN 'Low' 
	WHEN salary <= 50000 THEN 'Average'
    ELSE 'High'
    END 
);

# using IF-Else construction
DELIMITER $$
CREATE FUNCTION ufn_get_salary_level(salary DOUBLE(19,4)) 
RETURNS VARCHAR(10) 
BEGIN
	DECLARE level VARCHAR(10);
    IF salary < 30000 THEN SET level := 'Low';
    ELSEIF salary <= 50000 THEN SET level := 'Average';
    ELSE SET level := 'High';
    END IF;
    RETURN level;
END $$
DELIMITER ;

SELECT ufn_get_salary_level(13500.00);
SELECT ufn_get_salary_level(43300.00);
SELECT ufn_get_salary_level(125500.00);
DROP FUNCTION ufn_get_salary_level;

# 6
DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(10))
BEGIN
	SELECT e.first_name, e.last_name FROM employees AS e
	WHERE ufn_get_salary_level(e.salary) = salary_level
	ORDER BY e.first_name DESC, e.last_name DESC;
END $$
DELIMITER ;

CALL usp_get_employees_by_salary_level('high');
CALL usp_get_employees_by_salary_level('average');
DROP PROCEDURE usp_get_employees_by_salary_level;


# 8
DELIMITER $$
CREATE PROCEDURE usp_get_holders_full_name()
BEGIN
SELECT concat(ah.first_name, ' ', ah.last_name) AS 'full_name'
FROM account_holders AS ah
ORDER BY full_name, ah.id;
END $$
DELIMITER ;

CALL usp_get_holders_full_name;
DROP PROCEDURE usp_get_holders_full_name;


# 9
DELIMITER $$
CREATE PROCEDURE usp_get_holders_with_balance_higher_than(amount DECIMAL(19,4))
BEGIN
SELECT ah.first_name, ah.last_name FROM account_holders AS ah
JOIN (
	SELECT a.id, a.account_holder_id, SUM(a.balance) AS 'total_balance'
	FROM accounts AS a
	GROUP BY a.account_holder_id
	HAVING `total_balance` > amount) AS a 
	ON ah.id = a.account_holder_id
	ORDER BY a.id;
END $$
DELIMITER ;


CALL usp_get_holders_with_balance_higher_than(7000);
DROP PROCEDURE usp_get_holders_with_balance_higher_than;


# 10
DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value(initial_sum DECIMAL(19,4), interest_rate DOUBLE(3,2), years INT)
RETURNS DECIMAL(19,4)
BEGIN
	RETURN initial_sum * POW((1 + interest_rate), years);
END $$
DELIMITER ;

SELECT ufn_calculate_future_value(1000, 0.1, 5);


# 11
DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account(account_id INT, interest_rate DOUBLE(19,4))
BEGIN
	SELECT ah.id, ah.first_name, ah.last_name, a.balance, 
	ufn_calculate_future_value(a.balance, interest_rate, 5 ) AS 'balance_in_5_years'
	FROM account_holders ah
	JOIN accounts a 
	ON ah.id = a.account_holder_id
    GROUP BY ah.id
    HAVING account_id = ah.id;
END $$
DELIMITER ;

CALL usp_calculate_future_value_for_account(1, 0.1);
DROP PROCEDURE usp_calculate_future_value_for_account;


# 12
DELIMITER $$
CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(19,4))
BEGIN 
	IF money_amount > 0 THEN 
    START TRANSACTION;
    
		UPDATE accounts AS a
		SET a.balance = a.balance + money_amount
		WHERE a.id = account_id;
        
		IF (SELECT a.balance FROM accounts AS a 
			WHERE a.id = account_id) < 0 THEN ROLLBACK;
		ELSE COMMIT;
		END IF;
    END IF;
END $$
DELIMITER ;
    
CALL usp_deposit_money(1,10);
DROP PROCEDURE usp_deposit_money;

SELECT a.id AS 'account_id', a.account_holder_id, a.balance FROM `accounts` AS a
WHERE a.id = 1;


# 13
DELIMITER $$
CREATE PROCEDURE usp_withdraw_money(account_id INT , money_amount DECIMAL(19,4))
BEGIN
	IF money_amount > 0 THEN
    START TRANSACTION;
    
		UPDATE accounts AS a 
		SET a.balance = a.balance - money_amount
		WHERE a.id = account_id;
        
		IF (SELECT a.balance FROM accounts AS a
			WHERE a.id = account_id) < money_amount 
        THEN ROLLBACK;
    
		ELSE COMMIT;
        END IF;
	END IF;
END $$
DELIMITER ;

CALL usp_withdraw_money(1, 10);
DROP PROCEDURE usp_withdraw_money;

SELECT a.id AS 'account_id', a.account_holder_id, a.balance FROM `accounts` AS a
WHERE a.id = 1;


# 14
DELIMITER $$
CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, amount DECIMAL(19,4))
BEGIN
	IF amount > 0 
		AND (SELECT a.id FROM accounts AS a 
			WHERE a.id = from_account_id) IS NOT NULL
		AND (SELECT a.id FROM accounts AS a 
			WHERE a.id = TO_account_id) IS NOT NULL
		AND (SELECT a.balance FROM accounts AS a
			WHERE a.id = from_account_id) >= amount
		THEN START TRANSACTION;
    
		UPDATE accounts AS a
		SET a.balance = a.balance - amount
			WHERE a.id = from_account_id;
            
		UPDATE accounts AS a
		SET a.balance = a.balance + amount
			WHERE a.id = to_account_id;
			
		IF (SELECT balance FROM accounts AS a
			WHERE a.id = from_account_id) < amount
			THEN ROLLBACK;
		ELSE COMMIT;
		END IF;
    END IF;
END $$
DELIMITER ;

CALL usp_transfer_money(1, 2, 10);
CALL usp_transfer_money(2, 1, 10);
DROP PROCEDURE IF EXISTS usp_transfer_money;

SELECT a.id AS 'account_id', a.account_holder_id, a.balance FROM `accounts` AS a
WHERE a.id IN (1 , 2);
            













