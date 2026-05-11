-- ====== CREATE TABLE
CREATE TABLE users (
                       user_id    INT          PRIMARY KEY,
                       user_name  VARCHAR(50)  NOT NULL,
                       nickname   VARCHAR(50)  NOT NULL UNIQUE,
                       user_level INT          NOT NULL DEFAULT 1 CHECK (user_level >= 1),
                       join_date  DATE         NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE game (
                      game_id      INT          PRIMARY KEY,
                      game_name    VARCHAR(100) NOT NULL,
                      genre        VARCHAR(50)  NOT NULL,
                      release_date DATE         NOT NULL
);

CREATE TABLE item (
                      item_id    INT          PRIMARY KEY,
                      item_name  VARCHAR(100) NOT NULL,
                      item_price INT          NOT NULL CHECK (item_price >= 0),
                      item_grade VARCHAR(20)  NOT NULL
);

CREATE TABLE play (
                      user_id    INT  NOT NULL,
                      game_id    INT  NOT NULL,
                      start_date DATE NOT NULL DEFAULT CURRENT_DATE,
                      play_time  INT  NOT NULL DEFAULT 0 CHECK (play_time >= 0),
                      PRIMARY KEY (user_id, game_id),
                      CONSTRAINT fk_play_user FOREIGN KEY (user_id) REFERENCES users(user_id),
                      CONSTRAINT fk_play_game FOREIGN KEY (game_id) REFERENCES game(game_id)
);

CREATE TABLE user_item (
                           user_id       INT  NOT NULL,
                           item_id       INT  NOT NULL,
                           acquired_date DATE NOT NULL DEFAULT CURRENT_DATE,
                           quantity      INT  NOT NULL DEFAULT 1 CHECK (quantity >= 1),
                           PRIMARY KEY (user_id, item_id),
                           CONSTRAINT fk_useritem_user FOREIGN KEY (user_id) REFERENCES users(user_id),
                           CONSTRAINT fk_useritem_item FOREIGN KEY (item_id) REFERENCES item(item_id)
);


-- ====== INSERT INTO
INSERT INTO users (user_id, user_name, nickname, user_level, join_date) VALUES
                                                                            (1, '김철수', 'ironman_kim',  30, '2022-03-15'),
                                                                            (2, '이영희', 'elf_queen',    25, '2022-07-01'),
                                                                            (3, '박민준', 'shadow_park',  50, '2021-11-20'),
                                                                            (4, '최수연', 'crystal_choi', 10, '2024-01-05'),
                                                                            (5, '정다은', 'storm_jung',   42, '2023-05-18');

INSERT INTO game (game_id, game_name, genre, release_date) VALUES
                                                               (1, '드래곤 퀘스트',    'RPG',     '2020-06-01'),
                                                               (2, '배틀그라운드',     'SHOOTER', '2019-03-22'),
                                                               (3, '리그 오브 레전드', 'MOBA',    '2018-11-15'),
                                                               (4, '마인크래프트',     'SANDBOX', '2021-09-30');

INSERT INTO item (item_id, item_name, item_price, item_grade) VALUES
                                                                  (1, '불꽃 검',     5000, '영웅'),
                                                                  (2, '생명의 포션',  500, '일반'),
                                                                  (3, '어둠의 갑옷', 8000, '전설'),
                                                                  (4, '바람의 부츠', 3000, '희귀'),
                                                                  (5, '치유의 반지', 1500, '일반');

INSERT INTO play (user_id, game_id, start_date, play_time) VALUES
                                                               (1, 1, '2022-04-01', 1200),
                                                               (1, 2, '2022-05-10',  800),
                                                               (2, 1, '2022-08-01',  600),
                                                               (2, 3, '2022-09-15', 2400),
                                                               (3, 1, '2022-01-01', 5000),
                                                               (3, 3, '2022-03-01', 3000),
                                                               (4, 4, '2024-02-01',  300),
                                                               (5, 2, '2023-06-01', 1500);

INSERT INTO user_item (user_id, item_id, acquired_date, quantity) VALUES
                                                                      (1, 1, '2022-04-15',  1),
                                                                      (1, 2, '2022-05-01',  5),
                                                                      (2, 3, '2022-09-20',  1),
                                                                      (2, 4, '2022-10-01',  2),
                                                                      (3, 1, '2022-02-01',  1),
                                                                      (3, 3, '2022-03-15',  1),
                                                                      (3, 5, '2022-04-01',  3),
                                                                      (4, 2, '2024-02-10', 10),
                                                                      (5, 4, '2023-07-01',  1);


-- ====== SELECT 조회
-- 전체 유저 조회
SELECT * FROM users;

-- 레벨 높은 순서 조회
SELECT * FROM users
ORDER BY user_level DESC;

-- 레벨 10 이상 유저 조회
SELECT * FROM users
WHERE user_level >= 10;

-- S등급 유저 조회
SELECT * FROM users
WHERE user_grade = 'S';

-- ====== ALTER TABLE
-- 게임 회사에서 유저의 이메일도 저장하기로 했다.
ALTER TABLE users
    ADD COLUMN email VARCHAR(100) UNIQUE;

-- 유저에게 현재 접속 상태를 저장해야 한다.
ALTER TABLE users
    ADD COLUMN is_online BOOLEAN NOT NULL DEFAULT FALSE;

-- 게임 테이블에 게임 등급 정보를 추가해야 한다.
ALTER TABLE users
    ADD COLUMN user_grade VARCHAR(10) NOT NULL DEFAULT 'D'
        CHECK (user_grade IN ('S', 'A', 'B', 'C', 'D'));

-- 아이템 테이블의 판매 가능 여부를 추가해야 한다.
ALTER TABLE item
    ADD COLUMN is_sellable BOOLEAN NOT NULL DEFAULT TRUE;

-- 게임 등급 정보 추가
ALTER TABLE game
    ADD COLUMN game_grade VARCHAR(10) NOT NULL DEFAULT '전체이용가'
        CHECK (game_grade IN ('전체이용가', '12세이용가', '15세이용가', '청소년이용불가'));

-- ====== ALTER 후 데이터 UPDATE
-- 박민준 유저의 이메일 추가.
UPDATE users
SET email = 'minjun@email.com'
WHERE user_name = '박민준';

-- 최수연 유저의 레벨이 25로 올랐다.
UPDATE users
SET user_level = 25
WHERE user_name = '최수연';

-- 모든 유저의 기본 접속 상태를 온라인으로 변경.
UPDATE users
SET is_online = TRUE;

-- ironman_kim 유저가 현재 접속중으로 변경.
UPDATE users
SET is_online = TRUE
WHERE nickname = 'ironman_kim';

-- 생명의 포션 가격을 700으로 변경.
UPDATE item
SET item_price = 700
WHERE item_name = '생명의 포션';

-- 배틀그라운드 가능 연령을 15세이용가로 설정한다.
UPDATE game
SET game_grade = '15세이용가'
WHERE game_name = '배틀그라운드';

-- delete는 데이터를 삭제한다.
-- drop table은 테이블을 삭제한다.
-- alter table은 테이블 구조 변경한다.
-- update는 기존 데이터를 수정한다.