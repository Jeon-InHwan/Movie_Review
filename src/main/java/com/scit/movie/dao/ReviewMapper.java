package com.scit.movie.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.scit.movie.vo.ReviewVO;

public interface ReviewMapper {

	// 리뷰 작성 요청
	public int writeReview(ReviewVO review);

	// 리뷰 전체 목록 가져오기
	public ArrayList<ReviewVO> listReviews(Map<String, Object> search, RowBounds rb);

	// review_num을 기준으로, Review 정보 하나 가져오기
	public ReviewVO selectOneReview(int review_num);

	// review 정보를 하나 가져오기 전에, 조회수 1을 상승시키기
	public int updateHitcount(int review_num);

	// review_num을 토대로 review 하나 삭제 요청
	public int deleteReview(ReviewVO review);

	// review 수정 요청
	public int updateReview(ReviewVO review);

	// paging 처리를 하기 위해 전체 review 수를 DB에서 조회해오기
	public int selectTotalCount(Map<String, String> search);

	// review_num을 받아 조인된 테이블로부터 review 정보와 함께 상세 읽기 페이지로 이동
	public HashMap<String, Object> selectJoinedReview(int review_num);

}
