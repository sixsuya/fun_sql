const express = require("express"); //모듈 임포트.
const db = require("./db");

const app = express(); // 인스턴스 생성

app.use(express.static("public")); //정적 파일들을 public 폴더 안에 묶어 저장하겠다는 뜻
app.use(express.json()); //post 요청으로 body에 담겨있는 데이터를 처리할수 있도록 express에서 실행

// 식당 목록 불러 오기
app.get("/list", async (req, res) => {
  const qry = "select * from lunch order by 1 ";
  const connection = await db.getConnection();
  const result = await connection.execute(qry);
  res.send(result.rows);
});

// 식당등록 : add_restaurant
app.post("/add_restaurant", async (req, res) => {
  console.log(req.body);
  const {
    restaurant_no,
    restaurant_name,
    restaurant_address,
    restaurant_category,
    restaurant_menu,
    restaurant_price,
    restaurant_myung,
    restaurant_score,
    restaurant_discount,
    restaurant_etc,
  } = req.body;
  const qry = `insert into lunch (
            restaurant_no
           ,restaurant_name
  ,restaurant_address
  ,restaurant_category
  ,restaurant_menu
  ,restaurant_price
  ,restaurant_myung
  ,restaurant_score
  ,restaurant_discount
  ,restaurant_etc)
      values( 
      :restaurant_no,
      :restaurant_name,
      :restaurant_address,
      :restaurant_category,
      :restaurant_menu,
      :restaurant_price,
      :restaurant_myung,
      :restaurant_score,
      :restaurant_discount,
      :restaurant_etc)`;
  try {
    const connection = await db.getConnection();
    const result = await connection.execute(qry, [
      restaurant_no,
      restaurant_name,
      restaurant_address,
      restaurant_category,
      restaurant_menu,
      restaurant_price,
      restaurant_myung,
      restaurant_score,
      restaurant_discount,
      restaurant_etc,
    ]);
    console.log(result);
    connection.commit();
    res.json({
      restaurant_no,
      restaurant_name,
      restaurant_address,
      restaurant_category,
      restaurant_menu,
      restaurant_price,
      restaurant_myung,
      restaurant_score,
      restaurant_discount,
      restaurant_etc,
    });
  } catch (err) {
    console.log(err);
    res.json({
      retCode: "NG",
      retMsg: "DB 에러",
    });
  }
});

//댓글 삭제 기능.  !!!!!!!
// 요청방식 : get 사용   url : '/remove_board:board_no'   <= board_no : 삭제할 보드 번호 표시
// 반환되는결과 ( {retCode : 'OK' })   <- res.json

// 서버실행
app.listen(3000, () => {
  console.log("server 실행. http://localhost:3000");
}); //첫번째매개값 : 포트   두번째매개값 : 사용하는 함수
