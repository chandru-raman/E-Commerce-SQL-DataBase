CREATE UNIQUE INDEX idx_email ON customers(email_id);

CREATE INDEX idx_city ON customers(city);

CREATE INDEX idx_order_cust ON orders(customer_id);

CREATE INDEX idx_order_status ON orders(status);

CREATE INDEX idx_prod_cat ON products(category_id);

CREATE INDEX idx_prod_name ON products(name);

CREATE INDEX idx_item_prod ON order_items(product_id);

CREATE INDEX idx_pay_order ON payments(order_id);

CREATE INDEX idx_item_order_prod ON order_items(order_id, product_id);

CREATE INDEX idx_prod_price_stock ON products(price, stock_quantity);
