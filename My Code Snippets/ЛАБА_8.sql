-- Создание первого имени входа с ролью processadmin
CREATE LOGIN Test_name_3 WITH PASSWORD = '1326';
ALTER SERVER ROLE processadmin ADD MEMBER Test_name_3;

-- Создание второго имени входа с ролью bulkadmin
CREATE LOGIN Test_name_4 WITH PASSWORD = '1327';
ALTER SERVER ROLE bulkadmin ADD MEMBER Test_name_4;

-- Создание новой серверной роли
CREATE SERVER ROLE Role_CreateDB_AlterLogin;

-- Предоставление разрешений
GRANT CREATE ANY DATABASE TO Role_CreateDB_AlterLogin;
GRANT ALTER ANY LOGIN TO Role_CreateDB_AlterLogin;

-- Добавление Test_name в новую роль
ALTER SERVER ROLE Role_CreateDB_AlterLogin ADD MEMBER Test_name;

-- Удаление Test_name из роли dbcreator
ALTER SERVER ROLE dbcreator DROP MEMBER Test_name;

-- Сначала удаляем всех членов роли
ALTER SERVER ROLE Role_CreateDB_AlterLogin DROP MEMBER Test_name;
-- Затем удаляем саму роль
DROP SERVER ROLE Role_CreateDB_AlterLogin;


-- Удаление Test_name_4;
DROP LOGIN Test_name_4;


CREATE DATABASE TestDB;

-- Создание пользователя для Test_name
USE TestDB;
CREATE USER User_1 FOR LOGIN Test_name WITH DEFAULT_SCHEMA = dbo;

-- Создание пользователя для Test_name_2
CREATE USER User_2 FOR LOGIN Test_name_2 
WITH DEFAULT_SCHEMA = sales 


--создание схемы
go
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'sales')
BEGIN
    EXEC('CREATE SCHEMA sales');
    PRINT 'Схема sales успешно создана';
END
ELSE
    PRINT 'Схема sales уже существует';
GO

-- Создание пользовательской роли уровня БД
CREATE ROLE db_datawriter_view;
USE TestDB;
GRANT INSERT, UPDATE, DELETE ON SCHEMA::dbo TO db_datawriter_view;
GRANT SELECT ON SCHEMA::sales TO db_datawriter_view;
GRANT EXECUTE TO db_datawriter_view;


-- Добавление User_1 в роль
ALTER ROLE db_datawriter_view ADD MEMBER User_1;


USE TestDB;
-- Перед удалением пользователя нужно удалить его из всех ролей
ALTER ROLE db_datawriter_view DROP MEMBER User_1;
DROP USER User_1;


USE TestDB;
GO
CREATE SCHEMA inventory AUTHORIZATION db_datawriter_view;
GO
--Создаем таблицы
CREATE TABLE inventory.Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    Price DECIMAL(10,2),
    CategoryID INT
);
GO
CREATE TABLE inventory.Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName NVARCHAR(50)
);
GO
CREATE TABLE inventory.Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName NVARCHAR(100)
);
GO
INSERT INTO inventory.Categories VALUES (1, 'Электроника'), (2, 'Одежда');
INSERT INTO inventory.Products VALUES 
    (1, 'Ноутбук', 999.99, 1),
    (2, 'Смартфон', 499.99, 1),
    (3, 'Футболка', 19.99, 2);
GO
--Создаем представления с корректными ссылками
CREATE VIEW inventory.ExpensiveProducts AS
SELECT * FROM inventory.Products
WHERE Price > 100;
GO
CREATE VIEW inventory.ProductCategories AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Price,
    c.CategoryName 
FROM inventory.Products p
JOIN inventory.Categories c ON p.CategoryID = c.CategoryID;
GO
--Назначаем права
GRANT SELECT ON SCHEMA::inventory TO User_2;
GRANT INSERT, UPDATE ON inventory.Products TO User_1;
DENY DELETE ON inventory.Products TO User_2;
GO


USE TestDB;
-- Переназначаем владельца схемы на dbo
ALTER AUTHORIZATION ON SCHEMA::inventory TO dbo;


--При подключении как User_1
--Должно работать
INSERT INTO inventory.Products VALUES (1, 'Test', 100);
-- Должно вызвать ошибку 
DROP TABLE inventory.Products;


USE TestDB;
-- Сначала нужно удалить все объекты в схеме
DROP VIEW inventory.ProductCategories;
DROP VIEW inventory.ExpensiveProducts;
DROP TABLE inventory.Products;
DROP TABLE inventory.Categories;
DROP TABLE inventory.Suppliers;
-- Затем удалить саму схему
DROP SCHEMA inventory;


USE TestDB;
-- Создание новой роли
CREATE ROLE report_viewers;
-- Предоставление прав
GRANT SELECT ON SCHEMA::sales TO report_viewers;
-- Запрет прав
DENY INSERT, UPDATE, DELETE ON SCHEMA::sales TO report_viewers;
-- Создание пользователя 3
CREATE USER User_3 FOR LOGIN Test_name_3;
-- Добавление в роль
ALTER ROLE report_viewers ADD MEMBER User_3;
-- Отзыв прав
REVOKE SELECT ON SCHEMA::sales FROM report_viewers;


USE TestDB;
-- Добавление пользователей в db_owner
ALTER ROLE db_owner ADD MEMBER User_1;
ALTER ROLE db_owner ADD MEMBER User_2;
-- Запрет DDL для User2
DENY CREATE TABLE TO User_2;
DENY ALTER TO User_2;
-- Под User_1 это должно работать, а под User_2 должно вызывать ошибку
CREATE TABLE TestTable (ID INT);


-- Удаление ролей БД
USE TestDB;
DROP ROLE report_viewers;
DROP ROLE db_datawriter_view;

-- Удаление пользователей
DROP USER User_3;
DROP USER User_2;

-- Удаление имен входа
DROP LOGIN Test_name;
DROP LOGIN Test_name_2;
DROP LOGIN Test_name_3;

