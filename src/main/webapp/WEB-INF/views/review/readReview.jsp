<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movie Review 상세읽기</title>

<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="/resources/js/readReview.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/readReview.css">
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


<div id="tableWrapper">

	<div id="tableDiv"> 
		
		<div id="backwardDiv">
			<img alt="" src="/resources/images/backward.png">
			<span id ="backwardSpan">뒤로가기</span>
		</div>
		
		<table class="table table-dark table-hover" id="reviewTable">
			<tr>
				<th>이름</th>
				<td class="tdClass">
					${review.USER_NM}
				</td>
			</tr>
			<tr>
				<th>
					프로필 사진
				</th>
				<td class="tdClass">
					<c:choose>
						<c:when test="${review.PHOTO == 1}">
							<img class="profileImg" src="/resources/images/profile_01.png">
						</c:when>
						<c:when test="${review.PHOTO == 2}">
							<img class="profileImg" src="/resources/images/profile_02.png">
						</c:when>
						<c:when test="${review.PHOTO == 3}">
							<img class="profileImg" src="/resources/images/profile_03.png">
						</c:when>
						<c:when test="${review.PHOTO == 4}">
							<img class="profileImg" src="/resources/images/profile_04.png">
						</c:when>
						<c:when test="${review.PHOTO == 5}">
							<img class="profileImg" src="/resources/images/profile_05.png">
						</c:when>
						<c:when test="${review.PHOTO == 6}">
							<img class="profileImg" src="/resources/images/profile_06.png">
						</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>리뷰 제목</th>
				<td class="tdClass">${review.REVIEW_TITLE}</td>
			</tr>
			<tr>
				<th>리뷰 내용</th>
				<td class="tdClass"><pre id="preForText">${review.REVIEW_TEXT}</pre></td>
			</tr>
			<tr>
				<th>조회수</th>
				<td class="tdClass">${review.REVIEW_HITCOUNT}</td>
			</tr>
			<tr>
				<th>등록일</th>
				<td class="tdClass">${review.REVIEW_INDATE}</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td class="tdClass">
					<a id="fileName" href="/review/download?review_num=${review.REVIEW_NUM}">${review.REVIEW_ORIGINALFILE}</a>
				</td>
			</tr>
		</table>
	</div>
	
</div>


<c:if test="${sessionScope.loginId == review.USER_ID or sessionScope.manager == 1}">
	<div id="buttonDiv">
		<input type="button" id="updateReviewButton" class="btn btn-secondary btn-lg" value="리뷰 수정" onclick="toUpdateReviewForm(${review.REVIEW_NUM});">
		<input type="button" id="deleteReviewButton" class="btn btn-secondary btn-lg" value="리뷰 삭제" onclick="toDeleteReview(${review.REVIEW_NUM});">
	</div>
</c:if>


	
</body>
</html>