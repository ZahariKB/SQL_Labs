-- �������� ������� ����� ����� � ����� processadmin
CREATE LOGIN Test_name_3 WITH PASSWORD = '1326';
ALTER SERVER ROLE processadmin ADD MEMBER Test_name_3;

-- �������� ������� ����� ����� � ����� bulkadmin
CREATE LOGIN Test_name_4 WITH PASSWORD = '1327';
ALTER SERVER ROLE bulkadmin ADD MEMBER Test_name_4;

-- �������� ����� ��������� ����
CREATE SERVER ROLE Role_CreateDB_AlterLogin;

-- �������������� ����������
GRANT CREATE ANY DATABASE TO Role_CreateDB_AlterLogin;
GRANT ALTER ANY LOGIN TO Role_CreateDB_AlterLogin;

-- ���������� Test_name � ����� ����
ALTER SERVER ROLE Role_CreateDB_AlterLogin ADD MEMBER Test_name;

-- �������� Test_name �� ���� dbcreator
ALTER SERVER ROLE dbcreator DROP MEMBER Test_name;

-- ������� ������� ���� ������ ����
ALTER SERVER ROLE Role_CreateDB_AlterLogin DROP MEMBER Test_name;
-- ����� ������� ���� ����
DROP SERVER ROLE Role_CreateDB_AlterLogin;


-- �������� Test_name_4;
DROP LOGIN Test_name_4;


CREATE DATABASE TestDB;

-- �������� ������������ ��� Test_name
USE TestDB;
CREATE USER User_1 FOR LOGIN Test_name WITH DEFAULT_SCHEMA = dbo;

-- �������� ������������ ��� Test_name_2
CREATE USER User_2 FOR LOGIN Test_name_2 
WITH DEFAULT_SCHEMA = sales 


--�������� �����
go
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'sales')
BEGIN
    EXEC('CREATE SCHEMA sales');
    PRINT '����� sales ������� �������';
END
ELSE
    PRINT '����� sales ��� ����������';
GO

-- �������� ���������������� ���� ������ ��
CREATE ROLE db_datawriter_view;
USE TestDB;
GRANT INSERT, UPDATE, DELETE ON SCHEMA::dbo TO db_datawriter_view;
GRANT SELECT ON SCHEMA::sales TO db_datawriter_view;
GRANT EXECUTE TO db_datawriter_view;


-- ���������� User_1 � ����
ALTER ROLE db_datawriter_view ADD MEMBER User_1;


USE TestDB;
-- ����� ��������� ������������ ����� ������� ��� �� ���� �����
ALTER ROLE db_datawriter_view DROP MEMBER User_1;
DROP USER User_1;


USE TestDB;
GO
CREATE SCHEMA inventory AUTHORIZATION db_datawriter_view;
GO
--������� �������
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
INSERT INTO inventory.Categories VALUES (1, '�����������'), (2, '������');
INSERT INTO inventory.Products VALUES 
    (1, '�������', 999.99, 1),
    (2, '��������', 499.99, 1),
    (3, '��������', 19.99, 2);
GO
--������� ������������� � ����������� ��������
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
--��������� �����
GRANT SELECT ON SCHEMA::inventory TO User_2;
GRANT INSERT, UPDATE ON inventory.Products TO User_1;
DENY DELETE ON inventory.Products TO User_2;
GO


USE TestDB;
-- ������������� ��������� ����� �� dbo
ALTER AUTHORIZATION ON SCHEMA::inventory TO dbo;


--��� ����������� ��� User_1
--������ ��������
INSERT INTO inventory.Products VALUES (1, 'Test', 100);
-- ������ ������� ������ 
DROP TABLE inventory.Products;


USE TestDB;
-- ������� ����� ������� ��� ������� � �����
DROP VIEW inventory.ProductCategories;
DROP VIEW inventory.ExpensiveProducts;
DROP TABLE inventory.Products;
DROP TABLE inventory.Categories;
DROP TABLE inventory.Suppliers;
-- ����� ������� ���� �����
DROP SCHEMA inventory;


USE TestDB;
-- �������� ����� ����
CREATE ROLE report_viewers;
-- �������������� ����
GRANT SELECT ON SCHEMA::sales TO report_viewers;
-- ������ ����
DENY INSERT, UPDATE, DELETE ON SCHEMA::sales TO report_viewers;
-- �������� ������������ 3
CREATE USER User_3 FOR LOGIN Test_name_3;
-- ���������� � ����
ALTER ROLE report_viewers ADD MEMBER User_3;
-- ����� ����
REVOKE SELECT ON SCHEMA::sales FROM report_viewers;


USE TestDB;
-- ���������� ������������� � db_owner
ALTER ROLE db_owner ADD MEMBER User_1;
ALTER ROLE db_owner ADD MEMBER User_2;
-- ������ DDL ��� User2
DENY CREATE TABLE TO User_2;
DENY ALTER TO User_2;
-- ��� User_1 ��� ������ ��������, � ��� User_2 ������ �������� ������
CREATE TABLE TestTable (ID INT);


-- �������� ����� ��
USE TestDB;
DROP ROLE report_viewers;
DROP ROLE db_datawriter_view;

-- �������� �������������
DROP USER User_3;
DROP USER User_2;

-- �������� ���� �����
DROP LOGIN Test_name;
DROP LOGIN Test_name_2;
DROP LOGIN Test_name_3;

