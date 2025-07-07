USE Ucheb_8_Tuiev;

SELECT fio, [2011], [2012], [2013], [2015]
FROM dbo.test_table_pivot
PIVOT (sum(summa) FOR god IN ([2011], [2012], [2013], [2015])
) AS test_pivot;
INSERT INTO test_table_pivot (fio, god, summa) VALUES
('Иванов И.И.', 2011, 200),
('Иванов И.И.', 2011, 500),
('Иванов И.И.', 2012, 300),
('Иванов И.И.', 2012, 600),
('Иванов И.И.', 2013, 900),
('Иванов И.И.', 2014, 500),
('Иванов И.И.', 2014, 300),
('Иванов И.И.', 2015, 100),
('Петров П.П.', 2011, 100),
('Петров П.П.', 2012, 200),
('Петров П.П.', 2012, 300),
('Петров П.П.', 2013, 100),
('Петров П.П.', 2014, 300),
('Петров П.П.', 2014, 100),
('Сидоров С.С.', 2012, 100),
('Сидоров С.С.', 2013, 1000),
('Сидоров С.С.', 2014, 500),
('Сидоров С.С.', 2014, 300),
('Сидоров С.С.', 2015, 300);
CREATE TABLE test_table_pivot(
 fio varchar(50) NULL,
 god int NULL,
 summa float NULL
 );
SELECT predmet + ' - ' + fio + ' - ' + ush AS Информация
FROM Table_uch1;
SELECT predmet,
AVG(CASE WHEN ush = 'лицей' THEN ball END) AS лицей,
    AVG(CASE WHEN ush = 'гимназия' THEN ball END) AS гимназия
FROM Table_uch1
GROUP BY predmet;
SELECT ush, AVG(ball) AS average
FROM Table_uch1
GROUP BY ush;
SELECT fio, [Предмет или школа]
FROM Table_uch1
UNPIVOT ([Предмет или школа] 
FOR Значения IN (ush, predmet)) unpvt;
SELECT ush ,Математика ,Физика ,Химия
FROM
   (SELECT
    ush, predmet, fio
	FROM Table_uch1
   ) AS SOURCE_TABLE
   PIVOT
   (COUNT(fio)
    FOR predmet IN (Математика, Физика, Химия)
   )AS PIVOT_TABLE;
SELECT 'Количество' AS [Количество учеников по предметам]
  ,Математика
  ,Физика
  ,Химия
FROM
   (SELECT predmet, fio
	FROM Table_uch1
   ) AS SOURCE_TABLE
   PIVOT
   (COUNT(fio) FOR predmet IN (Математика, Физика, Химия)
   ) AS PIVOT_TABLE; 
