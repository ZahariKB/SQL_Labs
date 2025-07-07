USE Ucheb_8_Tuiev;
SELECT ProductName  + '(' + Manufacturer + ')' AS ModuleName, Price
INTO ProductSummary FROM Products

SELECT * FROM ProductSummary;