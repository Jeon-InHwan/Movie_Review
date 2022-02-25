<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>Movie_Review</title>

<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="/resources/js/index.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/index.css">
<link rel="stylesheet" type="text/css" href="/resources/css/bootstrap.css">

	
</head>
<body>

<div id="picture"></div>


<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/">Movie Review</a>
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
            <li><a class="dropdown-item" href="/member/joinForm">회원가입</a></li>
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
	<form action="/member/login" id="loginForm" method="POST">
		<div class="input-group mb-3">
 		 	<span class="input-group-text" id="idSpan">ID</span>
  			<input type="text" class="form-control" name="user_id" id="user_id"placeholder="ID를 입력해주세요!" aria-label="user_id" aria-describedby="idSpan">
  		</div>
  		<div class="input-group mb-3">	
  			<span class="input-group-text" id="passwordSpan">Password</span>
  			<input type="password" class="form-control" name="user_pwd" id="user_pwd" placeholder="Password를 입력해주세요!" aria-label="user_pwd" aria-describedby="passwordSpan">
		</div>
	</form>
</div>	

<div id="loginButtonDiv">
	<input type="button" class="btn btn-secondary btn-lg" id = "loginButton" value="로그인" onclick="doLogin();">
</div>

<div id="joinButtonDiv">
	<input type="button" class="btn btn-secondary btn-lg" id = "joinButton" value="회원가입" onclick = "location.href = '/member/joinForm'">
</div>



</body>
</html>
