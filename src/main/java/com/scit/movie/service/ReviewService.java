package com.scit.movie.service;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import com.scit.movie.dao.ReviewDAO;
import com.scit.movie.util.FileService;
import com.scit.movie.vo.ReviewVO;

@Service
public class ReviewService {

	
	@Autowired
	private ReviewDAO dao;
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private HttpServletResponse response;
	
	private static final String UPLOAD_PATH = "/MovieUploadFiles";
	
	
	// 리뷰 작성 요청
	public String writeReview(ReviewVO review, MultipartFile upload) {
	
		
		// upload라는 이름의 첨부파일이 있을 경우 파일 저장 실행
		if(!upload.isEmpty() ) {
			
			String original = upload.getOriginalFilename();
			String saved = FileService.saveFile(upload, UPLOAD_PATH);
			
			review.setReview_originalfile(original);
			review.setReview_savedfile(saved);
		}
		
		String path = "";
		
		String user_id = (String)session.getAttribute("loginId");
		review.setUser_id(user_id);
		
		int cnt = dao.writeReview(review);
		
		if(cnt < 1) {
			path = "redirect:/review/writeReviewForm";
		} else {
			path = "redirect:/review/listReviews";
		}
		
		return path;
	}


	// 리뷰 전체 목록 가져오기
	public ArrayList<ReviewVO> listReviews(String searchItem, String searchWord, int startRecord, int countPerPage) {
		
		Map<String, Object> search = new HashMap<String, Object>();
		search.put("searchItem", searchItem);
		search.put("searchWord", searchWord);
		
		ArrayList<ReviewVO> list = null;
		
		list = dao.listReviews(search, startRecord, countPerPage);
		
		return list;
	}


	
	// review_num을 기준으로, Review 정보 하나 가져오기
	public ReviewVO selectOneReview(int review_num) {
		
		// review 정보를 하나 가져오기 전에, 조회수 1을 상승시키기
		dao.updateHitcount(review_num);
		
		ReviewVO searchedReview = dao.selectOneReview(review_num);
		
		return searchedReview;
		
	}


	// review_num을 토대로 review 하나 삭제 요청
	public String deleteReview(int review_num) {
		
		String path = "";
		
		ReviewVO review = new ReviewVO();
		
		String user_id = (String)session.getAttribute("loginId");
		int manager = (int)session.getAttribute("manager");
		
		review.setUser_id(user_id);
		review.setReview_num(review_num);
		review.setManager(manager);
		
		ReviewVO searchedReview = dao.selectOneReview(review_num);
		
		String savedName = searchedReview.getReview_savedfile();
		String fullPath = UPLOAD_PATH + "/" + savedName;
		
		int cnt = dao.deleteReview(review);
		
		
		if(cnt  < 1) {
			path = "redirect:/review/readReview?review_num=" + review_num;
		} else {
			
			// 첨부파일이 있을 때만 삭제한다!
			if(savedName != null) {
				boolean check = FileService.deleteFile(fullPath);
				
				if(check) {
					System.out.println("첨부파일 삭제 성공");
				} else {
					System.out.println("첨부파일 삭제 실패");
				}
			}
			
			path = "redirect:/review/listReviews";
		}
		
		return path;
	}


	// review_num을 기준으로, Review 정보 하나 가져오기 (Update 용)
	public ReviewVO selectOneReviewForUpdate(int review_num) {
		
		ReviewVO searchedReview = dao.selectOneReview(review_num);
		
		return searchedReview;
	}


	// review 수정 요청
	public String updateReview(ReviewVO review, MultipartFile upload) {
		
		String path = "";
		
		String user_id = (String)session.getAttribute("loginId");
		int manager = (int)session.getAttribute("manager");
		
		review.setUser_id(user_id);
		review.setManager(manager);
		
		ReviewVO searchedReview = dao.selectOneReview(review.getReview_num());
		String savedFile = searchedReview.getReview_savedfile();
		
		// 수정하면서 파일 업로드를 요청한 경우
		if(!upload.isEmpty()) {
			
			// 1) 기존 글에 첨부파일이 있는 경우
			if(savedFile != null) {
				// 기존 파일 삭제
				FileService.deleteFile(UPLOAD_PATH + "/" + savedFile);
			}
			
			// 신규 첨부파일 업로드
			String originalFileName = upload.getOriginalFilename();
			
			// 파일서버에 실제 데이터 저장
			String savedFileName = FileService.saveFile(upload, UPLOAD_PATH);
			
			// DB에 보낼 BoardVO에 첨부파일 값 setting
			review.setReview_originalfile(originalFileName);
			review.setReview_savedfile(savedFileName);
			
		}
		
		int cnt = dao.updateReview(review);
		
		if(cnt  < 1) {
			path = "redirect:/review/updateReviewForm?review_num="+ review.getReview_num();
		} else {
			path = "redirect:/review/listReviews";
		}
		
		return path;
		
	}


	// paging 처리를 하기 위해 전체 review 수를 DB에서 조회해오기
	public int selectTotalCount(String searchItem, String searchWord) {
		
		Map<String, String> search = new HashMap<String, String>();
		search.put("searchItem", searchItem);
		search.put("searchWord", searchWord);
		
		int result = 0;
		result = dao.selectTotalCount(search);
		
		return result;
	}


	// Review 첨부파일 다운로드 요청
	public void download(int review_num) {
		
		ReviewVO searchedReview = dao.selectOneReview(review_num);
		
		// 원본 파일명
		String originalFile = searchedReview.getReview_originalfile();
		try {
			// Response에 파일을 첨부하여 전송할 것이며, 그 파일을 지정된 파일명으로 다운로드하도록 설정
			response.setHeader("Content-Disposition", " attachment;filename="+ URLEncoder.encode(originalFile, "UTF-8").replaceAll("\\+", "%20"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		// 파일이 저장되어 있는 실제 경로와 파일 이름
		String fullPath = UPLOAD_PATH + "/" + searchedReview.getReview_savedfile();
		
		
		// 전송을 위한 통로 개설
		FileInputStream filein = null;
		ServletOutputStream fileout = null;
		
		try {
			filein = new FileInputStream(fullPath);
			fileout = response.getOutputStream();
			
			//Spring의 파일 관련 유틸
			FileCopyUtils.copy(filein, fileout);
			
			// 전송 통로 닫기
			filein.close();
			fileout.close();
			
		} catch (IOException e) {
			e.printStackTrace();
			}
		
		}

	
	// review_num을 받아 조인된 테이블로부터 review 정보와 함께 상세 읽기 페이지로 이동
	public HashMap<String, Object> selectJoinedReview(int review_num) {
		
		// review 정보를 하나 가져오기 전에, 조회수 1을 상승시키기
		dao.updateHitcount(review_num);
		
		HashMap<String, Object> searchedReview = dao.selectJoinedReview(review_num);
		
		return searchedReview;
	}
	
}
	
	
	

