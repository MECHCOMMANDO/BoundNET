USE [master]
GO
/****** Object:  Database [BoundNETData]    Script Date: 5/3/2019 10:14:31 AM ******/
CREATE DATABASE [BoundNETData]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BoundNETData', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.DYLAN\MSSQL\DATA\BoundNETData.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BoundNETData_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.DYLAN\MSSQL\DATA\BoundNETData_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BoundNETData] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BoundNETData].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BoundNETData] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BoundNETData] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BoundNETData] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BoundNETData] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BoundNETData] SET ARITHABORT OFF 
GO
ALTER DATABASE [BoundNETData] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [BoundNETData] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [BoundNETData] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BoundNETData] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BoundNETData] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BoundNETData] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BoundNETData] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BoundNETData] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BoundNETData] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BoundNETData] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BoundNETData] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BoundNETData] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BoundNETData] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BoundNETData] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BoundNETData] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BoundNETData] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BoundNETData] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BoundNETData] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BoundNETData] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BoundNETData] SET  MULTI_USER 
GO
ALTER DATABASE [BoundNETData] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BoundNETData] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BoundNETData] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BoundNETData] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [BoundNETData]
GO
/****** Object:  StoredProcedure [dbo].[SP_DeletePaymentInfo]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei 
-- Create date: 4/17/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_DeletePaymentInfo] 
	-- Add the parameters for the stored procedure here
	@CustomerID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM [dbo].[Profile_Info]
      WHERE CustomerID = @CustomerID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_DeletePlayerStats]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Dylan Quinones Mattei 
-- Create date: 4/17/2019
-- Description:	Stored Procedures for the deletion of Player Stats in the case of administrator ban and/or account deletion. 
-- =============================================
CREATE PROCEDURE [dbo].[SP_DeletePlayerStats]
	-- Add the parameters for the stored procedure here
	@UserID int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM [dbo].[Player_Stats]
      WHERE UserID = @UserID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteProfileInfo]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei 
-- Create date: 4/17/2019
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SP_DeleteProfileInfo]
	-- Add the parameters for the stored procedure here
	@Username varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM [dbo].[Profile_Info]
      WHERE Username = @Username 
END

GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteUserLogin]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_DeleteUserLogin]
	-- Add the parameters for the stored procedure here
	@UserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM [dbo].[User_login]
      WHERE UserID = @UserID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_InsertPaymentInfo]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei 
-- Create date: 4/16/2019
-- Description:	Stored Procedures for inserting payment information upon account creation. 
-- =============================================
CREATE PROCEDURE [dbo].[SP_InsertPaymentInfo]
	-- Add the parameters for the stored procedure here
			@OrderID int output, 
            @CustomerID int,
            @Name varchar(50),
            @CreditCardNumber int,
            @ExpirationDate date,
            @CVCcode int,
            @Zipcode int,
            @ItemPurchased varchar(50),
            @DatePurchased date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[Payment_info]
           ([CustomerID]
           ,[Name]
           ,[CreditCardNumber]
           ,[ExpirationDate]
           ,[CVCcode]
           ,[Zipcode]
           ,[ItemPurchased]
           ,[DatePurchased])
     VALUES (@CustomerID, @Name, @CreditCardNumber, @ExpirationDate, @CVCcode, @Zipcode, @ItemPurchased, @DatePurchased);
	 SELECT CustomerID = @@IDENTITY
END


GO
/****** Object:  StoredProcedure [dbo].[SP_InsertPlayerStats]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei 
-- Create date: 4/16/2019
-- Description:	Stored Procedures for inserting player stats columns upon user account registration.
-- =============================================
CREATE PROCEDURE [dbo].[SP_InsertPlayerStats] 
	-- Add the parameters for the stored procedure here
			@UserID int output,
            @Username varchar(50),
            @InGameRank int,
            @Progression int,
            @LongestSurvivalTime time(7),
            @HighestElevation int,
            @HighScore int,
            @TimePlayed time(7)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[Player_Stats]
           ([Username]
           ,[InGameRank]
           ,[Progression]
           ,[LongestSurvivalTime]
           ,[HighestElevation]
           ,[HighScore]
           ,[TimePlayed])
     VALUES (@Username, @InGameRank, @Progression, @LongestSurvivalTime,
		    @HighestElevation, @HighScore, @TimePlayed);
	SELECT @UserID = @@IDENTITY
END

GO
/****** Object:  StoredProcedure [dbo].[SP_InsertProfileInfo]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/16/2019
-- Description:	Created Stored porcedure for inserting profile info upon user account registration. 
-- =============================================
CREATE PROCEDURE [dbo].[SP_InsertProfileInfo] 
	-- Add the parameters for the stored procedure here
			@CustomerID int output,
			@Username varchar(50),
            @FirstName varchar(50),
            @LastName varchar(50),
			@RoleType varchar(50),
            @Email varchar(50),
            @Address varchar(50),
            @City varchar(50),
            @State varchar(50),
            @ZipCode int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[Profile_info]
           ([Username]
           ,[FirstName]
           ,[LastName]
		   ,[RoleType]
           ,[Email]
           ,[Address]
           ,[City]
           ,[State]
           ,[ZipCode])
	VALUES (@Username, @FirstName, @LastName, @RoleType, @Email, @Address, @City, @State, @ZipCode);
	SELECT CustomerID = @@IDENTITY 
END


GO
/****** Object:  StoredProcedure [dbo].[SP_InsertUserLogin]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/11/2019
-- Description:	Stored procedure for inserting UserID, Email, and Password upon account registration.
-- =============================================
CREATE PROCEDURE [dbo].[SP_InsertUserLogin] 
	-- Add the parameters for the stored procedure here 
	@Email varchar(250),
	@Password varchar(50),
	@RoleType varchar(50),
	@UserID int output
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[User_login]
           ([Email]
           ,[Password]
           ,[Roletype])
	VALUES (@Email, @Password, @RoleType);
	SELECT @UserID = @@IDENTITY
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePaymentInfo]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdatePaymentInfo]
	-- Add the parameters for the stored procedure here
       @OrderID int,
       @CustomerID int,
       @Name varchar(250),
       @CreditCardNumber int,
       @ExpirationDate date,
       @CVCcode int,
       @Zipcode int,
       @ItemPurchased varchar(250),
       @DatePurchased date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Payment_Info]
   SET CustomerID = @CustomerID,
	   Name = @Name,
       CreditCardNumber = @CreditCardNumber, 
       ExpirationDate =  @ExpirationDate, 
       CVCcode = @CVCcode, 
       Zipcode = @Zipcode, 
       ItemPurchased = @ItemPurchased, 
       DatePurchased = @DatePurchased
WHERE CustomerID = @CustomerID 
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePaymentInfoCreditCardNumber]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei 
-- Create date: 4/26/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdatePaymentInfoCreditCardNumber]
	-- Add the parameters for the stored procedure here
	@CreditCardNumber int,
	@CustomerID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Payment_Info]
	SET CreditCardNumber = @CreditCardNumber
	WHERE CustomerID = @CustomerID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePaymentInfoCVCcode]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei 
-- Create date: 4/26/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdatePaymentInfoCVCcode]
	-- Add the parameters for the stored procedure here
	@CVCcode int,
	@CustomerID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Payment_Info]
	SET CVCcode = @CVCcode
	WHERE CustomerID = @CustomerID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePaymentInfoDatePurchased]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei 
-- Create date: 4/26/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdatePaymentInfoDatePurchased]
	-- Add the parameters for the stored procedure here
	@DatePurchased Datetime,
	@CustomerID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Payment_Info]
	SET DatePurchased = @DatePurchased
	WHERE CustomerID = @CustomerID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePaymentInfoExpirationDate]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei 
-- Create date: 4/26/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdatePaymentInfoExpirationDate]
	-- Add the parameters for the stored procedure here
	@ExpirationDate Datetime,
	@CustomerID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Payment_Info]
	SET ExpirationDate = @ExpirationDate
	WHERE CustomerID = @CustomerID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePaymentInfoName]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei 
-- Create date: 4/26/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdatePaymentInfoName] 
	-- Add the parameters for the stored procedure here
	@Name varchar(250),
	@CustomerID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Payment_Info]
	SET Name = @Name
	WHERE CustomerID = @CustomerID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePaymentInfoZipCode]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei 
-- Create date: 4/26/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdatePaymentInfoZipCode]
	-- Add the parameters for the stored procedure here
	@ZipCode int,
	@CustomerID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Payment_Info]
	SET ZipCode = @ZipCode
	WHERE CustomerID = @CustomerID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePaymentItemPurchased]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei 
-- Create date: 4/26/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdatePaymentItemPurchased]
	-- Add the parameters for the stored procedure here
	@ItemPurchased varchar(250),
	@CustomerID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Payment_Info]
	SET ItemPurchased = @ItemPurchased
	WHERE CustomerID = @CustomerID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePlayerStats]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/19/2019
-- Description:	Created Stored Procedures for updating user's player stats for real-time calculations. 
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdatePlayerStats]
	-- Add the parameters for the stored procedure here
	   @UserID int,
       @Username varchar(50),
       @InGameRank int,
       @Progression int,
       @LongestSurvivalTime time(7),
       @HighestElevation int,
       @HighScore int,
       @TimePlayed time(7)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- Insert statements for procedure here
	UPDATE [dbo].[Player_Stats]
   SET  Username = @Username,
        InGameRank = @InGameRank,
        Progression = @Progression, 
        LongestSurvivalTime = @LongestSurvivalTime,
        HighestElevation = @HighestElevation, 
        HighScore = @HighScore, 
        TimePlayed = @TimePlayed
 WHERE UserID = @UserID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePlayerStatsHighestElevation]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/22/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdatePlayerStatsHighestElevation] 
	-- Add the parameters for the stored procedure here
	@UserID int, 
	@HighestElevation int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Player_Stats]
	SET [HighestElevation] = @HighestElevation
	WHERE UserID = @UserID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePlayerStatsHighScore]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/22/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdatePlayerStatsHighScore] 
	-- Add the parameters for the stored procedure here
	@UserID int, 
	@HighScore int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Player_Stats]
	SET [HighScore] = @HighScore
	WHERE UserID = @UserID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePlayerStatsInGameRank]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/22/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdatePlayerStatsInGameRank] 
	-- Add the parameters for the stored procedure here
	@UserID int, 
	@InGameRank int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Player_Stats]
	SET [InGameRank] = @InGameRank
	WHERE UserID = @UserID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePlayerStatsLongestSurvivalTime]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/22/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdatePlayerStatsLongestSurvivalTime] 
	-- Add the parameters for the stored procedure here
	@UserID int, 
	@LongestSurvivalTime time
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Player_Stats]
	SET [LongestSurvivalTime] = @LongestSurvivalTime
	WHERE UserID = @UserID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePlayerStatsProgression]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/22/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdatePlayerStatsProgression] 
	-- Add the parameters for the stored procedure here
	@UserID int, 
	@Progression int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Player_Stats]
	SET [Progression] = @Progression
	WHERE UserID = @UserID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePlayerStatsTimePlayed]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/22/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdatePlayerStatsTimePlayed] 
	-- Add the parameters for the stored procedure here
	@UserID int, 
	@TimePlayed time
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Player_Stats]
	SET [TimePlayed] = @TimePlayed
	WHERE UserID = @UserID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdatePlayerStatsUsername]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/22/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdatePlayerStatsUsername] 
	-- Add the parameters for the stored procedure here
	@Username varchar(50),
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Player_Stats]
	SET [Username] = @Username
	WHERE UserID = @UserID 
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateProfileInfo]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/17/2019
-- Description:	Stored Procedures for updating user profile information.
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdateProfileInfo]
	-- Add the parameters for the stored procedure here
	@CustomerID int,
	@Username varchar(50),
	@FirstName varchar(50),
	@LastName varchar(50),
	@RoleType varchar(50),
	@Email varchar(250),
	@Address varchar(250),
	@City varchar(50),
	@State varchar(50),
	@ZipCode int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Profile_info]
   SET [Username] = @Username, 
       [FirstName] = @FirstName, 
       [LastName] = @LastName, 
	   [RoleType] = @RoleType,
       [Email] = @Email, 
       [Address] = @Address,
       [City] = @City,
       [State] = @State, 
       [ZipCode] = @ZipCode
 WHERE Username = @Username 
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateProfileInfoAddress]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/24/2019
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdateProfileInfoAddress]
	-- Add the parameters for the stored procedure here
	@Address varchar(250),
	@Username varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Profile_Info]
	SET [Address] = @Address
	WHERE Username = @Username
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateProfileInfoCity]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/24/2019
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdateProfileInfoCity]
	-- Add the parameters for the stored procedure here
	@City varchar(50),
	@Username varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Profile_Info]
	SET [City] = @City
	WHERE Username = @Username
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateProfileInfoEmail]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Dylan Quinones Mattei>
-- Create date: <4/22/2019>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdateProfileInfoEmail] 
	-- Add the parameters for the stored procedure here
	@Username varchar(50),
	@Email varchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Profile_Info]
	SET [Email] = @Email
	WHERE [Username] = @Username
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateProfileInfoFirstName]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/22/2019
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdateProfileInfoFirstName]
	-- Add the parameters for the stored procedure here
	@FirstName varchar(50),
	@Username varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Profile_Info]
	SET [FirstName] = @FirstName
	WHERE Username = @Username
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateProfileInfoLastName]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/22/2019
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdateProfileInfoLastName]
	-- Add the parameters for the stored procedure here
	@LastName varchar(50),
	@Username varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Profile_Info]
	SET [LastName] = @LastName
	WHERE Username = @Username
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateProfileInfoRoleType]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei 
-- Create date: 5/1/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdateProfileInfoRoleType] 
	-- Add the parameters for the stored procedure here
	@Username varchar(50),
	@RoleType varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Profile_Info]
	SET RoleType = @RoleType
	WHERE Username = @Username 
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateProfileInfoState]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/24/2019
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdateProfileInfoState]
	-- Add the parameters for the stored procedure here
	@State varchar(50),
	@Username varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Profile_Info]
	SET [State] = @State
	WHERE Username = @Username
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateProfileInfoUsername]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/22/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdateProfileInfoUsername] 
	-- Add the parameters for the stored procedure here
	@Username varchar(50),
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Player_Stats]
	SET [Username] = @Username
	WHERE UserID = @UserID 
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateProfileInfoZipCode]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/24/2019
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdateProfileInfoZipCode]
	-- Add the parameters for the stored procedure here
	@ZipCode int,
	@Username varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Profile_Info]
	SET [ZipCode] = @ZipCode
	WHERE Username = @Username
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateUserLogin]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UpdateUserLogin] 
	-- Add the parameters for the stored procedure here
	@UserID int,
	@Email varchar(250),
	@Password varchar(50),
	@RoleType varchar(50),
	@Salt varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE [dbo].[User_login]
   SET [Email] = @Email,
       [Password] = @Password,
       [Roletype] = @Roletype,
       [Salt] = @Salt
 WHERE UserID = @UserID

END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateUserLoginEmail]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Dylan Quinones Mattei>
-- Create date: <4/22/2019>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdateUserLoginEmail] 
	-- Add the parameters for the stored procedure here
	@UserID int,
	@Email varchar(250)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[User_Login]
	SET [Email] = @Email
	WHERE [UserID] = @UserID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateUserLoginPassword]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Dylan Quinones Mattei>
-- Create date: <4/22/2019>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdateUserLoginPassword] 
	-- Add the parameters for the stored procedure here
	@UserID int,
	@Password varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[User_Login]
	SET [Password] = @Password
	WHERE [UserID] = @UserID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateUserLoginRoleType]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones 
-- Create date: 5/1/2019
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UpdateUserLoginRoleType]
	-- Add the parameters for the stored procedure here
	@UserID int, 
	@Roletype varchar(50)
AS	
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[User_Login]
	SET Roletype = @Roletype
	WHERE UserID = @UserID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ViewAllPaymentInfo]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei 
-- Create date: 4/16/2019
-- Description:	Created Stored Procedure for administrator power of viewing all user stats and leaderboard calculations!
-- =============================================
CREATE PROCEDURE [dbo].[SP_ViewAllPaymentInfo] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [dbo].[Payment_Info]
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ViewAllPlayerStats]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei 
-- Create date: 4/16/2019
-- Description:	Created Stored Procedure for administrator power of viewing all user stats and leaderboard calculations!
-- =============================================
CREATE PROCEDURE [dbo].[SP_ViewAllPlayerStats] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [dbo].[Player_Stats]
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ViewAllProfileInfo]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/16/2019
-- Description:	Created Stored Procedure for viewing all user's profile info for administrator powers and paypal information autofill functions.  
-- =============================================
CREATE PROCEDURE [dbo].[SP_ViewAllProfileInfo] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [dbo].[Profile_info]
END


GO
/****** Object:  StoredProcedure [dbo].[SP_ViewAllUserLogin]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ViewAllUserLogin]
AS
SELECT * FROM User_login

GO
/****** Object:  StoredProcedure [dbo].[SP_ViewIndividualPaymentInfo]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei 
-- Create date: 4/17/2019
-- Description: Stored Procedures for viewing payment information for each individual user.
-- =============================================
CREATE PROCEDURE [dbo].[SP_ViewIndividualPaymentInfo] 
	-- Add the parameters for the stored procedure here
	@CustomerID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [dbo].[Payment_info]
		WHERE CustomerID = @CustomerID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ViewIndividualPlayerStats]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/29/2019
-- Description:	Creating a Stored Procedure to view an individuals player statistics!
-- =============================================
CREATE PROCEDURE [dbo].[SP_ViewIndividualPlayerStats]
	-- Add the parameters for the stored procedure here
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [DBO].[Player_Stats]
		WHERE UserID = @UserID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ViewIndividualProfileInfo]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/29/2019
-- Description:	Creating a Stored Procedure to view an individuals profile information!
-- =============================================
CREATE PROCEDURE [dbo].[SP_ViewIndividualProfileInfo]
	-- Add the parameters for the stored procedure here
	@Username varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [DBO].[Profile_Info]
		WHERE Username = @Username
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ViewIndividualUserEmailAuthentication]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ViewIndividualUserEmailAuthentication] 
	-- Add the parameters for the stored procedure here
	@Email varchar(250)
AS
BEGIN
SELECT * FROM [dbo].[User_login]
WHERE 
	Email = @Email
	
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ViewIndividualUserLogin]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei
-- Create date: 4/29/2019
-- Description:	Creating Stored Procedure to view an indivdual's user login
-- =============================================
CREATE PROCEDURE [dbo].[SP_ViewIndividualUserLogin] 
	-- Add the parameters for the stored procedure here
	@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [dbo].[User_Login]
	WHERE UserID = @UserID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ViewPaymentInfoByCustomerID]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei 
-- Create date: 4/16/2019
-- Description:	Created Stored Procedure for administrator power of viewing all user stats and leaderboard calculations!
-- =============================================
CREATE PROCEDURE [dbo].[SP_ViewPaymentInfoByCustomerID]
@CustomerID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [dbo].[Payment_Info]
	WHERE CustomerID = @CustomerID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ViewPlayerStatsByUserID]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei 
-- Create date: 4/16/2019
-- Description:	Created Stored Procedure for administrator power of viewing all user stats and leaderboard calculations!
-- =============================================
CREATE PROCEDURE [dbo].[SP_ViewPlayerStatsByUserID] 
@UserID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [dbo].[Player_Stats]
	WHERE UserID = @UserID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ViewProfileInfoByUsername]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dylan Quinones Mattei 
-- Create date: 4/16/2019
-- Description:	Created Stored Procedure for administrator power of viewing all user stats and leaderboard calculations!
-- =============================================
CREATE PROCEDURE [dbo].[SP_ViewProfileInfoByUsername]
@Username varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM [dbo].[Profile_Info]
	WHERE Username = @Username
END

GO
/****** Object:  Table [dbo].[Payment_Info]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Payment_Info](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[Name] [varchar](250) NOT NULL,
	[CreditCardNumber] [int] NOT NULL,
	[ExpirationDate] [date] NOT NULL,
	[CVCcode] [int] NOT NULL,
	[Zipcode] [int] NOT NULL,
	[ItemPurchased] [varchar](250) NOT NULL,
	[DatePurchased] [date] NOT NULL,
 CONSTRAINT [PK_Payment_Info_1] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Player_Stats]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Player_Stats](
	[UserID] [int] NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[InGameRank] [int] NOT NULL,
	[Progression] [int] NOT NULL,
	[LongestSurvivalTime] [time](7) NOT NULL,
	[HighestElevation] [int] NOT NULL,
	[HighScore] [int] NOT NULL,
	[TimePlayed] [time](7) NOT NULL,
 CONSTRAINT [PK_Player_Stats_1] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profile_Info]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profile_Info](
	[CustomerID] [int] IDENTITY(4,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[RoleType] [varchar](50) NOT NULL,
	[Email] [varchar](250) NOT NULL,
	[Address] [varchar](250) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [varchar](50) NOT NULL,
	[ZipCode] [int] NOT NULL,
 CONSTRAINT [PK_Profile_info] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User_Login]    Script Date: 5/3/2019 10:14:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User_Login](
	[UserID] [int] IDENTITY(4,1) NOT NULL,
	[Email] [varchar](250) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Roletype] [varchar](50) NOT NULL,
	[Salt] [varchar](20) NOT NULL,
 CONSTRAINT [PK_User_login] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Player_Stats] ([UserID], [Username], [InGameRank], [Progression], [LongestSurvivalTime], [HighestElevation], [HighScore], [TimePlayed]) VALUES (1, N'Lyrically_Gifted', 1, 0, CAST(0x0700000000000000 AS Time), 0, 0, CAST(0x0700000000000000 AS Time))
INSERT [dbo].[Player_Stats] ([UserID], [Username], [InGameRank], [Progression], [LongestSurvivalTime], [HighestElevation], [HighScore], [TimePlayed]) VALUES (2, N'MECHCOMMANDO', 1, 0, CAST(0x0700000000000000 AS Time), 0, 0, CAST(0x0700000000000000 AS Time))
INSERT [dbo].[Player_Stats] ([UserID], [Username], [InGameRank], [Progression], [LongestSurvivalTime], [HighestElevation], [HighScore], [TimePlayed]) VALUES (3, N'Toxic_Decepticon', 1, 0, CAST(0x0700000000000000 AS Time), 0, 0, CAST(0x0700000000000000 AS Time))
SET IDENTITY_INSERT [dbo].[Profile_Info] ON 

INSERT [dbo].[Profile_Info] ([CustomerID], [Username], [FirstName], [LastName], [RoleType], [Email], [Address], [City], [State], [ZipCode]) VALUES (1, N'Lyrically_Gifted', N'Snoop', N'Dogg', N'dbo', N'snoopdogg@gmail.com', N'911 Beverly Hills Dr.', N'Los Angeles', N'CA', 91210)
INSERT [dbo].[Profile_Info] ([CustomerID], [Username], [FirstName], [LastName], [RoleType], [Email], [Address], [City], [State], [ZipCode]) VALUES (2, N'MECHCOMMANDO', N'Dylan ', N'Quinones', N'dbo', N'quinonesmatteidylan@gmail.com', N'910 Bradwell St. ', N'Hinesville ', N'GA ', 31313)
INSERT [dbo].[Profile_Info] ([CustomerID], [Username], [FirstName], [LastName], [RoleType], [Email], [Address], [City], [State], [ZipCode]) VALUES (3, N'Toxic_Decepticon', N'Optimus', N'Prime', N'dbo', N'optimusprime@gmail.com', N'117 Autobot Dr.', N'Cybertron City', N'N/A', 0)
SET IDENTITY_INSERT [dbo].[Profile_Info] OFF
SET IDENTITY_INSERT [dbo].[User_Login] ON 

INSERT [dbo].[User_Login] ([UserID], [Email], [Password], [Roletype], [Salt]) VALUES (1, N'snoopdogg@gmail.com', N'PASSWORD', N'Moderator', N'0')
INSERT [dbo].[User_Login] ([UserID], [Email], [Password], [Roletype], [Salt]) VALUES (2, N'quinonesmatteidylan@gmail.com', N'PASSWORD1', N'Administrator', N'0')
INSERT [dbo].[User_Login] ([UserID], [Email], [Password], [Roletype], [Salt]) VALUES (3, N'optimusprime@gmail.com', N'PASSWORD2', N'User', N'0')
SET IDENTITY_INSERT [dbo].[User_Login] OFF
ALTER TABLE [dbo].[Payment_Info] ADD  CONSTRAINT [DF_Payment_info_CustomerID]  DEFAULT ((0)) FOR [CustomerID]
GO
ALTER TABLE [dbo].[Player_Stats] ADD  CONSTRAINT [DF_Player_Stats_UserID]  DEFAULT ((0)) FOR [UserID]
GO
ALTER TABLE [dbo].[Player_Stats] ADD  CONSTRAINT [DF_Player_Stats_Username]  DEFAULT ('robot') FOR [Username]
GO
ALTER TABLE [dbo].[Player_Stats] ADD  CONSTRAINT [DF_Player_Stats_TimePlayed]  DEFAULT ('00:00:00') FOR [TimePlayed]
GO
ALTER TABLE [dbo].[Profile_Info] ADD  CONSTRAINT [DF_Profile_info_Username]  DEFAULT ('robo') FOR [Username]
GO
ALTER TABLE [dbo].[Profile_Info] ADD  CONSTRAINT [DF_Profile_Info_RoleType]  DEFAULT (user_name()) FOR [RoleType]
GO
ALTER TABLE [dbo].[Profile_Info] ADD  CONSTRAINT [DF_Profile_info_ZipCode]  DEFAULT ((0)) FOR [ZipCode]
GO
ALTER TABLE [dbo].[User_Login] ADD  CONSTRAINT [DF_User_login_Email]  DEFAULT ('@gmail.com') FOR [Email]
GO
ALTER TABLE [dbo].[User_Login] ADD  CONSTRAINT [DF_User_login_Salt]  DEFAULT ((0)) FOR [Salt]
GO
ALTER TABLE [dbo].[Payment_Info]  WITH CHECK ADD  CONSTRAINT [ProfileInfoGrabbingPaymentInfo] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Profile_Info] ([CustomerID])
GO
ALTER TABLE [dbo].[Payment_Info] CHECK CONSTRAINT [ProfileInfoGrabbingPaymentInfo]
GO
ALTER TABLE [dbo].[Player_Stats]  WITH CHECK ADD  CONSTRAINT [UserLoginGrabbingPlayerStats] FOREIGN KEY([UserID])
REFERENCES [dbo].[User_Login] ([UserID])
GO
ALTER TABLE [dbo].[Player_Stats] CHECK CONSTRAINT [UserLoginGrabbingPlayerStats]
GO
ALTER TABLE [dbo].[Profile_Info]  WITH CHECK ADD  CONSTRAINT [PlayerStatsGrabbingProfileInfo] FOREIGN KEY([Username])
REFERENCES [dbo].[Player_Stats] ([Username])
GO
ALTER TABLE [dbo].[Profile_Info] CHECK CONSTRAINT [PlayerStatsGrabbingProfileInfo]
GO
USE [master]
GO
ALTER DATABASE [BoundNETData] SET  READ_WRITE 
GO
