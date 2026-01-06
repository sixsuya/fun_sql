const oracledb = require("oracledb");

//조회된 데이터를 객체방식으로 보여주기 위해 아래의 명령어 추가 입력
oracledb.outFormat = oracledb.OUT_FORMAT_OBJECT;

const dbConfig = {
  user: "scott",
  password: "tiger",
  connectString: "192.168.0.6:1521/xe",
};

// db에 접속하기 위한 session을 얻어 오는 함수.
async function getConnection() {
  try {
    const connection = await oracledb.getConnection(dbConfig);
    return connection; //연결(session)을 반환
  } catch (err) {
    return err; //에러 반환
  }
}

// 비동기처리 -> 동기방식 처리로 변경하기 위해 async, await 사용함
async function execute() {
  // session 획득 => dbeaber든, oracle이든 경로 접속 필요
  const qry = `insert into board (board_no, title, content, writer)
               values(5, 'db입력', '연습중입니다.', 'user01')`;
  try {
    const connection = await oracledb.getConnection(dbConfig);
    const result = await connection.execute(qry);
    connection.commit(); //커밋

    // const result = await connection.execute("select * from professor");

    console.log("DB 등록 성공");
    console.log(result);
  } catch (err) {
    console.log(`예외발생 => ${err}`);
  }
} // end of execute().

// execute();     <- 함수실행 구문

// 외부 js 파일에서 사용할 수 있도록 익스포트 하기.
module.exports = { getConnection, execute };
