--create Retirement_titles table with titles of current employees born 
--between January 1, 1952 and December 31, 1955
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    t.title,
    t.from_date,
    t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY t.emp_no;

-- Use Dictinct On with Orderby to remove duplicate rows and Label table unique_titles
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

SELECT COUNT(title),
FROM unique_titles 
GROUP BY title
ORDER BY title DESC;

--Sort the Unique Titles table in ascending order by the employee number and descending order by the last date (i.e. to_date) of the most recent title
SELECT COUNT(title),title 
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

--Deliverable 2: The Employees Eligible for the Mentorship Program
SELECT DISTINCT ON(e.emp_no) e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
    d.from_date,
    d.to_date,
    t.title
INTO mentorship_eligibilty
FROM employees AS e
INNER JOIN dept_emp AS d
ON (e.emp_no = d.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (d.to_date = '9999-01-01')
ORDER BY e.emp_no; 