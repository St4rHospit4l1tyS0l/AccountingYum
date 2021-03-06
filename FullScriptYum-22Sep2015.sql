USE [INSIGHT]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_gblStoreEx_gblStore]') AND parent_object_id = OBJECT_ID(N'[dbo].[gblStoreEx]'))
ALTER TABLE [dbo].[gblStoreEx] DROP CONSTRAINT [FK_gblStoreEx_gblStore]
GO
/****** Object:  Table [dbo].[SettingsEx]    Script Date: 9/22/2015 4:10:06 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SettingsEx]') AND type in (N'U'))
DROP TABLE [dbo].[SettingsEx]
GO
/****** Object:  Table [dbo].[gblStoreEx]    Script Date: 9/22/2015 4:10:06 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[gblStoreEx]') AND type in (N'U'))
DROP TABLE [dbo].[gblStoreEx]
GO
/****** Object:  Table [dbo].[CategoryEx]    Script Date: 9/22/2015 4:10:06 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CategoryEx]') AND type in (N'U'))
DROP TABLE [dbo].[CategoryEx]
GO
/****** Object:  UserDefinedFunction [dbo].[ufnGetInitDateOfDecember]    Script Date: 9/22/2015 4:10:06 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufnGetInitDateOfDecember]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ufnGetInitDateOfDecember]
GO
/****** Object:  StoredProcedure [dbo].[YumSalesSummary]    Script Date: 9/22/2015 4:10:06 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[YumSalesSummary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[YumSalesSummary]
GO
/****** Object:  StoredProcedure [dbo].[YumPayments]    Script Date: 9/22/2015 4:10:06 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[YumPayments]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[YumPayments]
GO
/****** Object:  StoredProcedure [dbo].[YumNetSales]    Script Date: 9/22/2015 4:10:06 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[YumNetSales]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[YumNetSales]
GO
/****** Object:  StoredProcedure [dbo].[YumEmployeeMeal]    Script Date: 9/22/2015 4:10:06 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[YumEmployeeMeal]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[YumEmployeeMeal]
GO
/****** Object:  StoredProcedure [dbo].[YumDiscountOverNetSales]    Script Date: 9/22/2015 4:10:06 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[YumDiscountOverNetSales]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[YumDiscountOverNetSales]
GO
/****** Object:  StoredProcedure [dbo].[YumDeposit]    Script Date: 9/22/2015 4:10:06 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[YumDeposit]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[YumDeposit]
GO
/****** Object:  StoredProcedure [dbo].[YumCreateFile]    Script Date: 9/22/2015 4:10:06 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[YumCreateFile]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[YumCreateFile]
GO
/****** Object:  StoredProcedure [dbo].[YumCalculatePeriodAndWeek]    Script Date: 9/22/2015 4:10:06 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[YumCalculatePeriodAndWeek]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[YumCalculatePeriodAndWeek]
GO
/****** Object:  StoredProcedure [dbo].[WriteToFile]    Script Date: 9/22/2015 4:10:06 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WriteToFile]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[WriteToFile]
GO
/****** Object:  StoredProcedure [dbo].[DeleteToFile]    Script Date: 9/22/2015 4:10:06 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteToFile]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteToFile]
GO

/****** Object:  Table [dbo].[CategoryEx]    Script Date: 9/22/2015 4:10:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CategoryEx]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CategoryEx](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[CsCnPrOw] [varchar](50) NULL,
	[AccountNumber] [varchar](50) NOT NULL,
	[SubAccountNumber] [varchar](50) NOT NULL,
	[CsCnScOw] [varchar](50) NULL,
	[QuerySp] [nvarchar](2000) NULL,
	[Factor] [int] NOT NULL,
	[RemoveIfZero] [bit] NOT NULL,
	[ModeId] [int] NULL,
	[TaxId] [int] NULL,
	[Percentage] [int] NULL,
	[TenderId] [int] NULL,
	[Opts] [varchar](100) NULL,
 CONSTRAINT [PK_CategoryEx] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[gblStoreEx]    Script Date: 9/22/2015 4:10:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[gblStoreEx]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[gblStoreEx](
	[Id] [int] NOT NULL,
	[CostCenter] [varchar](50) NOT NULL,
	[StoreId] [int] NOT NULL,
 CONSTRAINT [PK_gblStoreEx] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SettingsEx]    Script Date: 9/22/2015 4:10:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SettingsEx]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SettingsEx](
	[Id] [int] NOT NULL,
	[Key] [varchar](20) NOT NULL,
	[Value] [nvarchar](2000) NOT NULL,
	[Description] [nvarchar](2000) NOT NULL,
 CONSTRAINT [PK_SettingsEx] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (1, N'CA HT IN 21', NULL, N'3050', N'001', NULL, N'NetSales', -1, 0, 1, 21, NULL, NULL, NULL)
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (2, N'CA IN 10', NULL, N'3050', N'002', NULL, N'NetSales', -1, 0, 1, 10, NULL, NULL, NULL)
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (3, N'CA HT VAE 21', NULL, N'3100', N'001', NULL, N'NetSales', -1, 0, 2, 21, NULL, NULL, NULL)
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (4, N'CA HT VAE 10', NULL, N'3100', N'002', NULL, N'NetSales', -1, 0, 2, 10, NULL, NULL, NULL)
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (5, N'CA HT DRIVE 21', NULL, N'3100', N'003', NULL, N'NetSales', -1, 0, 3, 21, NULL, NULL, NULL)
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (6, N'CA HT DRIVE 10', NULL, N'3100', N'005', NULL, N'NetSales', -1, 0, 3, 10, NULL, NULL, NULL)
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (7, N'MARKETING IN', NULL, N'7420', N'008', NULL, N'PercentageNetSales', -1, 0, NULL, NULL, 5, NULL, NULL)
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (8, N'MARKETING OUT', N'72310000', N'8126', N'003', NULL, NULL, -1, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (9, N'ROYALTIES IN', NULL, N'9554', N'015', N'51426', N'PercentageNetSales', -1, 0, NULL, NULL, 3, NULL, NULL)
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (10, N'ROYALTIES OUT', N'72001', N'2762', N'51426', NULL, NULL, -1, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (11, N'COUPON SP 10', NULL, N'4505', N'003', NULL, N'Discount', 1, 0, 1, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (12, N'COUPONS VAE 21', NULL, N'4510', N'003', NULL, N'Discount', 1, 0, 2, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (13, N'COUPON DRIVE 10', NULL, N'4502', N'001', NULL, N'Discount', 1, 0, 3, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (14, N'COMIDAS HT 10', NULL, N'4702', N'001', NULL, N'EmployeeMeal', 1, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (15, N'TVA a 10%', N'72001', N'2564', N'043', NULL, N'Taxes', -1, 0, NULL, NULL, 10, NULL, NULL)
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (16, N'TVA a 21%', N'72001', N'2564', N'043', NULL, N'Taxes', -1, 0, NULL, NULL, 21, NULL, NULL)
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (17, N'DEPOT CB EMV', NULL, N'1020', N'950', NULL, N'Payments', 1, 0, NULL, NULL, NULL, 10, N'EQ')
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (18, N'DEPOT TR', NULL, N'1152', N'003', NULL, N'Payments', 1, 0, NULL, NULL, NULL, 10, N'EQTR')
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (19, N'DEPOT ESPECES 1', NULL, N'1020', N'950', NULL, N'Deposit', 1, 0, NULL, NULL, NULL, 1, N'NEQ')
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (20, N'DEPOT ESPECES 7', NULL, N'1020', N'950', NULL, N'Deposit', 1, 0, NULL, NULL, NULL, 7, N'NEQ')
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (21, N'ECART DEPOT CASH', NULL, N'6650', N'005', NULL, N'Cash-Deposit', 1, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (22, N'VAR CB', NULL, N'6650', N'006', NULL, N'Zero', 1, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (23, N'ECART STEW', NULL, N'6650', N'002', NULL, N'Cash-Cashier', 1, 0, NULL, NULL, NULL, 22, NULL)
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (24, N'ECART COFFRE CLOSE', NULL, N'6650', N'005', NULL, N'Zero', 1, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (25, N'ECART MANAGER', NULL, N'6650', N'010', NULL, N'Cash-Manager', 1, 0, NULL, NULL, NULL, NULL, N'EQ-ALL')
GO
INSERT [dbo].[CategoryEx] ([Id], [Name], [CsCnPrOw], [AccountNumber], [SubAccountNumber], [CsCnScOw], [QuerySp], [Factor], [RemoveIfZero], [ModeId], [TaxId], [Percentage], [TenderId], [Opts]) VALUES (26, N'ARRONDI ECRITURE', NULL, N'6650', N'010', NULL, N'Adjustment', 1, 0, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[gblStoreEx] ([Id], [CostCenter], [StoreId]) VALUES (1, N'72011002', 9)
GO
INSERT [dbo].[gblStoreEx] ([Id], [CostCenter], [StoreId]) VALUES (3, N'72028024', 11)
GO
INSERT [dbo].[SettingsEx] ([Id], [Key], [Value], [Description]) VALUES (1, N'Country', N'72001', N'Identificador del país para el archivo de exportación')
GO
INSERT [dbo].[SettingsEx] ([Id], [Key], [Value], [Description]) VALUES (2, N'CodeStore', N'AA', N'Código fijo para las tiendas')
GO
INSERT [dbo].[SettingsEx] ([Id], [Key], [Value], [Description]) VALUES (3, N'Currency', N'EUR', N'Moneda')
GO
INSERT [dbo].[SettingsEx] ([Id], [Key], [Value], [Description]) VALUES (4, N'CurrencySec', N'US', N'Moneda secundaria')
GO
INSERT [dbo].[SettingsEx] ([Id], [Key], [Value], [Description]) VALUES (5, N'EmployeeMeal', N'3', N'Identificador de la comida del empleado')
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_gblStoreEx_gblStore]') AND parent_object_id = OBJECT_ID(N'[dbo].[gblStoreEx]'))
ALTER TABLE [dbo].[gblStoreEx]  WITH CHECK ADD  CONSTRAINT [FK_gblStoreEx_gblStore] FOREIGN KEY([StoreId])
REFERENCES [dbo].[gblStore] ([StoreId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_gblStoreEx_gblStore]') AND parent_object_id = OBJECT_ID(N'[dbo].[gblStoreEx]'))
ALTER TABLE [dbo].[gblStoreEx] CHECK CONSTRAINT [FK_gblStoreEx_gblStore]
GO

sp_configure ''show advanced options'', 1;
GO
RECONFIGURE;
GO
sp_configure ''Ole Automation Procedures'', 1;
GO
RECONFIGURE;
GO

/****** Object:  StoredProcedure [dbo].[DeleteToFile]    Script Date: 9/22/2015 4:10:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteToFile]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DeleteToFile]
	@File VARCHAR(2000)
AS 
BEGIN 

	DECLARE @Result int
	DECLARE @FSO_Token int

	EXEC @Result = sp_OACreate ''Scripting.FileSystemObject'', @FSO_Token OUTPUT
	EXEC @Result = sp_OAMethod @FSO_Token, ''DeleteFile'', NULL, @File
	EXEC @Result = sp_OADestroy @FSO_Token
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[WriteToFile]    Script Date: 9/22/2015 4:10:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WriteToFile]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[WriteToFile]
@File        VARCHAR(2000),
@Text        VARCHAR(2000)
AS 
BEGIN 

DECLARE @OLE            INT 
DECLARE @FileID         INT 

EXECUTE sp_OACreate ''Scripting.FileSystemObject'', @OLE OUT 
EXECUTE sp_OAMethod @OLE, ''OpenTextFile'', @FileID OUT, @File, 8, 1 
EXECUTE sp_OAMethod @FileID, ''WriteLine'', Null, @Text
EXECUTE sp_OADestroy @FileID 
EXECUTE sp_OADestroy @OLE 

END  
' 
END
GO
/****** Object:  StoredProcedure [dbo].[YumCalculatePeriodAndWeek]    Script Date: 9/22/2015 4:10:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[YumCalculatePeriodAndWeek]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[YumCalculatePeriodAndWeek]
	@datetime AS DATE,
	@result AS VARCHAR(20) OUTPUT
AS
BEGIN
	DECLARE
		@Week AS INT,
		@Month AS INT,
		@Year AS INT,
		@DateLast AS DATE,
		@DateCurr AS DATE

	SET @Month = DATEPART(mm, @datetime)

	SET DATEFIRST 2

	SET @Year = DATEPART(yyyy, @datetime)

	SELECT @DateCurr = dbo.ufnGetInitDateOfDecember(@Year)

	IF @datetime < @DateCurr
	BEGIN
		SELECT @DateLast = dbo.ufnGetInitDateOfDecember(@Year-1)
		SET @Week = DATEPART(dy, DATEADD(mm, (@Year - 1901) * 12 + 11 , 30)) - DATEPART(dy, @DateLast) + DATEPART(dy, @datetime) 
		SET @Week = (@Week / 7) + 1
	END
	ELSE
	BEGIN
		SET @Week = DATEPART(dy, @datetime) - DATEPART(dy, @DateCurr)
		SET @Week = (@Week / 7) + 1
	END

	SET @result = ''CA P'' + RIGHT(''00'' + CONVERT(varchar, (CASE WHEN @Month = 12 THEN 1 ELSE @Month + 1 END)), 2) + 
		''S'' + RIGHT(''00'' + CONVERT(varchar, @Week), 2)
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[YumCreateFile]    Script Date: 9/22/2015 4:10:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[YumCreateFile]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[YumCreateFile]
	@DateToProc DATE  = NULL,
	@File VARCHAR(2000)  = NULL
AS
BEGIN
	IF @DateToProc IS NULL
		SET @DateToProc = CAST(GETDATE() AS DATE)

	IF @File IS NULL
		SET @File = ''C:\YumFile_'' + CONVERT(VARCHAR(10), @DateToProc, 105) +  ''.bak''

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
	SELECT @Country = Value FROM SettingsEx WHERE [Key] = ''Country''	
	SELECT @CodeStore = Value	FROM SettingsEx WHERE [Key] = ''CodeStore''
	SELECT @Currency = Value	FROM SettingsEx WHERE [Key] = ''Currency''
	SELECT @CurrencySec = Value	FROM SettingsEx WHERE [Key] = ''CurrencySec''
	SELECT @EmployeeMealId = CAST(Value AS INT) FROM SettingsEx WHERE [Key] = ''EmployeeMeal''


	SET @DateToProcTx = CONVERT(VARCHAR, DATEPART(mm, @DateToProc)) + ''/'' + CONVERT(VARCHAR, DATEPART(dd, @DateToProc)) + ''/'' + CONVERT(VARCHAR, DATEPART(yyyy, @DateToProc)) 
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

		IF @QuerySp = ''NetSales''
		BEGIN
			EXEC [dbo].[YumNetSales] @DateToProc, @StoreId, @ModeId, @TaxId, @DecRound, @TotalResSp OUTPUT
			IF @TaxId = 10 SET @TotalNet10 = @TotalNet10 +  @TotalResSp
			IF @TaxId = 21 SET @TotalNet21 = @TotalNet21 +  @TotalResSp
		END
		ELSE IF @QuerySp = ''PercentageNetSales''
		BEGIN
			SET  @TotalResSp = ROUND((((@TotalNet10 + @TotalNet21) * @Percentage)/ 100.0), @DecRound) * @Factor
		END
		ELSE IF @QuerySp = ''Discount''
		BEGIN
			EXEC [dbo].[YumDiscountOverNetSales] @DateToProc, @StoreId, @ModeId, @DecRound, @TotalResSp OUTPUT
		END
		ELSE IF @QuerySp = ''EmployeeMeal''
		BEGIN
			EXEC [dbo].[YumEmployeeMeal] @DateToProc, @StoreId, @EmployeeMealId, @DecRound, @TotalResSp OUTPUT
		END
		ELSE IF @QuerySp = ''Taxes''
		BEGIN
			IF @Percentage = 10
				SET  @TotalResSp = ROUND((((@TotalNet10) * @Percentage)/ 100.0), @DecRound)
			ELSE IF @Percentage = 21
				SET  @TotalResSp = ROUND((((@TotalNet21) * @Percentage)/ 100.0), @DecRound)
			ELSE
				SET  @TotalResSp = 0
		END
		ELSE IF @QuerySp = ''Payments''
		BEGIN
			EXEC [dbo].[YumPayments] @DateToProc, @StoreId, @TenderId, @Opts, @DecRound, @TotalResSp OUTPUT, @TotalCash OUTPUT
		END
		ELSE IF @QuerySp = ''Deposit''
		BEGIN
			EXEC [dbo].[YumDeposit] @DateToProc, @StoreId, @TenderId, @Opts, @DecRound, @TotalResSp OUTPUT
			SET @TotalDeposit = @TotalDeposit + @TotalResSp
		END
		ELSE IF @QuerySp = ''Cash-Deposit''
		BEGIN
			SET @TotalResSp = @TotalCash - @TotalDeposit
		END	
		ELSE IF @QuerySp = ''Cash-Cashier''
		BEGIN
			EXEC [dbo].[YumSalesSummary] @DateToProc, @StoreId, @TenderId, @DecRound, @TotalResSp OUTPUT
			SET @TotalResSp = @TotalCash - @TotalResSp
		END	
		ELSE IF @QuerySp = ''Cash-Manager''
		BEGIN
			EXEC [dbo].[YumDeposit] @DateToProc, @StoreId, @TenderId, @Opts, @DecRound, @TotalResSp OUTPUT
			SET @TotalResSp = @TotalCash - @TotalResSp
		END	
		ELSE IF @QuerySp = ''Zero''
		BEGIN
			SET  @TotalResSp = 0
		END
		ELSE IF @QuerySp = ''Adjustment''
		BEGIN
			SET  @TotalResSp = ROUND(@Adjustment, @DecRound)
		END

		IF @CsCnPrOw IS NULL 
			SET @CsCnPrOw = @CostCenter 
			
		IF @CsCnScOw IS NULL 
			SET @CsCnScOw = @CostCenter

		SET @TotalResSp = @TotalResSp * @Factor

		SET @Adjustment = @Adjustment + @TotalResSp

		SELECT @TotalResTx = CASE WHEN @TotalResSp IS NULL OR @TotalResSp = 0  THEN ''0'' ELSE CONVERT(VARCHAR, @TotalResSp, 128) END
		
		SET @TxLine = @Country + ''|'' + @CsCnPrOw + ''|'' + @AccountNumber + ''|'' + @SubAccountNumber + ''|'' + @TotalResTx + ''|'' + @CodeStore
			+ ''|''  + @Currency + ''|''  + @CurrencySec + ''|'' + @DateToProcTx + ''|'' + @PeriodWeek
			+ ''|'' + @Name + ''|'' + @CsCnScOw

		--PRINT @TxLine
		
		IF @RemoveIfZero = 0 OR (@RemoveIfZero = 1 AND @TotalResSp <> 0)
			EXEC WriteToFile @File, @TxLine
		
		FETCH NEXT FROM CursorCat INTO @StoreId, @CostCenter, @Name, @CsCnPrOw, @AccountNumber, @SubAccountNumber, @CsCnScOw, 
		@QuerySp, @Factor, @RemoveIfZero, @ModeId, @TaxId, @Percentage, @TenderId, @Opts
	END  

	CLOSE CursorCat  
	DEALLOCATE CursorCat 

END



' 
END
GO
/****** Object:  StoredProcedure [dbo].[YumDeposit]    Script Date: 9/22/2015 4:10:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[YumDeposit]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE PROCEDURE [dbo].[YumDeposit]
	@dateToProc AS DATE,
	@storeId AS INT,
	@itemId AS INT,
	@opt AS VARCHAR(10),
	@decRound AS INT,
	@total AS FLOAT OUTPUT
AS
BEGIN

	IF @opt = ''NEQ''
	BEGIN
		SELECT 
			@total = ROUND(SUM(ISNULL(Amount,0)), @decRound) 
		FROM dpvHstDeposit
		WHERE CAST(DateOfBusiness AS date) =  @dateToProc
			AND FKStoreId = @storeId
			AND DepositNumber = @itemId
			AND UPPER(Description) NOT LIKE ''CIERRE%''
	END
	ELSE IF @opt = ''EQ-ALL''
	BEGIN
		SELECT 
			@total = ROUND(SUM(ISNULL(Amount,0)), @decRound) 
		FROM dpvHstDeposit
		WHERE CAST(DateOfBusiness AS date) =  @dateToProc
			AND FKStoreId = @storeId
			AND UPPER(Description) LIKE ''CIERRE%''
	END

	IF @total IS NULL
		SET @total = 0
END




' 
END
GO
/****** Object:  StoredProcedure [dbo].[YumDiscountOverNetSales]    Script Date: 9/22/2015 4:10:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[YumDiscountOverNetSales]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[YumDiscountOverNetSales]
	@dateToProc AS DATE,
	@storeId AS INT,
	@modeId AS INT,
	@decRound AS INT,
	@total AS FLOAT OUTPUT
AS
BEGIN
	SELECT 
		@total = ROUND(SUM(ISNULL(Price,0) - ISNULL(DiscPric, 0)), @decRound) 
	FROM dpvHstGndItem
	WHERE CAST(DateOfBusiness AS date) =  @dateToProc
		AND FKStoreId = @storeId
		AND FKOrderModeId = @modeId	

	IF @total IS NULL
		SET @total = 0

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[YumEmployeeMeal]    Script Date: 9/22/2015 4:10:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[YumEmployeeMeal]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[YumEmployeeMeal]
	@dateToProc AS DATE,
	@storeId AS INT,
	@compId AS INT,
	@decRound AS INT,
	@total AS FLOAT OUTPUT
AS
BEGIN
	SELECT 
		@total = ROUND(SUM(ISNULL(Amount,0)), @decRound) 
	FROM dpvHstComp
	WHERE CAST(DateOfBusiness AS date) =  @dateToProc
		AND FKStoreId = @storeId
		AND FKCompId = @compId 

	IF @total IS NULL
		SET @total = 0

END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[YumNetSales]    Script Date: 9/22/2015 4:10:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[YumNetSales]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[YumNetSales]
	@dateToProc AS DATE,
	@storeId AS INT,
	@modeId AS INT,
	@taxId AS INT,
	@decRound AS INT,
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

	IF @total IS NULL
		SET @total = 0

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[YumPayments]    Script Date: 9/22/2015 4:10:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[YumPayments]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[YumPayments]
	@dateToProc AS DATE,
	@storeId AS INT,
	@tenderId AS INT,
	@opt AS VARCHAR(10),
	@decRound AS INT,
	@total AS FLOAT OUTPUT,
	@totalCash AS FLOAT OUTPUT
AS
BEGIN

	IF @opt = ''EQ''
	BEGIN
		SELECT 
			@total = ROUND(SUM(ISNULL(Amount,0)), @decRound) 
		FROM dpvHstTender
		WHERE CAST(DateOfBusiness AS date) =  @dateToProc
			AND FKStoreId = @storeId
			AND FKTenderId = @tenderId
	END
	ELSE IF @opt = ''NEQ''
	BEGIN
		SELECT 
			@total = ROUND(SUM(ISNULL(Amount,0)), @decRound) 
		FROM dpvHstTender
		WHERE CAST(DateOfBusiness AS date) =  @dateToProc
			AND FKStoreId = @storeId
			AND FKTenderId <> @tenderId
	END
	ELSE IF @opt = ''EQTR''
	BEGIN
		SELECT 
			@total = ROUND(SUM(ISNULL(Amount,0)), @decRound) 
		FROM dpvHstTender
		WHERE CAST(DateOfBusiness AS date) =  @dateToProc
			AND FKStoreId = @storeId
			AND FKTenderId IN (16, 17, 18)
	END

	IF @totalCash IS NULL
	BEGIN
		SELECT 
			@totalCash = ROUND(SUM(ISNULL(Amount,0)), @decRound) 
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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[YumSalesSummary]    Script Date: 9/22/2015 4:10:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[YumSalesSummary]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[YumSalesSummary]
	@dateToProc AS DATE,
	@storeId AS INT,
	@itemId AS INT,
	@decRound AS INT,
	@total AS FLOAT OUTPUT
AS
BEGIN

	SELECT 
		@total = ROUND(SUM(ISNULL(Amount,0)), @decRound) 
	FROM dpvHstSalesSummary
	WHERE CAST(DateOfBusiness AS date) =  @dateToProc
		AND FKStoreId = @storeId
		AND Type = @itemId
	
	IF @total IS NULL
		SET @total = 0
END

' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[ufnGetInitDateOfDecember]    Script Date: 9/22/2015 4:10:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufnGetInitDateOfDecember]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[ufnGetInitDateOfDecember](@Year INT)
RETURNS DATE 
AS 
BEGIN
	DECLARE 
		@DateCal AS DATE,
		@DayOfWeekFirst AS INT

	SET @DateCal = DATEADD(mm, (@Year - 1900) * 12 + 11 , 0)

	SET @DayOfWeekFirst = DATEPART(dw, @DateCal)

	--SELECT @DayOfWeekFirst 
	IF @DayOfWeekFirst > 1 --Martes por el DATEFIRST = 2
		SET @DayOfWeekFirst = 8 - @DayOfWeekFirst
	ELSE
		SET @DayOfWeekFirst = 0
	 
	SET @DateCal = DATEADD(dd, @DayOfWeekFirst, @DateCal)

	RETURN @DateCal
END
' 
END

GO
