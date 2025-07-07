CREATE DATABASE UniversityDB
ON
(
    NAME = UniversityDB_Data, 
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\UniversityDB_Data.mdf', 
    SIZE = 10MB, 
    MAXSIZE = 100MB,
    FILEGROWTH = 5MB
)
LOG ON
(
    NAME = UniversityDB_Log, 
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\UniversityDB_Log.ldf', 
    SIZE = 5MB, 
    MAXSIZE = 50MB, 
    FILEGROWTH = 5MB 
);

