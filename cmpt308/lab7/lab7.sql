Miracle 4/5/2026 Lab 7

DROP TABLE IF EXISTS Accounts;

CREATE TABLE Accounts (
  account_id INT PRIMARY KEY,
  owner TEXT NOT NULL,
  balance INT NOT NULL CHECK (balance >= 0)
);

INSERT INTO Accounts (account_id, owner, balance) VALUES
(1, 'Ava', 500),
(2, 'Ben', 300),
(3, 'Cara', 200);


SELECT balance FROM accounts 
WHERE account_id = 1 OR account_id = 2;


BEGIN;

	UPDATE accounts 
	SET balance = 400 
	WHERE account_id = 2; 
	
	UPDATE accounts 
	SET balance = 400 
	WHERE account_id = 1;

COMMIT;


SELECT balance FROM accounts 
WHERE account_id = 1 OR account_id = 2;


SELECT balance FROM accounts 
WHERE account_id = 1 OR account_id = 2;


BEGIN;

	UPDATE accounts 
	SET balance = 300 
	WHERE account_id = 2; 
	
	UPDATE accounts 
	SET balance = 500 
	WHERE account_id = 1;

COMMIT;


SELECT balance FROM accounts 
WHERE account_id = 1 OR account_id = 2;

