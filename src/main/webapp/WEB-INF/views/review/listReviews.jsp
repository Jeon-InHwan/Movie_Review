<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movie Review List</title>

<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="/resources/js/listReviews.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/listReviews.css">
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

	<div id="searchDiv">
		<form id="searchForm" action="/review/listReviews" method="GET">
			<select class="form-select form-select-sm" aria-label=".form-select-sm example" id="searchItem" name="searchItem">
			  <option value="review_title" ${searchItem == 'review_title' ? 'selected' : ''} >TITLE</option>
			  <option value="user_id" ${searchItem == 'user_id' ? 'selected' : ''}>WRITER ID</option>
			  <option value="review_text" ${searchItem == 'review_text' ? 'selected' : ''}>TEXT</option>
			</select>
			<input type="text" id="searchWord" name="searchWord" value="${searchWord}">
			<input type="hidden" name="page" id="page" value="">
			<input type="button" class="btn btn-secondary btn-sm" id="searchButton" value="검색" onclick="search(1)"><br>
		</form>
	</div>

	<div id="tableDiv"> 
		<table class="table table-dark table-hover" id="reviewTable">
			<tr>
				<th>NO</th>
				<th>ID</th>
				<th>리뷰 제목</th>
				<th>조회수</th>
				<th>등록일</th>
			</tr>
			<c:set var="num" value="${navi.totalRecordsCount - ((navi.currentPage-1)*10)}"/>
			<c:forEach var="review" items="${list}" varStatus="stat">
				<tr class="forClick">
					<td >${num}</td>
					<td>${review.user_id}</td>
					<td>${review.review_title}</td>
					<td>${review.review_hitcount}</td>
					<td>${review.review_indate}</td>
					<td class="hiddenTd"><input type="hidden" value="${review.review_num}"></td>
				</tr>
			<c:set var="num" value="${num-1}"></c:set>	
			</c:forEach>		
		</table>
	</div>
	
</div>


<div id = "pagenationDiv">

	<nav aria-label="Page navigation example" id="pagenationNaV">
	  <ul class="pagination" id="pagination">
	    <li class="page-item">
	      <a class="page-link" href="javascript:search(${navi.currentPage - 1});" aria-label="Previous">
	        <span aria-hidden="true">&laquo;</span>
	      </a>
	    </li>
	    <c:forEach var="num" begin="${navi.startPageGroup}" end="${navi.endPageGroup}">
			<c:choose>
				<c:when test="${navi.currentPage == num}">
					<li class="page-item"><a id="hilightCurrent" class="page-link" href="javascript:search(${num});">${num}</a></li>
				</c:when>
				<c:otherwise>
					<li class="page-item"><a class="page-link" href="javascript:search(${num});">${num}</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	    <li class="page-item">
	      <a class="page-link" href="javascript:search(${navi.currentPage + 1});" aria-label="Next">
	        <span aria-hidden="true">&raquo;</span>
	      </a>
	    </li>
	  </ul>
	</nav>
	
</div>



<div id="buttonDiv">
	<input type="button" id="toWriteReviewFormButton" class="btn btn-secondary btn-lg" value="리뷰 작성 페이지로 이동" onclick="toWriteReviewForm();">
</div>


	
</body>
</html>