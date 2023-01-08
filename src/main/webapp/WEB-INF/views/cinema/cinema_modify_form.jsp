<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Bootstrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
  #box{
     width: 500px;
     margin: auto;
     margin-top: 50px;
  
  }
  
  textarea {
	 width: 100%;
	 height: 150px;
	 resize: none;  
  }
  
  img{
     width: 80%;
     border: 1px solid gray;
     outline: 1px solid black;
  }

</style>


<script type="text/javascript">
 
  function send(f){
	  
	  var c_subject = f.c_subject.value.trim();
	  var c_info = f.c_info.value.trim();
	  
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
	  
	  //
	  f.action = "modify.do";  //CinemaModifyAction
	  f.submit();
	  
	  
  }
  
  //Ajax 파일 업로드
  function ajaxFileUpload() {
       // 업로드 버튼이 클릭되면 파일 찾기 창을 띄운다.
       $("#ajaxFile").click();
  }

  function ajaxFileChange() {
       // 파일이 선택되면 업로드를 진행한다.
      cinema_upload();
  }
  
  function cinema_upload() {

	   //console.log($("#ajaxFile")[0]);	
	   //파일선택->취소시
	   if( $("#ajaxFile")[0].files[0]==undefined)return;
	   
	   
	   
	 var form = $("#ajaxForm")[0];
     var formData = new FormData(form);
     formData.append("c_idx", '${ vo.c_idx }');
     formData.append("cinema", $("#ajaxFile")[0].files[0]); // cinema_upload.do?c_idx=5&cinema=a.jpg

     $.ajax({
           url : "cinema_upload.do", //CinemaUploadAction
           type : "POST",
           data : formData,
           processData : false,
           contentType : false,
           dataType : 'json',
           success:function(result_data) {
          	 
          	 $("#my_img").attr("src","../resources/upload/" + result_data.c_filename);
          	 
           },
           error : function(err){
          	 alert(err.responseText);
           }
     });
   }

</script>

</head>
<body>
	
	<%@ include file="../include/navbar.jsp"%>
	

	<!--파일업로드용 폼-->
	<form enctype="multipart/form-data" id="ajaxForm" method="post">
	    <input  type="file" id="ajaxFile" style="display:none;"  onChange="ajaxFileChange();" >
	</form>

	<form>
	<input type="hidden" name="c_idx" value="${ vo.c_idx }">
	   <div id="box">
	   		<h1 id="title">영화 목록</h1>
	        <div class="panel panel-primary" >
		      <div class="panel-heading"><h4>영화정보수정</h4></div>
		      <div class="panel-body">
		          <table class="table  table-striped">
		             <tr>
		               <td colspan="2" align="center">
		                 <img id="my_img" src="../resources/upload/${ vo.c_filename }">
		                 <br><br>
		                 <input type="button" class="btn btn-warning" value="사진수정" onclick="ajaxFileUpload();">
		               </td>
		             </tr>
		          
		             <tr>
		               <th>카테고리</th>
		               <td>
		               <select name="c_category" class="form-control">
			               <option value="액션" ${vo.c_category eq '액션' ? 'selected' :''}>액션</option>
			               <option value="SF" ${vo.c_category eq 'SF' ? 'selected' :''}>SF</option>
			               <option value="멜로" ${vo.c_category eq '멜로' ? 'selected' :''}>멜로</option>
			               <option value="드라마" ${vo.c_category eq '드라마' ? 'selected' :''}>드라마</option>
			               <option value="코미디" ${vo.c_category eq '코미디' ? 'selected' :''}>코미디</option>
			               <option value="아동" ${vo.c_category eq '아동' ? 'selected' :''}>아동</option>
		               </select>
		               </td>
		             </tr>
		             
		             <tr>
		                <th>제목</th>
		                <td><input name="c_subject"  class="form-control" style="width: 100%;" value="${vo.c_subject}"></td>
		             </tr>
		             
		             <tr>
		                <th>내용</th>
		                <td><textarea name="c_info"  class="form-control" style="height:150px;">${vo.c_info}</textarea></td>
		             </tr>
		             
		             <tr>
		                <td colspan="2" align="center">
		                   <input class="btn  btn-primary submit"  type="button"   value="수정" onclick="send(this.form);" >
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