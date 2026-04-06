-- Student
CREATE TABLE Student (
                         student_id INT PRIMARY KEY,   -- 학번
                         name VARCHAR(50),
                         major VARCHAR(50)
);

-- Professor
CREATE TABLE Professor (
                           employee_id INT PRIMARY KEY,  -- 사번
                           student_id INT,               -- (FK) 지도 학생 (선택적 관계)
                           name VARCHAR(50),
                           department VARCHAR(50),

                           FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

-- Course / Section
CREATE TABLE Course (
                        course_id INT,
                        section_id INT,
                        name VARCHAR(100),

                        PRIMARY KEY (course_id, section_id)  -- 복합키
);

-- Enrollment
CREATE TABLE Enrollment (
                            student_id INT,
                            course_id INT,
                            section_id INT,
                            grade VARCHAR(2),
                            enrolled_at DATE,

                            PRIMARY KEY (student_id, course_id, section_id),

                            FOREIGN KEY (student_id) REFERENCES Student(student_id),
                            FOREIGN KEY (course_id, section_id) REFERENCES Course(course_id, section_id)
);