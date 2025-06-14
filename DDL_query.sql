SELECT * FROM customers WHERE city='Delhi';

SELECT p.* FROM products p
JOIN category c ON p.category_id=c.category_id
WHERE c.category_name='Electronics';

SELECT * FROM orders WHERE status='active';

SELECT customer_id,COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id;

SELECT o.order_id,c.first_name,c.last_name,o.total_amount
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id;

SELECT p.name,oi.quantity,oi.subtotal
FROM order_items oi
JOIN products p ON oi.product_id=p.product_id;

SELECT DISTINCT c.first_name,c.last_name
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN payments p ON o.order_id=p.order_id
WHERE p.payment_method='UPI';

SELECT * FROM products
ORDER BY stock_quantity DESC
LIMIT 5;

SELECT payment_method,SUM(amount) AS total_collected
FROM payments
GROUP BY payment_method;

SELECT o.order_id,p.name AS product_name,oi.quantity
FROM orders o
JOIN order_items oi ON o.order_id=oi.order_id
JOIN products p ON oi.product_id=p.product_id;

SELECT DISTINCT c.first_name,c.last_name
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN order_items oi ON o.order_id=oi.order_id
JOIN products p ON oi.product_id=p.product_id
JOIN category cat ON p.category_id=cat.category_id
WHERE cat.category_name='Books';

SELECT c.first_name,c.last_name,SUM(p.amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN payments p ON o.order_id=p.order_id
GROUP BY c.first_name, c.last_name;

SELECT * FROM products
WHERE product_id NOT IN(
SELECT product_id FROM order_items
);

SELECT * FROM orders
ORDER BY total_amount DESC;

SELECT phone_no,COUNT(*) AS count
FROM customers
GROUP BY phone_no
HAVING COUNT(*)>1;

UPDATE products
SET stock_quantity=stock_quantity-10
WHERE product_id='P1001';

UPDATE orders
SET status='active'
WHERE order_id=5;

UPDATE customers
SET email_id='ravi_updated@gmail.com'
WHERE city='Mumbai';

UPDATE products
SET price=price*1.10
WHERE category_id=(
SELECT category_id FROM category WHERE category_name='Electronics'
);

UPDATE payments
SET payment_method='CARD'
WHERE order_id=10;

UPDATE orders
SET status='non-active'
WHERE total_amount<3000;

UPDATE customers
SET address='Updated Address 123'
WHERE last_name='Kaur';

UPDATE products
SET name='Office Chair'
WHERE name='Desk Chair';

UPDATE order_items
SET subtotal=quantity*unit_price
WHERE order_item_id='OI3';

UPDATE products
SET stock_quantity=stock_quantity-5
WHERE product_id='P1002';

DELETE FROM customers
WHERE customer_id NOT IN (
  SELECT DISTINCT customer_id FROM orders
);

DELETE FROM products
WHERE stock_quantity=0;

DELETE FROM orders
WHERE status='non-active' AND total_amount<3000;

DELETE FROM payments
WHERE amount<1000;

DELETE FROM order_items
WHERE quantity=1;

SELECT p.name,SUM(oi.subtotal) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id=p.product_id
GROUP BY p.name;

SELECT c.category_name,COUNT(p.product_id) AS product_count
FROM category c
LEFT JOIN products p ON c.category_id=p.category_id
GROUP BY c.category_name;

SELECT TOP 1 c.first_name,c.last_name,SUM(p.amount) AS total
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN payments p ON o.order_id=p.order_id
GROUP BY c.first_name, c.last_name
ORDER BY total DESC;

SELECT DISTINCT c.first_name,c.last_name
FROM customers c
JOIN orders o ON c.customer_id=o.customer_id
JOIN order_items oi ON o.order_id=oi.order_id
JOIN products p ON oi.product_id=p.product_id
WHERE p.name='Guitar';

SELECT p.name,SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id=p.product_id
GROUP BY p.name
HAVING SUM(oi.quantity)>2;
