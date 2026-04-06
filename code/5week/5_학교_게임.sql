-- User
CREATE TABLE UsersAccount (
                              user_id INT PRIMARY KEY,
                              email VARCHAR(100),
                              password VARCHAR(100),
                              created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Character (예약어 이슈 때문에 바꿈)
CREATE TABLE GameCharacter (
                               character_id INT PRIMARY KEY,
                               name VARCHAR(100),
                               level INT,
                               class_type VARCHAR(50),
                               user_id INT,

                               FOREIGN KEY (user_id) REFERENCES UsersAccount(user_id)
);

-- Item
CREATE TABLE Item (
                      item_id INT PRIMARY KEY,
                      name VARCHAR(50),
                      type VARCHAR(50)
);

-- Inventory (M:N 해결)
CREATE TABLE Inventory (
                           character_id INT,
                           item_id INT,
                           quantity INT DEFAULT 1,

                           PRIMARY KEY (character_id, item_id),

                           FOREIGN KEY (character_id) REFERENCES GameCharacter(character_id),
                           FOREIGN KEY (item_id) REFERENCES Item(item_id)
);