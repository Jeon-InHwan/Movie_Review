package com.scit.movie.vo;

import lombok.Data;

@Data
public class ReviewVO {

	private int review_num;
	private String review_title;
	private String review_text;
	private int review_hitcount;
	private String review_indate;
	private String user_id;
	private String review_originalfile;
	private String review_savedfile;
	private int manager;
	
}
