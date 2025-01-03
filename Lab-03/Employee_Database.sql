-- Create Database
CREATE DATABASE Bhavya_J_064;
USE Bhavya_J_064;

-- Create Tables
CREATE TABLE project (
    pno INT,
    ploc VARCHAR(50),
    pname VARCHAR(50),
    PRIMARY KEY (pno)
);

CREATE TABLE dept (
    deptno INT PRIMARY KEY,
    dname VARCHAR(50),
    dloc VARCHAR(50)
);

CREATE TABLE employee (
    empno INT PRIMARY KEY,
    empname VARCHAR(50),
    mgr_no INT,
    hiredate DATE,
    sal INT,
    deptno INT,
    FOREIGN KEY (deptno) REFERENCES dept (deptno)
);

CREATE TABLE incentives (
    empno INT,
    incentive_date DATE,
    incentive_amt INT,
    PRIMARY KEY (empno, incentive_date),
    FOREIGN KEY (empno) REFERENCES employee (empno)
);

CREATE TABLE assigned_to (
    empno INT,
    pno INT,
    job_role VARCHAR(50),
    PRIMARY KEY (empno, pno),
    FOREIGN KEY (empno) REFERENCES employee (empno),
    FOREIGN KEY (pno) REFERENCES project (pno)
);

-- Insert Values
INSERT INTO project VALUES
    (1, 'Panaji', 'apx'),
    (2, 'Mysuru', 'bdx'),
    (3, 'Mysuru', 'aap'),
    (4, 'Kochi', 'ccg'),
    (5, 'Udupi', 'fpg');

INSERT INTO dept VALUES
    (1, 'cse', 'bengaluru'),
    (2, 'design', 'kochi'),
    (3, 'accounts', 'mumbai'),
    (4, 'hr', 'hyderabad'),
    (5, 'aiml', 'mysuru');

INSERT INTO employee VALUES
    (111, 'Bhoomi', 115, '2020-11-18', 250000, 1),
    (112, 'Piyush', 115, '2016-07-20', 70000, 2),
    (113, 'Shreyas', 116, '2000-07-22', 100000, 5),
    (114, 'Aditi', 116, '2028-10-02', 100000, 5),
    (115, 'Anagha', 116, '2020-11-18', 80000, 2),
    (116, 'Harsha', NULL, '2024-07-03', 70000, 3);

INSERT INTO incentives VALUES
    (111, '2023-12-24', 3000),
    (114, '2023-12-24', 4000),
    (115, '2023-12-25', 5000),
    (116, '2023-12-25', 7000),
    (111, '2024-08-01', 3000);

INSERT INTO assigned_to VALUES
    (111, 1, 'developer'),
    (111, 4, 'data analyst'),
    (112, 2, 'developer'),
    (114, 3, 'accountant'),
    (113, 5, 'brand designer'),
    (115, 3, 'supervisor'),
    (112, 3, 'manager');

-- Queries

-- List all employees along with their project details (if assigned)
SELECT e.empno
FROM employee e, assigned_to a
WHERE e.empno = a.empno AND a.pno IN (
    SELECT pno
    FROM project
    WHERE ploc IN ('Panaji', 'Kochi', 'Mysuru')
);

-- Find employees with no incentives
SELECT empno
FROM employee
WHERE NOT EXISTS (
    SELECT 1
    FROM incentives
    WHERE empno = employee.empno
);

-- List employee details with project and department information
SELECT e.empno, e.empname, d.dname, a.job_role, d.dloc, p.ploc
FROM employee e, project p, assigned_to a, dept d
WHERE e.empno = a.empno AND p.pno = a.pno AND e.deptno = d.deptno AND d.dloc = p.ploc;

-- List employees and their project details
SELECT e.empname, p.*
FROM employee e, project p, assigned_to a
WHERE a.empno = e.empno AND a.pno = p.pno;

-- Calculate total incentives for each employee
SELECT e.empname, SUM(i.incentive_amt) AS total_incentive
FROM employee e, incentives i
WHERE e.empno = i.empno
GROUP BY e.empname;

-- List managers for projects
SELECT p.ploc, p.pname, a.job_role
FROM project p, assigned_to a
WHERE p.pno = a.pno AND a.job_role = 'manager';

-- Count employees in each department
SELECT d.dname, COUNT(e.empno) AS total
FROM dept d, employee e
WHERE d.deptno = e.deptno
GROUP BY d.dname;

-- Find employees with no project assignments
SELECT empname
FROM employee
WHERE NOT EXISTS (
    SELECT 1
    FROM assigned_to
    WHERE empno = employee.empno
);

-- List employee details with department
SELECT e.empname, d.dname, d.dloc
FROM employee e, dept d
WHERE e.deptno = d.deptno;

-- Find employees managed by a specific manager
SELECT e.empname
FROM employee e
WHERE mgr_no = 116;

-- Count employees per project
SELECT p.pname, COUNT(a.empno) AS No_of_employees
FROM project p, assigned_to a
WHERE a.pno = p.pno
GROUP BY p.pname;

-- Count employees under each manager
SELECT e.mgr_no, COUNT(e.empno) AS total
FROM employee e
GROUP BY e.mgr_no;

-- Calculate total incentives per employee
SELECT e.empname, COUNT(i.empno) AS total, SUM(i.incentive_amt) AS sum
FROM employee e, incentives i
WHERE e.empno = i.empno
GROUP BY e.empname;

-- List developers assigned to projects
SELECT e.empname, p.pname, a.job_role
FROM employee e, project p, assigned_to a
WHERE e.empno = a.empno AND p.pno = a.pno AND a.job_role = 'developer';

-- Calculate average salary per department
SELECT d.dname, AVG(e.sal) AS average
FROM employee e, dept d
WHERE e.deptno = d.deptno
GROUP BY d.dname;
