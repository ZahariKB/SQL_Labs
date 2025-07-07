-- AFTER INSERT триггер для таблицы Professor
USE UniversityDB
go
CREATE TRIGGER tr_Professor_AfterInsert
ON Professor
AFTER INSERT
AS
BEGIN
    PRINT 'AFTER INSERT: Добавлен новый преподаватель'
    SELECT * FROM inserted
END
GO
--демонстрация
use UniversityDB
-- Вставка нового преподавателя
INSERT INTO Professor(full_name, position) 
VALUES ('Иванов Иван Михайлович', 'Доцент')


-- AFTER UPDATE триггер для таблицы Discipline
go
CREATE TRIGGER tr_Discipline_AfterUpdate
ON Discipline
AFTER UPDATE
AS
BEGIN
    PRINT 'AFTER UPDATE: Данные дисциплины изменены'
    SELECT 'Старые значения' AS Info, * FROM deleted
    SELECT 'Новые значения' AS Info, * FROM inserted
END
GO

--демонстрация
-- Обновление дисциплины
UPDATE Discipline 
SET name_of_discipline = 'молекулярная химия' 
WHERE id = 1


-- AFTER DELETE триггер для таблицы GroupOfStudents
go
CREATE TRIGGER tr_Group_AfterDelete
ON GroupOfStudents
AFTER DELETE
AS
BEGIN
    PRINT 'AFTER DELETE: Удалена группа'
    SELECT * FROM deleted
END
GO

--демонстрация
-- Удаление группы
DELETE FROM GroupOfStudents 
WHERE id = 13

----------------------------------------------------------

-- INSTEAD OF INSERT для таблицы Audience
go
CREATE TRIGGER tr_Audience_InsteadOfInsert
ON Audience
INSTEAD OF INSERT
AS
BEGIN
    PRINT 'INSTEAD OF INSERT: Проверка данных перед вставкой'
    
    -- Проверка количества мест
    IF EXISTS (SELECT 1 FROM inserted WHERE seat_count <= 0)
    BEGIN
        RAISERROR('Количество мест должно быть больше 0', 16, 1)
        RETURN
    END
    
    -- Вставка с явным указанием столбцов (кроме ID)
    INSERT INTO Audience (
        number, 
        seat_count, 
        type_of_audience, 
        location_id
    )
    SELECT 
        number, 
        seat_count, 
        type_of_audience, 
        location_id
    FROM inserted
END
go
--демонстрация
--Попытка вставить некорректные данные
use UniversityDB
INSERT INTO Audience(number, seat_count, type_of_audience, location_id)
VALUES ('102', 0, 'Практическая', 1)


-- INSTEAD OF UPDATE для представления (пример)
go
CREATE VIEW vw_ProfessorInfo AS
SELECT id, full_name, position FROM Professor
GO

go
CREATE TRIGGER tr_vwProfessor_InsteadOfUpdate
ON vw_ProfessorInfo
INSTEAD OF UPDATE
AS
BEGIN
    PRINT 'INSTEAD OF UPDATE: Обновление через представление'
    UPDATE Professor
    SET full_name = i.full_name,
        position = i.position
    FROM Professor p
    INNER JOIN inserted i ON p.id = i.id
END
GO

--демонстрация
-- Выполним обновление через представление

UPDATE vw_ProfessorInfo 
SET full_name = 'Новое имя', position = 'Новая должность'
WHERE id = 1

-- Проверим результат
SELECT * FROM vw_ProfessorInfo WHERE id = 1
SELECT * FROM Professor WHERE id = 1

-----------------------------------------------

-- Процедура 1: Подсчет преподавателей по должности
go
CREATE PROCEDURE sp_CountProfessorsByPosition
    @position NVARCHAR(100),
    @count INT OUTPUT
AS
BEGIN
    SELECT @count = COUNT(*) 
    FROM Professor 
    WHERE position = @position
END
GO

-- Процедура 2: Получение средней вместимости аудиторий
go
CREATE PROCEDURE sp_GetAverageAudienceCapacity
    @campus_id INT,
    @avg_capacity INT OUTPUT
AS
BEGIN
    SELECT @avg_capacity = AVG(seat_count)
    FROM Audience
    WHERE location_id = @campus_id
END
GO

-- Пример вызова
go
DECLARE @prof_count INT, @avg_seats INT
EXEC sp_CountProfessorsByPosition 'Доцент', @prof_count OUTPUT
EXEC sp_GetAverageAudienceCapacity 3, @avg_seats OUTPUT
SELECT 
    @prof_count AS 'Количество доцентов',
    @avg_seats AS 'Средняя вместимость аудиторий'
GO

-----------------------------------------------------------------

-- Транзакция 1: Обновление данных с проверкой
go
BEGIN TRANSACTION UpdateProfessorData
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRY
    UPDATE Professor
    SET position = 'Старший преподаватель'
    WHERE id = 3
    
    UPDATE Lesson
    SET max_students = 25
    WHERE professor_id = 3
    
    COMMIT TRANSACTION
    PRINT 'Данные успешно обновлены'
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION
    PRINT 'Ошибка: ' + ERROR_MESSAGE()
END CATCH
GO
-- Транзакция 2: Удаление с проверкой зависимостей
go
BEGIN TRANSACTION DeleteDiscipline
BEGIN TRY
    DECLARE @discipline_id INT = 10
    
    IF EXISTS (SELECT 1 FROM Lesson WHERE discipline_id = @discipline_id)
    BEGIN
        RAISERROR('Невозможно удалить дисциплину: есть связанные занятия', 16, 1)
    END
    ELSE
    BEGIN
        DELETE FROM Discipline WHERE id = @discipline_id
        COMMIT TRANSACTION
        PRINT 'Дисциплина удалена'
    END
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION
    PRINT 'Ошибка: ' + ERROR_MESSAGE()
END CATCH
GO

--------------------------------------------------------

-- Пример 1: Вставка с проверкой дубликатов
go
BEGIN TRANSACTION InsertNewGroup
BEGIN TRY
    IF EXISTS (SELECT 1 FROM GroupOfStudents WHERE number = 'Группа 99')
    BEGIN
        RAISERROR('Группа с таким номером уже существует', 16, 1)
    END
    ELSE
    BEGIN
        INSERT INTO GroupOfStudents (number, academic_year)
        VALUES ('Группа 99', '2024-2025')
        
        COMMIT TRANSACTION
        PRINT 'Группа добавлена'
    END
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION
    PRINT 'Ошибка: ' + ERROR_MESSAGE()
END CATCH
GO

-- Пример 2: Комплексное обновление с откатом при ошибке
go
BEGIN TRANSACTION UpdateCampusData
BEGIN TRY
    UPDATE Location_of_campus
    SET name_of_campus = 'Новый корпус'
    WHERE id = 5
    
    -- Имитация ошибки
    IF 1 = 1
        RAISERROR('Тестовая ошибка', 16, 1)
    
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION
    PRINT 'Транзакция отменена: ' + ERROR_MESSAGE()
END CATCH
GO