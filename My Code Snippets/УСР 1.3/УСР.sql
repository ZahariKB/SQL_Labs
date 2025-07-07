USE Ucheb_8_Tuiev;

SELECT otdel,
       ISNULL(CAST(god AS VARCHAR(30)),
	             CASE WHEN GROUPING(god)=1 AND GROUPING(otdel)=0
				     THEN '������������ ����' ELSE '����� ����' END) AS god,
	   SUM(summa) AS itog,
	   GROUPING(otdel) AS grouping_otdel,
	   GROUPING(god) AS grouping_god
	FROM sotrud
GROUP BY ROLLUP (otdel, god)
SELECT otdel, god, SUM(summa) AS summ FROM sotrud
GROUP BY GROUPING SETS (
    (otdel, god),  
    (otdel),       
    (god),         
    ()
);
SELECT otdel, god, SUM(summa) AS summ FROM sotrud
GROUP BY otdel, god WITH CUBE;
SELECT god, SUM(summa) AS total_salary FROM sotrud
GROUP BY god WITH ROLLUP;
SELECT otdel, SUM(summa) AS summ FROM sotrud
GROUP BY otdel WITH ROLLUP;
SELECT otdel, god, SUM(summa) AS summ FROM sotrud
GROUP BY otdel, god WITH ROLLUP;
SELECT otdel, god, SUM(summa) AS summ FROM sotrud
GROUP BY otdel, god;
INSERT INTO sotrud (id, manager, otdel, god, summa) VALUES
(1, '���������_1', '�����������', 2014, 200.00),
(2, '���������_2', '�����������', 2014, 300.00),
(3, '���������_3', '����� �������', 2014, 150.00),
(4, '���������_4', '����� �������', 2014, 200.00),
(5, '���������_5', '����� ����������', 2014, 250.00),
(6, '���������_6', '����� ����������', 2014, 300.00),
(7, '���������_7', '����� ����������', 2014, 300.00),
(8, '���������_1', '�����������', 2015, 230.00),
(9, '���������_2', '�����������', 2015, 200.00),
(10, '���������_3', '����� �������', 2015, 200.00),
(11, '���������_4', '����� �������', 2015, 300.00),
(12, '���������_5', '����� ����������', 2015, 200.00),
(13, '���������_6', '����� ����������', 2015, 250.00),
(14, '���������_7', '����� ����������', 2015, 350.00);
CREATE TABLE  sotrud(
    id INT PRIMARY KEY,
    manager VARCHAR(50),
    otdel VARCHAR(50),
    god INT,
    summa DECIMAL(6,2)
);
