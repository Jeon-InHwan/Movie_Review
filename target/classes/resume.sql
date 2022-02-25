-- 회원 정보 테이블
CREATE TABLE test_user(
    user_id VARCHAR2(30) PRIMARY KEY,
    user_pw VARCHAR2(30) NOT NULL,
    user_nm VARCHAR2(30) NOT NULL
);

-- 이력서 테이블
CREATE TABLE test_resume(
    resume_no NUMBER PRIMARY KEY,
    user_id CONSTRAINT resume_fk REFERENCES test_user(user_id) NOT NULL,
    resume_title VARCHAR2(300) NOT NULL, 
    resume_location char(1) NOT NULL,
    resume_position char(1) NOT NULL,
    resume_pr VARCHAR2(3000) NOT NULL,
    resume_indate DATE DEFAULT SYSDATE
);

-- 이력서 번호를 위한 시퀀스 객체
CREATE SEQUENCE test_resume_seq;