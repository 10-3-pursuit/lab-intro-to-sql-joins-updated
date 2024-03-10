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
purchases-# (1, 250, TRUE),
purchases-# (2, 190, FALSE),
purchases-# (3, 300, TRUE),
purchases-# (1, 450, TRUE),
purchases-# (4, 120, FALSE),
purchases-# (2, 580, TRUE);
INSERT 0 6


\echo - Find all paid orders include the firstname, email and total
-- --

-- --

\echo - Find all orders, including the firstname, lastname and email of the customer who made each order.
-- --

-- --



\echo - Identify customers who have never made an order, return the first name and email.
-- --

-- --


\echo - List the total spending of each customer along with their first name, last name and email.
-- --

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