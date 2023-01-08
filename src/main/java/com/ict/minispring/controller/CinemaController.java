package com.ict.minispring.controller;

import java.io.File;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ict.minispring.dao.CinemaDao;
import com.ict.minispring.util.PageMaker;
import com.ict.minispring.vo.CinemaVo;
import com.ict.minispring.vo.MemberVo;

@Controller
@RequestMapping("/cinema/")
public class CinemaController {

	@Autowired
	private ServletContext application;

	@Autowired
	private HttpSession session;

	@Autowired
	private CinemaDao cinema_dao;

	/**
	 * 영화목록
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("list.do")
	public String list(PageMaker pageMaker, HttpServletRequest request, Model model) throws Exception {
		int totCount = cinema_dao.getTotCount();
		pageMaker.setPerPageNum(15);
		pageMaker.setTotPage(totCount);
		List<CinemaVo> list = cinema_dao.selectList(pageMaker);
		String pagination = pageMaker.bootStrapPagingHTML(request.getContextPath() + "/cinema/list.do");

		model.addAttribute("list", list);
		model.addAttribute("totCount", totCount);
		model.addAttribute("pagination", pagination);
		return "cinema/cinema_list";
	}

	/**
	 * 영화등록 폼
	 * 
	 * @return
	 */
	@RequestMapping("insert_form.do")
	public String insert_form() throws Exception {
		return "cinema/cinema_insert_form";
	}

	/**
	 * 영화등록
	 * 
	 * @param vo
	 * @param c_photo
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("insert.do")
	public String upload1(CinemaVo vo, @RequestParam MultipartFile c_photo, Model model) throws Exception {
		MemberVo user = (MemberVo) session.getAttribute("user");
		if (user == null) {
			model.addAttribute("reason", "session_timeout");
			return "redirect:../member/login_form.do";
		}

		String web_path = "/resources/upload/";
		String abs_path = application.getRealPath(web_path);
		String c_filename = "no_file";

		if (!c_photo.isEmpty()) {
			c_filename = c_photo.getOriginalFilename();
			File c = new File(abs_path, c_filename);

			if (c.exists()) {
				long time = System.currentTimeMillis();
				c_filename = String.format("%d_%s", time, c_filename);
				c = new File(abs_path, c_filename);
			}
			vo.setC_filename(c_filename);
			c_photo.transferTo(c);
		}

		
		 String c_info = vo.getC_info().replaceAll("\r\n", "<br>");
		 vo.setC_info(c_info);
		 

		cinema_dao.insert(vo);
		return "redirect:list.do";
	}

	/**
	 * 영화 수정폼 이동
	 * 
	 * @param c_idx
	 * @param model
	 * @return
	 */
	@RequestMapping("modify_form.do")
	public String modify_form(int c_idx, Model model) throws Exception {
		CinemaVo vo = cinema_dao.selectOne(c_idx);
		
		String c_info = vo.getC_info().replaceAll("<br>", "\r\n");
		vo.setC_info(c_info);

		model.addAttribute("vo", vo);
		return "cinema/cinema_modify_form";
	}

	/**
	 * 영화 수정
	 * 
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("modify.do")
	public String modify(CinemaVo vo) throws Exception {
		
		String c_info = vo.getC_info().replaceAll("\r\n", "<br>");
		vo.setC_info(c_info);

		int res = cinema_dao.update(vo);
		return "redirect:list.do";
	}

	/**
	 * 영화 삭제 처리
	 * 
	 * @param c_idx
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("delete.do")
	public String delete(int c_idx) throws Exception {

		CinemaVo vo = cinema_dao.selectOne(c_idx);
		String path = application.getRealPath("/resources/upload");
		if (vo != null && vo.getC_filename() != null && !vo.getC_filename().equals("")) {
			File f = new File(path, vo.getC_filename());
			f.delete();
			cinema_dao.delete(c_idx);
		}
		return "redirect:list.do";
	}

	/**
	 * 이미지 수정
	 * 
	 * @param c_idx
	 * @param c_photo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("cinema_upload.do")
	@ResponseBody
	public String upload(@RequestParam("c_idx") int c_idx, @RequestParam("cinema") MultipartFile c_photo)
			throws Exception {

		String web_path = "/resources/upload/";
		String abs_path = application.getRealPath(web_path);

		CinemaVo originVo = cinema_dao.selectOne(c_idx);
		File deleteFile = new File(abs_path, originVo.getC_filename());
		deleteFile.delete();

		String c_filename = "no file";
		if (!c_photo.isEmpty()) {

			c_filename = c_photo.getOriginalFilename();
			File f = new File(abs_path, c_filename);

			if (f.exists()) {

				long time = System.currentTimeMillis();
				c_filename = String.format("%d%s", time, c_filename);

				f = new File(abs_path, c_filename);

			}

			c_photo.transferTo(f);

		}

		CinemaVo vo = new CinemaVo();
		vo.setC_idx(c_idx);
		vo.setC_filename(c_filename);

		int res = cinema_dao.update_filename(vo);

		JSONObject json = new JSONObject();
		json.put("c_filename", c_filename);

		String json_str = json.toJSONString();

		return json_str;

	}

	/**
	 * @ResponseBody 로 반환값을 CinemaVo 객체로 반환하면 자동으로 json 형태로 반환처리됨 (** 스프링의 특징)
	 * 
	 *               {"c_idx":21,"c_category":"액션","c_subject":"제목","c_info":"내용",
	 *               "c_filename":"1671036698747_align-fingers-71282_640.jpg","c_regdate":"2022-12-15
	 *               01:51:38"} 영화상세보기
	 * @param c_idx
	 * @return
	 */
	@RequestMapping(value = "cinema_view.do")
	@ResponseBody
	public CinemaVo view(int c_idx) throws Exception {
		CinemaVo vo = cinema_dao.selectOne(c_idx);
		return vo;
	}

}
