/*
ALTER PROCEDURE [dbo].[YumNetSales]
	@dateToProc AS DATE,
	@storeId AS INT,
	@modeId AS INT,
	@taxId AS INT = 10,
	@decRound AS INT = 2,
	@total AS FLOAT OUTPUT
AS
BEGIN
	SELECT 
		@total = ROUND(SUM(ISNULL(DiscPric,0) + ISNULL(ExclTax, 0)), @decRound) 
	FROM dpvHstGndItem
	WHERE CAST(DateOfBusiness AS date) =  @dateToProc
		AND FKStoreId = @storeId
		AND FKOrderModeId = @modeId	
		AND FKTaxId = @taxId

	PRINT @total
	PRINT @total
	PRINT @total

	IF @total IS NULL
		SET @total = 0

END
*/
/*
DECLARE @totalOut AS FLOAT 
DECLARE @txt AS VARCHAR(1000)
--EXEC YumNetSales '2015-05-16', 9, 1, 10, 2, @total OUTPUT

SET @txt = '''2015-05-16'''
SET @txt = 'EXEC YumNetSales ' + @txt + ', 9, 1, 10, 2, @total OUTPUT'

PRINT @txt

 EXEC (@txt)


--SET @txt = '''2015-05-16'''

--set @totalOut = EXEC ('DECLARE @total AS FLOAT EXEC YumNetSales ' + @txt +  ', 9, 1, 10, 2, @total OUTPUT  SELECT @total')

*/

--EXEC YumCreateFile '2015-05-16'

DECLARE @datetime AS DATE = '2014-1-13',
	@Day AS INT,
	@Month AS INT,
	@LastYear AS INT,
	@DateCal AS DATE,
	@DayOfWeekFirst AS INT

SET @Month = DATEPART(mm, @datetime)
--SELECT 'CA P' + RIGHT('00' + CONVERT(varchar, (CASE WHEN @Month = 12 THEN 1 ELSE @Month + 1 END)), 2)
--select convert(varchar(10), GETDATE(), 101) 

SET DATEFIRST 2
--SELECT CONVERT(varchar, DATEPART(ww, @datetime))

SET @LastYear = DATEPART(yyyy, @datetime) - 1
--SELECT @LastYear
SET @DateCal = DATEADD(mm, (@LastYear - 1900) * 12 + 11 , 0)
--SELECT @DateCal
SET @DayOfWeekFirst = DATEPART(dw, @DateCal)

--SELECT @DayOfWeekFirst 
IF @DayOfWeekFirst > 1 --Martes por el DATEFIRST = 2
	SET @DayOfWeekFirst = 8 - @DayOfWeekFirst
ELSE
	SET @DayOfWeekFirst = 0
SELECT @DayOfWeekFirst 
	 
SET @DateCal = DATEADD(dd, @DayOfWeekFirst, @DateCal)
SELECT @DateCal

SET @DayOfWeekFirst = DATEPART(dy, DATEADD(mm, (@LastYear - 1900) * 12 + 11 , 30)) - DATEPART(dy, @DateCal) + DATEPART(dy, @datetime) 

SELECT (@DayOfWeekFirst)
SELECT (@DayOfWeekFirst / 7) + 1


/*
SELECT DATEPART(ww, '2018-12-04')
SELECT DATEPART(ww, '2018-12-31')

SELECT DATEPART(ww, '2017-12-05')
SELECT DATEPART(ww, '2017-12-31')

SELECT DATEPART(ww, '2016-12-06')
SELECT DATEPART(ww, '2016-12-31')

SELECT DATEPART(ww, '2015-12-01')
SELECT DATEPART(ww, '2015-12-31')

SELECT DATEPART(ww, '2014-12-02')
SELECT DATEPART(ww, '2014-12-31')
*/