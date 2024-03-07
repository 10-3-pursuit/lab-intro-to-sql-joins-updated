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
CREATE TABLE customers (id SERIAL PRIMARY KEY, firstname VARCHAR(20), lastname VARCHAR(50), email VARCHAR(30) NOT NULL);
--

\echo See details of the table you created
-- 
SELECT * FROM customers;
--

\echo - Uncomment the code below to add records to the customers table
INSERT INTO customers (firstname, lastname, email) VALUES
('Alex', 'Taylor', 'alex.taylor@example.com'),
('Jordan', 'Lee', 'jordan.lee@example.com'),
('Casey', 'Morgan', 'casey.morgan@example.com'),
('Riley', 'Quinn', 'riley.quinn@example.com'),
('Taylor', 'Morgan', 'taylor.morgan@example.com');




\echo - Create a table called orders
 with the following columns
-- id serial primary KEY
-- customerID - references the id from customers table
-- total - integer - amount cannot be less than 0
-- isPaid - boolean 
--
CREATE TABLE orders (id SERIAL PRIMARY KEY, customer_id numeric, total INT 
CHECK(total >= 0 ), is_paid BOOLEAN);
--

\echo - Uncomment the code below to add records to the customers table
INSERT INTO orders (customer_id, total, is_paid) VALUES
(1, 250, TRUE),
(2, 190, FALSE),
(3, 300, TRUE),
(1, 450, TRUE),
(4, 120, FALSE),
(2, 580, TRUE);



\echo - Find all paid orders include the firstname, email and total
-- --
SELECT customers.firstname, customers.email, orders.total FROM orders INNER JOIN customers ON orders.customer_id = customers.id WHERE orders.is_paid = TRUE;
-- --

\echo - Find all orders, including the firstname, lastname and email of the customer who made each order.
-- --
SELECT orders.id, orders.total, orders.is_paid, customers.firstname, customers.lastname, customers.email FROM orders LEFT JOIN customers ON orders.customer_id = customers.id;
-- --



\echo - Identify customers who have never made an order, return the first name and email.
-- --
SELECT customers.firstname, customers.email FROM customers FULL OUTER JOIN orders ON orders.customer_id = customers.id WHERE orders.id IS NULL;
-- --


\echo - List the total spending of each customer along with their first name, last name and email.
-- --
SELECT customers.firstname, customers.lastname, customers.email, SUM(total) FROM customers LEFT JOIN orders ON orders.customer_id = customers.id GROUP BY customers.firstname, customers.lastname, customers.email;
-- --

\echo - Show a list of firstname, lastname for customers along with the number of orders they have made, including those customers who have not made any orders.
-- --
SELECT customers.firstname, customers.lastname, COUNT(orders.id) FROM customers LEFT JOIN orders ON orders.customer_id = customers.id GROUP BY customers.firstname, customers.lastname;

-- --

\echo - Find all customers who have spent more than 300 in total across all their orders.
-- --
SELECT customers.firstname, customers.lastname, customers.email, SUM(orders.total) FROM customers JOIN orders ON orders.customer_id = customers.id GROUP BY customers.firstname, customers.lastname, customers.email HAVING SUM(orders.total) > 300;

-- --


\echo - For each order, list the order total alongside the email of the customer, include only orders with totals above 400.
-- --
SELECT customers.email, orders.total FROM orders LEFT JOIN customers ON orders.customer_id = customers.id WHERE orders.total > 400;
-- --