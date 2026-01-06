// express 서버모듈.
const express = require("express"); //모듈 임포트.

// const oracledb = require("oracledb"); // 요거는 임포트
const db = require("./db"); // 여기서 db는 db.js
// console.log(db);

const app = express(); // 인스턴스 생성

// URL주소 + 실행함수 => 앞에 2개를 묶어서 라우팅 이라고 함
// "/"
app.get("/", (req, res) => {
  // req : 요청개체 res : 응답개체   콜백함수(핸들러)
  res.send("/ Sixsuya 홈에 오신걸 환영합니다.");
});

// "/customer"   => http://localhost:3000/customer
app.get("/customer", (req, res) => {
  res.send("/customer 경로가 호출됨.");
});

// product => http://localhost:3000/product
app.get("/product", (req, res) => {
  res.send("/product 경로가 호출됨.");
});

// "/student" -> 화면에 출력하는데 학생번호로 추출해서 데이터 보기
app.get("/student/:studno", async (req, res) => {
  // /:studno => 문자가 아니라 값으로 받겠다는 의미
  console.log(req.params.studno);
  const studno = req.params.studno;
  const qry = "select * from student where studno = " + studno;
  const connection = await db.getConnection();
  const result = await connection.execute(qry);
  res.send(result.rows); // 반환되는 결과값 중에서 metaData는 제외하고 rows 속성의 결과만 출력
});

// '/employee -> 사원목록을 출력하는 라우팅 만들어 보기 / 사원번호로 소팅 되도록
app.get("/employee/:empno", async (req, res) => {
  console.log(req.params.empno);
  const empno = req.params.empno;
  const qry2 = "select * from emp where empno = " + empno;
  const connection = await db.getConnection();
  const result = await connection.execute(qry2);
  res.send(result.rows);
});

// 서버실행
app.listen(3000, () => {
  console.log("server 실행. http://localhost:3000/employee/");
}); //첫번째매개값 : 포트   두번째매개값 : 사용하는 함수
