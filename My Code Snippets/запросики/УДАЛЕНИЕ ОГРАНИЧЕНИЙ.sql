USE UniversityDB
SELECT * FROM Discipline
SELECT * FROM Audience
SELECT * FROM Location_of_campus
SELECT * FROM Lesson
SELECT * FROM Professor
SELECT * FROM Schedule
SELECT * FROM GroupOfStudents


--удалить ограничение
ALTER TABLE Audience DROP CONSTRAINT CHK_Capacity_Positive;
--удалить столбец
ALTER TABLE Audience DROP COLUMN capacity;


--отключение ограничений
USE UniversityDB
ALTER TABLE Audience NOCHECK CONSTRAINT fk_Audience_Location;
UPDATE Audience SET  location_id = 6 WHERE id = 4;
ALTER TABLE Audience CHECK CONSTRAINT fk_Audience_Location;
