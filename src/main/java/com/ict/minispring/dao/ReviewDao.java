package com.ict.minispring.dao;

import java.util.List;
import java.util.Map;

import com.ict.minispring.vo.ReviewVo;

public interface ReviewDao {

	public List<ReviewVo> selectList();

	public ReviewVo selectOne(int r_idx);

	public int update_count(int r_idx);

	public int insert(ReviewVo vo);

	public int update(ReviewVo vo);

	public int delete(int r_idx);

	public List<ReviewVo> selectList(Map<String, Object> map);

	public int selectRowTotal(Map<String, Object> map);

}
