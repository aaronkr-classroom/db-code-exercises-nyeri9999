-- =============================================
-- CHECK 제약조건 테스트
-- =============================================

-- 1. 유저 레벨은 1 ~ 100만 가능
ALTER TABLE users
    ADD CONSTRAINT chk_user_level
        CHECK (user_level >= 1 AND user_level <= 100);

UPDATE users SET user_level = 100 WHERE user_id = 1; -- 성공
UPDATE users SET user_level = 101 WHERE user_id = 1; -- 실패 (CHECK 위반)

-- 2. 접속 상태는 online, connecting, offline만 가능
ALTER TABLE users
    ADD CONSTRAINT chk_user_status
        CHECK (status IN ('online', 'connecting', 'offline'));

UPDATE users SET status = 'sleeping' WHERE user_id = 2; -- 실패 (CHECK 위반)

-- 3. 아이템 가격은 0원 이상
ALTER TABLE items
    ADD CONSTRAINT chk_item_price
        CHECK (price >= 0);

UPDATE items SET price = -10 WHERE item_id = 1001; -- 실패 (CHECK 위반)

-- 4. 아이템 등급은 S, A, B, C, D, E, F만 가능
ALTER TABLE items
    ADD CONSTRAINT chk_item_grade
        CHECK (grade IN ('S', 'A', 'B', 'C', 'D', 'E', 'F'));

UPDATE items SET grade = 'Z' WHERE item_id = 1001; -- 실패 (CHECK 위반)

-- 5. 닉네임은 중복되면 안된다.
ALTER TABLE users
    ADD CONSTRAINT uq_user_nickname
        UNIQUE (nickname);

INSERT INTO users VALUES (6, '홍길동', 'DragonKing', 10, '2026-05-18', 'home@home.com', 'offline'); -- 실패 (CHECK 위반: 닉네임 중복)

-- =============================================
-- FK 제약조건 확인
-- =============================================
SELECT constraint_name, table_name
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_TYPE = 'FOREIGN KEY'
  AND TABLE_NAME IN ('plays', 'user_items');  -- 두 테이블 한번에 확인

-- =============================================
-- 기존 FK 제약조건 전체 삭제
-- =============================================
ALTER TABLE plays      DROP CONSTRAINT plays_user_id_fkey;
ALTER TABLE plays      DROP CONSTRAINT plays_game_id_fkey;
ALTER TABLE user_items DROP CONSTRAINT user_items_user_id_fkey;
ALTER TABLE user_items DROP CONSTRAINT user_items_item_id_fkey;


-- =============================================
-- 새 FK 제약조건 추가
-- =============================================

-- 1. 유저 삭제 시 플레이 기록도 삭제
ALTER TABLE plays
    ADD CONSTRAINT fk_plays_users
        FOREIGN KEY (user_id)
            REFERENCES users(user_id)
            ON DELETE CASCADE;

-- 2. 게임은 플레이 기록이 있으면 삭제 불가
ALTER TABLE plays
    ADD CONSTRAINT fk_plays_games
        FOREIGN KEY (game_id)
            REFERENCES games(game_id)
            ON DELETE RESTRICT;

-- 3. 유저 삭제 시 보유 아이템 목록도 삭제
ALTER TABLE user_items
    ADD CONSTRAINT fk_user_items_users
        FOREIGN KEY (user_id)
            REFERENCES users(user_id)
            ON DELETE CASCADE;

-- 4. 아이템 보유 중이면 삭제 불가
ALTER TABLE user_items
    ADD CONSTRAINT fk_user_items_items
        FOREIGN KEY (item_id)
            REFERENCES items(item_id)
            ON DELETE RESTRICT;

-- =============================================
-- CASCADE 테스트 (유저 삭제 시 연관 데이터 함께 삭제)
-- =============================================

-- 삭제 전 데이터 확인
SELECT * FROM plays      WHERE user_id = 1;
SELECT * FROM user_items WHERE user_id = 1;

-- 유저 삭제 (plays, user_items 데이터도 함께 삭제됨)
DELETE FROM users WHERE user_id = 1;

-- 삭제 후 확인 (결과 없으면 CASCADE 정상 동작)
SELECT * FROM plays      WHERE user_id = 1;
SELECT * FROM user_items WHERE user_id = 1;


-- =============================================
-- RESTRICT 테스트 (연관 데이터 있으면 삭제 불가)
-- =============================================

-- 현재 게임/아이템 데이터 확인
SELECT * FROM games;
SELECT * FROM items;

-- 게임 삭제 시도 (plays에 기록 있으면 오류 발생해야 정상)
DELETE FROM games WHERE game_id = 101;

-- 아이템 삭제 시도 (user_items에 보유자 있으면 오류 발생해야 정상)
DELETE FROM items WHERE item_id = 1004;