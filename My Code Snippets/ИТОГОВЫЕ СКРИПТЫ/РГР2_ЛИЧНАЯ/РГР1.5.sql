use UniversityDB
CREATE TABLE Professor (
    id INT IDENTITY PRIMARY KEY, 
    full_name NVARCHAR(255) NOT NULL,
	position NVARCHAR(100) DEFAULT('Преподаватель')
);