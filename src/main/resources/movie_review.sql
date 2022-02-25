-- 리뷰 테이블
CREATE TABLE movie_review(
	review_num NUMBER PRIMARY KEY
	, review_title VARCHAR2(200) NOT NULL
	, review_text VARCHAR2(4000) NOT NULL
	, review_hitcount NUMBER DEFAULT 0
	, review_indate DATE DEFAULT SYSDATE
	, user_id CONSTRAINT movie_review_fk REFERENCES movie_member(user_id)
	, review_originalfile VARCHAR2(300)
	, review_savedfile VARCHAR2(300)
);


-- 리뷰 테이블에 사용될 시퀀스
CREATE SEQUENCE REVIEW_NUM_SEQ;