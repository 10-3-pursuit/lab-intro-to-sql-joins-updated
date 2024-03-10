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
purchases=# \d customers
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

\echo - Uncomment the code below to add records to the customers table
-- INSERT INTO customers (firstname, lastname, email) VALUES
-- ('Alex', 'Taylor', 'alex.taylor@example.com'),
-- ('Jordan', 'Lee', 'jordan.lee@example.com'),
-- ('Casey', 'Morgan', 'casey.morgan@example.com'),
-- ('Riley', 'Quinn', 'riley.quinn@example.com'),
-- ('Taylor', 'Morgan', 'taylor.morgan@example.com');




\echo - Create a table called orders
 with the following columns
-- id serial primary KEY
-- customerID 
-- total - integer - amount cannot be less than 0
-- isPaid - boolean 
--

--

\echo - Uncomment the code below to add records to the customers table
-- INSERT INTO orders (customerID, total, isPaid) VALUES
-- (1, 250, TRUE),
-- (2, 190, FALSE),
-- (3, 300, TRUE),
-- (1, 450, TRUE),
-- (4, 120, FALSE),
-- (2, 580, TRUE);



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