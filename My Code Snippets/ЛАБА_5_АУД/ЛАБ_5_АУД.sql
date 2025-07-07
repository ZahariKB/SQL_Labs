USE JoinTable


SELECT TOP (1000) [ShifrKaf], [NKaf], [AbFaK_Kaf] FROM 
JoinTable.dbo.Kafedra

CREATE TABLE ##PR7
(
�������� VARCHAR(50),
���������  FLOAT
)
INSERT INTO ##PR7 (��������, ���������)
	SELECT Nazvanie, ROUND(KolNas / PL, 0) AS ���������
	FROM Tabl_Kontinent$ 
	SELECT * FROM ##PR7

SELECT DATENAME(MONTH, data) AS ��������������, Count(DISTINCT Kod) AS �������������������, COUNT(DISTINCT ReGNom) AS ������������������� 
INTO #PR6 FROM Ozenka 
GROUP  BY DATENAME(MONTH, data)
SELECT * FROM #PR6


DECLARE @PR5 TABLE (
�������� NCHAR(40),
������� NCHAR(40),
������� INT,
��������� INT,
��������� NCHAR(20)
)
INSERT INTO @PR5
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent 
FROM Tabl_Kontinent$
WHERE PL * 1000 < (SELECT AVG(PL) FROM Tabl_Kontinent$)
SELECT
	��������,
	�������,
	�������,
	���������, 
	���������
	FROM @PR5


DECLARE @PR4 TABLE
( 
	����������� INT,
	���������� DATE,
	��������� DATE
)
DECLARE @T AS DATE, @N INT = 1
SET @T = CAST(YEAR(GETDATE()) AS CHAR(4)) + '0101'
WHILE DATEPART(WEEKDAY, @T) > 1
SET @T = DATEADD(DAY,-1,@T)
PRINT DATEPART(WEEK,@T)
WHILE YEAR(@T) < YEAR(DATEADD(YEAR,1,GETDATE()))
BEGIN
	INSERT
		@PR4
	VALUES
		(@N,@T,DATEADD(DAY,6,@T))

	SET @T = DATEADD(DAY,6,@T)
	SET @N = @N + 1
END
SELECT 
	�����������,
	����������,
	���������
	FROM @PR4

GO
Create VIEW PR3 (
	�������, ���������, ������, �������, �������, �������� )
AS SELECT FIO, Dolgn, Zvanie, Stepen, Nkaf, Zarplata FROM Sotrudnik C
INNER JOIN Prepodavatel P ON C.TabNom = P.TabNom_Pr
INNER JOIN Kafedra K ON C.ShiftKaf_Sotr = K.ShifrKaf
GO
SELECT 
�������, ���������, ������, �������, �������, �������� FROM PR3



go 
CREATE VIEW PR2
(
	Kontinent, PL, KolNas
)
AS
SELECT 
	Kontinent, SUM(PL), SUM(KolNas)
FROM Tabl_Kontinent$
GROUP BY Kontinent
GO

SELECT Kontinent, PL, KolNas FROM PR2


go
Create view PR1
AS 
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent FROM 
Tabl_Kontinent$ 
WHERE KolNas < 5000000
AND PL > 100000
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent FROM
PR1