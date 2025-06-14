CREATE VIEW customer_summary AS
SELECT c.customer_id,CONCAT(c.first_name,' ',c.last_name) AS customer_name,COUNT(o.order_id) AS total_orders,SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
GROUP BY c.customer_id,c.first_name,c.last_name;

CREATE VIEW active_orders AS
SELECT o.order_id,o.customer_id,o.total_amount,o.status,p.payment_method,p.amount AS paid_amount
FROM orders o
JOIN payments p ON o.order_id=p.order_id
WHERE o.status='active';

CREATE VIEW low_stock AS
SELECT product_id,name AS product_name,stock_quantity,price
FROM products
WHERE stock_quantity<50;

CREATE VIEW order_items_detail AS
SELECT oi.order_item_id,o.order_id,CONCAT(c.first_name,' ',c.last_name) AS customer_name,p.name AS product_name,oi.quantity,oi.unit_price,oi.subtotal
FROM order_items oi
JOIN orders o ON oi.order_id=o.order_id
JOIN customers c ON o.customer_id=c.customer_id
JOIN products p ON oi.product_id=p.product_id;

CREATE VIEW category_summary AS
SELECT cat.category_name,COUNT(p.product_id) AS total_products,SUM(p.stock_quantity) AS total_stock
FROM category cat
JOIN products p ON cat.category_id=p.category_id
GROUP BY cat.category_name;
