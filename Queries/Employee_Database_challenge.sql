--Delieverable 1: number of retiring employees by title
--get employees born between 1952-01-01 and 1955-12-31
--use distinct on statement to create a title with most recent employee title, then use count

--Retrieve emp_no, first_name, and last_name columns from Employees table
--Retrieve title, from_date, and to_date from titles table
SELECT e.emp_no, e.first_name, e.last_name,
	t.title, t.from_date, t.to_date
--create new table
INTO retirement_titles
FROM employees as e
	LEFT JOIN titles as t
	ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

--copy the starter code and paste here:
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title

INTO unique_titles
FROM retirement_titles as rt
WHERE rt.to_date = '9999-01-01'
ORDER BY rt.emp_no ASC, to_date DESC;

--retrieve number of employees by more recent job title who are about to retire

--retrieve number of titles from unique titles table
SELECT COUNT(title), title 
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC