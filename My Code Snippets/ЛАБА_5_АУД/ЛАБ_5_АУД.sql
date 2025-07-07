USE JoinTable


SELECT TOP (1000) [ShifrKaf], [NKaf], [AbFaK_Kaf] FROM 
JoinTable.dbo.Kafedra

CREATE TABLE ##PR7
(
Название VARCHAR(50),
Плотность  FLOAT
)
INSERT INTO ##PR7 (Название, Плотность)
	SELECT Nazvanie, ROUND(KolNas / PL, 0) AS Плотность
	FROM Tabl_Kontinent$ 
	SELECT * FROM ##PR7

SELECT DATENAME(MONTH, data) AS Названиемесяца, Count(DISTINCT Kod) AS Количествоэкзаменов, COUNT(DISTINCT ReGNom) AS Количествостудентов 
INTO #PR6 FROM Ozenka 
GROUP  BY DATENAME(MONTH, data)
SELECT * FROM #PR6


DECLARE @PR5 TABLE (
Название NCHAR(40),
Столица NCHAR(40),
Площадь INT,
Население INT,
Континент NCHAR(20)
)
INSERT INTO @PR5
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent 
FROM Tabl_Kontinent$
WHERE PL * 1000 < (SELECT AVG(PL) FROM Tabl_Kontinent$)
SELECT
	Название,
	Столица,
	Площадь,
	Население, 
	Континент
	FROM @PR5


DECLARE @PR4 TABLE
( 
	Номернедели INT,
	Датаначала DATE,
	Датаконца DATE
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
	Номернедели,
	Датаначала,
	Датаконца
	FROM @PR4

GO
Create VIEW PR3 (
	Фамилия, Должность, Звание, Степень, Кафедра, Зарплата )
AS SELECT FIO, Dolgn, Zvanie, Stepen, Nkaf, Zarplata FROM Sotrudnik C
INNER JOIN Prepodavatel P ON C.TabNom = P.TabNom_Pr
INNER JOIN Kafedra K ON C.ShiftKaf_Sotr = K.ShifrKaf
GO
SELECT 
Фамилия, Должность, Звание, Степень, Кафедра, Зарплата FROM PR3



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