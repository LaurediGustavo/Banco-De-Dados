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





