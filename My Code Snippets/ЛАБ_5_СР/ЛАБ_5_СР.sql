Use Ucheb_8_Tuiev

--1
GO
CREATE VIEW AfricaCountries AS
SELECT Nazvanie, Stolica, PL, KolNas 
FROM Tabl_Kontinent$
WHERE Kontinent = 'Африка' 
  AND KolNas > 10000000 
  AND PL > 500000
GO
SELECT * FROM AfricaCountries

--2
GO
CREATE VIEW ContinentStats AS
SELECT 
    Kontinent,
    AVG(PL) AS AvgArea,
    AVG(KolNas/PL) AS AvgPopulationDensity
FROM Tabl_Kontinent$
GROUP BY Kontinent
GO
SELECT * FROM ContinentStats

USE JoinTable
GO
CREATE VIEW TeachersWithExams AS
SELECT 
    FIO AS Фамилия,
    Dolgn AS Должность,
    Zvanie AS Звание,
    Stepen AS Степень,
    Nkaf AS Кафедра,
    COUNT(E.Kod) AS КоличествоЭкзаменов
FROM Sotrudnik C
INNER JOIN Prepodavatel P ON C.TabNom = P.TabNom_Pr
INNER JOIN Kafedra K ON C.ShiftKaf_Sotr = K.ShifrKaf
LEFT JOIN Ozenka E ON P.TabNom_Pr = E.Tab_Nom
GROUP BY FIO, Dolgn, Zvanie, Stepen, Nkaf
GO
SELECT * FROM TeachersWithExams

--4
DECLARE @MonthsTable TABLE (
    НомерМесяца INT,
    НазваниеМесяца NVARCHAR(20),
    КоличествоДней INT
)

DECLARE @Year INT = YEAR(GETDATE())
DECLARE @Month INT = 1

WHILE @Month <= 12
BEGIN
    INSERT INTO @MonthsTable
    VALUES (
        @Month,
        DATENAME(MONTH, DATEFROMPARTS(@Year, @Month, 1)),
        DAY(EOMONTH(DATEFROMPARTS(@Year, @Month, 1)))
    )
    SET @Month = @Month + 1
END

SELECT * FROM @MonthsTable

--5
USE Ucheb_8_Tuiev
DECLARE @SmallCountries TABLE (
    Название NCHAR(40),
    Столица NCHAR(40),
    Площадь INT,
    Население INT,
    Континент NCHAR(20)
)

INSERT INTO @SmallCountries
SELECT 
    T1.Nazvanie,
    T1.Stolica,
    T1.PL,
    T1.KolNas,
    T1.Kontinent
FROM Tabl_Kontinent$ T1
WHERE T1.PL * 100 < (
    SELECT AVG(T2.PL) 
    FROM Tabl_Kontinent$ T2 
    WHERE T2.Kontinent = T1.Kontinent
)

SELECT * FROM @SmallCountries

--6
USE JoinTable
CREATE TABLE #WeekExams (
    НомерНедели INT,
    КоличествоЭкзаменов INT,
    КоличествоСтудентов INT
)

INSERT INTO #WeekExams
SELECT 
    DATEPART(WEEK, data) AS НомерНедели,
    COUNT(DISTINCT Kod) AS КоличествоЭкзаменов,
    COUNT(DISTINCT ReGNom) AS КоличествоСтудентов
FROM Ozenka
GROUP BY DATEPART(WEEK, data)

SELECT * FROM #WeekExams

--7
USE Ucheb_8_Tuiev
CREATE TABLE ##ContinentExtremes (
    Континент NCHAR(20),
    МаксПлощадь INT,
    МинПлощадь INT
)

INSERT INTO ##ContinentExtremes
SELECT 
    Kontinent,
    MAX(PL) AS МаксПлощадь,
    MIN(PL) AS МинПлощадь
FROM Tabl_Kontinent$
GROUP BY Kontinent

SELECT * FROM ##ContinentExtremes

--8
USE JoinTable
WITH FacultyAvgSalary AS (
    SELECT 
        K.ShifrKaf,
        AVG(C.Zarplata) AS AvgSalary
    FROM Sotrudnik C
    INNER JOIN Kafedra K ON C.ShiftKaf_Sotr = K.ShifrKaf
    GROUP BY K.ShifrKaf
)
SELECT 
    C.FIO AS Фамилия,
    C.Zarplata AS Зарплата,
    K.NKaf AS Кафедра,
    F.AvgSalary AS СредняяЗарплатаНаКафедре
FROM Sotrudnik C
INNER JOIN Kafedra K ON C.ShiftKaf_Sotr = K.ShifrKaf
INNER JOIN FacultyAvgSalary F ON K.ShifrKaf = F.ShifrKaf
WHERE C.Zarplata < F.AvgSalary

--9
DROP VIEW IF EXISTS AfricaCountries
DROP VIEW IF EXISTS ContinentStats
DROP VIEW IF EXISTS TeachersWithExams
DROP VIEW IF EXISTS PR1
DROP VIEW IF EXISTS PR2
DROP VIEW IF EXISTS PR3