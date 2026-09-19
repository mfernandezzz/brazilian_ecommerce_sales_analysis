-- 1) Top products
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

-- Payments type, total_orders and the revenue by payment_type
SELECT payments.payment_type AS payment_type, COUNT(orders.order_id) AS orders, SUM(payments.payment_value) AS revenue
FROM payments
INNER JOIN orders ON payments.order_id = orders.order_id
GROUP BY payment_type
ORDER BY revenue DESC;

-- Select all the data for those orders with a not_defined payment_type
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

-- SELECT the products and the respective amount of orders for those purchases made with a debit card (debit_card payment type)
SELECT product_category_name, COUNT(orders.order_id) AS orders
FROM products
INNER JOIN order_items ON products.product_id = order_items.product_id
INNER JOIN orders ON order_items.order_id = orders.order_id
INNER JOIN payments ON orders.order_id = payments.order_id
WHERE payment_type = 'debit_card'
GROUP BY product_category_name
ORDER BY orders DESC;

-- 2) RFM Segmentation: RFM segmentation is a marketing method for grouping customers based on:
-- Recency: how recently they purchased
-- Frequency: how often they purchase
-- Moentary Value: how much they spend
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

-- Select the City, customers per city, total spending by customers in each city, total orders, and last purchase date
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

-- 3) yearly_revenue_trend and monthly_revenue_trend
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