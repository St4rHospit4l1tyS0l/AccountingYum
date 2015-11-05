USE [INSIGHT]
GO

/****** Object:  StoredProcedure [dbo].[YumCreateFile]    Script Date: 9/30/2015 5:14:56 PM ******/
DROP PROCEDURE [dbo].[YumCreateFile]
GO

/****** Object:  StoredProcedure [dbo].[YumCreateFile]    Script Date: 9/30/2015 5:14:56 PM ******/
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

CREATE PROCEDURE [dbo].[YumCreateFile]
	@DateToProc DATE  = NULL,
	@File VARCHAR(2000)  = NULL
AS
BEGIN
	IF @DateToProc IS NULL
		SET @DateToProc = CAST(GETDATE() AS DATE)

	IF @File IS NULL
		SET @File = 'C:\Yum\YumFile_' + CONVERT(VARCHAR(10), @DateToProc, 105) +  '.bak'

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
		@TenderId INT,
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
		@QuerySp, @Factor, @RemoveIfZero, @ModeId, @TaxId, @Percentage, @TenderId, @Opts

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
			EXEC [dbo].[YumPayments] @DateToProc, @StoreId, @TenderId, @Opts, @TotalResSp OUTPUT, @TotalCash OUTPUT
		END
		ELSE IF @QuerySp = 'Deposit'
		BEGIN
			EXEC [dbo].[YumDeposit] @DateToProc, @StoreId, @TenderId, @Opts, @TotalResSp OUTPUT
			SET @TotalDeposit = @TotalDeposit + @TotalResSp
		END
		ELSE IF @QuerySp = 'Cash-Deposit'
		BEGIN
			SET @TotalResSp = @TotalCash - @TotalDeposit
		END	
		ELSE IF @QuerySp = 'Cash-Cashier'
		BEGIN
			EXEC [dbo].[YumSalesSummary] @DateToProc, @StoreId, @TenderId, @TotalResSp OUTPUT
			SET @TotalResSp = @TotalCash - @TotalResSp
		END	
		ELSE IF @QuerySp = 'Cash-Manager'
		BEGIN
			EXEC [dbo].[YumDeposit] @DateToProc, @StoreId, @TenderId, @Opts, @TotalResSp OUTPUT
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
		@QuerySp, @Factor, @RemoveIfZero, @ModeId, @TaxId, @Percentage, @TenderId, @Opts
	END  

	CLOSE CursorCat  
	DEALLOCATE CursorCat 

END





GO


