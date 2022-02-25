<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[관리자] 회원목록</title>

<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<script type="text/javascript" src="/resources/js/bootstrap.bundle.js"></script>
<script type="text/javascript" src="/resources/js/listMembers.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/listMembers.css">
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
		<form id="searchForm" action="/manager/listMembers" method="GET">
			<select class="form-select form-select-sm" aria-label=".form-select-sm example" id="searchItem" name="searchItem">
			  <option value="user_id" ${searchItem == 'user_id' ? 'selected' : ''} >ID</option>
			  <option value="user_nm" ${searchItem == 'user_nm' ? 'selected' : ''}>이름</option>
			</select>
			<select class="form-select form-select-sm" aria-label=".form-select-sm example" id="searchStatus" name="searchStatus">
			  <option value="all" ${searchStatus == 'all' ? 'selected' : ''} >전체 계정</option>
			  <option value="0" ${searchStatus == '0' ? 'selected' : ''} >활성화 계정</option>
			  <option value="3" ${searchStatus == '3' ? 'selected' : ''}>비활성화 계정</option>
			</select>
			<input type="text" name="searchWord" value="${searchWord}">
			<input type="hidden" name="page" id="page" value="">
			<input type="button" class="btn btn-secondary btn-sm" id="searchButton" value="검색" onclick="search(1)"><br>
		</form>
	</div>
	
	
	<div id="tableDiv"> 
		<table class="table table-dark table-hover" id="memberTable">
			<tr>
				<th>NO</th>
				<th>ID</th>
				<th>이름</th>
				<th>프로필 사진</th>
				<th>계정 상태</th>
				<th>계정 처리</th>
				<th>가입일</th>
			</tr>
			<c:set var="num" value="${navi.totalRecordsCount - ((navi.currentPage-1)*10)}"/>
			<c:forEach var="member" items="${list}" varStatus="stat">
				<tr class="forClick">
					<td >${num}</td>
					<td>${member.user_id}</td>
					<td>${member.user_nm}</td>
					<td>
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
					</td>
					<c:choose>
						<c:when test="${member.manager == 0}">
							<td>활성화</td>
						</c:when>
						<c:otherwise>
							<td>비활성화</td>
						</c:otherwise>
					</c:choose>
					<td>
						<c:choose>
							<c:when test="${member.manager == 0}">
								<input type="button" class="btn btn-secondary btn-sm" value="비활성화 하기">
							</c:when>
							<c:otherwise>
								<input type="button" class="btn btn-secondary btn-sm" value="활성화 하기">
							</c:otherwise>
						</c:choose>		
					</td>
					<td>${member.regdate}</td>
					<td class="hiddenTd"><input type="hidden" value="${member.user_id}"></td>
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


	
</body>
</html>