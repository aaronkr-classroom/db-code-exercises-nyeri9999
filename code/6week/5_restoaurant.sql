-- Customer 테이블
CREATE TABLE Customer (
                          customer_id INT PRIMARY KEY,
                          name VARCHAR(100),
                          phone VARCHAR(13) UNIQUE,
                          address VARCHAR(100)
);

-- Restaurant 테이블
CREATE TABLE Restaurant (
                            restaurant_id INT PRIMARY KEY,
                            name VARCHAR(100),
                            phone VARCHAR(23),
                            address VARCHAR(100)
);

-- Order 테이블
CREATE TABLE Orders (
                        order_id INT PRIMARY KEY,
                        date TIMESTAMP,
                        total NUMERIC,

                        customer_id INT,
                        restaurant_id INT,

                        FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
                        FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id)
);

-- Order 테이블
CREATE TABLE Delivery (
                          delivery_id INT PRIMARY KEY,
                          driver_name VARCHAR(100),
                          status INT,

                          order_id INT,
                          FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Customer
VALUES
    (1, '앨리스', '010-1111-2222', '충청북도 충주시'),
    (2, '김수민', '010-3333-4444', '충청북도 청주시');

INSERT INTO Restaurant
VALUES
    (1, '김밥천국', '02-123-4567', '서울시 마포구'),
    (2, '피자플레이스', '063-518-5233', '전라북도 전주시');

INSERT INTO Orders (order_id, customer_id, restaurant_id, date, total)
VALUES
    (1,1,1,'2026-04-13 15:17:00', 24000),
    (2,2,2,'2026-04-13 15:17:00', 24000);

INSERT INTO Delivery (delivery_id, driver_name, status, order_id)
VALUES
    -- 0: 받았다, 1:조리하다, 2:배달중, 3:배달완료, 4: 취소
    (25000, 1, 1, 1),
    (18000, 2, 3,2);

-- 조회 쿼리
SELECT *
FROM Orders;

SELECT *
FROM Orders
ORDER BY total DESC; -- ASC

SELECT *
FROM Orders
WHERE total >= 5000;

SELECT *
FROM Delivery
WHERE status = 3;
