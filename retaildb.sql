CREATE DATABASE retail_db;
USE retail_db;
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2),
    cost DECIMAL(10,2)
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(10),
    city VARCHAR(50)
);

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    customer_id INT,
    sale_date DATE,
    quantity INT,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Products (name, category, price, cost) VALUES
('Laptop', 'Electronics', 55000, 45000),
('Smartphone', 'Electronics', 25000, 18000),
('Headphones', 'Accessories', 2000, 1200),
('Shoes', 'Fashion', 3000, 2000),
('Watch', 'Fashion', 4000, 2500),
('Cycle','Sports',12000,8000),
('Cricket kit', 'Sports', 7000, 5000),
('Toys', 'Kids', 500, 200),
('Face wash', 'Personal care', 960, 350),
('Dressing table', 'Furniture', 11000, 7000);

INSERT INTO Customers (name, age, gender, city) VALUES
('Preetham', 28, 'M', 'Bengaluru'),
('Sneha', 34, 'F', 'Mumbai'),
('Arjun', 23, 'M', 'Delhi'),
('Priya', 41, 'F', 'Chennai'),
('Deepak', 30, 'M', 'Bengaluru'),
('Anita', 27, 'F', 'Pune'),
('Suresh', 50, 'M', 'Kochi'),
('Meera', 19, 'F', 'Chennai'),
('Vikram', 36, 'M', 'Mumbai'),
('Neha', 45, 'F', 'Delhi');

INSERT INTO Sales (product_id, customer_id, quantity, sale_date) VALUES
(1, 1, 1, '2025-09-01'),
(2, 2, 2, '2025-09-02'),
(3, 3, 3, '2025-09-03'),
(4, 4, 1, '2025-09-04'),
(5, 5, 2, '2025-09-05'),
(1, 6, 1, '2025-09-06'),
(2, 7, 1, '2025-09-07'),
(3, 8, 2, '2025-09-08'),
(4, 9, 1, '2025-09-09'),
(5, 10, 1, '2025-09-10'); 

-- Best-selling product
SELECT p.name, SUM(s.quantity) AS total_sold
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sold DESC
LIMIT 1;

-- Total sales per product category
SELECT p.category, SUM(s.total_amount) AS total_sales
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.category;

-- Average purchase per customer
SELECT c.name, AVG(s.total_amount) AS avg_purchase
FROM Sales s
JOIN Customers c ON s.customer_id = c.customer_id
GROUP BY c.name;

-- Daily sales trend
SELECT s.sale_date, SUM(s.total_amount) AS daily_sales
FROM Sales s
GROUP BY s.sale_date
ORDER BY s.sale_date;

SET SQL_SAFE_UPDATES = 0;

UPDATE Sales s
JOIN Products p ON s.product_id = p.product_id
SET s.total_amount = p.price * s.quantity;
