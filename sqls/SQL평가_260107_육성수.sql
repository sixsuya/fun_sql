-- 1번문제
select employee_id, last_name, salary, department_id
from employees
where salary between 7000 and 12000
and substr(last_name, 1, 1) = 'H'
;

--2번문제
select  employee_id, first_name, last_name, job_id, salary, department_id
from employees
where department_id between 50 and 60
and salary > 5000
;


--3번문제
SELECT first_name, last_name, salary,
                             case when salary <= 5000 then salary*1.2
                               when salary >=5000 and salary < 10000 then salary*1.15
                               when salary >= 10000 and salary < 15000 then salary*1.1
                               else salary
                               end "salary"
FROM employees
WHERE employee_id = &employee_id
;

--4번문제
select d.department_id, d.department_name,l.city
from departments d
join locations l on d.location_id = l.location_id
;

--5번문제
select employee_id, last_name, job_id
from employees
where department_id = (
    select department_id
    from departments
    where department_name = 'IT')    
;

--6번문제
select employee_id, first_name, last_name, email, phone_number, to_char(hire_date, 'DD-Month-yy'), job_id 
from employees
where to_date(hire_date,'YYYY-MM-DD') < to_date('2014-01-01', 'YYYY-MM-DD')
and job_id = 'ST_CLERK'
;

--7번문제
select last_name, job_id, salary, to_char(commission_pct,'.9')
from employees
where commission_pct is not null
order by 3 desc
;

--8번문제
create table PROF(
    PROFNO NUMBER(4) 
    ,NAME VARCHAR2(15) not null
    ,ID varchar2(15) not null
    ,HIREDATE date
    ,PAY number(4)
    );
    
--9번문제
  --(1)
insert into prof
values(1001, 'Mark', 'm1001', '2001-03-07', 800)
;

insert into prof
values(1003, 'Adam', 'a1003', '2002-03-11', null)
;


  --(2)
update prof
set pay = 1200
where profno = 1001
;

  --(3)
delete from prof
where profno = 1003
;

--10번문제
 --(1)
 alter table prof modify profno primary key;
 
 --(2)
 alter table prof add (gender char(3));
 
 --(3)
 alter table prof modify name varchar2(20);
 
 -- end of test.