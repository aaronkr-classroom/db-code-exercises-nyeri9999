-- DROP TABLE
DROP TABLE IF EXISTS 근무하다;
DROP TABLE IF EXISTS 사원;
DROP TABLE IF EXISTS 부서;

-- CREATE TABLE
CREATE TABLE 사원 (
                    사원번호 INT          PRIMARY KEY,
                    이름     VARCHAR(50)  NOT NULL,
                    입사일   DATE         NOT NULL,
                    호봉     INT          NOT NULL DEFAULT 10 CHECK (호봉 BETWEEN 10 AND 30),
                    휴대폰   VARCHAR(20)  NOT NULL UNIQUE
);

CREATE TABLE 부서 (
                    부서번호 INT          PRIMARY KEY,
                    부서명   VARCHAR(100) NOT NULL,
                    부서장   INT,                              -- 초기 INSERT 시 순환참조 문제로 NULL 허용
                    사무실   VARCHAR(100) NOT NULL UNIQUE,
                    전화번호 VARCHAR(20)  NOT NULL,
                    CONSTRAINT fk_부서_부서장 FOREIGN KEY (부서장) REFERENCES 사원(사원번호)
);

CREATE TABLE 근무하다 (
                      사번     INT          NOT NULL,
                      부서번호 INT          NOT NULL,
                      직책     VARCHAR(50)  NOT NULL,
                      PRIMARY KEY (사번, 부서번호),
                      CONSTRAINT fk_근무_사원 FOREIGN KEY (사번)     REFERENCES 사원(사원번호),
                      CONSTRAINT fk_근무_부서 FOREIGN KEY (부서번호) REFERENCES 부서(부서번호)
);


-- INSERT INTO
INSERT INTO 사원 (사원번호, 이름, 입사일, 호봉, 휴대폰) VALUES
                                            (1101, '김정아', '2022-03-01', 20, '010-3452-0022'),
                                            (1102, '이기원', '2022-03-01', 18, '010-1478-1287'),
                                            (1103, '박영중', '2022-09-01', 15, '010-3214-1234'),
                                            (1201, '최강희', '2023-02-01', 21, '010-1122-3344'),
                                            (1202, '조현수', '2023-03-15', 14, '010-5566-4321'),
                                            (1203, '박재성', '2022-09-01', 17, '010-3452-3457'),
                                            (1312, '김민수', '2024-01-15', 10, '010-2340-0023'),
                                            (1314, '이정숙', '2024-02-10', 10, '010-3420-0991');

INSERT INTO 부서 (부서번호, 부서명, 부서장, 사무실, 전화번호) VALUES
                                               (100, '기획실', NULL, 'A402', '02-233-1233'),
                                               (200, '비서실', NULL, 'A501', '02-455-1221'),
                                               (300, '총무부', NULL, 'B311', '041-567-3454'),
                                               (400, '인사부', NULL, 'B201', '041-344-6776'),
                                               (500, '자재부', NULL, 'A102', '02-458-45012');

UPDATE 부서 SET 부서장 = 1101 WHERE 부서번호 = 100;
UPDATE 부서 SET 부서장 = 1102 WHERE 부서번호 = 200;
UPDATE 부서 SET 부서장 = 1201 WHERE 부서번호 = 300;
UPDATE 부서 SET 부서장 = 1203 WHERE 부서번호 = 400;

INSERT INTO 근무하다 (사번, 부서번호, 직책) VALUES
                                    (1101, 100, '부장'),
                                    (1102, 200, '과장'),
                                    (1103, 200, '대리'),
                                    (1201, 300, '부장'),
                                    (1202, 300, '대리'),
                                    (1203, 400, '과장'),
                                    (1312, 100, '사원'),
                                    (1314, 400, '사원')

-- 1. 단순 SELECT
-- 1-1. 전체 테이블 조회
SELECT * FROM 사원;
SELECT * FROM 부서;
SELECT * FROM 근무하다;

-- 1-2. 특정 컬럼만 조회
SELECT 사원번호, 이름, 입사일 FROM 사원;
SELECT 부서번호, 부서명, 사무실 FROM 부서;

-- 1-3. 컬럼 별칭(AS) 사용
SELECT 사원번호  AS "사번",
       이름      AS "성명",
       호봉      AS "현재호봉"
FROM 사원;

-- 1-4. 중복 제거 (DISTINCT)
SELECT DISTINCT 직책 FROM 근무하다;

-- 2. WHERE 조건 필터링
-- 2-1. 단일 조건
SELECT * FROM 사원
WHERE 호봉 >= 18;                               -- 호봉 18 이상

SELECT * FROM 사원
WHERE 입사일 >= '2023-01-01';                   -- 2023년 이후 입사자

SELECT * FROM 부서
WHERE 전화번호 LIKE '02%';                       -- 서울 지역번호 부서

-- 2-2. AND / OR 복합 조건
SELECT * FROM 사원
WHERE 호봉 BETWEEN 15 AND 20                    -- 호봉 15~20
  AND 입사일 >= '2022-01-01';                   -- 2022년 이후 입사

SELECT * FROM 사원
WHERE 이름 = '김정아'
   OR 이름 = '이기원';

-- 2-3. IN / NOT IN
SELECT * FROM 사원
WHERE 사원번호 IN (1101, 1201, 1312);           -- 특정 사원번호 목록

SELECT * FROM 근무하다
WHERE 직책 NOT IN ('부장', '과장');             -- 부장/과장 제외

-- 2-4. NULL 체크
SELECT * FROM 부서
WHERE 부서장 IS NULL;                           -- 부서장 미지정 부서

SELECT * FROM 부서
WHERE 부서장 IS NOT NULL;                       -- 부서장 지정된 부서

-- 2-5. LIKE 패턴 매칭
SELECT * FROM 사원
WHERE 이름 LIKE '김%';                          -- 성이 '김'인 사원

SELECT * FROM 사원
WHERE 휴대폰 LIKE '010-34%';                    -- 특정 번호 패턴

-- 2-6. 정렬 (ORDER BY)
SELECT * FROM 사원
ORDER BY 호봉 DESC;                             -- 호봉 높은 순

SELECT * FROM 사원
ORDER BY 입사일 ASC, 호봉 DESC;                 -- 입사일 오래된 순, 동일 입사일이면 호봉 높은 순

-- 2-7. 결과 개수 제한 (LIMIT)
SELECT * FROM 사원
ORDER BY 호봉 DESC
    LIMIT 3;                                        -- 호봉 상위 3명