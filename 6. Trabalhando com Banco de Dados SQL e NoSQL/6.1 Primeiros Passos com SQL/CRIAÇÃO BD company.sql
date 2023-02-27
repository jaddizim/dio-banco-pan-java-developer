use company;
CREATE TABLE employee (
    Fname VARCHAR(15) NOT NULL,
    Minit CHAR,
    Lname VARCHAR(15) NOT NULL,
    Ssn CHAR(9) NOT NULL,
    Bdate DATE,
    Adress VARCHAR(30),
    Sex CHAR,
    Salary DECIMAL(10 , 2 ),
    Super_ssn CHAR(9),
    Dno INT NOT NULL,
    CONSTRAINT chk_salary_employee CHECK (Salary > 2000.0),
    CONSTRAINT pk_employee PRIMARY KEY (Ssn)
);

CREATE TABLE department (
    Dname VARCHAR(15) NOT NULL,
    Dnumber INT NOT NULL,
    Mgr_Ssn CHAR(9) NOT NULL,
    Mgr_start_date DATE,
    Dept_create_date DATE,
    CONSTRAINT chk_date_dept CHECK (Dept_create_date < Mgr_start_date),
    CONSTRAINT pk_dept PRIMARY KEY (Dnumber),
    CONSTRAINT unique_name_dept UNIQUE (Dname),
    FOREIGN KEY (Mgr_ssn)
        REFERENCES employee (Ssn)
);

alter table department drop foreign key department_ibfk_1;

alter table department
	add constraint fk_dept foreign key (Mgr_ssn) references employee (Ssn)
	on update cascade;

CREATE TABLE company.dept_locations (
    Dnumber INT NOT NULL,
    Dlocation VARCHAR(15) NOT NULL,
    CONSTRAINT pk_dept_locations PRIMARY KEY (Dnumber , Dlocation),
    FOREIGN KEY fk_dept_locations (Dnumber)
        REFERENCES department (Dnumber)
);

alter table dept_locations drop foreign key fk_dept_locations;

alter table dept_locations
	add constraint fk_dept_locations foreign key (Dnumber) references department (Dnumber)
	on delete cascade
    on update cascade;

CREATE TABLE project (
    Pname VARCHAR(15) NOT NULL,
    Pnumber INT NOT NULL,
    Plocation VARCHAR(15),
    Dnum INT NOT NULL,
    CONSTRAINT unique_project UNIQUE (Pname),
    CONSTRAINT pk_project PRIMARY KEY (Pnumber),
    FOREIGN KEY fk_project_dnum (Dnum)
        REFERENCES department (Dnumber)
);

DROP TABLE WORKS_ON;

CREATE TABLE works_on (
    Essn CHAR(9) NOT NULL,
    Pno INT NOT NULL,
    Hours DECIMAL(3,1) NOT NULL,
    CONSTRAINT pk_works_on PRIMARY KEY (Essn, Pno),
    CONSTRAINT fk_works_on_employee FOREIGN KEY (Essn)
        REFERENCES employee (Ssn),
	CONSTRAINT fk_works_on_project FOREIGN KEY (Pno)
        REFERENCES project (Pnumber)
);

DROP TABLE DEPENDENT;

CREATE TABLE dependent (
    Essn CHAR(9) NOT NULL,
    Dependent_name VARCHAR(15) NOT NULL,
    Sex CHAR,
    Bdate date,
    Relationship VARCHAR(8),
    CONSTRAINT pk_dependent PRIMARY KEY (Essn, Dependent_name),
    CONSTRAINT fk_dependent FOREIGN KEY (Essn)
        REFERENCES employee (Ssn)
);

alter table employee
add constraint fk_employee
foreign key (Super_Ssn) references employee (Ssn)
on delete set null
on update cascade;

SELECT 
    *
FROM
    information_schema.table_constraints
WHERE
    table_name = 'department' and constraint_schema = 'company';