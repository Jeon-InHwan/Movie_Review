package com.scit.movie.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.scit.movie.dao.MemberDAO;
import com.scit.movie.vo.MemberVO;

@Service
public class MemberService {

	@Autowired
	private MemberDAO dao;
	
	@Autowired
	private HttpSession session;
	
	
	// DB까지 도달하는 회원가입 요쳥  (ID 중복 확인 포함)
	public String join(MemberVO member) {
		
		String path = "";
		
		MemberVO searchedMember = dao.selectMember(member.getUser_id());
		
		if(searchedMember != null) {
			return "redirect:/member/joinForm";
		}
		
		int cnt = dao.join(member);
		
		if(cnt < 1) {
			path = "redirect:/member/joinForm";
		} else {
			path = "redirect:/";
		}
		
		return path;
	}


	
	// 로그인 요청
	public String login(MemberVO member) {
		
		String path = "";
		
		MemberVO searchedMember = dao.selectMember(member.getUser_id());
		
		
		
		// 사용자가 입력한 id를 토대로, 데이터베이스에서 일치하는 데이터를 가져오지 못한 경우
		if(searchedMember == null) {
			System.out.println("ID가 틀린 상황");
			path = "redirect:/";
		} else {
			
			// 이미 탈퇴 신청이 완료된 회원인 경우
			if(searchedMember.getManager() == 3) {
				System.out.println("이미 탈퇴한 회원");
				path = "redirect:/";
				return path;
			}
			
			// 사용자가 입력한 비밀번호와 조회한 데이터의 비밀번호가 같은지 확인
			if(member.getUser_pwd().equals(searchedMember.getUser_pwd())){
				// 일치하는 경우이므로, 로그인 처리를 해주어야 함 => 세션 스코프에 로그인 정보 저장
				session.setAttribute("loginId", searchedMember.getUser_id());
				session.setAttribute("loginNm", searchedMember.getUser_nm());
				session.setAttribute("manager", searchedMember.getManager());
				path = "redirect:/member/afterLogin";
			} else {
				// 비밀번호만 틀린 상황 (ID는 바르게 입력한 상황)
				System.out.println("PW가 틀린 상황");
				path = "redirect:/";
				}
			}
		
			return path;
	}


	// 로그아웃 요청 처리
	public void logout() {
		
		// 세션 스코프에 저장되어 있는 로그인 정보 삭제
		session.removeAttribute("loginId");
		session.removeAttribute("loginNm");
		session.removeAttribute("manager");
		
	}


	// 회원정보 수정 요청을 위한 회원 조회
	public MemberVO forMemberUpdate() {
		
		String user_id = (String)session.getAttribute("loginId");
		
		MemberVO searchedMember = dao.selectMember(user_id);
		
		return searchedMember;
	}



	// 회원정보 수정 요청
	public String updateMember(MemberVO member) {

		String path = "";
		
		String user_id = (String)session.getAttribute("loginId");
		
		member.setUser_id(user_id);
		
		int cnt = dao.updateMember(member);
		
		if(cnt < 1) {
			path = "redirect:/member/updateMemberForm";
		} else {
			session.removeAttribute("loginId");
			session.removeAttribute("loginNm");
			session.removeAttribute("manager");
			path = "redirect:/";
		}
		
		return path;
	}



	// 회원탈퇴 요청
	public String withdrawalMembeer(MemberVO member) {
		
		String path = "";
		int cnt = 0;
		
		String user_id = (String)session.getAttribute("loginId");

		MemberVO searchedMember = dao.selectMember(user_id);
		
		if(member.getUser_id().equals(searchedMember.getUser_id())) {
			if (member.getUser_pwd().equals(searchedMember.getUser_pwd())) {
				cnt = dao.deleteMember(searchedMember.getUser_id());
			}
		} else {
			path = "redirect:/member/withdrawalMemberForm";
		}
		
		if(cnt < 1) {
			path = "redirect:/member/withdrawalMemberForm";
		} else {
			session.removeAttribute("loginId");
			session.removeAttribute("loginNm");
			session.removeAttribute("manager");
			path = "redirect:/";
		}
		
		return path;
	}



	// Member 목록 요청 by 관리자
	public ArrayList<MemberVO> listMembers(String searchItem, String searchWord, String searchStatus, int startRecord, int countPerPage) {
		
		Map<String, Object> search = new HashMap<String, Object>();
		search.put("searchItem", searchItem);
		search.put("searchStatus", searchStatus);
		search.put("searchWord", searchWord);
		
		ArrayList<MemberVO> list = dao.listMembers(search, startRecord, countPerPage);
		
		return list;
		
	}


	// paging 처리를 하기 위해 전체 회원 수를 DB에서 조회해오기
	public int selectTotalCount(String searchItem, String searchStatus, String searchWord) {
		
		Map<String, String> search = new HashMap<String, String>();
		search.put("searchItem", searchItem);
		search.put("searchStatus", searchStatus);
		search.put("searchWord", searchWord);
		
		int result = 0;
		
		result = dao.selectTotalCount(search);
		
		return result;
		
		
	}


	// 관리자에 의한 회원 비활성화
	public String deactivateUser(String user_id) {
		
		String path = "";
		int cnt = 0;
		
		cnt = dao.deactivateUser(user_id);
		
		if(cnt < 1) {
			path = "redirect:/manager/listMembers";
		} else {
			path = "redirect:/manager/listMembers";
		}
		
		return path;
		
	}


	// 관리자에 의한 회원 활성화
	public String activateUser(String user_id) {
		
		String path = "";
		int cnt = 0;
		
		cnt = dao.activateUser(user_id);
		
		if(cnt < 1) {
			path = "redirect:/manager/listMembers";
		} else {
			path = "redirect:/manager/listMembers";
		}
		
		return path;
		
	}


	// 로그인 처리 후 메인 홈페이지로 이동할 때 들고갈 데이터
	public MemberVO selectOneMember() {
		
		String user_id = (String)session.getAttribute("loginId");
		MemberVO searchedMember = dao.selectMember(user_id);
		
		return searchedMember;
		
	}

	
	
	
}
