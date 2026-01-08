//fetch를 통해서 게시글 데이터 가져오기
fetch("boards")
  .then((response) => {
    return response.json();
  })
  .then((result) => {
    console.log(result);
    // 반복처리(table 개수만큼)
    result.forEach((elem) => {
      // tbody subject
      const insertHtml = `<tr>
            <td>${elem.BOARD_NO}</td>
            <td>${elem.TITLE}</td>
            <td>${elem.WRITER}</td>
            <td>${new Date(elem.WRITE_DATE).toLocaleString()}</td>
            <td><button onclick='deleteRow(${
              elem.BOARD_NO
            })' class = del>삭제</td>
          </tr>`;
      const subject = document.querySelector("tbody");
      subject.insertAdjacentHTML("afterbegin", insertHtml); //위치 조건에 따라 정렬순서도 영향 받음
    }); // end of forEach
  })
  .catch((err) => {
    console.log(err);
  });

// form에다가 submit 이벤트 등록하기
document.querySelector("form").addEventListener("submit", (e) => {
  e.preventDefault();
  // document.querySelector('input[name=""]')
  const board_no = document.querySelector("#bno").value;
  const title = document.querySelector("#title").value;
  const content = document.querySelector("#content").value;
  const writer = document.querySelector("#writer").value;
  // 입력값 체크.
  if (!board_no || !title || !content || !writer) {
    alert("필수값 입력");
    return;
  }
  const data = {
    board_no,
    title,
    content,
    writer,
  };

  //post 요청.
  // 1. 호출할 url이 첫번째 값
  // 2. 옵션 객체(option object)
  fetch("./add_board", {
    // cf) ../ <- 상위 폴더로 이동해서 경로를 찾을때 사용  ./ <- 동일 레벨 폴더일때 사용
    method: "post",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(data),
  })
    .then((data) => {
      //fetch 함수가 성공적으로 실행 되면 시행할 작업
      console.log(data);
      return data.json();
    })
    .then((result) => {
      console.log(result);
      const insertHtml = `<tr>
            <td>${result.board_no}</td>
            <td>${result.title}</td>
            <td>${result.writer}</td>            
            <td>${new Date().toLocaleString()}</td>
            <td><button onclick='deleteRow(${
              result.board_no
            })' class = del>삭제</td>
          </tr>`;
      const subject = document.querySelector("tbody");
      subject.insertAdjacentHTML("afterbegin", insertHtml);
    })
    .catch((err) => {
      //fetch 함수가 에러가 나면 시행할 작업
      console.log(err);
    });
});

// 글 삭제 기능(del button)   <- fetch 통해서 구현. .get을 사용한 fetch 참고하기.
// console.log 통해 실패값이 나왔을때 검증할수 있어야.
//document.queryselector('tr').remove()

// fetch("remove_board")
//   .then((response) => {
//     return response.json();
//   })
//   .then((result) => {
//     const boardno = document.querySelector("#bno").value; // 클릭하는 버튼의 보드넘버 출력
//     console.log(boardno);
//   })
// delete from board where board_no = boardno;  //해당 보드넘버 데이터를 원본부터 삭제하는 함수
// }); // end of function
// .then((result) => {
//   console.log(result);
//   // 반복처리(table 개수만큼)
//   result.forEach((elem) => {
//     // tbody subject
//     const insertHtml = `<tr>
//           <td>${elem.BOARD_NO}</td>
//           <td>${elem.TITLE}</td>
//           <td>${elem.WRITER}</td>
//           <td>${new Date(elem.WRITE_DATE).toLocaleString()}</td>
//           <td><button onclick='deleteRow(${
//             elem.BOARD_NO
//           })' class = del>삭제</td>
//         </tr>`;
//     const subject = document.querySelector("tbody");
//     subject.insertAdjacentHTML("afterbegin", insertHtml);
//   }); // end of forEach again
// })
// .catch((err) => {
//   console.log(err);
// });

function deleteRow(bno) {
  console.log(bno);
  fetch("/remove_board/" + bno)
    .then((response) => {
      return response.json();
    })
    .then((result) => {
      console.log(result);
    })
    .catch((err) => {
      console.log(err);
    });
}
