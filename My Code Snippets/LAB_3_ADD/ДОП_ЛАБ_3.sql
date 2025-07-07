use UniversityDB

--�������� 3
SELECT p.full_name
FROM Professor p
WHERE EXISTS (
    SELECT 1
    FROM Lesson l
    JOIN Schedule s ON l.id = s.lesson_id
    JOIN Audience a ON s.audience_id = a.id
    WHERE l.professor_id = p.id
    AND a.type_of_audience = '������������ �����'
);

--��������� 2
SELECT d.name_of_discipline
FROM Discipline d
JOIN Lesson l ON d.id = l.discipline_id
WHERE l.professor_id IN (
    SELECT id 
    FROM Professor 
    WHERE position = '������'
);

--��������� 1
SELECT number, seat_count, type_of_audience
FROM Audience
WHERE seat_count > (SELECT AVG(seat_count) FROM Audience);

--��������
SELECT p.full_name AS professor_name
FROM Professor p
JOIN Lesson l ON p.id = l.professor_id
JOIN Discipline d ON l.discipline_id = d.id
WHERE d.name_of_discipline IN ('������� ��������', '�����������', '������ �����')
EXCEPT
SELECT p.full_name
FROM Professor p
JOIN Lesson l ON p.id = l.professor_id
JOIN Discipline d ON l.discipline_id = d.id
WHERE d.name_of_discipline IN ('�������������� ������', '������', '�����');

SELECT a.number AS audience_number
FROM Audience a
JOIN Schedule s ON a.id = s.audience_id
JOIN Lesson l ON s.lesson_id = l.id
WHERE l.type_of_lesson = '������'
EXCEPT
SELECT a.number
FROM Audience a
JOIN Schedule s ON a.id = s.audience_id
JOIN Lesson l ON s.lesson_id = l.id
WHERE l.type_of_lesson = '��������';

--�����������
SELECT d.name_of_discipline, a.number
FROM Discipline d
JOIN Lesson l ON d.id = l.discipline_id
JOIN Schedule s ON l.id = s.lesson_id
JOIN Audience a ON s.audience_id = a.id
WHERE l.type_of_lesson = '������'
INTERSECT
SELECT d.name_of_discipline, a.number
FROM Discipline d
JOIN Lesson l ON d.id = l.discipline_id
JOIN Schedule s ON l.id = s.lesson_id
JOIN Audience a ON s.audience_id = a.id
JOIN Location_of_campus loc ON a.location_id = loc.id
WHERE loc.name_of_campus = '������� ������ ���';


--�����������
use UniversityDB
SELECT location_id, number, type_of_audience FROM Audience
UNION
SELECT * FROM Location_of_campus
--�����������
SELECT * FROM Discipline 
WHERE code = 'MA101'
UNION 
SELECT * FROM Professor
WHERE full_name = '����� ������� ���������'
