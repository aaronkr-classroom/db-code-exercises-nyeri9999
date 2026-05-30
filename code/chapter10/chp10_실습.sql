-- ====================
-- 테이블 생성
-- ====================

CREATE TABLE customer_grade_code (
    code VARCHAR(10) PRIMARY KEY,
    grade VARCHAR(10) NOT NULL,  
    criteria VARCHAR(30)         
);

CREATE TABLE customers (
    id INT PRIMARY KEY,  
    name VARCHAR(30) NOT NULL,                
    phone VARCHAR(13),                        
    address VARCHAR(60),                     
    grade_code VARCHAR(10),     
    FOREIGN KEY (grade_code) REFERENCES customer_grade_code(code)
);

CREATE TABLE job_code (
    code VARCHAR(10) PRIMARY KEY,
    job_name VARCHAR(60) NOT NULL
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    birth_date DATE,
    phone VARCHAR(13),
    salary INT,
    job_code VARCHAR(10),
    hire_date DATE,
    FOREIGN KEY (job_code) REFERENCES job_code(code)
);

CREATE TABLE tour_products (
    tour_id INT PRIMARY KEY,     
    departure_location VARCHAR(60),      
    destination_location VARCHAR(60),        
    program TEXT,                            
    start_datetime TIMESTAMP,        
    end_datetime TIMESTAMP,          
    min_people INT,
    max_people INT,
    tour_fee INT,
    deposit INT,
    departure_confirmed BOOLEAN,
    manager_emp_id INT,
    FOREIGN KEY (manager_emp_id) REFERENCES employees(emp_id)
);

-- ====================
-- 데이터 삽입
-- ====================

-- Customer Grade Code
INSERT INTO customer_grade_code (code, grade, criteria) VALUES
('G01', 'Bronze', '누적 이용금액 0원 이상'),
('G02', 'Silver', '누적 이용금액 100만원 이상'),
('G03', 'Gold', '누적 이용금액 300만원 이상'),
('G04', 'VIP', '누적 이용금액 500만원 이상');

-- Customers
INSERT INTO customers (id, name, phone, address, grade_code) VALUES
(1001, '김철수', '010-1111-2222', '서울시 강남구', 'G03'),
(1002, '이현수', '010-2222-3333', '부산시 해운대구', 'G01'),
(1003, '이지혜', '010-3333-4444', '대구시 수성구', 'G02'),
(1004, '손영은', '010-4444-5555', '인천시 연수구', 'G04'),
(1005, '하지연', '010-5555-6666', '서울시 송파구', 'G02');

-- Job Code
INSERT INTO job_code (code, job_name) VALUES
('J01', '상품기획'),
('J02', '영업/마케팅'),
('J03', '고객지원(CS)'),
('J04', '인사총무'),
('J05', 'IT개발');

-- Employees
INSERT INTO employees (emp_id, name, birth_date, phone, salary, job_code, hire_date) VALUES
(2001, '김사원', '1980-05-01', '010-9999-1111', 5000000, 'J01', '2015-03-01'),
(2002, '김대리', '1985-08-15', '010-9999-2222', 4500000, 'J02', '2016-04-10'),
(2003, '김부장', '1988-11-20', '010-9999-3333', 4200000, 'J03', '2018-01-05'),
(2004, '김차장', '1990-02-28', '010-9999-4444', 3800000, 'J04', '2020-07-15'),
(2005, '김사장', '1992-12-12', '010-9999-5555', 3500000, 'J01', '2022-09-01');

-- Tour Products
INSERT INTO tour_products (tour_id, departure_location, destination_location, program, start_datetime, end_datetime, min_people, max_people, tour_fee, deposit, departure_confirmed, manager_emp_id) VALUES
(3001, '서울', '제주', '제주도 2박3일 힐링 투어', '2026-06-01 09:00:00', '2026-06-03 18:00:00', 10, 30, 500000, 50000, true, 2001),
(3002, '부산', '경주', '경주 역사 탐방 1박2일', '2026-06-10 10:00:00', '2026-06-11 17:00:00', 15, 40, 250000, 25000, false, 2005),
(3003, '서울', '강릉', '정동진 일출 무박여행', '2026-06-15 23:00:00', '2026-06-16 12:00:00', 20, 45, 80000, 10000, true, 2001),
(3004, '대구', '여수', '여수 밤바다 당일치기', '2026-06-20 08:00:00', '2026-06-20 22:00:00', 15, 45, 60000, 5000, false, 2005),
(3005, '인천', '부산', '부산 맛집 탐방 2박3일', '2026-07-01 09:00:00', '2026-07-03 19:00:00', 10, 25, 450000, 45000, true, 2001);


-- ====================
-- 조회
-- ====================

-- 전체 확인
TABLE job_code;
TABLE employees;
--JOIN

SELECT e.emp_id, e.name, j.job_name, e.salary
FROM employees AS e
JOIN job_code AS j
    ON e.job_code = j.code;

TABLE customer_grade_code;
TABLE customers;

-- JOIN
SELECT c.id, c.name, c.phone, g.grade, g.criteria
FROM customers c
JOIN customer_grade_code g
    ON c.grade_code = g.code;

-- Tour + Manager JOIN
SELECT t.tour_id, t.destination_location, t.program, e.name AS manager_name
FROM tour_products t
JOIN employees e
    ON t.manager_emp_id = e.emp_id;

-- WHERE JOIN
SELECT t.program, t.tour_fee, e.name
FROM tour_products t
JOIN employees e
ON t.manager_emp_id = e.emp_id
WHERE t.tour_fee >= 400000;

-- ORDER BY
SELECT name, salary
FROM employees
ORDER BY salary DESC;

-- Multiple JOINS
SELECT t.program, t.destination_location, e.name AS manager, j.job_name
FROM tour_products t
JOIN employees e
    ON t.manager_emp_id = e.emp_id
JOIN job_code j
    ON e.job_code = j.code;
