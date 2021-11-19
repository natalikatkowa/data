USE [master]
GO

/****** Object:  Database [school_new]    Script Date: 19.11.2021 12:41:46 ******/
CREATE DATABASE [school_new]
 CONTAINMENT = NONE
 ON  PRIMARY
( NAME = N'school', FILENAME = N'D:\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\school_new.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON
( NAME = N'school_log', FILENAME = N'D:\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\school_new_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [school_new].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [school_new] SET ANSI_NULL_DEFAULT OFF
GO

ALTER DATABASE [school_new] SET ANSI_NULLS OFF
GO

ALTER DATABASE [school_new] SET ANSI_PADDING OFF
GO

ALTER DATABASE [school_new] SET ANSI_WARNINGS OFF
GO

ALTER DATABASE [school_new] SET ARITHABORT OFF
GO

ALTER DATABASE [school_new] SET AUTO_CLOSE OFF
GO

ALTER DATABASE [school_new] SET AUTO_SHRINK OFF
GO

ALTER DATABASE [school_new] SET AUTO_UPDATE_STATISTICS ON
GO

ALTER DATABASE [school_new] SET CURSOR_CLOSE_ON_COMMIT OFF
GO

ALTER DATABASE [school_new] SET CURSOR_DEFAULT  GLOBAL
GO

ALTER DATABASE [school_new] SET CONCAT_NULL_YIELDS_NULL OFF
GO

ALTER DATABASE [school_new] SET NUMERIC_ROUNDABORT OFF
GO

ALTER DATABASE [school_new] SET QUOTED_IDENTIFIER OFF
GO

ALTER DATABASE [school_new] SET RECURSIVE_TRIGGERS OFF
GO

ALTER DATABASE [school_new] SET  DISABLE_BROKER
GO

ALTER DATABASE [school_new] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO

ALTER DATABASE [school_new] SET DATE_CORRELATION_OPTIMIZATION OFF
GO

ALTER DATABASE [school_new] SET TRUSTWORTHY OFF
GO

ALTER DATABASE [school_new] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO

ALTER DATABASE [school_new] SET PARAMETERIZATION SIMPLE
GO

ALTER DATABASE [school_new] SET READ_COMMITTED_SNAPSHOT OFF
GO

ALTER DATABASE [school_new] SET HONOR_BROKER_PRIORITY OFF
GO

ALTER DATABASE [school_new] SET RECOVERY FULL
GO

ALTER DATABASE [school_new] SET  MULTI_USER
GO

ALTER DATABASE [school_new] SET PAGE_VERIFY CHECKSUM
GO

ALTER DATABASE [school_new] SET DB_CHAINING OFF
GO

ALTER DATABASE [school_new] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF )
GO

ALTER DATABASE [school_new] SET TARGET_RECOVERY_TIME = 60 SECONDS
GO

ALTER DATABASE [school_new] SET DELAYED_DURABILITY = DISABLED
GO

ALTER DATABASE [school_new] SET ACCELERATED_DATABASE_RECOVERY = OFF
GO

ALTER DATABASE [school_new] SET QUERY_STORE = OFF
GO

ALTER DATABASE [school_new] SET  READ_WRITE
GO


CREATE TABLE [dbo].[Hub_Class](
	[Id_Class] [int] IDENTITY(1,1) NOT NULL,
	[Id_Teacher] [int] NOT NULL,
	[LoadDate] [timestamp] NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Class] PRIMARY KEY CLUSTERED
(
	[Id_Class] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Hub_GradeBook](
	[Id_GradeBook] [int] NOT NULL,
	[Id_Student] [int] IDENTITY(1,1) NOT NULL,
	[Id_Subject] [int] NOT NULL,
	[LoadDate] [timestamp] NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_GradeBook] PRIMARY KEY CLUSTERED
(
	[Id_GradeBook] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Hub_Students](
	[Id_Student] [int] IDENTITY(1,1) NOT NULL,
	[Id_Class] [int] NOT NULL,
	[LoadDate] [timestamp] NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED
(
	[Id_Student] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON


CREATE TABLE [dbo].[Sat_Students](
	[Id_Student] [int] NOT NULL,
	[LoadDate] [timestamp] NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Mobile] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
 CONSTRAINT [PK_Sat_Students] PRIMARY KEY CLUSTERED
(
	[Id_Student] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Sat_Students]  WITH CHECK ADD  CONSTRAINT [FK_Sat_Students_Hub_Students] FOREIGN KEY([Id_Student])
REFERENCES [dbo].[Hub_Students] ([Id_Student])
GO

ALTER TABLE [dbo].[Sat_Students] CHECK CONSTRAINT [FK_Sat_Students_Hub_Students]
GO


CREATE TABLE [dbo].[Sat_Subjects](
	[Id_Subject] [int] NOT NULL,
	[LoadDate] [timestamp] NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[SubjectName] [nvarchar](50) NOT NULL,
	[Definition] [nvarchar](max) NULL,
	[Files] [image] NULL,
 CONSTRAINT [PK_Sat_Subjects] PRIMARY KEY CLUSTERED
(
	[Id_Subject] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Sat_Subjects]  WITH CHECK ADD  CONSTRAINT [FK_Sat_Subjects_Hub_Subjects] FOREIGN KEY([Id_Subject])
REFERENCES [dbo].[Hub_Subjects] ([Id_Subject])
GO

ALTER TABLE [dbo].[Sat_Subjects] CHECK CONSTRAINT [FK_Sat_Subjects_Hub_Subjects]
GO

CREATE TABLE [dbo].[Sat_Teachers](
	[Id_Teacher] [int] NOT NULL,
	[LoadDate] [timestamp] NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[LastNameTeacher] [nvarchar](50) NOT NULL,
	[FirstNameTeacher] [nvarchar](50) NOT NULL,
	[Mobile] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](50) NULL,
	[Salary] [nvarchar](50) NULL,
 CONSTRAINT [PK_Sat_Teachers] PRIMARY KEY CLUSTERED
(
	[Id_Teacher] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Sat_Teachers]  WITH CHECK ADD  CONSTRAINT [FK_Sat_Teachers_Hub_Teachers] FOREIGN KEY([Id_Teacher])
REFERENCES [dbo].[Hub_Teachers] ([Id_Teacher])
GO

ALTER TABLE [dbo].[Sat_Teachers] CHECK CONSTRAINT [FK_Sat_Teachers_Hub_Teachers]
GO

CREATE TABLE [dbo].[Sat_GradeBook](
	[Id_GradeBook] [int] NOT NULL,
	[LoadDate] [timestamp] NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[Score] [float] NOT NULL,
 CONSTRAINT [PK_Sat_GradeBook] PRIMARY KEY CLUSTERED
(
	[Id_GradeBook] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Sat_GradeBook]  WITH CHECK ADD  CONSTRAINT [FK_Sat_GradeBook_Hub_GradeBook] FOREIGN KEY([Id_GradeBook])
REFERENCES [dbo].[Hub_GradeBook] ([Id_GradeBook])
GO

ALTER TABLE [dbo].[Sat_GradeBook] CHECK CONSTRAINT [FK_Sat_GradeBook_Hub_GradeBook]
GO

CREATE TABLE [dbo].[Sat_Class](
	[Id_Class] [int] NOT NULL,
	[LoadDate] [nvarchar](50) NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
	[HeadTeacher] [nvarchar](50) NULL,
 CONSTRAINT [PK_Sat_Class] PRIMARY KEY CLUSTERED
(
	[Id_Class] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Sat_Class]  WITH CHECK ADD  CONSTRAINT [FK_Sat_Class_Hub_Class] FOREIGN KEY([Id_Class])
REFERENCES [dbo].[Hub_Class] ([Id_Class])
GO

ALTER TABLE [dbo].[Sat_Class] CHECK CONSTRAINT [FK_Sat_Class_Hub_Class]
GO

CREATE TABLE [dbo].[Link_TeachersAndClasses](
	[Id_TeachersAndClasses] [int] NOT NULL,
	[Id_Teacher] [int] IDENTITY(1,1) NOT NULL,
	[Id_Class] [int] NOT NULL,
	[Id_Subject] [int] NOT NULL,
	[LoadDate] [timestamp] NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TeachersAndClasses_1] PRIMARY KEY CLUSTERED
(
	[Id_TeachersAndClasses] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Link_TeachersAndClasses]  WITH CHECK ADD  CONSTRAINT [FK_TeachersAndClasses_Class] FOREIGN KEY([Id_Class])
REFERENCES [dbo].[Hub_Class] ([Id_Class])
GO

ALTER TABLE [dbo].[Link_TeachersAndClasses] CHECK CONSTRAINT [FK_TeachersAndClasses_Class]
GO

ALTER TABLE [dbo].[Link_TeachersAndClasses]  WITH CHECK ADD  CONSTRAINT [FK_TeachersAndClasses_Subjects] FOREIGN KEY([Id_Subject])
REFERENCES [dbo].[Hub_Subjects] ([Id_Subject])
GO

ALTER TABLE [dbo].[Link_TeachersAndClasses] CHECK CONSTRAINT [FK_TeachersAndClasses_Subjects]
GO

ALTER TABLE [dbo].[Link_TeachersAndClasses]  WITH CHECK ADD  CONSTRAINT [FK_TeachersAndClasses_Teachers] FOREIGN KEY([Id_Teacher])
REFERENCES [dbo].[Hub_Teachers] ([Id_Teacher])
GO

ALTER TABLE [dbo].[Link_TeachersAndClasses] CHECK CONSTRAINT [FK_TeachersAndClasses_Teachers]
GO


CREATE TABLE [dbo].[Link_SubjectAndGradebook](
	[Id_SubjectAndGradebook] [int] NOT NULL,
	[Id_GradeBook] [int] NOT NULL,
	[Id_Subject] [int] NOT NULL,
	[LoadDate] [timestamp] NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Link_SubjectAndGradebook] PRIMARY KEY CLUSTERED
(
	[Id_SubjectAndGradebook] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Link_SubjectAndGradebook]  WITH CHECK ADD  CONSTRAINT [FK_Link_SubjectAndGradebook_Hub_GradeBook] FOREIGN KEY([Id_GradeBook])
REFERENCES [dbo].[Hub_GradeBook] ([Id_GradeBook])
GO

ALTER TABLE [dbo].[Link_SubjectAndGradebook] CHECK CONSTRAINT [FK_Link_SubjectAndGradebook_Hub_GradeBook]
GO

ALTER TABLE [dbo].[Link_SubjectAndGradebook]  WITH CHECK ADD  CONSTRAINT [FK_Link_SubjectAndGradebook_Hub_Subjects] FOREIGN KEY([Id_Subject])
REFERENCES [dbo].[Hub_Subjects] ([Id_Subject])
GO

ALTER TABLE [dbo].[Link_SubjectAndGradebook] CHECK CONSTRAINT [FK_Link_SubjectAndGradebook_Hub_Subjects]
GO


CREATE TABLE [dbo].[Link_StudentsAndGradebook](
	[Id_StudentsAndGradebook] [int] NOT NULL,
	[Id_GradeBook] [int] NOT NULL,
	[Id_Student] [int] NOT NULL,
	[LoadDate] [timestamp] NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Link_StudentsAndGradebook] PRIMARY KEY CLUSTERED
(
	[Id_StudentsAndGradebook] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Link_StudentsAndGradebook]  WITH CHECK ADD  CONSTRAINT [FK_Link_StudentsAndGradebook_Hub_GradeBook] FOREIGN KEY([Id_GradeBook])
REFERENCES [dbo].[Hub_GradeBook] ([Id_GradeBook])
GO

ALTER TABLE [dbo].[Link_StudentsAndGradebook] CHECK CONSTRAINT [FK_Link_StudentsAndGradebook_Hub_GradeBook]
GO

ALTER TABLE [dbo].[Link_StudentsAndGradebook]  WITH CHECK ADD  CONSTRAINT [FK_Link_StudentsAndGradebook_Hub_Students] FOREIGN KEY([Id_Student])
REFERENCES [dbo].[Hub_Students] ([Id_Student])
GO

ALTER TABLE [dbo].[Link_StudentsAndGradebook] CHECK CONSTRAINT [FK_Link_StudentsAndGradebook_Hub_Students]
GO

CREATE TABLE [dbo].[Link_StudentAndClass](
	[Id_StudentAndClass] [int] NOT NULL,
	[Id_Student] [int] NOT NULL,
	[Id_Class] [int] NOT NULL,
	[LoadDate] [timestamp] NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_StudentAndClass] PRIMARY KEY CLUSTERED
(
	[Id_StudentAndClass] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Link_StudentAndClass]  WITH CHECK ADD  CONSTRAINT [FK_StudentAndClass_Class] FOREIGN KEY([Id_Class])
REFERENCES [dbo].[Hub_Class] ([Id_Class])
GO

ALTER TABLE [dbo].[Link_StudentAndClass] CHECK CONSTRAINT [FK_StudentAndClass_Class]
GO

ALTER TABLE [dbo].[Link_StudentAndClass]  WITH CHECK ADD  CONSTRAINT [FK_StudentAndClass_Students1] FOREIGN KEY([Id_Student])
REFERENCES [dbo].[Hub_Students] ([Id_Student])
GO

ALTER TABLE [dbo].[Link_StudentAndClass] CHECK CONSTRAINT [FK_StudentAndClass_Students1]
GO

CREATE TABLE [dbo].[Hub_Teachers](
	[Id_Teacher] [int] IDENTITY(1,1) NOT NULL,
	[LoadDate] [timestamp] NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Teachers] PRIMARY KEY CLUSTERED
(
	[Id_Teacher] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Hub_Subjects](
	[Id_Subject] [int] IDENTITY(1,1) NOT NULL,
	[LoadDate] [timestamp] NOT NULL,
	[RecordSource] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Subjects] PRIMARY KEY CLUSTERED
(
	[Id_Subject] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
