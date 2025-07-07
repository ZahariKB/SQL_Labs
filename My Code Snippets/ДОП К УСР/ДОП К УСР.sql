USE UniversityDB;
SELECT day_of_week, type_of_lesson, COUNT(*) AS lesson_count
FROM Lesson
GROUP BY CUBE(day_of_week, type_of_lesson);
SELECT day_of_week, type_of_lesson, lesson_count
FROM (
    SELECT day_of_week, 
           MAX(CASE WHEN type_of_lesson = 'Лекция' THEN max_students ELSE 0 END) AS Лекция,
           MAX(CASE WHEN type_of_lesson = 'Практика' THEN max_students ELSE 0 END) AS Практика
    FROM Lesson
    GROUP BY day_of_week
) AS PivotTable
UNPIVOT (
    lesson_count FOR type_of_lesson IN (Лекция, Практика)
) AS UnpivotTable;
SELECT day_of_week, Lecture, Lab
FROM (
    SELECT type_of_lesson, day_of_week, COUNT(*) AS LessonCount
    FROM Lesson
    GROUP BY type_of_lesson, day_of_week
) AS SourceTable
PIVOT (
    SUM(LessonCount) FOR type_of_lesson IN (Lecture, Lab)
) AS PivotTable;
SELECT discipline_id, COUNT(*) OVER(PARTITION BY type_of_lesson) AS LessonCount
FROM Lesson;
SELECT academic_year, number, COUNT(*) AS GroupCount
FROM GroupOfStudents
GROUP BY GROUPING SETS((academic_year), (number), (academic_year, number));
SELECT type_of_lesson, day_of_week, COUNT(*) AS LessonCount
FROM Lesson
GROUP BY ROLLUP(type_of_lesson, day_of_week);
SELECT type_of_audience, SUM(seat_count) AS TotalSeats
FROM Audience
GROUP BY type_of_audience
HAVING SUM(seat_count) > 200;
SELECT academic_year, COUNT(*) AS GroupCount
FROM GroupOfStudents
GROUP BY academic_year
HAVING COUNT(*) = 2;
SELECT type_of_lesson, COUNT(*) AS LessonCount
FROM Lesson
GROUP BY type_of_lesson;
SELECT academic_year, COUNT(*) AS StudentCount
FROM GroupOfStudents
GROUP BY academic_year;
SELECT COUNT(*) AS ProfessorCount
FROM Professor;
SELECT AVG(seat_count) AS AvgSeats
FROM Audience;
SELECT MIN(academic_year) AS MinYear
FROM GroupOfStudents;
SELECT MAX(max_students) AS MaxStudents
FROM Lesson;
SELECT SUM(seat_count) AS TotalSeats
FROM Audience;
ALTER TABLE Audience
ADD CONSTRAINT CHK_Capacity_Positive CHECK (capacity > 0);
INSERT INTO Schedule(audience_id, lesson_id)
VALUES (12, 11),
       (13, 12);
INSERT INTO Lesson (discipline_id, professor_id, group_id, type_of_lesson, max_students, date_of_lesson, day_of_week, start_time, end_time)
VALUES (11, 11, 11, 'Практика', 50, '2025-09-08', 'Wednesday', '10:00:00.0000000','11:20:00.0000000'),
       (12, 12, 12, 'Лекция', 90, '2025-09-08', 'Wednesday', '11:20:00.0000000','12:35:00.0000000');
INSERT INTO GroupOfStudents (number, academic_year)
VALUES ('Группа 9', '2024-2025'),
       ('Группа 10','2018-2019');
INSERT INTO Professor (full_name, position)
VALUES ('Орлович Юрий Леонидович', 'Декан'),
       ('Мартыненко Игнат Михайлович','Заместитель декана');
INSERT INTO Location_of_campus (name_of_campus, adres)
VALUES ('Корпус института бизнеса', 'ул. Обойная 7'),
       ('Корпус факультета международных отношений','ул. Ленинградская 20');
INSERT INTO Audience (number, seat_count, type_of_audience, location_id)
VALUES ('300-a', 30, 'Практическая', 6),
       ('521', 120, 'Лекционная', 9);
INSERT INTO Discipline (code, name_of_discipline)
VALUES ('DFUR198', 'Дифференциальные уравнения'),
       ('OP059', 'Основы права');
EXEC sp_rename 'StudentGroup', 'GroupOfStudents';
SELECT id, name_of_campus, adres
FROM Location_of_campus
WHERE adres LIKE 'ул. Курчатова%';
SELECT id, number, academic_year
FROM StudentGroup
WHERE academic_year = '2023-2024';
SELECT id, audience_id, lesson_id
FROM Schedule
WHERE audience_id = 1;
SELECT id, discipline_id, professor_id, group_id, type_of_lesson, max_students, date_of_lesson, day_of_week, start_time, end_time
FROM Lesson
WHERE day_of_week = 'Monday';
SELECT number, seat_count, type_of_audience
FROM Audience
WHERE seat_count > 50;
SELECT id, full_name, position
FROM Professor
WHERE position = 'Старший преподаватель';
SELECT id, code, name_of_discipline
FROM Discipline
WHERE code LIKE 'CS%';
SELECT *
INTO StudentGroupBackup
FROM StudentGroup;
SELECT full_name, position
FROM Professor
ORDER BY LEN(full_name) ASC;
SELECT *
FROM Location_of_campus
ORDER BY name_of_campus DESC
OFFSET 3 ROWS FETCH NEXT 4 ROWS ONLY;
SELECT TOP 5 *
FROM Professor;
SELECT TOP 30 PERCENT *
FROM Schedule;
SELECT DISTINCT type_of_lesson, 
DATEDIFF(MINUTE, start_time, end_time) AS lesson_duration
FROM Lesson;
SELECT number, academic_year
FROM StudentGroup
ORDER BY number DESC, academic_year DESC
SELECT full_name, position
FROM Professor
ORDER BY full_name;
--1
SELECT * FROM Audience;
SELECT * FROM Discipline;
SELECT * FROM Lesson;
SELECT * FROM Location_of_campus;
SELECT * FROM Professor;
SELECT * FROM Schedule;
SELECT * FROM StudentGroup;
