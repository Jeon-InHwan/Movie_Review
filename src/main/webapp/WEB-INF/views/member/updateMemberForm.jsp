<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[Movie Review 회원정보 수정 ]</title>

<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="/resources/js/updateMemberForm.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/updateMemberForm.css">
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


<div id="outWrapper">
	<form action="/member/updateMember" id="updateForm" method="POST">
		<div class="input-group mb-3">
 		 	<span class="input-group-text" id="idSpan">ID</span>
  			<input type="text" class="form-control" id="user_id" name="user_id" value="${member.user_id}" disabled="disabled" aria-label="user_id" aria-describedby="idSpan">
  		</div>
  		<div class="input-group mb-3">	
  			<span class="input-group-text" id="passwordSpan">Password</span>
  			<input type="password" class="form-control" id="user_pwd" name="user_pwd" placeholder="Password는 5글자 이상, 12글자 이하로 입력해주세요!" aria-label="user_pwd" aria-describedby="passwordSpan">
		</div>
		<div class="input-group mb-3">	
  			<span class="input-group-text" id="nameSpan">Name</span>
  			<input type="text" class="form-control" id="user_nm" name="user_nm" value="${member.user_nm}" aria-label="user_pwd" aria-describedby="nameSpan">
		</div>
		<div  class="input-group mb-3" id="photoRadio">
			<div id="photoSpanDiv">	
				<span class="input-group-text" id="photoSpan">profile 사진</span>
				<div id="photoDiv">
					<img src="/resources/images/profile_01.png">
					<img src="/resources/images/profile_02.png">
					<img src="/resources/images/profile_03.png">
					<img src="/resources/images/profile_04.png">
					<img src="/resources/images/profile_05.png">
					<img src="/resources/images/profile_06.png">
					<br>
					<div class="forRadio">
						<c:choose>
						<c:when test="${member.photo == 1}">
							<input class="form-check-input" type="radio" name="photo" value=1 checked="checked">
						</c:when>
						<c:otherwise>
							<input class="form-check-input" type="radio" name="photo" value=1>
						</c:otherwise>
						</c:choose>
					</div>
					<div class="forRadio">
						<c:choose>
						<c:when test="${member.photo == 2}">
							<input class="form-check-input" type="radio" name="photo" value=2 checked="checked">
						</c:when>
						<c:otherwise>
							<input class="form-check-input" type="radio" name="photo" value=2>
						</c:otherwise>
						</c:choose>
					</div>
					<div class="forRadio">
						<c:choose>
						<c:when test="${member.photo == 3}">
							<input class="form-check-input" type="radio" name="photo" value=3 checked="checked">
						</c:when>
						<c:otherwise>
							<input class="form-check-input" type="radio" name="photo" value=3>
						</c:otherwise>
						</c:choose>
					</div>
					<div class="forRadio">
						<c:choose>
						<c:when test="${member.photo == 4}">
							<input class="form-check-input" type="radio" name="photo" value=4 checked="checked">
						</c:when>
						<c:otherwise>
							<input class="form-check-input" type="radio" name="photo" value=4>
						</c:otherwise>
						</c:choose>
					</div>	
					<div class="forRadio">
						<c:choose>
						<c:when test="${member.photo == 5}">
							<input class="form-check-input" type="radio" name="photo" value=5 checked="checked">
						</c:when>
						<c:otherwise>
							<input class="form-check-input" type="radio" name="photo" value=5>
						</c:otherwise>
						</c:choose>
					</div>	
					<div class="forRadio">
						<c:choose>
						<c:when test="${member.photo == 6}">
							<input class="form-check-input" type="radio" name="photo" value=6 checked="checked">
						</c:when>
						<c:otherwise>
							<input class="form-check-input" type="radio" name="photo" value=6>
						</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>	

<div id="updateButtonDiv">
	<input type="button" class="btn btn-secondary btn-lg" id = "updateButton" value="회원정보 수정!" onclick="formCheck();">
</div>


</body>
</html>