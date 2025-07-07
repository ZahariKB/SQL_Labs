use UniversityDB
CREATE TABLE StudentGroup (
    id INT IDENTITY PRIMARY KEY, 
	number NVARCHAR(50) NOT NULL,
	academic_year NVARCHAR(9) NOT NULL CHECK (CAST(SUBSTRING(academic_year, 1, 4) AS INT) >= 2000)
);