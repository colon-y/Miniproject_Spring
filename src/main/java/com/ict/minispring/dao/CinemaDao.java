package com.ict.minispring.dao;

import java.util.List;

import com.ict.minispring.util.PageMaker;
import com.ict.minispring.vo.CinemaVo;


public interface CinemaDao {

	public List<CinemaVo> selectList(PageMaker pageMaker) throws Exception;
	
	public CinemaVo selectOne(int c_idx) throws Exception;

	public int update(CinemaVo vo) throws Exception;

	public int delete(int c_idx) throws Exception;

	public int insert(CinemaVo vo) throws Exception;

	public int update_filename(CinemaVo vo) throws Exception;

	public int getTotCount() throws Exception;
	
}
