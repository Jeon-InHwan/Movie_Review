package com.scit.movie.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import com.scit.movie.vo.MemberVO;

public interface MemberMapper {

	
	// DB까지 도달하는 회원가입 요쳥
	public int join(MemberVO member);

	// ID 중복체크, 로그인 요청을 처리하기 위한 회원 조회
	public MemberVO selectMember(String user_id);

	// 회원정보 수정 요청
	public int updateMember(MemberVO member);

	// 회원탈퇴 요청
	public int deleteMember(String user_id);
	
	// paging 처리를 하기 위해 전체 회원 수를 DB에서 조회해오기
	public int selectTotalCount(Map<String, String> search);

	// Member 목록 요청 by 관리자
	public ArrayList<MemberVO> listMembers(Map<String, Object> search, RowBounds rb);

	// 관리자에 의한 회원 비활성화
	public int deactivateUser(String user_id);

	// 관리자에 의한 회원 활성화
	public int activateUser(String user_id);
	
	
}
