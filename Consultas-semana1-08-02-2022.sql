use classicmodels;

# 1° - Compradores
SELECT *FROM customers; 

# 2° - Comprador de determinado estado
SELECT *FROM customers c 
	WHERE c.state like 'NY';

# 3° - Lista de quantidades compradas por país
SELECT COUNT(c.customerNumber), c.country FROM customers c 
	GROUP BY c.country;

# 4° - Lista de quantidades compradas por país ordenados
SELECT COUNT(c.customerNumber), c.country FROM customers c 
	GROUP BY c.country 
	ORDER BY COUNT(c.customerNumber) DESC;

# 5° - Paises com mais de 10 compradores
SELECT COUNT(c.customerNumber), c.country FROM customers c 
	GROUP BY c.country 
    HAVING COUNT(c.customerNumber) > 10
    ORDER BY COUNT(c.customerNumber) DESC;

# 6° - Funcionário que são do escritório de Boston
SELECT *FROM employees e
	WHERE e.officeCode = (SELECT o.officeCode FROM offices o
    WHERE o.city LIKE 'Boston');
    
# 7° - Funcionários que venderam o produto de código x
SELECT * FROM customers c
	WHERE c.customerNumber IN (SELECT o.customerNumber FROM orders o
	WHERE o.orderNumber IN (SELECT od.orderNumber FROM orderdetails od
    WHERE od.productCode LIKE 'S10_1678'));

# 8° - Produtos com o preço entre 10 e 100
SELECT * FROM products p
	WHERE p.buyPrice BETWEEN 10 AND 100;

# 9° - Produtos com mais de 30 compras
SELECT *FROM products p
	WHERE p.productCode IN (SELECT o.productCode FROM orderdetails o
    WHERE o.quantityOrdered > 30);
    
# 10° - Compras maiores que 100
SELECT *FROM products p
	WHERE p.productCode IN (SELECT o.productCode FROM orderdetails o
    WHERE o.priceEach > 100);
    
# 11° - Utilizando INNER JOIN
SELECT *FROM products p
	INNER JOIN productlines pl ON pl.productLine = p.productLine;

# 12° - Utilizando LEFT JOIN
SELECT *FROM products p
	LEFT JOIN productlines pl ON pl.productLine = p.productLine;

# 13° - Utilizando RIGHT JOIN
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

# 16° - União de duas tabelas
SELECT c.customerName FROM customers c
UNION	
SELECT p.customerNumber FROM payments p;

# 17° - Produto mais barato
SELECT min(buypRICE) AS MenorPreco FROM products p;

# 18° - Produto mais caro
SELECT max(buypRICE) AS "Maior Preço" FROM products p;

# 19° - Média dos preços dos produtos
SELECT avg(buypRICE) AS "Media dos Preços" FROM products p;

# 20° - mes que mais vendeu
SELECT MONTH(o.orderDate), COUNT(o.orderNumber) FROM orders o
	GROUP BY month(o.orderDate)
    ORDER BY COUNT(o.orderDate) DESC
    LIMIT 1, 1;

# 21° - cidade com mais compras
SELECT c.city, COUNT(ol.productCode) FROM customers c
	INNER JOIN orders o ON c.customerNumber = o.customerNumber
    INNER JOIN orderdetails ol ON o.orderNumber = ol.orderNumber
	GROUP BY c.city
    ORDER BY COUNT(ol.productCode) DESC;

# 22° - Funcionario que mais vendeu no mes
SELECT e.firstName, e.lastName, o.requiredDate, COUNT(e.employeeNumber) FROM classicmodels.employees e
	INNER JOIN classicmodels.customers c ON c.salesRepEmployeeNumber = e.employeeNumber
    INNER JOIN classicmodels.orders o ON o.customerNumber = c.customerNumber
    WHERE month(o.requiredDate) = 5
    GROUP BY e.employeeNumber
    ORDER BY COUNT(e.employeeNumber) DESC;
    
# 23° - Cidade com mais funcionarios
SELECT o.city, COUNT(e.officeCode) FROM classicmodels.offices o
	INNER JOIN classicmodels.employees e ON e.officeCode = o.officeCode
    GROUP BY e.officeCode
    ORDER BY COUNT(e.officeCode) DESC;
    
# 24° - Mes que mais entrou dinheiro
SELECT month(p.paymentDate), SUM(p.amount) FROM classicmodels.payments p
	WHERE month(p.paymentDate) = 2
    GROUP BY month(p.paymentDate);
    
# 25° - Produto que nao foi vendido
SELECT *FROM classicmodels.products p
	WHERE p.productCode NOT IN (SELECT o.productCode FROM classicmodels.orderdetails o);
    
# 26° - Funcionários que trabalham no escritório de NY
SELECT *FROM classicmodels.employees e
	WHERE e.officeCode IN (SELECT o.officeCode FROM classicmodels.offices o
    WHERE o.state LIKE '%NY%');
    
# 27° - Produto com a maior escala
SELECT MAX(p1.productScale), p1.productName FROM classicmodels.products p1;

# 28° - Escritório com dois endereços preenchidos
SELECT *FROM classicmodels.offices o 
	WHERE o.addressLine1 IS NOT NULL AND
    o.addressLine2 IS NOT NULL;
    
# 29° - comprador que mais gastou
SELECT c.customerName, SUM(p.amount) FROM classicmodels.customers c 
	INNER JOIN classicmodels.payments p 
		ON p.customerNumber = c.customerNumber
		GROUP BY p.customerNumber
		ORDER BY SUM(p.amount) DESC
		LIMIT 10;

# 30° - Compradores com a mesma cidade do escritório
SELECT *FROM classicmodels.customers c
	INNER JOIN classicmodels.employees e
	ON e.employeeNumber = c.salesRepEmployeeNumber
		INNER JOIN classicmodels.offices o
		ON o.officeCode = e.officeCode
			WHERE c.city = o.city
        
    


