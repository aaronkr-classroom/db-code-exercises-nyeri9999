-- 강사(강사번호(PK), 이름, 전문분야, 연락처)
-- 강좌(강좌번호(PK), 강좌명, 수강료, 최대인원, 강사번호(FK))
-- 회원(회원번호(PK), 이름, 전화번호, 가입일)
-- 수강신청(회원번호(FK), 강좌번호(FK), 신청일)

-- 간단한 ERD
    -- 강사 -- 1:N -- 강좌 -- N:M -- 회원
    -- 강사 -- 1:N -- 강좌 -- 수강신청 -- N:1 -- 회원


CREATE TABLE instructors (
                             instructor_id INT PRIMARY KEY,
                             name VARCHAR(30),
                             specialty VARCHAR(50),
                             contact VARCHAR(13)
);

CREATE TABLE classes (
                         class_id INT PRIMARY KEY,
                         class_name VARCHAR(50) NOT NULL,
                         fee INT CHECK (fee >= 0),
                         max_students INT CHECK (max_students BETWEEN 5 AND 50),
                         instructor_id INT,
                         FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
);

CREATE TABLE members (
                         member_id INT PRIMARY KEY,
                         name VARCHAR(30) NOT NULL,
                         phone VARCHAR(13),
                         join_date DATE
);

CREATE TABLE registrations (
                               member_id INT,
                               class_id INT,
                               register_date DATE,
                               PRIMARY KEY (member_id, class_id),
                               FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
                               FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE
);

INSERT INTO instructors (instructor_id, name, specialty, contact) VALUES
                                                                      (1, '김영희', '요가', '010-1111-1111'),
                                                                      (2, '박민수', '드로잉', '010-2222-2222'),
                                                                      (3, '이지은', '영어회화', '010-3333-3333');

INSERT INTO members (member_id, name, phone, join_date) VALUES
                                                            (1001, '홍길동', '010-1234-5678', '2026-01-10'),
                                                            (1002, '김철수', '010-2345-6789', '2026-02-15'),
                                                            (1003, '이영희', '010-3456-7890', '2026-03-20');

INSERT INTO classes (class_id, class_name, fee, max_students, instructor_id) VALUES
                                                                                 (101, '아침 요가', 50000, 20, 1),
                                                                                 (102, '수채화 기초', 70000, 15, 2),
                                                                                 (103, '영어 회화', 60000, 10, 3);

INSERT INTO registrations (member_id, class_id, register_date) VALUES
                                                                   (1001, 101, '2026-03-04'),
                                                                   (1001, 103, '2026-03-05'),
                                                                   (1002, 101, '2026-03-05'),
                                                                   (1003, 102, '2026-03-07');

-- join
SELECT m.name, c.class_name
FROM registrations r
         JOIN members m ON r.member_id = m.member_id
         JOIN classes c ON r.class_id = c.class_id;

-- index
-- 10만명 추가.
CREATE TABLE member2 (
                         member_id SERIAL PRIMARY KEY,
                         name VARCHAR(30) NOT NULL,
                         phone VARCHAR(13),
                         join_date DATE
);

INSERT INTO member2 (name, phone, join_date)
SELECT
    'Member_' || g,
    '010-' || LPAD((random() * 9999)::INT::TEXT, 4, '0') || '-' || LPAD((random() * 9999)::INT::TEXT, 4, '0'),
    CURRENT_DATE - ((random() * 1000)::INT)
FROM generate_series(1, 100000) g;

INSERT INTO member2 (name, phone, join_date)
VALUES ('홍길동', '010-1234-5678', current_date);

TABLE members2;

-- 검색시간 확인하기
EXPLAIN ANALYZE
SELECT * FROM members2
WHERE name = '홍길동';
-- Planning Time: 0.053ms
-- Execution Time: 11.843ms

-- INDEX 추가
CREATE INDEX idx_members_name
    ON members2 (name);

-- VIEW 추가
CREATE VIEW registration_view AS
    SELECT
        m.name AS 회원명,
        c.class_name AS 강좌명
        r.register_date AS 신청일
FROM registrations r
JOIN members m on r.member_id = m.member_id
JOIN classes c on r.class_id = r.class_id;

SELECT * FROM registrations_view;