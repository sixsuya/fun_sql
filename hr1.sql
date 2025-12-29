select *
from tab;

select *
from employees;

select *   --  요거 권한 없어야 하는데 보이고 있음. 나중에 drop 배우면 그걸로 테이블 날리자.
from emp;

select *
from employees
where job_id = 'IT_PROG';

select*
from departments;  -- 부서정보

select *
from employees
where employee_id = 103
;

--교재 1장 예제--

select*
from departments;
select *
from employees;

SELECT *
FROM employees
WHERE 1=1    -- 동적 쿼리 조건 구성의 단순화. SQL을 주석 처리하는 과정이 훨씬 쉬워진다.
and salary + salary*nvl(commission_pct,0) > 10000
and department_id IN (20,80)
--and department_id = 50
--and salary >= 3000
;