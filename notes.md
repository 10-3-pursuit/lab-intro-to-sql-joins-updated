# The SQL GROUP BY Statement

The GROUP BY statement groups rows that have the same values into summary rows, like "find the number of customers in each country".

The GROUP BY statement is often used with aggregate functions (COUNT(), MAX(), MIN(), SUM(), AVG()) to group the result-set by one or more columns.

### GROUP BY Syntax:

```
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
ORDER BY column_name(s);
```
Demo Database:

Below is a selection from the "Customers" table in the Northwind sample database:

```sql
| CustomerID | CustomerName                        | ContactName       | Address                      | City        | PostalCode | Country |
|------------|-------------------------------------|-------------------|------------------------------|-------------|------------|---------|
| 1          | Alfreds Futterkiste                 | Maria Anders      | Obere Str. 57                | Berlin      | 12209      | Germany |
| 2          | Ana Trujillo Emparedados y helados  | Ana Trujillo      | Avda. de la Constitución 2222| México D.F. | 05021      | Mexico  |
| 3          | Antonio Moreno Taquería             | Antonio Moreno    | Mataderos 2312               | México D.F. | 05023      | Mexico  |
| 4          | Around the Horn                     | Thomas Hardy      | 120 Hanover Sq.              | London      | WA1 1DP    | UK      |
| 5          | Berglunds snabbköp                  | Christina Berglund| Berguvsvägen 8               | Luleå       | S-958 22   | Sweden  |
```
SQL GROUP BY Examples:

The following SQL statement lists the number of customers in each country:

```sql
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country;
```
The following SQL statement lists the number of customers in each country, sorted high to low:

Example:

```sql
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
ORDER BY COUNT(CustomerID) DESC;
```
# GROUP BY With JOIN Example

Below is a selection from the "Orders" table in the Northwind sample database:

| Order ID | Quantity | Unit Price | Order Date | Priority |
|----------|----------|------------|------------|----------|
| 10248    | 90       | 5          | 1996-07-04 | 3        |
| 10249    | 81       | 6          | 1996-07-05 | 1        |
| 10250    | 34       | 4          | 1996-07-08 | 2        |

And a selection from the "Shippers" table:

| ShipperID | ShipperName     |
|-----------|-----------------|
| 1         | Speedy Express  |
| 2         | United Package  |
| 3         | Federal Shipping|

### GROUP BY With JOIN Example
The following SQL statement lists the number of orders sent by each shipper:

```sql
SELECT Shippers.ShipperName, COUNT(Orders.OrderID) AS NumberOfOrders FROM Orders
LEFT JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID
GROUP BY ShipperName;
```
# SQL HAVING Keyword
HAVING
The HAVING command is used instead of WHERE with aggregate functions.

The following SQL lists the number of customers in each country. Only include countries with more than 5 customers:

Example:
```sql
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5;
```
The HAVING clause was added to SQL because the WHERE clause cannot be used with aggregate functions.

Aggregate functions are often used with GROUP BY clauses, and by adding HAVING we can write condition like we do with WHERE clauses.

## HAVING with JOIN
https://www.w3schools.com/postgresql/postgresql_having.php

The following SQL statement lists only orders with a total price of 400$ or more:

Example:
```sql
SELECT order_details.order_id, SUM(products.price)
FROM order_details
LEFT JOIN products ON order_details.product_id = products.product_id
GROUP BY order_id
HAVING SUM(products.price) > 400.00;
```

<!-- Additional Notes For future reference -->
# SQL Server COALESCE() Function

Example:
Return the first non-null value in a list:

```sql
SELECT COALESCE(NULL, NULL, NULL, 'W3Schools.com', NULL, 'Example.com');
```
Definition and Usage:
The COALESCE() function returns the first non-null value in a list.

Syntax:
COALESCE(val1, val2, ...., val_n)

Parameter Values: val1, val2, val_n

Parameter Description: Required. The values to test

Technical Details:
Works in:	SQL Server (starting with 2008), Azure SQL Database, Azure SQL Data Warehouse, Parallel Data Warehouse

# SQL AS Keyword
AS:
The AS command is used to rename a column or table with an alias. An alias only exists for the duration of the query.

Alias for Columns:
The following SQL statement creates two aliases, one for the CustomerID column and one for the CustomerName column:

Example:
```sql
SELECT CustomerID AS ID, CustomerName AS Customer
FROM Customers;
```
The following SQL statement creates two aliases. Notice that it requires double quotation marks or square brackets if the alias name contains spaces:

Example:
```sql
SELECT CustomerName AS Customer, ContactName AS [Contact Person]
FROM Customers;
```
The following SQL statement creates an alias named "Address" that combine four columns (Address, PostalCode, City and Country):

Example:
```sql
SELECT CustomerName, Address + ', ' + PostalCode + ' ' + City + ', ' + Country AS Address
FROM Customers;
```
Note: To get the SQL statement above to work in MySQL use the following:

```sql
SELECT CustomerName, CONCAT(Address,', ',PostalCode,', ',City,', ',Country) AS Address
FROM Customers;
```
Alias for Tables:
The following SQL statement selects all the orders from the customer with CustomerID=4 (Around the Horn). We use the "Customers" and "Orders" tables, and give them the table aliases of "c" and "o" respectively (Here we use aliases to make the SQL shorter):

Example:
```sql
SELECT o.OrderID, o.OrderDate, c.CustomerName
FROM Customers AS c, Orders AS o
WHERE c.CustomerName="Around the Horn" AND c.CustomerID=o.CustomerID;
```