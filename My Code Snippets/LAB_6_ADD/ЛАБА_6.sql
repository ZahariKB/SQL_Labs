-- 23. Хранимые процедуры с входными параметрами

--1 Добавление нового занятия в расписание
GO
CREATE PROCEDURE AddLessonToSchedule
    @discipline_id INT, @professor_id INT, @group_id INT,
    @type_of_lesson NVARCHAR(50), @max_students INT, @date_of_lesson DATE,
    @day_of_week NVARCHAR(20), @start_time TIME, @end_time TIME
AS BEGIN
    -- Проверка существования связанных сущностей
    IF EXISTS(
        SELECT 1 
        FROM Discipline d
        JOIN Professor p ON d.id = @discipline_id AND p.id = @professor_id
        JOIN GroupOfStudents g ON g.id = @group_id
		)
    BEGIN
        INSERT INTO Lesson (
            discipline_id, professor_id, group_id, type_of_lesson, 
			max_students, date_of_lesson, day_of_week, start_time, end_time
        )
        VALUES (
            @discipline_id, @professor_id, @group_id, @type_of_lesson,
            @max_students, @date_of_lesson, @day_of_week, @start_time, @end_time
        )
        PRINT 'Занятие успешно добавлено!'
    END
    ELSE
        PRINT 'Ошибка: Проверьте корректность вводимых данных!'
END
GO
-- Пример вызова
EXEC AddLessonToSchedule 
    @discipline_id = 4, @professor_id = 3, @group_id = 8, @type_of_lesson = 'Практика',
    @max_students = 25, @date_of_lesson = '2024-09-10', @day_of_week = 'Wednesday',
    @start_time = '14:00', @end_time = '15:30'

--2 Обновление информации об аудитории
GO
CREATE PROCEDURE UpdateAudienceInfo
    @audience_id INT, @new_seat_count INT, @new_type NVARCHAR(50)
AS
BEGIN
    UPDATE Audience
    SET 
        seat_count = @new_seat_count,
        type_of_audience = @new_type
    WHERE id = @audience_id
    IF @@ROWCOUNT > 0
        PRINT 'Данные аудитории обновлены!'
    ELSE
        PRINT 'Аудитория с указанным ID не найдена!'
END
GO

-- Пример вызова
EXEC UpdateAudienceInfo 
    @audience_id = 5,
    @new_seat_count = 35,
    @new_type = 'Компьютерная лаборатория'

-- 24. Хранимые процедуры с выходными параметрами

--1 Подсчет количества групп в указанном учебном году
GO
CREATE PROCEDURE GetGroupsCountByYear
    @academic_year NVARCHAR(9),
    @groups_count INT OUTPUT
AS
BEGIN
    SELECT @groups_count = COUNT(*)
    FROM GroupOfStudents
    WHERE academic_year = @academic_year
END
GO

-- Пример вызова
use UniversityDB
DECLARE @count1 INT
EXEC GetGroupsCountByYear 
    @academic_year = '2023-2024',
    @groups_count = @count1 OUTPUT

SELECT @count1 AS [Количество групп]

--2 Получение средней вместимости аудиторий на кампусе
GO
CREATE PROCEDURE GetAverageSeatsByCampus
    @campus_id INT,
    @avg_seats INT OUTPUT
AS
BEGIN
    SELECT @avg_seats = AVG(seat_count)
    FROM Audience
    WHERE location_id = @campus_id
END
GO

-- Пример вызова
use UniversityDB
DECLARE @avg INT
EXEC GetAverageSeatsByCampus 
    @campus_id = 3,
    @avg_seats = @avg OUTPUT

SELECT @avg AS [Средняя вместимость]

-- 25. Пользовательские скалярные функции

--1 Проверка существования дисциплины по коду
GO
CREATE FUNCTION dbo.CheckDisciplineExists(@code NVARCHAR(20))
RETURNS BIT
AS
BEGIN
    DECLARE @exists BIT = 0
    IF EXISTS(SELECT 1 FROM Discipline WHERE code = @code)
        SET @exists = 1
    RETURN @exists
END
GO

-- Пример использования
SELECT dbo.CheckDisciplineExists('CS1416') AS [Существует дисциплина]

--2 Расчет общего количества мест в аудиториях кампуса
GO
CREATE FUNCTION dbo.GetTotalSeatsByCampus(@campus_id INT)
RETURNS INT
AS
BEGIN
    DECLARE @total INT
    SELECT @total = SUM(seat_count)
    FROM Audience
    WHERE location_id = @campus_id
    RETURN @total
END
GO

-- Пример использования
SELECT dbo.GetTotalSeatsByCampus(3) AS [Всего мест в главном корпусе]

-- 26. Функции, возвращающие табличное значение

--1 Получение расписания преподавателя
GO
CREATE FUNCTION dbo.GetProfessorSchedule(@professor_id INT)
RETURNS TABLE
AS
RETURN (
    SELECT 
        d.name_of_discipline AS Дисциплина,
        g.number AS Группа,
        l.day_of_week AS День,
        l.start_time AS Начало,
        l.end_time AS Окончание,
        a.number AS Аудитория
    FROM Lesson l
    JOIN Schedule s ON l.id = s.lesson_id
    JOIN Discipline d ON l.discipline_id = d.id
    JOIN GroupOfStudents g ON l.group_id = g.id
    JOIN Audience a ON s.audience_id = a.id
    WHERE l.professor_id = @professor_id
)
GO

-- Пример использования
SELECT * FROM dbo.GetProfessorSchedule(4)

--2 Поиск свободных аудиторий по времени
GO
CREATE FUNCTION dbo.FindFreeAudiences(
    @target_date DATE, @start_time TIME, @end_time TIME
)
RETURNS @result TABLE (
    audience_id INT, number NVARCHAR(10), type_of_audience NVARCHAR(50),
    seat_count INT, campus NVARCHAR(100)
) AS
BEGIN
    INSERT INTO @result
    SELECT 
        a.id, a.number, a.type_of_audience, a.seat_count, lc.name_of_campus
    FROM Audience a
    JOIN Location_of_campus lc ON a.location_id = lc.id
    WHERE NOT EXISTS (
        SELECT 1 
        FROM Schedule s
        JOIN Lesson l ON s.lesson_id = l.id
        WHERE s.audience_id = a.id
        AND l.date_of_lesson = @target_date
        AND (
            (l.start_time < @end_time AND l.end_time > @start_time)
        )
    )
    RETURN
END
GO
--Пример использования
SELECT * 
FROM dbo.FindFreeAudiences(
    '2024-09-01', '10:00', '11:30'
)
WHERE seat_count >= 20


use UniversityDB
go
ALTER PROCEDURE AddLessonToSchedule
    @discipline_code NVARCHAR(20), @professor_id INT, @group_id INT,
    @type_of_lesson NVARCHAR(50), @max_students INT, @date_of_lesson DATE,
    @day_of_week NVARCHAR(20), @start_time TIME, @end_time TIME
AS 
BEGIN
    DECLARE @discipline_id INT;

    SELECT @discipline_id = id 
    FROM Discipline 
    WHERE code = @discipline_code;

    IF dbo.CheckDisciplineExists(@discipline_code) = 1
    AND EXISTS (
        SELECT 1 
        FROM Professor p 
        JOIN GroupOfStudents g ON p.id = @professor_id AND g.id = @group_id
    )
    BEGIN
        INSERT INTO Lesson ( discipline_id, 
    professor_id, group_id, type_of_lesson, max_students, 
    date_of_lesson, day_of_week, start_time, end_time
	) 
        VALUES (@discipline_id,         
    @professor_id, @group_id, @type_of_lesson, @max_students,           
    @date_of_lesson, @day_of_week, @start_time, @end_time );
        PRINT 'Успешно!';
    END
    ELSE
        PRINT 'Ошибка: Дисциплина или связи не существуют!';
END
go

Use UniversityDB
GO
EXEC AddLessonToSchedule 
    @discipline_code = 'MA102', 
    @professor_id = 3, 
    @group_id = 8, 
    @type_of_lesson = 'Практика',
    @max_students = 25, 
    @date_of_lesson = '2024-09-10', 
    @day_of_week = 'Wednesday',
    @start_time = '14:00', 
    @end_time = '15:30';
GO

select * from Lesson