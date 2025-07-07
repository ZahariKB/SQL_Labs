use JoinTable

SELECT s.Reg_Nom, s.Fio_stud, sp.NaprSpez --1
FROM Student s
inner JOIN Spezialn sp ON s.Nom_SpeZ_St = sp.NSpez
WHERE sp.Shift_Spez = 'ис';

use JoinTable
SELECT s.TabNom, s.FIO, s.Dolgn, r.FIO AS Rukovoditel --2
FROM Sotrudnik s
LEFT JOIN Sotrudnik r ON s.TabNom_ruk = r.TabNom AND s.TabNom != s.TabNom_ruk;

use JoinTable
SELECT s.Reg_Nom, s.Fio_stud, COUNT(*) AS Kolvo_ekzamenov --3
FROM Student s
JOIN Ozenka o ON s.Reg_Nom = o.ReGNom
GROUP BY s.Reg_Nom, s.Fio_stud
HAVING COUNT(*) >= 2;

use JoinTable
SELECT i.TabNom_IN, i.Spez, s.Zarplata --4
FROM Ingener i
JOIN Sotrudnik s ON i.TabNom_IN = s.TabNom
WHERE s.Zarplata < 2000;
SELECT DISTINCT s.Reg_Nom, s.Fio_stud --5
FROM Student s
JOIN Ozenka o ON s.Reg_Nom = o.ReGNom
WHERE o.Auditoria = '+505';

use JoinTable
SELECT s.Reg_Nom, s.Fio_stud, --6
       COUNT(*) AS Kolvo_ekzamenov, 
       AVG(o.Ozenk_a) AS Sredniy_ball
FROM Student s
JOIN Ozenka o ON s.Reg_Nom = o.ReGNom
GROUP BY s.Reg_Nom, s.Fio_stud
HAVING AVG(o.Ozenk_a) >= 4;
SELECT s.FIO, s.Zarplata, p.Stepen --7
FROM Sotrudnik s
JOIN Prepodavatel p ON s.TabNom = p.TabNom_Pr
WHERE s.Dolgn = 'зав.кафедрой';

use JoinTable
SELECT s.TabNom, s.FIO, p.Stepen--8
FROM Sotrudnik s
JOIN Prepodavatel p ON s.TabNom = p.TabNom_Pr
WHERE p.Zvanie = 'профессор';
SELECT p.Predmet, s.FIO, s.Dolgn, pr.Stepen, o.data, o.Auditoria --9
FROM Ozenka o
JOIN Predmet p ON o.Kod = p.kod_pred
JOIN Sotrudnik s ON o.Tab_Nom = s.TabNom
JOIN Prepodavatel pr ON s.TabNom = pr.TabNom_Pr
WHERE o.data BETWEEN '2022-06-05' AND '2022-06-10'
ORDER BY o.data;

use JoinTable
SELECT s.TabNom, s.FIO, COUNT(*) AS Kolvo_ekzamenov --10
FROM Sotrudnik s
JOIN Ozenka o ON s.TabNom = o.Tab_Nom
GROUP BY s.TabNom, s.FIO
HAVING COUNT(*) > 2;

SELECT s.Reg_Nom, s.Fio_stud --11
FROM Student s
WHERE s.Reg_Nom NOT IN (
    SELECT ReGNom 
    FROM Ozenka 
    WHERE data = '2022-06-05'
);