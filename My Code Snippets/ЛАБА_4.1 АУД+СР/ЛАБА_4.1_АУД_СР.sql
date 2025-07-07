USE Ucheb_8_Tuiev

-- 1 Даны числа A и B. Найти и вывести их произведение. 
DECLARE @A INT = 5, @B INT = 7, @Product INT
SET @Product = @A * @B
PRINT 'Произведение: ' + CAST(@Product AS VARCHAR(10));

-- 2 В таблице «Ученики» найти разницу между средними баллами лицеистов и гимназистов
DECLARE @AvgLicey FLOAT, @AvgGimn FLOAT, @Diff FLOAT
SET @AvgLicey = (SELECT AVG(ball) FROM Table_uch1 WHERE ush = 'лицей')
SET @AvgGimn = (SELECT AVG(ball) FROM Table_uch1 WHERE ush = 'гимназия')
SET @Diff = ABS(@AvgLicey - @AvgGimn)
PRINT 'Разница средних баллов: ' + CAST(@Diff AS VARCHAR(10));

-- 3 В таблице «Ученики» проверить на четность количество строк. 
DECLARE @RowCount INT
SELECT @RowCount = COUNT(*) FROM Table_uch1
IF @RowCount % 2 = 0
	PRINT 'Количество строк четное'
ELSE
	PRINT 'Количество строк нечетное';

-- 4 Дано четырехзначное число. Вывести сумму его цифр. 
DECLARE @Num INT = 1234, @Sum INT = 0
SET @Sum = @Num/1000 + (@Num/100)%10 + (@Num/10)%10 + @Num%10
PRINT 'Сумма цифр: ' + CAST(@Sum AS VARCHAR(4));

-- 5 Даны случайные целые числа a, b и c. Найти наименьшее из них. 
DECLARE @a INT = rand() * 10, @b INT = rand() * 10, @c INT = rand()*10, @Min INT
SET @Min = CASE 
	WHEN @a <= @b AND @a <= @c THEN @a
	WHEN @b <= @a AND @b <= @c THEN @b
	ELSE @c
END
PRINT 'Наименьшее число: ' + CAST(@Min AS VARCHAR(3));

-- 6 Дано случайное целое число a. Проверить, делится ли данное число на 11. 
DECLARE @Num6 INT = rand() * 100
IF @Num6 % 11 = 0
	PRINT CAST(@Num6 AS VARCHAR(8)) + ' делится на 11'
ELSE
	PRINT CAST(@Num6 AS VARCHAR(8)) + ' не делится на 11';

-- 7 Дано случайное целое число N (N < 1000). Если оно является степенью числа 3, то вывести «Да», если не является – вывести «Нет». 
DECLARE @N INT = rand() * 1000
DECLARE @Temp INT = @N
WHILE @Temp % 3 = 0 AND @Temp > 1
	SET @Temp = @Temp / 3
IF @Temp = 1
	PRINT 'Да'
ELSE
	PRINT 'Нет';

DECLARE @a8 INT = RAND() * 100, @b8 INT = RAND() * 100, @GCD INT, @LCM INT
DECLARE @x INT = @a8, @y INT = @b8
WHILE @x <> @y
	IF @x > @y SET @x = @x - @y ELSE SET @y = @y - @x
SET @GCD = @x
SET @LCM = @a8 * @b8 / @GCD
PRINT '@a8: ' + CAST(@a8 AS VARCHAR(8)) 
PRINT '@b8: ' + CAST(@b8 AS VARCHAR(8))
PRINT 'НОК: ' + CAST(@LCM AS VARCHAR(8));

-- 9 Даны два целых числа A и B (A<B). Найти сумму квадратов всех целых чисел от A до B включительно.
DECLARE @A9 INT = 2, @B9 INT = 7, @SumSq INT = 0
WHILE @A9 <= @B9
BEGIN
	SET @SumSq = @SumSq + @A9 * @A9
	SET @A9 = @A9 + 1
END
PRINT 'Сумма квадратов: ' + CAST(@SumSq AS VARCHAR(12));

-- 10 Найти первое натуральное число, которое при делении на 2, 3, 4, 5, и 6 дает остаток 1, но делится на 7.
DECLARE @Num10 INT = 1
WHILE 1=1
BEGIN
	IF @Num10 % 2 = 1 AND @Num10 % 3 = 1 AND @Num10 % 4 = 1 AND 
	@Num10 % 5 = 1 AND @Num10 % 6 = 1 AND @Num10 % 7 = 0
	BEGIN
		PRINT 'Найдено число: ' + CAST(@Num10 AS VARCHAR(10))
		BREAK
	END
	SET @Num10 = @Num10 + 1
END;

-- 11 Вывести свою фамилию на экран столько раз, сколько в ней букв.
DECLARE @LastName VARCHAR(5) = 'Тюев'
DECLARE @Count INT = LEN(@LastName)
WHILE @Count > 0
BEGIN
    PRINT @LastName
    SET @Count = @Count - 1
END;











DECLARE @L2 INT, @M2 INT, @N2 CHAR(13)
SET @N2 = 'Нижневартовск'
SET @L2 = LEN(@N2)
SET @M2 = @L2
WHILE @L2 > 0
BEGIN
	PRINT LEFT(@N2, @L2) + SPACE(2 * (@M2 - @L2)) + RIGHT(REVERSE(@N2), @L2)
	SET @L2 = @L2 - 1
END
SET @L2 = 2
WHILE @L2 <= @M2
BEGIN
	PRINT LEFT(@N2, @L2) + SPACE(2 * (@M2 - @L2)) + RIGHT(REVERSE(@N2), @L2)
	SET @L2 = @L2 + 1 
END;


DECLARE @l INT, @n1 CHAR(13) = 'Нижневартовск'
SET @l = LEN(@n1)
WHILE @l > 0
BEGIN
	PRINT @n1
	SET @l = @l - 1
END;



DECLARE @D INT = 31, @M1 INT = 12
SET @D = CASE
	WHEN @M1 IN (1, 3, 5, 7, 8, 10, 12) AND @D = 31 THEN 1
	WHEN @M1 IN (4, 6, 9, 11) AND @D = 30 THEN 1
	WHEN @M1 = 2 AND @D = 29 THEN 1
	ELSE @D + 1
END;


SET @M1 = CASE
	WHEN @D = 1 AND @M1 = 12 THEN 1
	WHEN @D = 1 AND @M1 < 12 THEN @M1 + 1
	ELSE @M1
END
PRINT CAST(@D AS VARCHAR(2)) + '/' + CAST(@M1 AS VARCHAR(2));


DECLARE @a8 INT = 10
WHILE @a8 < 100
BEGIN
	IF (@a8 % 4 = 0) and (@a8 % 6 != 0)
		PRINT @a8
	SET @a8 = @a8 + 1
END;


DECLARE @A7 INT = RAND() * 5, @C7 INT = 1
DECLARE @B7 INT = @A7 + RAND() * 5
PRINT '@a7 = ' + CAST(@A7 AS CHAR(1)) + ', @B7 = ' +
CAST(@B7 AS CHAR(1))
WHILE @A7 <= @B7
BEGIN
	PRINT REPLICATE(@A7, @C7)
	SET @A7 = @A7 + 1
	SET @C7 = @C7 + 1
END;



DECLARE @N INT = RAND() * 10, @M INT = 1, @S1 INT = 0
WHILE @M <= 2 * @N - 1
BEGIN
	SET @S1 = @S1 + @M
	PRINT @S1
	SET @M = @M + 2
END;


DECLARE @a6 INT = 5, @b6 INT = 10, @s INT = 0
WHILE @a6 <= @b6
BEGIN
	SET @s = @s + @a6
	SET @a6 = @a6 + 1
END
PRINT 'Сумма = ' + CAST(@s as varchar(4));


DECLARE @a5 INT = RAND() * 1000, @b5 INT = RAND() *  1000
print '@a5 = ' + CAST(@a5 AS VARCHAR(4))
print '@b5 = ' + CAST(@b5 AS VARCHAR(4))
WHILE @a5 != @b5
BEGIN 
	IF @a5 > @b5
		SET @a5 = @a5 - @b5
	ELSE
		SET @b5 = @b5 - @a5
END
PRINT 'НОД = ' + CAST(@a5 AS VARCHAR(4));


DECLARE @a4 INT = RAND() * 1000
WHILE @a4 % 5 = 0
	SET @a4 = @a4 / 5
IF @a4 = 1
	PRINT 'Да'
ELSE
	PRINT 'Нет';


DECLARE @a3 INT = RAND() * 100
IF @a3 % 3 = 0
	PRINT CAST(@a3 AS VARCHAR(3)) + ' делится на 3'
ELSE
	PRINT CAST(@a3 AS VARCHAR(3)) + ' не делится на 3';




DECLARE @a2 INT = RAND() * 100, @b2 INT =  RAND() * 100
IF @a2 > @b2
	PRINT '@a2 = ' + CAST(@a2 AS VARCHAR(3))
ELSE
	PRINT '@b2 = ' + CAST(@b2 AS VARCHAR(3));


DECLARE @a1 INT, @b1 INT
SET @a1 = RAND() * 1000
SET @b1 = SQUARE(@a1)
PRINT @a1
PRINT @b1;




DECLARE @maxp FLOAT, @minp FLOAT, @difff FLOAT
SELECT @maxp = MAX(ball), @minp = MIN(ball) FROM Table_uch1
SET @difff = @maxp - @minp 
PRINT @difff;



DECLARE @licey FLOAT, @gimn FLOAT, @diff FLOAT
SET @licey = (SELECT MAX(ball) FROM Table_uch1 WHERE ush = 'Лицей')
SET @gimn = (SELECT MAX(ball) FROM Table_uch1 WHERE ush = 'Гимназия')
SET @diff = ABS(@licey - @gimn)
PRINT @diff;


DECLARE @a INT, @b INT, @c INT
SET @a = 5
SET @b = 10
SET @c = @a + @b 
PRINT @c;


--создание таблицы и заполнение данными
CREATE TABLE Table_uch1 (
    id INT IDENTITY(1,1) PRIMARY KEY, 
    fio NVARCHAR(50) NOT NULL,
    predmet NVARCHAR(50) NOT NULL,
    ush NVARCHAR(50) NOT NULL,
    ball DECIMAL(5,1) NOT NULL
);
INSERT INTO Table_uch1 (fio, predmet, ush, ball)
VALUES
    (N'Ивановна', N'математика', N'лицей', 98.5),
    (N'Петров', N'физика', N'лицей', 99.0),
    (N'Сидоров', N'математика', N'лицей', 88.0),
    (N'Полухина', N'физика', N'гимназия', 78.0),
    (N'Матвеева', N'химия', N'лицей', 92.0),
    (N'Касимов', N'химия', N'гимназия', 68.0),
    (N'Нестеров', N'математика', N'гимназия', 81.0),
    (N'Авдеев', N'физика', N'лицей', 87.0),
    (N'Никитина', N'химия', N'лицей', 94.0),
    (N'Барышев', N'химия', N'лицей', 88.0);
