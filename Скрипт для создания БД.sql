USE [master]
GO
/****** Object:  Database [raspisanie]    Script Date: 14.09.2023 12:42:02 ******/
CREATE DATABASE [raspisanie]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'raspisanie_Data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\raspisanie.mdf' , SIZE = 27648KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'raspisanie_Log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\raspisanie.ldf' , SIZE = 46272KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [raspisanie] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [raspisanie].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [raspisanie] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [raspisanie] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [raspisanie] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [raspisanie] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [raspisanie] SET ARITHABORT OFF 
GO
ALTER DATABASE [raspisanie] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [raspisanie] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [raspisanie] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [raspisanie] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [raspisanie] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [raspisanie] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [raspisanie] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [raspisanie] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [raspisanie] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [raspisanie] SET  ENABLE_BROKER 
GO
ALTER DATABASE [raspisanie] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [raspisanie] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [raspisanie] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [raspisanie] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [raspisanie] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [raspisanie] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [raspisanie] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [raspisanie] SET RECOVERY FULL 
GO
ALTER DATABASE [raspisanie] SET  MULTI_USER 
GO
ALTER DATABASE [raspisanie] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [raspisanie] SET DB_CHAINING OFF 
GO
ALTER DATABASE [raspisanie] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [raspisanie] SET TARGET_RECOVERY_TIME = 120 SECONDS 
GO
ALTER DATABASE [raspisanie] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [raspisanie] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'raspisanie', N'ON'
GO
ALTER DATABASE [raspisanie] SET QUERY_STORE = ON
GO
ALTER DATABASE [raspisanie] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = ALL, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [raspisanie]
GO
/****** Object:  UserDefinedFunction [dbo].[ShortFIO]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[ShortFIO]
(
	@Surname nvarchar(50),
	@Name nvarchar(40),
	@Patronymic nvarchar(50)
)
RETURNS NVARCHAR(140)
AS
BEGIN
	DECLARE @FIO NVARCHAR(140)


	IF @SurName IS NOT NULL AND @Name IS NOT NULL AND @Patronymic IS NOT NULL
		SET @FIO = UPPER(SUBSTRING(LTRIM(RTRIM(@SurName)), 1, 1)) + LOWER(SUBSTRING(LTRIM(RTRIM(@SurName)), 2, LEN(LTRIM(RTRIM(@SurName))))) +
			   ' ' + 
			   UPPER(SUBSTRING(LTRIM(RTRIM(@Name)), 1, 1)) + 
			   '. ' + 
			   UPPER(SUBSTRING(LTRIM(RTRIM(@Patronymic)), 1, 1)) + 
			   '.';
	IF @FIO =' . .' SET @FIO=NULL
	RETURN @FIO
END
GO
/****** Object:  UserDefinedFunction [dbo].[ShortTime]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ShortTime]
(
	@first time(0),
	@second time(0)
)
RETURNS nvarchar(11)
AS
BEGIN
	
	DECLARE @return nvarchar(11)

	IF @first IS NOT NULL AND @second IS NOT NULL
		
		SET @return = CONVERT(nvarchar(5), @first, 108) + '/' + CONVERT(nvarchar(5), @second, 108)

	RETURN @return

END
GO
/****** Object:  Table [dbo].[changes]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[changes](
	[guid] [uniqueidentifier] NOT NULL,
	[week_guid] [uniqueidentifier] NOT NULL,
	[day_guid] [uniqueidentifier] NOT NULL,
	[time_guid] [uniqueidentifier] NOT NULL,
	[group_guid] [uniqueidentifier] NOT NULL,
	[lesson_guid] [uniqueidentifier] NOT NULL,
	[room_guid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Изменения] PRIMARY KEY CLUSTERED 
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[department]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[department](
	[guid] [uniqueidentifier] NOT NULL,
	[department_title] [nvarchar](200) NOT NULL,
	[institute_guid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Кафедры] PRIMARY KEY CLUSTERED 
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_GUID8] UNIQUE NONCLUSTERED 
(
	[guid] ASC,
	[department_title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[events]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[events](
	[guid] [uniqueidentifier] NOT NULL,
	[week_guid] [uniqueidentifier] NOT NULL,
	[day_guid] [uniqueidentifier] NOT NULL,
	[time_guid] [uniqueidentifier] NOT NULL,
	[group_guid] [uniqueidentifier] NOT NULL,
	[event_title] [nvarchar](100) NOT NULL,
	[teacher_guid] [uniqueidentifier] NOT NULL,
	[room_guid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Мероприятия] PRIMARY KEY CLUSTERED 
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[groups]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[groups](
	[guid] [uniqueidentifier] NOT NULL,
	[group_title] [nvarchar](15) NOT NULL,
	[institute_guid] [uniqueidentifier] NOT NULL,
	[size] [tinyint] NOT NULL,
 CONSTRAINT [PK_Список_групп_1] PRIMARY KEY CLUSTERED 
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_GUID5] UNIQUE NONCLUSTERED 
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[institutes]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[institutes](
	[guid] [uniqueidentifier] NOT NULL,
	[institute_title] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Институты] PRIMARY KEY CLUSTERED 
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_GUID2] UNIQUE NONCLUSTERED 
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lesson_type]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lesson_type](
	[guid] [uniqueidentifier] NOT NULL,
	[lesson_type] [nchar](3) NOT NULL,
 CONSTRAINT [PK_Типы_пар] PRIMARY KEY CLUSTERED 
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_GUID1] UNIQUE NONCLUSTERED 
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lessons]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lessons](
	[guid] [uniqueidentifier] NOT NULL,
	[group_guid] [uniqueidentifier] NOT NULL,
	[lesson_title] [nvarchar](100) NOT NULL,
	[teacher_guid] [uniqueidentifier] NOT NULL,
	[lesson_type_guid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Предметы] PRIMARY KEY CLUSTERED 
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_GUID6] UNIQUE NONCLUSTERED 
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rooms]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rooms](
	[guid] [uniqueidentifier] NOT NULL,
	[room_number] [nvarchar](11) NOT NULL,
	[room_size] [tinyint] NOT NULL,
 CONSTRAINT [PK_Кабинеты] PRIMARY KEY CLUSTERED 
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_GUID7] UNIQUE NONCLUSTERED 
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[schedule]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[schedule](
	[guid] [uniqueidentifier] NOT NULL,
	[week_guid] [uniqueidentifier] NOT NULL,
	[day_guid] [uniqueidentifier] NOT NULL,
	[time_guid] [uniqueidentifier] NOT NULL,
	[group_guid] [uniqueidentifier] NOT NULL,
	[lesson_guid] [uniqueidentifier] NOT NULL,
	[room_guid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Расписание] PRIMARY KEY CLUSTERED 
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[teachers]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[teachers](
	[guid] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](40) NOT NULL,
	[surname] [nvarchar](50) NOT NULL,
	[patronymic] [nvarchar](50) NOT NULL,
	[department_guid] [uniqueidentifier] NOT NULL,
	[supervised_group_guid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Преподаватели] PRIMARY KEY CLUSTERED 
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[times]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[times](
	[guid] [uniqueidentifier] NOT NULL,
	[time_start] [time](0) NOT NULL,
	[time_end] [time](0) NOT NULL,
	[lesson_number] [tinyint] NOT NULL,
 CONSTRAINT [PK_Время_пар] PRIMARY KEY CLUSTERED 
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_GUID] UNIQUE NONCLUSTERED 
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[guid] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](40) NOT NULL,
	[surname] [nvarchar](50) NOT NULL,
	[patronymic] [nvarchar](50) NULL,
	[group] [nvarchar](15) NULL,
	[login] [nvarchar](30) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_Login_Password] UNIQUE NONCLUSTERED 
(
	[login] ASC,
	[password] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[week_days]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[week_days](
	[guid] [uniqueidentifier] NOT NULL,
	[day_number] [tinyint] NOT NULL,
	[day_title] [nvarchar](11) NOT NULL,
 CONSTRAINT [PK_week_days] PRIMARY KEY CLUSTERED 
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[week_type]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[week_type](
	[guid] [uniqueidentifier] NOT NULL,
	[week_type] [nvarchar](50) NOT NULL,
	[current] [bit] NOT NULL,
 CONSTRAINT [PK_Тип_недели] PRIMARY KEY CLUSTERED 
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [AK_GUID4] UNIQUE NONCLUSTERED 
(
	[guid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_week_days]    Script Date: 14.09.2023 12:42:03 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_week_days] ON [dbo].[week_days]
(
	[day_title] ASC,
	[day_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[changes] ADD  CONSTRAINT [DF_changes_guid]  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[department] ADD  CONSTRAINT [DF_Кафедры_Guid]  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[events] ADD  CONSTRAINT [DF_Мероприятия_Guid]  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[groups] ADD  CONSTRAINT [DF_Список_групп_Guid]  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[institutes] ADD  CONSTRAINT [DF_Институты_Guid]  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[lesson_type] ADD  CONSTRAINT [DF_Типы_пар_Guid]  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[lessons] ADD  CONSTRAINT [DF_Предметы_Guid]  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[rooms] ADD  CONSTRAINT [DF_Кабинеты_Guid]  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[schedule] ADD  CONSTRAINT [DF_schedule_guid]  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[times] ADD  CONSTRAINT [DF_Время_пар_Guid]  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_Users_Guid]  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[week_days] ADD  CONSTRAINT [DF_Дни_недели_Guid]  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[week_type] ADD  CONSTRAINT [DF_Тип_недели_Guid]  DEFAULT (newid()) FOR [guid]
GO
ALTER TABLE [dbo].[changes]  WITH CHECK ADD  CONSTRAINT [FK_changes_lessons] FOREIGN KEY([lesson_guid])
REFERENCES [dbo].[lessons] ([guid])
GO
ALTER TABLE [dbo].[changes] CHECK CONSTRAINT [FK_changes_lessons]
GO
ALTER TABLE [dbo].[changes]  WITH CHECK ADD  CONSTRAINT [FK_changes_rooms] FOREIGN KEY([room_guid])
REFERENCES [dbo].[rooms] ([guid])
GO
ALTER TABLE [dbo].[changes] CHECK CONSTRAINT [FK_changes_rooms]
GO
ALTER TABLE [dbo].[changes]  WITH CHECK ADD  CONSTRAINT [FK_changes_times] FOREIGN KEY([time_guid])
REFERENCES [dbo].[times] ([guid])
GO
ALTER TABLE [dbo].[changes] CHECK CONSTRAINT [FK_changes_times]
GO
ALTER TABLE [dbo].[changes]  WITH CHECK ADD  CONSTRAINT [FK_changes_week_days] FOREIGN KEY([day_guid])
REFERENCES [dbo].[week_days] ([guid])
GO
ALTER TABLE [dbo].[changes] CHECK CONSTRAINT [FK_changes_week_days]
GO
ALTER TABLE [dbo].[changes]  WITH CHECK ADD  CONSTRAINT [FK_changes_week_type] FOREIGN KEY([week_guid])
REFERENCES [dbo].[week_type] ([guid])
GO
ALTER TABLE [dbo].[changes] CHECK CONSTRAINT [FK_changes_week_type]
GO
ALTER TABLE [dbo].[department]  WITH CHECK ADD  CONSTRAINT [FK_department_institutes] FOREIGN KEY([institute_guid])
REFERENCES [dbo].[institutes] ([guid])
GO
ALTER TABLE [dbo].[department] CHECK CONSTRAINT [FK_department_institutes]
GO
ALTER TABLE [dbo].[events]  WITH CHECK ADD  CONSTRAINT [FK_events_groups] FOREIGN KEY([group_guid])
REFERENCES [dbo].[groups] ([guid])
GO
ALTER TABLE [dbo].[events] CHECK CONSTRAINT [FK_events_groups]
GO
ALTER TABLE [dbo].[events]  WITH CHECK ADD  CONSTRAINT [FK_events_rooms] FOREIGN KEY([room_guid])
REFERENCES [dbo].[rooms] ([guid])
GO
ALTER TABLE [dbo].[events] CHECK CONSTRAINT [FK_events_rooms]
GO
ALTER TABLE [dbo].[events]  WITH CHECK ADD  CONSTRAINT [FK_events_teachers] FOREIGN KEY([teacher_guid])
REFERENCES [dbo].[teachers] ([guid])
GO
ALTER TABLE [dbo].[events] CHECK CONSTRAINT [FK_events_teachers]
GO
ALTER TABLE [dbo].[events]  WITH CHECK ADD  CONSTRAINT [FK_events_times] FOREIGN KEY([time_guid])
REFERENCES [dbo].[times] ([guid])
GO
ALTER TABLE [dbo].[events] CHECK CONSTRAINT [FK_events_times]
GO
ALTER TABLE [dbo].[events]  WITH CHECK ADD  CONSTRAINT [FK_events_week_days] FOREIGN KEY([day_guid])
REFERENCES [dbo].[week_days] ([guid])
GO
ALTER TABLE [dbo].[events] CHECK CONSTRAINT [FK_events_week_days]
GO
ALTER TABLE [dbo].[events]  WITH CHECK ADD  CONSTRAINT [FK_events_week_type] FOREIGN KEY([week_guid])
REFERENCES [dbo].[week_type] ([guid])
GO
ALTER TABLE [dbo].[events] CHECK CONSTRAINT [FK_events_week_type]
GO
ALTER TABLE [dbo].[groups]  WITH CHECK ADD  CONSTRAINT [FK_groups_institutes] FOREIGN KEY([institute_guid])
REFERENCES [dbo].[institutes] ([guid])
GO
ALTER TABLE [dbo].[groups] CHECK CONSTRAINT [FK_groups_institutes]
GO
ALTER TABLE [dbo].[lessons]  WITH CHECK ADD  CONSTRAINT [FK_lessons_groups] FOREIGN KEY([group_guid])
REFERENCES [dbo].[groups] ([guid])
GO
ALTER TABLE [dbo].[lessons] CHECK CONSTRAINT [FK_lessons_groups]
GO
ALTER TABLE [dbo].[lessons]  WITH CHECK ADD  CONSTRAINT [FK_lessons_lesson_type] FOREIGN KEY([lesson_type_guid])
REFERENCES [dbo].[lesson_type] ([guid])
GO
ALTER TABLE [dbo].[lessons] CHECK CONSTRAINT [FK_lessons_lesson_type]
GO
ALTER TABLE [dbo].[lessons]  WITH CHECK ADD  CONSTRAINT [FK_lessons_teachers] FOREIGN KEY([teacher_guid])
REFERENCES [dbo].[teachers] ([guid])
GO
ALTER TABLE [dbo].[lessons] CHECK CONSTRAINT [FK_lessons_teachers]
GO
ALTER TABLE [dbo].[schedule]  WITH CHECK ADD  CONSTRAINT [FK_schedule_lessons] FOREIGN KEY([lesson_guid])
REFERENCES [dbo].[lessons] ([guid])
GO
ALTER TABLE [dbo].[schedule] CHECK CONSTRAINT [FK_schedule_lessons]
GO
ALTER TABLE [dbo].[schedule]  WITH CHECK ADD  CONSTRAINT [FK_schedule_rooms] FOREIGN KEY([room_guid])
REFERENCES [dbo].[rooms] ([guid])
GO
ALTER TABLE [dbo].[schedule] CHECK CONSTRAINT [FK_schedule_rooms]
GO
ALTER TABLE [dbo].[schedule]  WITH CHECK ADD  CONSTRAINT [FK_schedule_times] FOREIGN KEY([time_guid])
REFERENCES [dbo].[times] ([guid])
GO
ALTER TABLE [dbo].[schedule] CHECK CONSTRAINT [FK_schedule_times]
GO
ALTER TABLE [dbo].[schedule]  WITH CHECK ADD  CONSTRAINT [FK_schedule_week_days] FOREIGN KEY([day_guid])
REFERENCES [dbo].[week_days] ([guid])
GO
ALTER TABLE [dbo].[schedule] CHECK CONSTRAINT [FK_schedule_week_days]
GO
ALTER TABLE [dbo].[schedule]  WITH CHECK ADD  CONSTRAINT [FK_schedule_week_type] FOREIGN KEY([week_guid])
REFERENCES [dbo].[week_type] ([guid])
GO
ALTER TABLE [dbo].[schedule] CHECK CONSTRAINT [FK_schedule_week_type]
GO
ALTER TABLE [dbo].[teachers]  WITH CHECK ADD  CONSTRAINT [FK_teachers_department] FOREIGN KEY([department_guid])
REFERENCES [dbo].[department] ([guid])
GO
ALTER TABLE [dbo].[teachers] CHECK CONSTRAINT [FK_teachers_department]
GO
ALTER TABLE [dbo].[teachers]  WITH CHECK ADD  CONSTRAINT [FK_teachers_groups] FOREIGN KEY([supervised_group_guid])
REFERENCES [dbo].[groups] ([guid])
GO
ALTER TABLE [dbo].[teachers] CHECK CONSTRAINT [FK_teachers_groups]
GO
/****** Object:  StoredProcedure [dbo].[GETchanges_teacher]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GETchanges_teacher]
(
   @FIO uniqueidentifier, @Day nvarchar(11)
)
AS
BEGIN

	SELECT [Day],[Number],[Time],[Group],[Lesson],[Type],[FIO],[Room] FROM 
(
	SELECT
		[week_type].[week_type] AS [Week],

		[week_days].[day_title] AS [Day],

		[times].[lesson_number] AS [Number],

		[dbo].ShortTime((Select dbo.times.time_start FROM times WHERE times.[guid]=dbo.[changes].[time_guid]),
		(Select dbo.times.time_end FROM times WHERE times.[guid]=dbo.[changes].[time_guid])) AS [Time],

		[groups].[group_title] AS [Group],

		[lessons].[lesson_title] AS [Lesson],

		lessons.teacher_guid AS [teacher_guid],

		[lesson_type].lesson_type AS [Type],

		[dbo].[ShortFIO]((Select dbo.teachers.surname FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid]),
		(Select dbo.teachers.[name] FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid]),
		(Select dbo.teachers.[patronymic] FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid])) AS FIO,

		[rooms].[room_number] AS [Room]
	FROM [dbo].[changes]

		LEFT JOIN [dbo].[times] ON [dbo].[times].[guid] = [dbo].[changes].[time_guid]
		LEFT JOIN [dbo].[lessons]  ON [dbo].[lessons].[guid] = [dbo].[changes].[lesson_guid]
		LEFT JOIN [dbo].[week_days] ON [dbo].[week_days].[guid] = [dbo].[changes].[day_guid]
		LEFT JOIN [dbo].[week_type] ON [dbo].[week_type].[guid] = [dbo].[changes].[week_guid]
		LEFT JOIN [dbo].[groups] ON [dbo].[groups].[guid] = [dbo].[changes].[group_guid]
		LEFT JOIN [dbo].[rooms] ON [dbo].[rooms].[guid] = [dbo].[changes].[room_guid]
		LEFT JOIN [dbo].[lesson_type] ON [dbo].[lesson_type].[guid] = [dbo].[lessons].[lesson_type_guid]
) as [CHANGES]


	WHERE @FIO=[CHANGES].teacher_guid and @Day=[CHANGES].[Day] and [CHANGES].[Week] like (SELECT week_type.week_type FROM week_type WHERE week_type.[current]= 'True')
	
	Order by [CHANGES].[Number]

	END
GO
/****** Object:  StoredProcedure [dbo].[GETchangesByGroup]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Выборка изменений на группу и день в текущую неделю
CREATE PROCEDURE [dbo].[GETchangesByGroup]
(
    @Group nvarchar(15), 
    @Day nvarchar(15)
)
AS
BEGIN
 
	SELECT [Day],[Number],[Time],[Group],[Lesson],[Type],[FIO],[Room] FROM (
	SELECT
		[week_type].[week_type] AS [Week],
		[week_days].[day_title] AS [Day],
		[times].[lesson_number] AS [Number],
		[dbo].ShortTime((Select dbo.times.time_start FROM times WHERE times.[guid]=dbo.[changes].[time_guid]),(Select dbo.times.time_end FROM times WHERE times.[guid]=dbo.[changes].[time_guid])) AS [Time],
		[groups].[group_title] AS [Group],
		[lessons].[lesson_title] AS [Lesson],
		[lesson_type].lesson_type AS [Type],
		[dbo].[ShortFIO]((Select dbo.teachers.surname FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid]),(Select dbo.teachers.[name] FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid]),(Select dbo.teachers.[patronymic] FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid])) AS FIO,
		[rooms].[room_number] AS [Room]
	FROM [dbo].[changes]

		LEFT JOIN [dbo].[times] ON [dbo].[times].[guid] = [dbo].[changes].[time_guid]
		LEFT JOIN [dbo].[lessons]  ON [dbo].[lessons].[guid] = [dbo].[changes].[lesson_guid]
		LEFT JOIN [dbo].[week_days] ON [dbo].[week_days].[guid] = [dbo].[changes].[day_guid]
		LEFT JOIN [dbo].[week_type] ON [dbo].[week_type].[guid] = [dbo].[changes].[week_guid]
		LEFT JOIN [dbo].[groups] ON [dbo].[groups].[guid] = [dbo].[changes].[group_guid]
		LEFT JOIN [dbo].[rooms] ON [dbo].[rooms].[guid] = [dbo].[changes].[room_guid]
		LEFT JOIN [dbo].[lesson_type] ON [dbo].[lesson_type].[guid] = [dbo].[lessons].[lesson_type_guid]
		) as [CHANGE]

	WHERE @Group=[Group] and @Day=[Day] and [Week] like  (SELECT week_type.week_type FROM week_type WHERE week_type.[current]= 'True')
	
	Order by [Number]


/*
	SELECT 
		Изменения.[Week], 
		Изменения.[Day],
		Время_пар.Номер_пары as [Number],
		Время_пар.Время_ID AS Time, 
		Изменения.[Group],
		Предметы.Lesson,
		Предметы.Тип_пары AS [Type],
		dbo.ShortFIO(Преподаватели.Surname,Преподаватели.[Name], Преподаватели.Patronymic) AS FIO,
		Изменения.[Кабинет] AS [Room]
	FROM Изменения 
			LEFT JOIN Время_пар ON Время_пар.Время_ID = Изменения.[Time]
			LEFT JOIN Предметы ON Предметы.[Guid] = Изменения.Lesson_GUID
			LEFT JOIN Преподаватели ON Преподаватели.[Guid]=Предметы.Teacher_GUID
	WHERE @Group=Изменения.[Group] and @Day=Изменения.[Day] 
	and Изменения.[Week] like (SELECT Тип_недели.Тип_недели FROM Тип_недели WHERE Тип_недели.[Current]= 'True')
	ORDER BY Время_пар.Номер_пары
*/	
END
GO
/****** Object:  StoredProcedure [dbo].[GetCurrentWeekType]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCurrentWeekType] 

AS
BEGIN

Select [week_type].[week_type] AS [Week] from [week_type] where [week_type].[current] =1
END
GO
/****** Object:  StoredProcedure [dbo].[GETeventsByGroup]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GETeventsByGroup]

  @Group nvarchar(15), 
  @Day nvarchar(11)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [Day],[Number],[Time],[Group],[Lesson],[Type],[FIO],[Room] FROM ( SELECT
			[week_type].[week_type] AS [Week],
			[week_days].[day_title] AS [Day],
			[times].[lesson_number] AS [Number],
			[dbo].ShortTime((Select dbo.times.time_start FROM times WHERE times.[guid]=dbo.[events].[time_guid]),
			(Select dbo.times.time_end FROM times WHERE times.[guid]=dbo.[events].[time_guid])) AS [Time],
			[groups].[group_title] AS [Group],
			[events].[event_title] AS [Lesson],
			[dbo].[ShortFIO]((Select dbo.teachers.surname FROM teachers WHERE teachers.guid=dbo.[events].[teacher_guid]),
			(Select dbo.teachers.[name] FROM teachers WHERE teachers.guid=dbo.[events].[teacher_guid]),
			(Select dbo.teachers.[patronymic] FROM teachers WHERE teachers.guid=dbo.[events].[teacher_guid])) AS FIO,
			[rooms].[room_number] AS [Room],
			NULL AS [Type]
		FROM
			[dbo].[events]

			LEFT JOIN [dbo].[times] ON [dbo].[times].[guid] = [dbo].[events].[time_guid]
			LEFT JOIN [dbo].[week_days] ON [dbo].[week_days].[guid] = [dbo].[events].[day_guid]
			LEFT JOIN [dbo].[week_type] ON [dbo].[week_type].[guid] = [dbo].[events].[week_guid]
			LEFT JOIN [dbo].[groups] ON [dbo].[groups].[guid] = [dbo].[events].[group_guid]
			LEFT JOIN [dbo].[rooms] ON [dbo].[rooms].[guid] = [dbo].[events].[room_guid]
			LEFT JOIN [dbo].[teachers] ON [dbo].[teachers].[guid] = [dbo].[events].teacher_guid
			) as [result]
			WHERE @Group =[result].[Group] and @Day=[result].[Day] and [result].[Week] like  (SELECT week_type.week_type FROM week_type WHERE week_type.[current]= 'True') 
END
GO
/****** Object:  StoredProcedure [dbo].[GetGroups]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetGroups]

AS
	BEGIN
		Select [group_title] AS 'Group' from [dbo].[groups] Order by [Group]

	END
GO
/****** Object:  StoredProcedure [dbo].[GETraspisanie_changes_events]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:      <Pavel, , Belousov>
-- Create Date: <11/11/2021, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[GETraspisanie_changes_events]
(
  @Group nvarchar(15), 
  @Day nvarchar(11)
)
--Расп+изменения
AS
BEGIN

DECLARE	@RASP TABLE
	(
		[Day] nvarchar(11),
		[Number] tinyint,
		[Time] nvarchar(11),
		[Group] nvarchar(15),
		[Lesson] nvarchar(100),
		[Type] nchar(3) NULL,
		[FIO] nvarchar(60),
		[Room] nvarchar(11) NULL
	)
DECLARE	@CHANG TABLE
	(
		[Day] nvarchar(11),
		[Number] tinyint,
		[Time] nvarchar(11),
		[Group] nvarchar(15),
		[Lesson] nvarchar(100),
		[Type] nchar(3) NULL,
		[FIO] nvarchar(60),
		[Room] nvarchar(11) NULL
	)
DECLARE	@EVENT TABLE
	(
		[Day] nvarchar(11),
		[Number] tinyint,
		[Time] nvarchar(11),
		[Group] nvarchar(15),
		[Lesson] nvarchar(100),
		[Type] nchar(3) NULL,
		[FIO] nvarchar(60),
		[Room] nvarchar(11) NULL
	)
DECLARE	@Times TABLE
	(
		[Time] nvarchar(11)
	)

	Insert into @RASP
	Exec [dbo].[GETraspisanieByGroup] @Group, @Day
	Insert into @CHANG
	Exec [dbo].[GETchangesByGroup] @Group, @Day
	Insert into @EVENT
	Exec [dbo].[GETeventsByGroup] @Group, @Day
	Insert into @Times
	Select [Time] from @CHANG
	Insert into @Times
	Select [Time] from @EVENT

	DELETE FROM @RASP where [Time] IN (SELECT * FROM @Times)

	SELECT * FROM @RASP
	UNION
	SELECT * FROM @CHANG
	UNION
	SELECT * FROM @EVENT
/*

SELECT [Day],[Number],[Time],[Group],[Lesson],[Type],[FIO],[Room] FROM(
SELECT [Day],[Number],[Time],[Group],[Lesson],[Type],[FIO],[Room] FROM
	(SELECT * FROM (
	SELECT
		[week_type].[week_type] AS [Week],
		[week_days].[day_title] AS [Day],
		[times].[lesson_number] AS [Number],
		[dbo].ShortTime((Select dbo.times.time_start FROM times WHERE times.[guid]=dbo.[schedule].[time_guid]),(Select dbo.times.time_end FROM times WHERE times.[guid]=dbo.[schedule].[time_guid])) AS [Time],
		[groups].[group_title] AS [Group],
		[lessons].[lesson_title] AS [Lesson],
		[lesson_type].lesson_type AS [Type],
		[dbo].[ShortFIO]((Select dbo.teachers.surname FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid]),(Select dbo.teachers.[name] FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid]),(Select dbo.teachers.[patronymic] FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid])) AS FIO,
		[rooms].[room_number] AS [Room]
	FROM [dbo].[schedule]

		LEFT JOIN [dbo].[times] ON [dbo].[times].[guid] = [dbo].[schedule].[time_guid]
		LEFT JOIN [dbo].[lessons]  ON [dbo].[lessons].[guid] = [dbo].[schedule].[lesson_guid]
		LEFT JOIN [dbo].[week_days] ON [dbo].[week_days].[guid] = [dbo].[schedule].[day_guid]
		LEFT JOIN [dbo].[week_type] ON [dbo].[week_type].[guid] = [dbo].[schedule].[week_guid]
		LEFT JOIN [dbo].[groups] ON [dbo].[groups].[guid] = [dbo].[schedule].[group_guid]
		LEFT JOIN [dbo].[rooms] ON [dbo].[rooms].[guid] = [dbo].[schedule].[room_guid]
		LEFT JOIN [dbo].[lesson_type] ON [dbo].[lesson_type].[guid] = [dbo].[lessons].[lesson_type_guid]
		) as [SCHEDULE]

	WHERE @Group=[SCHEDULE].[Group] and @Day=[SCHEDULE].[Day] and [SCHEDULE].[Week] like (SELECT week_type.week_type FROM week_type WHERE week_type.[current]= 'True')
	
	) as SCHEDULE
	WHERE [SCHEDULE].[Time]
	NOT IN
(		Select [dbo].ShortTime((Select dbo.times.time_start FROM times WHERE times.[guid]=dbo.[changes].[time_guid]),(Select dbo.times.time_end FROM times WHERE times.[guid]=dbo.[changes].[time_guid])) AS [Time]
		FROM [changes]

		
		LEFT JOIN [dbo].[week_type] ON [dbo].[week_type].[guid] =[changes].[week_guid]
		LEFT JOIN [dbo].[groups] ON [dbo].[groups].[guid] = [changes].[group_guid]

		WHERE @Group=SCHEDULE.[Group] and @Day=[SCHEDULE].[Day] and [SCHEDULE].[Week] like (SELECT week_type.week_type WHERE week_type.[current]= 'True')) and
	
	@Group=SCHEDULE.[Group] and 
	@Day=SCHEDULE.[Day] and
	SCHEDULE.[Week] like (SELECT week_type.week_type FROM week_type WHERE week_type.[current]= 'True')

	UNION 
	SELECT [Day],[Number],[Time],[Group],[Lesson],[Type],[FIO],[Room] FROM (
	SELECT
		[week_type].[week_type] AS [Week],
		[week_days].[day_title] AS [Day],
		[times].[lesson_number] AS [Number],
		[dbo].ShortTime((Select dbo.times.time_start FROM times WHERE times.[guid]=dbo.[changes].[time_guid]),(Select dbo.times.time_end FROM times WHERE times.[guid]=dbo.[changes].[time_guid])) AS [Time],
		[groups].[group_title] AS [Group],
		[lessons].[lesson_title] AS [Lesson],
		[lesson_type].lesson_type AS [Type],
		[dbo].[ShortFIO]((Select dbo.teachers.surname FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid]),(Select dbo.teachers.[name] FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid]),(Select dbo.teachers.[patronymic] FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid])) AS FIO,
		[rooms].[room_number] AS [Room]
	FROM [dbo].[changes]

		LEFT JOIN [dbo].[times] ON [dbo].[times].[guid] = [dbo].[changes].[time_guid]
		LEFT JOIN [dbo].[lessons]  ON [dbo].[lessons].[guid] = [dbo].[changes].[lesson_guid]
		LEFT JOIN [dbo].[week_days] ON [dbo].[week_days].[guid] = [dbo].[changes].[day_guid]
		LEFT JOIN [dbo].[week_type] ON [dbo].[week_type].[guid] = [dbo].[changes].[week_guid]
		LEFT JOIN [dbo].[groups] ON [dbo].[groups].[guid] = [dbo].[changes].[group_guid]
		LEFT JOIN [dbo].[rooms] ON [dbo].[rooms].[guid] = [dbo].[changes].[room_guid]
		LEFT JOIN [dbo].[lesson_type] ON [dbo].[lesson_type].[guid] = [dbo].[lessons].[lesson_type_guid]
		) as [CHANGE]

	WHERE @Group=[Group] and @Day=[Day] and [Week] like  (SELECT week_type.week_type FROM week_type WHERE week_type.[current]= 'True')
	
	) as [scheadule]

	WHERE [scheadule].[Time] NOT IN (SELECT [Time] FROM (
		SELECT 
			[week_type].[week_type] AS [Week],
			[week_days].[day_title] AS [Day],
			[times].[lesson_number] AS [Number],
			[dbo].ShortTime((Select dbo.times.time_start FROM times WHERE times.[guid]=dbo.[events].[time_guid]),
			(Select dbo.times.time_end FROM times WHERE times.[guid]=dbo.[events].[time_guid])) AS [Time],
			[groups].[group_title] AS [Group],
			[events].[event_title] AS [Lesson],
			[dbo].[ShortFIO]((Select dbo.teachers.surname FROM teachers WHERE teachers.guid=dbo.[events].[teacher_guid]),
			(Select dbo.teachers.[name] FROM teachers WHERE teachers.guid=dbo.[events].[teacher_guid]),
			(Select dbo.teachers.[patronymic] FROM teachers WHERE teachers.guid=dbo.[events].[teacher_guid])) AS FIO,
			[rooms].[room_number] AS [Room],
			COALESCE ('NULL','NULL') AS [Type]
		FROM
			[dbo].[events]

			LEFT JOIN [dbo].[times] ON [dbo].[times].[guid] = [dbo].[events].[time_guid]
			LEFT JOIN [dbo].[week_days] ON [dbo].[week_days].[guid] = [dbo].[events].[day_guid]
			LEFT JOIN [dbo].[week_type] ON [dbo].[week_type].[guid] = [dbo].[events].[week_guid]
			LEFT JOIN [dbo].[groups] ON [dbo].[groups].[guid] = [dbo].[events].[group_guid]
			LEFT JOIN [dbo].[rooms] ON [dbo].[rooms].[guid] = [dbo].[events].[room_guid]
			LEFT JOIN [dbo].[teachers] ON [dbo].[teachers].[guid] = [dbo].[events].teacher_guid
			) as [shedule]
		WHERE @Group=[shedule].[Group] and @Day=[shedule].[Day] and [shedule].[Week] like  (SELECT week_type.week_type FROM week_type WHERE week_type.[current]= 'True'))
		UNION
		(SELECT [Day],[Number],[Time],[Group],[Lesson],[Type],[FIO],[Room] FROM ( SELECT
			[week_type].[week_type] AS [Week],
			[week_days].[day_title] AS [Day],
			[times].[lesson_number] AS [Number],
			[dbo].ShortTime((Select dbo.times.time_start FROM times WHERE times.[guid]=dbo.[events].[time_guid]),
			(Select dbo.times.time_end FROM times WHERE times.[guid]=dbo.[events].[time_guid])) AS [Time],
			[groups].[group_title] AS [Group],
			[events].[event_title] AS [Lesson],
			[dbo].[ShortFIO]((Select dbo.teachers.surname FROM teachers WHERE teachers.guid=dbo.[events].[teacher_guid]),
			(Select dbo.teachers.[name] FROM teachers WHERE teachers.guid=dbo.[events].[teacher_guid]),
			(Select dbo.teachers.[patronymic] FROM teachers WHERE teachers.guid=dbo.[events].[teacher_guid])) AS FIO,
			[rooms].[room_number] AS [Room],
			NULL AS [Type]
		FROM
			[dbo].[events]

			LEFT JOIN [dbo].[times] ON [dbo].[times].[guid] = [dbo].[events].[time_guid]
			LEFT JOIN [dbo].[week_days] ON [dbo].[week_days].[guid] = [dbo].[events].[day_guid]
			LEFT JOIN [dbo].[week_type] ON [dbo].[week_type].[guid] = [dbo].[events].[week_guid]
			LEFT JOIN [dbo].[groups] ON [dbo].[groups].[guid] = [dbo].[events].[group_guid]
			LEFT JOIN [dbo].[rooms] ON [dbo].[rooms].[guid] = [dbo].[events].[room_guid]
			LEFT JOIN [dbo].[teachers] ON [dbo].[teachers].[guid] = [dbo].[events].teacher_guid
			) as [result]

		WHERE @Group=[Group] and @Day=[Day] and [Week] like  (SELECT week_type.week_type FROM week_type WHERE week_type.[current]= 'True'))

*/
END
GO
/****** Object:  StoredProcedure [dbo].[GETraspisanie_changes_events_teachers]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GETraspisanie_changes_events_teachers]
(
 @FIO uniqueidentifier,
 @Day nvarchar(15)
)
AS
	
BEGIN
/*
SELECT [Day],[Number],[Time],[Lesson],[Type],[FIO],[Room] FROM (
	SELECT
		[week_type].[week_type] AS [Week],
		[week_days].[day_title] AS [Day],
		[times].[lesson_number] AS [Number],
		[dbo].ShortTime((Select dbo.times.time_start FROM times WHERE times.[guid]=dbo.[schedule].[time_guid]),(Select dbo.times.time_end FROM times WHERE times.[guid]=dbo.[schedule].[time_guid])) AS [Time],
		[lessons].[lesson_title] AS [Lesson],
		[lesson_type].lesson_type AS [Type],
		[dbo].[ShortFIO]((Select dbo.teachers.surname FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid]),(Select dbo.teachers.[name] FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid]),(Select dbo.teachers.[patronymic] FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid])) AS FIO,
		[rooms].[room_number] AS [Room]
	FROM [dbo].[schedule]
	
		LEFT JOIN [dbo].[week_type] ON [dbo].[week_type].[guid] = [dbo].[schedule].[week_guid]
		LEFT JOIN [dbo].[week_days] ON [dbo].[week_days].[guid] = [dbo].[schedule].[day_guid]
		LEFT JOIN [dbo].[times] ON [dbo].[times].[guid] = [dbo].[schedule].[time_guid]
		LEFT JOIN [dbo].[lessons]  ON [dbo].[lessons].[guid] = [dbo].[schedule].[lesson_guid]		
		LEFT JOIN [dbo].[lesson_type] ON [dbo].[lesson_type].[guid] = [dbo].[lessons].[lesson_type_guid]
		LEFT JOIN [dbo].[rooms] ON [dbo].[rooms].[guid] = [dbo].[schedule].[room_guid]
		LEFT JOIN [dbo].[teachers] ON [dbo].[teachers].[guid] = [dbo].[lessons].[guid]
		
		WHERE @FIO=lessons.teacher_guid) as [SCHEADULE] 
		
		Where @Day=[Day] and [Week] like (SELECT week_type.week_type FROM week_type WHERE week_type.[current]= 'True')
		
		*/
		
SELECT [Day],[Number],[Time],[Group],[Lesson],[Type],[FIO],[Room] FROM(
SELECT [Day],[Number],[Time],[Group],[Lesson],[Type],[FIO],[Room] FROM
	(SELECT * FROM (
	SELECT
		[week_type].[week_type] AS [Week],
		[week_days].[day_title] AS [Day],
		[times].[lesson_number] AS [Number],
		[dbo].ShortTime((Select dbo.times.time_start FROM times WHERE times.[guid]=dbo.[schedule].[time_guid]),(Select dbo.times.time_end FROM times WHERE times.[guid]=dbo.[schedule].[time_guid])) AS [Time],
		[groups].[group_title] AS [Group],
		[lessons].[lesson_title] AS [Lesson],
		[lesson_type].lesson_type AS [Type],
		[dbo].[ShortFIO]((Select dbo.teachers.surname FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid]),(Select dbo.teachers.[name] FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid]),(Select dbo.teachers.[patronymic] FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid])) AS FIO,
		[rooms].[room_number] AS [Room]
	FROM [dbo].[schedule]

		LEFT JOIN [dbo].[times] ON [dbo].[times].[guid] = [dbo].[schedule].[time_guid]
		LEFT JOIN [dbo].[lessons]  ON [dbo].[lessons].[guid] = [dbo].[schedule].[lesson_guid]
		LEFT JOIN [dbo].[week_days] ON [dbo].[week_days].[guid] = [dbo].[schedule].[day_guid]
		LEFT JOIN [dbo].[week_type] ON [dbo].[week_type].[guid] = [dbo].[schedule].[week_guid]
		LEFT JOIN [dbo].[groups] ON [dbo].[groups].[guid] = [dbo].[schedule].[group_guid]
		LEFT JOIN [dbo].[rooms] ON [dbo].[rooms].[guid] = [dbo].[schedule].[room_guid]
		LEFT JOIN [dbo].[lesson_type] ON [dbo].[lesson_type].[guid] = [dbo].[lessons].[lesson_type_guid]
		
	WHERE @FIO=lessons.teacher_guid
		) as [SCHEDULE]
	WHERE @Day=[SCHEDULE].[Day] and [SCHEDULE].[Week] like (SELECT week_type.week_type FROM week_type WHERE week_type.[current]= 'True')
	
	) as SCHEDULE
	WHERE [SCHEDULE].[Time]
	NOT IN
(		Select [dbo].ShortTime((Select dbo.times.time_start FROM times WHERE times.[guid]=dbo.[changes].[time_guid]),(Select dbo.times.time_end FROM times WHERE times.[guid]=dbo.[changes].[time_guid])) AS [Time]
		FROM [changes]

		
		LEFT JOIN [dbo].[week_type] ON [dbo].[week_type].[guid] =[changes].[week_guid]
		LEFT JOIN [dbo].[lessons] ON [dbo].[lessons].[guid]=[changes].lesson_guid

		WHERE @FIO=lessons.teacher_guid and @Day=[SCHEDULE].[Day] and [SCHEDULE].[Week] like (SELECT week_type.week_type WHERE week_type.[current]= 'True')) and
	
	 
	@Day=SCHEDULE.[Day] and
	SCHEDULE.[Week] like (SELECT week_type.week_type FROM week_type WHERE week_type.[current]= 'True')



	UNION --Объединение с изменениями



	SELECT [Day],[Number],[Time],[Group],[Lesson],[Type],[FIO],[Room] FROM (
	SELECT
		[week_type].[week_type] AS [Week],
		[week_days].[day_title] AS [Day],
		[times].[lesson_number] AS [Number],
		[dbo].ShortTime((Select dbo.times.time_start FROM times WHERE times.[guid]=dbo.[changes].[time_guid]),(Select dbo.times.time_end FROM times WHERE times.[guid]=dbo.[changes].[time_guid])) AS [Time],
		[groups].[group_title] AS [Group],
		[lessons].[lesson_title] AS [Lesson],
		[lesson_type].lesson_type AS [Type],
		[dbo].[ShortFIO]((Select dbo.teachers.surname FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid]),(Select dbo.teachers.[name] FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid]),(Select dbo.teachers.[patronymic] FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid])) AS FIO,
		[rooms].[room_number] AS [Room]
	FROM [dbo].[changes]

		LEFT JOIN [dbo].[times] ON [dbo].[times].[guid] = [dbo].[changes].[time_guid]
		LEFT JOIN [dbo].[lessons]  ON [dbo].[lessons].[guid] = [dbo].[changes].[lesson_guid]
		LEFT JOIN [dbo].[week_days] ON [dbo].[week_days].[guid] = [dbo].[changes].[day_guid]
		LEFT JOIN [dbo].[week_type] ON [dbo].[week_type].[guid] = [dbo].[changes].[week_guid]
		LEFT JOIN [dbo].[groups] ON [dbo].[groups].[guid] = [dbo].[changes].[group_guid]
		LEFT JOIN [dbo].[rooms] ON [dbo].[rooms].[guid] = [dbo].[changes].[room_guid]
		LEFT JOIN [dbo].[lesson_type] ON [dbo].[lesson_type].[guid] = [dbo].[lessons].[lesson_type_guid]

		WHERE @FIO=dbo.lessons.teacher_guid
		) as [CHANGE]

	WHERE @Day=[Day] and [Week] like  (SELECT week_type.week_type FROM week_type WHERE week_type.[current]= 'True')
	
	) as [scheadule]

	WHERE [scheadule].[Time] NOT IN (SELECT [Time] FROM (
		SELECT 
			[week_type].[week_type] AS [Week],
			[week_days].[day_title] AS [Day],
			[times].[lesson_number] AS [Number],
			[dbo].ShortTime((Select dbo.times.time_start FROM times WHERE times.[guid]=dbo.[events].[time_guid]),
			(Select dbo.times.time_end FROM times WHERE times.[guid]=dbo.[events].[time_guid])) AS [Time],
			[groups].[group_title] AS [Group],
			[events].[event_title] AS [Lesson],
			[dbo].[ShortFIO]((Select dbo.teachers.surname FROM teachers WHERE teachers.guid=dbo.[events].[teacher_guid]),
			(Select dbo.teachers.[name] FROM teachers WHERE teachers.guid=dbo.[events].[teacher_guid]),
			(Select dbo.teachers.[patronymic] FROM teachers WHERE teachers.guid=dbo.[events].[teacher_guid])) AS FIO,
			[rooms].[room_number] AS [Room],
			COALESCE ('NULL','NULL') AS [Type]
		FROM
			[dbo].[events]

			LEFT JOIN [dbo].[times] ON [dbo].[times].[guid] = [dbo].[events].[time_guid]
			LEFT JOIN [dbo].[week_days] ON [dbo].[week_days].[guid] = [dbo].[events].[day_guid]
			LEFT JOIN [dbo].[week_type] ON [dbo].[week_type].[guid] = [dbo].[events].[week_guid]
			LEFT JOIN [dbo].[groups] ON [dbo].[groups].[guid] = [dbo].[events].[group_guid]
			LEFT JOIN [dbo].[rooms] ON [dbo].[rooms].[guid] = [dbo].[events].[room_guid]
			LEFT JOIN [dbo].[teachers] ON [dbo].[teachers].[guid] = [dbo].[events].teacher_guid
			LEFT JOIN [dbo].[lessons] ON [dbo].lessons.teacher_guid=@FIO
			
		WHERE @FIO=dbo.lessons.teacher_guid
			) as [shedule]
		WHERE @Day=[shedule].[Day] and [shedule].[Week] like  (SELECT week_type.week_type FROM week_type WHERE week_type.[current]= 'True'))
		
		
		
		
		UNION --Объединение с мероприятиями





		(SELECT [Day],[Number],[Time],[Group],[Lesson],[Type],[FIO],[Room] FROM ( SELECT
			[week_type].[week_type] AS [Week],
			[week_days].[day_title] AS [Day],
			[times].[lesson_number] AS [Number],
			[dbo].ShortTime((Select dbo.times.time_start FROM times WHERE times.[guid]=dbo.[events].[time_guid]),
			(Select dbo.times.time_end FROM times WHERE times.[guid]=dbo.[events].[time_guid])) AS [Time],
			[groups].[group_title] AS [Group],
			[events].[event_title] AS [Lesson],
			[dbo].[ShortFIO]((Select dbo.teachers.surname FROM teachers WHERE teachers.guid=dbo.[events].[teacher_guid]),
			(Select dbo.teachers.[name] FROM teachers WHERE teachers.guid=dbo.[events].[teacher_guid]),
			(Select dbo.teachers.[patronymic] FROM teachers WHERE teachers.guid=dbo.[events].[teacher_guid])) AS FIO,
			[rooms].[room_number] AS [Room],
			NULL AS [Type]
		FROM
			[dbo].[events]

			LEFT JOIN [dbo].[times] ON [dbo].[times].[guid] = [dbo].[events].[time_guid]
			LEFT JOIN [dbo].[week_days] ON [dbo].[week_days].[guid] = [dbo].[events].[day_guid]
			LEFT JOIN [dbo].[week_type] ON [dbo].[week_type].[guid] = [dbo].[events].[week_guid]
			LEFT JOIN [dbo].[groups] ON [dbo].[groups].[guid] = [dbo].[events].[group_guid]
			LEFT JOIN [dbo].[rooms] ON [dbo].[rooms].[guid] = [dbo].[events].[room_guid]
			LEFT JOIN [dbo].[teachers] ON [dbo].[teachers].[guid] = [dbo].[events].teacher_guid
			LEFT JOIN [dbo].[lessons] ON [dbo].lessons.teacher_guid = @FIO
			
		WHERE @FIO=dbo.lessons.teacher_guid
			) as [result]

		WHERE @Day=[Day] and [Week] like  (SELECT week_type.week_type FROM week_type WHERE week_type.[current]= 'True'))

END
GO
/****** Object:  StoredProcedure [dbo].[GETraspisanie_teacher]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Выборка расписания на группу и день в текущую неделю--
CREATE PROCEDURE [dbo].[GETraspisanie_teacher]
(
   @FIO uniqueidentifier, @Day nvarchar(15)
)
AS
BEGIN

	SELECT [Day],[Number],[Time],[Group],[Lesson],[Type],[FIO],[Room] FROM 
(
	SELECT
		[week_type].[week_type] AS [Week],
		[week_days].[day_title] AS [Day],
		[times].[lesson_number] AS [Number],
		[dbo].ShortTime((Select dbo.times.time_start FROM times WHERE times.[guid]=dbo.[schedule].[time_guid]),(Select dbo.times.time_end FROM times WHERE times.[guid]=dbo.[schedule].[time_guid])) AS [Time],
		[groups].[group_title] AS [Group],
		[lessons].[lesson_title] AS [Lesson],
		lessons.teacher_guid AS [teacher_guid],
		[lesson_type].lesson_type AS [Type],
		[dbo].[ShortFIO]((Select dbo.teachers.surname FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid]),(Select dbo.teachers.[name] FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid]),(Select dbo.teachers.[patronymic] FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid])) AS FIO,
		[rooms].[room_number] AS [Room]
	FROM [dbo].[schedule]

		LEFT JOIN [dbo].[times] ON [dbo].[times].[guid] = [dbo].[schedule].[time_guid]
		LEFT JOIN [dbo].[lessons]  ON [dbo].[lessons].[guid] = [dbo].[schedule].[lesson_guid]
		LEFT JOIN [dbo].[week_days] ON [dbo].[week_days].[guid] = [dbo].[schedule].[day_guid]
		LEFT JOIN [dbo].[week_type] ON [dbo].[week_type].[guid] = [dbo].[schedule].[week_guid]
		LEFT JOIN [dbo].[groups] ON [dbo].[groups].[guid] = [dbo].[schedule].[group_guid]
		LEFT JOIN [dbo].[rooms] ON [dbo].[rooms].[guid] = [dbo].[schedule].[room_guid]
		LEFT JOIN [dbo].[lesson_type] ON [dbo].[lesson_type].[guid] = [dbo].[lessons].[lesson_type_guid]
) as [SCHEDULE]


	WHERE @FIO=SCHEDULE.teacher_guid and @Day=[SCHEDULE].[Day] and [SCHEDULE].[Week] like (SELECT week_type.week_type FROM week_type WHERE week_type.[current]= 'True')
	
	Order by [SCHEDULE].[Number]

	END
GO
/****** Object:  StoredProcedure [dbo].[GETraspisanieByGroup]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Выборка расписания на группу и день в текущую неделю--
CREATE PROCEDURE [dbo].[GETraspisanieByGroup]
(
   @Group nvarchar(15), @Day nvarchar(15)
)
AS
BEGIN

--Новый метод --

	SELECT [Day],[Number],[Time],[Group],[Lesson],[Type],[FIO],[Room] FROM (
	SELECT
		[week_type].[week_type] AS [Week],
		[week_days].[day_title] AS [Day],
		[times].[lesson_number] AS [Number],
		[dbo].ShortTime((Select dbo.times.time_start FROM times WHERE times.[guid]=dbo.[schedule].[time_guid]),(Select dbo.times.time_end FROM times WHERE times.[guid]=dbo.[schedule].[time_guid])) AS [Time],
		[groups].[group_title] AS [Group],
		[lessons].[lesson_title] AS [Lesson],
		[lesson_type].lesson_type AS [Type],
		[dbo].[ShortFIO]((Select dbo.teachers.surname FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid]),(Select dbo.teachers.[name] FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid]),(Select dbo.teachers.[patronymic] FROM teachers WHERE teachers.guid=dbo.[lessons].[teacher_guid])) AS FIO,
		[rooms].[room_number] AS [Room]
	FROM [dbo].[schedule]

		LEFT JOIN [dbo].[times] ON [dbo].[times].[guid] = [dbo].[schedule].[time_guid]
		LEFT JOIN [dbo].[lessons]  ON [dbo].[lessons].[guid] = [dbo].[schedule].[lesson_guid]
		LEFT JOIN [dbo].[week_days] ON [dbo].[week_days].[guid] = [dbo].[schedule].[day_guid]
		LEFT JOIN [dbo].[week_type] ON [dbo].[week_type].[guid] = [dbo].[schedule].[week_guid]
		LEFT JOIN [dbo].[groups] ON [dbo].[groups].[guid] = [dbo].[schedule].[group_guid]
		LEFT JOIN [dbo].[rooms] ON [dbo].[rooms].[guid] = [dbo].[schedule].[room_guid]
		LEFT JOIN [dbo].[lesson_type] ON [dbo].[lesson_type].[guid] = [dbo].[lessons].[lesson_type_guid]
		) as [SCHEDULE]

	WHERE @Group=[SCHEDULE].[Group] and @Day=[SCHEDULE].[Day] and [SCHEDULE].[Week] like (SELECT week_type.week_type FROM week_type WHERE week_type.[current]= 'True')
	
	Order by [SCHEDULE].[Number]




--Старый метод--
/*	SELECT 

		Расписание.[Week], Расписание.[Day],Время_пар.Номер_пары as [Number] ,Время_пар.Время_ID AS [Time], Расписание.[Group] ,
		Предметы.Lesson, Предметы.Тип_пары AS [Type],
		dbo.[ShortFIO](Преподаватели.Surname,Преподаватели.[Name], Преподаватели.Patronymic) AS FIO,
		Расписание.[Кабинет] AS [Room]

	FROM Расписание 

			LEFT JOIN Время_пар ON Время_пар.Время_ID = Расписание.[Time]
			LEFT JOIN Предметы ON Предметы.[Guid] = Расписание.Lesson_GUID
			LEFT JOIN Преподаватели ON Преподаватели.[Guid]=Предметы.Teacher_GUID

	WHERE @Group=Расписание.[Group] and @Day=Расписание.[Day] 
	and Расписание.[Week] like (SELECT Тип_недели.Тип_недели FROM Тип_недели WHERE Тип_недели.[Current]= 'True')
	ORDER BY Время_пар.Номер_пары
*/

--метод Предтечей

/*	SELECT
		Расписание.[Week],Расписание.Day,Расписание.Time,
		(SELECT Номер_пары FROM Время_пар WHERE Расписание.Time = Время_пар.Время_ID) AS Номер,
		Расписание.[Group],	Предметы.Lesson,
		(Select	CONCAT(	Преподаватели.Surname,'.',
						LEFT(Преподаватели.Name,1),'.',
						LEFT(Преподаватели.Patronymic,1),'.'
						) AS FIO
						FROM Преподаватели
						WHERE Преподаватели.Guid = Предметы.Teacher_GUID
		)	AS Преподаватель,
		/*По факту - ShortFIO функция*/
		Расписание.Кабинет,	Предметы.Тип_пары

FROM Расписание

JOIN Предметы ON Расписание.Lesson_GUID=Предметы.Guid
JOIN Время_пар ON Расписание.Time = Время_пар.Время_ID
WHERE Расписание.Week = @Week and Расписание.Day = @Day and Расписание.[Group]=@Group

Order by (
	CASE Время_ID
	WHEN '1' THEN 1
	WHEN '2' THEN 2
	WHEN '3' THEN 3
	WHEN '4' THEN 4
	WHEN '5' THEN 5
	WHEN '6' THEN 6
	WHEN '7' THEN 7
	ELSE 100 END
	) ASC */
END
GO
/****** Object:  StoredProcedure [dbo].[GetTeachers]    Script Date: 14.09.2023 12:42:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetTeachers]
AS
	BEGIN
	SELECT * FROM
	(Select 
		[dbo].[teachers].[guid] AS [Guid],
		[dbo].[ShortFIO](
		(dbo.teachers.surname),
		(dbo.teachers.[name]),
		(dbo.teachers.[patronymic])) AS FIO
	from teachers) as result
	where result.FIO IS NOT NULL
	Order by FIO

	END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Название дня на русском языке' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'week_days', @level2type=N'COLUMN',@level2name=N'day_title'
GO
USE [master]
GO
ALTER DATABASE [raspisanie] SET  READ_WRITE 
GO
