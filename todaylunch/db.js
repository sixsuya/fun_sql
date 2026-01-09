const oracledb = require("oracledb");
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

// 외부 js 파일에서 사용할 수 있도록 익스포트 하기.
module.exports = { getConnection };
