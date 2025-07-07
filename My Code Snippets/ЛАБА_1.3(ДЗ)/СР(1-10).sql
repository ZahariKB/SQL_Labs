USE Ucheb_8_Tuiev;

SELECT * FROM Products 
WHERE Manufacturer = 'Samsung';
SELECT * FROM Products 
WHERE Price > 45000;
SELECT * FROM Products 
WHERE Price * ProductCount > 200000;
SELECT * FROM Products 
WHERE Manufacturer = 'Samsung' AND Price > 50000;
SELECT * FROM Products 
WHERE Manufacturer = 'Samsung' OR Price > 50000;
SELECT * FROM Products 
WHERE Manufacturer != 'Samsung';
SELECT * FROM Products 
WHERE (ProductCount > 2 AND Price > 30000) OR Manufacturer = 'Samsung';
SELECT * FROM Products 
WHERE Manufacturer IN ('Samsung', 'Xiaomi', 'Huawei');
SELECT * FROM Products 
WHERE Price BETWEEN 20000 AND 40000;
SELECT * FROM Products 
WHERE Price * ProductCount BETWEEN 100000 AND 200000;