-- 회원 테이블

CREATE TABLE movie_member(
	user_id VARCHAR2(50) PRIMARY KEY
	, user_pwd VARCHAR2(50) NOT NULL
	, user_nm VARCHAR2(50) NOT NULL
	, regdate DATE DEFAULT SYSDATE
	, photo NUMBER DEFAULT 1
	, manager NUMBER DEFAULT 0
);