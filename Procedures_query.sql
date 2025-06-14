-- Adds a new customer to the customers table
CREATE PROCEDURE add_customer
@first_name VARCHAR(50),
@last_name VARCHAR(50),
@email_id VARCHAR(100),
@phone_no VARCHAR(15),
@address VARCHAR(100),
@city VARCHAR(30),
@country VARCHAR(30)
AS
BEGIN
INSERT INTO customers (first_name,last_name,email_id,phone_no,address,city,country)
VALUES (@first_name,@last_name,@email_id,@phone_no,@address,@city,@country);
END;

-- Adds a new category
CREATE PROCEDURE add_category
@category_name VARCHAR(100)
AS
BEGIN
INSERT INTO category (category_name)
VALUES (@category_name);
END;

-- Adds a new product to the product list
CREATE PROCEDURE add_product
@product_id VARCHAR(50),
@name VARCHAR(100),
@description VARCHAR(300),
@price MONEY,
@stock_quantity INT,
@category_id INT
AS
BEGIN
INSERT INTO products (product_id,name,description,price,stock_quantity,category_id)
VALUES (@product_id,@name,@description,@price,@stock_quantity,@category_id);
END;

-- Places a new order for a customer
CREATE PROCEDURE add_order
@customer_id INT,
@total_amount DECIMAL(20,4)
AS
BEGIN
INSERT INTO orders (customer_id,total_amount)
VALUES (@customer_id,@total_amount);
END;

-- Adds an item to an order
CREATE PROCEDURE add_order_item
@order_item_id VARCHAR(50),
@order_id INT,
@product_id VARCHAR(50),
@quantity INT,
@unit_price DECIMAL(20,4)
AS
BEGIN
DECLARE @subtotal DECIMAL(20,4)=@quantity*@unit_price;
INSERT INTO order_items (order_item_id,order_id,product_id,quantity,unit_price,subtotal)
VALUES (@order_item_id,@order_id,@product_id,@quantity,@unit_price,@subtotal);
END;

-- Adds payment details for an order
CREATE PROCEDURE add_payment
@order_id INT,
@payment_method VARCHAR(20),
@amount DECIMAL(20,1)
AS
BEGIN
INSERT INTO payments (order_id,payment_method,amount)
VALUES (@order_id,@payment_method,@amount);
END;

-- Fetches full details of a customer by ID
CREATE PROCEDURE get_customer
@customer_id INT
AS
BEGIN
SELECT * FROM customers WHERE customer_id=@customer_id;
END;

-- Fetches full product details by product ID
CREATE PROCEDURE get_product
@product_id VARCHAR(50)
AS
BEGIN
SELECT * FROM products WHERE product_id=@product_id;
END;

-- Lists all orders placed by a customer
CREATE PROCEDURE get_customer_orders
@customer_id INT
AS
BEGIN
SELECT * FROM orders WHERE customer_id=@customer_id;
END;

-- Lists payment details for a specific order
CREATE PROCEDURE get_order_payments
@order_id INT
AS
BEGIN
SELECT * FROM payments WHERE order_id=@order_id;
END;

-- Lists all products under a given category
CREATE PROCEDURE list_products_by_category
@category_id INT
AS
BEGIN
SELECT * FROM products WHERE category_id=@category_id;
END;

-- Lists all active orders
CREATE PROCEDURE list_active_orders
AS
BEGIN
SELECT * FROM orders WHERE status='active';
END;

-- Shows order items with product names for a given order
CREATE PROCEDURE get_order_details
@order_id INT
AS
BEGIN
SELECT oi.*,p.name,p.price
FROM order_items oi
JOIN products p ON oi.product_id=p.product_id
WHERE oi.order_id=@order_id;
END;

-- Shows invoice-style summary for a given order
CREATE PROCEDURE get_order_invoice
@order_id INT
AS
BEGIN
SELECT o.order_id,o.order_date,c.first_name+' '+c.last_name AS customer_name,
p.name AS product_name,oi.quantity,oi.unit_price,oi.subtotal
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
JOIN order_items oi ON o.order_id=oi.order_id
JOIN products p ON oi.product_id=p.product_id
WHERE o.order_id=@order_id;
END;

-- Shows how many orders and total amount a customer has spent
CREATE PROCEDURE get_customer_summary
@customer_id INT
AS
BEGIN
SELECT COUNT(order_id) AS total_orders,SUM(total_amount) AS total_spent
FROM orders
WHERE customer_id=@customer_id;
END;

-- Lists all products with their category name
CREATE PROCEDURE list_products_with_category
AS
BEGIN
SELECT p.product_id,p.name,c.category_name,p.price,p.stock_quantity
FROM products p
JOIN category c ON p.category_id=c.category_id;
END;

-- Shows top N selling products by quantity sold
CREATE PROCEDURE top_selling_products
@top_n INT
AS
BEGIN
SELECT TOP(@top_n) p.name,SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id=p.product_id
GROUP BY p.name
ORDER BY total_sold DESC;
END;

-- Shows total sales made on a specific date
CREATE PROCEDURE get_sales_by_date
@order_date DATE
AS
BEGIN
SELECT SUM(total_amount) AS total_sales
FROM orders
WHERE order_date=@order_date;
END;

-- Updates price and stock for a product
CREATE PROCEDURE update_product
@product_id VARCHAR(50),
@price MONEY,
@stock_quantity INT
AS
BEGIN
UPDATE products
SET price=@price,stock_quantity=@stock_quantity
WHERE product_id=@product_id;
END;

-- Deletes a product from the catalog
CREATE PROCEDURE delete_product
@product_id VARCHAR(50)
AS
BEGIN
DELETE FROM products WHERE product_id=@product_id;
END;
