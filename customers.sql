-- Getting started, do not update
DROP DATABASE IF EXISTS purchases;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS orders;
CREATE DATABASE purchases;
\c purchases

-- End getting started code


--
-- Create a table called customers
 -- with the following columns
-- id serial primary KEY
-- firstname - string with 20 characters
-- lastname - string with 50 characters
-- email - string with 30 characters(unable to be null)
--
purchases=# CREATE TABLE customers (id SERIAL PRIMARY KEY, firstname VARCHAR(20), lastname VARCHAR(50), email VARCHAR(30) NOT NULL);
CREATE TABLE

--

-- See details of the table you created
-- 
 \d customers
                                     Table "public.customers"
  Column   |         Type          | Collation | Nullable |                Default
-----------+-----------------------+-----------+----------+---------------------------------------
 id        | integer               |           | not null | nextval('customers_id_seq'::regclass)
 firstname | character varying(20) |           |          |
 lastname  | character varying(50) |           |          |
 email     | character varying(30) |           | not null |
Indexes:
    "customers_pkey" PRIMARY KEY, btree (id)

(END)
--

-- Uncomment the code below to add records to the customers table
INSERT INTO customers (firstname, lastname, email) VALUES
('Alex', 'Taylor', 'alex.taylor@example.com'),
('Jordan', 'Lee', 'jordan.lee@example.com'),
('Casey', 'Morgan', 'casey.morgan@example.com'),
('Riley', 'Quinn', 'riley.quinn@example.com'),
('Taylor', 'Morgan', 'taylor.morgan@example.com');
-- Uncomment the code below to add records to the customers table
purchases=# INSERT INTO customers (firstname, lastname, email) VALUES
purchases-# ('Alex', 'Taylor', 'alex.taylor@example.com'),
purchases-# ('Jordan', 'Lee', 'jordan.lee@example.com'),
purchases-# ('Casey', 'Morgan', 'casey.morgan@example.com'),
purchases-# ('Riley', 'Quinn', 'riley.quinn@example.com'),
purchases-# ('Taylor', 'Morgan', 'taylor.morgan@example.com');
INSERT 0 5


-- Create a table called orders with the following columns
-- Note: If no default value is declared explicitly, the default value is the null value. This usually makes sense because a null value can be considered to represent unknown data. https://www.postgresql.org/docs/current/ddl-default.html#:~:text=If%20no%20default%20value%20is,after%20the%20column%20data%20type.
-- id serial primary KEY
-- customerID 
-- total - integer - amount cannot be less than 0
-- isPaid - boolean 
--
purchases=# CREATE TABLE orders (id SERIAL PRIMARY KEY, customerID numeric DEFAULT NULL, total INT, CHECK (total > 0), isPaid BOOLEAN);
CREATE TABLE
--

-- Uncomment the code below to add records to the customers table
-- INSERT INTO orders (customerID, total, isPaid) VALUES
-- (1, 250, TRUE),
-- (2, 190, FALSE),
-- (3, 300, TRUE),
-- (1, 450, TRUE),
-- (4, 120, FALSE),
-- (2, 580, TRUE);
INSERT INTO orders (customerID, total, isPaid) VALUES
(1, 250, TRUE),
(2, 190, FALSE),
(3, 300, TRUE),
(1, 450, TRUE),
(4, 120, FALSE),
(2, 580, TRUE);
INSERT 0 6


-- Find all paid orders include the firstname, email and total
-- --
SELECT customers.firstname, customers.email, orders.total FROM orders FULL OUTER JOIN customers ON orders.id = customers.id WHERE orders.ispaid IS TRUE;
 firstname |          email           | total
-----------+--------------------------+-------
 Alex      | alex.taylor@example.com  |   250
 Casey     | casey.morgan@example.com |   300
 Riley     | riley.quinn@example.com  |   450
           |                          |   580
(4 rows)
-- --

-- Find all orders, including the firstname, lastname and email of the customer who made each order.
-- --
SELECT * FROM orders INNER JOIN customers ON orders.id = customers.id;
 id | customerid | total | ispaid | id | firstname | lastname |           email
----+------------+-------+--------+----+-----------+----------+---------------------------
  1 |          1 |   250 | t      |  1 | Alex      | Taylor   | alex.taylor@example.com
  2 |          2 |   190 | f      |  2 | Jordan    | Lee      | jordan.lee@example.com
  3 |          3 |   300 | t      |  3 | Casey     | Morgan   | casey.morgan@example.com
  4 |          1 |   450 | t      |  4 | Riley     | Quinn    | riley.quinn@example.com
  5 |          4 |   120 | f      |  5 | Taylor    | Morgan   | taylor.morgan@example.com
(5 rows)
-- --



-- Identify customers who have never made an order, return the first name and email.
-- --
-- joining on orders.customerid and checking if orders.id is NULL. This is the correct approach because if there's no matching order for a customer, orders.id will indeed be NULL, as there's no corresponding row in the orders table for that customer.
SELECT customers.firstname, customers.email
FROM customers
LEFT JOIN orders ON customers.id = orders.customerid
WHERE orders.id IS NULL;
 firstname |           email
-----------+---------------------------
 Taylor    | taylor.morgan@example.com
-- --


-- List the total spending of each customer along with their first name, last name and email.
-- --
purchases=# SELECT * FROM customers INNER JOIN orders ON customers.id = orders.id;
 id | firstname | lastname |           email           | id | customerid | total | ispaid
----+-----------+----------+---------------------------+----+------------+-------+--------
  1 | Alex      | Taylor   | alex.taylor@example.com   |  1 |          1 |   250 | t
  2 | Jordan    | Lee      | jordan.lee@example.com    |  2 |          2 |   190 | f
  3 | Casey     | Morgan   | casey.morgan@example.com  |  3 |          3 |   300 | t
  4 | Riley     | Quinn    | riley.quinn@example.com   |  4 |          1 |   450 | t
  5 | Taylor    | Morgan   | taylor.morgan@example.com |  5 |          4 |   120 | f
-- --

\echo - Show a list of firstname, lastname for customers along with the number of orders they have made, including those customers who have not made any orders.
-- --


-- --

\echo - Find all customers who have spent more than 300 in total across all their orders.
-- --

-- --


\echo - For each order, list the order total alongside the email of the customer, include only orders with totals above 400.
-- --

-- --