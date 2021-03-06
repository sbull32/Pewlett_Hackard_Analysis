--Create retirement by title Table
SELECT e.emp_no,
    e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) rbt.emp_no,
    rbt.first_name,
	rbt.last_name,
	rbt.title
INTO unique_titles
FROM retirement_titles as rbt
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles;

--Retrieve employees about to retire from unique titles table
SELECT COUNT(rbut.title),
		rbut.title
INTO retiring_titles
FROM retirement_by_unique_title as rbut
GROUP BY (rbut.title)
ORDER BY COUNT(rbut.title) DESC;

SELECT * FROM retiring_titles;

--Create a Mentorship Eligibilty table
SELECT DISTINCT ON (emp_no) e.emp_no,
    e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

SELECT * FROM mentorship_eligibilty;