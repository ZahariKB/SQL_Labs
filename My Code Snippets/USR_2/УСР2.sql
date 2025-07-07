USE Ucheb_8_Tuiev
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$
WHERE PL < 500 AND KolNas < 100000
ORDER BY Nazvanie;

SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$
WHERE PL > 1000000
EXCEPT
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$
WHERE KolNas < 100000000
ORDER BY Nazvanie;


SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$
WHERE PL < 500
UNION
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$
WHERE PL > 5000000
ORDER BY PL;



--3/4
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$
WHERE PL > 1000000
INTERSECT
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$
WHERE KolNas > 100000000



--2
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$
WHERE PL > 1000000
UNION ALL
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$
WHERE KolNas > 100000000


--1
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$
WHERE PL > 1000000
UNION
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$
WHERE KolNas > 100000000
