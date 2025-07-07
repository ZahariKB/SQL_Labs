use UniversityDB
CREATE TABLE Lesson (
    id INT IDENTITY(1,1) PRIMARY KEY, 
	discipline_id INT NOT NULL,
	professor_id INT NOT NULL,
	group_id INT NOT NULL,
	type_of_lesson NVARCHAR(20) DEFAULT('Лекция'),
	max_students INT NOT NULL CHECK(max_students > 0),
	date_of_lesson DATE NOT NULL,
	day_of_week NVARCHAR(10) NOT NULL CHECK(day_of_week IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday')),
	start_time TIME NOT NULL,
	end_time TIME NOT NULL,
	CONSTRAINT fk_Lesson_Discipline FOREIGN KEY (discipline_id) REFERENCES Discipline(id),
	CONSTRAINT fk_Lesson_Professor FOREIGN KEY (professor_id) REFERENCES Professor(id),
	CONSTRAINT fk_Lesson_Group FOREIGN KEY (group_id) REFERENCES StudentGroup(id)
);