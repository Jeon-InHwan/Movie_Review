package com.scit.movie.vo;

import lombok.Data;

@Data
public class MemberVO {

	private String user_id;
	private String user_pwd;
	private String user_nm;
	private String regdate;
	private int photo;
	private int manager;
	
}
