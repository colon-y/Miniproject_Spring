<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<!-- Bootstrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<style type="text/css">
  #box{
       width: 800px !important;
       margin: auto;
       margin-top: 100px;
  }
  
  input[type='button']{
     width: 80px;
  }
</style>

<script type="text/javascript">
  
  function send(f){
	  
	  var m_id  = f.m_id.value.trim();
	  var m_pwd = f.m_pwd.value.trim();
	  
	  if(m_id==''){
		  alert('아이디를 입력하세요');
		  f.m_id.value='';
		  f.m_id.focus();
		  return;
	  }
	  
	  if(m_pwd==''){
		  alert('비밀번호를 입력하세요');
		  f.m_pwd.value='';
		  f.m_pwd.focus();
		  return;
	  }
	  
	  f.action = "login.do"; 
	  f.submit();
  }
$(function(){
	const msg='${param.msg}';
	
	if(msg=="success"){		
		setTimeout(() => {
			history.replaceState({}, null, location.pathname);
			alert("회원 가입을 축하합니다.");			
		}, 300);
	}
	
	if(msg=="userDelete"){
		setTimeout(() => {
			history.replaceState({}, null, location.pathname);
			alert("탈퇴 처리된 회원입니다.");			
		}, 300);		
	}
})  
</script>


<script type="text/javascript">

  $(document).ready(function(){
	
	  //0.1초후에 showMessage함수 호출
	  setTimeout(showMessage,100);
	  
  });
  
  function showMessage(){
	  
	 // /member/login_form.do?reason=fail_id
	 if("${ param.reason eq 'fail_id' }" =="true"){
		 alert('아이디가 틀렸습니다');
		 return;
	 } 		  
	  
	 // /member/login_form.do?reason=fail_pwd
	 if("${ param.reason eq 'fail_pwd' }" =="true"){
		 alert('비밀번호가 틀렸습니다');
		 return;
	 } 
	 
	 // /member/login_form.do?reason=session_timeout
	 if("${ param.reason eq 'session_timeout' }" =="true"){
		 alert('로그아웃 되었습니다');
		 return;
	 } 
	 	  
	  
  }
</script>
</head>
<body>
	<%@ include file="../include/navbar.jsp"%>

<form>
	 <div id="box">
	 	<h1 id="title">로그인</h1>
	    <div class="panel panel-primary">
	      <div class="panel-heading"><h5>로그인</h5></div>
	      <div class="panel-body">
	          <table class="table  table-striped">
	             <tr>
	                <th>아이디</th>
	                <td><input name="m_id" class="form-control" value="${ param.m_id }" onkeyup="enterkey()"></td>
	             </tr>
	             <tr>
	                <th>비밀번호</th>
	                <td><input type="password" class="form-control" name="m_pwd" onkeyup="enterkey()"></td>
	             </tr> 
	             
	             <tr>
	                <td colspan="2" align="center">
	                   <input  class="btn btn-primary submit" type="button"  value="로그인" 
	                           onclick="send(this.form);"  >
	                   <input  class="btn btn-success " type="button"  value="목록보기"  
	                           onclick="location.href='../cinema/list.do';">
	                </td>
	             </tr>
	             
	          </table>
	      </div>
	    </div>
	 </div>
</form>



 
<script>
function enterkey(e) {	
	if (window.event.keyCode==13) {		
    	$(".submit").click();
    }
}
</script> 
</body>
</html>