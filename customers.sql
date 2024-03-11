-- Getting started, do not update
DROP DATABASE IF EXISTS purchases;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS orders;
CREATE DATABASE purchases;
\c purchases

-- End getting started code


--
\echo - Create a table called customers
 -- with the following columns
-- id serial primary KEY
-- firstname - string with 20 characters
-- lastname - string with 50 characters
-- email - string with 20 characters(unable to be null)
--
CREATE TABLE customers(id SERIAL PRIMARY KEY, first_name VARCHAR(20), last_name VARCHAR(50), email VARCHAR(30) NOT NULL );
--

\echo See details of the table you created
-- 
\d customers;
--

\echo - Uncomment the code below to add records to the customers table
INSERT INTO customers (first_name, last_name, email) VALUES
('Alex', 'Taylor', 'alex.taylor@example.com'),
('Jordan', 'Lee', 'jordan.lee@example.com'),
('Casey', 'Morgan', 'casey.morgan@example.com'),
('Riley', 'Quinn', 'riley.quinn@example.com'),
('Taylor', 'Morgan', 'taylor.morgan@example.com');




\echo - Create a table called orders with the following columns
-- id serial primary KEY
-- customerID - references the id from customers table
-- total - integer - amount cannot be less than 0
-- isPaid - boolean 
--
CREATE TABLE orders(id SERIAL PRIMARY KEY, customer_id INT, total INT, isPaid BOOLEAN,  CHECK(total >= 0));
--

\echo - Uncomment the code below to add records to the customers table
INSERT INTO orders (customer_id, total, isPaid) VALUES
(1, 250, TRUE),
(2, 190, FALSE),
(3, 300, TRUE),
(1, 450, TRUE),
(4, 120, FALSE),
(2, 580, TRUE);



\echo - Find all paid orders include the firstname, email and total
-- --
SELECT first_name, email, total FROM customers FULL OUTER JOIN orders ON customers.id = orders.customer_id WHERE isPaid = true; 
-- --

\echo - Find all orders, including the firstname, lastname and email of the customer who made each order.
-- --
SELECT first_name, last_name, email FROM customers INNER JOIN orders ON customers.id = orders.customer_id;
-- --



\echo - Identify customers who have never made an order, return the first name and email.
-- --
-- could do this either way
-- SELECT first_name, email FROM customers WHERE id NOT IN (SELECT DISTINCT customer_id FROM orders);

SELECT customers.first_name, customers.email
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
WHERE orders.id IS NULL;
-- --


\echo - List the total spending of each customer along with their first name, last name and email.
-- --
SELECT 
    customers.first_name, 
    customers.last_name, 
    customers.email, 
SUM(orders.total) AS total_spending
FROM 
    customers customers
LEFT JOIN 
    orders orders ON customers.id = orders.customer_id
GROUP BY 
    customers.id;
-- HAVING SUM(order.total), 0 > 0;




-- --

\echo - Show a list of firstname, lastname for customers along with the number of orders they have made, including those customers who have not made any orders.
-- --


SELECT customers.first_name, customers.last_name, COUNT(orders.id) AS number_of_orders
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.id;
-- --

\echo - Find all customers who have spent more than 300 in total across all their orders.
-- --
SELECT customers.first_name, customers.last_name, customers.email, SUM(orders.total) AS total_spent
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.id
HAVING SUM(orders.total) > 300;
-- --


\echo - For each order, list the order total alongside the email of the customer, include only orders with totals above 400.
-- --
SELECT customers.email, orders.total
FROM customers
INNER JOIN orders ON customers.id = orders.customer_id
WHERE orders.total > 400;
-- --