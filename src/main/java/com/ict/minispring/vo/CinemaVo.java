package com.ict.minispring.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CinemaVo {

	private int c_idx;
	private String c_category;
	private String c_subject;
	private String c_info;
	private String c_filename;
	private int review_cnt;
	private String c_regdate;	
	
}
