use UniversityDB;
CREATE TABLE Schedule (
	id INT PRIMARY KEY,
	audience_id INT NOT NULL,
	lesson_id INT NOT NULL
	CONSTRAINT fk_Schedule_Audience FOREIGN KEY (audience_id) REFERENCES Audience(id),
	CONSTRAINT fk_Schedule_Lesson FOREIGN KEY (lesson_id) REFERENCES Lesson(id),
);