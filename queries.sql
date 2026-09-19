-- Top 10 products with highest quantity of orders
SELECT product_category_name AS product, COUNT(order_items.order_id) AS orders
FROM products
INNER JOIN order_items ON products.product_id = order_items.product_id
GROUP BY product
ORDER BY orders DESC;

-- Top 10 products and their respective revenue
SELECT products.product_category_name AS product, SUM(payments.payment_value) AS revenue
FROM products
INNER JOIN order_items ON products.product_id = order_items.product_id
INNER JOIN orders ON order_items.order_id = orders.order_id
INNER JOIN payments ON orders.order_id = payments.order_id
GROUP BY product
ORDER BY revenue DESC
LIMIT 10;

-- Payments type and their respective amount of orders
SELECT payment_type, COUNT(order_id) AS orders
FROM payments
GROUP BY payment_type
ORDER BY orders DESC;

-- Payments type, total_orders and revenue
SELECT payments.payment_type AS payment_type, COUNT(orders.order_id) AS orders, SUM(payments.payment_value) AS revenue
FROM payments
INNER JOIN orders ON payments.order_id = orders.order_id
GROUP BY payment_type
ORDER BY revenue DESC;

-- All the data for those orders with a not_defined payment_type
SELECT * FROM orders
INNER JOIN payments ON orders.order_id = payments.order_id
WHERE payment_type = 'not_defined';

-- City and State with their respective amount of customers
SELECT customer_state AS state, COUNT(customer.customer_id) AS customers
FROM customer
GROUP BY state
ORDER BY customers DESC;

SELECT customer_city AS city, COUNT(customer.customer_id) AS customers
FROM customer
GROUP BY city
ORDER BY customers DESC;

SELECT customer_city AS city, customer_state AS state, COUNT(customer_id) AS customers
FROM customer
GROUP BY city, state
ORDER BY customers DESC
LIMIT 10;

-- The products and the respective amount of orders for those purchases made with a debit card (debit_card payment type)
SELECT product_category_name, COUNT(orders.order_id) AS orders
FROM products
INNER JOIN order_items ON products.product_id = order_items.product_id
INNER JOIN orders ON order_items.order_id = orders.order_id
INNER JOIN payments ON orders.order_id = payments.order_id
WHERE payment_type = 'debit_card'
GROUP BY product_category_name
ORDER BY orders DESC;

-- RFM Segmentation: RFM segmentation is a marketing method for grouping customers based on:
-- Recency: how recently they purchased
-- Frequency: how often they purchase
-- Monetary Value: how much they spend
SELECT customer.customer_id AS id, customer.customer_city AS city, customer_state AS state, 
    MAX(orders.order_purchase_timestamp) AS last_purchase, 
    COUNT(orders.order_id) AS orders, 
    SUM(payments.payment_value) AS total_spend
FROM customer
INNER JOIN orders ON customer.customer_id = orders.customer_id
INNER JOIN payments ON orders.order_id = payments.order_id
GROUP BY id, city, state
ORDER BY total_spend DESC
LIMIT 10;

-- The City, customers per city, total spending by customers in each city, total orders, and last purchase date
SELECT customer.customer_city AS city, COUNT(customer.customer_id) AS customers, 
    SUM(payments.payment_value) AS total_spending,
    COUNT(orders.order_id) AS total_orders,
    MAX(orders.order_purchase_timestamp) AS last_order
FROM customer
INNER JOIN orders ON customer.customer_id = orders.customer_id
INNER JOIN payments ON orders.order_id = payments.order_id
GROUP BY city
ORDER BY total_spending DESC
LIMIT 10;

-- Identify the top 10 sellers, their city, state, last sell date, last_sell made, quantity of orders and total revenue
SELECT sellers.seller_id AS id, sellers.seller_city AS city, sellers.seller_state AS state, 
    MAX(orders.order_purchase_timestamp) AS last_sell,
    COUNT(orders.order_id) AS orders, 
    SUM(payments.payment_value) AS revenue
FROM sellers
INNER JOIN order_items ON sellers.seller_id = order_items.seller_id
INNER JOIN orders ON order_items.order_id = orders.order_id
INNER JOIN payments ON orders.order_id = payments.order_id
GROUP BY id, city, state 
ORDER BY revenue DESC
LIMIT 10;

-- Get the total revenue by year
SELECT DISTINCT (EXTRACT(year FROM order_purchase_timestamp)) AS year, SUM(payments.payment_value) AS revenue
FROM orders
INNER JOIN payments ON orders.order_id = payments.order_id
GROUP BY year
ORDER BY year ASC;

-- Get the total revenue by month for all the period
SELECT DISTINCT (EXTRACT(year FROM order_purchase_timestamp)) AS year, 
    (EXTRACT(month FROM order_purchase_timestamp)) AS month,
    SUM(payments.payment_value) AS revenue
FROM orders
INNER JOIN payments ON orders.order_id = payments.order_id
GROUP BY year, month
ORDER BY year ASC;

-- Show the products, the quantity of orders and the revenue for each one during the year 2017
SELECT products.product_category_name AS product, COUNT(orders.order_id) AS orders, SUM(payments.payment_value) AS revenue
FROM products
INNER JOIN order_items ON products.product_id = order_items.product_id
INNER JOIN orders ON order_items.order_id = orders.order_id
INNER JOIN payments ON orders.order_id = payments.order_id
WHERE EXTRACT(year FROM orders.order_purchase_timestamp) = 2017
GROUP BY product
ORDER BY orders DESC
LIMIT 10;

-- Total orders and revenue per product with a freight_value above the average
SELECT products.product_category_name AS product,
    COUNT(orders.order_id) AS orders, 
    SUM(payments.payment_value) AS revenue
FROM products
INNER JOIN order_items ON products.product_id = order_items.product_id
INNER JOIN orders ON order_items.order_id = orders.order_id
INNER JOIN payments ON orders.order_id = payments.order_id
WHERE freight_value > (SELECT AVG(freight_value) FROM order_items)
GROUP BY product, freight_value
ORDER BY revenue DESC;
