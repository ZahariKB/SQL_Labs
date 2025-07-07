USE AdventureWorks2019;
SELECT SalesOrderID, 
       CONCAT('Order ¹', SalesOrderID, ' create ', FORMAT(OrderDate, 'yyyy-MM-dd')) AS OrderDescription
FROM Sales.SalesOrderHeader;
