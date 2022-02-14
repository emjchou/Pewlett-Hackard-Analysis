-- Constructing/Creating tables for PH-EmployeeDB
CREATE TABLE departments (
	dept_no VARCHAR(4) NOT NULL,
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE (dept_name)
);

CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

-- Create a query (does not construct anything)
-- Queries are interactive, spoken directly to the data. 

SELECT * FROM departments;

-- anyone between 1952 and 1955 will retire
-- create a query which will return employees that fit the criteria
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- check for 1952 birthdates only
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

--check for 1953 only
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

--check for 1954 only
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

--check for 1955 only
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

--retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

---number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--exporting table as csv named retirement_info
--after executing this code, need to right click on the table and export
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--join
SELECT first_name, last_name, title
FROM employees as e
LEFT JOIN titles as t on e.emp_no = t.emp_no;

--drop the retirement info table
DROP TABLE retirement_info;

--create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--check the table 
SELECT * FROM retirement_info;

--create a joined table using inner join
--joins departments and dept_manager tables
SELECT departments.dept_name,
	dept_manager.emp_no,
	dept_manager.from_date,
	dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

--Joining retirement_info and dept_emp tables to get emp_no, first_name, last_name, and the to_date
SELECT retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

--use aliases/nicknames to create table
--joining retirement)info and dept_emp tables
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

--use alias method d for departments and dm for dept_namager
-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

--use left join on retirement)info and dept_emp to make new list including
-- employee number, first name, last name, to-date and save into a table named current_emp
--where only the current employees are included
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

--check table
SELECT * FROM current_emp;

--join the current_emp and dept_emp tables
--to count employees by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO employee_by_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;
--above, we used COUNT instead of SUM because the employee numbers would have just been added
--SUM adds all employee numbers together
--COUNT counts the number of employee numbers (thus the number of employees in the list)
SELECT * FROM employee_by_dept;

--create a list for employee info for retiring employees only
--employee number, last name, first name, gender, salary

--check the to_date column to see if it aligns with employment date
SELECT * FROM salaries
ORDER BY to_date DESC;
--from above, the to_date is not up-to-date. then we need to use the to_date from dept_emp table

SELECT e.emp_no, e.first_name, e.last_name, e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no=de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date='9999-01-01');

--make management table
--list of managers per department
SELECT dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
INTO manager_info
FROM dept_manager as dm
INNER JOIN departments AS d
ON (dm.dept_no=d.dept_no)
INNER JOIN current_emp AS ce
ON (dm.emp_no = ce.emp_no);

SELECT * FROM manager_info;

--create department retirees list
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp as ce
	INNER JOIN dept_emp AS de
	ON (ce.emp_no=de.emp_no)
	INNER JOIN departments AS d
	ON (de.dept_no=d.dept_no);
	
--check table
SELECT * FROM dept_info;	

--create a query that will return info for sales department:
--employee numbers, employee first name, employee last name, employee department name
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	d.dept_name
--INTO sales_info
FROM employees AS e
	INNER JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
	INNER JOIN departments as d
	ON (de.dept_no = d.dept_no)
WHERE d.dept_name ='Sales';
	
--new query for sales and development teams
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	d.dept_name
--INTO sales_development_info
FROM employees AS e
	INNER JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
	INNER JOIN departments as d
	ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales', 'Development');
	




