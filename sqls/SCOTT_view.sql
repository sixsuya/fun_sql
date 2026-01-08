-- p.420 연습문제 2번
select e.department_id, department_name, max_sal
from (select department_id, max(salary) max_sal
    from employees
    group by department_id) e
    join departments d on e.department_id = d.department_id
;

select d.dname "학과명", s.max_height "최고키", s.max_weight "최고몸무게"
from (select deptno1, max(height) max_height, max(weight) max_weight
    from student
    group by deptno1) s
    join department d 
    on s.deptno1 = d.deptno
;

-- p.426~ 서브쿼리
-- p.427 그림 예제 : ward보다 comm을 적게 받는 사람들 목록
select *
from emp
where ename='WARD'    -- 1차로 WARD의 COMM 확인
;

select *
from emp
where comm<500           -- 그 결과로 2차로 조건 넣어서 진행
;

-- 상기 2개 쿼리를 하나로 합치고 싶을때.
select *
from emp
where comm < (select comm from emp where ename = 'WARD') 
;

-- p429 단일행 연습문제 1
select deptno1
from student
where name = 'Anthony Hopkins';   --서브쿼리 조건문

select name Stud_Name, dname DEPT_NAme     -- dname은 department에 있으므로 join 사용
from student s
join department d on s.deptno1 = d.deptno
where deptno1 = (select deptno1 from student where name = 'Anthony Hopkins')
;

-- 연습문제 2
select hiredate
from professor
where name = 'Meg Ryan'
;

select name PROF_NAME, TO_DATE(hiredate,'YYYY-MM-DD'), dname DEPT_NAME
from professor p
join department d on p.deptno = d.deptno
where hiredate > (select hiredate from professor where name = 'Meg Ryan')
;

select name PROF_NAME, hiredate, dname DEPT_NAME
from professor p
join department d on p.deptno = d.deptno
where hiredate > (select hiredate from professor where name = 'Meg Ryan')
;

--p.432 상단 그림 예제 in()
select empno, name, deptno
from emp2
where deptno in(                     -- in() : 다중값을 인식. 괄호안의 모든 값을 포함
    select dcode
    from dept2
    where area = 'Pohang Main Office')        
;

select dcode
from dept2
where area = 'Pohang Main Office'
;

select *
from dept2
;

-- exists : 값이 존재하면 메인쿼리를 전체적으로 수행하겠다는 의미
select * from dept;

select *
from dept
where exists (select deptno
            from dept
            where deptno = &dno)     -- &dno : 값을 넣을수 있게 팝업으로 만들어줌
;

select *
from dept
where exists (select deptno
            from dept
            where deptno = :dno)     -- :dno : 위와 마찬가지로 값을 넣을수 있게 팝업으로 만들어줌
;


--any,all 조건값
select *
from emp2
where pay > any(50000000,56000000,510000000,49000000)
;

-- p.434 연습문제1
select name, position, to_char(pay,'$999,999,999') salary
from emp2 
where pay > any(select pay from emp2 where position = 'Section head')
;

-- 연습문제2
select name, grade, weight
from student
where weight < all(select weight
from student
where grade=2)
;

-- p.435 연습문제3
select deptno, round(avg(pay))
from emp2
group by deptno, pay
;

select * from emp2
;

select * from dept2;




select d.dname, e.name, e.pay
from emp2 e
join dept2 d on e.deptno = d.dcode
where pay < any(
;