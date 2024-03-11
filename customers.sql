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
-- email - string with 30 characters(unable to be null)
--
CREATE TABLE customers (id SERIAL PRIMARY KEY, firstname VARCHAR(20), lastname VARCHAR(50), email VARCHAR(30) not NULL);
--

\echo See details of the table you created
-- 
\d customers;
--

\echo - Uncomment the code below to add records to the customers table
INSERT INTO customers (firstname, lastname, email) VALUES
('Alex', 'Taylor', 'alex.taylor@example.com'),
('Jordan', 'Lee', 'jordan.lee@example.com'),
('Casey', 'Morgan', 'casey.morgan@example.com'),
('Riley', 'Quinn', 'riley.quinn@example.com'),
('Taylor', 'Morgan', 'taylor.morgan@example.com');




\echo - Create a table called orders
--  with the following columns
-- id serial primary KEY
-- customerID 
-- total - integer - amount cannot be less than 0
-- isPaid - boolean 
--
CREATE TABLE orders (id SERIAL PRIMARY KEY, customerID INT, total INT CHECK (total >= 0), isPaid BOOLEAN);
--


\echo - Uncomment the code below to add records to the customers table
INSERT INTO orders (customerID, total, isPaid) VALUES
(1, 250, TRUE),
(2, 190, FALSE),
(3, 300, TRUE),
(1, 450, TRUE),
(4, 120, FALSE),
(2, 580, TRUE);



\echo - Find all paid orders include the firstname, email and total
-- --
SELECT c.firstname, c.email, SUM(o.total) AS total
FROM customers c JOIN orders o ON c.id = o.customerID
WHERE isPaid = TRUE
GROUP BY c.firstname, c.email;
-- --

\echo - Find all orders, including the firstname, lastname and email of the customer who made each order.
-- --
SELECT o.id AS order_id, c.firstname, c.lastname, c.email
FROM orders o JOIN customers c ON o.customerID = c.id;
-- --



\echo - Identify customers who have never made an order, return the first name and email.
-- --
SELECT c.firstname, c.email FROM customers c LEFT JOIN orders o ON c.id = o.customerID WHERE o.id IS NULL;

-- --


\echo - List the total spending of each customer along with their first name, last name and email.
-- --
SELECT c.firstname, c.lastname, c.email, SUM(o.total) AS total_spending 
FROM customers c LEFT JOIN orders o ON c.id = o.customerID
GROUP BY c.firstname, c.lastname, c.email;

-- --

\echo - Show a list of firstname, lastname for customers along with the number of orders they have made, including those customers who have not made any orders.
-- --
SELECT c.firstname, c.lastname, COUNT(o.id) AS orders FROM customers c
LEFT JOIN orders o ON c.id = o.customerID GROUP BY c.id, c.firstname, c.lastname;

-- --

\echo - Find all customers who have spent more than 300 in total across all their orders.
-- --
SELECT c.firstname, c.lastname, c.email, SUM(o.total) AS total_spending 
FROM customers c JOIN orders o ON c.id = o.customerID GROUP BY c.id, c.firstname, c.lastname
HAVING SUM(o.total) > 300;

-- --


\echo - For each order, list the order total alongside the email of the customer, include only orders with totals above 400.
-- --
SELECT o.total AS order_total, c.email FROM orders o JOIN customers c ON o.customerID = c.id
WHERE o.total > 400;
-- --