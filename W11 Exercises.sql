-- Gabriel Yanqui
-- W11 Transactions

USE sakila;

-- Create the `account` table
CREATE TABLE account (
    account_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    avail_balance DOUBLE NOT NULL,
    last_activity_date DATETIME NOT NULL
);

-- Create the `transaction` table
CREATE TABLE transaction (
    txn_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    txn_date DATETIME DEFAULT NULL,
    account_id INT UNSIGNED DEFAULT NULL,
    txn_type_cd VARCHAR(1) NOT NULL,
    amount DOUBLE DEFAULT NULL
);

-- Insert initial data into the `account` table
INSERT INTO account (account_id, avail_balance, last_activity_date)
VALUES
(123, 500, '2019-07-10 20:53:27'),
(789, 75, '2019-06-22 15:18:35');

-- Insert initial data into the `transaction` table
INSERT INTO transaction (txn_id, txn_date, account_id, txn_type_cd, amount)
VALUES
(1001, '2019-05-15 00:00:00', 123, 'C', 500),
(1002, '2019-06-01 00:00:00', 789, 'C', 75);

-- Begin the transaction to transfer $50
START TRANSACTION;

-- Insert debit transaction for account 123
INSERT INTO transaction (txn_date, account_id, txn_type_cd, amount)
VALUES (NOW(), 123, 'D', 50);

-- Insert credit transaction for account 789
INSERT INTO transaction (txn_date, account_id, txn_type_cd, amount)
VALUES (NOW(), 789, 'C', 50);

-- Update account 123 to deduct $50
UPDATE account
SET avail_balance = avail_balance - 50,
    last_activity_date = NOW()
WHERE account_id = 123;

-- Update account 789 to add $50
UPDATE account
SET avail_balance = avail_balance + 50,
    last_activity_date = NOW()
WHERE account_id = 789;

-- Commit the transaction
COMMIT;

-- Verify the updated `account` table
SELECT * FROM account;

-- Verify the updated `transaction` table
SELECT * FROM transaction;

-- Eliminar la tabla `transaction` primero porque depende de la tabla `account`
DROP TABLE IF EXISTS transaction;

-- Eliminar la tabla `account`
DROP TABLE IF EXISTS account;