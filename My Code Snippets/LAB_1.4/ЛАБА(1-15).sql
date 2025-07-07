USE Ucheb_8_Tuiev;

SELECT Kontinent, AVG(CAST(KolNas AS FLOAT) / PL) AS Plotn
FROM Tabl_Kontinent$
WHERE Pl > 1000000
GROUP BY Kontinent 
HAVING AVG(CAST(KolNas AS FLOAT) / PL) > 10
ORDER BY Plotn DESC;
SELECT MAX(LEN(Nazvanie)) AS Дл_Название,
MAX(LEN(Stolica)) AS Дл_Столица,
MIN(LEN(Nazvanie)) AS Кр_Название,
MIN(LEN(Stolica)) AS Кр_Столица  FROM Tabl_Kontinent$;
SELECT COUNT(*) AS KolNas FROM Tabl_Kontinent$
WHERE Stolica IS NULL
SELECT  Kontinent FROM Tabl_Kontinent$
GROUP BY Kontinent
HAVING MAX(Cast(KolNas AS FLOAT)) <= 1000 * MIN(Cast(KolNas AS FLOAT));
SELECT Kontinent, CASE WHEN Kontinent IN ('Европа','Азия') 
THEN FLOOR(SUM(KolNas) *  1.2)
WHEN Kontinent IN ('Северная Америка','Африка')
THEN FLOOR(SUM(KolNas) * 1.5)
ELSE FLOOR(SUM(KolNas) * 1.7)
END AS Sum_Nas
FROM Tabl_Kontinent$
GROUP BY Kontinent;
SELECT Kontinent, AVG(CAST(KolNas AS FLOAT) / PL) AS SR_Plont FROM Tabl_Kontinent$
GROUP BY Kontinent 
HAVING AVG(CAST(KolNas AS FLOAT) / PL) > 100;
SELECT  LEFT(Nazvanie, 1) AS PerV_BV, 
COUNT(Nazvanie) AS Kol_Stran FROM Tabl_Kontinent$
GROUP BY LEFT(Nazvanie,1)
ORDER BY PerV_BV;
SELECT Kontinent, Count(Nazvanie) AS Kol_Stran FROM  Tabl_Kontinent$
GROUP BY Kontinent
ORDER BY Kol_Stran DESC;
SELECT MAX(KolNas) - MIN(KolNas)
AS Razn FROM Tabl_Kontinent$;
SELECT COUNT(DISTINCT Kontinent)
AS Кол_Kontinent FROM Tabl_Kontinent$;
SELECT  COUNT(*) AS Kol FROM Tabl_Kontinent$
WHERE LEFT(Nazvanie, 1) = 'С';
SELECT ROUND(AVG(CAST(KolNas AS FLOAT)),2)
AS SR_KolNas FROM Tabl_Kontinent$
WHERE Kontinent != 'Европа'
SELECT 
SUM(KolNas) AS sum_KolNas FROM Tabl_Kontinent$
WHERE Kontinent = 'Северная Америка' OR Kontinent = 'Южная Америка'
SELECT 
MIN(KolNas) AS min_Kol_Nas FROM Tabl_Kontinent$
WHERE Kontinent = 'Африка';
SELECT 
MAX(PL) AS max_pl FROM Tabl_Kontinent$;