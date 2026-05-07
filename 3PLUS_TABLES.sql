-- 1. List all orders with the customer's name and product name (3-table JOIN: orders + customers + products)

SELECT
	o.id as order_number,
	c.name AS customer_name,
	p.product_name
FROM orders o
JOIN products p ON o.product_id = p.id
JOIN customers c ON o.customer_id = c.id;

-- 2. Show only orders for Electronics products — include customer name, product name, and price

SELECT
	o.id as order_number,
	c.name AS customer_name,
	p.product_name as product_name,
	p.price as product_price
FROM orders o
JOIN products p ON o.product_id = p.id
JOIN customers c ON o.customer_id = c.id
WHERE category = 'Electronics';

-- 3. Find all customers and any orders they have placed — show NULL for customers with no orders

SELECT
	o.id as order_number,
	c.name AS customer_name,
	p.product_name,
	o.quantity
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
LEFT JOIN products p ON o.product_id = p.id;

-- 4. Count how many orders each product has received (JOIN orders + products, GROUP BY product_name)

SELECT
	p.product_name as product_name,
	count(o.product_id) as times_sold,
	sum(o.quantity) as amount_sold
FROM orders o
JOIN products p ON o.product_id = p.id
GROUP BY p.id, p.product_name
ORDER BY times_sold DESC, amount_sold DESC;

-- 5. Find the customer who made the highest total purchase (SUM price × quantity, ORDER BY + LIMIT 1)

SELECT
	c.name AS customer_name,
	sum(p.price * o.quantity) as total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN products p ON o.product_id = p.id
GROUP BY c.id, c.name
ORDER BY total_spent DESC
LIMIT 1;
