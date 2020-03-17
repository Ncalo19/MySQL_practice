CREATE TABLE person(
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30),
    major VARCHAR(30)
);
bdf
INSERT INTO person (name, major)
VALUES('Nicolas Calo', 'Business Management')
;

INSERT INTO person (name, major)
VALUES
('Jonathan Calo', 'Videography'),
('Nick Calo', 'Masonry'),
('Mishelle Calo', 'Real Estate')
;

ALTER TABLE person CHANGE major career varchar(30);

SELECT student_id, name, career FROM person;

DROP TABLE person;

CREATE TABLE employee(
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    birth_date DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT,
    branch_id INT
);

CREATE TABLE branch(
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(20),
    mgr_id INT,
    mgr_start_date DATE
);

ALTER TABLE branch
ADD FOREIGN KEY(mgr_id)
REFERENCES employee(emp_id);

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

CREATE TABLE client(
    client_id INT PRIMARY KEY,
    client_name VARCHAR(20),
    branch_id INT,
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with(
    emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY(emp_id, client_id),
    FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
    FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier(
    branch_id INT,
    supplier_name VARCHAR(30),
    supply_type VARCHAR(20),
    PRIMARY KEY(branch_id, supplier_name),
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES
(2, 'Hammer Mill', 'Paper'),
(2, 'Uni-ball', 'Writing Utensils'),
(3, 'Patriot Paper', 'Paper'),
(2, 'J.T. Forms & Labels', 'Custom Forms'),
(3, 'Uni-ball', 'Writing Utensils'),
(3, 'Hammer Mill', 'Paper'),
(3, 'Stamford Lables', 'Custom Forms');

UPDATE branch_supplier
SET supplier_name = 'Stamford Labels'
WHERE supplier_name = 'Stamford Lables';

SELECT * FROM branch_supplier;

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);


-- basic queries
SELECT emp_id, client_id, total_sales FROM works_with;

SELECT * FROM employee;

SELECT * FROM employee
ORDER BY sex, first_name, last_name;

SELECT * FROM employee
LIMIT 5;

SELECT first_name AS forename, last_name AS surname
FROM employee;

SELECT DISTINCT sex
FROM employee;

-- functions
SELECT COUNT(sex) -- counts number of values in the specified dataset
FROM employee;

SELECT COUNT(emp_id)
FROM employee
WHERE sex = 'F' AND birth_date > '1971-01-01';

SELECT AVG(salary)
FROM employee
WHERE sex = 'M';

SELECT COUNT(sex), sex
FROM employee
GROUP BY sex;

-- wildcards: grabbing data that matches a specific pattern
SELECT client_id
FROM client
WHERE client_name LIKE '%llc%'; -- case insensitive with % (one or two)

SELECT *
FROM employee
WHERE birth_date LIKE '____-02%'; -- _ : adds a distance from start of text you are searching in

-- UNION: brings together multiple data entries from different rows (and/or diff tables)
SELECT client_name
FROM client
UNION
SELECT supplier_name -- all union items need same number of columns
FROM branch_supplier;


-- JOIN : joins/merges data and adds them to a new dataset/datapoint based on related data

INSERT INTO branch VALUES(4, 'Buffalo', NULL, NULL);

SELECT employee.emp_id, employee.first_name, employee.last_name, branch.branch_name
FROM employee
JOIN branch -- there is also left (ex. all rows from employee) and right join (ex. all rows from branch)
ON employee.emp_id = branch.mgr_id;

-- Nested query: query inside a query (filter inside a filter)

SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
    SELECT emp_id
    FROM works_with
    WHERE total_sales > 30000
);

SELECT client.client_name
FROM client
WHERE client.branch_id = (
    SELECT branch.branch_id
    FROM branch
    WHERE branch.mgr_id = 102
);

SELECT * FROM branch_supplier;
