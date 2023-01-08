<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 리뷰</title>

<!-- Bootstrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
#box {
	width: 800px;
	margin: auto;
	margin-top: 10px;
}

#title {
	text-align: center;
	font-family: 휴먼옛체, 굴림체, 궁서체;
	font-size: 28px;
	font-weight: bold;
	color: #337ab7;
	text-shadow: 1px 1px 3px black;
}

.content_type {
	padding: 5px;
	min-height: 60px;
	border: 1px solid gray;
	box-shadow: -1px -1px 1px #555555;
	text-shadow: none;
	color: black;
	overflow: hidden;
}

</style>

<script type="text/javascript">
	function reply() {

		//로그인여부
		if ("${empty user}" == "true") {

			if (confirm("댓글쓰기는 로그인후에 가능합니다\n로그인 하시겠습니까?") == false) return;
			
			//로그인폼으로 이동
			location.href = "../member/login_form.do?url="+ encodeURIComponent(location.href);
			return;
		}

		location.href = "list.do?r_idx=${ vo.r_idx }&page=${ param.page }";
	}
</script>

<script type="text/javascript">
	function del(r_idx) {
		if (confirm("정말 삭제하시겠습니까?") == false)
			return;
		//삭제로 이동
		location.href = "delete.do?c_idx=${param.c_idx}&r_idx="+r_idx+"&page=${ param.page }&search=${ param.search }&search_text=${ param.search_text}";
	}

	function modify_form(r_idx) {
		//수정폼 띄우기
		location.href = "modify_form.do?c_idx=${param.c_idx}&r_idx="+r_idx+"&page=${ param.page }&search=${ param.search }&search_text=${ param.search_text}";
	}
	

	function search() {
		var search = $("#search").val();
		var search_text = $("#search_text").val().trim();

		//전체검색이 아닌경우
		if (search != 'all' && search_text == '') {
			alert('검색어를 입력하세요');
			$("#search_text").val('');
			$("#search_text").focus();
			return;
		}
		//검색내용을 parameter로 목록보기(list.do)호출
		location.href = "list.do?c_idx=${param.c_idx}&search=" + search + "&search_text="+ encodeURIComponent(search_text);
	}
</script>


<script type="text/javascript">
	//초기화
	$(document).ready(function() {

		if ("${ not empty param.search }" == "true") {
			$("#search").val('${ param.search }');
		}

		//전체검색 실행시 검색어 지우기
		if ("${ param.search == 'all' }" == "true") {
			$("#search_text").val('');
		}
	});
</script>


</head>
<body>

	<%@ include file="../include/navbar.jsp"%>

	<div id="box">
		<h1 id="title">REVIEW </h1>

		<div class="panel-body" style="margin-bottom: 30px">
			<table class="table  table-striped">
				<tr>
					<td align="center" style="width: 50%"><img id="my_img"
					 src="../resources/upload/${ cinemaVo.c_filename }" style="max-width: 350px"></td>
					<td>
						<h4>카테고리: ${cinemaVo.c_category}</h4>
						<h3>제목: ${cinemaVo.c_subject}</h3>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<h4>[내용]</h4> ${cinemaVo.c_info}
					</td>
				</tr>
			</table>
		</div>


		
		<div style="margin-top: 10px; margin-bottom: 10px; text-align: right;">
		 <c:choose>
		 	<c:when test="${empty user}">
		 	<input class="btn btn-primary" type="button" value="리뷰쓰기" onclick="alert('로그인후 이용 가능합니다.')">
		 	</c:when>
		 	<c:otherwise>
		 	<input class="btn btn-primary" type="button" value="리뷰쓰기" onclick="location.href='insert_form.do?c_idx=${cinemaVo.c_idx}'">
		 	</c:otherwise>
		 </c:choose>
			
		</div>


		<div style="text-align: center; margin: 10px;">
			<select id="search" name="search" class="form-control" style="display: inline; width: 150px">
				<option value="all">전체</option>
				<option value="subject">제목</option>
				<option value="name">작성자</option>
				<option value="content">내용</option>
				<option value="name_content">작성자+내용</option>
			</select> 
			<span style="display: none;">${param.search_text}</span>
			
			<input type="search"	 id="search_text" 
			value="${param.search_text}" class="form-control" style="display: inline; width: 200px"> 
			<input type="button" value="검색" onclick="search();"  class="submit"
				style="display: inline; width: 50px" class="btn btn-info">
		</div>
		
		<c:if test="${empty list }">
			<h3 class="text-center" style="margin-top: 30px">등록된 리뷰가 없습니다.</h3>
		</c:if>

		<c:forEach var="vo" items="${list}">
			<form>
				<input type="hidden" name="r_idx" value="${vo.r_idx}">
				<div class="panel panel-primary" style="position: relative;">					
					<div class="panel-heading" style="display: flex; justify-content: space-between;">
						<div class="subject"><h4 style="font-size: 15px">${ vo.r_subject}
						<span style="color: #fff"> (평점: ${ vo.r_score } 점)</span>						
						</h4></div>
						<div>
							<div id="m_nickname"><b>${vo.m_nickname}</b> 님의 리뷰 <%-- ${user.m_idx}- ${vo.m_idx} --%> </div>	
									
							<div class="regdate">작성일: ${fn:substring(vo.r_regdate, 0, 16) }</div>
						</div>						
					</div>
					<div>
						
						<%-- <div class="count">조회수 : ${ vo.r_count }</div> --%>
					</div>
					<div class="content" style="padding: 5px; width: 85%; min-height: 50px;">${ vo.r_content }</div>
					
					
					<c:choose>
						<c:when test="${user.m_grade eq '관리자'}">
							<div style="text-align: right;margin-bottom: 29;display: inline;position: absolute;top: 65px;right: 17px">											
								<input class="btn btn-info btn-sm" type="button" value="수정하기" onclick="modify_form(`${vo.r_idx}`);">
								<input class="btn btn-danger btn-sm" type="button" value="삭제하기" onclick="del(`${vo.r_idx}`);">
						    </div>								
						</c:when>
						<c:when test="${user.m_idx eq vo.m_idx}">
							<div style="text-align: right;margin-bottom: 29;display: inline;position: absolute;top: 65px;right: 17px">											
								<input class="btn btn-info btn-sm" type="button" value="수정하기" onclick="modify_form(`${vo.r_idx}`);">
								<input class="btn btn-danger btn-sm" type="button" value="삭제하기" onclick="del(`${vo.r_idx}`);">
						    </div>														
						</c:when>						
					</c:choose>
					
					
				</div>
			</form>
		</c:forEach>
		<!-- 페이징 메뉴 -->
		<div style="text-align: center; font-size: 20px;">${ pageMenu }</div>
		
	</div>
	
	<div style="margin-bottom: 100px">&nbsp;</div>
	
	
<script>
$(function(){
	$("#search_text").on("keyup",function(e){
		if (window.event.keyCode==13) {		
	    	$(".submit").click();
	    }
	})
})
</script> 	
</body>
</html>