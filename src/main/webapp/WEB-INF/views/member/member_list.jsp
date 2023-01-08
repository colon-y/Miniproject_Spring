<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- JSTL tag library -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록</title>
<!-- Bootstrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
#box {
	width: 1200px;
	margin: auto;
	margin-top: 30px;
}

#title {
	text-align: center;
	font-size: 30px;
	font-weight: bold;
	color: #3355ff;
	text-shadow: 1px 1px 3px black;
}

th {
	text-align: center;
}

td {
	text-indent: 10px; /* 들여쓰기 */
}
</style>
<!-- SweetAlert2 library -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script type="text/javascript">
	function del(m_idx){
		
		//---------------------------------------------------------
		Swal.fire({
			  title: '정말 삭제하시겠습니까?',
			  html: "<h5>선택한 사용자가 삭제됩니다</h5>",
			  icon: 'question',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '삭제',
			  cancelButtonText:  '취소'
			}).then((result) => {
				  
				//삭제버튼을 누르면..
				if (result.isConfirmed) {
					location.href = 'delete.do?m_idx=' + m_idx; // MemberDeleteAction
					
				}
			});
	}
</script>
</head>
<body>

	<%@ include file="../include/navbar.jsp"%>

	<div id="box">
		<h1 id="title">::::${ user.m_grade eq '관리자' ? '회원목록':'회원정보' }::::</h1>
		<!-- 회원가입 -->
		<c:if test="${ user.m_grade eq '관리자'}">
			<div style="float: right;">
				<input class="btn btn-primary" type="button" value="회원가입" onclick="location.href='insert_form.do';"> <br>
			<br>
			</div>
		</c:if>


		<!-- 데이터 출력 -->
		<div style="margin-top:50px">
			<table class="table  table-striped text-center">
				<tr class="info">
					<th>회원번호</th>
					<th>이름</th>
					<th>아이디</th>
					<th>비밀번호</th>
					<th>닉네임</th>
					<th>회원등급</th>
					<th>아이피</th>
					<th>가입일자</th>
					<th>우편번호</th>
					<th>주소</th>
					<th>수정 및 업데이트</th>
				</tr>

				<!-- data 없는 경우 -->
				<c:if test="${ empty list }">
					<tr>
						<td colspan="10" align="center"><font color="red">등록된 회원이 없습니다</font></td>
					</tr>
				</c:if>

				<!-- data -->
				<c:if test="${ user.m_grade eq '관리자' }">
					<!--  for(MemberVo vo : list) -->
					<c:forEach var="vo" items="${ list }">
						<tr>
							<td>${ vo.m_idx }</td>
							<td>${ vo.m_name }</td>
							<td>${ vo.m_id }</td>
							<td>${ vo.m_pwd }</td>
							<td>${ vo.m_nickname }</td>
							<td>${ vo.m_grade }</td>
							<td>${ vo.m_ip }</td>
							<td>${ fn:substring(vo.m_regdate,0,10) }</td>
							<td>${ vo.m_zipcode }</td>
							<td>${ vo.m_addr }</td>
							<td class="text-center">
								<table style="margin: 0 auto">
									<tr>
										<th>
										 <input class="btn btn-info" type="button" value="수정" onclick="location.href='modify_form.do?m_idx=${ vo.m_idx }';">
										 <input class="btn btn-danger" type="button" value="삭제" onclick="del('${ vo.m_idx }');">
										 </th>
									</tr>
								</table>
							</td>
						</tr>
					</c:forEach>
				</c:if>


			<c:forEach var="vo" items="${ list }">
				<c:if test="${(user.m_grade ne '관리자' ) and  user.m_idx eq vo.m_idx }">
					
						<tr>
							<td>${ vo.m_idx }</td>
							<td>${ vo.m_name }</td>
							<td>${ vo.m_id }</td>
							<td>${ vo.m_pwd }</td>
							<td>${ vo.m_nickname }</td>
							<td>${ vo.m_grade }</td>
							<td>${ vo.m_ip }</td>
							<td>${ fn:substring(vo.m_regdate,0,10) }</td>
							<td>${ vo.m_zipcode }</td>
							<td>${ vo.m_addr }</td>
							<td class="text-center">
							<table style="margin: 0 auto">
								<tr>
									<th>
									 <input class="btn btn-info" type="button" value="수정" onclick="location.href='modify_form.do?m_idx=${ vo.m_idx }';">
									 <input class="btn btn-danger" type="button" value="삭제" onclick="del('${ vo.m_idx }');">
									 </th>
								</tr>
							</table>
							</td>
						</tr>
					
				</c:if>
				</c:forEach>
			</table>


		</div>

	</div>

</body>
</html>
