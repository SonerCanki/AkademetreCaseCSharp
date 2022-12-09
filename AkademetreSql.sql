SELECT
	Product as 'Ürün',
	(SELECT Site FROM [AkademetreCase].[dbo].[Table] ta WHERE ta.Price=(SELECT MIN(Price) FROM [AkademetreCase].[dbo].[Table] ta WHERE ta.Product=t.Product)) as 'Minimum Fiyatlý Site Adý',
	(SELECT MIN(Price) FROM [AkademetreCase].[dbo].[Table] ta WHERE ta.Product=t.Product) as 'Minimum Fiyat',
	(SELECT TOP(1) Site FROM [AkademetreCase].[dbo].[Table] ta WHERE ta.Price=(SELECT MAX(Price) FROM [AkademetreCase].[dbo].[Table] ta WHERE ta.Product=t.Product) ORDER BY Site ASC) as 'Maksimum Fiyatlý Site Adý',
	(SELECT MAX(Price) FROM [AkademetreCase].[dbo].[Table] ta WHERE ta.Product=t.Product) as 'Maksimum Fiyat',
	(SELECT AVG(Price) FROM [AkademetreCase].[dbo].[Table] ta WHERE ta.Product=t.Product) as 'Ortalama Fiyat'
FROM [AkademetreCase].[dbo].[Table] t GROUP BY Product

/*--------------------------------------------*/

USE [master]
GO
/****** Object:  Database [AkademetreCase]    Script Date: 12/9/2022 12:03:08 AM ******/
CREATE DATABASE [AkademetreCase]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AkademetreCase', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AkademetreCase.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AkademetreCase_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AkademetreCase_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [AkademetreCase] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AkademetreCase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AkademetreCase] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AkademetreCase] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AkademetreCase] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AkademetreCase] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AkademetreCase] SET ARITHABORT OFF 
GO
ALTER DATABASE [AkademetreCase] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AkademetreCase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AkademetreCase] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AkademetreCase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AkademetreCase] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AkademetreCase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AkademetreCase] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AkademetreCase] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AkademetreCase] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AkademetreCase] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AkademetreCase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AkademetreCase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AkademetreCase] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AkademetreCase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AkademetreCase] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AkademetreCase] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AkademetreCase] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AkademetreCase] SET RECOVERY FULL 
GO
ALTER DATABASE [AkademetreCase] SET  MULTI_USER 
GO
ALTER DATABASE [AkademetreCase] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AkademetreCase] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AkademetreCase] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AkademetreCase] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AkademetreCase] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AkademetreCase] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'AkademetreCase', N'ON'
GO
ALTER DATABASE [AkademetreCase] SET QUERY_STORE = OFF
GO
USE [AkademetreCase]
GO
/****** Object:  Table [dbo].[Table]    Script Date: 12/9/2022 12:03:08 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table](
	[Site] [nvarchar](max) NULL,
	[Product] [nvarchar](max) NULL,
	[Price] [decimal](18, 0) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Table] ([Site], [Product], [Price]) VALUES (N'Teknosa', N'Apple iPhone 8 ', CAST(6000 AS Decimal(18, 0)))
GO
INSERT [dbo].[Table] ([Site], [Product], [Price]) VALUES (N'Hepsiburada', N'Apple iPhone 8 ', CAST(6120 AS Decimal(18, 0)))
GO
INSERT [dbo].[Table] ([Site], [Product], [Price]) VALUES (N'MediaMarkt', N'Apple iPhone 8 ', CAST(5869 AS Decimal(18, 0)))
GO
INSERT [dbo].[Table] ([Site], [Product], [Price]) VALUES (N'Amazon', N'Apple iPhone 8 ', CAST(6000 AS Decimal(18, 0)))
GO
INSERT [dbo].[Table] ([Site], [Product], [Price]) VALUES (N'Teknosa', N'PS 4', CAST(3999 AS Decimal(18, 0)))
GO
INSERT [dbo].[Table] ([Site], [Product], [Price]) VALUES (N'Hepsiburada', N'PS 4', CAST(3999 AS Decimal(18, 0)))
GO
INSERT [dbo].[Table] ([Site], [Product], [Price]) VALUES (N'MediaMarkt', N'PS 4', CAST(3999 AS Decimal(18, 0)))
GO
INSERT [dbo].[Table] ([Site], [Product], [Price]) VALUES (N'Amazon', N'PS 4', CAST(3850 AS Decimal(18, 0)))
GO
INSERT [dbo].[Table] ([Site], [Product], [Price]) VALUES (N'Teknosa', N'Apple MacBook Pro', CAST(10999 AS Decimal(18, 0)))
GO
INSERT [dbo].[Table] ([Site], [Product], [Price]) VALUES (N'Hepsiburada', N'Apple MacBook Pro', CAST(11250 AS Decimal(18, 0)))
GO
INSERT [dbo].[Table] ([Site], [Product], [Price]) VALUES (N'MediaMarkt', N'Apple MacBook Pro', CAST(10899 AS Decimal(18, 0)))
GO
INSERT [dbo].[Table] ([Site], [Product], [Price]) VALUES (N'Amazon', N'Apple MacBook Pro', CAST(13450 AS Decimal(18, 0)))
GO
USE [master]
GO
ALTER DATABASE [AkademetreCase] SET  READ_WRITE 
GO
