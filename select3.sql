SELECT * FROM tab;

SELECT empno
	  ,ename
	  ,sal
	  ,nvl(comm, 0) AS commission
FROM emp;
-- nvl함수 단일행 함수 ; 한 row에 대해 함수를 실행

SELECT INITCAP(position) AS initcap
	  ,POSITION
	  ,LOWER(UPPER(position)) AS "upper -> lower"
	  ,LENGTH(position) AS "length of position"
	  ,LENGTHB('홍길동') lengthb
-- LENGTHB는 바이트단위로 반환 한글은 1글자에 3바이트 영어는 1글자에 1바이트, LENGTH는 문자 수대로 반환
	  ,name
FROM professor
WHERE LENGTH(name) < 10;

SELECT ename || ', ' || job AS "Name And Job"
	  ,concat(concat(ename, ', '), job) AS "Name And Job concat"
	  -- ||연산자는 중간에 이어붙이는 구분자를 넣는게 쉬운데 concat함수를 써서 표현하려면 두번 중복해서 사용해야된다.
	  -- , * SQL Error [936] [42000]: ORA-00936: 누락된 표현식 ; 이유는 COLUMN 이름이 *인것을 찾는다
	  -- , emp.* 이런 식으로 사용해야함
	  , substr(e.job, 1, 3) AS "short job"
	  -- e.job은 e라는 테이블에서 job이라는 column을 가지고 온다는 뜻
	  , e.*
	  -- table도 alias(별칭)를 사용할 수 있다.
FROM emp e;

SELECT SUBSTR('abcde', -5, 4)
FROM dual;
-- substr(문자열, 시작위치, 크기) 함수는 어떠한 문자데이터에서 몇번째 글자부터 몇개를 가져온다는 뜻으로 사용한다.
-- substr(문자열, 마이너스위치, 크기)도 가능하다. 위치가 마이너스인경우는 뒤에서 몇 번째인지 순서를 파악한다. 크기는 그대로 양수만 가능하다.

-- 문제 emp 테이블의 이름이 J로 시작하는 사람을 출력한다.
SELECT *
FROM emp
WHERE SUBSTR(emp.ename, 1, 1) = 'J';
-- WHERE ename LIKE 'J%';

-- 문제 78p 
SELECT name
	  ,tel 
	  ,instr(tel,')', 2) "location of )" 
	  ,substr(tel, 1, instr(tel, ')', 1) -1) AS "area code"
	  ,instr(tel, ')', 1) +1 "from"
	  ,instr(tel, '-', 1) "to"
	  ,substr(tel, instr(tel, ')', 1) + 1 
	  			 , (instr(tel, '-', 1) - (instr(tel, ')', 1) +1))) AS "contry code"
FROM student
WHERE deptno1 = 201;

SELECT INSTR('telephone', 'e', 5)
FROM dual;
-- 시작위치부터 값을 찾기 시작하는 것이고 찾은 값의 위치 값 반환은 처음부터 세아려서 반환한다. 

SELECT LPAD('abc', 13, '1-')
FROM dual;
-- 왼쪽채우기, // rpad는 오른쪽에 채우기; 자리수를 정해주고 원하는 값을 채워서 자리수를 맞춘다.

SELECT name
	  ,id
	  ,LPAD(ID, 10, '*')
FROM student
WHERE deptno1 = 201;

-- 81p
SELECT LPAD(ename, 9, '123456789') lpad
	  ,RPAD(ename, 9, '-') rpad
FROM emp
WHERE deptno = 10;

-- 82p
SELECT RPAD(ename, 9, SUBSTR('123456789', LENGTH(ename)+1)) rpad
	  ,SUBSTR('123456789', LENGTH(ename)+1) ex
	  -- SUBSTR을 사용할 때 시작위치만 지정해주면 자르는 위치가 문자의 마지막으로 설정하여 문자를 다 가져온다.
FROM emp
WHERE deptno = 10;

SELECT LTRIM('abcde', 'aaa') "LTRIM"
	  ,RTRIM('abcde', 'DDDde') "RTRIM"
	  ,LTRIM('  hello', ' ') "ltrim"
	  ,RTRIM('hello    ', ' ') "rtrim"
	  ,RTRIM(LTRIM('    hello    ', ' '), ' ') "l-rtrim"
	  ,REPLACE('1  hello   2', ' ', '') "replace1"
	  ,REPLACE('1  hello  2', substr('1  hello  2', 2, 1), '') "replace2"
FROM dual;

-- 84p
SELECT ename
	   ,REPLACE(e.ename, SUBSTR(e.ename, 2, 2), '--') replace
FROM emp e
WHERE deptno = 10;

SELECT name
	  ,jumin
	  ,REPLACE(jumin, SUBSTR(jumin, -7), '-/-/-/-') jumin
FROM student
WHERE deptno1 = 101;

SELECT name
	  ,tel
--	  ,REPLACE(tel, SUBSTR(tel, instr(tel, ')') + 1, 3), '***') REPLACE
	  ,REPLACE(tel, SUBSTR(tel, INSTR(tel, ')', 1) + 1, (INSTR(tel, '-', 1) - INSTR(tel, ')', 1)-1)), SUBSTR('*****',1, (INSTR(tel, '-', 1) - INSTR(tel, ')', 1)-1))) replace
--	  ,REPLACE(tel, SUBSTR(tel, 5, 3), '***') replace
--	  ,instr(tel, ')', 1)
FROM student
WHERE deptno1 = 201;

SELECT name
	  ,tel
--	  ,REPLACE(tel, SUBSTR(tel, instr(tel, '-') +1, 4), '****') replace
	  ,REPLACE(tel, SUBSTR(tel, -4, 4), '****') replace
FROM student
WHERE deptno1 = 101;

-- 숫자함수
SELECT round(12.12345, 1) "1번째"
	  ,round(12.12345, 2) "2번째"
	  ,round(12.12345, 3) "3번째"
	  ,round(12.12345, 4) "4번째"
	  ,round(12.12345, 0) "0번째"
	  ,round(12.12345, -1) "-1번째(1의자리수)"
	  ,'12.12345' "원래 수"
	  ,ROUND(12.12345) "라운드"
-- 2번째 매개값의 기본값은 0
FROM dual;
-- 반올림 할 위치 매개값이 마이너스가 되어도 된다.

SELECT TRUNC(12.12345) "기본값"
	  ,TRUNC(12.12345, 1) "1번"
	  ,TRUNC(12.12345, 5) "5번"
	  ,'12.12345' "원래값"
FROM dual;

SELECT MOD(12, 7) "나머지"
	  ,CEIL(12/5) "근접한 큰 정수"
	  ,FLOOR(12/5) "근접한 작은 정수"
	  ,POWER(3, 4) "거듭제곱"
FROM dual;

SELECT hiredate "날짜"
	  ,hiredate + 1 "날짜 + 1일"	  
	  ,SYSDATE "현재 시간 시분초 나옴"
	  ,MONTHS_BETWEEN(SYSDATE, HIREDATE) "오늘까지 몇 달"
	  ,ADD_MONTHS(SYSDATE, -10) "현재시스템 날짜기준 몇 달 뒤"
	  ,NEXT_DAY(SYSDATE, '월요일') "해당 요일이 오는 날짜"
	  -- 원래 영어를 넣는데 지금 데이터베이스 세팅 언어가 한글이라서 한글을 입력
	  ,LAST_DAY(SYSDATE) "이 달의 마지막 날"
	  ,LAST_DAY(ADD_MONTHS(SYSDATE, -1)) "어떤 날의 이전달의 마지막날"
	  ,ROUND(SYSDATE - (3/24)) "정오 기준 날짜 반올림"
	  ,SYSDATE - (3/24) - (1/24/60) "3시간전, 1분전"
	  ,TRUNC(SYSDATE) "시간 버리기"
	  ,TRUNC(SYSDATE, 'mm') "월 단위로 버리기"
FROM emp;

SELECT *
FROM professor;

-- 교수번호, 이름, 급여, 보너스, 근무년수 
-- 근무년수 20년 넘는사람 출력
SELECT profno
	  ,name
	  ,pay
	  ,bonus
	  ,TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)/12) "근무년수"
FROM professor
WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)/12) > 20;

-- 근무년수 10년은 넘고 20년은 안되는 교수의 근무연수를 '15년 3개월'같이
SELECT name
	  ,hiredate
	  ,TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)/12)||'년 '|| MOD(TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)),12) ||'개월' "근속년수"
FROM professor
WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)/12) > 10
AND   TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)/12) < 20;

-- 업데이트
UPDATE professor
SET hiredate = ADD_MONTHS(hiredate, 60)
WHERE 1 = 1;

SELECT 2 + '2' "묵시적 형변환"
	  ,2 + TO_NUMBER('2') "명시적 형변환"
FROM dual;

SELECT SYSDATE "오늘 날짜"
	  -- date값
	  ,TO_CHAR(SYSDATE, 'YYYY"년" MON DD"일" HH24"시"MI"분"SS"초"') AS "연 월 일" 
	  ,TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS "날짜"
	  -- VARCHAR2 값
	  ,TO_CHAR(123456789, '000,999,999,999') "숫자를 문자로 변환"
	  -- 숫자를 문자로 표현할 때 자리수를 9로 표현한다.
	  -- VARCHAR2 값
	  ,TO_DATE('20241222 201010', 'YYYYMMDD HH24MISS') "날짜 값으로 변환"
	  -- DATE 값
	  ,TO_DATE('2025-12-31') "TEST"
FROM dual
WHERE TO_DATE('2025-12-31', 'YYYY-MM-DD') < SYSDATE + 1;

SELECT NVL(null, '0')
FROM dual;

SELECT ename
	  ,sal
	  ,comm
	  ,sal + NVL(comm, 0) "총급여"
--	  ,sal + comm "총급여 null"
	  ,NVL2(comm, sal + comm, sal) "null값 구분하기"
FROM emp;

SELECT DECODE(null, 'null', '같다', '아니다') "if역할 함수"
-- DECODE() oracle에서만 사용하는 함수
-- DECODE(1,2,3,4) 1번이 2번이랑 같은지 비교, 같으면 3, 아니면 4
-- null 값도 비교할 수 있다. 대신 값이 null인지 문자 'null'인지 확인을 잘 해야한다.
FROM dual;

SELECT deptno1
	  ,DECODE(deptno1, 101, 'Computer Eng',
	  				   102, 'Multi Eng',
	  				   103, 'Software Eng',
	  				   'etc') "학과 줄임"
	  ,DECODE(deptno1, 101, '컴퓨터학과', 
	   					DECODE(deptno1, 102, 'multi eng',
	   							DECODE(deptno1, 103, 'software eng', 'etc'))) "학과"
FROM student;
-- 120p
SELECT name
	  ,jumin
	  ,DECODE(SUBSTR(jumin, 7, 1), '1', 'MAN', '2', 'WOMAN') "Gender"
FROM student
WHERE deptno1 = 101;

SELECT name
	  ,tel
	  ,DECODE(SUBSTR(tel, 1, INSTR(tel,')', 1) - 1)
	  		  , '02', 'SEOUL'
	  		  , '031', 'GYEONGGI'
	  		  , '051', 'BUSAN'
	  		  , '052', 'ULSAN'
  		      , '053', 'DAEGU'
	  		  , '055', 'GYEONGNAM'
	  		  , '확인 필요') "LOC"
FROM student
WHERE deptno1 = 101;

-- CASE 구문으로 변경
SELECT name
	  ,tel
	  ,CASE SUBSTR(tel, 1, INSTR(tel, ')', 1) -1) WHEN '02' THEN 'SEOUL'
	  											  WHEN '031' THEN 'GYEONGGI'
	  											  WHEN '051' THEN 'BUSAN'
	  											  WHEN '052' THEN 'ULSAN'
	  											  WHEN '055' THEN 'GYEONGNAM'
	  											  ELSE 'ETC'
	   END "LOC 2"
-- CASE column WHEN '조건' THEN '값'
FROM student
WHERE deptno1 = 201;

SELECT name
	  ,jumin
	  ,CASE SUBSTR(jumin, 7, 1) WHEN '1' THEN 'MAN'
	  							WHEN '2' THEN 'WOMAN'
	  							ELSE 'ETC'
	  END "Gender"
-- CASE 구문은 자동형변환이 안되는 경우도 있으니 자료형을 정확히 적어주자
-- CASE 구문이 데이터베이스 표준 함수, DECODE 구문은 ORACLE 데이터베이스만의 함수
FROM student
WHERE deptno1 = 101;

-- CASE 구문을 통해 범위 지정 조건
SELECT name
	  ,SUBSTR(jumin, 3, 2) "Month"
--	  ,CASE WHEN SUBSTR(jumin, 3, 2) >= '01' AND SUBSTR(jumin, 3, 2) <= '03' THEN '1/4'
--	  		WHEN SUBSTR(jumin, 3, 2) >= '04' AND SUBSTR(jumin, 3, 2) <= '06' THEN '2/4'
--	  		WHEN SUBSTR(jumin, 3, 2) >= '07' AND SUBSTR(jumin, 3, 2) <= '09' THEN '3/4'
--	  		WHEN SUBSTR(jumin, 3, 2) >= '10' AND SUBSTR(jumin, 3, 2) <= '12' THEN '4/4'
	  ,CASE WHEN SUBSTR(jumin, 3, 2) BETWEEN '01' AND '03' THEN '1/4'
	  		WHEN SUBSTR(jumin, 3, 2) BETWEEN '04' AND '06' THEN '2/4'
	  		WHEN SUBSTR(jumin, 3, 2) BETWEEN '07' AND '09' THEN '3/4'
	  		WHEN SUBSTR(jumin, 3, 2) BETWEEN '10' AND '12' THEN '4/4'
	  END "Qua"
FROM student;

-- 123p
SELECT empno
	  ,ename
	  ,sal
	  ,CASE WHEN sal >= '1' AND sal <= '1000' THEN 'LEVEL 1'
	  		WHEN sal > '1000' AND sal <= '2000' THEN 'LEVEL 2'
	  		WHEN sal > '2000' AND sal <= '3000' THEN 'LEVEL 3'
	  		WHEN sal > '3000' AND sal <= '4000' THEN 'LEVEL 4'
	  		WHEN sal > '4000' AND sal <= '5000' THEN 'LEVEL 5'
	  	END "LEVEL"
FROM emp
ORDER BY 4 DESC, 3 DESC;
-- 정규식은 우선 넘어감


-- DESC student; 이건 SQLPLUS 기반의 예약어

-- GROUP(복수행) 함수
-- 부서번호별로 그룹화 하기
-- GROUP BY에 있는 값이 기준, 기준이 가장 작은 단위의 데이터라서 그 안의 세부내용을 더 나누어서 확인할 수 없음
-- GROUP BY가 기준이기에 기준 이외의 값을 가져올 수 없다. 따라서 다른 행을 보려고 하면 GROUP BY 표현식 오류가 생긴다.
-- GROUP BY가 없으면 전체 table에 대해서 분석하겠다라는 의미
-- GROUP BY column으로 사용하는데 출력값은 해당 column의 값을 기준으로 그룹화하여 보여준다.
SELECT deptno
FROM emp
GROUP BY deptno;

SELECT deptno
	  ,COUNT(*) "인원"
	  ,SUM(sal) "부서별 급여"
FROM emp
GROUP BY deptno;

SELECT deptno
	  ,job
	  ,COUNT(*) "수"
-- COUNT(1) 이렇게 적으면 첫 번째 column을 기준으로 세겠다라는 의미, Primary Key라서 무조건 존재해야되며 중복이 안되기때문에 count로 총 갯수를 세기 위해서 자주 사용
	  ,SUM(sal) "직무별 급여합계"
	  ,SUM(sal + nvl(comm,0)) "커미션포함 급여합계"
--	  ,ROUND(SUM(sal + NVL(comm,0)) / COUNT(1)) "직무별 평균 급여"
	  ,ROUND(AVG(sal + NVL(comm,0))) "직무별 평균 급여"
	  ,MIN(sal + NVL(comm,0)) "최저급여"
	  ,MAX(sal + NVL(comm,0)) "최고급여"
	  ,STDDEV(sal) "표준편차"
	  ,VARIANCE(sal) "분산"
FROM emp
GROUP BY deptno, job;

SELECT *
FROM emp;

--p.156~ 복수행 함수
SELECT job
		,sum(sal)
		,count(sal) "n"
		,round(avg(sal)) "직무별 평균 급여" 
FROM emp
GROUP BY job                        -- where 절 조건문
HAVING round(avg(sal)) > 1500       -- having 절 조건문
;

-- 아래와 같이는 표현할수 없음 : where에는 그룹과 상관 없는 조건이 들어와야 됨.
--SELECT job
--		,sum(sal)
--		,count(sal) "n"
--		,round(avg(sal)) "직무별 평균 급여" 
--FROM emp
--WHERE round(avg(sal)) > 1500         
--GROUP BY job                      
--;


-- 위에 having을 쓴것과 결과값이 다름 : salesman 에 1600이 나타남 : 1500보다 큰 사람을 소팅 한 후에 그룹을 지어 버림
SELECT job
		,sum(sal)
		,count(sal) "n"
		,round(avg(sal)) "직무별 평균 급여" 
FROM emp
WHERE sal > 1500
GROUP BY job                      
;

-- p.165~ rollup 함수 : 사용하지 않고도 쿼리를 여러개 만들어 표현 가능하나, 쉽게 해주는 기능
-- 1. 직무별로 평균급여, 사원수 구하고 싶을때.
SELECT deptno, job, avg(sal), count(1)
FROM EMP
GROUP BY deptno, JOB
;

--2. 부서별 평균급여, 사원수
SELECT deptno, '', avg(sal), count(1)
FROM EMP
GROUP BY  deptno
;

--3. 전체 평균 급여, 사원수
SELECT '전체', '합계', round(avg(sal)), count(1)
FROM EMP
ORDER BY 1,2
;



-- 1번과 2번을 합쳐서 표현
SELECT deptno, job, avg(sal), count(1)
FROM EMP
GROUP BY deptno, JOB
UNION all
SELECT deptno, '', avg(sal), count(1)
FROM EMP
GROUP BY  deptno
ORDER BY 1,2
;

-- 1,2,3번을 합쳐서 표현                    ||'' <- 문자형태로 표시하겠다는 의미 : deptno는 숫자 데이터임
SELECT deptno||'', job, round(avg(sal)), count(1)
FROM EMP
GROUP BY deptno, JOB
UNION all
SELECT deptno||'', '소계', round(avg(sal)), count(1)
FROM EMP
GROUP BY  deptno
UNION ALL
SELECT '전체', '합계', round(avg(sal)), count(1)
FROM EMP
ORDER BY 1,2
;


-- 위와 같은 표현을 roll up 함수 사용하여 표현     *참고로 숫자는 오른쪽 정렬, 문자는 왼쪽정렬됨. deptno를 ||''로 문자로 연결해줬으니 왼쪽정렬됨
SELECT nvl(deptno||'', '전체') dept
 		,decode(deptno, NULL, '합계', nvl(job, '소계')) job
 		,round(avg(sal))
 		,count(1)
FROM emp
GROUP BY rollup(deptno, job)
ORDER BY 1,2
;


--p.220~ join 함수
SELECT *
FROM emp
;

SELECT *
FROM dept
;

-- 상기 2개 테이블 연결
SELECT *
FROM emp
JOIN dept ON emp.deptno = dept.deptno
;

-- 아래와 같이 줄여서 표현함 : driving 테이블 => 선행테이블. 먼저 읽는 테이블. 후에 읽는 것은 driven table 이라고 함.
SELECT *
FROM emp e
JOIN dept d ON e.deptno = d.deptno
;

-- 보고싶은 테이블을 select에 지정해서 볼 수 있음
SELECT e.*
FROM emp e
JOIN dept d ON e.deptno = d.deptno
;

SELECT d.*
FROM emp e
JOIN dept d ON e.deptno = d.deptno
;

SELECT empno, ename, dname, loc, e.deptno   --deptno는 중복 테이블이므로, 어느 테이블인지 지정 해줘야 표현 가능함
FROM emp e
JOIN dept d ON e.deptno = d.deptno
;

--join 조건이 없으면 중복값이 모두 표현됨(10개 값 x 10개값 = 100개값 보여줌)
SELECT empno, ename, dname, loc, e.deptno
FROM emp e
     ,dept d
WHERE ename = 'KING'
;

-- join 사용하면 중복값 제거하고 합쳐서 표현됨
SELECT empno, ename, dname, loc, d.deptno
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE ename = 'KING'
;

SELECT empno, ename, dname, loc, d.deptno
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE dname = 'ACCOUNTING'
;

-- ANSI join 문법 vs Oracle join 문법
SELECT empno, ename, dname, loc, d.deptno
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE dname = 'ACCOUNTING'   -- ANSI 문법
;

SELECT empno, ename, dname, loc, d.deptno
FROM emp e
     ,dept d
WHERE e.deptno = d.deptno
AND dname =  'ACCOUNTING'       -- Oracle 문법
;

-- join은 2개 이상 테이블 사용 가능
-- 학생, 교수, 학과 join 해보기 (학생을 선행테이블 기준으로)
-- 학번, 이름, 담당교수 이름, 학과명
SELECT *
FROM STUDENT
;

SELECT *
FROM professor
;

SELECT *
FROM DEPARTMENT
;

SELECT s.studno "학번"
		,s.name "학생이름"
		,p.name "교수이름"
		,d.dname "학과명"
FROM student s
JOIN professor p ON s.profno = p.profno
JOIN department d ON s.deptno1 = d.deptno
;

-- p.236~ non-equi join(비등가조인)
SELECT *
FROM customer
;

SELECT *
FROM gift
;

SELECT c.GNAME 
		,c.POINT 
		,g.gname
FROM customer c
JOIN gift g
ON c.point BETWEEN g.g_start AND g.g_end
;

-- 똑같은 의미로 between을 아래과 같이 표현 가능
SELECT c.GNAME 
		,c.POINT 
		,g.gname
FROM customer c
JOIN gift g
ON c.point >= g.g_start AND c.point <= g.g_end
;

--예제 : 학생.학점

SELECT *
FROM student
;

SELECT *
FROM score
;

SELECT *
FROM HAKJUM
;

SELECT t.STUDNO
       ,t. NAME 
       ,s.total
FROM student t
JOIN SCORE s
ON s.studno = t.STUDNO
;

SELECT t.STUDNO 
		,t.NAME 
		,s.TOTAL 
		,h.grade
FROM student t
JOIN SCORE s
ON s.studno = t.STUDNO
JOIN hakjum h
ON s.total >= h.MIN_POINT AND s.total <= h.MAX_POINT 
ORDER BY 3 desc
;

-- p.254 연습문제 1번
SELECT *
FROM student
;
SELECT *
FROM DEPARTMENT d 
;

SELECT s.name
		,s.DEPTNO1 
		,d.dname
FROM STUDENT s 
JOIN DEPARTMENT d 
ON s.deptno1 = d.deptno
;

-- p.254 연습문제 2번
SELECT *
FROM EMP2 e 
;

SELECT *
FROM P_GRADE pg 
;

SELECT e.name
		,e."POSITION" 
		,e.pay
		,pg.S_PAY AS "Low PAY"
		,pg.E_PAY  AS "High PAY"
FROM emp2 e
JOIN P_GRADE pg 
ON e.POSITION = pg."POSITION" 
;

-- p.255 연습문제 3번
SELECT *
FROM P_GRADE pg 
;

SELECT *
FROM EMP2 e 
;

SELECT e.name		
		,trunc(MONTHS_BETWEEN(sysdate,e.BIRTHDAY)/12) "AGE"
		, e."POSITION" "CURR_POSITION"
		,g.POSITION BE_POSITION
FROM EMP2 e 
JOIN p_grade g
ON trunc(MONTHS_BETWEEN(sysdate,e.BIRTHDAY)/12) >= g.S_AGE 
AND trunc(MONTHS_BETWEEN(sysdate,e.BIRTHDAY)/12) <= g.E_AGE 
ORDER BY 2 desc
;

SELECT e.name		
		,trunc(MONTHS_BETWEEN(sysdate,e.BIRTHDAY)/12) "AGE"
		, e."POSITION" "CURR_POSITION"
		,g.POSITION BE_POSITION
FROM EMP2 e 
JOIN p_grade g
ON trunc(MONTHS_BETWEEN(sysdate,e.BIRTHDAY)/12)
between g.S_AGE AND g.E_AGE
ORDER BY 2 desc
;

-- row 데이터 변경
--UPDATE EMP2
--SET birthday = ADD_MONTHS(birthday, -96)
--WHERE 1=1
--;


--p240~ outer join
SELECT *
FROM STUDENT s
JOIN professor p ON s.profno = p.profno  --student 데이터는 20명이나, professor와 join하면 15명으로 줄어듬 => profno가 null값인 5명 때문
;

SELECT s.studno "학번"
		,s.name "학생이름"
		,p.profno "교수번호"
		,p.name "교수이름"
FROM STUDENT s
LEFT OUTER JOIN professor p ON s.profno = p.profno    -- left outer join : 왼쪽 테이블을 기준으로 join (student의 driving table 데이터 값을 모두 살려서 가져옴)
;

SELECT s.studno "학번"
		,s.name "학생이름"
		,p.profno "교수번호"
		,p.name "교수이름"
FROM STUDENT s
right OUTER JOIN professor p ON s.profno = p.profno    -- right outer join : 오른쪽 테이블을 기준으로 join (professor의 driving table 데이터 값을 모두 살려서 가져옴)
;

SELECT s.studno "학번"
		,s.name "학생이름"
		,p.profno "교수번호"
		,p.name "교수이름"
FROM STUDENT s
full OUTER JOIN professor p ON s.profno = p.profno    -- full outer join : 양쪽 데이터 값을 모두 살려서 가져옴
;

--p250~ SELF join : 다른 테이블끼리 묶는게 아니라 한 테이블에서 데이터 값을 모두 추출하여 join으로 나타낼때.
SELECT e1.empno "사원번호"
		,e1.ename "사원이름"
		,e2.empno "관리자번호"
		,e2.ename "관리자이름"
FROM EMP e1
LEFT OUTER JOIN emp e2    -- emp 하나의 테이블만 사용하였음.
ON e1.mgr = e2.empno
;

SELECT *
FROM EMP e 
;

--p.255 연습문제 4
SELECT *
FROM CUSTOMER c
ORDER BY 4 desc
;

SELECT *
FROM GIFT g 
;

SELECT c.GNAME 
		,c.POINT 
		,g.gname
FROM CUSTOMER c 
JOIN gift g
ON c.point >= 600000 
WHERE g.Gno  = 7
;


--p.256 연습문제 5
SELECT *
FROM PROFESSOR p 
;

SELECT p1.profno 
		,p1.name
		,p1.HIREDATE 
		,count(p1.HIREDATE) count
FROM PROFESSOR p1
JOIN PROFESSOR p2
ON p1.HIREDATE  > p2.HIREDATE 
;

SELECT NAME
		,count(HIREDATE)
FROM professor
;

SELECT p1.profno 
		,p1.name
		,p1.HIREDATE
		,count(p2.HIREDATE) COUNT
FROM PROFESSOR p1
JOIN professor p2
ON p1.HIREDATE = p2.HIREDATE
WHERE p1.HIREDATE  > p2.HIREDATE 
GROUP BY p1.profno, p1.name, p1.HIREDATE
;


SELECT p1.profno 
		,p1.name
		,TO_CHAR(p1.HIREDATE, 'YYYY/MM/DD') hiredate
FROM PROFESSOR p1
JOIN professor p2
ON p1.HIREDATE = p2.HIREDATE
GROUP BY p1.profno, p1.name, p1.HIREDATE
;