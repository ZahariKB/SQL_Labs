USE Ucheb_8_Tuiev;

SELECT otdel,
       ISNULL(CAST(god AS VARCHAR(30)),
	             CASE WHEN GROUPING(god)=1 AND GROUPING(otdel)=0
				     THEN 'Промежутоынй итог' ELSE 'Общий итог' END) AS god,
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
(1, 'Сотрудник_1', 'Бухгалтерия', 2014, 200.00),
(2, 'Сотрудник_2', 'Бухгалтерия', 2014, 300.00),
(3, 'Сотрудник_3', 'Отдел покупок', 2014, 150.00),
(4, 'Сотрудник_4', 'Отдел покупок', 2014, 200.00),
(5, 'Сотрудник_5', 'Отдел реализации', 2014, 250.00),
(6, 'Сотрудник_6', 'Отдел реализации', 2014, 300.00),
(7, 'Сотрудник_7', 'Отдел реализации', 2014, 300.00),
(8, 'Сотрудник_1', 'Бухгалтерия', 2015, 230.00),
(9, 'Сотрудник_2', 'Бухгалтерия', 2015, 200.00),
(10, 'Сотрудник_3', 'Отдел покупок', 2015, 200.00),
(11, 'Сотрудник_4', 'Отдел покупок', 2015, 300.00),
(12, 'Сотрудник_5', 'Отдел реализации', 2015, 200.00),
(13, 'Сотрудник_6', 'Отдел реализации', 2015, 250.00),
(14, 'Сотрудник_7', 'Отдел реализации', 2015, 350.00);
CREATE TABLE  sotrud(
    id INT PRIMARY KEY,
    manager VARCHAR(50),
    otdel VARCHAR(50),
    god INT,
    summa DECIMAL(6,2)
);
