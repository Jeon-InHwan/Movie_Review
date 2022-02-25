<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome to Movie Review</title>

<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="/resources/js/afterLogin.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/afterLogin.css">
<link rel="stylesheet" type="text/css" href="/resources/css/bootstrap.css">

</head>

<body>
	
<div id="picture"></div>
	
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/member/afterLogin">Movie Review</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDarkDropdown" aria-controls="navbarNavDarkDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDarkDropdown">
      <ul class="navbar-nav">
        <li class="nav-item dropdown" id="firstLi">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDarkDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            회원메뉴
          </a>
          <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="navbarDarkDropdownMenuLink1" id="firstUl">
            <li><a class="dropdown-item" href="/member/updateMemberForm">회원정보 수정</a></li>
            <c:if test="${sessionScope.manager != 1}">
            	<li><a class="dropdown-item" href="/member/withdrawalMemberForm">회원탈퇴</a></li>
            </c:if>
            <c:if test="${sessionScope.manager == 1}">
            	<li><a class="dropdown-item" href="/manager/listMembers">회원목록</a></li>
            </c:if>
          </ul>
        </li>
        <li class="nav-item dropdown" id="secondLi">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDarkDropdownMenuLink" role="button" data-bs-toggle="dropdown"aria-expanded="false" >
            리뷰 게시판
          </a>
          <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="navbarDarkDropdownMenuLink1" id="SecondUl">
            <li><a class="dropdown-item" href="/review/listReviews">리뷰 게시판 이동</a></li>
            <li><a class="dropdown-item" href="/review/writeReviewForm">리뷰 게시판 작성</a></li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</nav>


<div class="dropdown" id="dropdownId">
  <c:choose>
  	<c:when test="${sessionScope.manager == 0}">
  		<button type="button" class="btn btn-secondary dropdown-toggle" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
  			${sessionScope.loginNm}(${sessionScope.loginId})님
  		</button>
  	</c:when>
  	<c:otherwise>
  		<button type="button" class="btn btn-secondary dropdown-toggle" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
  			${sessionScope.loginNm}<span class="position-absolute top-0 start-0 translate-middle badge rounded-pill bg-danger">Manager</span>
  		</button>
  	</c:otherwise>
  </c:choose>
  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1" id="userUl">
    <li><a class="dropdown-item" href="/member/updateMemberForm">회원정보 수정</a></li>
    <li><a class="dropdown-item" href="/member/logout">로그아웃</a></li>
  </ul>
</div>

<button class="btn btn-light" id = "clock"></button>

<div class="card" style="width: 18rem;" id="card1">
  <img src="/resources/images/personal_info.jpg" class="card-img-top" alt="...">
  <div class="card-body">
    <h5 class="card-title">개인정보 수정</h5>
    <p class="card-text">보안을 위해 주기적으로 <br>비밀번호를 바꿔주세요!</p>
    <a href="/member/updateMemberForm" class="btn btn-outline-dark">지금 수정하기!</a>
  </div>
</div>

<div class="card" style="width: 18rem;" id="card2">
  <img src="/resources/images/review.jpg" class="card-img-top" alt="...">
  <div class="card-body">
    <h5 class="card-title">Review 작성</h5>
    <p class="card-text">지금, 당신이 본 영화의 <br>Review를 작성하세요!</p>
    <a href="/review/writeReviewForm" class="btn btn-outline-dark">리뷰 작성하기!</a>
  </div>
</div>

<div id="profileDiv">
	<c:choose>
		<c:when test="${member.photo == 1}">
			<img class="profileImg" src="/resources/images/profile_01.png">
		</c:when>
		<c:when test="${member.photo == 2}">
			<img class="profileImg" src="/resources/images/profile_02.png">
		</c:when>
		<c:when test="${member.photo == 3}">
			<img class="profileImg" src="/resources/images/profile_03.png">
		</c:when>
		<c:when test="${member.photo == 4}">
			<img class="profileImg" src="/resources/images/profile_04.png">
		</c:when>
		<c:when test="${member.photo == 5}">
			<img class="profileImg" src="/resources/images/profile_05.png">
		</c:when>
		<c:when test="${member.photo == 6}">
			<img class="profileImg" src="/resources/images/profile_06.png">
		</c:when>
	</c:choose>
	<br>
	<span id="welcoming">${member.user_nm}님 환영합니다!</span>
</div>

	
</body>
</html>