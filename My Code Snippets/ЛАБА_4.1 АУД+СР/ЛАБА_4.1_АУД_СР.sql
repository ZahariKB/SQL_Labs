USE Ucheb_8_Tuiev

-- 1 ���� ����� A � B. ����� � ������� �� ������������. 
DECLARE @A INT = 5, @B INT = 7, @Product INT
SET @Product = @A * @B
PRINT '������������: ' + CAST(@Product AS VARCHAR(10));

-- 2 � ������� �������� ����� ������� ����� �������� ������� ��������� � �����������
DECLARE @AvgLicey FLOAT, @AvgGimn FLOAT, @Diff FLOAT
SET @AvgLicey = (SELECT AVG(ball) FROM Table_uch1 WHERE ush = '�����')
SET @AvgGimn = (SELECT AVG(ball) FROM Table_uch1 WHERE ush = '��������')
SET @Diff = ABS(@AvgLicey - @AvgGimn)
PRINT '������� ������� ������: ' + CAST(@Diff AS VARCHAR(10));

-- 3 � ������� �������� ��������� �� �������� ���������� �����. 
DECLARE @RowCount INT
SELECT @RowCount = COUNT(*) FROM Table_uch1
IF @RowCount % 2 = 0
	PRINT '���������� ����� ������'
ELSE
	PRINT '���������� ����� ��������';

-- 4 ���� �������������� �����. ������� ����� ��� ����. 
DECLARE @Num INT = 1234, @Sum INT = 0
SET @Sum = @Num/1000 + (@Num/100)%10 + (@Num/10)%10 + @Num%10
PRINT '����� ����: ' + CAST(@Sum AS VARCHAR(4));

-- 5 ���� ��������� ����� ����� a, b � c. ����� ���������� �� ���. 
DECLARE @a INT = rand() * 10, @b INT = rand() * 10, @c INT = rand()*10, @Min INT
SET @Min = CASE 
	WHEN @a <= @b AND @a <= @c THEN @a
	WHEN @b <= @a AND @b <= @c THEN @b
	ELSE @c
END
PRINT '���������� �����: ' + CAST(@Min AS VARCHAR(3));

-- 6 ���� ��������� ����� ����� a. ���������, ������� �� ������ ����� �� 11. 
DECLARE @Num6 INT = rand() * 100
IF @Num6 % 11 = 0
	PRINT CAST(@Num6 AS VARCHAR(8)) + ' ������� �� 11'
ELSE
	PRINT CAST(@Num6 AS VARCHAR(8)) + ' �� ������� �� 11';

-- 7 ���� ��������� ����� ����� N (N < 1000). ���� ��� �������� �������� ����� 3, �� ������� ���, ���� �� �������� � ������� ����. 
DECLARE @N INT = rand() * 1000
DECLARE @Temp INT = @N
WHILE @Temp % 3 = 0 AND @Temp > 1
	SET @Temp = @Temp / 3
IF @Temp = 1
	PRINT '��'
ELSE
	PRINT '���';

DECLARE @a8 INT = RAND() * 100, @b8 INT = RAND() * 100, @GCD INT, @LCM INT
DECLARE @x INT = @a8, @y INT = @b8
WHILE @x <> @y
	IF @x > @y SET @x = @x - @y ELSE SET @y = @y - @x
SET @GCD = @x
SET @LCM = @a8 * @b8 / @GCD
PRINT '@a8: ' + CAST(@a8 AS VARCHAR(8)) 
PRINT '@b8: ' + CAST(@b8 AS VARCHAR(8))
PRINT '���: ' + CAST(@LCM AS VARCHAR(8));

-- 9 ���� ��� ����� ����� A � B (A<B). ����� ����� ��������� ���� ����� ����� �� A �� B ������������.
DECLARE @A9 INT = 2, @B9 INT = 7, @SumSq INT = 0
WHILE @A9 <= @B9
BEGIN
	SET @SumSq = @SumSq + @A9 * @A9
	SET @A9 = @A9 + 1
END
PRINT '����� ���������: ' + CAST(@SumSq AS VARCHAR(12));

-- 10 ����� ������ ����������� �����, ������� ��� ������� �� 2, 3, 4, 5, � 6 ���� ������� 1, �� ������� �� 7.
DECLARE @Num10 INT = 1
WHILE 1=1
BEGIN
	IF @Num10 % 2 = 1 AND @Num10 % 3 = 1 AND @Num10 % 4 = 1 AND 
	@Num10 % 5 = 1 AND @Num10 % 6 = 1 AND @Num10 % 7 = 0
	BEGIN
		PRINT '������� �����: ' + CAST(@Num10 AS VARCHAR(10))
		BREAK
	END
	SET @Num10 = @Num10 + 1
END;

-- 11 ������� ���� ������� �� ����� ������� ���, ������� � ��� ����.
DECLARE @LastName VARCHAR(5) = '����'
DECLARE @Count INT = LEN(@LastName)
WHILE @Count > 0
BEGIN
    PRINT @LastName
    SET @Count = @Count - 1
END;











DECLARE @L2 INT, @M2 INT, @N2 CHAR(13)
SET @N2 = '�������������'
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


DECLARE @l INT, @n1 CHAR(13) = '�������������'
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
PRINT '����� = ' + CAST(@s as varchar(4));


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
PRINT '��� = ' + CAST(@a5 AS VARCHAR(4));


DECLARE @a4 INT = RAND() * 1000
WHILE @a4 % 5 = 0
	SET @a4 = @a4 / 5
IF @a4 = 1
	PRINT '��'
ELSE
	PRINT '���';


DECLARE @a3 INT = RAND() * 100
IF @a3 % 3 = 0
	PRINT CAST(@a3 AS VARCHAR(3)) + ' ������� �� 3'
ELSE
	PRINT CAST(@a3 AS VARCHAR(3)) + ' �� ������� �� 3';




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
SET @licey = (SELECT MAX(ball) FROM Table_uch1 WHERE ush = '�����')
SET @gimn = (SELECT MAX(ball) FROM Table_uch1 WHERE ush = '��������')
SET @diff = ABS(@licey - @gimn)
PRINT @diff;


DECLARE @a INT, @b INT, @c INT
SET @a = 5
SET @b = 10
SET @c = @a + @b 
PRINT @c;


--�������� ������� � ���������� �������
CREATE TABLE Table_uch1 (
    id INT IDENTITY(1,1) PRIMARY KEY, 
    fio NVARCHAR(50) NOT NULL,
    predmet NVARCHAR(50) NOT NULL,
    ush NVARCHAR(50) NOT NULL,
    ball DECIMAL(5,1) NOT NULL
);
INSERT INTO Table_uch1 (fio, predmet, ush, ball)
VALUES
    (N'��������', N'����������', N'�����', 98.5),
    (N'������', N'������', N'�����', 99.0),
    (N'�������', N'����������', N'�����', 88.0),
    (N'��������', N'������', N'��������', 78.0),
    (N'��������', N'�����', N'�����', 92.0),
    (N'�������', N'�����', N'��������', 68.0),
    (N'��������', N'����������', N'��������', 81.0),
    (N'������', N'������', N'�����', 87.0),
    (N'��������', N'�����', N'�����', 94.0),
    (N'�������', N'�����', N'�����', 88.0);
