
--ok
create table titles (
	title_id VARCHAR(8) PRIMARY KEY NOT NULL,
	title VARCHAR (40) NOT NULL
);



--ok
create table dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(8) NOT NULL,
    foreign key (emp_no) references employees (emp_no),
    foreign key (dept_no) references departments (dept_no)
);


--ok
create table dept_manager (
	dept_no VARCHAR(8) NOT NULL,
	emp_no INT NOT NULL,
    foreign key (emp_no) references employees (emp_no),
    foreign key (dept_no) references departments (dept_no)
);


--ok
create table salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
    foreign key (emp_no) references employees (emp_no)
);



--ok
create table employees (
	emp_no INT PRIMARY KEY NOT NULL,
	title_id VARCHAR(8) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(35) NOT NULL,
	last_name VARCHAR(35) NOT NULL,
	sex VARCHAR(1)NOT NULL,
	hire_date DATE NOT NULL,
	foreign key (title_id) references titles (title_id)
);


--ok
create table departments (
	dept_no VARCHAR(8) primary key NOT NULL,
	dept_name VARCHAR(40) NOT NULL
);


SELECT *
FROM employees

SELECT *
FROM salaries

SELECT *
FROM departments

SELECT *
FROM dept_manager

SELECT *
FROM dept_emp

SELECT *
FROM titles


--1.List the employee number, last name, first name, sex, and salary of each employee.
SELECT employees.emp_no, last_name, first_name, sex, salary
FROM employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no;

--Joining data for manager
SELECT employees.emp_no,
dept_manager.dept_no,
departments.dept_name,
employees.title_id,
titles.title,
employees.first_name,
employees.last_name,
employees.birth_date,
employees.sex,
employees.hire_date
FROM employees 
JOIN dept_manager
ON employees.emp_no = dept_manager.emp_no
JOIN departments
ON dept_manager.dept_no = departments.dept_no
JOIN titles
ON employees.title_id = titles.title_id;

--Joining data for employee
SELECT employees.emp_no,
dept_emp.dept_no,
departments.dept_name,
employees.title_id,
titles.title,
employees.first_name,
employees.last_name,
employees.birth_date,
employees.sex,
employees.hire_date
FROM employees 
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
JOIN titles
ON employees.title_id = titles.title_id;

--2.List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE (hire_date BETWEEN '1986-01-01' AND '1986-12-31')

--3.List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT titles.title,
dept_manager.dept_no,
departments.dept_name,
employees.emp_no,
employees.last_name,
employees.first_name
FROM employees 
JOIN dept_manager
ON employees.emp_no = dept_manager.emp_no
JOIN departments
ON dept_manager.dept_no = departments.dept_no
JOIN titles
ON employees.title_id = titles.title_id;

--4.List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT dept_emp.dept_no,
employees.emp_no,
employees.last_name,
employees.first_name,
departments.dept_name
FROM employees 
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
JOIN titles
ON employees.title_id = titles.title_id;

--5.List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND
last_name LIKE 'B%';

--6.List each employee in the Sales department, including their employee number, last name, and first name.
SELECT employees.emp_no,
employees.last_name,
employees.first_name
FROM employees 
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
JOIN titles
ON employees.title_id = titles.title_id
WHERE dept_name = 'Sales';

--7.List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.emp_no,
employees.last_name,
employees.first_name,
departments.dept_name
FROM employees 
JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
JOIN titles
ON employees.title_id = titles.title_id
WHERE dept_name = 'Sales' OR dept_name ='Development';



--8.List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT (last_name) AS "frequency" 
FROM employees 
GROUP BY last_name 
ORDER BY COUNT (last_name) DESC;





