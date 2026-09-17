-- Create the schema for the database
CREATE DATABASE brazilian_ecommerce;

-- Table customer
CREATE TABLE customer (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_city VARCHAR(50) NOT NULL,
    customer_state VARCHAR(10) NOT NULL
    customer_zip_code_prefix INT NOT NULL
);

-- Table payments
CREATE TABLE payments (
    payment_sequential INT NOT NULL,
    payment_type VARCHAR(25) NOT NULL,
    payment_installments INT NOT NULL,
    payment_value REAL NOT NULL
);

-- Table reviews (orders)
CREATE TABLE reviews (
    review_id VARCHAR(50) PRIMARY KEY,
    review_score INT NOT NULL,
    review_comment_title VARCHAR(50),
    review_comment_message TEXT,
    review_creation_date DATE
);

-- Table Orders
CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    order_status VARCHAR(20) NOT NULL,
    order_purchase_timestamp DATE,
    order_approved_at DATE,
    order_delivered_carrier_date DATE,
    order_delivered_customer_date DATE,
    order_estimated_delivery_date DATE
);

ALTER TABLE orders ADD COLUMN customer_id VARCHAR(50);
ALTER TABLE orders ADD CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id);

ALTER TABLE payments ADD COLUMN order_id VARCHAR(50) PRIMARY KEY;
ALTER TABLE payemnts ADD CONSTRAINT fk_payments_orders FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE reviews ADD COLUMN order_id VARCHAR(50) NOT NULL;
ALTER TABLE reviews ADD CONSTRAINT fk_reviews_orders FOREIGN KEY (order_id) REFERENCES orders(order_id);

-- Table products
CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(50) NOT NULL,
    product_name_length INT NOT NULL,
    product_weight_g INT NOT NULL,
    product_length_cm INT NOT NULL,
    product_height_cm INT NOT NULL,
    product_width_cm INT NOT NULL
);

-- Table order_items (orders-products)
CREATE TABLE order_items (
    order_detail_id SERIAL PRIMARY KEY,
    items_quantity INT NOT NULL,
    shipping_limit_date DATE,
    price REAL NOT NULL,
    freight_value REAL NOT NULL
);

ALTER TABLE order_items ADD COLUMN order_id VARCHAR(50) NOT NULL;
ALTER TABLE order_items ADD COLUMN product_id VARCHAR(50) NOT NULL;

ALTER TABLE order_items ADD CONSTRAINT fk_order_items_orders FOREIGN KEY (order_id) REFERENCES orders(order_id);
ALTER TABLE order_items ADD CONSTRAINT fk_order_items_products FOREIGN KEY (product_id) REFERENCES products(product_id);

-- Table sellers
CREATE TABLE sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix INT NOT NULL,
    seller_city VARCHAR(50) NOT NULL,
    seller_state VARCHAR(10) NOT NULL
);

ALTER TABLE order_items ADD COLUMN seller_id VARCHAR(50) NOT NULL;
ALTER TABLE order_items ADD CONSTRAINT fk_order_items_sellers FOREIGN KEY (seller_id) REFERENCES sellers(seller_id);

-- Table category_name_translation
CREATE TABLE category_name_translation (
    portuguese_name VARCHAR(50) NOT NULL,
    english_name VARCHAR(50) NOT NULL
);

-- Insert data into tables from csv files using psql command line
-- Table customer
\copy customer (customer_city, customer_city, customer_state, customer_zip_code_prefix) 
    FROM '/home/matiasf/Desktop/Brazilian_Ecommerce_SQL_project/customers.csv' 
    WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', ENCODING 'UTF-8');

-- Table orders
\copy orders (order_id, order_status, order_purchase_timestamp, order_approved_at, order_delivered_carrier_date,
            order_delivered_customer_date, order_estimated_delivery_date, customer_id)
    FROM '/home/matiasf/Desktop/Brazilian_Ecommerce_SQL_project/orders.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', ENCODING 'UTF-8');

-- Table payments
\copy payments (payment_sequential, payment_type, payment_installments, payment_value, order_id)
    FROM '/home/matiasf/Desktop/Brazilian_Ecommerce_SQL_project/payments.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', ENCODING 'UTF-8');

-- Table reviews
\copy reviews (review_id, review_score, review_comment_title, review_creation_date, order_id)
    FROM '/home/matiasf/Desktop/Brazilian_Ecommerce_SQL_project/reviews.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', ENCODING 'UTF-8');

\copy products (product_id, product_category_name, product_name_length, product_weight_g, product_length_cm, product_height_cm, product_width_cm)
    FROM '/home/matiasf/Desktop/Brazilian_Ecommerce_SQL_project/products.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', ENCODING 'UTF-8');

\copy sellers (seller_id, seller_city, seller_state, seller_zip_code_prefix)
    FROM '/home/matiasf/Desktop/Brazilian_Ecommerce_SQL_project/sellers.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', ENCODING 'UTF-8');

\copy order_items (items_quantity, shipping_limit_date, price, freight_value, order_detail_id, order_id, product_id, seller_id)
    FROM '/home/matiasf/Desktop/Brazilian_Ecommerce_SQL_project/order_items.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', ENCODING 'UTF-8');

\copy category_name_translation (portuguese_name, english_name)
    FROM '/home/matiasf/Desktop/Brazilian_Ecommerce_SQL_project/product_category_name_translation.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', ENCODING 'UTF-8');