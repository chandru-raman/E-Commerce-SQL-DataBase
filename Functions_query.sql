CREATE FUNCTION get_full_name(@cust_id INT)
RETURNS VARCHAR(100)
AS
BEGIN
DECLARE @full_name VARCHAR(100)
SELECT @full_name=first_name+' '+last_name FROM customers WHERE customer_id=@cust_id
RETURN @full_name
END;
GO

SELECT customer_id,email_id,dbo.get_full_name(customer_id) AS full_name FROM customers;

CREATE FUNCTION get_total_order_amount(@order_id INT)
RETURNS DECIMAL(20,2)
AS
BEGIN
DECLARE @total DECIMAL(20,2)
SELECT @total=SUM(subtotal) FROM order_items WHERE order_id=@order_id
RETURN @total
END;
GO

SELECT order_id,dbo.get_total_order_amount(order_id) AS total_amount FROM orders;

CREATE FUNCTION get_stock_status(@pid VARCHAR(50))
RETURNS VARCHAR(20)
AS
BEGIN
DECLARE @status VARCHAR(20)
SELECT @status=CASE WHEN stock_quantity=0 THEN 'Out of Stock' WHEN stock_quantity<10 THEN 'Low Stock' ELSE 'In Stock' END FROM products WHERE product_id=@pid
RETURN @status
END;
GO

SELECT product_id,name,dbo.get_stock_status(product_id) AS stock_status FROM products;

CREATE FUNCTION get_discounted_price(@price MONEY,@discount_percent INT)
RETURNS MONEY
AS
BEGIN
RETURN @price-(@price*@discount_percent/100)
END;
GO

SELECT product_id,name,price,dbo.get_discounted_price(price,10) AS discounted_price FROM products;

CREATE FUNCTION get_customer_city(@cust_id INT)
RETURNS VARCHAR(30)
AS
BEGIN
DECLARE @city VARCHAR(30)
SELECT @city=city FROM customers WHERE customer_id=@cust_id
RETURN @city
END;
GO

SELECT customer_id,dbo.get_customer_city(customer_id) AS city FROM customers;

CREATE FUNCTION days_since_order(@oid INT)
RETURNS INT
AS
BEGIN
DECLARE @days INT
SELECT @days=DATEDIFF(DAY,order_date,GETDATE()) FROM orders WHERE order_id=@oid
RETURN @days
END;
GO

SELECT order_id,order_date,dbo.days_since_order(order_id) AS days_ago FROM orders;

CREATE FUNCTION get_payment_method(@oid INT)
RETURNS VARCHAR(20)
AS
BEGIN
DECLARE @method VARCHAR(20)
SELECT @method=payment_method FROM payments WHERE order_id=@oid
RETURN @method
END;
GO

SELECT order_id,dbo.get_payment_method(order_id) AS payment_method FROM payments;

CREATE FUNCTION count_products_by_category(@cat_id INT)
RETURNS INT
AS
BEGIN
DECLARE @count INT
SELECT @count=COUNT(*) FROM products WHERE category_id=@cat_id
RETURN @count
END;
GO

SELECT category_id,category_name,dbo.count_products_by_category(category_id) AS total_products FROM category;

CREATE FUNCTION max_order_by_customer(@cust_id INT)
RETURNS DECIMAL(20,2)
AS
BEGIN
DECLARE @max DECIMAL(20,2)
SELECT @max=MAX(total_amount) FROM orders WHERE customer_id=@cust_id
RETURN @max
END;
GO

SELECT customer_id,dbo.max_order_by_customer(customer_id) AS max_order_amount FROM customers;

CREATE FUNCTION product_exists(@pid VARCHAR(50))
RETURNS BIT
AS
BEGIN
DECLARE @exists BIT=0
IF EXISTS(SELECT 1 FROM products WHERE product_id=@pid)
SET @exists=1
RETURN @exists
END;
GO

SELECT product_id,dbo.product_exists(product_id) AS exists_flag FROM products;

CREATE FUNCTION avg_order_value(@cust_id INT)
RETURNS DECIMAL(20,2)
AS
BEGIN
DECLARE @avg DECIMAL(20,2)
SELECT @avg=AVG(total_amount) FROM orders WHERE customer_id=@cust_id
RETURN @avg
END;
GO

SELECT customer_id,dbo.avg_order_value(customer_id) AS avg_order_value FROM customers;

CREATE FUNCTION total_payment()
RETURNS DECIMAL(20,2)
AS
BEGIN
DECLARE @total DECIMAL(20,2)
SELECT @total=SUM(amount) FROM payments
RETURN @total
END;
GO

SELECT dbo.total_payment() AS total_revenue;

CREATE FUNCTION get_category_name(@pid VARCHAR(50))
RETURNS VARCHAR(100)
AS
BEGIN
DECLARE @name VARCHAR(100)
SELECT @name=c.category_name FROM products p JOIN category c ON p.category_id=c.category_id WHERE p.product_id=@pid
RETURN @name
END;
GO

SELECT product_id,name,dbo.get_category_name(product_id) AS category_name FROM products;

CREATE FUNCTION get_last_payment_date()
RETURNS DATETIME
AS
BEGIN
DECLARE @dt DATETIME
SELECT @dt=MAX(payment_date) FROM payments
RETURN @dt
END;
GO

SELECT dbo.get_last_payment_date() AS last_payment;

CREATE FUNCTION count_orders_by_product(@pid VARCHAR(50))
RETURNS INT
AS
BEGIN
DECLARE @cnt INT
SELECT @cnt=COUNT(*) FROM order_items WHERE product_id=@pid
RETURN @cnt
END;
GO

SELECT product_id,name,dbo.count_orders_by_product(product_id) AS times_ordered FROM products;
