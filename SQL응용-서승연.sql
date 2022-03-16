DROP DATABASE IF EXISTS school_db;
DROP USER IF EXISTS school_db@localhost;
CREATE DATABASE IF NOT EXISTS school_db;
CREATE USER school_db@localhost IDENTIFIED WITH mysql_native_password by 'school_db';
GRANT ALL PRIVILEGES ON school_db.* TO school_db@localhost WITH GRANT OPTION;
SHOW databases;

USE school_db;
SHOW TABLES;

CREATE TABLE 학과(
	학과번호 VARCHAR(15) NOT NULL,
    학과명 VARCHAR(20) NOT NULL UNIQUE,
    학과전화번호 VARCHAR(20) NOT NULL UNIQUE,
    PRIMARY KEY (학과번호)
    );
DESC 학과;

CREATE TABLE 학생(
	학생번호 VARCHAR(15) NOT NULL,
    학생이름 VARCHAR(10) NOT NULL,
    학생주민번호 VARCHAR(20) NOT NULL UNIQUE,
    학생주소 VARCHAR(50) NOT NULL,
    학생전화번호 VARCHAR(20) NOT NULL UNIQUE,
    학생이메일 VARCHAR(45) NOT NULL UNIQUE,
    학과번호 VARCHAR(15) NOT NULL,
    PRIMARY KEY (학생번호),
    FOREIGN KEY(학과번호) REFERENCES 학과(학과번호)
);
DESC 학생;

CREATE TABLE 교수(
	교수번호 VARCHAR(15) NOT NULL,
    교수이름 VARCHAR(10) NOT NULL,
    교수주민번호 VARCHAR(20) NOT NULL UNIQUE,
    교수주소 VARCHAR(50) NOT NULL,
    교수전화번호 VARCHAR(20) NOT NULL UNIQUE,
    교수이메일 VARCHAR(45) NOT NULL UNIQUE,
    학과번호 VARCHAR(15) NOT NULL,
    PRIMARY KEY (교수번호),
    FOREIGN KEY(학과번호) REFERENCES 학과(학과번호)
);
DESC 교수;

CREATE TABLE 강좌(
	강좌번호 VARCHAR(15) NOT NULL,
    교수번호 VARCHAR(15),
    강좌명 VARCHAR(20) NOT NULL UNIQUE,
    취득학점 INT NOT NULL,
    강의시간 VARCHAR(20) NULL,
    강의실정보 VARCHAR(45) NULL,
    PRIMARY KEY (강좌번호,교수번호),
    FOREIGN KEY(교수번호) REFERENCES 교수(교수번호)
  );
DESC 강좌;

CREATE TABLE 수강내역(
	출석점수 INT NULL,
    중간고사점수 INT NULL,
    기말고사점수 INT NULL,
    기타점수 INT NULL,
    총점 INT NOT NULL,
    평점 VARCHAR(20) NOT NULL,
    학생번호 VARCHAR(15) NOT NULL,
    강좌번호 VARCHAR(15) NOT NULL,
    교수번호 VARCHAR(15) NOT NULL,
    PRIMARY KEY (학생번호,강좌번호,교수번호),
    FOREIGN KEY(학생번호) REFERENCES 학생(학생번호),
    FOREIGN KEY(강좌번호) REFERENCES 강좌(강좌번호),
    FOREIGN KEY(교수번호) REFERENCES 강좌(교수번호)
);
DESC 수강내역;

CREATE TABLE IF NOT EXISTS 교수와학생(
	학생번호 VARCHAR(15) NOT NULL,
    교수번호 VARCHAR(15) NOT NULL,
    현재학년학기 VARCHAR(45) NOT NULL,
    PRIMARY KEY (학생번호),
    FOREIGN KEY(학생번호) REFERENCES 학생(학생번호),
    FOREIGN KEY(교수번호) REFERENCES 교수(교수번호)
    );
DESC 교수와학생;
SHOW TABLES;
    
INSERT INTO 학과 VALUES('1001','건축학과','02-541-1001');
INSERT INTO 학과 VALUES('2002','물리학과','02-542-2002');
INSERT INTO 학과 VALUES('3003','컴퓨터학과','02-543-3003');
INSERT INTO 학과 VALUES('4004','영문학과','02-544-4004');
INSERT INTO 학과 VALUES('5005','중국어학과','02-555-5005');
SELECT * FROM 학과;

INSERT INTO 학생 VALUES('10123','홍길동','930512-120505','경기도 부천시 부천동','010-8905-1234','hong9305@naver.com','1001');
INSERT INTO 학생 VALUES('20234','이몽룡','980421-220404','인천시 부평구 부평2동','010-7804-2345','lee9804@naver.com','2002');
INSERT INTO 학생 VALUES('30345','성춘향','900801-130808','서울시 마포구 상수동','010-6805-3456','seong9008@naver.com','3003');
INSERT INTO 학생 VALUES('40456','임학도','991215-241212','인천시 계양구 병방동 ','010-8812-4567','im9912@naver.com','4004');
INSERT INTO 학생 VALUES('50678','임꺽정','971123-151111','경기도 김포시 장기동','010-7911-5678','im9711@naver.com','5005');
INSERT INTO 학생 VALUES('60789','박문수','950711-160707','경기도 부천시 신월동','010-9507-7898','park9507@naver.com','1001');
INSERT INTO 학생 VALUES('70890','이순신','960221-270202','인천시 부평구 부평6동 ','010-9602-2720','lee9602@naver.com','2002');
INSERT INTO 학생 VALUES('80901','최영','910301-180303','서울시 강남구 대치동','010-9103-1858','cho9103@naver.com','3003');
INSERT INTO 학생 VALUES('90012','안중근','921015-291010','서울시 서초구 양재동','010-9210-2578','an9210@naver.com','4004');
SELECT * FROM 학생;

INSERT INTO 교수 VALUES('12345','김교수','890511-1234567','경기도 김포시 사우동','010-8905-1234','kim12345@naver.com','1001');
INSERT INTO 교수 VALUES('23456','강교수','780421-2345678','인천시 부평구 갈산동','010-7804-2345','gang23456@naver.com','2002');
INSERT INTO 교수 VALUES('34567','이교수','680501-1345678','서울시 강남시 압구정동','010-6805-3456','lee34567@naver.com','3003');
INSERT INTO 교수 VALUES('45678','박교수','881215-2456789','서울시 마포구 아현동','010-8812-4567','park45678@naver.com','4004');
INSERT INTO 교수 VALUES('56789','최교수','791123-1567890','경기도 부천시 원미동','010-7911-5678','cho56789@naver.com','5005');
SELECT * FROM 교수;

INSERT INTO 강좌 VALUES('1212','12345','건축의이해',3,'매주 수요일','건축학과 101동');
INSERT INTO 강좌 VALUES('2323','23456','물리의이해',4,'매주 목요일','물리학과 205동');
INSERT INTO 강좌 VALUES('3434','34567','컴퓨터응용',4,null,'컴퓨터학과 303동');
INSERT INTO 강좌 VALUES('6767','45678','영어독해',2,'매주 월요일','영문학과 401동');
INSERT INTO 강좌 VALUES('7878','56789','중국어회화',3,'매주 월요일','중국어학과 502동');
SELECT * FROM 강좌;

INSERT INTO 수강내역 VALUES(10,10,8,5,33,'출석우수','10123','1212','12345');
INSERT INTO 수강내역 VALUES(2,5,5,2,14,'출석미흡','20234','2323','23456');
INSERT INTO 수강내역 VALUES(10,10,10,10,40,'성적우수','30345','6767','45678');
INSERT INTO 수강내역 VALUES(5,5,4,3,17,'불성실','40456','6767','45678');
INSERT INTO 수강내역 VALUES(10,10,5,8,33,'열심함','50678','7878','56789');
SELECT * FROM 수강내역;

INSERT INTO 교수와학생 VALUES('10123','12345','2학년2학기');
INSERT INTO 교수와학생 VALUES('20234','12345','1학년1학기');
INSERT INTO 교수와학생 VALUES('30345','23456','1학년 2학기');
INSERT INTO 교수와학생 VALUES('40456','34567','2학년 1학기');
INSERT INTO 교수와학생 VALUES('50678','45678','2학년1학기');
INSERT INTO 교수와학생 VALUES('60789','56789','2학년2학기');
INSERT INTO 교수와학생 VALUES('70890','23456','4학년1학기');
INSERT INTO 교수와학생 VALUES('80901','34567','4학년1학기');
INSERT INTO 교수와학생 VALUES('90012','56789','3학년1학기');
SELECT * FROM 교수와학생;

-- 4번 수강하지않은 학생 명단
SELECT 학생.학생번호 AS 학번, 학생.학생이름 AS 성명 FROM 학생 WHERE  학생번호 NOT IN (SELECT 학생번호 FROM 수강내역) ;

-- 5번 교수별 담당학생 명단
SELECT 교수와학생.교수번호 AS 교번, 교수.교수이름 AS 교수자명, 교수와학생.학생번호 AS 학번, 학생.학생이름 AS 학생명 FROM 교수와학생 JOIN 교수 ON 교수와학생.교수번호=교수.교수번호  JOIN 학생 ON 교수와학생.학생번호=학생.학생번호 ORDER BY 교수.교수이름 ASC;

-- 6번 컴퓨터학과 자료변경
SELECT * FROM 학과 ORDER BY 학과명 ASC;
SET FOREIGN_KEY_CHECKS = 0;
UPDATE 학과 SET 학과번호='0111', 학과명='컴퓨터공학과' WHERE 학과명='컴퓨터학과';
SET FOREIGN_KEY_CHECKS = 1;
SELECT * FROM 학과 ORDER BY 학과명 ASC;

-- 7번 교수관련자료삭제
SELECT * FROM 교수와학생 ORDER BY 교수번호 ASC;
DELETE  FROM 교수와학생 WHERE 교수번호 = (SELECT 강좌.교수번호 FROM 강좌 WHERE 강좌.강의시간 IS NULL);
SELECT * FROM 교수와학생 ORDER BY 교수번호 ASC;

SELECT * FROM 교수;
SET FOREIGN_KEY_CHECKS = 0;
DELETE  FROM 교수 WHERE 교수번호 = (SELECT 강좌.교수번호 FROM 강좌 WHERE 강좌.강의시간 IS NULL);
SET FOREIGN_KEY_CHECKS = 1;
SELECT * FROM 교수;

SELECT * FROM 강좌;
DELETE FROM 강좌 WHERE 강좌.강의시간 IS NULL;
SELECT * FROM 강좌;
