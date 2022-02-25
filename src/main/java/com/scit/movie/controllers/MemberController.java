package com.scit.movie.controllers;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.scit.movie.service.MemberService;
import com.scit.movie.util.PageNavigator;
import com.scit.movie.vo.MemberVO;

@Controller
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService service;
	
	private final int countPerPage = 10;
	private final int pagePerGroup = 5;

	
	// 회원가입 Form으로 이동하는 요청
	@RequestMapping(value = "/member/joinForm", method = RequestMethod.GET)
	public String joinForm() {
		return "member/joinForm";
	}
	
	
	// DB까지 도달하는 회원가입 요청  (ID 중복 확인 포함)
	@RequestMapping(value = "/member/join", method = RequestMethod.POST)
	public String join(MemberVO member) {
		
		logger.info("granted MemberVO for join : {}", member);
		
		return service.join(member);
		
	}
	
	
	// 로그인 요청
	@RequestMapping(value = "/member/login", method = RequestMethod.POST)
	public String login(MemberVO member) {
		return service.login(member);
	}
	
	
	// 로그인 처리 후 메인 홈페이지로 이동
	@RequestMapping(value = "/member/afterLogin", method = RequestMethod.GET)
	public String afterLogin(Model model) {
		
		MemberVO member = service.selectOneMember();
		model.addAttribute("member", member);
		return "member/afterLogin";
	}

	
	
	// 로그아웃 요청 처리
	@RequestMapping(value = "/member/logout", method = RequestMethod.GET)
	public String logout() {
		
		service.logout();
		
		return "redirect:/";
	}
	
	
	// 회원정보 수정 Form 요청
	@RequestMapping(value = "/member/updateMemberForm", method = RequestMethod.GET)
	public String updateMemberForm(Model model) {
		
		MemberVO searchedMember = service.forMemberUpdate();
		
		model.addAttribute("member", searchedMember);
		
		return "member/updateMemberForm";
	}
	
	
	// 회원정보 수정 요청
	@RequestMapping(value = "/member/updateMember", method = RequestMethod.POST)
	public String updateMember(MemberVO member) {
		logger.info("granted MemberVo for updateMember : {}", member);
		return service.updateMember(member);
	}
	
	
	// 회원탈퇴 폼 요청
	@RequestMapping(value = "/member/withdrawalMemberForm", method = RequestMethod.GET)
	public String withdrawalMemberForm() {
		return "member/withdrawalMemberForm";
	}
	
	
	// 회원탈퇴 요청
	@RequestMapping(value = "/member/withdrawalMember", method = RequestMethod.POST)
	public String  withdrawalMember(MemberVO member) {
		logger.info("granted MemberVO for deleteMember : {}", member);
		return service.withdrawalMembeer(member);
	}
	
	
	// Member 목록 요청 by 관리자
	@RequestMapping(value = "/manager/listMembers", method = RequestMethod.GET)
	public String MemberList(Model model,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(value = "searchItem", defaultValue = "user_id") String searchItem,
			@RequestParam(value = "searchStatus", defaultValue = "all") String searchStatus,
			@RequestParam(value = "searchWord", defaultValue = "") String searchWord) {
		
		// paging 처리를 하기 위해 전체 회원 수를 DB에서 조회해오기 (검색한 경우도 고려해야함)
		int totalCount = service.selectTotalCount(searchItem, searchStatus, searchWord);
		
		logger.info("granted selectTotalCount : {}", totalCount);
		
		// paging 처리를 위한 객체 생성
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, totalCount);
			
		ArrayList<MemberVO> list = service.listMembers(searchItem, searchWord, searchStatus, navi.getStartRecord(), navi.getCountPerPage());
		
		model.addAttribute("list", list);
		model.addAttribute("navi", navi);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("searchStatus", searchStatus);
		model.addAttribute("searchItem", searchItem);
		
		
		return "manager/listMembers";
	}
	
	
	// 관리자에 의한 회원 비활성화
	@RequestMapping(value = "/manager/deactivateUser", method = RequestMethod.GET)
	public String deactivateUser(String user_id) {
		
		return service.deactivateUser(user_id);
	}
	
	
	// 관리자에 의한 회원 활성화
	@RequestMapping(value = "/manager/activateUser", method = RequestMethod.GET)
	public String activateUser(String user_id) {
		
		return service.activateUser(user_id);
	}
	
	
	
}
