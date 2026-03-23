/* 엔티티 생성(주제: 동아리 관리)
   ** cascade랑 on delete는 편의상 그냥 함.
   club (동아리)
    - club_id(PK, SERIAL)
    - name(VARCHAR)
    - description(TEXT)
    - created_at(DATE)
   ------
   member (회원)
    - member_id(PK, SERIAL)
    - name(VARCHAR),
    - email(VARCHAR),
    - join_date(DATE)
   -------
   club_member (동아리에 속한 회원)
    - id(PK)
    - club_id(FK)
    - member_id(FK)
    - role(동아리 직위, VARCHAR)
*/

-- 엔티티 생성 코드 --
CREATE TABLE club (
                      club_id SERIAL PRIMARY KEY,
                      name VARCHAR(100) NOT NULL,
                      description TEXT,
                      created_at DATE DEFAULT CURRENT_DATE
);

CREATE TABLE member (
                        member_id SERIAL PRIMARY KEY,
                        name VARCHAR(50) NOT NULL,
                        email VARCHAR(100) UNIQUE,
                        join_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE club_member (
                             id SERIAL PRIMARY KEY,
                             club_id INT NOT NULL,
                             member_id INT NOT NULL,
                             role VARCHAR(20),
                             CONSTRAINT fk_club
                                 FOREIGN KEY (club_id)
                                     REFERENCES club(club_id)
                                     ON DELETE CASCADE,
                             CONSTRAINT fk_member
                                 FOREIGN KEY (member_id)
                                     REFERENCES member(member_id)
                                     ON DELETE CASCADE,
                             CONSTRAINT uq_club_member UNIQUE (club_id, member_id)
);

-- 각 엔티티에 데이터 삽입 코드 --
INSERT INTO club (name, description) VALUES
                                         ('축구 동아리', '축구를 좋아하는 모임'),
                                         ('독서 동아리', '책 읽는 모임');

INSERT INTO member (name, email) VALUES
                                     ('김철수', 'chulsoo@test.com'),
                                     ('이영희', 'younghee@test.com'),
                                     ('박민수', 'minsoo@test.com'),
                                     ('최지은', 'jieun@test.com'),
                                     ('홍길동', 'gildong@test.com');

INSERT INTO club_member (club_id, member_id, role) VALUES
                                                       (1, 1, '회장'),
                                                       (1, 2, '부원'),
                                                       (1, 3, '부원'),
                                                       (2, 4, '회장'),
                                                       (2, 5, '부원');
-- 조회 쿼리--
-- 1. 전체 조회(all select)
SELECT c.name AS club_name, m.name AS member_name, cm.role
FROM club_member cm
         JOIN Club c ON cm.club_id = c.club_id
         JOIN Member m ON cm.member_id = m.member_id;
-- 2. 정렬(order by)
SELECT m.name, m.join_date
FROM Member m
ORDER BY m.join_date DESC;
-- 3. 조건(where)
SELECT m.name, c.name AS club_name
FROM club_member cm
         JOIN Member m ON cm.member_id = m.member_id
         JOIN Club c ON cm.club_id = c.club_id
WHERE c.name = '축구 동아리';

