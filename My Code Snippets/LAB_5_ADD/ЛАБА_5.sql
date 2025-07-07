
--5 не обновляемых представлений 

-- 1. Представление с информацией о занятиях (аудитории, дисциплины, группы)
use UniversityDB;
GO
CREATE VIEW LessonDetailsView AS
SELECT 
    s.id AS schedule_id,
    a.number AS audience_number,
    a.type_of_audience,
    a.seat_count,
    lc.name_of_campus AS campus_location,
    lc.adres AS campus_address,
    d.name_of_discipline,
    g.number AS group_number,
    g.academic_year
FROM Schedule s
JOIN Audience a ON s.audience_id = a.id
JOIN Location_of_campus lc ON a.location_id = lc.id
JOIN Lesson l ON s.lesson_id = l.id
JOIN Discipline d ON l.discipline_id = d.id
JOIN GroupOfStudents g ON l.group_id = g.id;
GO
-- 2. Представление с преподавателями и количеством проводимых занятий
use UniversityDB;
go
CREATE VIEW ProfessorActivityView AS
SELECT 
    p.id,
    p.full_name,
    p.position,
    COUNT(DISTINCT l.id) AS lessons_count
FROM Professor p
LEFT JOIN Lesson l ON p.id = l.professor_id
GROUP BY p.id, p.full_name, p.position
GO
-- 3. Представление с загруженностью аудиторий
use UniversityDB;
GO
CREATE VIEW AudienceUtilizationView AS
SELECT 
    a.id,
    a.number,
    a.type_of_audience,
    a.seat_count,
    lc.name_of_campus,
    COUNT(s.id) AS scheduled_lessons
FROM Audience a
JOIN Location_of_campus lc ON a.location_id = lc.id
LEFT JOIN Schedule s ON a.id = s.audience_id
GROUP BY a.id, a.number, a.type_of_audience, a.seat_count, lc.name_of_campus
GO
-- 4. Представление с расписанием по группам
use UniversityDB;
GO
CREATE VIEW GroupScheduleView AS
SELECT 
    g.id AS group_id, g.number AS group_number, g.academic_year,
    d.name_of_discipline, p.full_name AS professor, a.number AS audience,
    lc.name_of_campus, l.day_of_week, l.start_time, l.end_time
FROM GroupOfStudents g
JOIN Lesson l ON g.id = l.group_id
JOIN Discipline d ON l.discipline_id = d.id
JOIN Professor p ON l.professor_id = p.id
JOIN Schedule s ON l.id = s.lesson_id
JOIN Audience a ON s.audience_id = a.id
JOIN Location_of_campus lc ON a.location_id = lc.id
GO

-- 5. Представление с дисциплинами и количеством групп
use UniversityDB;
GO
CREATE VIEW DisciplineCoverageView AS
SELECT 
    d.id, d.code, d.name_of_discipline,
    COUNT(DISTINCT l.group_id) AS groups_count,
    COUNT(DISTINCT l.professor_id) AS professors_count
FROM Discipline d
LEFT JOIN Lesson l ON d.id = l.discipline_id
GROUP BY d.id, d.code, d.name_of_discipline
GO

SELECT * FROM LessonDetailsView
SELECT * FROM ProfessorActivityView
SELECT * FROM AudienceUtilizationView
SELECT * FROM GroupScheduleView
SELECT * FROM DisciplineCoverageView


-- 3 обновляемых представления с примерами операций

--Представление для базовой информации о преподавателях
go
CREATE VIEW ProfessorBasicView AS
SELECT id, full_name, position
FROM Professor;
go

-- INSERT
INSERT INTO ProfessorBasicView (full_name, position)
VALUES ('Петров Петр Петрович', 'Ассистент');

-- UPDATE
UPDATE ProfessorBasicView 
SET position = 'Старший преподаватель' 
WHERE id = 3;

SELECT * FROM ProfessorBasicView
--Представление для работы с группами студентов
go
CREATE VIEW GroupBasicView AS
SELECT id, number, academic_year
FROM GroupOfStudents
WHERE academic_year >= '2023-2024'; -- Только текущие и будущие группы
go

-- INSERT
INSERT INTO GroupBasicView (number, academic_year)
VALUES ('Группа 16', '2024-2025');

-- UPDATE
UPDATE GroupBasicView 
SET number = 'Группа 2' 
WHERE id = 1;

-- DELETE
DELETE FROM GroupBasicView 
WHERE id = 11;
SELECT * FROM GroupBasicView
--Представление для работы с аудиториями
go
CREATE VIEW AudienceBasicView AS
SELECT id, number,seat_count, type_of_audience, location_id
FROM Audience
WHERE seat_count > 20; -- Только аудитории с более чем 20 местами
go

-- INSERT
INSERT INTO AudienceBasicView (number, seat_count, type_of_audience, location_id)
VALUES ('205', 22, 'Лекционная', 3);

-- UPDATE
UPDATE AudienceBasicView 
SET type_of_audience = 'Компьютерный класс' 
WHERE id = 5;

-- DELETE
DELETE FROM AudienceBasicView 
WHERE id = 11;
SELECT * FROM AudienceBasicView

--Применение табличных переменных, временных таблиц 

--Пример с табличной переменной
DECLARE @CampusUsage TABLE (
    campus_id INT,
    campus_name NVARCHAR(100),
    audience_count INT,
    total_seats INT
);

INSERT INTO @CampusUsage
SELECT 
    lc.id,
    lc.name_of_campus,
    COUNT(a.id) AS audience_count,
    SUM(a.seat_count) AS total_seats
FROM Location_of_campus lc
LEFT JOIN Audience a ON lc.id = a.location_id
GROUP BY lc.id, lc.name_of_campus;

SELECT * FROM @CampusUsage


-- Пример с локальной временной таблицей
CREATE TABLE #TempDisciplineStats (
    discipline_id INT,
    discipline_name NVARCHAR(100),
    professor_count INT,
    group_count INT
);

INSERT INTO #TempDisciplineStats
SELECT 
    d.id,
    d.name_of_discipline,
    COUNT(DISTINCT l.professor_id) AS professor_count,
    COUNT(DISTINCT l.group_id) AS group_count
FROM Discipline d
LEFT JOIN Lesson l ON d.id = l.discipline_id
GROUP BY d.id, d.name_of_discipline;

SELECT * FROM #TempDisciplineStats
ORDER BY group_count DESC;

DROP TABLE #TempDisciplineStats;

--Пример с глобальной временной таблицей
CREATE TABLE ##GlobalProfessorWorkload (
    professor_id INT,
    professor_name NVARCHAR(100),
    position NVARCHAR(100),
    lesson_count INT
);

INSERT INTO ##GlobalProfessorWorkload
SELECT 
    p.id,
    p.full_name,
    p.position,
    COUNT(l.id) AS lesson_count
FROM Professor p
LEFT JOIN Lesson l ON p.id = l.professor_id
GROUP BY p.id, p.full_name, p.position;

SELECT * FROM ##GlobalProfessorWorkload
ORDER BY lesson_count DESC;

DROP TABLE ##GlobalProfessorWorkload;

--Пример с обобщенным табличным выражением
WITH GroupDisciplineStats AS (
    SELECT 
        g.id AS group_id,
        g.number AS group_number,
        g.academic_year,
        COUNT(DISTINCT l.discipline_id) AS disciplines_count,
        COUNT(l.id) AS lessons_count
    FROM GroupOfStudents g
    LEFT JOIN Lesson l ON g.id = l.group_id
    GROUP BY g.id, g.number, g.academic_year
)
SELECT 
    group_id,
    group_number,
    academic_year,
    disciplines_count,
    lessons_count,
    CASE 
        WHEN lessons_count > 10 THEN 'Высокая'
        WHEN lessons_count > 5 THEN 'Средняя'
        ELSE 'Низкая'
    END AS workload_level
FROM GroupDisciplineStats
ORDER BY academic_year DESC, lessons_count DESC;