package com.scit.movie.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.scit.movie.vo.ReviewVO;

@Repository
public class ReviewDAO {

	
	@Autowired
	private SqlSession session;
	
	
	
	// 리뷰 작성 요청
	public int writeReview(ReviewVO review) {
		
		int cnt = 0;
		
		try {
			ReviewMapper mapper = session.getMapper(ReviewMapper.class);
			cnt = mapper.writeReview(review);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}



	// 리뷰 전체 목록 가져오기
	public ArrayList<ReviewVO> listReviews(Map<String, Object> search, int startRecord, int countPerPage) {
		
		ArrayList<ReviewVO> list = null;
		
		try {
			ReviewMapper mapper = session.getMapper(ReviewMapper.class);
			RowBounds rb = new RowBounds(startRecord, countPerPage);
			list = mapper.listReviews(search, rb);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
		
	}



	// review_num을 기준으로, Review 정보 하나 가져오기
	public ReviewVO selectOneReview(int review_num) {
		
		ReviewVO searchedReview = null;
		
		try {
			ReviewMapper mapper = session.getMapper(ReviewMapper.class);
			searchedReview = mapper.selectOneReview(review_num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return searchedReview;
	}


	// review 정보를 하나 가져오기 전에, 조회수 1을 상승시키기
	public int updateHitcount(int review_num) {
		
		int cnt = 0;
		
		try {
			ReviewMapper mapper = session.getMapper(ReviewMapper.class);
			cnt = mapper.updateHitcount(review_num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}



	// review_num을 토대로 review 하나 삭제 요청
	public int deleteReview(ReviewVO review) {

		int cnt = 0;
		
		try {
			ReviewMapper mapper = session.getMapper(ReviewMapper.class);
			cnt = mapper.deleteReview(review);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}



	// review 수정 요청
	public int updateReview(ReviewVO review) {

		int cnt = 0;
		
		try {
			ReviewMapper mapper = session.getMapper(ReviewMapper.class);
			cnt = mapper.updateReview(review);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}



	// paging 처리를 하기 위해 전체 review 수를 DB에서 조회해오기
	public int selectTotalCount(Map<String, String> search) {
		
		int result = 0;
		 
		try {
			 ReviewMapper mapper = session.getMapper(ReviewMapper.class);
			 result = mapper.selectTotalCount(search);
			} catch(Exception e) {
			 e.printStackTrace();
		}
			return result;
	}



	// review_num을 받아 조인된 테이블로부터 review 정보와 함께 상세 읽기 페이지로 이동
	public HashMap<String, Object> selectJoinedReview(int review_num) {
		
		HashMap<String, Object> searchedReview = null;
		
		try {
			 ReviewMapper mapper = session.getMapper(ReviewMapper.class);
			 searchedReview = mapper.selectJoinedReview(review_num);
			} catch(Exception e) {
			 e.printStackTrace();
		}
			return searchedReview;
	}
	


	
	
	
	
	

}
