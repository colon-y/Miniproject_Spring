<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="URL" value="${pageContext.request.requestURL}" />  
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/images/style.css">
  
<!-- Fixed navbar -->
    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">MovieSpring</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="${pageContext.request.contextPath}/">MovieSpring</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav">
           <li class="${fn:contains(URL, 'cinema')? 'active':''}" ><a href="${pageContext.request.contextPath}/cinema/list.do" class="menu-a">영화목록</a></li>    
 		   <c:if test="${not empty sessionScope.user}">
 			<li class="${fn:contains(URL, 'member')? 'active':''}">
 				<a href="${pageContext.request.contextPath}/member/list.do" class="menu-a">
          			${ user.m_grade eq '관리자' ? '회원목록':'회원정보' }</a>
          	</li>
          	</c:if>
          </ul>
          <ul class="nav navbar-nav navbar-right">
          <c:choose>
          	<c:when test="${empty sessionScope.user}">
				<li><a href="${pageContext.request.contextPath}/member/insert_form.do" class="menu-a">회원가입</a></li>
            	<li><a href="${pageContext.request.contextPath}/member/login_form.do" class="menu-a">로그인</a></li>
          	</c:when>
          	<c:otherwise>          	
          		<li><a href="#" class="under-none"><b>${ user.m_name }님</b> 환영합니다.</a></li>          	
          		<li><a href="${pageContext.request.contextPath}/member/logout.do" class="menu-a">로그아웃</a></li>
          	</c:otherwise>
          </c:choose>          
          </ul>
          
        </div><!--/.nav-collapse -->
      </div>
    </nav>    
    
    <div class="mb-5"style="margin-bottom: 100px"></div>
    
    
    