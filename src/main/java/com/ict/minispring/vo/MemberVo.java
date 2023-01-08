package com.ict.minispring.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class MemberVo {

	private int m_idx;
	private String m_name;
	private String m_id;
	private String m_pwd;
	private String m_nickname;
	private String m_grade;
	private String m_ip;
	private String m_regdate;
	private String m_zipcode;
	private String m_addr;
	private String m_delete;
		
}
