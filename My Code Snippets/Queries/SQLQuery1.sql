USE UniversityDB
SELECT * FROM Audience
SELECT * FROM Discipline
SELECT * FROM GroupOfStudents
SELECT * FROM Lesson
SELECT * FROM Location_of_campus
SELECT * FROM Professor
SELECT * FROM Schedule

USE UniversityDB;
UPDATE Schedule
SET audience_id = 4
WHERE id = 11


USE UniversityDB
SELECT A.id, A.number, A.seat_count, A.type_of_audience, L.type_of_lesson, L.max_students, L.date_of_lesson 
FROM Schedule S
JOIN Audience A ON A.id = S.audience_id
JOIN Lesson L ON L.id = S.lesson_id
WHERE A.id = 4