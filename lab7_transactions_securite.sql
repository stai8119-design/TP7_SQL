CREATE DATABASE banque_demo
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE banque_demo;
CREATE TABLE compte (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  titulaire   VARCHAR(100) NOT NULL,
  solde       DECIMAL(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB;
SHOW CREATE TABLE compte;
INSERT INTO compte (titulaire, solde) VALUES
  ('Alice', 1000.00),
  ('Bob',   500.00);
  SELECT * FROM compte;
  START TRANSACTION;
  UPDATE compte SET solde = solde - 200.00 WHERE titulaire = 'Alice';
UPDATE compte SET solde = solde + 200.00 WHERE titulaire = 'Bob';
COMMIT;
SELECT * FROM compte;
START TRANSACTION;
UPDATE compte SET solde = solde - 2000.00 WHERE titulaire = 'Alice';
UPDATE compte SET solde = solde + 2000.00 WHERE titulaire = 'Bob';
ROLLBACK;
SELECT * FROM compte;
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
SELECT solde FROM compte WHERE titulaire = 'Alice';  
UPDATE compte SET solde = solde + 100.00 WHERE titulaire = 'Alice';
COMMIT;
SELECT solde FROM compte WHERE titulaire = 'Alice';
START TRANSACTION;
SELECT * FROM compte
WHERE titulaire = 'Alice'
FOR UPDATE;
UPDATE compte SET solde = solde + 10.00 WHERE titulaire = 'Alice';
COMMIT;
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'P@ssw0rd!';
GRANT SELECT, INSERT, UPDATE ON banque_demo.compte TO 'app_user'@'localhost';
FLUSH PRIVILEGES;