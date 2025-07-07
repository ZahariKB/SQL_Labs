use JoinTable

CREATE TABLE Kafedra (
    NKaf VARCHAR(100),
    AbFaK_Kaf VARCHAR(10),
    ShifrKaf VARCHAR(10)
);
INSERT INTO Kafedra (ShifrKaf, NKaf, AbFaK_Kaf) VALUES
( 'ВМ', 'Высшая Математика', 'ен'),
( 'ис', 'Информационные Системы', 'ит'),
( 'мм', 'Математическое Моделирование', 'фм'),
( 'оф', 'Общая Физика', 'ен'),
( 'пи', 'Прикладная Математика', 'ит'),
( 'эф', 'Экспериментальная Физика', 'фм');

CREATE TABLE Fakultet (
    ABfak VARCHAR(10),
    NFak VARCHAR(100)
);
INSERT INTO Fakultet (ABfak, NFak) VALUES
('гн', 'Гуманитарные Науки'),
('ен', 'Естественные Науки'),
('ит', 'Информационные Технологии'),
('фм', 'Физико Математический');

CREATE TABLE Sotrudnik (
  
    TabNom INTEGER NOT NULL,              
    ShiftKaf_Sotr VARCHAR(10) NOT NULL,   
    FIO VARCHAR(50) NOT NULL,             
    Dolgn VARCHAR(50) NOT NULL,           
    Zarplata DECIMAL(10,2) NOT NULL,      
    TabNom_ruk INTEGER NOT NULL,        
                   
);
INSERT INTO Sotrudnik (TabNom, ShiftKaf_Sotr, FIO, Dolgn, Zarplata, TabNom_ruk) VALUES
    (101, 'пи', 'Прохоров', 'зав.кафедрой', 3500.00, 101),
    (102, 'пи', 'Семенов', 'преподаватель', 2500.00, 101),
    (105, 'пи', 'Петров', 'преподаватель', 2500.00, 101),
    (153, 'пи', 'Сидорова', 'инженер', 1500.00, 102),
    (201, 'ио', 'Андреев', 'зав.кафедрой', 3500.00, 201),
    (202, 'ио', 'Борисов', 'преподаватель', 2500.00, 201),
    (241, 'ио', 'Глухов', 'инженер', 2000.00, 201),
    (242, 'ио', 'Чернов', 'инженер', 1500.00, 202),
    (301, 'мм', 'Басов', 'зав.кафедрой', 3500.00, 301),
    (302, 'мм', 'Сергеева', 'преподаватель', 2500.00, 301),
    (401, 'оф', 'Волкля', 'зав.кафедрой', 3500.00, 401),
    (402, 'оф', 'Зайцев', 'преподаватель', 2500.00, 401),
    (403, 'оф', 'Смирнов', 'преподаватель', 1500.00, 401),
    (435, 'оф', 'Лисик', 'инженер', 2000.00, 402),
    (501, 'вм', 'Кузнецов', 'зав.кафедрой', 3500.00, 501),
    (502, 'вм', 'Романцев', 'преподаватель', 2500.00, 501),
    (503, 'вм', 'Соловьев', 'преподаватель', 2500.00, 501),
    (601, 'эф', 'Зверев', 'зав.кафедрой', 3500.00, 601),
    (602, 'эф', 'Сорокина', 'преподаватель', 2500.00, 601),
    (614, 'эф', 'Григорьев', 'инженер', 2000.00, 602);

	CREATE TABLE Spezialn (
    NSpez VARCHAR(10) PRIMARY KEY,
    NaprSpez VARCHAR(100) NOT NULL,
    Shift_Spez VARCHAR(10) NOT NULL
);
INSERT INTO Spezialn (NSpez, NaprSpez, Shift_Spez) VALUES
    ('01.03.04', 'Прикладная Математика', 'мм'),
    ('09.03.02', 'Информационные системы и технологии', 'ис'),
    ('14.03.02', 'Ядерная физика и технологии', 'иф'),
    ('38.03.05', 'Бизнес информатика', 'ис'),
    ('09.09.03', 'Прикладная информатика', 'пи');

CREATE TABLE Predmet (
    kod_pred INTEGER PRIMARY KEY,
    Kol INTEGER NOT NULL,
    Predmet VARCHAR(100) NOT NULL,
    Ispolnitel_kaf VARCHAR(10) NOT NULL
);
INSERT INTO Predmet (kod_pred, Kol, Predmet, Ispolnitel_kaf) VALUES
    (101, 320, 'Математика', 'вм'),
    (102, 160, 'Информатика', 'пи'),
    (103, 160, 'Физика', 'оф'),
    (202, 120, 'База данных', 'ис'),
    (204, 160, 'Электронника', 'эф'),
    (205, 80, 'Программирование', 'пи'),
    (209, 80, 'Моделирование', 'мм');

CREATE TABLE Zakaz (
    N_Z VARCHAR(10) NOT NULL,
    Kod_Z INTEGER NOT NULL
);
INSERT INTO Zakaz (N_Z, Kod_Z) VALUES
    ('01.03.04', 101),
    ('01.03.04', 205),
    ('01.03.04', 209),
    ('09.03.02', 101),
    ('09.03.02', 102),
    ('09.03.02', 103),
    ('09.03.02', 202),
    ('09.02.03', 205),
    ('09.02.03', 209),
    ('09.03.03', 101),
    ('09.09.03', 102),
    ('09.09.03', 103),
    ('09.03.03', 205),
    ('09.03.03', 202),
    ('14.03.02', 101),
    ('14.03.02', 102),
    ('14.03.02', 103),
    ('14.03.02', 204),
    ('38.03.05', 101),
    ('38.03.05', 103),
    ('38.03.05', 202),
    ('38.03.05', 209);

	CREATE TABLE ZavKaf (
    TabNom_K INTEGER PRIMARY KEY,
    St_K INTEGER NOT NULL
);
INSERT INTO ZavKaf (TabNom_K, St_K) VALUES
    (101, 15),
    (201, 18),
    (301, 20),
    (401, 10),
    (501, 18),
    (601, 8);

CREATE TABLE Ingener (
    TabNom_IN INTEGER PRIMARY KEY,
    Spez VARCHAR(50) NOT NULL
);
INSERT INTO Ingener (TabNom_IN, Spez) VALUES
    (153, 'электроник'),
    (241, 'электроник'),
    (242, 'программист'),
    (435, 'электроник'),
    (614, 'программист');

	CREATE TABLE Prepodavatel (
    TabNom_Pr INTEGER PRIMARY KEY,
    Zvanie VARCHAR(50) NOT NULL,
    Stepen VARCHAR(50)
);
INSERT INTO Prepodavatel (TabNom_Pr, Zvanie, Stepen) VALUES
    (101, 'профессор', 'д.т.н.'),
    (102, 'доцент', 'к.ф.-м.н.'),
    (105, 'доцент', 'к.т.н.'),
    (201, 'профессор', 'д.ф.-м.н.'),
    (202, 'доцент', 'к.ф.-м.н.'),
    (301, 'профессор', 'д.т.н.'),
    (302, 'доцент', 'к.т.н.'),
    (401, 'профессор', 'д.т.н.'),
    (402, 'доцент', 'к.т.н.'),
    (403, 'ассистент', NULL),
    (501, 'профессор', 'д.ф.-м.н.'),
    (502, 'профессор', 'д.ф.-м.н.'),
    (503, 'доцент', 'к.ф.-м.н.'),
    (601, 'профессор', 'д.ф.-м.н.');

	CREATE TABLE Student (
    Reg_Nom VARCHAR(10) PRIMARY KEY,
    Nom_SpeZ_St VARCHAR(10) NOT NULL,
    Fio_stud VARCHAR(50) NOT NULL
);
INSERT INTO Student (Reg_Nom, Nom_SpeZ_St, Fio_stud) VALUES
    ('10101', '09.03.03', 'Николаева'),
    ('10102', '09.03.03', 'Иванов'),
    ('10103', '09.03.03', 'Крюков'),
    ('20101', '09.03.02', 'Андреев'),
    ('20102', '09.03.02', 'Федоров'),
    ('30101', '14.03.02', 'Бондаренко'),
    ('30102', '14.03.02', 'Цветков'),
    ('30103', '14.03.02', 'Петров'),
    ('50101', '01.03.04', 'Сергеев'),
    ('50102', '01.03.04', 'Кудрявцев'),
    ('80101', '38.03.05', 'Макаров'),
    ('80102', '38.03.05', 'Яковлев');

	CREATE TABLE Ozenka (
    data DATE NOT NULL,
    Kod INTEGER NOT NULL,
    ReGNom VARCHAR(10) NOT NULL,
    Tab_Nom INTEGER NOT NULL,
    Auditoria VARCHAR(10) NOT NULL,
    Ozenk_a INTEGER NOT NULL,
    PRIMARY KEY (data, Kod, ReGNom)
);
INSERT INTO Ozenka (data, Kod, ReGNom, Tab_Nom, Auditoria, Ozenk_a) VALUES
    ('2022-06-05', 102, '10101', 102, '+505', 4),
    ('2022-06-05', 102, '10102', 102, '+505', 4),
    ('2022-06-05', 202, '20101', 202, '+506', 4),
    ('2022-06-05', 202, '20102', 202, '+506', 3),
    ('2022-06-07', 102, '30101', 105, 'φ419', 3),
    ('2022-06-07', 102, '30102', 101, '+506', 4),
    ('2022-06-07', 102, '80101', 1002, 'M425', 5),
    ('2022-06-09', 205, '80102', 402, 'M424', 4),
    ('2022-06-09', 209, '20101', 302, 'φ333', 3),
    ('2022-06-10', 101, '10102', 501, '+506', 4),
    ('2022-06-10', 204, '30102', 601, 'φ349', 5),
    ('2022-06-10', 209, '80101', 301, '>105', 5),
    ('2022-06-10', 209, '80102', 301, '>105', 4),
    ('2022-06-12', 101, '80101', 502, 'c324', 4),
    ('2022-06-15', 101, '30101', 503, 'φ417', 4),
    ('2022-06-15', 101, '50101', 501, 'φ201', 5),
    ('2022-06-15', 101, '50102', 501, 'φ201', 3),
    ('2022-06-15', 103, '10101', 403, 'φ414', 4),
    ('2022-06-15', 102, '10101', 102, '+505', 5);

use JoinTable
select * from fakultet
select * from kafedra
select * from sotrudnik
select * from spezialn
select * from predmet
select * from zakaz
select * from ZavKAf
select * from Ingener
select * from prepodavatel
select * from student
select * from ozenka

use JoinTable
 
select --1
F.Nfak As Fakultet,
K.Nkaf as Kafedra from
Fakultet F, Kafedra K where
F.ABfak = K.AbFaK_Kaf
order by Fakultet, Kafedra
select f.Nfak as Fakultet, --2 
       k.Nkaf as Kafedra
	   from fakultet f
	   inner join kafedra k on
	   F.Abfak = k.aBFAK_KAF
	   ORDER BY FAKULTET, KAFEDRA

use JoinTable
select f.Nfak as Fakultet, --3
       k.Nkaf as Kafedra
	   from fakultet f
	   LEFT OUTER join kafedra k on
	   F.Abfak = k.aBFAK_KAF
	   ORDER BY FAKULTET, KAFEDRA

use JoinTable
select S.Fio_stud, --4
      P.NaprSpez,
	  K.Nkaf as Kafedra
	  from Student s inner join Spezialn P on S.Nom_SpeZ_St=P.NSpez
	  inner join Kafedra k on  P.Shift_Spez = K.ShifrKaf
select s.fio, s.dolgn, s.zarplata, p.fio as [Руководитель] --5
from Sotrudnik s 
inner join Sotrudnik p on s.TabNom = p.TabNom_ruk

use JoinTable
select  s.fio_stud --6
from student s inner join ozenka o on s.Reg_Nom = o.ReGNom
group by Fio_stud

use JoinTable
select --7
S.fio_stud,
count(o.ozenk_a) as [Количество экзаменов],
avg(o.ozenk_a) as [средний балл]
from student s inner join ozenka o on s.Reg_Nom=O.ReGNom
group by s.Fio_stud

use JoinTable
select --8
S.fio,
s.zarplata,
z.st_k
from sotrudnik s inner join zavkaf z on tabnom=z.TabNom_K
select --9
s.fio,
p.stepen
from Sotrudnik s inner join prepodavatel p on S.TabNom = p.TabNom_Pr
WHERE P.Stepen in ('к.ф.-м.н.','д.ф.-м.н.')

use JoinTable
select distinct --10 
Pr.predmet as Дисциплина,
s.fio,
s.dolgn,
p.stepen,
o.data,
o.auditoria from
Ozenka o
inner join predmet pr on o.kod=pr.kod_pred
inner join sotrudnik s on o.Tab_Nom = s.TabNom
inner join prepodavatel p on o.Tab_Nom = p.TabNom_Pr
order by o.data

use JoinTable
select --11
p.fio,
count(o.data) as [Количество экзаменов]
from ozenka o
inner join Sotrudnik p on p.tabnom= o.tab_nom
group by p.fio
select --12
s.fio_stud
from
student s
left outer join ozenka o on s.Reg_Nom=o.ReGNom
where o.regnom is null