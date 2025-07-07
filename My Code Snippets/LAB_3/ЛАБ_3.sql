use Ucheb_8_Tuiev

SELECT Nazvanie, Stolica, PL, KolNas, Kontinent FROM Tabl_Kontinent$ A
WHERE PL = (SELECT MIN(PL) FROM Tabl_Kontinent$ B WHERE B.Kontinent = A.Kontinent)
AND KolNas = (SELECT MAX(KolNas) FROM Tabl_Kontinent$ C 
WHERE C.Kontinent = A.Kontinent  AND C.PL = (SELECT MIN(PL) FROM Tabl_Kontinent$ D WHERE D.Kontinent = A.Kontinent));
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent FROM Tabl_Kontinent$ 
WHERE KolNas !> ( SELECT KolNas FROM Tabl_Kontinent$ WHERE Nazvanie = 'Фиджи');
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent FROM Tabl_Kontinent$ 
WHERE Kontinent = (SELECT Kontinent FROM Tabl_Kontinent$ WHERE Nazvanie = 'Фиджи');
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent FROM Tabl_Kontinent$ 
WHERE Kontinent = 'Африка' AND EXISTS
( SELECT * FROM Tabl_Kontinent$ WHERE Kontinent = 'Африка' AND PL > 2000000);
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent FROM Tabl_Kontinent$ 
WHERE Kontinent = 'Африка' AND KolNas > ANY( SELECT KolNas FROM Tabl_Kontinent$
WHERE Kontinent = 'Южная Америка');
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent FROM Tabl_Kontinent$ 
WHERE Kontinent = 'Южная Америка' AND KolNas > ALL(
SELECT KolNas FROM Tabl_Kontinent$
WHERE Kontinent = 'Африка');
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent FROM Tabl_Kontinent$
WHERE Kontinent IN (SELECT Kontinent FROM Tabl_Kontinent$
GROUP BY Kontinent 
HAVING AVG(KolNas/PL) > (SELECT AVG(KolNas/PL) FROM Tabl_Kontinent$));
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$ A WHERE PL > (SELECT AVG(PL) FROM Tabl_Kontinent$ B 
WHERE B.Kontinent = A.Kontinent);
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent,
ROUND(CAST(PL AS FLOAT) * 100 / (SELECT SUM(PL) FROM Tabl_Kontinent$ B WHERE B.Kontinent = A.Kontinent), 3) AS Percentt 
FROM Tabl_Kontinent$ A
ORDER BY Percentt DESC;
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent FROM 
(SELECT Nazvanie, Stolica, PL, KolNas, Kontinent FROM Tabl_Kontinent$ WHERE Kontinent = 'Европа') A 
WHERE KolNas < 5000000;
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent,
(KolNas/PL) AS POpulationDensity FROM Tabl_Kontinent$
WHERE (KolNas/PL) > (SELECT SUM(KolNas)/SUM(PL) FROM Tabl_Kontinent$);
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent,
ROUND(CAST(PL AS FLOAT) * 100 / (SELECT SUM(PL) FROM Tabl_Kontinent$), 3) AS AreaPercent 
FROM Tabl_Kontinent$
ORDER BY AreaPercent DESC;
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent FROM Tabl_Kontinent$ 
WHERE KolNas = (SELECT MAX(Мин_Нас) FROM (SELECT MIN(KolNas) AS Мин_Нас FROM Tabl_Kontinent$
GROUP BY Kontinent) A);
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$ 
WHERE KolNas !> (SELECT KolNas FROM Tabl_Kontinent$
WHERE Nazvanie = 'Ангола');
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$ 
WHERE Kontinent = (SELECT Kontinent FROM Tabl_Kontinent$
WHERE Nazvanie = 'Ангола');
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$  WHERE Kontinent = 'Африка' AND EXISTS(SELECT * FROM Tabl_Kontinent$
WHERE Kontinent = 'Африка' AND KolNas > 100000000);
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent FROM Tabl_Kontinent$ 
WHERE Kontinent = 'Европа' AND KolNas > ANY(SELECT KolNas FROM Tabl_Kontinent$ WHERE Kontinent = 'Южная Америка');
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent FROM Tabl_Kontinent$ 
WHERE Kontinent = 'Азия' AND KolNas > ALL(SELECT KolNas FROM Tabl_Kontinent$
WHERE Kontinent = 'Европа');
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent FROM Tabl_Kontinent$ 
WHERE Kontinent IN (SELECT Kontinent FROM Tabl_Kontinent$
GROUP BY Kontinent HAVING AVG(KolNas) > (SELECT AVG(KolNas) FROM Tabl_Kontinent$));
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$ А WHERE KolNas > (SELECT AVG(KolNas) FROM Tabl_Kontinent$ Б 
WHERE Б.Kontinent = А.Kontinent);
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent,
ROUND(CAST(KolNas AS FLOAT) * 100 / 
(SELECT SUM(KolNas) FROM Tabl_Kontinent$ Б WHERE А.Kontinent = Б.Kontinent), 3)
AS Процент FROM Tabl_Kontinent$ А
ORDER BY Процент DESC;
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM 
(SELECT Nazvanie, Stolica, PL, KolNas, Kontinent 
FROM Tabl_Kontinent$ WHERE Nazvanie = 'Африка') A
WHERE KolNas > 50000000;
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent FROM Tabl_Kontinent$
WHERE KolNas > (SELECT AVG(KolNas) FROM Tabl_Kontinent$);
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent, 
ROUND(CAST(KolNas AS FLOAT) * 100 / (SELECT SUM(KolNas) FROM Tabl_Kontinent$), 3) AS Процент
FROM Tabl_Kontinent$
ORDER BY Процент DESC;                                                                                                                                          
