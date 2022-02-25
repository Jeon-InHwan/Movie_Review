package com.scit.movie.controllers;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import com.scit.movie.service.ReviewService;
import com.scit.movie.util.PageNavigator;
import com.scit.movie.vo.ReviewVO;

@Controller
public class ReviewController {
	
	
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	@Autowired
	private ReviewService service;
	
	private final int countPerPage = 10;
	private final int pagePerGroup = 5;
	
	
	// 리뷰 작성 Form 요청
	@RequestMapping(value = "/review/writeReviewForm", method = RequestMethod.GET)
	public String writeReviewForm() {
		return "review/writeReviewForm";
	}
	

	// 리뷰 작성 요청
	@RequestMapping(value = "/review/writeReview", method = RequestMethod.POST)
	public String writeReview(ReviewVO review, MultipartFile upload) {

		return service.writeReview(review, upload);
	}
	
	
	// 리뷰 목록을 출력하는 페이지로 이동 요청 (리뷰 전체 목록 가져오기)
	@RequestMapping(value = "/review/listReviews", method = RequestMethod.GET)
	public String listReviews(Model model, 
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(value = "searchItem", defaultValue = "review_title") String searchItem,
			@RequestParam(value = "searchWord", defaultValue = "") String searchWord) {
		
		
		// paging 처리를 하기 위해 전체 review 수를 DB에서 조회해오기 (검색한 경우도 고려해야함)
		int totalCount = service.selectTotalCount(searchItem, searchWord);
		
		// paging 처리를 위한 객체 생성
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, totalCount);
		
		ArrayList<ReviewVO> list = service.listReviews(searchItem, searchWord, navi.getStartRecord(), navi.getCountPerPage());
		
		model.addAttribute("list", list);
		model.addAttribute("navi", navi);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("searchItem", searchItem);
		
		return "review/listReviews";
	
	}
	
	
	// review_num을 받아 조인된 테이블로부터 review 정보와 함께 상세 읽기 페이지로 이동
	@RequestMapping(value = "/review/readReview", method = RequestMethod.GET)
	public String readReview(int review_num, Model model) {
		
		HashMap<String, Object> searchedReview = service.selectJoinedReview(review_num);
		
		logger.info("granted HashMap : {}", searchedReview);
		
		model.addAttribute("review", searchedReview);
		
		return "review/readReview";
	}
	
	
	// review_num을 토대로 review 하나 삭제 요청
	@RequestMapping(value = "/review/deleteReview", method = RequestMethod.GET)
	public String deleteReview(int review_num) {
		return service.deleteReview(review_num);
	}


	// review 수정 Form 요청
	@RequestMapping(value = "/review/updateReviewForm", method = RequestMethod.GET)
	public String updateReviewForm(int review_num, Model model) {
		ReviewVO searchedReview = service.selectOneReviewForUpdate(review_num);
		model.addAttribute("review", searchedReview);
		return "review/updateReviewForm";
	}
	
	
	// review 수정 요청
	@RequestMapping(value = "/review/updateReview", method = RequestMethod.POST)
	public String updateReview(ReviewVO review, MultipartFile upload) {
		logger.info("granted ReviewVO for updateReview : {}", review);
		return service.updateReview(review, upload);
	}
	
	
	// Review 첨부파일 다운로드 요청
	@RequestMapping(value="/review/download", method = RequestMethod.GET)
	public String download(int review_num) {
		
		service.download(review_num);
		
		return null;
	}
}


