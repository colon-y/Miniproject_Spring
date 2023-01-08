<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

	<div id="cinema_popup">
		<div style="text-align: right; margin-right: 3px;">
			<input type="button" value="x" style="color: red;" onclick="hide_cinema_popup();">
		</div>
		<img id="img_cinema" src="">
		<div id="cinema_category">카테고리</div>
		<div id="cinema_subject">제목</div>
		<div id="cinema_info">내용</div>
		<div id="cinema_regdate">등록일</div>
		<div>
			<input class="btn btn-info" type="button" value="리뷰보기" 
				onclick="reviewMove();">
				
			<input type="hidden" name="c_idx" id="c_idx" >
			
			<c:if test="${ user.m_grade eq '관리자' }">
				<div id="photo_job" style="display: inline; float: right;">					
					<input class="btn  btn-info" type="button" value="수정" onclick="photo_modify();"> 
					<input class="btn  btn-danger" type="button" value="삭제" onclick="photo_delete();">
				</div>
			</c:if>
		</div>
	</div>


