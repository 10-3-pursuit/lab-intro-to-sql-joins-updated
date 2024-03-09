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
CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  firstname VARCHAR(20),
  lastname VARCHAR(50),
  email VARCHAR(30) NOT NULL
);
--

\echo See details of the table you created
-- 
\d customers
--

\echo - Uncomment the code below to add records to the customers table

INSERT INTO 
customers (firstname, lastname, email) 
VALUES
('Alex', 'Taylor', 'alex.taylor@example.com'),
('Jordan', 'Lee', 'jordan.lee@example.com'),
('Casey', 'Morgan', 'casey.morgan@example.com'),
('Riley', 'Quinn', 'riley.quinn@example.com'),
('Taylor', 'Morgan', 'taylor.morgan@example.com');


\echo - Create a table called orders with the following columns
-- id serial primary KEY
-- customerID 
-- total - integer - amount cannot be less than 0
-- isPaid - boolean 
--
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customerID INT REFERENCES customers(id),
    total INTEGER CHECK (total >= 0),
    isPaid BOOLEAN
);
--

\echo - Uncomment the code below to add records to the customers table
INSERT INTO 
orders (customerID, total, isPaid) 
VALUES
(1, 250, TRUE),
(2, 190, FALSE),
(3, 300, TRUE),
(1, 450, TRUE),
(4, 120, FALSE),
(2, 580, TRUE);



\echo - Find all paid orders include the firstname, email and total
-- --
SELECT customers.firstname, customers.email, orders.total
FROM orders
INNER JOIN customers ON orders.customerID = customers.id
WHERE orders.isPaid = TRUE;
-- --

\echo - Find all orders, including the firstname, lastname and email of the customer who made each order.
-- --
SELECT orders.*, customers.firstname, customers.lastname, customers.email
FROM orders
INNER JOIN customers ON orders.customerID = customers.id;
-- --



\echo - Identify customers who have never made an order, return the first name and email.
-- --
SELECT customers.firstname, customers.email
FROM customers
LEFT JOIN orders ON customers.id = orders.customerID
WHERE orders.id IS NULL;
-- --


\echo - List the total spending of each customer along with their first name, last name and email.
-- --
SELECT customers.firstname, customers.lastname, customers.email, SUM(orders.total) AS total_spending
FROM customers
LEFT JOIN orders ON customers.id = orders.customerID
GROUP BY customers.id, customers.firstname;
-- --

\echo - Show a list of firstname, lastname for customers along with the number of orders they have made, including those customers who have not made any orders.
-- --
SELECT customers.firstname, customers.lastname, COUNT(orders.id) AS num_orders
FROM customers
LEFT JOIN orders ON customers.id = orders.customerID
GROUP BY customers.id, customers.firstname, customers.lastname;
-- --

\echo - Find all customers who have spent more than 300 in total across all their orders.
-- --
SELECT customers.id, customers.firstname, customers.lastname, SUM(orders.total) AS total_spending
FROM customers
LEFT JOIN orders ON customers.id = orders.customerID
GROUP BY customers.id, customers.firstname 
HAVING SUM(orders.total) > 300;
-- --
-- having filters after calculating sum and grouping it.

\echo - For each order, list the order total alongside the email of the customer, include only orders with totals above 400.
-- --
SELECT orders.total AS order_total, customers.email
FROM orders
JOIN customers ON orders.customerID = customers.id
WHERE orders.total > 400;
-- --