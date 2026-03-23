/*
Entity / 객체
    professor

properties / 속성
    id(bigserial)
    name(varchar(30))
    dept(varchar(50))
    salary(numeric)
    salary_level(numeric)
    hire_date(date)
 */

-- 엔티티 생성하기
CREATE TABLE professor(
                        id bigserial,
                        name varchar(30),
                        dept varchar(50),
                        salary numeric,
                        salary_level numeric,
                        hire_date date
);

-- 데이터 삽입하기
INSERT INTO professor (name, dept, salary, salary_level, hire_date)
VALUES
    ('김정운', '컴퓨터공학', 100000, 2, '1998-12-31'),
    ('박지선', '정보통신공학과', 110000, 2, '2001-03-01'),
    ('노지선', '간호학과', 90000, 2, '2003-05-23'),
    ('김대준', '컴퓨터공학과', 70000, 2, '2011-11-19'),
    ('김정숙', '소프트웨어학과', 1000000, 2, '2004-06-11');

-- 데이터 검색하기
select * from professor;

-- 조회(조건 달아서)
SELECT name, salary FROM professor;
SELECT name, salary FROM professor ORDER BY salary DESC; -- asc(오름차순)
SELECT name, salary FROM professor WHERE salary > 9000;
SELECT name, salary FROM professor WHERE name LIKE '김%'; -- postsql에서 ILIKE 대/소문자 상관없음 --
SELECT name, salary FROM professor WHERE dept LIKE '%공%' ORDER BY dept ASC;
SELECT name, salary FROM professor WHERE salary BETWEEN 70001 AND 89999;

