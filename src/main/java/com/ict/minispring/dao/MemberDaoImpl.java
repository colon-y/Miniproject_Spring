package com.ict.minispring.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.minispring.vo.MemberVo;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private SqlSession sqlSession;

	
	@Override
	public List<MemberVo> selectList() throws Exception{
		System.out.println(" member.member_list 가져오기 ");
		return sqlSession.selectList("member.member_list");
	}

	@Override
	public MemberVo selectOne(int m_idx)  throws Exception{
		return sqlSession.selectOne("member.member_one_m_idx", m_idx);
	}
	
	@Override
	public MemberVo selectOne(String m_id) throws Exception {
		return sqlSession.selectOne("member.member_one_m_id", m_id);
	}

	@Override
	public int delete(int m_idx)  throws Exception{
		return sqlSession.delete("member.member_delete", m_idx);
	}
	
	@Override
	public int deleteHide(int m_idx) throws Exception {
		return sqlSession.update("member.delete_hide", m_idx);
	}
	

	@Override
	public int update(MemberVo vo) throws Exception {
		return sqlSession.update("member.member_update", vo);
	}

	@Override
	public int insert(MemberVo vo) {
		return sqlSession.insert("member.member_insert", vo);
	}

	@Override
	public MemberVo checkId(String m_id) {
		return sqlSession.selectOne("member.check_id", m_id);
	}


	@Override
	public MemberVo checkNickname(String m_nickname) {
		return sqlSession.selectOne("member.check_nickname", m_nickname);
	}


	
	
	
}
