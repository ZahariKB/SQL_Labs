USE Ucheb_8_Tuiev;

SELECT fio, [2011], [2012], [2013], [2015]
FROM dbo.test_table_pivot
PIVOT (sum(summa) FOR god IN ([2011], [2012], [2013], [2015])
) AS test_pivot;
INSERT INTO test_table_pivot (fio, god, summa) VALUES
('������ �.�.', 2011, 200),
('������ �.�.', 2011, 500),
('������ �.�.', 2012, 300),
('������ �.�.', 2012, 600),
('������ �.�.', 2013, 900),
('������ �.�.', 2014, 500),
('������ �.�.', 2014, 300),
('������ �.�.', 2015, 100),
('������ �.�.', 2011, 100),
('������ �.�.', 2012, 200),
('������ �.�.', 2012, 300),
('������ �.�.', 2013, 100),
('������ �.�.', 2014, 300),
('������ �.�.', 2014, 100),
('������� �.�.', 2012, 100),
('������� �.�.', 2013, 1000),
('������� �.�.', 2014, 500),
('������� �.�.', 2014, 300),
('������� �.�.', 2015, 300);
CREATE TABLE test_table_pivot(
 fio varchar(50) NULL,
 god int NULL,
 summa float NULL
 );
SELECT predmet + ' - ' + fio + ' - ' + ush AS ����������
FROM Table_uch1;
SELECT predmet,
AVG(CASE WHEN ush = '�����' THEN ball END) AS �����,
    AVG(CASE WHEN ush = '��������' THEN ball END) AS ��������
FROM Table_uch1
GROUP BY predmet;
SELECT ush, AVG(ball) AS average
FROM Table_uch1
GROUP BY ush;
SELECT fio, [������� ��� �����]
FROM Table_uch1
UNPIVOT ([������� ��� �����] 
FOR �������� IN (ush, predmet)) unpvt;
SELECT ush ,���������� ,������ ,�����
FROM
   (SELECT
    ush, predmet, fio
	FROM Table_uch1
   ) AS SOURCE_TABLE
   PIVOT
   (COUNT(fio)
    FOR predmet IN (����������, ������, �����)
   )AS PIVOT_TABLE;
SELECT '����������' AS [���������� �������� �� ���������]
  ,����������
  ,������
  ,�����
FROM
   (SELECT predmet, fio
	FROM Table_uch1
   ) AS SOURCE_TABLE
   PIVOT
   (COUNT(fio) FOR predmet IN (����������, ������, �����)
   ) AS PIVOT_TABLE; 
