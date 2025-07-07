USE Ucheb_8_Tuiev;
SELECT ProductName + '(' + Manufacturer + ')' AS  ModelName, Price,
Price * ProductCount AS TotalSum
From Products;