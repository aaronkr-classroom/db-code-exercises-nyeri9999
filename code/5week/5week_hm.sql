-- 테이블 생성
CREATE TABLE student (
                         id INT PRIMARY KEY,
                         name TEXT NOT NULL,
                         major TEXT,
                         grade INT CHECK (grade BETWEEN 1 AND 4),
                         birth_date DATE
);

CREATE TABLE course (
                        id INT PRIMARY KEY,
                        title TEXT NOT NULL,
                        professor TEXT,
                        credits INT CHECK (credits > 0),
                        start_date DATE
);
-- 데이터 삽입
INSERT INTO student (id, name, major, grade, birth_date) VALUES
                                                             (1, 'Kim', 'Computer Science', 3, '2001-05-10'),
                                                             (2, 'Lee', 'Mathematics', 2, '2002-08-21'),
                                                             (3, 'Park', 'Physics', 4, '2000-12-01');

INSERT INTO course (id, title, professor, credits, start_date) VALUES
                                                                   (101, 'Database Systems', 'Dr. Choi', 3, '2025-03-01'),
                                                                   (102, 'Algorithms', 'Dr. Kim', 3, '2025-03-02'),
                                                                   (103, 'Linear Algebra', 'Dr. Lee', 2, '2025-03-03');
-- 전체 조회
SELECT * FROM student;
-- 특정 컬럼만 조회
SELECT name, major FROM student;
-- 정렬
SELECT * FROM student ORDER BY grade DESC;
-- 조건 조회
SELECT * FROM student WHERE grade >= 3;
