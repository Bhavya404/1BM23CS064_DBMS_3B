-- CREATE DATABASE

CREATE DATABASE bhavya_j_064;
USE bhavya_j_064;

-- CREATE TABLES

CREATE TABLE branch (
    branchname VARCHAR(50),
    branchcity VARCHAR(50),
    assests INT,
    PRIMARY KEY (branchname)
);

CREATE TABLE bankcustomer (
    customername VARCHAR(50),
    customer_street VARCHAR(50),
    city VARCHAR(50),
    PRIMARY KEY (customername)
);

CREATE TABLE bankaccount (
    accno INT,
    branchname VARCHAR(50),
    balance INT,
    PRIMARY KEY (accno),
    FOREIGN KEY (branchname) REFERENCES branch (branchname)
);

CREATE TABLE depositer (
    customername VARCHAR(50),
    accno INT,
    PRIMARY KEY (customername, accno),
    FOREIGN KEY (customername) REFERENCES bankcustomer(customername),
    FOREIGN KEY (accno) REFERENCES bankaccount(accno)
);

CREATE TABLE loan (
    loannumber INT,
    branchname VARCHAR(50),
    amount INT,
    PRIMARY KEY (loannumber),
    FOREIGN KEY (branchname) REFERENCES branch (branchname)
);

-- INSERTING VALUES INTO THE TABLE

INSERT INTO branch
VALUES ('SBI-chamrajpet', 'banglore', 50000),
       ('SBI-residencyroad', 'banglore', 10000),
       ('SBI-shivajiroad', 'bombay', 20000),
       ('SBI-parlimentroad', 'delhi', 10000),
       ('SBI-jantarmantar', 'delhi', 20000);

INSERT INTO bankcustomer
VALUES ('avinash', 'bull-temple-road', 'banglore'),
       ('dinesh', 'bannergatta-road', 'banglore'),
       ('mohan', 'nationalcollege-road', 'banglore'),
       ('nikil', 'akbar-road', 'delhi'),
       ('ravi', 'prithviraj-road', 'delhi');

INSERT INTO bankaccount
VALUES (1, 'SBI-chamrajpet', 2000),
       (2, 'SBI-residencyroad', 5000),
       (3, 'SBI-shivajiroad', 6000),
       (4, 'SBI-parlimentroad', 9000),
       (5, 'SBI-jantarmantar', 8000),
       (6, 'SBI-shivajiroad', 4000),
       (8, 'SBI-residencyroad', 4000),
       (9, 'SBI-parlimentroad', 3000),
       (10, 'SBI-residencyroad', 5000),
       (11, 'SBI-jantarmantar', 2000);

INSERT INTO depositer
VALUES ('avinash', 1),
       ('dinesh', 2),
       ('nikil', 4),
       ('ravi', 5),
       ('avinash', 8),
       ('nikil', 9),
       ('dinesh', 10),
       ('nikil', 11);

INSERT INTO loan
VALUES (1, 'SBI-chamrajpet', 1000),
       (2, 'SBI-residencyroad', 2000),
       (3, 'SBI-shivajiroad', 3000),
       (4, 'SBI-parlimentroad', 4000),
       (5, 'SBI-jantarmantar', 5000);

-- QUERIES

-- Display the branch name and assets from all branches in lakhs of rupees and rename the assets column to 'assets in lakhs'.
SELECT branchname, assests AS 'assets in lakhs'
FROM branch;

-- Find all the customers who have at least two accounts at the same branch (e.g., SBI_ResidencyRoad).
SELECT d.customername
FROM bankaccount b, depositer d
WHERE b.accno = d.accno AND branchname = 'SBI-residencyroad'
GROUP BY customername
HAVING COUNT(*) >= 2;

-- Create a view which gives each branch the sum of the amount of all the loans at the branch.
CREATE VIEW loan_info AS
SELECT b.branchname, SUM(l.amount)
FROM branch b, loan l
WHERE b.branchname = l.branchname
GROUP BY l.branchname;
SELECT * FROM loan_info;

-- Retrieve all branches and their respective total assets.
SELECT branchname, assests
FROM branch;

-- List all customers who live in a particular city.
SELECT customername
FROM bankcustomer
WHERE city = 'banglore';

-- List all customers with their account numbers.
SELECT customername, accno
FROM depositer;

-- Find all the customers who have an account at all the branches located in a specific city (e.g., Delhi).
SELECT c.customername
FROM bankcustomer c, depositer d, bankaccount a, branch b
WHERE c.customername = d.customername 
  AND d.accno = a.accno 
  AND a.branchname = b.branchname 
  AND b.branchname = ALL (
      SELECT b.branchname
      FROM branch b
      WHERE b.branchcity = 'delhi'
  );

-- Find all customers who have accounts with a balance greater than a specified amount (5000).
SELECT c.customername, b.balance
FROM bankcustomer c, bankaccount b, depositer d
WHERE d.accno = b.accno 
  AND c.customername = d.customername 
  AND b.balance > 5000;

-- List all branches that have both a loan and an account.
SELECT DISTINCT(b.branchname)
FROM branch b, bankaccount a, loan l
WHERE b.branchname = a.branchname 
  AND b.branchname = l.branchname;

-- Get the number of accounts held at each branch.
SELECT branchname, COUNT(*)
FROM bankaccount
GROUP BY branchname;

-- Find all branches that have no loans issued.
SELECT b.branchname
FROM branch b
WHERE b.branchname NOT IN (
    SELECT branchname
    FROM loan
);

-- Retrieve the branch with the smallest total loan amount.
SELECT branchname, MIN(amount)
FROM loan
GROUP BY branchname
ORDER BY MIN(amount)
LIMIT 1;
