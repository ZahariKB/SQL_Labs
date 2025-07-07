CREATE TABLE Audience (
id INT Identity Primary key,
number NVARCHAR(50) NOT NULL,
seat_count INT NOT NULL CHECK(seat_count > 0),
type_of_audience NVARCHAR(50) NOT NULL,
location_id INT NOT NULL,
constraint fk_Audience_Location FOREIGN KEY (location_id) REFERENCES Location_of_campus(id),
constraint uq_Audience_number UNIQUE(number, location_id)
);
