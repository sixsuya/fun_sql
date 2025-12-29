-- SCOTT 계정소유의 테이블 목록 조회.
-- SQL : structured Query language
select * from tab;
-- table / columm 구분해야 함

select * from customer;
-- *는 전체 column을 보겠다는 의미

desc customer;
- 테이블의 구조 확인 (데이터 타입 확인 가능)

select gno, gname from customer;
-- 원하는 column만 보는 방법

select * from professor;

select * from student;

select studno, name from student;

SELECT studno, NAME
FROM student;
-- 명령어(키워드)는 대문자로 보통 사용함 / 명령어를 줄 바꿔서 사용하기도 함

SELECT 'hello, ' || name as "name"    -- alias(별칭) : 칼럼명을 지정
FROM student;
-- 'hello, ' ||     <- 문자열과 데이터를 연결해서 볼 수 있는 기능
-- "name" <- 제목부분의 칼럼명을 내가 원하는 형태로 볼 수 있는 기능

SELECT 'hello, ' || name as name    -- ""를 안쓰면 대문자로 표시함. 대소문자 구분하고 싶으면 ""사용해야함
FROM student;

SELECT * 
FROM department;  --department : 학과 / dept : 부서정보(emp 칼럼과 연관)

SELECT *
FROM emp;       -- DEPTNO 조회 가능하고, 이것의 정보가 dept에 있음

SELECT DISTINCT deptno   -- 중복된 값 제거해서 표기
FROM emp;

SELECT distinct deptno, ename   -- deptno, ename 2개를 중복을 같이 계산해서 보여줌
FROM emp;

SELECT distinct deptno, ename
FROM emp
order by deptno;       -- 정렬해서 보여주는 기능

SELECT distinct deptno, ename
FROM emp
order by ename; 

SELECT '부서번호는 ' || deptno || ', 이름은 ' || ename    -- 컬럼이 합쳐져서 표현됨
FROM emp
order by ename; 

SELECT '부서번호는 ' || deptno || ', 이름은 ' || ename 
  as "Name with Dept"            -- 칼럼명을 지정
FROM emp
order by ename; 

-- p39 연습문제 1번 --
SELECT '''s'           -- '를 표시하고 싶으면 그 앞에 '를 하나 더 붙임.
FROM dual;       -- 표시되는 형식을 체크해보고 싶을때 사용하는 구문

SELECT  name || '''s ID: ' || ID || ' , WEIGHT IS ' || weight || 'kg'
as "ID AND WEIGHT"
FROM student;

SELECT  name || q'['s ID: ]' || ID || ' , WEIGHT is ' || weight || 'kg'   -- q'[]' 로 괄호 안의 문구로 표현 가능
as "ID AND WEIGHT"
FROM student;

SELECT * from emp;

-- p.39 연습문제 2번 --
SELECT ename || '(' || job || '), ' || ename || '''' || job || ''''
as "NAME AND JOB"
from emp;

SELECT ename || q'[(]' || job || q'[), ]' || ename || q'[']' || job || q'[']'
as "NAME AND JOB"
from emp;