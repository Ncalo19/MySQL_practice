CREATE TABLE immediate_family(
    f_name VARCHAR(15) PRIMARY KEY,
    age INT,
    eye_color VARCHAR(10)
);

INSERT INTO immediate_family VALUES
('Nick', 52, 'Green'),
('Mishelle', 50, 'Brown'),
('Nicolas', 23, 'Blue'),
('Jonathan', 21, 'Brown'),
('Andrew', 9, 'Brown'),
('Sarah', 7, 'Green');

SELECT * FROM immediate_family;

SELECT * FROM immediate_family
WHERE age > 20;

SELECT * FROM immediate_family
WHERE age > 20
ORDER BY age ASC;

SELECT f_name, eye_color FROM immediate_family
WHERE eye_color LIKE 'Brown';

SELECT count(eye_color), eye_color FROM immediate_family
GROUP BY eye_color;

SELECT AVG(age) FROM immediate_family;

SELECT AVG(age) FROM immediate_family
WHERE age > 20;

INSERT INTO immediate_family VALUES('Dog', 10, 'Brown');

DELETE FROM immediate_family
WHERE f_name LIKE 'Dog';

SELECT COUNT(*) FROM immediate_family;

SELECT * FROM immediate_family
WHERE f_name LIKE '%_i%';

SELECT * FROM immediate_family
ORDER BY age ASC
LIMIT 3;

CREATE TABLE extended_family(
    f_name VARCHAR(15) PRIMARY KEY,
    age INT,
    eye_color VARCHAR(10)
);

INSERT INTO extended_family VALUES
('Wayne', 62, 'Brown'),
('Margie', 54, 'Brown'),
('Kelly', 30, 'Blue'),
('Jacquelyn', 28, 'Brown'),
('Christopher', 23, 'Brown');

SELECT f_name FROM immediate_family
UNION
SELECT f_name FROM extended_family;
