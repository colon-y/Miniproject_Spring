<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta name="autocomplete" content="off" />
<title>회원등록</title>
<!-- Bootstrap 3.x -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- SweetAlert2 library -->
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- Daum 우편번호 검색 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>



<style type="text/css">
#box {
	width: 800px !important;
	margin: auto;
	margin-top: 60px;
}

td span{
	margin-top:5px;
}
</style>




<script type="text/javascript">

  var regular_name = /^[ㄱ-ㅎ|가-힣|a-z|A-Z\*]+$/;
  
  //문서내 Element의 배치가 완료가 되면
  $(document).ready(function(){
	  $('#m_id').attr("autocomplete","off");
	  $('#m_pwd').attr("autocomplete","off");
	  
	  //이름 입력창에서 키가 입력되면
	  $("#m_name").keyup(function(event){
		  var m_name = $(this).val();
		  if(regular_name.test(m_name)==false){
			  $("#name_msg").html("이름은 한글 또는 영문으로 입력해주세요").css("color","red");
			  //가입하기 버튼 비활성화
		      $("#btn_register").attr("disabled", true);
			  return;		  
	     }else{
	    	  $("#name_msg").html("사용 가능한 이름입니다").css("color","blue");
	    	  //가입하기 버튼 활성화
			  $("#btn_register").attr("disabled", false);
		 }
		  
		  /* //서버에 사용가능 여부 확인(jQuery Ajax)
		  $.ajax({
			  url		: 'check_name.do',			//MemberCheckNameAction
			  data		: {'m_name': m_name},       // parameter : check_name.do?m_name=one
			  success	: function(res_data){	
				 if(parseInt(res_data)==0){
					 $("#name_msg").html("사용 가능한 이름입니다").css("color","blue");			                          			  				
					 $("#btn_register").attr("disabled", false);	 
				 }else{
					 $("#name_msg").html("사용 불가능한 이름입니다").css("color","red");			                          			  				
					 $("#btn_register").attr("disabled", true);	
				 }
				  				  				
			  },error:function(err){
				  console.log("err : ",err);
				  //alert(err.responseText);
			  }
		  });	 */	  
	  });
	  
  });
  

  var regular_id = /^[a-zA-Z0-9]{3,16}$/;

  //문서내 Element의 배치가 완료가 되면
  $(document).ready(function(){
	  
	  //아이디 입력창에서 키가 입력되면
	  $("#m_id").keyup(function(event){
		  
		  var m_id = $(this).val();
		  
		  if(regular_id.test(m_id)==false){
			  
			  $("#id_msg").html("아이디는 3~16자리의 영문자/숫자 조합으로 입력해주세요")
			              .css("color","red");
			  
			  //가입하기 버튼 비활성화
		      $("#btn_register").attr("disabled", true);
			  return;
		  }
		  
		  
		  //서버에 사용가능 여부 확인(jQuery Ajax)
		  $.ajax({
			  url		: 'check_id.do',			//MemberCheckIdAction
			  data		: {'m_id': m_id},			//parameter : check_id.do?m_id=one
			  dataType	: 'json',
			  success	: function(res_data){
				  
				  if(res_data==true){//사용가능한 아이디
					  
					  $("#id_msg").html("사용 가능한 아이디입니다")
		                          .css("color","blue");
				  
				       //가입하기 버튼 활성화
				       $("#btn_register").attr("disabled", false);
					   
				  }else{//이미 사용중인 아이디
					  
					  $("#id_msg").html("이미 사용중인 아이디입니다")
                                .css("color","red");					  
				      //가입하기 버튼 비활성화
				      $("#btn_register").attr("disabled", true);
				  
				  }
				  
			  },
			  error		: function(err){
				  alert(err.responseText);
			  }
		  });
		  
	  });
	  
  });

  var regular_pwd = "^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
	  
  //문서내 Element의 배치가 완료가 되면
	  $(document).ready(function(){
		  
		  //비밀번호 입력창에서 키가 입력되면
		  $("#m_pwd").keyup(function(event){
			  
			  var m_pwd = $(this).val();
			  
			  if(regular_pwd.test(m_pwd)==false){
				  
				  $("#pwd_msg").html("8자 이상, 최소 하나의 문자와 숫자를 사용해주세요")
				               .css("color","red");
				  
				  //가입하기 버튼 비활성화
			      $("#btn_register").attr("disabled", true);
				  return;
			  }else{
				  $("#pwd_msg").html("사용 가능한 비밀번호입니다").css("color","blue");
				  //가입하기 버튼 활성화
				  $("#btn_register").attr("disabled", false);
			  }
			  
			  
			  /* //서버에 사용가능 여부 확인(jQuery Ajax)
			  $.ajax({
				  url		: 'check_pwd.do',			//MemberCheckPwdAction
				  data		: {'m_pwd': m_pwd},			//parameter : check_pwd.do?m_pwd=one
				  dataType	: 'json',
				  success	: function(res_data){
					  //res_data = {"result": true }  //사용가능
					  //res_data = {"result": false}  //현재 사용중(사용못함)
					  
					  if(res_data.result)
						  
						  $("#pwd_msg").html("사용 가능한 비밀번호입니다")
			                          .css("color","blue");
					  
					      //가입하기 버튼 활성화
					      $("#btn_register").attr("disabled", false);
						  
					  
				  },
				  error		: function(err){
					  alert(err.responseText);
				  }
			  }); */
			  
		  });
		  
	  });
	  
	  
  var regular_nickname = /^[ㄱ-ㅎ|가-힣|a-z|A-Z\*]{3,16}$/;
  
  //문서내 Element의 배치가 완료가 되면
  $(document).ready(function(){
	  
	
	  
	  //닉네임 입력창에서 키가 입력되면
	  $("#m_nickname").keyup(function(event){
		  
		  var m_nickname = $(this).val();
		  
		  if(regular_nickname.test(m_nickname)==false){			  
			  $("#nickname_msg").html("닉네임은 3~16자리의 한글 또는 영문으로 입력해주세요").css("color","red");			              			  
			  //가입하기 버튼 비활성화
		     $("#btn_register").attr("disabled", true);
			  return;
		  }
		  
		  
		  //서버에 사용가능 여부 확인(jQuery Ajax)
		  $.ajax({
			  url		: 'check_nickname.do',      //MemberCheckNicknameAction
			  data		: {'m_nickname': m_nickname},			//parameter : check_id.do?m_id=one
			  dataType	: 'json',
			  success	: function(res_data){
				 
				  if(res_data){//사용가능한 아이디					  
					  $("#nickname_msg").html("사용 가능한 닉네임입니다").css("color","blue");				  
				       //가입하기 버튼 활성화
				       $("#btn_register").attr("disabled", false);
				       
				  }else{//이미 사용중인 닉네임					  
					  $("#nickname_msg").html("이미 사용중인 닉네임입니다").css("color","red");					  
				      //가입하기 버튼 비활성화
				      $("#btn_register").attr("disabled", true);				  
				  }
				  
			  },
			  error		: function(err){
				  alert(err.responseText);
			  }
		  });
		  
	  });
	  
  });
  
  function find(){
	  
	  var width  = 500; //팝업의 너비
	  var height = 600; //팝업의 높이
	  
	  new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
	            // data = {'zonecode':12345 ,'address':'서울시 마포구 노고산동','roadAddress':'', 'jibunAddress':'서울' }
	            
	            //선택된 주소의 우편번호 넣기
	            $("#m_zipcode").val(data.zonecode);
	            
	          //선택된 주소의 주소 넣기
	            $("#m_addr").val(data.address);
	        },
	        theme: {
	            searchBgColor: "#0B65C8", //검색창 배경색
	            queryTextColor: "#FFFFFF" //검색창 글자색
	        },
	        width: width,
	        height: height
	  }).open(
			  //중앙에 띄우겠다 
			  {
				    left: (window.screen.width / 2) - (width / 2),
				    top: (window.screen.height / 2) - (height / 2)
		      }
			 ); 
  }
  
  
  function send(f){
	  
	  //입력값 체크(이름/비번/우편번호/주소)
	  var m_name 	 = f.m_name.value.trim();
	  var m_id       = f.m_id.value.trim();
	  var m_pwd  	 = f.m_pwd.value.trim();
	  var m_nickname = f.m_nickname.value.trim();
	  var m_zipcode  = f.m_zipcode.value.trim();
	  var m_addr 	 = f.m_addr.value.trim();
	  
	  //이름체크
	  if(m_name==''){
		  alert('이름을 입력하세요');
		  f.m_name.value='';
		  f.m_name.focus();
		  return;
	  }
	  
	  //비번체크
	  if(m_pwd==''){
		  alert('비밀번호를 입력하세요');
		  f.m_pwd.value='';
		  f.m_pwd.focus();
		  return;
	  }
	  
	//닉네임체크
	  if(m_nickname==''){
		  alert('닉네임을 입력하세요');
		  f.m_nickname.value='';
		  f.m_nickname.focus();
		  return;
	  }
	  
	  //우편번호체크
	  if(m_zipcode==''){
		  alert('우편번호를 입력하세요');
		  f.m_zipcode.value='';
		  f.m_zipcode.focus();
		  find();
		  return;
	  }
	  
	  //주소체크
	  if(m_addr==''){
		  alert('주소를 입력하세요');
		  f.m_addr.value='';
		  f.m_addr.focus();
		  return;
	  }  

	  const span=document.querySelectorAll("span");
	  span.forEach(item=>{
		  console.log(" item : ", item);
	  });
	  
	  	  
 	  f.action = "insert.do";//MemberInsertAction
	  f.submit(); 
  }

</script>

<script type="text/javascript">

	function enterup() {
	    //alert("Enter Key 입력 감지 \n함수 실행.");
	}

</script>

</head>
<body>

	<%@ include file="../include/navbar.jsp"%>


	<form autocomplete="off">
		<div id="box">
			<h1 id="title">회원가입</h1>
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h4>회원가입</h4>
				</div>
				<div class="panel-body">
					<table class="table  table-striped">

						<tr>
							<th>이름</th>
							<td><input name="m_name" id="m_name" class="form-control" onkeyup="enterkey()">  
								<span id="name_msg"></span>
							</td>
						</tr>

						<tr>
							<th>아이디</th>
							<td>
							
							<input style="display:none" aria-hidden="true">
							<input type="password" style="display:none" aria-hidden="true">						
							<input type="text"   style="display:none" aria-hidden="true">
							<input type="text"  name="m_id" id="m_id" class="form-control" autocomplete="off" autocapitalize="off" onkeyup="enterkey()"> 							
							<span id="id_msg" style="display:inline-block;"></span>
							</td>
						</tr>

						<tr>
							<th>비밀번호</th>
							<td><input type="password" name="m_pwd"  id="m_pwd" 
							class="form-control" autocomplete="none" onkeyup="enterkey()">
							<span id="pwd_msg"></span>
							</td>
						</tr>

						<tr>
							<th>닉네임</th>
							<td><input name="m_nickname" id="m_nickname" class="form-control" onkeyup="enterkey()"> 
							<span id="nickname_msg"></span>
							</td>
						</tr>

						<tr>
							<th>우편번호</th>
							<td><input id="m_zipcode" name="m_zipcode" class="form-control" style="display: inline;width: 30%" readonly> 
								<input type="button" class="btn btn-default" value="주소찾기" onclick="find();">
							</td>
						</tr>

						<tr>
							<th>주소</th>
							<td>
								<input id="m_addr" name="m_addr" size="60" class="form-control" onkeyup="enterkey()">
							</td>
						</tr>

						<tr>
							<td colspan="2" align="center">
							<input class="btn  btn-primary submit" type="button" value="가입하기" id="btn_register" disabled="disabled" onclick="send(this.form);"
								onkeyup="if(window.event.keyCode==13){enterup()}"
							> <input class="btn  btn-success" type="button" value="영화목록" onclick="location.href='${ pageContext.request.contextPath }/cinema/list.do';"></td>
						</tr>

					</table>
				</div>
			</div>
		</div>
	</form>

<script>
function enterkey() {	
	if (window.event.keyCode==13) {		
    	$(".submit").click();
    }
}
</script> 
</body>
</html>