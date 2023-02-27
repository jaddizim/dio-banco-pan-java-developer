USE company;

SHOW TABLES;

-- Dnumber : department
DESC department;

-- Dnumber : dept_locations
DESC dept_locations;

SELECT * FROM department;
SELECT * FROM dept_locations;

-- CLÁUSULA AMBÍGUA
SELECT * FROM department, dept_locations WHERE Dnumber = Dnumber;

-- CLÁUSULA DESAMBÍGUA
SELECT 
    Dname as Department_Name,
    Dlocation as Location
FROM
    department AS d,
    dept_locations AS L
WHERE
    d.Dnumber = L.Dnumber;