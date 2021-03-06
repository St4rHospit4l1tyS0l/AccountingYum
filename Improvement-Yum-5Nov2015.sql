USE [INSIGHT]
GO

ALTER TABLE CategoryEx ALTER COLUMN TenderId varchar(100)
GO

/****** Object:  UserDefinedFunction [dbo].[udf_SplitVariable]    Script Date: 11/5/2015 3:31:59 PM ******/
DROP FUNCTION [dbo].[udf_SplitVariable]
GO

/****** Object:  UserDefinedFunction [dbo].[udf_SplitVariable]    Script Date: 11/5/2015 3:31:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[udf_SplitVariable]
(
    @List VARCHAR(MAX),
    @SplitOn VARCHAR(5) = ','
)

RETURNS @RtnValue TABLE
(
    Id VARCHAR(10)
)

AS
BEGIN

--Account for ticks
SET @List = (REPLACE(@List, '''', ''))

--Loop through all of the items in the string and add records for each item
WHILE (CHARINDEX(@SplitOn,@List)>0)
BEGIN

    INSERT INTO @RtnValue (Id)
		SELECT Value = LTRIM(RTRIM(SUBSTRING(@List, 1, CHARINDEX(@SplitOn, @List)-1)))  

    SET @List = SUBSTRING(@List, CHARINDEX(@SplitOn,@List) + LEN(@SplitOn), LEN(@List))

END

INSERT INTO @RtnValue (Id)
	SELECT Value = LTRIM(RTRIM(@List))

RETURN

END 

GO

/****** Object:  StoredProcedure [dbo].[YumDeposit]    Script Date: 11/5/2015 4:03:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[YumDeposit]
	@dateToProc AS DATE,
	@storeId AS INT,
	@itemIds AS VARCHAR(100),
	@opt AS VARCHAR(10),
	@total AS FLOAT OUTPUT
AS
BEGIN

	IF @opt = 'NEQ'
	BEGIN
		SELECT 
			@total = SUM(ISNULL(Amount,0))
		FROM dpvHstDeposit
		INNER JOIN [dbo].[udf_SplitVariable](@itemIds, DEFAULT) Sv ON Sv.Id = dpvHstDeposit.DepositNumber OR @itemIds IS NULL
		WHERE CAST(DateOfBusiness AS date) =  @dateToProc
			AND FKStoreId = @storeId
			--AND DepositNumber = @itemIds
			AND UPPER(Description) NOT LIKE 'CIERRE%'
	END
	ELSE IF @opt = 'EQ-ALL'
	BEGIN
		SELECT 
			@total = SUM(ISNULL(Amount,0))
		FROM dpvHstDeposit
		WHERE CAST(DateOfBusiness AS date) =  @dateToProc
			AND FKStoreId = @storeId
			AND UPPER(Description) LIKE 'CIERRE%'
	END

	IF @total IS NULL
		SET @total = 0
END

GO


/****** Object:  StoredProcedure [dbo].[YumPayments]    Script Date: 11/5/2015 4:09:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[YumPayments]
	@dateToProc AS DATE,
	@storeId AS INT,
	@itemIds AS VARCHAR(100),
	@opt AS VARCHAR(10),
	@total AS FLOAT OUTPUT,
	@totalCash AS FLOAT OUTPUT
AS
BEGIN

	IF @opt = 'EQ'
	BEGIN
		SELECT 
			@total = SUM(ISNULL(Amount,0))
		FROM dpvHstTender
		INNER JOIN [dbo].[udf_SplitVariable](@itemIds, DEFAULT) Sv ON Sv.Id = dpvHstTender.FKTenderId -- OR @itemIds IS NULL
		WHERE CAST(DateOfBusiness AS date) =  @dateToProc
			AND FKStoreId = @storeId
			--AND FKTenderId = @itemIds
	END
	ELSE IF @opt = 'NEQ'
	BEGIN
		SELECT 
			@total = SUM(ISNULL(Amount,0))
		FROM dpvHstTender
		WHERE CAST(DateOfBusiness AS date) =  @dateToProc
			AND FKStoreId = @storeId
			AND NOT EXISTS
			(
				SELECT 1
				FROM [dbo].[udf_SplitVariable](@itemIds, DEFAULT) Sv WHERE Sv.Id = dpvHstTender.FKTenderId
			)
			-- AND FKTenderId <> @itemIds
	END
	/*
	ELSE IF @opt = 'EQTR'
	BEGIN
		SELECT 
			@total = SUM(ISNULL(Amount,0))
		FROM dpvHstTender
		WHERE CAST(DateOfBusiness AS date) =  @dateToProc
			AND FKStoreId = @storeId
			AND FKTenderId IN (16, 17, 18)
	END
	*/
	
	IF @totalCash IS NULL
	BEGIN
		SELECT 
			@totalCash = SUM(ISNULL(Amount,0))
		FROM dpvHstTender
		WHERE CAST(DateOfBusiness AS date) =  @dateToProc
			AND FKStoreId = @storeId
			AND FKTenderId IN (1, 2, 3, 4, 5)
		
		IF @totalCash IS NULL
			SET @totalCash = 0	
	END

	IF @total IS NULL
		SET @total = 0

END

GO

/****** Object:  StoredProcedure [dbo].[YumSalesSummary]    Script Date: 11/5/2015 4:28:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[YumSalesSummary]
	@dateToProc AS DATE,
	@storeId AS INT,
	@itemIds AS VARCHAR(100),
	@total AS FLOAT OUTPUT
AS
BEGIN

	DECLARE @totalStartingBank FLOAT

	SELECT 
		@total = SUM(ISNULL(Amount,0))
	FROM dpvHstSalesSummary
	INNER JOIN [dbo].[udf_SplitVariable](@itemIds, DEFAULT) Sv ON Sv.Id = dpvHstSalesSummary.Type --OR @itemIds IS NULL	
	WHERE CAST(DateOfBusiness AS date) =  @dateToProc
		AND FKStoreId = @storeId
		--AND Type = @itemIds
	
	SELECT 
		@totalStartingBank = SUM(ISNULL(Amount, 0))
	FROM dpvHstSalesSummary
	WHERE CAST(DateOfBusiness AS date) =  @dateToProc
		AND FKStoreId = @storeId
		AND Type = 15
		AND TypeId = 202				

	SET @total = ISNULL(@total, 0) - ISNULL(@totalStartingBank, 0)

END
GO


UPDATE CategoryEx SET TenderId = '16, 17, 18', Opts = 'EQ' WHERE QuerySp = 'Payments' AND Opts = 'EQTR'
GO

UPDATE CategoryEx SET TenderId = '1, 2' WHERE Name = 'DEPOT ESPECES 1'
GO

/****** Object:  StoredProcedure [dbo].[YumCreateFile]    Script Date: 11/5/2015 3:20:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*
sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'Ole Automation Procedures', 1;
GO
RECONFIGURE;
GO


--EXEC YumCreateFile '2015-05-16'
*/

ALTER PROCEDURE [dbo].[YumCreateFile]
	@DateToProc DATE  = NULL,
	@File VARCHAR(2000)  = NULL
AS
BEGIN
	IF @DateToProc IS NULL
		SET @DateToProc = CAST(GETDATE() AS DATE)

	IF @File IS NULL
		SET @File = 'D:\Yum_Export\JDEExportar_' + CONVERT(VARCHAR(10), @DateToProc, 112) +  '.txt'

	DECLARE @Country  VARCHAR(2000),
		@CodeStore  VARCHAR(2000),
		@Currency  VARCHAR(2000),
		@CurrencySec  VARCHAR(2000),
		@EmployeeMealId INT,

		@Name NVARCHAR(250),
		@CsCnPrOw VARCHAR(250),
		@AccountNumber VARCHAR(250),
		@SubAccountNumber VARCHAR(250),
		@CsCnScOw VARCHAR(250),
		@TxLine VARCHAR(2000),
		@TotalResTx VARCHAR(100),
		@StoreId INT,
		@CostCenter VARCHAR(50),
		@QuerySp NVARCHAR(2000),
		@Factor INT,
		@RemoveIfZero BIT,
		@ModeId INT, 
		@TaxId INT,
		@ItemIds VARCHAR(100),
		@Opts VARCHAR(100),
		@Percentage INT = 0,
		@DecRound INT = 2,
		@DateToProcTx VARCHAR(10),
		@PeriodWeek VARCHAR(20),
		@LastStoreId INT = -1,
		@TotalNet21 FLOAT = 0,
		@TotalNet10 FLOAT = 0,
		@Adjustment FLOAT = 0,
		@TotalCash FLOAT = NULL,
		@TotalDeposit FLOAT = 0

	--Obtener los valores por defecto
	SELECT @Country = Value FROM SettingsEx WHERE [Key] = 'Country'	
	SELECT @CodeStore = Value	FROM SettingsEx WHERE [Key] = 'CodeStore'
	SELECT @Currency = Value	FROM SettingsEx WHERE [Key] = 'Currency'
	SELECT @CurrencySec = Value	FROM SettingsEx WHERE [Key] = 'CurrencySec'
	SELECT @EmployeeMealId = CAST(Value AS INT) FROM SettingsEx WHERE [Key] = 'EmployeeMeal'


	SET @DateToProcTx = CONVERT(VARCHAR, DATEPART(mm, @DateToProc)) + '/' + CONVERT(VARCHAR, DATEPART(dd, @DateToProc)) + '/' + CONVERT(VARCHAR, DATEPART(yyyy, @DateToProc)) 
	EXEC [dbo].[YumCalculatePeriodAndWeek] @DateToProc, @PeriodWeek OUTPUT

	--Elimina el archivo si existe
	EXEC DeleteToFile @File

	DECLARE @TotalResSp AS FLOAT = 0 

	--Cursor para iterar sobre los restaurantes y sobre cada una de las categorías (conceptos)
	DECLARE CursorCat CURSOR FOR
	SELECT SE.StoreId, SE.CostCenter, CE.Name, CE.CsCnPrOw, CE.AccountNumber, CE.SubAccountNumber, CE.CsCnScOw, 
		CE.QuerySp, CE.Factor, CE.RemoveIfZero, CE.ModeId, CE.TaxId, CE.Percentage, CE.TenderId, CE.Opts
	FROM CategoryEx CE
	CROSS JOIN gblStoreEx SE
	ORDER BY SE.StoreId, CE.Id

	OPEN CursorCat
	FETCH NEXT FROM CursorCat INTO @StoreId, @CostCenter, @Name, @CsCnPrOw, @AccountNumber, @SubAccountNumber, @CsCnScOw, 
		@QuerySp, @Factor, @RemoveIfZero, @ModeId, @TaxId, @Percentage, @ItemIds, @Opts

	WHILE @@FETCH_STATUS = 0  
	BEGIN  
		IF @LastStoreId <> @StoreId  --Resetar los valores por cada tienda o restaurante consultado
		BEGIN
			SET @LastStoreId = @StoreId
			SELECT @TotalNet21 = 0, @TotalNet10 = 0, @Adjustment = 0
		END

		IF @QuerySp = 'NetSales'
		BEGIN
			EXEC [dbo].[YumNetSales] @DateToProc, @StoreId, @ModeId, @TaxId, @TotalResSp OUTPUT
			IF @TaxId = 10 
			BEGIN
				SET @TotalResSp = @TotalResSp /1.10
				SET @TotalNet10 = @TotalNet10 +  @TotalResSp
			END

			IF @TaxId = 21 
			BEGIN
				SET @TotalResSp = @TotalResSp /1.21
				SET @TotalNet21 = @TotalNet21 +  @TotalResSp
			END
		END
		ELSE IF @QuerySp = 'PercentageNetSales'
		BEGIN
			SET  @TotalResSp = (((@TotalNet10 + @TotalNet21) * @Percentage)/ 100.0) * @Factor
		END
		ELSE IF @QuerySp = 'Discount'
		BEGIN
			EXEC [dbo].[YumDiscountOverNetSales] @DateToProc, @StoreId, @ModeId, @TotalResSp OUTPUT
		END
		ELSE IF @QuerySp = 'EmployeeMeal'
		BEGIN
			EXEC [dbo].[YumEmployeeMeal] @DateToProc, @StoreId, @EmployeeMealId, @TotalResSp OUTPUT
		END
		ELSE IF @QuerySp = 'Taxes'
		BEGIN
			IF @Percentage = 10
				SET  @TotalResSp = (((@TotalNet10) * @Percentage)/ 100.0)
			ELSE IF @Percentage = 21
				SET  @TotalResSp = (((@TotalNet21) * @Percentage)/ 100.0)
			ELSE
				SET  @TotalResSp = 0
		END
		ELSE IF @QuerySp = 'Payments'
		BEGIN
			EXEC [dbo].[YumPayments] @DateToProc, @StoreId, @ItemIds, @Opts, @TotalResSp OUTPUT, @TotalCash OUTPUT
		END
		ELSE IF @QuerySp = 'Deposit'
		BEGIN
			EXEC [dbo].[YumDeposit] @DateToProc, @StoreId, @ItemIds, @Opts, @TotalResSp OUTPUT
			SET @TotalDeposit = @TotalDeposit + @TotalResSp
		END
		ELSE IF @QuerySp = 'Cash-Deposit'
		BEGIN
			SET @TotalResSp = @TotalCash - @TotalDeposit
		END	
		ELSE IF @QuerySp = 'Cash-Cashier'
		BEGIN
			EXEC [dbo].[YumSalesSummary] @DateToProc, @StoreId, @ItemIds, @TotalResSp OUTPUT
			SET @TotalResSp = @TotalCash - @TotalResSp
		END	
		ELSE IF @QuerySp = 'Cash-Manager'
		BEGIN
			EXEC [dbo].[YumDeposit] @DateToProc, @StoreId, @ItemIds, @Opts, @TotalResSp OUTPUT
			SET @TotalResSp = @TotalCash - @TotalResSp
		END	
		ELSE IF @QuerySp = 'Zero'
		BEGIN
			SET  @TotalResSp = 0
		END
		ELSE IF @QuerySp = 'Adjustment'
		BEGIN
			SET  @TotalResSp = @Adjustment
		END

		IF @CsCnPrOw IS NULL 
			SET @CsCnPrOw = @CostCenter 
			
		IF @CsCnScOw IS NULL 
			SET @CsCnScOw = @CostCenter

		SET @TotalResSp = @TotalResSp * @Factor

		SET @Adjustment = @Adjustment + @TotalResSp

		SET @TotalResSp = ROUND(@TotalResSp, @DecRound)

		SELECT @TotalResTx = CASE WHEN @TotalResSp IS NULL OR @TotalResSp = 0  THEN '0' ELSE CONVERT(VARCHAR, @TotalResSp, 128) END
		
		SET @TxLine = @Country + '|' + @CsCnPrOw + '|' + @AccountNumber + '|' + @SubAccountNumber + '|' + @TotalResTx + '|' + @CodeStore
			+ '|'  + @Currency + '|'  + @CurrencySec + '|' + @DateToProcTx + '|' + @PeriodWeek
			+ '|' + @Name + '|' + @CsCnScOw

		--PRINT @TxLine
		
		IF @RemoveIfZero = 0 OR (@RemoveIfZero = 1 AND @TotalResSp <> 0)
			EXEC WriteToFile @File, @TxLine
		
		FETCH NEXT FROM CursorCat INTO @StoreId, @CostCenter, @Name, @CsCnPrOw, @AccountNumber, @SubAccountNumber, @CsCnScOw, 
		@QuerySp, @Factor, @RemoveIfZero, @ModeId, @TaxId, @Percentage, @ItemIds, @Opts
	END  

	CLOSE CursorCat  
	DEALLOCATE CursorCat 

END





