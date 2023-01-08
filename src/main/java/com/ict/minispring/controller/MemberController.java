package com.ict.minispring.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ict.minispring.dao.MemberDao;
import com.ict.minispring.vo.MemberVo;

@Controller
@RequestMapping("/member/")
public class MemberController {
		
	@Autowired
	private HttpServletRequest request;
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private MemberDao member_dao;

	/**
	 * 회원목록
	 * @param m_id
	 * @param model
	 * @return
	 */
	@RequestMapping("list.do")
	public String list(String m_id, Model model) throws Exception{
		List<MemberVo> list = member_dao.selectList();		
		model.addAttribute("list", list);		
		return "member/member_list";
	}
	
	/**
	 * 회원가입 폼
	 * @return
	 */
	@RequestMapping("insert_form.do")
	public String insert_form(String msg)  throws Exception{		
		return "member/member_insert_form";
	}
			
	/**
	 * 회원등록 처리
	 * @param vo
	 * @return
	 */
	@RequestMapping("insert.do")
	public String insert(MemberVo vo, HttpSession session , RedirectAttributes rttr) throws Exception {		
		String ip = request.getRemoteAddr();
		
		vo.setM_ip(ip);
		vo.setM_grade("일반");	
		member_dao.insert(vo);
		if(session.getAttribute("user")!=null) {
			return "redirect:list.do";	
		}				
		return "redirect:login_form.do?msg=success";		
	}
	
	/**
	 * 회원정보 수정폼
	 * @param m_idx
	 * @param model
	 * @return
	 */
	@RequestMapping("modify_form.do")
	public String modify_form(int m_idx, Model model) throws Exception {
		MemberVo vo = member_dao.selectOne(m_idx);		
		model.addAttribute("vo", vo);		
		return "member/member_modify_form";
	}
	
	/**
	 * 회원수정
	 * @param vo
	 * @return
	 */
	@PostMapping("modify.do")
	public String modify(MemberVo vo)  throws Exception{		
		String m_ip = request.getRemoteAddr();		
		vo.setM_ip(m_ip);	
		member_dao.update(vo);		
		return "redirect:list.do";
	}
	
	
	/**
	 * 회원삭제
	 * @param m_idx
	 * @return
	 */
	@RequestMapping("delete.do")
	public String delete(int m_idx) throws Exception {		
		//member_dao.delete(m_idx);		
		member_dao.deleteHide(m_idx);
		return "redirect:list.do";
	}
	

	/**
	 * 로그인폼
	 * @return
	 */
	@RequestMapping("login_form.do")
	public String login_form() throws Exception {		
		return "member/member_login_form";
	}
	
	/**
	 * 로그인처리
	 * @param m_id
	 * @param m_pwd
	 * @param model
	 * @return
	 */
	@RequestMapping("login.do")
	public String login(String m_id, String m_pwd, Model model) throws Exception {		
		MemberVo user = member_dao.selectOne(m_id);
		
		if(user==null) {
			model.addAttribute("reason", "fail_id");
			return "redirect:login_form.do?";
		}
		
		if(user.getM_pwd().equals(m_pwd)==false) {
			model.addAttribute("reason", "fail_pwd");
			model.addAttribute("m_id", m_id);
			return "redirect:login_form.do?";
		}
		
		if(user.getM_delete().equals("hide")) {			
			return "redirect:login_form.do?msg=userDelete";
		}
		
		session.setAttribute("user", user);		
		return "redirect:../cinema/list.do";
	}
	
	/**
	 * 아이디 중복체크
	 * @param m_id
	 * @return
	 */
	@RequestMapping(value="check_id.do")
	@ResponseBody
	public String check_id(String m_id)  throws Exception {		
		MemberVo vo = member_dao.checkId(m_id);
		return vo==null? "true":"false";
	}
	
	
	/**
	 * 닉네임 중복체크
	 * @param m_nickname
	 * @return
	 */
	@RequestMapping(value="check_nickname.do")
	@ResponseBody
	public boolean check_nickname(String m_nickname) throws Exception {		
		MemberVo vo = member_dao.checkNickname(m_nickname);		
		boolean bResult = false;		
		if(vo==null) bResult = true;	
		return bResult;
	}
	
	
	/**
	 * 로그아웃 처리
	 * @return
	 */
	@RequestMapping("logout.do")
	public String logout() throws Exception {		
		session.invalidate();		
		return "redirect:../cinema/list.do";		
	}
	
	
	
	
}
