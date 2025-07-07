USE Himchistka;

--1)������ ��������� ������ � ������ ��� ������ �� ���� ������, ����������� �� �
--������� ��� ���������� ����� ��� ���� ��������� ���������� ���������
--�������� ����� �� ������� ������;
SELECT DISTINCT * FROM Client;
SELECT DISTINCT * FROM Orders;
SELECT DISTINCT * FROM Item;

--2)�������� ������, ����������� � � ����
USE Himchistka;
SELECT * FROM Orders
WHERE YEAR(date) = 2019;


--3)��������� ���������� �������, ���������� ��� ������� � ���� Y. 
USE Himchistka;
SELECT COUNT(DISTINCT Orders.order_id) AS TotalOrders FROM Orders
JOIN Item
ON Orders.order_id = Item.order_id
WHERE Item.cleaning_type = '���������' AND Item.type = '������';


--4)��������� ����� ���������� ������� ��� ������� �������. 
USE Himchistka;
SELECT name AS ClientName, COUNT(order_id) AS TotalOrders FROM Client
JOIN Orders ON Client.client_id = Orders.client_id
GROUP BY name;


--5)����� ����� ���� �������, ��������� ��������� �� �������� �������� �
USE Himchistka;
SELECT SUM(Item.cost) AS TotalCost FROM Client
JOIN Orders
ON Client.client_id = Orders.client_id
JOIN Item
ON Orders.order_id = Item.order_id
WHERE Client.importance = 7;


--6)�������� ��������, ������� ����� ������� �������� � � �������� ����� Y
--�������
USE Himchistka;
SELECT Client.name AS ClientName, COUNT(Orders.order_id) AS TotalOrders FROM Client
JOIN Orders ON Client.client_id = Orders.client_id
WHERE Client.importance = 7
GROUP BY Client.name
HAVING COUNT(Orders.order_id) > 0;
 

--*)�������� ������
CREATE TABLE Client (
    client_id INT PRIMARY KEY, 
    name NVARCHAR(100) NOT NULL, 
    address NVARCHAR(200),
    contact NVARCHAR(50), 
    importance NVARCHAR(50) NOT NULL --������� ��������
);
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    client_id INT NOT NULL, 
    date DATE NOT NULL, 
    discount DECIMAL(5,2), 
    execution_date DATE, 
    actual_date DATE, 
    FOREIGN KEY (client_id) REFERENCES Client(client_id) 
);
CREATE TABLE Item (
    item_id INT PRIMARY KEY, 
    order_id INT NOT NULL, 
    type NVARCHAR(50) NOT NULL,
    description NVARCHAR(200), 
    dirtiness NVARCHAR(50), 
    cleaning_type NVARCHAR(50) NOT NULL, 
    cost DECIMAL(10,2) NOT NULL, 
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) 
);

--���������� ������ ������� 
INSERT INTO Item (item_id, order_id, type, description, dirtiness, cleaning_type, cost) VALUES
(1, 1, '������', '������ ������, ������ 50', '������� �����������', '���������', 25.00),
(2, 1, '�������', '����� �������, ������ 42', '������ �����������', '���������', 15.00),
(3, 2, '������', '������� ������, ������ 46', '�����', '���������', 30.00),
(4, 3, '������', '������� ������, ������ L', '������� �����������', '���������', 35.00),
(5, 4, '������', '����� ������, ������ 32', '������ �����������', '���������', 20.00),
(6, 5, '����', '����� ����', '�����', '���������', 10.00);




