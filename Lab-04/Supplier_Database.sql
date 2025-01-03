-- Create Database
CREATE DATABASE Bhavya_J_064_supp;
USE Bhavya_J_064_supp;

-- Create Tables
CREATE TABLE Supplier (
    s_id INT PRIMARY KEY,
    s_name VARCHAR(30),
    city VARCHAR(20)
);

CREATE TABLE Parts (
    p_id INT PRIMARY KEY,
    p_name VARCHAR(30),
    color VARCHAR(30)
);

CREATE TABLE Catalog (
    s_id INT,
    p_id INT,
    cost FLOAT,
    FOREIGN KEY (s_id) REFERENCES Supplier(s_id),
    FOREIGN KEY (p_id) REFERENCES Parts(p_id)
);

-- Insert Values into Supplier Table
INSERT INTO Supplier VALUES
(10001, 'Acme_Widget', 'Bangalore'),
(10002, 'Johns', 'Kolkata'),
(10003, 'Vimal', 'Mumbai'),
(10004, 'Reliance', 'Delhi');

-- Insert Values into Parts Table
INSERT INTO Parts VALUES
(20001, 'Book', 'Red'),
(20002, 'Pen', 'Red'),
(20003, 'Pencil', 'Green'),
(20004, 'Mobile', 'Green'),
(20005, 'Charger', 'Black');

-- Insert Values into Catalog Table
INSERT INTO Catalog VALUES
(10001, 20001, 10),
(10001, 20002, 10),
(10001, 20003, 30),
(10001, 20004, 10),
(10001, 20005, 10),
(10002, 20001, 10),
(10002, 20002, 20),
(10003, 20003, 30),
(10004, 20003, 40);

-- Query 1: Find the pnames of parts for which there is some supplier
SELECT DISTINCT p.p_name
FROM Supplier s, Catalog c, Parts p
WHERE s.s_id = c.s_id AND p.p_id = c.p_id AND c.s_id IS NOT NULL;

-- Query 2: Find the snames of suppliers who supply every part
SELECT DISTINCT s.s_name
FROM Supplier s, Catalog c, Parts p
WHERE s.s_id = c.s_id
GROUP BY s.s_id, s.s_name
HAVING COUNT(DISTINCT c.p_id) = (SELECT COUNT(*) FROM Parts p);

-- Query 3: Find the snames of suppliers who supply every red part
SELECT DISTINCT s.s_name
FROM Supplier s, Catalog c, Parts p
WHERE s.s_id = c.s_id
  AND c.p_id IN (SELECT p_id FROM Parts p WHERE p.color = 'Red');

-- Query 4: Find the pnames of parts supplied by Acme Widget Suppliers and by no one else
SELECT DISTINCT p.p_name
FROM Supplier s, Parts p, Catalog c
WHERE p.p_id IN (
    SELECT c.p_id
    FROM Catalog c, Supplier s
    WHERE s.s_id = c.s_id AND s.s_name = 'Acme_Widget'
) 
AND p.p_id NOT IN (
    SELECT c.p_id
    FROM Catalog c, Supplier s
    WHERE s.s_id = c.s_id AND s.s_name != 'Acme_Widget'
);

-- Query 5: Find the sids of suppliers who charge more for some part than the average cost of that part
CREATE VIEW Bhavya_J_064_Average(p_id, Average_Product_Cost) AS 
SELECT c.p_id, AVG(c.cost)
FROM Catalog c
GROUP BY c.p_id;

SELECT c.s_id
FROM Catalog c, Bhavya_J_064_Average a
WHERE c.p_id = a.p_id AND c.cost > a.Average_Product_Cost
GROUP BY c.p_id, c.s_id;

-- Query 6: For each part, find the sname of the supplier who charges the most for that part
SELECT DISTINCT s.s_name, c.cost, c.p_id
FROM Catalog c, Supplier s
WHERE s.s_id = c.s_id
  AND c.cost IN (
      SELECT MAX(c.cost)
      FROM Catalog c
      GROUP BY c.p_id
  );
