USE Ucheb_8_Tuiev;
SELECT * FROM Student
WHERE ((godpost > 2016) AND (spez = 'математика'))
OR ((godpost > 2018) AND (spez='физика'))