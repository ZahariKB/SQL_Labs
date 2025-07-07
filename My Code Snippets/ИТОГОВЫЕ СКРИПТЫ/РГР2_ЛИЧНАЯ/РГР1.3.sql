CREATE TABLE Location (
    id INT IDENTITY(1,1) PRIMARY KEY, 
    name NVARCHAR(255) NOT NULL, 
    address NVARCHAR(500) NOT NULL, 
    CONSTRAINT uq_Location_name UNIQUE (name) 
);
