package com.ict.minispring.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ict.minispring.common.MyConstant;
import com.ict.minispring.dao.CinemaDao;
import com.ict.minispring.dao.ReviewDao;
import com.ict.minispring.util.Paging;
import com.ict.minispring.vo.CinemaVo;
import com.ict.minispring.vo.MemberVo;
import com.ict.minispring.vo.ReviewVo;

@Controller
@RequestMapping("/review/")
public class ReviewController {

	public static final int BLOCK_LIST = 5;
	
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private ReviewDao review_dao;

	
	@Autowired
	private CinemaDao cinema_dao;
	
	@RequestMapping("list.do")
	public String list(@RequestParam(value="page", required=false, defaultValue="1") int nowPage,
			           @RequestParam(value="search", required=false, defaultValue="all") String search,
			           @RequestParam(name="search_text", required=false) String search_text,
			           @RequestParam(name="c_idx")  Integer c_idx,
			           Model model)  throws Exception{
		if(c_idx==null)	return "redirect:list.do";
		CinemaVo cinemaVo = cinema_dao.selectOne(c_idx);	
		
		session.removeAttribute("show");
		
		int start = (nowPage-1) * MyConstant.Review.BLOCK_LIST + 1;
		int end   = start       + MyConstant.Review.BLOCK_LIST - 1;
		
		Map<String, Object> map = new HashMap<>();
		map.put("c_idx", c_idx);
		map.put("start", start);
		map.put("end", end);
		map.put("search", search);
		map.put("search_text", search_text);
		

		int rowTotal = review_dao.selectRowTotal(map);		
		String search_filter = String.format("search=%s&search_text=%s", search, search_text);		
		String pageMenu = Paging.getPaging("list.do", 
                                           search_filter,
                                           nowPage,
                                           rowTotal,
                                           MyConstant.Review.BLOCK_LIST,
                                           MyConstant.Review.BLOCK_PAGE,
                                           c_idx
                						  );
		
		List<ReviewVo> list = review_dao.selectList(map);
		model.addAttribute("cinemaVo", cinemaVo);
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);		
		return "review/review_list";
	}
	
	
	@RequestMapping("insert_form.do")
	public String insert_form(HttpSession session) throws Exception{
		if(session.getAttribute("user")==null)return "redirect:../member/login_form.do";
		return "review/review_insert_form";
	}
	
	
	@RequestMapping("insert.do")
	public String insert(ReviewVo vo,  HttpSession session,  Model model) throws Exception {		
		if(session.getAttribute("user")==null) {			
			model.addAttribute("reason", "session_timeout");			
			return "redirect:../member/login_form.do";
		}
		MemberVo memberVo=(MemberVo)session.getAttribute("user");
		vo.setM_idx(memberVo.getM_idx());
		review_dao.insert(vo);		
		return "redirect:list.do?c_idx="+vo.getC_idx();
	}
	
	
	
	@RequestMapping("delete.do")
	public String delete(int r_idx,int c_idx,
						 @RequestParam(value="page", required=false, defaultValue = "1") int page,
			             @RequestParam(value="search", required=false, defaultValue = "all") String search,
			             @RequestParam(value="search_text", required=false) String search_text,
			             Model model) throws Exception{
		if(session.getAttribute("user")==null) return "redirect:../member/login_form.do";
		MemberVo memberVo=(MemberVo)session.getAttribute("user");
		ReviewVo reviewVo = review_dao.selectOne(r_idx);	
		if(memberVo.getM_idx()!=reviewVo.getM_idx()){
			if(!memberVo.getM_grade().equals("관리자") ) return "redirect:../member/login_form.do";
		}
		
		System.out.println(" 리뷰 삭제  : " +r_idx);
		 
		review_dao.delete(r_idx);		
		model.addAttribute("page", page);
		model.addAttribute("search", search);
		model.addAttribute("search_text", search_text);	
		return "redirect:list.do?c_idx="+c_idx+"&r_idx="+r_idx+"&page="+page+"&search="+search+"&search_text="+search_text;		
	}
	
	
	@RequestMapping("modify_form.do")
	public String modify_form(int r_idx, Model model) {				
		if(session.getAttribute("user")==null) return "redirect:../member/login_form.do";
		MemberVo memberVo=(MemberVo)session.getAttribute("user");
		ReviewVo reviewVo = review_dao.selectOne(r_idx);
		if(memberVo.getM_idx()!=reviewVo.getM_idx()){
			if(!memberVo.getM_grade().equals("관리자") ) return "redirect:../member/login_form.do";
		}	
		
		ReviewVo vo = review_dao.selectOne(r_idx);				
		model.addAttribute("vo", vo);		
		return "review/review_modify_form";
	}
	
	
	@RequestMapping("modify.do")
	public String modify(ReviewVo vo,
			 			 @RequestParam(value="page", required=false, defaultValue = "1")int page,
                         @RequestParam(value="search",required=false, defaultValue="all") String search,
	                     @RequestParam(value="search_text", required=false) String search_text, 
	                     HttpSession session,
                         Model model) throws Exception {	
	
		if(session.getAttribute("user")==null) return "redirect:../member/login_form.do";
		MemberVo memberVo=(MemberVo)session.getAttribute("user");
		ReviewVo reviewVo = review_dao.selectOne(vo.getR_idx());	
		if(memberVo.getM_idx()!=reviewVo.getM_idx()){
			if(!memberVo.getM_grade().equals("관리자") ) return "redirect:../member/login_form.do";
		}
		
		vo.setM_idx(reviewVo.getM_idx());
		review_dao.update(vo);	
		
		model.addAttribute("r_idx", vo.getR_idx());
		model.addAttribute("page" , page);
		model.addAttribute("search", search);
		model.addAttribute("search_text", search_text);		
		return "redirect:list.do?c_idx="+vo.getC_idx()+"&r_idx="+vo.getR_idx()+"&page="+page+"&search="+search+"&search_text="+search_text;
	}
	
	
	
}
