USE AdventureWorks2019;
SELECT SalesOrderID, 
       CONCAT('Order �', SalesOrderID, ' create ', FORMAT(OrderDate, 'yyyy-MM-dd')) AS OrderDescription
FROM Sales.SalesOrderHeader;
