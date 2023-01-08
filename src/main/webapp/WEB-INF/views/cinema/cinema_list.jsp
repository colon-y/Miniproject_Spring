<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 목록</title>
<!-- Bootstrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<style type="text/css">
#box {
	width: 1200px;
	margin: auto;
	margin-top: 30px;
}
#title {
	text-align: center;
	color: #337ab7;
	font-weight: bold;
	text-shadow: 1px 1px 2px black;
}

#empty_msg {
	text-align: center;
	color: red;
	margin-top: 200px;
}

#cinema_box {
	width: 100%;
	height: 500px;
	border: 5px solid #2b56be;
	overflow-y: scroll;
	margin-top: 10px;
	overflow-x:hidden;
}

#cinema_box::-webkit-scrollbar {
   width: 10px;
}
#cinema_box::-webkit-scrollbar-thumb {
   background-color: #2b56be;
   border-radius: 10px;
    background-clip: padding-box;
    border: 2px solid transparent;
}
#cinema_box::-webkit-scrollbar-track {
   background-color: grey;
   border-radius: 10px;
   box-shadow: inset 0px 0px 5px white;
}
 
 
.pagination li a:hover, .pagination li.active a {
  border: 1px
}
.cinema {
	width: 140px;
	height: 180px;
	border: 1px solid #ff6666;
	margin: 25px;
	padding: 10px;
	float: left;
}

.cinema:hover {
	border: 1px solid red;
}

.cinema>img {
	width: 117px;
	height: 100px;
	border: 1px solid gray;
	outline: 1px solid black;
	cursor: pointer;
}

.cinema_class {
	border: 1px solid gray;
	margin-top: 2px;
	margin-bottom: 2px;
	padding: 3px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
</style>
<script type="text/javascript">
  function upload_cinema(){	  
	  location.href="insert_form.do"; // CinemaInsertFormAction
  }
  
  var global_c_idx;
  function cinema_view(c_idx){	
	  
	  //alert(c_idx + '번호의 영화정보 보여줘');
	  
	  global_c_idx  = c_idx;
	  //화면중앙배치
	  center_cinema_popup();
	  
	  //데이터 가져와서 세팅하기
	  $.ajax({
		  url:'cinema_view.do', //CinemaViewAction
		  data:{'c_idx': c_idx },
		  dataType: 'json',
		  success: function(res_data){
			  console.log("영화 상세 보기 :",res_data);
			  
			  //팝업윈도우 배치작업
			  //res_data={'p_idx':20, 'p_subject':'제목','p_content':'내용', 'p_filename':'a.jpg',...,'m_idx': 11}
			  $("#img_cinema").attr('src','../resources/upload/' + res_data.c_filename);
			  $("#cinema_category").html('장르 : ' + res_data.c_category);
			  $("#cinema_subject").html(res_data.c_subject);
			  $("#cinema_info").html(res_data.c_info);
			  $("#cinema_regdate").html(res_data.c_regdate.substring(0,10));
			  $("#c_idx").val(res_data.c_idx);			 
			  
			  //수정/삭제버튼의 사용유무: 관리자인 경우"
			  const admin="${ user.m_grade eq '관리자'}";			  
              if(admin){   	
            	  $("#cinema_job").show();            	 
              }else{ 	
            	  $("#cinema_job").hide();            	  
              }			    
		  },
		  error:function(err){
			  alert(err.responseText);
		  }
	  });
	
  }
  
  function center_cinema_popup(){	  
	  //브라우저 크기 구하기
	  var w_width  = $(window).width();
	  var w_height = $(window).height();
	  
	  console.log(w_width,w_height);
	  
	  //Popup 크기 구하기
	  var p_width = $("#cinema_popup").width();
	  var p_height= $("#cinema_popup").height();
	  
	  console.log(p_width,p_height);
	  
	//var left = w_width/2  - p_width/2;
	//var top  = w_height/2 - p_height/2 ;
	var left = w_width/2  - p_width/2;
	var top  = "25%";
	  
	  
	  //CSS : Map방식 속성값 지정
	  $("#cinema_popup").css({'left': left, 'top': top});
	  $("#cinema_popup").show();
  }
  
  function hide_cinema_popup(){	  
	  $("#cinema_popup").hide();	  
  }

  
  function photo_modify(){
	  location.href="modify_form.do?c_idx=" +$("#c_idx").val();
  }
  
  //영화삭제
  function photo_delete(){	  
	  if(!confirm("정말 삭제하시겠습니까?"))return;	  
	  //삭제하기
	  location.href="delete.do?c_idx=" + $("#c_idx").val(); // CinemaDeleteAction
	  
  }
  
  //수정하기
  function cinema_modify(){	  
	  //수정폼 띄우기
	  location.href = "modify_form.do?c_idx=" + global_c_idx; //CinemaModifyFormAction	  
  }
  
  function reviewMove(){
	  location.href='../review/list.do?c_idx='+$("#c_idx").val();
  }
</script>

</head>
<body>


 <%@ include file="../include/navbar.jsp" %>
 
	<!-- popup추가  -->
	<%@include file="cinema_popup.jsp"%>

	<div id="box" style="margin-bottom: 20px">
		<h1 id="title">영화 목록</h1>

		<c:if test="${ user.m_grade eq '관리자' }">
			<div style="float: right; margin-bottom: 20px">
				<input class="btn  btn-primary" type="button" value="영화 업로드" onclick="upload_cinema()">
			</div>
		</c:if>


		<div id="cinema_box">
			<!-- 데이터가 없는경우 -->
			<c:if test="${ empty list }">
				<div id="empty_msg">영화정보가 없습니다</div>
			</c:if>

			<!-- 데이터가 있는경우 -->
	
			
			<div class="list con">
				<ul class="row">				  
<%-- 				  <c:if test="${empty list}">
				  		<li class="no-data"><h3>데이터가 없습니다</h3><li>
				  </c:if> --%>
					<c:forEach items="${list}" var="row" varStatus="status">
						<li  class="cell ${status.index %5 ==0? 'on':''}  ${(status.count%5==0) ? 'on3':'' }" >
						
							<div class="img-box">
								<img src="../resources/upload/${row.c_filename}" onclick="cinema_view('${row.c_idx}');" style="height:125px">												
							</div>
							
							<div class="product-name" style="position:releative;">${row.c_subject}
							 <span style="position: absolute;right: 15px;" title="리뷰">
							 <br>
							 <i class="fa fa-comments"></i> ${row.review_cnt}</span>
							</div>															
						</li>																	
				  </c:forEach>						
				</ul>
			</div>
			
			
		</div>
		<div style="margin-bottom: 100px;" class="text-center">	
				<c:if test="${totCount>15}">
					${pagination}			
				</c:if>							
		</div>	
				

					
		

	</div>

</body>
</html>