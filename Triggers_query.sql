-- Tracks when a customer is deleted for audit purposes
CREATE TRIGGER log_customer_delete ON customers AFTER DELETE AS
BEGIN
INSERT INTO audit_log(table_name,action_type) VALUES('customers','DELETE');
END;

-- Logs when a new product category is added to track catalog updates
CREATE TRIGGER log_category_insert ON category AFTER INSERT AS
BEGIN
INSERT INTO audit_log(table_name,action_type) VALUES('category','INSERT');
END;

-- Logs product updates and gives a warning if stock is running low
CREATE TRIGGER log_product_update ON products AFTER UPDATE AS
BEGIN
IF EXISTS(SELECT 1 FROM inserted WHERE stock_quantity<10)
BEGIN
PRINT 'Warning: Stock level is low (below 10 units).';
END;
INSERT INTO audit_log(table_name,action_type) VALUES('products','UPDATE');
END;

-- Logs the creation of a new order for tracking order history
CREATE TRIGGER log_order_insert ON orders AFTER INSERT AS
BEGIN
INSERT INTO audit_log(table_name,action_type) VALUES('orders','INSERT');
END;

-- Automatically updates subtotal in order_items when quantity or price is updated
CREATE TRIGGER update_order_item_subtotal ON order_items AFTER UPDATE AS
BEGIN
UPDATE oi SET oi.subtotal=i.quantity*i.unit_price
FROM order_items oi JOIN inserted i ON oi.order_item_id=i.order_item_id;
INSERT INTO audit_log(table_name,action_type) VALUES('order_items','UPDATE');
END;

-- Validates payment against order total and logs mismatches
CREATE TRIGGER log_payment_insert ON payments AFTER INSERT AS
BEGIN
IF EXISTS(
SELECT 1 FROM payments p JOIN orders o ON p.order_id=o.order_id
WHERE p.amount<>o.total_amount)
BEGIN
PRINT 'Payment mismatch: Amount paid does not match order total.';
END;
INSERT INTO audit_log(table_name,action_type) VALUES('payments','INSERT');
END;
