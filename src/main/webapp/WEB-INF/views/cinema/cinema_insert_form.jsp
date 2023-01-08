<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화등록</title>
<!-- Bootstrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
  #box{
     width: 800px;
     margin: auto;
     margin-top: 50px;
  
  }
  
  textarea {
	 width: 100%;
	 height: 150px;
	 resize: none;  
  }

</style>


<script type="text/javascript">
 
  function send(f){
	  
	  var c_subject = f.c_subject.value.trim();
	  var c_info    = f.c_info.value.trim();
	  var c_photo   = f.c_photo.value;
	  
	  if(c_subject==''){
		  
		  alert('제목을 입력하세요');
		  f.c_subject.value='';
		  f.c_subject.focus();
		  return;
	  }
	  
	  if(c_info==''){
		  
		  alert('내용을 입력하세요');
		  f.c_info.value='';
		  f.c_info.focus();
		  return;
	  }
	  
	  if(c_photo==''){
		  alert('사진을 선택하세요');
		  return;
	  }
	  
	  //
	  f.action = "insert.do";  //CinemaInsertAction
	  f.submit();
	  
	  
  }

</script>

</head>
<body>


 <%@ include file="../include/navbar.jsp" %>
 
 
	<form  method="POST"  enctype="multipart/form-data">
	   <div id="box">
	   		<h1 id="title">영화 등록</h1>
	   		
	        <div class="panel panel-primary">
		      <div class="panel-heading"><h4>영화등록</h4></div>
		      <div class="panel-body">
		          <table class="table  table-striped">
		             <tr>
		               <th>카테고리</th>
		               <td>
		               <select name="c_category" class="form-control" style="width: 150px">
			               <option value="액션">액션</option>
			               <option value="SF">SF</option>
			               <option value="멜로">멜로</option>
			               <option value="드라마">드라마</option>
			               <option value="코미디">코미디</option>
			               <option value="아동">아동</option>
		               </select></td>
		             </tr>
		             
		             <tr>
		                <th>제목</th>
		                <td><input name="c_subject"  style="width: 100%;" class="form-control"></td>
		             </tr>
		             
		             <tr>
		                <th>내용</th>
		                <td><textarea name="c_info" class="form-control" style="height: 200px"></textarea></td>
		             </tr>
		             
		             <tr>
		                <th>사진</th>
		                <td><input type="file"  name="c_photo"></td>
		             </tr>
		             
		             <tr>
		                <td colspan="2" align="center">
		                   <input class="btn  btn-primary submit"  type="button"  value="등록" onclick="send(this.form);">
		                   <input class="btn  btn-success"  type="button"  value="목록" onclick="location.href='list.do';">
		                </td>
		             </tr>
		                
		          </table>
		      </div>
		    </div>
	   
	   </div>
	</form>

<script>
$(function(){
	$("input").on("keyup",function(e){
		if (window.event.keyCode==13) {		
	    	$(".submit").click();
	    }
	})
})
</script>
</body>
</html>