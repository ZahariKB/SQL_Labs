USE Ucheb_8_Tuiev;

SELECT COALESCE(ush, '����� �� ���� ������') AS school, 
COALESCE(predmet, '����� �� ���� ���������') AS predmet, 
MAX(ball) AS max
FROM Table_uch1
GROUP BY ush, predmet WITH ROLLUP;
SELECT COALESCE(ush, '����� �� ���� ������') AS school, 
    COALESCE(predmet, '����� �� ���� ���������') AS predmet, 
    SUM(ball) AS summ
FROM Table_uch1
GROUP BY ush, predmet WITH ROLLUP;
SELECT COALESCE(ush, '����� �� ���� ������') AS school, 
    COALESCE(predmet, '����� �� ���� ���������') AS predmet, 
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
WHEN 1 THEN '����� �� ��������'
WHEN 3 THEN '�����'
ELSE ''
END AS �����
,ISNULL(predmet, '') AS Predmet
,ISNULL(ush, '') AS Ush
,COUNT(fio) AS kol
FROM Table_uch1
GROUP BY ROLLUP(predmet, ush);
SELECT IIF(GROUPING(predmet)=1, '�����', predmet) AS Predmet,
IIF(GROUPING(ush)=1, '�����', ush) AS Ush,
COUNT(fio) AS kol
FROM Table_uch1
GROUP BY CUBE(predmet, ush);
SELECT COALESCE(predmet, '�����') AS predmet,
COALESCE(ush, '�����') AS ush,
COUNT(fio) AS kol
FROM Table_uch1 
GROUP BY ROLLUP(predmet, ush)
SELECT COALESCE(predmet, '�����') AS predmet,
COALESCE(ush, '�����') AS ush,
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
