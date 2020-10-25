USE [C:\USERS\NEIL\SOURCE\REPOS\HOMEWORKCUSTOMER\APP_DATA\客戶資料.MDF]
GO
/****** Object:  Table [dbo].[客戶銀行資訊]    Script Date: 2020/10/25 下午 10:39:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[客戶銀行資訊](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[客戶Id] [int] NOT NULL,
	[銀行名稱] [nvarchar](50) NOT NULL,
	[銀行代碼] [int] NOT NULL,
	[分行代碼] [int] NULL,
	[帳戶名稱] [nvarchar](50) NOT NULL,
	[帳戶號碼] [nvarchar](20) NOT NULL,
	[IsDelete] [bit] NOT NULL,
 CONSTRAINT [PK_客戶銀行資訊] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[客戶聯絡人]    Script Date: 2020/10/25 下午 10:39:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[客戶聯絡人](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[客戶Id] [int] NOT NULL,
	[職稱] [nvarchar](50) NOT NULL,
	[姓名] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](250) NOT NULL,
	[手機] [nvarchar](50) NULL,
	[電話] [nvarchar](50) NULL,
	[IsDelete] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Contacts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[客戶資料]    Script Date: 2020/10/25 下午 10:39:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[客戶資料](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[客戶名稱] [nvarchar](50) NOT NULL,
	[統一編號] [char](8) NOT NULL,
	[電話] [nvarchar](50) NOT NULL,
	[傳真] [nvarchar](50) NULL,
	[地址] [nvarchar](100) NULL,
	[Email] [nvarchar](250) NULL,
	[IsDelete] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Customers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Customer_Test_View]    Script Date: 2020/10/25 下午 10:39:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Customer_Test_View]
	AS SELECT DISTINCT
			[dbo].[客戶資料].Id,
			[dbo].[客戶資料].客戶名稱,
			(SELECT COUNT(*) FROM [dbo].[客戶銀行資訊] WHERE [dbo].[客戶資料].Id = [dbo].[客戶銀行資訊].客戶Id AND [dbo].[客戶銀行資訊].IsDelete = 0) AS 客戶銀行數,
			(SELECT COUNT(*) FROM [dbo].[客戶聯絡人] WHERE [dbo].[客戶資料].Id = [dbo].[客戶聯絡人].客戶Id AND [dbo].[客戶聯絡人].IsDelete = 0) AS 客戶聯絡人數
		FROM [dbo].[客戶資料]
		LEFT JOIN [dbo].[客戶銀行資訊]
		ON [dbo].[客戶資料].Id = [dbo].[客戶銀行資訊].客戶Id
		LEFT JOIN [dbo].[客戶聯絡人]
		ON [dbo].[客戶資料].Id = [dbo].[客戶聯絡人].客戶Id
		WHERE [dbo].[客戶資料].IsDelete = 0;
GO
SET IDENTITY_INSERT [dbo].[客戶聯絡人] ON 

INSERT [dbo].[客戶聯絡人] ([Id], [客戶Id], [職稱], [姓名], [Email], [手機], [電話], [IsDelete]) VALUES (4, 1, N'普通員工', N'測試人', N'testemail@gmail.com', N'09123456789', N'02123456789', 0)
INSERT [dbo].[客戶聯絡人] ([Id], [客戶Id], [職稱], [姓名], [Email], [手機], [電話], [IsDelete]) VALUES (5, 5, N'呵呵', N'呵呵', N'123@gmail.com', N'09123456789', N'09123456789', 1)
INSERT [dbo].[客戶聯絡人] ([Id], [客戶Id], [職稱], [姓名], [Email], [手機], [電話], [IsDelete]) VALUES (6, 5, N'123', N'123', N'123@gmail.com', N'0911-111111', N'123', 0)
SET IDENTITY_INSERT [dbo].[客戶聯絡人] OFF
GO
SET IDENTITY_INSERT [dbo].[客戶資料] ON 

INSERT [dbo].[客戶資料] ([Id], [客戶名稱], [統一編號], [電話], [傳真], [地址], [Email], [IsDelete]) VALUES (1, N'多奇數位', N'12694272', N'0223222480', N'0223418318', N'台北市中正區杭州南路一段六巷五號三樓', N'service@miniasp.com', 0)
INSERT [dbo].[客戶資料] ([Id], [客戶名稱], [統一編號], [電話], [傳真], [地址], [Email], [IsDelete]) VALUES (5, N'聯電', N'2303    ', N'9123456789', N'2303', N'聯電', N'2303@gmail.com', 0)
INSERT [dbo].[客戶資料] ([Id], [客戶名稱], [統一編號], [電話], [傳真], [地址], [Email], [IsDelete]) VALUES (6, N'華南金', N'2550    ', N'2550', N'2550', N'2550', N'2550@gmail.com', 1)
SET IDENTITY_INSERT [dbo].[客戶資料] OFF
GO
SET IDENTITY_INSERT [dbo].[客戶銀行資訊] ON 

INSERT [dbo].[客戶銀行資訊] ([Id], [客戶Id], [銀行名稱], [銀行代碼], [分行代碼], [帳戶名稱], [帳戶號碼], [IsDelete]) VALUES (1, 1, N'測試銀行111', 1, 52, N'測試銀行帳戶1', N'23456789', 0)
INSERT [dbo].[客戶銀行資訊] ([Id], [客戶Id], [銀行名稱], [銀行代碼], [分行代碼], [帳戶名稱], [帳戶號碼], [IsDelete]) VALUES (2, 1, N'華南銀行', 2550, 2550, N'd2550', N'd2550', 0)
INSERT [dbo].[客戶銀行資訊] ([Id], [客戶Id], [銀行名稱], [銀行代碼], [分行代碼], [帳戶名稱], [帳戶號碼], [IsDelete]) VALUES (3, 5, N'華南銀行', 2550, 2550, N'2550', N'2550', 1)
SET IDENTITY_INSERT [dbo].[客戶銀行資訊] OFF
GO
ALTER TABLE [dbo].[客戶聯絡人] ADD  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [dbo].[客戶資料] ADD  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [dbo].[客戶銀行資訊] ADD  DEFAULT ((0)) FOR [IsDelete]
GO
ALTER TABLE [dbo].[客戶聯絡人]  WITH CHECK ADD  CONSTRAINT [FK_客戶聯絡人_客戶資料] FOREIGN KEY([客戶Id])
REFERENCES [dbo].[客戶資料] ([Id])
GO
ALTER TABLE [dbo].[客戶聯絡人] CHECK CONSTRAINT [FK_客戶聯絡人_客戶資料]
GO
ALTER TABLE [dbo].[客戶銀行資訊]  WITH CHECK ADD  CONSTRAINT [FK_客戶銀行資訊_客戶資料] FOREIGN KEY([客戶Id])
REFERENCES [dbo].[客戶資料] ([Id])
GO
ALTER TABLE [dbo].[客戶銀行資訊] CHECK CONSTRAINT [FK_客戶銀行資訊_客戶資料]
GO
