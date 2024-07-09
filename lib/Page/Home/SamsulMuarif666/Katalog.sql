CREATE TABLE katalog (
    id INT AUTO_INCREMENT PRIMARY KEY,
    imageUrl VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    store VARCHAR(100) NOT NULL,
    sold INT NOT NULL,
    description TEXT
);
