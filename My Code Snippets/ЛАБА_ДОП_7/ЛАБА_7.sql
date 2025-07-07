-- AFTER INSERT ������� ��� ������� Professor
USE UniversityDB
go
CREATE TRIGGER tr_Professor_AfterInsert
ON Professor
AFTER INSERT
AS
BEGIN
    PRINT 'AFTER INSERT: �������� ����� �������������'
    SELECT * FROM inserted
END
GO
--������������
use UniversityDB
-- ������� ������ �������������
INSERT INTO Professor(full_name, position) 
VALUES ('������ ���� ����������', '������')


-- AFTER UPDATE ������� ��� ������� Discipline
go
CREATE TRIGGER tr_Discipline_AfterUpdate
ON Discipline
AFTER UPDATE
AS
BEGIN
    PRINT 'AFTER UPDATE: ������ ���������� ��������'
    SELECT '������ ��������' AS Info, * FROM deleted
    SELECT '����� ��������' AS Info, * FROM inserted
END
GO

--������������
-- ���������� ����������
UPDATE Discipline 
SET name_of_discipline = '������������ �����' 
WHERE id = 1


-- AFTER DELETE ������� ��� ������� GroupOfStudents
go
CREATE TRIGGER tr_Group_AfterDelete
ON GroupOfStudents
AFTER DELETE
AS
BEGIN
    PRINT 'AFTER DELETE: ������� ������'
    SELECT * FROM deleted
END
GO

--������������
-- �������� ������
DELETE FROM GroupOfStudents 
WHERE id = 13

----------------------------------------------------------

-- INSTEAD OF INSERT ��� ������� Audience
go
CREATE TRIGGER tr_Audience_InsteadOfInsert
ON Audience
INSTEAD OF INSERT
AS
BEGIN
    PRINT 'INSTEAD OF INSERT: �������� ������ ����� ��������'
    
    -- �������� ���������� ����
    IF EXISTS (SELECT 1 FROM inserted WHERE seat_count <= 0)
    BEGIN
        RAISERROR('���������� ���� ������ ���� ������ 0', 16, 1)
        RETURN
    END
    
    -- ������� � ����� ��������� �������� (����� ID)
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
--������������
--������� �������� ������������ ������
use UniversityDB
INSERT INTO Audience(number, seat_count, type_of_audience, location_id)
VALUES ('102', 0, '������������', 1)


-- INSTEAD OF UPDATE ��� ������������� (������)
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
    PRINT 'INSTEAD OF UPDATE: ���������� ����� �������������'
    UPDATE Professor
    SET full_name = i.full_name,
        position = i.position
    FROM Professor p
    INNER JOIN inserted i ON p.id = i.id
END
GO

--������������
-- �������� ���������� ����� �������������

UPDATE vw_ProfessorInfo 
SET full_name = '����� ���', position = '����� ���������'
WHERE id = 1

-- �������� ���������
SELECT * FROM vw_ProfessorInfo WHERE id = 1
SELECT * FROM Professor WHERE id = 1

-----------------------------------------------

-- ��������� 1: ������� �������������� �� ���������
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

-- ��������� 2: ��������� ������� ����������� ���������
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

-- ������ ������
go
DECLARE @prof_count INT, @avg_seats INT
EXEC sp_CountProfessorsByPosition '������', @prof_count OUTPUT
EXEC sp_GetAverageAudienceCapacity 3, @avg_seats OUTPUT
SELECT 
    @prof_count AS '���������� ��������',
    @avg_seats AS '������� ����������� ���������'
GO

-----------------------------------------------------------------

-- ���������� 1: ���������� ������ � ���������
go
BEGIN TRANSACTION UpdateProfessorData
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRY
    UPDATE Professor
    SET position = '������� �������������'
    WHERE id = 3
    
    UPDATE Lesson
    SET max_students = 25
    WHERE professor_id = 3
    
    COMMIT TRANSACTION
    PRINT '������ ������� ���������'
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION
    PRINT '������: ' + ERROR_MESSAGE()
END CATCH
GO
-- ���������� 2: �������� � ��������� ������������
go
BEGIN TRANSACTION DeleteDiscipline
BEGIN TRY
    DECLARE @discipline_id INT = 10
    
    IF EXISTS (SELECT 1 FROM Lesson WHERE discipline_id = @discipline_id)
    BEGIN
        RAISERROR('���������� ������� ����������: ���� ��������� �������', 16, 1)
    END
    ELSE
    BEGIN
        DELETE FROM Discipline WHERE id = @discipline_id
        COMMIT TRANSACTION
        PRINT '���������� �������'
    END
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION
    PRINT '������: ' + ERROR_MESSAGE()
END CATCH
GO

--------------------------------------------------------

-- ������ 1: ������� � ��������� ����������
go
BEGIN TRANSACTION InsertNewGroup
BEGIN TRY
    IF EXISTS (SELECT 1 FROM GroupOfStudents WHERE number = '������ 99')
    BEGIN
        RAISERROR('������ � ����� ������� ��� ����������', 16, 1)
    END
    ELSE
    BEGIN
        INSERT INTO GroupOfStudents (number, academic_year)
        VALUES ('������ 99', '2024-2025')
        
        COMMIT TRANSACTION
        PRINT '������ ���������'
    END
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION
    PRINT '������: ' + ERROR_MESSAGE()
END CATCH
GO

-- ������ 2: ����������� ���������� � ������� ��� ������
go
BEGIN TRANSACTION UpdateCampusData
BEGIN TRY
    UPDATE Location_of_campus
    SET name_of_campus = '����� ������'
    WHERE id = 5
    
    -- �������� ������
    IF 1 = 1
        RAISERROR('�������� ������', 16, 1)
    
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION
    PRINT '���������� ��������: ' + ERROR_MESSAGE()
END CATCH
GO