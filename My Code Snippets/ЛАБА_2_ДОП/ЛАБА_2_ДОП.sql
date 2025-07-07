--Перекрестное соединение
use UniversityDB
SELECT 
    d.id AS discipline_id,
    d.name_of_discipline AS discipline_name,
    a.id AS audience_id,
    a.number AS audience_number,
    a.type_of_audience AS audience_type
FROM 
    Discipline d
CROSS JOIN 
    Audience a
ORDER BY 
    d.id, a.id;

--Полное внешнее соединение
USE UniversityDB
SELECT 
    d.id,
    d.name_of_discipline,
    a.id,
    a.number,
    a.type_of_audience
FROM 
    Discipline d
FULL OUTER JOIN 
    Schedule s ON d.id = s.lesson_id
FULL OUTER JOIN 
    Audience a ON s.audience_id = a.id
ORDER BY 
    d.id, a.id;

--Правое внешнее соединение 2
USE UniversityDB
SELECT Los.id, A.location_id, A.type_of_audience, A.seat_count, LOS.name_of_campus FROM Location_of_campus LOS
RIGHT OUTER JOIN Audience A ON A.location_id = Los.id
order by LOS.id

--Правое внешнее соединение 1
USE UniversityDB
SELECT D.id, L.discipline_id, D.name_of_discipline, L.type_of_lesson FROM Discipline D
RIGHT OUTER JOIN Lesson L ON L.discipline_id = D.id


--Внешнее левое соединение 2
USE UniversityDB
SELECT D.id, L.discipline_id, D.name_of_discipline, L.type_of_lesson FROM Discipline D
LEFT OUTER JOIN Lesson L ON L.discipline_id = D.id


--Внешнее левое соединение 1
USE UniversityDB
SELECT Los.id, A.location_id, LOS.name_of_campus FROM Location_of_campus LOS
LEFT OUTER JOIN Audience A ON A.location_id = Los.id
order by LOS.id

--внутреннее присоединение
USE UniversityDB
SELECT L.discipline_id, L.id, S.audience_id, A.location_id, D.name_of_discipline, LOS.name_of_campus, P.full_name  FROM Lesson L
JOIN Schedule S ON L.id = S.lesson_id
JOIN Audience A ON A.id = S.audience_id
jOIN Discipline D ON D.id = L.discipline_id
jOIN Location_of_campus LOS ON LOS.id = A.location_id
jOIN Professor P ON P.id = L.professor_id