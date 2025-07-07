USE UniversityDB

--1.1
USE UniversityDB
DECLARE @AudienceNumber NVARCHAR(10) = '107';
SELECT 
    p.full_name AS ProfessorName,
    p.position AS Position,
    d.name_of_discipline AS DisciplineName,
    l.type_of_lesson AS LessonType
FROM 
    Professor p
JOIN 
    Lesson l ON p.id = l.professor_id
JOIN 
    Discipline d ON l.discipline_id = d.id
JOIN 
    Schedule s ON l.id = s.lesson_id
JOIN 
    Audience a ON s.audience_id = a.id
WHERE 
    a.number = @AudienceNumber;


--1.2
USE UniversityDB
DECLARE @DisciplineName NVARCHAR(100) = 'Математический анализ';

SELECT 
    l.id AS LessonID,
    l.type_of_lesson AS LessonType,
    l.start_time AS StartTime,
    l.end_time AS EndTime,
    a.number AS AudienceNumber
FROM 
    Lesson l
JOIN 
    Discipline d ON l.discipline_id = d.id
JOIN 
    Schedule s ON l.id = s.lesson_id
JOIN 
    Audience a ON s.audience_id = a.id
WHERE 
    d.name_of_discipline = @DisciplineName;

--2.1
USE UniversityDB
DECLARE @DisciplineName NVARCHAR(100) = 'Квантовая физика';
DECLARE @DisciplineExists BIT = 0;

BEGIN
    IF EXISTS (SELECT 1 FROM Discipline WHERE name_of_discipline = @DisciplineName)
    BEGIN
        SET @DisciplineExists = 1;
        PRINT 'Дисциплина "' + @DisciplineName + '" уже существует.';
    END
    ELSE
    BEGIN
        PRINT 'Дисциплина "' + @DisciplineName + '" не найдена.';
    END
END;

--2.2
DECLARE @Counter INT = 1;
WHILE @Counter <= 10
BEGIN
    IF @Counter = 5
    BEGIN
        PRINT 'Пропуск 5-й итерации';
        SET @Counter = @Counter + 1;
        CONTINUE;
    END
    
    IF @Counter > 8
    BEGIN
        PRINT 'Прерывание цикла на 9-й итерации';
        BREAK;
    END
    
    PRINT 'Итерация: ' + CAST(@Counter AS NVARCHAR(10));
    SET @Counter = @Counter + 1;
END;

--2.3
BEGIN TRY
    INSERT INTO Discipline (name_of_discipline, code)
    VALUES ('Тестовая дисциплина', 'TEST101');
    
    PRINT 'Запись успешно добавлена.';
END TRY
BEGIN CATCH
    PRINT 'Ошибка: ' + ERROR_MESSAGE();
END CATCH;

--3.1
SELECT 
    d.name_of_discipline AS Discipline,
    l.type_of_lesson AS LessonType,
    l.start_time AS StartTime,
    l.end_time AS EndTime,
    a.number AS Audience
FROM Lesson l     
JOIN Discipline d ON l.discipline_id = d.id
JOIN Schedule s ON l.id = s.lesson_id
JOIN Audience a ON s.audience_id = a.id
WHERE 
    CONVERT(DATE, l.start_time) = CONVERT(DATE, GETDATE());
	--3.2
	SELECT 
    d.name_of_discipline AS Discipline,
    l.type_of_lesson AS LessonType,
    DATEDIFF(MINUTE, l.start_time, l.end_time) AS DurationMinutes
FROM 
    Lesson l
JOIN 
    Discipline d ON l.discipline_id = d.id;

--строковые функции
--1
SELECT 
    name_of_discipline AS DisciplineName,
    SUBSTRING(code, 1, 3) AS FacultyCode,
    SUBSTRING(code, 4, 4) AS CourseNumber
FROM 
    Discipline;
--2
use UniversityDB
SELECT 
    CONCAT(full_name, ' (', position, ')') AS ProfessorInfo
FROM 
    Professor;
--3
use UniversityDB
SELECT 
    full_name AS ProfessorName,
    LEN(SUBSTRING(full_name, 1, CHARINDEX(' ', full_name) - 1)) AS LastNameLength
FROM 
    Professor
WHERE 
    LEN(SUBSTRING(full_name, 1, CHARINDEX(' ', full_name) - 1)) > 5;
--4
use UniversityDB
SELECT 
    id,
    REPLACE(name_of_campus, 'Корпус', 'Здание') AS ModifiedName
FROM 
    Location_of_campus;

--Числовые функции
--1
SELECT 
    ROUND(AVG(seat_count), 0) AS AvgCapacityRounded
FROM 
    Audience;

--3
SELECT 
    number AS AudienceNumber,
    LOG(seat_count) AS LogCapacity
FROM 
    Audience
WHERE 
    seat_count > 0;
--4
SELECT 
    id,
    full_name,
    CASE WHEN id % 2 = 0 THEN 'Четный' ELSE 'Нечетный' END AS IdType
FROM 
    Professor;