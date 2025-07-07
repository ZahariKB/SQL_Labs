use UniversityDB
CREATE TABLE Discipline (
    id INT IDENTITY PRIMARY KEY, 
    code NVARCHAR(50) UNIQUE NOT NULL, 
    name_of_discipline NVARCHAR(255) NOT NULL 
);