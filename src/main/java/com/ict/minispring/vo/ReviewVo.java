package com.ict.minispring.vo;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class ReviewVo {
	
	private int r_idx;
	private int r_score;
	private int r_count;
	private int m_idx;
	private int c_idx;
	private String r_subject;
	private String r_content;
	private String r_regdate;
	private String m_nickname;	
	private String m_ip;
	private String c_subject;
	private String c_category;

	
}
