<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 수정</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
<script src="//cdn.ckeditor.com/4.19.0/full/ckeditor.js"></script>  
<script type="text/javascript">
    var toolbar = {
            toolbarGroups : [
                { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
                { name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ] },
               /*  { name: 'links', groups: [ 'links' ] },
                { name: 'insert', groups: [ 'insert' ] },
                '/',
                { name: 'clipboard', groups: [ 'clipboard', 'undo' ] }, */
                { name: 'styles', groups: [ 'styles' ] },
                { name: 'colors', groups: [ 'colors' ] },
                { name: 'tools', groups: [ 'tools' ] },
                { name: 'others', groups: [ 'others' ] },
                { name: 'about', groups: [ 'about' ] },
                { name: 'editing', groups: [ 'find', 'selection', 'spellchecker', 'editing' ] },
                { name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
                { name: 'forms', groups: [ 'forms' ] },
            ],

            removeButtons : 'Cut,Copy,Paste,PasteText,PasteFromWord,Find,SelectAll,Scayt,Replace,Save,NewPage,ExportPdf,Print,Templates,Form,Checkbox,Radio,TextField,Textarea,Select,Button,ImageButton,HiddenField,CreateDiv,Blockquote,BidiLtr,BidiRtl,Language,RemoveFormat,CopyFormatting,Anchor,Flash,PageBreak,About',
        }


</script>  
  
  
  
<style type="text/css">
   #box{
      width: 650px;
      margin: auto;
      margin-top: 50px;
   }
   
   textarea {
	  width: 100%;
	  resize: none;
   }
</style>

<script type="text/javascript">

   function send(f){ // f = this.form
	   var r_subject = f.r_subject.value.trim();
       var r_content = CKEDITOR.instances.r_content.getData();
       
       if(r_subject==''){
    	   alert('제목을 입력하세요');
    	   f.subject.value='';
    	   f.subject.focus();
    	   return;
       }
   
       if(r_content==''){
    	   alert('내용을 입력하세요');
    	   f.content.value='';
    	   f.content.focus();
    	   return;
       }
    
	   f.action = "modify.do";//대상 : ReviewModifyAction
	   f.submit();//전송
	   
	   
   }


</script>  

</head>
<body>
	<%@ include file="../include/navbar.jsp"%>

<form>
    <div id="box">
    	<h1 id="title">리뷰 수정</h1>
          <div class="panel panel-primary">
		      <div class="panel-heading"><h4>리뷰 수정</h4></div>
		      <div class="panel-body">
		          <table class="table">
		              <tr>
		                <th>작성자</th>
		                <td><input name="m_name" value="${user.m_name}" readonly  class="form-control"></td>
		              </tr>
		              
		              <tr>
	                    <th>제목</th>
	                    <td><input style="width:100%;" name="r_subject" class="form-control" value="${vo.r_subject}"></td>
	                  </tr>
	                  
	                  <tr>
	                    <th>평점</th>	                
	                    <td>
		                    <select name="r_score" class="form-control" style="width:150px">
		                     <c:forEach begin="1" end="10" step="1" var="score">
		                     	<option value="${score}" ${vo.r_score eq score? 'selected' :''} >${score}</option>
		                     </c:forEach>	                      	                    
		                    </select>
	                    </td>
	                  </tr>
		             		              
		              <tr>
	                    <td colspan="2">
	                      <textarea name="r_content"  rows="" cols="">${ vo.r_content }</textarea>
	                      <script>
							// Replace the <textarea id="editor1"> with a CKEditor
							// instance, using default configuration.
							CKEDITOR.replace( 'r_content', {
							     filebrowserUploadUrl: '${pageContext.request.contextPath}/ckeditorImageUpload.do'	
							});
								
							CKEDITOR.on('dialogDefinition', function( ev ){
						            var dialogName = ev.data.name;
						            var dialogDefinition = ev.data.definition;
						          
						            switch (dialogName) {
						                case 'image': //Image Properties dialog
								              //dialogDefinition.removeContents('info');
								              dialogDefinition.removeContents('Link');
								              dialogDefinition.removeContents('advanced');
								              break;
							    }
							 });
						    </script>
	                      </td>
	                  </tr>
		              
		              <tr>
		                 <td colspan="2" align="center">
		                 	<input type="hidden" name="r_idx" value="${param.r_idx}">
		                 	<input type="hidden" name="c_idx" value="${param.c_idx}">
		                 		
		                     <input  class="btn  btn-primary submit" type="button"  value="작성완료"
		                             onclick="send(this.form);">
		                             
		                     <input  class="btn  btn-success" type="button"  value="목록보기" 
		                             onclick="location.href='list.do?c_idx=${param.c_idx}'">
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
		console.log(e);
		if (window.event.keyCode==13) {		
	    	$(".submit").click();
	    }
	})
})
</script> 

</body>
</html>
