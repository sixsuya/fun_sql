// express 서버모듈.
const express = require("express"); //모듈 임포트.

// const oracledb = require("oracledb"); // 요거는 임포트
const db = require("./db"); // 여기서 db는 db.js
// console.log(db);

const app = express(); // 인스턴스 생성

app.use(express.static("public")); //정적 파일들을 public 폴더 안에 묶어 저장하겠다는 뜻
app.use(express.json()); //post 요청으로 body에 담겨있는 데이터를 처리할수 있도록 express에서 실행

// URL주소 + 실행함수 => 앞에 2개를 묶어서 라우팅 이라고 함
// "/"
app.get("/", (req, res) => {
  // req : 요청개체 res : 응답개체   콜백함수(핸들러)
  res.send("/ Sixsuya 홈에 오신걸 환영합니다.");
});

//댓글 삭제 기능.
// 요청방식 : get 사용   url : '/remove_board:board_no'   <= board_no : 삭제할 보드 번호 표시
// 반환되는결과 ( {retCode : 'OK' })   <- res.json
app.get("/remove_board/:board_no", async (req, res) => {
  console.log(req.params.bno);
  const bno = req.params.bno;
  const qry = "delete from board where board_no = " + bno;
  const connection = await db.getConnection();
  const result = await connection.execute(qry);
  res.send(result.rows);
});

// 댓글 전체 목록을 반환.
app.get("/boards", async (req, res) => {
  const qry = "select * from board order by 1";
  try {
    const connection = await db.getConnection();
    const result = await connection.execute(qry);
    console.log("성공");
    res.send(result.rows);
  } catch (err) {
    console.log(err);
    req.send("실패");
  }
});

// 요청방식 get vs post
//get : 단순조회에 사용(데이터 전달량이 한정됨), 처리속도가 빠름, 데이터가 머리와 꼬리에 담겨서 url에 노출됨
// post : 많은 양의 데이터 전달 가능, body에 담아서 보냄, 속도가 느림, insert는 post로 사용

// add_board
app.post("/add_board", async (req, res) => {
  console.log(req.body); //  => { board_no: 10, title: 'test', content: 'sample', writer: 'user01' }
  const { board_no, title, content, writer } = req.body; //  위에 있는 각각 객체의 값을 담아주겠다는 명령어 =>  const board_no = req.body.board_no <- 이 표현을 각 객체로 하는 것을 한번에 해줌
  const qry = `insert into board (board_no, title, content, writer)
                values(:board_no, :title, :content, :writer)`;
  try {
    const connection = await db.getConnection();
    const result = await connection.execute(qry, [
      board_no,
      title,
      content,
      writer,
    ]);
    console.log(result);
    connection.commit();
    // res.send("처리완료"); // 서버 - 클라이언트 응답 결과
    res.json({ board_no, title, content, writer });
  } catch (err) {
    console.log(err);
    // res.send("처리중에러"); //
    res.json({ retCode: "NG", retMsg: "DB 에러" });
  }
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
  const qry = "select * from emp where empno = " + empno;
  const connection = await db.getConnection();
  const result = await connection.execute(qry);
  res.send(result.rows);
});

// 서버실행
app.listen(3000, () => {
  console.log("server 실행. http://localhost:3000/");
}); //첫번째매개값 : 포트   두번째매개값 : 사용하는 함수
