package com.scit.movie.dao;

import java.util.ArrayList;
import java.util.Map;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scit.movie.vo.MemberVO;

@Repository
public class MemberDAO {

	@Autowired
	private SqlSession session;
	
	
	// DB까지 도달하는 회원가입 요쳥
	public int join(MemberVO member) {
		
		int cnt = 0;
		
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			cnt = mapper.join(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}


	// ID 중복체크, 로그인 요청을 처리하기 위한 회원 조회
	public MemberVO selectMember(String user_id) {
		
		MemberVO searchedMember = null;
		
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			searchedMember = mapper.selectMember(user_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return searchedMember;
	}


	// 회원정보 수정 요청
	public int updateMember(MemberVO member) {

		int cnt = 0;
		
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			cnt = mapper.updateMember(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}


	// 회원탈퇴 요청
	public int deleteMember(String user_id) {

		int cnt = 0;
		
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			cnt = mapper.deleteMember(user_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}


	// Member 목록 요청 by 관리자
	public ArrayList<MemberVO> listMembers(Map<String, Object> search, int startRecord, int countPerPage) {
		
		ArrayList<MemberVO> list = null;
		
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			RowBounds rb = new RowBounds(startRecord, countPerPage);
			list = mapper.listMembers(search, rb);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}


	// paging 처리를 하기 위해 전체 회원 수를 DB에서 조회해오기
	public int selectTotalCount(Map<String, String> search) {
		
		int result = 0;
		 
		try {
			 MemberMapper mapper = session.getMapper(MemberMapper.class);
			 result = mapper.selectTotalCount(search);
			} catch(Exception e) {
			 e.printStackTrace();
		}
			return result;
	}


	// 관리자에 의한 회원 비활성화
	public int deactivateUser(String user_id) {
		
		int result = 0;
		 
		try {
			 MemberMapper mapper = session.getMapper(MemberMapper.class);
			 result = mapper.deactivateUser(user_id);
			} catch(Exception e) {
			 e.printStackTrace();
		}
			return result;
	}


	// 관리자에 의한 회원 활성화
	public int activateUser(String user_id) {
		
		int result = 0;
		 
		try {
			 MemberMapper mapper = session.getMapper(MemberMapper.class);
			 result = mapper.activateUser(user_id);
			} catch(Exception e) {
			 e.printStackTrace();
		}
			return result;
	}
	
	
	

}
