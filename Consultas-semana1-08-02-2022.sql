use classicmodels;

# 1°
SELECT *FROM customers;

# 2°
SELECT *FROM customers c 
	WHERE c.state like 'NY';

# 3°
SELECT COUNT(c.customerNumber), c.country FROM customers c 
	GROUP BY c.country;

# 4°
SELECT COUNT(c.customerNumber), c.country FROM customers c 
	GROUP BY c.country 
	ORDER BY COUNT(c.customerNumber) DESC;

# 5°
SELECT COUNT(c.customerNumber), c.country FROM customers c 
	GROUP BY c.country 
    HAVING COUNT(c.customerNumber) > 10
    ORDER BY COUNT(c.customerNumber) DESC;

# 6°
SELECT *FROM employees e
	WHERE e.officeCode = (SELECT o.officeCode FROM offices o
    WHERE o.city LIKE 'Boston');
    
# 7°
SELECT * FROM customers c
	WHERE c.customerNumber IN (SELECT o.customerNumber FROM orders o
	WHERE o.orderNumber IN (SELECT od.orderNumber FROM orderdetails od
    WHERE od.productCode LIKE 'S10_1678'));

# 8°
SELECT * FROM products p
	WHERE p.buyPrice BETWEEN 10 AND 100;

# 9°
SELECT *FROM products p
	WHERE p.productCode IN (SELECT o.productCode FROM orderdetails o
    WHERE o.quantityOrdered > 30);
    
# 10°
SELECT *FROM products p
	WHERE p.productCode IN (SELECT o.productCode FROM orderdetails o
    WHERE o.priceEach > 100);
    
# 11°
SELECT *FROM products p
	INNER JOIN productlines pl ON pl.productLine = p.productLine;

# 12°
SELECT *FROM products p
	LEFT JOIN productlines pl ON pl.productLine = p.productLine;

# 13°
SELECT *FROM products p
	RIGHT JOIN productlines pl ON pl.productLine = p.productLine;
    
# 14° - employees que mais vendeu
SELECT COUNT(c.salesRepEmployeeNumber), e.firstName, e.lastName FROM employees e
	INNER JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
    GROUP BY c.salesRepEmployeeNumber;
    
# 15° - customers que mais comprou
SELECT c.customerName, COUNT(o.customerNumber) FROM customers c
	INNER JOIN orders o ON c.customerNumber = o.customerNumber
	GROUP BY o.customerNumber
    ORDER BY COUNT(o.customerNumber) DESC
    LIMIT 1, 1;

# 16°
SELECT c.customerName FROM customers c
UNION	
SELECT p.customerNumber FROM payments p;

# 17°
SELECT min(buypRICE) AS MenorPreco FROM products p;

# 18°
SELECT max(buypRICE) AS "Maior Preço" FROM products p;

# 19°
SELECT avg(buypRICE) AS "Media dos Preços" FROM products p;

# 20° - mes que mais vendeu
SELECT MONTH(o.orderDate), COUNT(o.orderNumber) FROM orders o
	GROUP BY month(o.orderDate)
    ORDER BY COUNT(o.orderDate) DESC
    LIMIT 1, 1
    


