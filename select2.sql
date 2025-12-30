-- 조건을 지정하고 그 값만 불러오기 : WHERE 조건절 작성
SELECT * 
from emp
WHERE sal < 3000
;

SELECT * 
from emp
WHERE sal < 3000
AND job = 'SALESMAN'     -- 조건을 추가로 달때는 AND 사용(모두만족)
;

SELECT ename, sal "인상전 급여" , sal * 1.1        -- 조회된 값에 조건을 추가하여 표시
as "인상된 급여"
from emp
WHERE sal < 3000
AND job = 'SALESMAN'
;

SELECT ename
, sal "인상전 급여" 
, sal + comm "총급여"     -- 테이블 끼리 값을 연산할수도 있음
, sal * 1.1 
as "인상된 급여"
from emp
WHERE sal < 3000
AND job = 'SALESMAN'
;

SELECT ename
, sal "인상전 급여" 
, sal + comm "총급여"
, (sal + comm) * 1.1       -- 괄호로 묶어서 연산 적용 가능
as "인상된 급여(급여+보너스)"
from emp
WHERE sal < 3000
AND job = 'SALESMAN'
;

SELECT ename
, sal "인상전 급여" 
, sal + comm "총급여"
, (sal + comm) * 1.1 
as "인상된 급여(급여+보너스)"
from emp
WHERE sal < 3000
AND job = 'SALESMAN'
ORDER BY ename;        -- 이름 순으로 정렬
;

SELECT ename
, sal "인상전 급여" 
, sal + comm "총급여"
, (sal + comm) * 1.1 
as "인상된 급여(급여+보너스)"
from emp
WHERE sal < 3000
AND job = 'SALESMAN'
ORDER BY ename desc;        -- 이름 순으로 역순으로 정렬, 구문 순서 중요!!
;

SELECT *
FROM emp
WHERE sal > 2000
OR job = 'SALESMAN';         -- OR 조건값으로 설정 가능(또는 만족)

SELECT *
FROM emp
WHERE sal <= 3000             -- 범위를 지정 가능(AND활용)
and sal >= 2000;

SELECT *
FROM emp
WHERE sal between 2000 AND 3000;  -- 상기 값은 between AND 로 활용 가능(시작 및 끝 값 포함)

SELECT *
FROM emp
WHERE hiredate between '81/01/01' AND '81/12/31'    -- date 유형도 활용 가능
ORDER BY hiredate;


-- in (a,b,c)   : 해당 값만 출력. 범위개념이 아님을 주의.

SELECT *
FROM emp
WHERE deptno in (10,30);     -- in (a,b,c) 에서 값을 3개 미만 설정할수도 있음

SELECT *
FROM emp
WHERE deptno in (10,20)
AND ename in ('SMITH', 'FORD');     -- 문자열도 사용 가능

SELECT *
FROM emp
WHERE deptno in (10,20)
AND ename NOT in ('SMITH', 'FORD');     -- NOT을 사용하여 제외 필터링도 가능

-- is null / is not null  여기서 null은 공백과는 다른 개념. 연산을 하지 못하는 값을 지칭하는 것임.
SELECT *
FROM emp
WHERE comm is null;  -- 연산을 하지 못하기 때문에 WHERE comm = null;   요렇게는 사용할수 없음.

SELECT *
FROM emp
WHERE comm is not null;   -- 0인 값도 가져옴(0은 null값이 아님)

-- LIKE  : 유사하다는 개념임. same과는 다른 개념. %와 _ 사용
SELECT *
FROM emp
WHERE ename LIKE '%LA%';    -- 여기서 %는 모든값 이라는 뜻임.즉, LA를 포함한 모든 값

SELECT *
FROM emp
WHERE ename LIKE '%LA';    -- LA로 끝나는 값이라는 의미. 해당값 없음

SELECT *
FROM emp
WHERE ename LIKE '_LA%';    -- 언더바는 글자 하나에 대응한다는 의미. 즉, LA 앞에 글자 하나 포함하면 출력

--연산자 예제--
-- 참고 : primary key : id나 고유번호 처럼 중복된 값이 존재하지 않는 값을 의미 / professor 에서는 profno값.
SELECT *
FROM professor;

SELECT *
FROM department;   --여기서 101과 103과 2개 과의 교수님만 위에서 조회하고 싶음

SELECT *
FROM professor
WHERE deptno in(101, 103)
AND profno like '3%';   -- 위에서 profno가 3으로 시작하는 값만.

SELECT *
FROM professor
WHERE deptno in(101, 103)
AND position NOT in ('a full professor');  -- position 에서 full을 포함하지 않는 값만--


SELECT *
FROM professor
WHERE bonus is null and pay >= 300
or pay+bonus >= 300                    -- 300 넘게 받는 사람 중에 null값인 사람도 포함
;

-- 위의 방식을 nvl을 통해 간략히 표현 가능함 => nvl(경로,치환값 ) : null값인 경우에 그것을 치환해 주는 명령어
SELECT *
FROM professor
WHERE pay + nvl(bonus, 0) >= 300
;

select *
from employees;   -- scott 계정은 이거 조회 권한 없음

-- p.59 집합연산자
-- 교수, 학생 두가지를 가지고 => 교수(학생)번호 / 이름 / 학과정보 취합하여 출력하고자 함. 각 테이블에서 정보 가져와야함
SELECT profno, name, deptno  -- 교수정보
FROM professor
;
SELECT studno, name, deptno1  -- 학생정보
FROM student
;

SELECT profno, name, deptno
FROM professor
UNION ALL                      -- UNION ALL : 중복값 있어도 모두 출력
SELECT studno, name, deptno1
FROM student
;


SELECT profno, name, deptno
FROM professor
UNION                      -- UNIONL : 중복값 제외 하고 출력
SELECT studno, name, deptno1
FROM student
;

-- UNION 예시 --
SELECT studno, name
FROM student                   -- 4건
WHERE deptno1 = 101
;
SELECT studno, name
FROM student                  -- 2건
WHERE deptno2 = 201
;

SELECT studno, name
FROM student
WHERE deptno1 = 101
UNION ALL                       -- 6건
SELECT studno, name
FROM student
WHERE deptno2 = 201
;

SELECT studno, name
FROM student
WHERE deptno1 = 101
UNION                   -- 5건(중복1개 제외)
SELECT studno, name
FROM student
WHERE deptno2 = 201
;

SELECT studno, name
FROM student
WHERE deptno1 = 101
UNION ALL                  
SELECT studno, name
FROM student
WHERE deptno2 = 201
order by 1           -- 정렬해서 출력
;

-- INTERSECT
SELECT studno, name
FROM student
WHERE deptno1 = 101
INTERSECT                 -- INTERSECT : 중복값(교집합)만 출력
SELECT studno, name
FROM student
WHERE deptno2 = 201
order by 1         
;

-- MINUS : 쿼리의 순서가 중요!
SELECT studno, name
FROM student
WHERE deptno1 = 101
MINUS                 -- MINUS : 차집합 출력 => 101에서 201과의 중복값을 빼고 나머지 101 출력.
SELECT studno, name
FROM student
WHERE deptno2 = 201
order by 1         
;

-- p40 연습문제 3
SELECT ename || '''s sal is $' || sal
AS "Name And Sal"
FROM emp
;



