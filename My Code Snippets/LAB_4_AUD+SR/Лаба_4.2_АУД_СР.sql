--1 Вывести ФИО студентов и длину ФИО
SELECT FIO, LEN(FIO) AS Длина_ФИО FROM Student;

--2 Вывести список студентов, убрать лишние пробелы в ФИО
SELECT TRIM(FIO) AS ФИО, Data, spez, godpost FROM Student;

--3 Найти позиции буквы «о» в ФИО каждого студента. Вывести ФИО и позицию
SELECT FIO, CHARINDEX('о', FIO) AS Позиция_о FROM Student;

--4 Вывести ФИО и первые три буквы специализации каждого студента
SELECT FIO, LEFT(spez, 3) AS Спец_3 FROM Student;

--5 Вывести список студентов, заменить специализацию «математика» на «прикладная математика»
SELECT FIO, Data, REPLACE(spez, 'Математика', 'прикладная математика') AS Спец,  godpost FROM Student;

--6 Вывести список студентов, специализацию на верхнем регистре
SELECT FIO, Data, UPPER(spez) AS Спец, godpost FROM Student;

--7 Вывести ФИО студентов в правильном и обратном виде
SELECT FIO, REVERSE(FIO) AS ФИО_обр FROM Student;

--8 Вывести каждую специализацию 4 раза в одной строке. Убрать дубликаты
SELECT DISTINCT REPLICATE(spez, 4) AS Спец_4 FROM Student;

--9 Вывести абсолютное значение тригонометрических функций на точке π
SELECT
    ABS(COS(PI())) AS Косинус_Пи,
    ABS(SIN(PI())) AS Синус_Пи,
    ABS(TAN(PI())) AS Тангенс_Пи,
    ABS(COT(PI())) AS КоТангенс_Пи;

--10 Вывести число 132.456, округленное с точностью от 3 до -3
SELECT
    ROUND(132.456, 3) AS Окр3,
    ROUND(132.456, 2) AS Окр2,
    ROUND(132.456, 1) AS Окр1,
    ROUND(132.456, 0) AS Окр0,
    ROUND(132.456, -1) AS Окр_1,
    ROUND(132.456, -2) AS Окр_2,
    ROUND(132.456, -3) AS Окр_3;

--11 Вывести наименьшее целое число, которое больше или равно 123.456, и наибольшее целое число, которое меньше или равно 123.456
SELECT
    CEILING(123.456) AS Больше,
    FLOOR(123.456) AS Меньше;

--12 Вывести квадратный корень, квадрат и куб числа 25
SELECT
    SQRT(25) AS Корень,
    SQUARE(25) AS Квадрат,
    POWER(25, 3) AS Куб;

--13 Вывести текущую дату и время
SELECT GETDATE() AS Сейчас;

--14 Вывести день, месяц, год, час, минуту, секунду, номер квартала, номер недели, день года, день недели для текущей даты и времени
SELECT
    DAY(GETDATE()) AS День,
    MONTH(GETDATE()) AS Месяц,
    YEAR(GETDATE()) AS Год,
    DATEPART(HOUR, GETDATE()) AS Час,
    DATEPART(MINUTE, GETDATE()) AS Минута,
    DATEPART(SECOND, GETDATE()) AS Секунда,
    DATEPART(QUARTER, GETDATE()) AS Квартал,
    DATEPART(WEEK, GETDATE()) AS Неделя,
    DATEPART(DAYOFYEAR, GETDATE()) AS День_года,
    DATEPART(WEEKDAY, GETDATE()) AS День_недели;

--15 Вывести дату 100 дней назад от текущей
SELECT DATEADD(DAY, -100, GETDATE()) AS День_100_Назад;

--16 Иванов И.И. родился 8 июля 1895 года, скончался 12 апреля 1971 года. Вывести количество прожитых дней
SELECT DATEDIFF(DAY, '18950708', '19710412') AS Количество_прожитых_дней;

--17 Вывести ФИО и время года рождения каждого студента
SELECT FIO, CASE MONTH(Data)
        WHEN 3 THEN 'Весна'
        WHEN 4 THEN 'Весна'
        WHEN 5 THEN 'Весна'
        WHEN 6 THEN 'Лето'
        WHEN 7 THEN 'Лето'
        WHEN 8 THEN 'Лето'
        WHEN 9 THEN 'Осень'
        WHEN 10 THEN 'Осень'
        WHEN 11 THEN 'Осень'
        ELSE 'Зима'
   END AS Время_года FROM Student;

--18 Вывести список студкетов. Для каждого студента, в зависимости от возраста, при поступлении «молодой» или «старше» в дополнительном столбце
SELECT FIO, Data, spez, godpost, IIF(godpost - YEAR(Data) <= 18, 'Молодой', 'старше') 
AS Возраст_при_поступлении FROM Student;

--19 Вывести ФИО, дату рождения и знак зодиака каждого студента
SELECT FIO, Data, CASE
        WHEN (MONTH(Data)=3 AND DAY(Data) >= 21) OR (MONTH(Data)=4 AND DAY(Data) <= 20) THEN 'Овен'
        WHEN (MONTH(Data)=4 AND DAY(Data) >= 21) OR (MONTH(Data)=5 AND DAY(Data) <= 21) THEN 'Телец'
        WHEN (MONTH(Data)=5 AND DAY(Data) >= 22) OR (MONTH(Data)=6 AND DAY(Data) <= 21) THEN 'Близнецы'
        WHEN (MONTH(Data)=6 AND DAY(Data) >= 22) OR (MONTH(Data)=7 AND DAY(Data) <= 22) THEN 'Рак'
        WHEN (MONTH(Data)=7 AND DAY(Data) >= 23) OR (MONTH(Data)=8 AND DAY(Data) <= 21) THEN 'Лев'
        WHEN (MONTH(Data)=8 AND DAY(Data) >= 22) OR (MONTH(Data)=9 AND DAY(Data) <= 23) THEN 'Дева'
        WHEN (MONTH(Data)=9 AND DAY(Data) >= 24) OR (MONTH(Data)=10 AND DAY(Data) <= 23) THEN 'Весы'
        WHEN (MONTH(Data)=10 AND DAY(Data) >= 24) OR (MONTH(Data)=11 AND DAY(Data) <= 22) THEN 'Скорпион'
        WHEN (MONTH(Data)=11 AND DAY(Data) >= 23) OR (MONTH(Data)=12 AND DAY(Data) <= 22) THEN 'Стрелец'
        WHEN (MONTH(Data)=12 AND DAY(Data) >= 23) OR (MONTH(Data)=1 AND DAY(Data) <= 20) THEN 'Козерог'
        WHEN (MONTH(Data)=1 AND DAY(Data) >= 21) OR (MONTH(Data)=2 AND DAY(Data) <= 19) THEN 'Водолей'
        WHEN (MONTH(Data)=2 AND DAY(Data) >= 20) OR (MONTH(Data)=3 AND DAY(Data) <= 20) THEN 'Рыбы'
    END AS Знак_зодиака
FROM Student;


--Самостоятельная работа
--1 Вывести список студентов, отсортированный по количеству символов в ФИО
SELECT FIO, LEN(FIO) AS llength
FROM  Student
ORDER BY LEN(FIO);

--2 Вывести список студентов, убрать лишние пробелы в ФИО
SELECT TRIM(FIO) AS FIO, Data, spez, godpost
FROM Student;

--3 Найти позиции «ов» в ФИО каждого студентов. Вывести ФИО и номер позиции
SELECT FIO, CHARINDEX('ов', FIO) AS pos
FROM Student;

--4 Вывести ФИО и последние две буквы специализации для каждого студента
SELECT FIO, RIGHT(spez, 2) AS last_2_letters
FROM Student;

--5 Вывести список студентов, ФИО в формате Фамилия и Инициалы
SELECT CONCAT(
LEFT(FIO, CHARINDEX(' ', FIO)), ' ', 
SUBSTRING(FIO, CHARINDEX(' ', FIO) + 1, 1),  '.', 
SUBSTRING(FIO, CHARINDEX(' ', FIO, CHARINDEX(' ', FIO) + 1) + 1, 1), '.' 
) AS name_
FROM Student;

--6 Вывести список специализаций в правильном и обратном виде. Убрать дубликаты
SELECT DISTINCT spez, REVERSE(spez) AS revers_spez
FROM Student;

--7 Вывести свою фамилию в одной строке столько раз, сколько вам лет
DECLARE @age INT = DATEDIFF(YEAR, '2005-08-25', GETDATE());
SELECT REPLICATE('Тюев ', @age) AS Тюев;

--8 Вывести абсолютное значение функций sin²(π/2) - cos²(3π) с точностью два знака после десятичной запятой
SELECT ROUND(ABS(POWER(SIN(PI()/2), 2) - POWER(COS(3*PI()), 2)), 2) AS res;

--9 Вывести количество дней до конца семестра
SELECT DATEDIFF(DAY, GETDATE(), '20250601') AS days_left;

--10 Вывести количество месяцев от вашего рождения
SELECT DATEDIFF(MONTH, '2005-08-25', GETDATE()) AS months;

--11 Вывести список специализаций без повторений. Для каждой специализации вывести «длинный» или «короткий», в зависимости от количества символов
SELECT DISTINCT spez, IIF(LEN(spez) > 8, 'длинный', 'короткий') AS spez_length
FROM Student



