//fetch를 통해서 list 데이터 가져오기
document.addEventListener("DOMContentLoaded", () => {
  fetch("/list")
    .then((res) => res.json())
    .then((result) => {
      const subject = document.querySelector("#listBody");
      subject.innerHTML = ""; // 초기화

      result.forEach((elem) => {
        const insertHtml = `
          <tr id="row_${elem.restaurant_no}">
            <td><span class="badge unvisited">미방문</span></td>
            <td>${elem.restaurant_no}</td>
            <td>${elem.restaurant_name}</td>
            <td>${elem.restaurant_category}</td>
            <td>${elem.restaurant_price}</td>
            <td>${elem.restaurant_discount}</td>
            <td>${elem.restaurant_myung}</td>
          </tr>
        `;
        subject.insertAdjacentHTML("beforeend", insertHtml);
      });
    })
    .catch((err) => console.error(err));
});

// form에다가 submit 이벤트 등록하기
const form = document.querySelector("#restaurantForm");
form.addEventListener("submit", (e) => {
  e.preventDefault();
  const restaurant_no = document.querySelector("#restaurant_no").value;
  const restaurant_name = document.querySelector("#restaurant_name").value;
  const restaurant_address = document.querySelector(
    "#restaurant_address"
  ).value;
  const restaurant_category = document.querySelector(
    "#restaurant_category"
  ).value;
  const restaurant_menu = document.querySelector("#restaurant_menu").value;
  const restaurant_price = Number(
    document.querySelector("#restaurant_price").value
  );
  const restaurant_myung = Number(
    document.querySelector("#restaurant_myung").value
  );
  const restaurant_score = Number(
    document.querySelector("#restaurant_score").value
  );
  const restaurant_discount = document.querySelector(
    "#restaurant_discount"
  ).value;
  const restaurant_etc = document.querySelector("#restaurant_etc").value;
  if (
    !restaurant_no ||
    !restaurant_name ||
    !restaurant_address ||
    !restaurant_category ||
    !restaurant_menu ||
    !restaurant_price ||
    !restaurant_myung ||
    !restaurant_score ||
    !restaurant_discount ||
    !restaurant_etc
  ) {
    alert("필수값 입력");
    return;
  }
  const data = {
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
  };

  fetch("/add_restaurant", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify(data),
  })
    .then((response) => {
      return response.json();
    })
    .then((result) => {
      if (result.retCode === "NG") {
        alert(result.retMsg);
        return;
      }

      const tbody = document.querySelector("#list tbody");
      const insertHtml = `<tr>
            <td>${result.restaurant_no}</td>
            <td>${result.restaurant_name}</td>
            <td>${result.restaurant_address}</td>
            <td>${result.restaurant_category}</td>
            <td>${result.restaurant_menu}</td>
            <td>${result.restaurant_price}</td>
            <td>${result.restaurant_myung}</td>
            <td>${result.restaurant_score}</td>
            <td>${result.restaurant_discount}</td>
            <td>${result.restaurant_etc}</td>
          </tr>`;
      tbody.insertAdjacentHTML("afterbegin", insertHtml);
      alert("등록 완료");
      form.reset();
      showTab("list");
    })
    .catch((err) => {
      console.log(err);
      alert("등록 실패");
    });
});

function showTab(tabId) {
  // 모든 탭 버튼 비활성화
  document.querySelectorAll(".tab").forEach((btn) => {
    btn.classList.remove("active");
  });

  // 모든 콘텐츠 숨김
  document.querySelectorAll(".content").forEach((section) => {
    section.classList.remove("active");
  });

  // 클릭된 탭 버튼 활성화
  const activeBtn = document.querySelector(
    `.tab[onclick="showTab('${tabId}')"]`
  );
  if (activeBtn) {
    activeBtn.classList.add("active");
  }

  // 해당 콘텐츠 표시
  document.getElementById(tabId).classList.add("active");
}

function openDetail() {
  document.getElementById("modal").style.display = "flex";
}

function closeModal() {
  document.getElementById("modal").style.display = "none";
}

function openReview() {
  closeModal();
  document.getElementById("review").style.display = "flex";
}

function submitReview() {
  alert("방문 완료 처리되었습니다.");
  document.getElementById("review").style.display = "none";
  showTab("visited");
}

function sortTable(col) {
  alert("정렬 기능 (JS/DB 연동 시 구현)");
}
let selectedRow = null;

function openDetail(row) {
  selectedRow = row;
  document.getElementById("modal").style.display = "flex";
}

function markVisited() {
  if (!selectedRow) return;

  // 뱃지 변경
  const badge = selectedRow.querySelector(".badge");
  badge.textContent = "방문완료";
  badge.classList.remove("unvisited");
  badge.classList.add("visited");

  // row 스타일 변경
  selectedRow.classList.add("visited-row");

  closeModal();
  openReview();
}
