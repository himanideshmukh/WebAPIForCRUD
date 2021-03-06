USE [ThinkBridgeTest]
GO
/****** Object:  StoredProcedure [dbo].[USP_ItemMaster]    Script Date: 03-06-2022 00:22:43 ******/
DROP PROCEDURE [dbo].[USP_ItemMaster]
GO
/****** Object:  Table [dbo].[tblItemMaster]    Script Date: 03-06-2022 00:22:43 ******/
DROP TABLE [dbo].[tblItemMaster]
GO
/****** Object:  Table [dbo].[tblItemMaster]    Script Date: 03-06-2022 00:22:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblItemMaster](
	[Item_ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](200) NULL,
	[Price] [decimal](18, 2) NULL,
	[Isactive] [tinyint] NULL,
	[CreatedBy] [int] NULL,
	[CreatedOn] [nchar](10) NULL,
	[CreatedByIP] [datetime] NULL,
	[UpdatedBy] [int] NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedByIP] [varchar](50) NULL,
	[DeletedBy] [int] NULL,
	[DeletedOn] [datetime] NULL,
	[DeletedByIP] [varchar](50) NULL,
 CONSTRAINT [PK_tblItemMaster] PRIMARY KEY CLUSTERED 
(
	[Item_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[tblItemMaster] ON 

INSERT [dbo].[tblItemMaster] ([Item_ID], [Name], [Description], [Price], [Isactive], [CreatedBy], [CreatedOn], [CreatedByIP], [UpdatedBy], [UpdatedOn], [UpdatedByIP], [DeletedBy], [DeletedOn], [DeletedByIP]) VALUES (1, N'CFL', N'CFL for use', CAST(50.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tblItemMaster] ([Item_ID], [Name], [Description], [Price], [Isactive], [CreatedBy], [CreatedOn], [CreatedByIP], [UpdatedBy], [UpdatedOn], [UpdatedByIP], [DeletedBy], [DeletedOn], [DeletedByIP]) VALUES (2, N'HP Laptop', N'Office Use', CAST(50000.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[tblItemMaster] OFF
/****** Object:  StoredProcedure [dbo].[USP_ItemMaster]    Script Date: 03-06-2022 00:22:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[USP_ItemMaster]
@flag int = null,
@Item_ID int = null
, @Name nvarchar(100) = null
, @Description nvarchar(200) = null
, @Price decimal(18,2) = null
AS
BEGIN
	declare @Msg varchar(10), @ErrorMsg varchar(25)
	if(@flag = 1)
	BEGIN
		if not exists (select * from tblItemMaster where Item_ID = @Item_ID)
		BEGIN
			insert into tblItemMaster (Name,Description,Price,Isactive, CreatedOn )
			values (@Name,@Description,@Price, 1, DATEADD(MINUTE, 330, GETUTCDATE()))

			set @Msg = 'Ok'
			set @ErrorMsg = 'Record saved successfully.'
		END
		else
		BEGIN
			set @Msg = 'Not Ok'
			set @ErrorMsg = 'Record already exists.'
		END
	END
	if(@flag = 2)
	BEGIN
		Update tblItemMaster 
		set Name = @Name,
			Description = @Description,
			Price = @Price,
			UpdatedOn = DATEADD(MINUTE, 330, GETUTCDATE())
		where Item_ID = @Item_ID
	END
	if(@flag = 3)
	BEGIN
		Delete from tblItemMaster
		where Item_ID = @Item_ID
	END
	if(@flag = 4)
	BEGIN
		select Name,Description,Price from tblItemMaster
		where Isactive = 1
	END
END

GO
