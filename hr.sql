-- creating table
create table hrdata
(
	emp_no int8 primary key,
	gender varchar(50) not null,
	marital_status varchar(50),
	age_band varchar(50),
	age	int8,
	department varchar(50),
	education varchar(50),
	education_field varchar(50),
	job_role varchar(50),
	business_travel	varchar(50),
	employee_count int8,
	attrition varchar(50),
	attrition_label	varchar(50),	
	job_satisfaction int8,
	active_employee int8
)


select * from hrdata;

-- Employee count

select sum(employee_count) from hrdata;


-- Total emmployees with education as High School

select sum(employee_count) AS emp_count
from hrdata
where education = 'Associates Degree';


-- employees in R&D department

select sum(employee_count) AS emp_count
from hrdata
where department = 'R&D';

-- employees from education field medical
select sum(employee_count) AS emp_count
from hrdata
where education_field = 'Medical';

-- Attrition count
select count(attrition)
from hrdata
where attrition = 'Yes';

-- Attrition count for doctoral degree
select count(attrition)
from hrdata
where attrition = 'Yes' and education = 'Doctoral Degree';


-- Attrition count for R&D department
select count(attrition)
from hrdata
where attrition = 'Yes' and department = 'R&D';


-- Attrition count for R&D department and education field as medical
select count(attrition)
from hrdata
where attrition = 'Yes' and department = 'R&D' and education_field = 'Medical';


-- Attrition count for R&D department and education field as medical and education high school
select count(attrition)
from hrdata
where attrition = 'Yes' and department = 'R&D' and education_field = 'Medical' and education = 'High School';

-- find attrition rate

select round(((select count(attrition) from hrdata 
where attrition = 'Yes')/sum(employee_count))*100,2) 
from hrdata;


-- find attrition rate in sales department

select round(((select count(attrition) from hrdata 
where attrition = 'Yes' and department = 'Sales')/sum(employee_count))*100,2) 
from hrdata
where department = 'Sales';


-- active employees

select sum(employee_count) - (select count(attrition)
from hrdata
where attrition = 'Yes')
from hrdata;


-- active male employees
select sum(employee_count) - (select count(attrition)
from hrdata
where attrition = 'Yes' and gender = 'Male')
from hrdata
where gender = 'Male';


-- active female employees
select sum(employee_count) - (select count(attrition)
from hrdata
where attrition = 'Yes' and gender = 'Female')
from hrdata
where gender = 'Female';


-- average age
select round(avg(age),0)
from hrdata;

-- attrition by gender

select gender, count(attrition)
from hrdata
where attrition = 'Yes'
group by gender;

-- attrition by gender & high school
select gender, count(attrition)
from hrdata
where attrition = 'Yes' and education = 'High School'
group by gender;


-- department wise attrition

select department,count(attrition),
round((cast(count(attrition) as numeric) / (select count(attrition) from hrdata where attrition = 'Yes'))*100,2)
from hrdata
where attrition = 'Yes'
group by department;

-- department wise attrition for female

select department,count(attrition),
round((cast(count(attrition) as numeric) / (select count(attrition) from hrdata where attrition = 'Yes' and gender = 'Female'))*100,2)
from hrdata
where attrition = 'Yes' and gender = 'Female'
group by department;

-- department wise attrition for male

select department,count(attrition),
round((cast(count(attrition) as numeric) / (select count(attrition) from hrdata where attrition = 'Yes' and gender = 'Male'))*100,2)
from hrdata
where attrition = 'Yes' and gender = 'Male'
group by department;

-- No. of employees by age group

select age, sum(employee_count)
from hrdata
group by age
order by age ;

-- No. of employees by age group in hr dept

select age, sum(employee_count)
from hrdata
where department = 'R&D'
group by age
order by age ;

-- job satisfaction rating
select *
from crosstab(
'select job_role,job_satisfaction,sum(employee_count)
	from hrdata
	group by job_role,job_satisfaction
	order by job_role,job_satisfaction'
	
)as ct (job_role varchar(50),one numeric,two numeric,three numeric,four numeric)
order by job_role;	


-- education field wise attrition
select education_field, count(attrition) 
from hrdata
where attrition = 'Yes'
group by education_field
order by count(attrition) desc;


-- age band wise attrition
select age_band,gender, count(attrition),
round((cast(count(attrition) as numeric)/(select count(attrition) from hrdata where attrition = 'Yes'))*100,2)
from hrdata
where attrition = 'Yes'
group by gender,age_band
order by age_band,gender;















