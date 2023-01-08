package com.ict.minispring.dao;

import java.util.List;

import com.ict.minispring.vo.MemberVo;

public interface MemberDao {

	public MemberVo selectOne(int m_idx) throws Exception;
	
	public MemberVo selectOne(String m_id) throws Exception;

	public List<MemberVo> selectList() throws Exception;

	public int delete(int m_idx) throws Exception;
	
	public int deleteHide(int m_idx) throws Exception;

	public int update(MemberVo vo) throws Exception;

	public int insert(MemberVo vo) throws Exception;
	
	public MemberVo checkId(String m_id);

	public MemberVo checkNickname(String m_nickname);

	
}
