-- p.68~ 함수

-- initcap

SELECT initcap(position) AS "InitCap"   -- 첫 글자를 대문자료 표시
       ,upper(POSITION) AS "uppercase"  -- 전체 대문자로 표시
       ,lower(position) AS "lowercase"  -- 전체 소문자로 표시
       ,length(position)                -- 글자수를 표시
       ,length('홍가나')                 -- 한글도 글자수는 영어와 같음
       ,lengthb(position)               -- 글자수를 byte로 표시
       ,lengthb('홍가나')                 -- 한글은 한글자에 3byte       
FROM professor
WHERE length(name) < 10;
;

SELECT ename || job
AS "Name And Job"
FROM emp
;

SELECT ename || ',' || job AS "Name And Job"   -- 함수보다 더 간단히 표시 편함(중간에 값을 추가한다거나 하는 작업들)
       ,concat(ename, job) AS "NAme job"       -- 두 문자열을 합쳐서 출력
       ,concat(concat(ename, ','), job) AS "NAme job"       -- 사이에 추가로 뭔가를 적으려면 함수를 여러번 사용해야 함
       , emp.*                         -- 중간에는 * 표시로 데이터 불러오면 에러가 나서 'table명.*' <- 이런식으로 사용해야 함
FROM emp
;

SELECT ename || ',' || job AS "Name And Job"   -- 함수보다 더 간단히 표시 편함(중간에 값을 추가한다거나 하는 작업들)
       ,concat(ename, job) AS "NAme job"       -- 두 문자열을 합쳐서 출력
       ,concat(concat(ename, ','), job) AS "NAme job"       -- 사이에 추가로 뭔가를 적으려면 함수를 여러번 사용해야 함       
       ,e.*                           -- 테이블 이름이 길면 적기 힘드니, FROM 란에 테이블명 옆에 약어를 쓴 후, 약어로 호출 가능
FROM emp e                            -- emp 옆에 약어 e로 표시함
;

SELECT 'abcde', (3*2)               
FROM dual                          -- 더미 값으로 가져와서 테스트 해보는 방법
;

SELECT substr('abcde',1,2)          -- 문자 잘라서 가져오는 함수. 여기서는 첫번째부터 시작해서 2개 잘라 오겠다는 뜻
       ,substr('abcde', 2, 3)       -- 이거는 두번째부터 3개 잘라오겠다
       ,substr('hello', -3, 3)       -- 마이너스 값은 뒤에서부터 계산. 여기서는 뒤에서 3번째 부터 3개 잘라오겠다는 뜻.
       ,length('hello, world')   -- 구문도 스페이스바 포함하여 제일 뒤부터 계산함.
       ,substr('hello, world', -3, 2)   -- 구문도 스페이스바 포함하여 제일 뒤부터 계산함.
FROM dual
;

SELECT ename || ',' || job AS "Name And Job" )
       ,substr(e.job,1,3) AS "short Job"       --
       ,e.*                          
FROM emp e                          
;

--교수님 예제
SELECT e.*
FROM emp e  
WHERE substr(e.ename, 1, 1) = 'J'    -- 이름이 J로 시작하는 사람만 출력
;

--p.78 사용예1 풀이 : deptno1의 값이 201인 학생 중에서 tel이 ')'가 있는 위치
SELECT name, tel, deptno1
FROM student
;

SELECT tel
      ,instr(tel,')',1) "Location of )"   --첫번째 부터 시작해서 )가 나오는게 몇번째 위치인지 출력
      ,substr(tel,1,instr(tel,')',1)) AS "Local No"    --instr과 substr을 활용해서 지역번호를 출력해 주는 구문
FROM student
WHERE deptno1 = 201
;

--p.79 퀴즈
SELECT name
--      ,instr(tel,')',1) "Location of )"   --첫번째 부터 시작해서 )가 나오는게 몇번째 위치인지 출력
      ,tel
      ,substr(tel,1,instr(tel,')',1)-1) AS "AREA CODE"    -- -1을 통해 )를 표시 안하고 숫자만 표시
FROM student
WHERE deptno1 = 201
;

-- p.79 퀴즈를 활용 : 가운데 전화번호만 표시
SELECT name
      ,tel
      ,instr(tel, ')',1)+1 AS "from"    -- )를 포함하여 앞까지 차지하는 길이 계산
      ,instr(tel,'-',1) AS "to"         -- - 앞까지 길이 계산
      ,substr(tel, instr(tel, ')', 1) + 1,     -- ) 다음부터 시작해서
       (instr(tel,'-', 1) - (instr(tel, ')',1)+1))) AS "국번"   -- to와 from 길이 차이를 통해 가운데 자리수를 계산하여 그만큼 출력
FROM student
WHERE deptno1 = 201
AND substr(tel, 1, instr(tel, ')', 1) - 1) = '02'   -- 지역번호 02인 사람들만 추출
;

-- p.80 LPAD() 함수
SELECT LPAD('abc',5,'-')   -- 5자리를 채우는데 왼쪽부터 -로 채운다는 뜻. abc는 3자리이므로 5자리까지 2자리를 -로 왼쪽부터 채웠음
FROM dual
;

SELECT studno
       ,name
       ,id
       ,length(ID)
       ,lpad(id,10,'*')       
FROM student
WHERE deptno1 = 201
;

-- p.81 퀴즈 및 RPAD() 함수
SELECT lpad(ENAME, 9, '12345678') Lpad 
       ,length(ENAME)
       ,rpad(ENAME, 9, '-') rpad
FROM emp
WHERE deptno = 10
;

--rpad를 통해 숫자로 채워넣기
SELECT length(ENAME)
       ,substr('123456789',(LENGTH(ENAME)+1),9)
       ,rpad(Ename,9,substr('123456789',(LENGTH(ENAME)+1),9)) rpad2
FROM emp
WHERE deptno = 10
;

SELECT length(ENAME)
       ,substr('123456789',(LENGTH(ENAME)+1),9)
       ,rpad(Ename,9,substr('123456789', LENGTH(ENAME)+1)) rpad2     -- substr에 끝깞 지정 안해주면 마지막 위치로 확인
FROM emp
WHERE deptno = 10
;

-- p.82 LTRIM() , RTRIM()함수 : 빈공간 제거, 혹은 특정 문자 제거
SELECT ltrim('abcde','abc')
		,rtrim('abcde','de')
		,ltrim('     abcde')
		,rtrim('     abcde           ')
		,LENGTH(rtrim('     abcde           '))
		,ltrim(rtrim('     abcde           '))
		,LENGTH(ltrim(rtrim('     abcde           ')))
FROM dual
;

-- p.83 REPLACE() 함수 : 대체 하는 함수

SELECT ltrim('abcde','abc')
--		,rtrim('abcde','de')
--		,ltrim('     abcde')
--		,rtrim('     abcde           ')
--		,LENGTH(rtrim('     abcde           '))
--		,ltrim(rtrim('     abcde           '))
--		,LENGTH(ltrim(rtrim('     abcde           ')))
		,replace(' hello ', ' ', '')
		,length(replace(' hello ', ' ', ''))   -- 공백을 찾아서 제거함
		,replace(' hello ', ' ', '*')          -- 공백을 찾아서 *로 교체함
FROM dual
;


-- p.84 replace 퀴즈 1~4
SELECT REPLACE(e.ename, substr(e.ename,2,2), '--') rep1
		, e.job
		,e.*
FROM emp e
WHERE deptno = 10
;

SELECT e.name
		,e.jumin
		,replace(e.jumin, substr(e.jumin,7),'-/-/-/-') rep2
		,e.*		
FROM student e
WHERE deptno1 = 101
;

SELECT e.name
		,e.tel
		,replace(e.tel,substr(tel, instr(tel, ')', 1) + 1,(instr(tel,'-', 1) - (instr(tel, ')',1)+1))),'***') rep3
		,substr('****',1, instr(tel, '-', 1) - instr(tel,')', 1) -1)
		,replace(e.tel
				,substr(tel
						, instr(tel, ')', 1) + 1
						,instr(tel,'-', 1) - instr(tel, ')',1)+1)
				,substr('****'
				,1
				,instr(tel,'-', 1) - instr(tel, ')',1)-1)) rep3#
		,e.*		
FROM student e
WHERE deptno1 = 201
;

SELECT e.name
		,e.tel
		,substr(e.tel,instr(e.tel,'-')+1,4)
		,replace(e.tel,substr(e.tel,instr(e.tel,'-')+1,4),'****') rep4
		,e.*		
FROM student e
WHERE deptno1 = 101
;

-- p.86 숫자관련 함수들
SELECT round(12.345,1) round1  -- 소수점 반올림해서 몇번째 자리까지 표시하겠다.
		,round(12.345,2) round2	
		,round(124545.345,-4) AS "round-4" -- 마이너스를 통해 소수점 윗자리도 가능
		,round(12.345)		  round0 -- 뒷자리 지정 안하면 소수점 버림
		,trunc(12.345,2)  trunc     -- trunc => 버림
		,mod(12,5)        mod     -- %와 같은 의미. 나누고 나머지값 출력
		,ceil(12/5) ceil          -- 2.4인데 올림해서 3으로 나타냄
		,floor(12/5) floor       -- 2.4인데 버림해서 2로 나타탬
		,power(3,3)  power           -- n승으로 곱함
FROM dual
;

--p.89 날짜 관련 함수
SELECT ename AS name
        ,hiredate
		,hiredate+1 AS "hire+1"    -- 숫자 1은 날짜 하루 개념으로 더해짐
		,sysdate AS "sysdate"                   -- 현재 시스템의 날짜와 시간 표시. 함수지만 괄호 없이 사용. 초까지 나옴. 소수점 아래 초단위로는 안나옴
		,round(months_between(sysdate,hiredate)) AS "m.b"   -- 두 날짜사이에 몇달이 차이나는지 출력. 소수점으로 표시됨
		,ADD_MONths(hiredate,-1) AS "add.month"  -- 날짜에서 1달을 더해줌. 각 달의 길이를 반영함
		,next_day(sysdate-7,'수')  -- 지정 날짜 기준으로 그 다음 돌아오는 요일의 날짜를 출력
		,last_day(sysdate)   -- 지정 날짜 기준 그 달의 마지막 날짜를 출력
		,last_day(add_months(sysdate,-1))  -- 저번달의 마지막 날 출력
		,round(sysdate)  -- 날짜를 반올림함 : 정오를 기준으로 지나면 다음날 출력
		,round(sysdate-(3/24))  -- 3시간 전을 의미함, 현재 14시 57분으로 3시간 전이면 11시 57분으로 정오 전이라 내림되어서 12월 30일로 표기됨
		,trunc(sysdate,'mm')   --일자와 시간을 다 버리고 해당월 첫째날 시작시간으로 출력
FROM emp
;

-- 교수님 예제 : professor에서 근무년수가 20년이 넘는 교수의 profno, name, pay, bonus 표시하고 근무년수를 'n년'으로 표시되게. 소수점은 버림
SELECT profno
	,name
	,pay
	,bonus
--	,hiredate
--	,round(months_between(sysdate,hiredate)) AS period	
	,'근무년수(' || trunc(months_between(sysdate,hiredate)/12) || '년)' AS "근무년수"
FROM professor
WHERE round(months_between(sysdate,hiredate)) > (20*12)
;

--UPDATE professor
--SET hiredate = add_months(hiredate, 5*12)    -- hiredate 값 조정
--WHERE 1=1
--;

-- 교수님 예제2 : 근속년수 10년 넘고 20년 미만인 사람의 근속년수 개월까지 나오게.
SELECT profno
	,name
	,pay
	,bonus
--	,hiredate
--	,round(months_between(sysdate,hiredate)) AS period	
--	,mod(trunc(months_between(sysdate,hiredate)),12) AS period2	
	,trunc(months_between(sysdate,hiredate)/12) || '년 ' || mod(trunc(months_between(sysdate,hiredate)),12) || '개월' AS "근무기간"
FROM professor
WHERE round(months_between(sysdate,hiredate)) >= (10*12)
AND round(months_between(sysdate,hiredate)) < (20*12)
;

-- p.99~ 형 변환 함수
SELECT 2+ '2' auto   -- 묵시적 형변환 : 숫자 + 문자 타입은 원래 계산이 안되야 하나, 오라클에서는 묵시적 변환으로 자동 변환으로 적절하게 인식해줌
		,2 + to_number('2') manual  -- 명시적 형 변환
FROM dual
;

SELECT sysdate              -- date 값
		,to_char(sysdate,'YYYY') yyyy -- varchar2   => 연도만 가져와서 출력
		,to_char(sysdate,'MM')  mm  -- 달만 가져와서 출력
		,to_char(sysdate,'YYYY - MM - DD') FULLday -- 연도,달,일 사이에 구분값 형태는 원하는 대로 지정할 수 있음
		,to_char(sysdate,'YYYY MM  DD HH:MI:SS') HOUR  -- 시간단위까지도 표시 가능
		,to_char(sysdate,'HH24:MI:SS') HOUR  -- 24시간단위도 표시 가능
		,to_char(123456789.12,'999,999,999.99') num -- 숫자도 변경하여 표시 가능하며, 가운데 쉼표 구분값 표현도 되고, 소수점도 가능함
		,to_char(123456789.12,'00,999,999,999.99') num -- 뒤에 자리수 범위가 달라도 앞에 0으로 표시해서 나타낼수도 있음
		,to_date('202405','YYYYMM') dt             -- 문자열을 date 값으로 변환
		,to_date('2024-05','YYYY-MM') dt2           -- 구분값을 동일한 형식으로 맞춰 줘야 함(하이픈은 하이픈, 붙여쓰는건 붙여쓰는거)
		,to_date('2024-05-06','YYYY-DD-MM') dt3     -- 연-일-월 순서로 지정했으니, 연월일 순이 아니라 연일월 순으로 인식함
		,to_date('2024-05-06 101112','YYYY-MM-DD HHMISS') dt4      -- 시간도 표현 가능함. 구분값을 동일한 형식으로 맞춰 줘야 함
FROM dual
--WHERE sysdate > sysdate + 1   -- false, true 값을 설정하여 구문을 표현 하느냐 안하느냐로 사용 가능
--WHERE '2025-12-31' < sysdate + 1   -- 앞이 문자 구문이나, 자동형변환을 통해 뒷쪽의 값을 계산하여 true로 판단하여 값을 표시해주고 있음
WHERE to_date('2025-12-31', 'YYYY-MM-DD') < sysdate+1  -- 수동형변환 통해 true로 인식하도록 형변환 진행함
;

-- p.110~ 일반함수
SELECT ename
		,nvl('hello','0') null0      -- null값이 아니면 데이터 그대로 표현함
		,comm
		,sal
--		,sal + nvl(comm, 0) AS "총급여"   
--		,sal + comm AS "총급여2"      -- null + 다른값은 null로 연산됨
--		,sal + nvl2(comm,comm,0) null2   -- nvl2() : if else 느낌으로 null 값일때 반환값이랑 아닐때 반환값을 구분해서 출력가능
		,nvl2(comm,sal+comm,sal) null3
FROM emp
;

-- p.113~ decode()함수 : ORACLE 에서만 사용 가능 함수
SELECT decode('a', 'a', '같다','다르다') de1   -- 데이터 2개를 비교해서 맞을때 출력값과 다를때 출력값을 구분해서 출력함
		,decode(null, 'null', '같다','다르다') de2   -- null값과 'null'값은 다름.
FROM dual
;

-- 범위 주석표시( /* */)
/*
101	Computer Engineering
102	Multimedia Engineering                 
103	Software Engineering
그외 기타
 */
SELECT deptno1
		,decode(deptno1, 101, 'Computer Engineering', 'ETC') AS dept
		,decode(deptno1, 101, 'Computer Engineering', 
	     	decode(deptno1, 102, 'Multimedia Engineering', 'ETC')) AS dept2  -- if else 처럼 추가로 조건 지정이 가능함
	    ,decode(deptno1, 101, 'Computer Engineering', 
	     	decode(deptno1, 102, 'Multimedia Engineering', 
	     	      decode(deptno1, 103, 'Software Engineering', 'ETC'))) AS dept3
	   	   ,decode(deptno1, 101, 'Computer Eng.',
	                     102, 'Multimedia Eng.',                           -- 위에꺼 연결해서 왼쪽과 같이 줄여서 표현 가능
	                     103, 'Software Eng.','ETC') AS dept4 	  
FROM student
;


