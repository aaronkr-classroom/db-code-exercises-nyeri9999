-- SQL 작성 --
-- 1. 테이블 생성
-- 유저
CREATE TABLE users (
                       user_id SERIAL PRIMARY KEY,
                       username VARCHAR(30) NOT NULL,
                       email VARCHAR(50) UNIQUE NOT NULL,
                       join_date DATE DEFAULT CURRENT_DATE
);
-- 게임 프로필
CREATE TABLE game_profile (
                              profile_id SERIAL PRIMARY KEY,
                              user_id INT UNIQUE NOT NULL,
                              level INT DEFAULT 1,
                              gold INT DEFAULT 0,
                              play_time INT DEFAULT 0,
                              rank_tier VARCHAR(20),
                              CONSTRAINT fk_user
                                  FOREIGN KEY (user_id)
                                      REFERENCES users(user_id)
                                      ON DELETE CASCADE
);
-- 2. 데이터 삽입
-- 유저
INSERT INTO users (username, email)
VALUES
    ('궁존야띵', 'player1@test.com'),
    ('환각라이즈', 'player2@test.com'),
    ('왜이렇게빨리끝나나요', 'player1557@test.com');
-- 게임 프로필
INSERT INTO game_profile (user_id, level, gold, play_time, rank_tier)
VALUES
    (1, 15, 3000, 120, 'Silver'),
    (2, 25, 6000, 160, 'Gold'),
    (3, 35, 9000, 200, 'Platinum');
-- 엔티티별 조회 쿼리
-- 엔티티별 각각 전체 조회
SELECT * FROM users;
SELECT * FROM game_profile;
-- 레벨 20 이상 유저 조회
SELECT * FROM game_profile WHERE level >= 20;
-- 게임머니 순으로 정렬(desc)
SELECT * FROM game_profile ORDER BY gold DESC;
