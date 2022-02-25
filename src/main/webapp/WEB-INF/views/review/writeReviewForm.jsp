<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movie Review 작성</title>

<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="/resources/js/writeReviewForm.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/writeReviewForm.css">
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

<form action="/review/writeReview" id="writeReview" enctype="multipart/form-data" method=POST>
	<div id="tableWrapper">
		<div id="tableDiv"> 
			<table class="table table-dark table-hover" id="reviewTable">
				<tr>
					<th id="idTh">ID</th>
					<td>${sessionScope.loginId}</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						<div class="input-group mb-3">	
  							<input type="text" class="form-control" name="review_title" id="review_title" placeholder="" aria-label="review_title" aria-describedby="basic-addon1">
  						</div>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td id="contentTd">
						<div class="form-floating">
  							<textarea class="form-control" name = "review_text"  id="review_text"></textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td id="fileTd">
						<div class="form-floating">
  							<input type="file" id="upload "name="upload">
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>
</form>
	

<div id="buttonDiv">
	<input type="button" id="writeButton" class="btn btn-secondary btn-lg" value="리뷰 작성" onclick="writeReviewCheck();">
</div>



</body>
</html>