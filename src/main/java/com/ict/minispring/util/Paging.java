package com.ict.minispring.util;
/*
        nowPage   : 현재 페이지
        rowTotal  : 전체 데이터 개수
        blockList : 한 페이지당 게시물 수
        blockPage : 한 화면에 나타낼 페이지 목록 수
*/
public class Paging {
	
	public static String getPaging(String pageURL,
			                       String search_filter,
			                       int nowPage, int rowTotal,int blockList, int blockPage , int c_idx){
		
		
		pageURL=pageURL+"?c_idx="+c_idx;
		
		int totalPage, /*전체 페이지 수*/
            startPage, /*시작 페이지 번호*/
            endPage;   /*마지막 페이지 번호*/

		boolean  isPrevPage,isNextPage;
		StringBuffer sb; //모든 상황을 판단하여 Html코드를 저장할 곳
		
		
		isPrevPage=isNextPage=false;
		//입력된 전체 자원을 통해 전체 페이지 수를 구한다
		totalPage = rowTotal/blockList;
		if(rowTotal%blockList!=0)totalPage++;
		

		//만약 잘못된 연산과 움직임으로 인하여 현재 페이지 수가 전체 페이지 수를 넘을 경우
		//강제로 현재 페이지 값을 전체 페이지 값으로 변경
		if(nowPage > totalPage)nowPage = totalPage;
		

		//시작 페이지와 마지막 페이지룰 구함
		startPage = ((nowPage-1)/blockPage) * blockPage+1;
		endPage =   startPage + blockPage - 1; //
		
		//마지막 페이지 수가 전체 페이지 수보다 크면 마지막 페이지 값을 변경
		if(endPage > totalPage)endPage = totalPage;
		
		//마지막 페이지가 전체 페이지보다 작을 경우 다음 페이징이 적용될 수 있도록
		//boolean 변수의 값을 설정
		if(endPage < totalPage) isNextPage = true;
		//시작페이지의 값이 1보다 작으면 이전 페이징 적용할 수 있도록 값 설정
		if(startPage > 1)isPrevPage = true;
		
		//HTML 코드를 저장할 StringBuffer 생성 -> 코드 생성
		sb = new StringBuffer();
		sb.append("<ul class=\"pagination\">");
//-----그룹 페이지 처리 : 이전--------------------------------------------------------------------------------------------		
		if(isPrevPage){
			sb.append("<li><a href ='"+pageURL+"&page=");
			sb.append(startPage-1);
			sb.append("&");
			sb.append(search_filter);
			sb.append("'>&laquo;</a></li>");
		}
		//else
			//sb.append("</");
		
//------페이지 목록 출력-------------------------------------------------------------------------------------------------
	
		for(int i=startPage; i<= endPage ;i++){
			//if(i>totalPage)break;
			if(i == nowPage){ //현재 있는 페이지
				sb.append("<li class='active'>");
				
				sb.append("<a href=\"#\">");
				sb.append(i);
				sb.append("</a>");
				
				sb.append("</li>");
			}
			else{//현재 페이지가 아니면
				sb.append(" <li><a href='"+pageURL+"&page=");
				sb.append(i);
				sb.append("&");
				sb.append(search_filter);
				sb.append("'>");
				sb.append(i);
				sb.append("</a></li>");
			}
		}// end for

		
		//sb.append("&nbsp;|");
		
//-----그룹 페이지 처리 : 다음----------------------------------------------------------------------------------------------
		if(isNextPage){
			sb.append("<li><a href='"+pageURL+"&page=");
			sb.append(endPage+1);			
			sb.append("&");
			sb.append(search_filter);			
			sb.append("'>&raquo;</a></li>");
		}
		else
		//	sb.append(">");
		sb.append("</ul>");
//---------------------------------------------------------------------------------------------------------------------	    
		return sb.toString();
	}
	

}