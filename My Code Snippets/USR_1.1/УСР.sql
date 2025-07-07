USE Ucheb_8_Tuiev;

SELECT COALESCE(ush, 'Итого по всем школам') AS school, 
COALESCE(predmet, 'Итого по всем предметам') AS predmet, 
MAX(ball) AS max
FROM Table_uch1
GROUP BY ush, predmet WITH ROLLUP;
SELECT COALESCE(ush, 'Итого по всем школам') AS school, 
    COALESCE(predmet, 'Итого по всем предметам') AS predmet, 
    SUM(ball) AS summ
FROM Table_uch1
GROUP BY ush, predmet WITH ROLLUP;
SELECT COALESCE(ush, 'Итого по всем школам') AS school, 
    COALESCE(predmet, 'Итого по всем предметам') AS predmet, 
    COUNT(*) AS kol
FROM Table_uch1
GROUP BY ush, predmet WITH ROLLUP;
SELECT ush, predmet, AVG(ball) AS average
FROM Table_uch1
GROUP BY ush, predmet;
SELECT ush, predmet, MIN(ball) AS minimum
FROM Table_uch1
GROUP BY ush, predmet WITH ROLLUP;
SELECT ush, predmet, MAX(ball) AS max
FROM Table_uch1
GROUP BY ush, predmet WITH CUBE;

SELECT CASE GROUPING_ID(predmet, ush)
WHEN 1 THEN 'Итого по предмету'
WHEN 3 THEN 'Итого'
ELSE ''
END AS Итого
,ISNULL(predmet, '') AS Predmet
,ISNULL(ush, '') AS Ush
,COUNT(fio) AS kol
FROM Table_uch1
GROUP BY ROLLUP(predmet, ush);
SELECT IIF(GROUPING(predmet)=1, 'ИТОГО', predmet) AS Predmet,
IIF(GROUPING(ush)=1, 'ИТОГО', ush) AS Ush,
COUNT(fio) AS kol
FROM Table_uch1
GROUP BY CUBE(predmet, ush);
SELECT COALESCE(predmet, 'ИТОГО') AS predmet,
COALESCE(ush, 'ИТОГО') AS ush,
COUNT(fio) AS kol
FROM Table_uch1 
GROUP BY ROLLUP(predmet, ush)
SELECT COALESCE(predmet, 'ИТОГО') AS predmet,
COALESCE(ush, 'ИТОГО') AS ush,
COUNT(fio) AS kol
FROM Table_uch1 
GROUP BY ROLLUP(predmet, ush)
SELECT predmet, ush, COUNT(fio) AS kol FROM Table_uch1
GROUP BY GROUPING SETS(predmet,ush)
SELECT predmet, ush, COUNT(fio) AS kol FROM Table_uch1
GROUP BY predmet, ush WITH CUBE
SELECT predmet, ush, COUNT(fio) AS kol FROM Table_uch1
GROUP BY predmet, ush
SELECT predmet, ush, COUNT(FIO) AS kol FROM Table_uch1
GROUP BY predmet, ush WITH ROLLUP
SELECT predmet, ush, COUNT(FIO) AS kol FROM Table_uch1
GROUP BY predmet, ush
