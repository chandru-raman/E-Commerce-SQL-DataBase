CREATE DATABASE e_commerce;

USE e_commerce;

-- Customer Information Table - 1

CREATE TABLE customers(
customer_id INT IDENTITY(100,1) PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
email_id VARCHAR(100) UNIQUE,
phone_no VARCHAR(15) UNIQUE,
address VARCHAR(100),
city VARCHAR(30),
country VARCHAR(30),
created_at DATETIME DEFAULT GETDATE()
);

-- Category Table - 2

CREATE TABLE category(
category_id INT IDENTITY(200,1) PRIMARY KEY,
category_name VARCHAR(100)
);

-- Product Information Table - 3

CREATE TABLE products(
product_id VARCHAR(50) UNIQUE,
name VARCHAR(100),
description VARCHAR(300),
price MONEY,
stock_quantity INT,
category_id INT,
create_at DATETIME DEFAULT GETDATE(),
CONSTRAINT FK1 FOREIGN KEY (category_id)
REFERENCES category(category_id)
);

-- Order Details Table - 4

CREATE TABLE orders(
order_id INT IDENTITY(1,1) PRIMARY KEY,
customer_id INT,
order_date DATE DEFAULT GETDATE(),
total_amount DECIMAL(20,4),
status VARCHAR(20) DEFAULT 'active',
CONSTRAINT FK2 FOREIGN KEY (customer_id)
REFERENCES customers(customer_id),
CONSTRAINT ck1 CHECK (status in('active','non-active'))
);

-- Order Items Table - 5

CREATE TABLE order_items(
order_item_id VARCHAR(50) UNIQUE,
order_id INT,
product_id VARCHAR(50),
quantity INT,
unit_price DECIMAL(20,4),
subtotal DECIMAL(20,4),
CONSTRAINT FK3 FOREIGN KEY (order_id)
REFERENCES orders(order_id),
CONSTRAINT FK4 FOREIGN KEY (product_id)
REFERENCES products(product_id)
);

-- Payment Types Table - 6

CREATE TABLE payments(
payment_id INT IDENTITY(300,1) PRIMARY KEY,
order_id INT,
payment_method VARCHAR(20),
payment_date DATETIME DEFAULT GETDATE(),
amount DECIMAL(20,1),
CONSTRAINT FK5 FOREIGN KEY (order_id)
REFERENCES orders(order_id),
CONSTRAINT ck2 CHECK (payment_method IN ('UPI','CARD','CASH'))
);

-- Audit Log Table - 7

CREATE TABLE audit_log (
audit_id INT IDENTITY(1,1) PRIMARY KEY,
table_name VARCHAR(50),
action_type VARCHAR(20),
action_time DATETIME DEFAULT GETDATE()
);

