package com.ict.minispring.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ict.minispring.vo.ReviewVo;

@Repository
public class ReviewDaoImpl implements ReviewDao {

	@Autowired
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public List<ReviewVo> selectList() {		
		return sqlSession.selectList("review.review_list");
	}

	@Override
	public ReviewVo selectOne(int r_idx) {
		return sqlSession.selectOne("review.review_one", r_idx);
	}

	
	@Override
	public int update_count(int r_idx) {	
		return sqlSession.update("review.review_count", r_idx);
	}

	@Override
	public int insert(ReviewVo vo) {
		return sqlSession.insert("review.review_insert", vo);
	}

	
	@Override
	public int update(ReviewVo vo) {	
		return sqlSession.update("review.review_update", vo);
	}

	@Override
	public int delete(int r_idx) {
		return sqlSession.delete("review.review_delete", r_idx);
	}

	@Override
	public List<ReviewVo> selectList(Map<String, Object> map) {
		return sqlSession.selectList("review.review_list" ,map);
	}

	
	@Override
	public int selectRowTotal(Map<String, Object> map) {
		return sqlSession.selectOne("review.select_row_total" ,map);
	}

	
	
}
