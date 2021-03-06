USE [PhoneBookDB]
GO
/****** Object:  StoredProcedure [dbo].[ContactViewByID]    Script Date: 03-Jul-2017 8:23:34 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactViewByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ContactViewByID]
GO
/****** Object:  StoredProcedure [dbo].[ContactViewAll]    Script Date: 03-Jul-2017 8:23:34 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactViewAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ContactViewAll]
GO
/****** Object:  StoredProcedure [dbo].[ContactSearchByValue]    Script Date: 03-Jul-2017 8:23:34 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactSearchByValue]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ContactSearchByValue]
GO
/****** Object:  StoredProcedure [dbo].[ContactDeleteByID]    Script Date: 03-Jul-2017 8:23:34 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactDeleteByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ContactDeleteByID]
GO
/****** Object:  StoredProcedure [dbo].[ContactAddOrEdit]    Script Date: 03-Jul-2017 8:23:34 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactAddOrEdit]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ContactAddOrEdit]
GO
/****** Object:  Table [dbo].[PhoneBook]    Script Date: 03-Jul-2017 8:23:34 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PhoneBook]') AND type in (N'U'))
DROP TABLE [dbo].[PhoneBook]
GO
/****** Object:  Table [dbo].[PhoneBook]    Script Date: 03-Jul-2017 8:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PhoneBook]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PhoneBook](
	[PhoneBookID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Contact] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Address] [varchar](250) NULL,
 CONSTRAINT [PK_PhoneBook] PRIMARY KEY CLUSTERED 
(
	[PhoneBookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[ContactAddOrEdit]    Script Date: 03-Jul-2017 8:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactAddOrEdit]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ContactAddOrEdit] AS' 
END
GO
ALTER PROC [dbo].[ContactAddOrEdit]
@PhoneBookID INT,
@FirstName VARCHAR(50),
@LastName VARCHAR(50),
@Contact VARCHAR(50),
@Email VARCHAR(50),
@Address VARCHAR(50)
AS
	IF @PhoneBookID =0
	BEGIN
		INSERT INTO PhoneBook (FirstName,LastName,Contact,Email,Address)
		VALUES (@FirstName,@LastName,@Contact,@Email,@Address)
	END
	ELSE
	BEGIN
		UPDATE PhoneBook
		SET
			FirstName=@FirstName,
			LastName=@LastName,
			Contact=@Contact,
			Email=@Email,
			Address=@Address
		WHERE PhoneBookID = @PhoneBookID
	END
GO
/****** Object:  StoredProcedure [dbo].[ContactDeleteByID]    Script Date: 03-Jul-2017 8:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactDeleteByID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ContactDeleteByID] AS' 
END
GO
ALTER PROC [dbo].[ContactDeleteByID]
@PhoneBookID INT
AS
	DELETE FROm PhoneBook
	WHERE PhoneBookID = @PhoneBookID
GO
/****** Object:  StoredProcedure [dbo].[ContactSearchByValue]    Script Date: 03-Jul-2017 8:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactSearchByValue]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ContactSearchByValue] AS' 
END
GO
ALTER PROC [dbo].[ContactSearchByValue]
@SearchValue VARCHAR(50)
AS
	SELECT *
	FROM PhoneBook
	WHERE FirstName LIKE '%'+@SearchValue+'%' OR LastName LIKE '%'+@SearchValue+'%'
GO
/****** Object:  StoredProcedure [dbo].[ContactViewAll]    Script Date: 03-Jul-2017 8:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactViewAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ContactViewAll] AS' 
END
GO
ALTER PROC [dbo].[ContactViewAll]
AS
	SELECT *
	FROM PhoneBook
GO
/****** Object:  StoredProcedure [dbo].[ContactViewByID]    Script Date: 03-Jul-2017 8:23:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactViewByID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ContactViewByID] AS' 
END
GO
ALTER PROC [dbo].[ContactViewByID]
@PhoneBookID INT
AS
	SELECT *
	FROM PhoneBook
	WHERE PhoneBookID = @PhoneBookID
GO
