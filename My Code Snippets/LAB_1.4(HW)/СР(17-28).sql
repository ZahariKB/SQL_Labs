USE Ucheb_8_Tuiev;

SELECT Kontinent
FROM Tabl_Kontinent$
WHERE KolNas > 1000000
GROUP BY Kontinent
HAVING AVG(CAST(KolNas AS FLOAT) / PL) > 30;
SELECT AVG(LEN(Nazvanie)) AS AvgNameLength
FROM Tabl_Kontinent$
WHERE Kontinent = 'Африка';
SELECT Kontinent
FROM Tabl_Kontinent$
GROUP BY Kontinent
HAVING MAX(PL) / MIN(PL) <= 10000;
SELECT Kontinent, SUM(KolNas * 1.1) AS PredictedPopulation
FROM Tabl_Kontinent$
GROUP BY Kontinent;
SELECT LEN(Nazvanie) AS NameLength, COUNT(*) AS CountryCount
FROM Tabl_Kontinent$
GROUP BY LEN(Nazvanie)
ORDER BY CountryCount DESC;
SELECT Kontinent, COUNT(*) AS CountryCount
FROM Tabl_Kontinent$
WHERE KolNas > 100000000
GROUP BY Kontinent
ORDER BY CountryCount;
SELECT CAST(MAX(PL) AS FLOAT) / MIN(PL) AS AreaRatio
FROM Tabl_Kontinent$;
SELECT COUNT(DISTINCT Kontinent) AS ContinentCount
FROM Tabl_Kontinent$
WHERE Nazvanie LIKE 'Р%';
SELECT COUNT(*) AS CountryCount
FROM Tabl_Kontinent$
WHERE Nazvanie LIKE '%ан%'
  AND Nazvanie NOT LIKE '%стан%';
SELECT ROUND(AVG(CAST(KolNas AS FLOAT)), 1) AS AvgPopulation
FROM Tabl_Kontinent$;
SELECT Nazvanie, KolNas
FROM Tabl_Kontinent$
WHERE Kontinent IN ('Северная Америка', 'Южная Америка')
AND KolNas = (SELECT MAX(KolNas) FROM Tabl_Kontinent$
WHERE Kontinent IN ('Северная Америка', 'Южная Америка'));
SELECT MIN(PL) AS MinArea
FROM Tabl_Kontinent$;
