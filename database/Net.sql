USE [PMS_Bhiwandi]
GO
/****** Object:  User [admin]    Script Date: 4/27/2023 5:45:05 PM ******/
CREATE USER [admin] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [Demo]    Script Date: 4/27/2023 5:45:05 PM ******/
CREATE USER [Demo] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[RemoveAlphaCharacters]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[RemoveAlphaCharacters](@Temp VarChar(1000))
Returns VarChar(1000)
AS
Begin

    Declare @KeepValues as varchar(50)
    Set @KeepValues = '%[^0-9+,]%'
    While PatIndex(@KeepValues, @Temp) > 0
        Set @Temp = Stuff(@Temp, PatIndex(@KeepValues, @Temp), 1, '')

    Return @Temp
End
GO
/****** Object:  UserDefinedFunction [dbo].[RemoveAlphaCharactersExceptDot]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Function [dbo].[RemoveAlphaCharactersExceptDot](@Temp VarChar(1000))
Returns VarChar(1000)
AS
Begin

    Declare @KeepValues as varchar(50)
    Set @KeepValues = '%[^0-9+,.]%'
    While PatIndex(@KeepValues, @Temp) > 0
        Set @Temp = Stuff(@Temp, PatIndex(@KeepValues, @Temp), 1, '')

    Return @Temp
End

GO
/****** Object:  UserDefinedFunction [dbo].[RemoveNonAlphaCharacters]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  Function [dbo].[RemoveNonAlphaCharacters](@Temp VarChar(1000))
Returns VarChar(1000)
AS
Begin

    Declare @KeepValues as varchar(50)
    Set @KeepValues = '%[^a-z ]%'
    While PatIndex(@KeepValues, @Temp) > 0
        Set @Temp = Stuff(@Temp, PatIndex(@KeepValues, @Temp), 1, '')

    Return @Temp
End
GO
/****** Object:  UserDefinedFunction [dbo].[Test_PMS_Vikhroli]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Test_PMS_Vikhroli]   
(   
    @txt_id NVARCHAR(MAX),   
    @Other_tax_Name CHAR(1)   
)   
RETURNS @output TABLE(splitdata NVARCHAR(MAX)   
)   
BEGIN   
    DECLARE @start INT, @end INT   
    SELECT @start = 1, @end = CHARINDEX(@Other_tax_Name, @txt_id)   
    WHILE @start < LEN(@txt_id) + 1 BEGIN   
        IF @end = 0    
            SET @end = LEN(@txt_id) + 1  
         
        INSERT INTO @output (splitdata)    
        VALUES(SUBSTRING(@txt_id, @start, @end - @start))   
        SET @start = @end + 1   
        SET @end = CHARINDEX(@Other_tax_Name, @txt_id, @start)  
          
    END   
    RETURN   
END  
GO
/****** Object:  UserDefinedFunction [dbo].[udf_GetNumeric]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[udf_GetNumeric]
(@strAlphaNumeric VARCHAR(256))
RETURNS VARCHAR(256)
AS
BEGIN
DECLARE @intAlpha INT
SET @intAlpha = PATINDEX('%[^0-9]%', @strAlphaNumeric)
BEGIN
WHILE @intAlpha > 0
BEGIN
SET @strAlphaNumeric = STUFF(@strAlphaNumeric, @intAlpha, 1, '' )
SET @intAlpha = PATINDEX('%[^0-9]%', @strAlphaNumeric )
END
END
RETURN ISNULL(@strAlphaNumeric,0)
END

GO
/****** Object:  Table [dbo].[NewSyncTable]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewSyncTable](
	[ID] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_NewSyncTable] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ob_complaint_log]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ob_complaint_log](
	[complaint_id] [varchar](50) NOT NULL,
	[company_name] [varchar](255) NOT NULL,
	[job_desc] [varchar](8000) NULL,
	[complaint_details] [varchar](8000) NOT NULL,
	[contact_person] [varchar](255) NULL,
	[email_to] [varchar](255) NULL,
	[created_by] [varchar](50) NOT NULL,
	[created_on] [datetime] NOT NULL,
	[updated_on] [datetime] NULL,
	[mode_of_complaint] [varchar](50) NULL,
	[contact_email] [varchar](255) NULL,
	[contact_telephone] [varchar](255) NULL,
 CONSTRAINT [PK_ob_complaint_log] PRIMARY KEY CLUSTERED 
(
	[complaint_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ob_customer_feedback]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ob_customer_feedback](
	[feedback_id] [bigint] IDENTITY(1,1) NOT NULL,
	[report_id] [bigint] NOT NULL,
	[customer_name] [varchar](8000) NOT NULL,
	[product_name] [varchar](8000) NULL,
	[remark] [varchar](8000) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL,
 CONSTRAINT [PK_ob_customer_feedback] PRIMARY KEY CLUSTERED 
(
	[feedback_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ob_daily_report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ob_daily_report](
	[report_id] [bigint] IDENTITY(1,1) NOT NULL,
	[no_of_calls] [varchar](255) NOT NULL,
	[no_of_visits] [varchar](255) NOT NULL,
	[no_of_presponse] [varchar](255) NOT NULL,
	[entry_insert_datetime] [datetime] NULL,
	[entry_update_datetime] [datetime] NULL,
	[userid] [varchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL,
 CONSTRAINT [PK_ob_daily_report] PRIMARY KEY CLUSTERED 
(
	[report_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ob_new_order_booking]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ob_new_order_booking](
	[booking_id] [varchar](50) NOT NULL,
	[order_date_time] [datetime] NULL,
	[product_category] [varchar](255) NULL,
	[transaction_category] [varchar](255) NULL,
	[supply_from] [varchar](255) NULL,
	[company_name] [varchar](1000) NOT NULL,
	[contact_person] [varchar](50) NULL,
	[contact_mobile] [varchar](50) NULL,
	[contact_email] [varchar](250) NULL,
	[UserId] [varchar](50) NOT NULL,
	[po_no] [varchar](50) NULL,
	[po_date] [date] NULL,
	[taxes_applicable] [varchar](50) NULL,
	[bank_charges_yn] [varchar](1) NULL,
	[extra_charges_yn] [varchar](1) NULL,
	[extra_charges_Amount] [varchar](50) NULL,
	[extra_charges_desc] [varchar](1000) NULL,
	[transport_mode] [varchar](50) NULL,
	[transport_ownership] [varchar](50) NULL,
	[transport_cost] [varchar](50) NULL,
	[transport_type] [varchar](50) NULL,
	[transporter_id] [varchar](50) NULL,
	[Transporter] [varchar](1000) NULL,
	[octroi_charges_yn] [varchar](1) NULL,
	[octroi_billedto] [varchar](50) NULL,
	[transport_yn] [varchar](1) NULL,
	[transport_billedto] [varchar](50) NULL,
	[job_sample_yn] [varchar](1) NULL,
	[job_sample_cost] [varchar](50) NULL,
	[dtp_sec_feature_yn] [varchar](1) NULL,
	[dtp_spot_carbon_yn] [varchar](1) NULL,
	[dtp_coating_yn] [varchar](1) NULL,
	[dtp_company] [varchar](50) NULL,
	[dtp_Remark] [varchar](1000) NULL,
	[dtp_sec_feature_txt] [varchar](255) NULL,
	[dtp_coating_txt] [varchar](255) NULL,
	[product_name] [varchar](255) NOT NULL,
	[item_description] [varchar](255) NULL,
	[size] [varchar](255) NOT NULL,
	[quantity] [varchar](255) NOT NULL,
	[rate] [varchar](255) NULL,
	[rate_unit] [varchar](50) NULL,
	[numbering_details] [varchar](255) NULL,
	[delivery_address] [varchar](1000) NULL,
	[printups_column] [varchar](255) NULL,
	[rows] [varchar](255) NULL,
	[perforation_yn] [varchar](50) NULL,
	[perforation_direction] [varchar](50) NULL,
	[type] [varchar](50) NULL,
	[job_card_no] [varchar](50) NULL,
	[entry_remark] [varchar](1000) NULL,
	[Status] [int] NULL,
	[packaging_details] [varchar](1000) NULL,
	[Remark] [nvarchar](1000) NULL,
 CONSTRAINT [PK_ob_new_order_booking] PRIMARY KEY CLUSTERED 
(
	[booking_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ob_new_ply_table]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ob_new_ply_table](
	[ply_id] [bigint] IDENTITY(1,1) NOT NULL,
	[booking_id] [varchar](50) NOT NULL,
	[GSM] [varchar](255) NULL,
	[Color] [varchar](255) NULL,
 CONSTRAINT [PK_ob_new_ply_table] PRIMARY KEY CLUSTERED 
(
	[ply_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[order_booking]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[order_booking](
	[booking_id] [varchar](50) NOT NULL,
	[name] [varchar](1000) NOT NULL,
	[product] [varchar](255) NULL,
	[size] [varchar](255) NULL,
	[quantity] [varchar](255) NOT NULL,
	[delivery_location] [varchar](255) NULL,
	[delivery_date] [date] NULL,
	[email_id] [varchar](255) NULL,
	[mobile_no] [varchar](50) NULL,
	[order_date_time] [datetime] NULL,
	[Status] [int] NULL,
	[ContactPerson] [varchar](255) NULL,
	[UserId] [varchar](50) NOT NULL,
	[Remark] [nvarchar](1000) NULL,
	[po_no] [nvarchar](50) NULL,
	[po_date] [date] NULL,
	[job_card_no] [nvarchar](50) NULL,
	[type] [varchar](50) NULL,
	[delivery_address] [varchar](1000) NULL,
	[copy_mark] [nvarchar](255) NULL,
	[numbering] [varchar](255) NULL,
	[packaging] [varchar](255) NULL,
	[height] [varchar](50) NULL,
	[width] [varchar](50) NULL,
	[item_description] [varchar](255) NULL,
	[entry_remark] [varchar](1000) NULL,
	[rate] [varchar](255) NULL,
	[taxes_applicable] [varchar](255) NULL,
	[dtp_sec_feature] [varchar](1) NULL,
	[dtp_spat_carbon] [varchar](1) NULL,
	[dtp_coating] [varchar](1) NULL,
	[dtp_company] [varchar](50) NULL,
	[dtp_Remark] [varchar](1000) NULL,
	[dtp_sec_feature_txt] [varchar](255) NULL,
	[dtp_coating_txt] [varchar](255) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_order_booking_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_order_booking_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK__order_bo__5DE3A5B17F60ED59] PRIMARY KEY CLUSTERED 
(
	[booking_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ply_table]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ply_table](
	[ply_id] [bigint] IDENTITY(1,1) NOT NULL,
	[booking_id] [varchar](50) NOT NULL,
	[gsm] [varchar](255) NOT NULL,
	[color] [varchar](255) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_ply_table_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_ply_table_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_ply_table] PRIMARY KEY CLUSTERED 
(
	[ply_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Activity]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Activity](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[Activity_Name] [varchar](150) NULL,
	[Office_Position] [nvarchar](50) NULL,
	[Senior] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Activity_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_Activity] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Appraisal]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Appraisal](
	[ID] [nvarchar](20) NOT NULL,
	[AppraisalBy] [nvarchar](20) NULL,
	[AppraisalTo] [nvarchar](20) NULL,
	[CreatedBy] [nvarchar](20) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](20) NULL,
	[UpdatedOn] [datetime] NULL,
	[DeleteFlag] [nvarchar](10) NULL CONSTRAINT [DF_PMS_Appraisal_DeleteFlag]  DEFAULT ((1)),
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_AppraisalDetail]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_AppraisalDetail](
	[ID] [nvarchar](20) NOT NULL,
	[AppraisalID] [nvarchar](20) NOT NULL,
	[JobKnw_1] [nvarchar](10) NULL,
	[skill_2] [nvarchar](10) NULL,
	[QualtyWrk_3] [nvarchar](10) NULL,
	[QualtyOP_4] [nvarchar](10) NULL,
	[PlaninAblty_5] [nvarchar](10) NULL,
	[TimlyOP_6] [nvarchar](10) NULL,
	[AbltyLern_7] [nvarchar](10) NULL,
	[TrainAblT_8] [nvarchar](10) NULL,
	[Initaitive_9] [nvarchar](10) NULL,
	[Creativity_10] [nvarchar](10) NULL,
	[Sefety_11] [nvarchar](10) NULL,
	[tmSpirit_12] [nvarchar](10) NULL,
	[AblTCntrlSubOrdint_13] [nvarchar](10) NULL,
	[AttdTowrdSuperior_14] [nvarchar](10) NULL,
	[AttdTowrdWork_15] [nvarchar](10) NULL,
	[AtndPnctualT_16] [nvarchar](10) NULL,
	[CommSuperSub_17] [nvarchar](10) NULL,
	[MchSparArrg_18] [nvarchar](10) NULL,
	[HouseKeeping_19] [nvarchar](10) NULL,
	[PMSEntry_20] [nvarchar](10) NULL,
	[KnwlTrnsfrAbiliT_21] [nvarchar](10) NULL,
	[WstgReducMesr_22] [nvarchar](10) NULL,
	[CstReduc_23] [nvarchar](10) NULL,
	[Total] [nvarchar](10) NULL,
	[Rating] [nvarchar](10) NULL,
	[Status] [nvarchar](10) NULL CONSTRAINT [DF_PMS_AppraisalDetail_Status]  DEFAULT ((0)),
	[Who] [nvarchar](25) NULL,
	[Remark] [nvarchar](250) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](20) NULL,
	[CreatedOn] [datetime] NULL,
	[AutoCreatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Auto_Synchronise]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Auto_Synchronise](
	[Auto_Id] [int] NOT NULL,
	[Type] [varchar](100) NULL,
	[Date_Time] [datetime] NULL,
	[Status] [int] NULL,
	[Message] [varchar](255) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [pk_Auto_Id] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Business_Work_Flow]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Business_Work_Flow](
	[Auto_Id] [varchar](15) NOT NULL,
	[BWF_Type] [varchar](150) NULL,
	[Customer] [nvarchar](50) NULL,
	[Job_Card] [nvarchar](50) NULL,
	[Work_Order] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Business_Work_Flow_CreatedOn_1]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Business_Work_Flow] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Buyer]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Buyer](
	[Buyer_Id] [nvarchar](50) NOT NULL,
	[Buyer_Name] [nvarchar](50) NULL,
	[Organisation] [nvarchar](100) NULL,
	[Address] [nvarchar](200) NULL,
	[PhoneNo] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Buyer_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Buyer] PRIMARY KEY CLUSTERED 
(
	[Buyer_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Category]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Category](
	[id] [nvarchar](50) NOT NULL,
	[categorytype] [nvarchar](50) NOT NULL,
	[rmid] [nvarchar](50) NULL,
	[name] [varchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Category_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Category] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_CHACartingLocations]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_CHACartingLocations](
	[CartingLocationID] [nvarchar](50) NOT NULL,
	[CHASupplierID] [nvarchar](50) NULL,
	[Address] [nvarchar](max) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_CHACartingLocations] PRIMARY KEY CLUSTERED 
(
	[CartingLocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_ChangeRequestModule]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_ChangeRequestModule](
	[Reqst_Id] [nvarchar](50) NOT NULL,
	[TypeofModule] [int] NULL,
	[ModuleName] [nvarchar](50) NULL,
	[Reqst_Details] [nvarchar](550) NULL,
	[DateTime] [date] NULL,
	[Time] [time](4) NULL,
	[UserId] [nvarchar](50) NULL,
	[TypeofReqst] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_ChangeRequestModule_CreatedOn]  DEFAULT (getdate()),
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_ChangeRequestModule] PRIMARY KEY CLUSTERED 
(
	[Reqst_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_City]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_City](
	[city_Id] [nvarchar](50) NOT NULL,
	[city_Name] [nvarchar](50) NULL,
	[city_Code] [nvarchar](50) NULL,
	[state_Id] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_City_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[city_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Collection]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Collection](
	[ID] [nvarchar](50) NOT NULL,
	[Type] [int] NULL,
	[Bank_Name] [nvarchar](50) NULL,
	[Payment_Mode] [nvarchar](50) NULL,
	[TrackingNo] [nvarchar](50) NULL,
	[DateOfChkIssue] [date] NULL,
	[DateOfChkRec] [date] NULL,
	[DateOfDeposite] [date] NULL,
	[Cust_Name] [nvarchar](50) NULL,
	[AdvOnAc] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL,
 CONSTRAINT [PK_PMS_Collection] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_CollectionDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_CollectionDetails](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[CollectionID] [nvarchar](50) NULL,
	[FileType] [nvarchar](50) NULL,
	[File_Name] [nvarchar](50) NULL,
	[File_Location] [nvarchar](350) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_CollectionDetails_CreatedOn]  DEFAULT (getdate()),
	[CreatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_CollectionDetails] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_CollectionForm]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_CollectionForm](
	[Collection_Id] [nvarchar](50) NOT NULL,
	[Type] [int] NULL,
	[Invoice_No] [nvarchar](50) NULL,
	[Bank_Name] [nvarchar](50) NULL,
	[Pay_mode] [nvarchar](50) NULL,
	[Tracking_No] [nvarchar](50) NULL,
	[ChqIssDate] [date] NULL,
	[ChqRecvDate] [date] NULL,
	[DepositDate] [date] NULL,
	[InvoiceAmt] [nvarchar](50) NULL,
	[AmtRecev] [decimal](10, 2) NULL,
	[AmtDiff] [nvarchar](50) NULL,
	[CreatedOn] [datetime2](7) NULL CONSTRAINT [DF_PMS_CollectionForm_CreatedOn]  DEFAULT (getdate()),
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime2](7) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_CollectionForm] PRIMARY KEY CLUSTERED 
(
	[Collection_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_CollectionsDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_CollectionsDetails](
	[ID] [nvarchar](50) NOT NULL,
	[Collection_ID] [nvarchar](50) NULL,
	[InvoiceNo] [nvarchar](50) NULL,
	[InvoiceAmt] [decimal](10, 2) NULL,
	[AmountRec] [decimal](10, 2) NULL,
	[ChkTDS] [nvarchar](50) NULL,
	[AmtDiff_TDS] [decimal](10, 2) NULL,
	[ChkAdvPay] [nvarchar](50) NULL,
	[AmtDiff_AdvPayment] [decimal](10, 2) NULL,
	[ChkLateDekivery] [nvarchar](50) NULL,
	[AmtDiff_LateDelivery] [decimal](10, 2) NULL,
	[ChkOther] [nvarchar](50) NULL,
	[AmtDiff_Other] [decimal](10, 2) NULL,
	[BalanceAmount] [decimal](10, 2) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL,
 CONSTRAINT [PK_PMS_CollectionsDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Color]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Color](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[Color_Name] [varchar](50) NULL,
	[Status] [char](5) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Color_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_Color] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_ColorShade]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_ColorShade](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[Color_Shade] [varchar](75) NULL,
	[Status] [char](50) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_ColorShade_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_ColorShade] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Company]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Company](
	[comp_Id] [nvarchar](50) NOT NULL,
	[comp_Name] [nvarchar](50) NULL,
	[comp_RegsAdd] [nvarchar](max) NULL,
	[comp_corrAdd] [nvarchar](max) NULL,
	[comp_PhoneNo] [nvarchar](15) NULL,
	[comp_FaxNo] [nvarchar](15) NULL,
	[comp_VatRegsNo] [nvarchar](15) NULL,
	[comp_GrioNo] [nvarchar](15) NULL,
	[comp_Bank] [nvarchar](50) NULL,
	[comp_Branch] [nvarchar](50) NULL,
	[comp_AccNo] [nvarchar](20) NULL,
	[comp_SaleTaxDed] [nvarchar](20) NULL,
	[comp_SaleTaxDECL] [nvarchar](max) NULL,
	[comp_TermsCond] [nvarchar](max) NULL,
	[comp_Prefix] [nvarchar](25) NULL,
	[service_reg_no] [varchar](50) NULL,
	[TIN_No] [varchar](50) NULL,
	[Pan_No] [varchar](50) NULL,
	[ECC_No] [varchar](50) NULL,
	[Excise_Range] [varchar](50) NULL,
	[Excise_division] [varchar](50) NULL,
	[Commissioner_rate] [varchar](50) NULL,
	[service_reg_no_dated] [datetime] NULL,
	[ECC_No_dated] [datetime] NULL,
	[GST_No] [nvarchar](50) NULL,
	[ARN_No] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Company_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Company_UpdatedOn]  DEFAULT (getdate()),
	[IT_TDS] [nvarchar](50) NULL,
	[CIN_No] [nvarchar](50) NULL,
	[CorrespondantBank] [nvarchar](50) NULL,
	[CorrespondantBankAccountNo] [nvarchar](50) NULL,
	[CorrespondantBankLocation] [nvarchar](50) NULL,
	[CorrespondantBankSwiftBicCode] [nvarchar](50) NULL,
	[IEC_No] [nvarchar](50) NULL,
 CONSTRAINT [PK_Company1] PRIMARY KEY CLUSTERED 
(
	[comp_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Company_BankDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Company_BankDetails](
	[ID] [nvarchar](50) NOT NULL,
	[Comp_ID] [nvarchar](50) NULL,
	[BankName] [nvarchar](250) NULL,
	[AcNo] [nvarchar](50) NULL,
	[Branch] [nvarchar](250) NULL,
	[ACName] [nvarchar](150) NULL,
	[EmailID] [nvarchar](100) NULL,
	[Mobile] [nvarchar](50) NULL,
	[IFSCCode] [nvarchar](50) NULL,
	[ACType] [nvarchar](10) NULL,
	[Address] [nvarchar](max) NULL,
	[Templete] [nvarchar](50) NULL,
	[CostCenter] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreaedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Company_BankDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Company_RTGS]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Company_RTGS](
	[ID] [nvarchar](50) NOT NULL,
	[Comp_BD_ID] [nvarchar](50) NULL,
	[Supplier_ID] [varchar](20) NULL,
	[BankID] [varchar](50) NULL,
	[Date] [date] NULL,
	[Amount] [decimal](10, 2) NULL,
	[Amt_words] [nvarchar](max) NULL,
	[Cheque_No] [nvarchar](50) NULL,
	[Type] [nvarchar](50) NULL,
	[NEFTStatus] [int] NULL,
	[Reason] [nvarchar](150) NULL,
	[Remarks] [nvarchar](max) NULL,
	[Invoice_No] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Company_RTGS_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Company_RTGS] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_CompanyPlants]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_CompanyPlants](
	[compPlant_Id] [nvarchar](50) NOT NULL,
	[compPlant_ECC] [nvarchar](50) NULL,
	[compPlants_SalesTax] [nvarchar](50) NULL,
	[comp_ID] [nvarchar](50) NULL,
	[compPlant_ECC_dated] [datetime] NULL,
	[compPlants_SalesTax_dated] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_CompanyPlants_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL CONSTRAINT [DF_PMS_CompanyPlants_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_CompanyPlants] PRIMARY KEY CLUSTERED 
(
	[compPlant_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Complain_Mgmt_System]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Complain_Mgmt_System](
	[Auto_Id] [varchar](50) NOT NULL,
	[Complain_Category] [varchar](100) NULL,
	[Complain_Title] [varchar](100) NULL,
	[Complain_Text] [varchar](max) NULL,
	[File_Name] [varchar](255) NULL,
	[Entry_Date] [datetime] NULL,
	[User_Name] [nvarchar](50) NULL,
	[status] [int] NULL CONSTRAINT [DF_PMS_Complain_Mgmt_System_Status]  DEFAULT ('1'),
	[Resolution] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL,
 CONSTRAINT [PK_PMS_Complain_Mgmt_System] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Config]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Config](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[conf_email_username] [nvarchar](50) NULL,
	[conf_email_password] [nvarchar](50) NULL,
	[conf_smtpserver_name] [nvarchar](50) NULL,
	[conf_DailyRep_EmailID] [nvarchar](30) NULL,
	[conf_DailyRep_ReptReq] [int] NULL,
	[conf_DailyRep_WantMail] [int] NULL,
	[conf_QC_EventEmailID] [nvarchar](30) NULL,
	[conf_QC_NonEventEmailId] [nvarchar](30) NULL,
	[conf_QC_RepReq] [int] NULL,
	[conf_QC_WantMail] [int] NULL,
	[conf_Comp_EventEmailID] [nvarchar](30) NULL,
	[conf_Comp_NonEventEmailId] [nvarchar](30) NULL,
	[conf_Comp_RepReq] [int] NULL,
	[conf_Comp_WantMail] [int] NULL,
	[conf_WorkOrd_EmailID] [nvarchar](30) NULL,
	[conf_WorkOrd_ReptReq] [int] NULL,
	[conf_WorkOrd_WantMail] [int] NULL,
	[conf_Westage_EventEmailID] [nvarchar](30) NULL,
	[conf_Westage_NonEventEmailId] [nvarchar](30) NULL,
	[conf_Westage_RepReq] [int] NULL,
	[conf_Westage_WantMail] [int] NULL,
	[conf_Mail_From] [nvarchar](30) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Config] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Config_AllTypeReportMail]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Config_AllTypeReportMail](
	[Auto_Id] [int] IDENTITY(1,1) NOT NULL,
	[Report_Type] [nvarchar](15) NULL,
	[Bind] [nvarchar](3) NULL,
	[Mail] [nvarchar](50) NULL,
	[Type] [varchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Config_AllTypeReportMail] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Config_BackOfficeWorkReport]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Config_BackOfficeWorkReport](
	[Work_Id] [int] IDENTITY(1,1) NOT NULL,
	[Work_ReportType] [nvarchar](15) NULL,
	[Work_Bind] [nvarchar](3) NULL,
	[Work_MailID] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Config_BackOfficeWorkReport] PRIMARY KEY CLUSTERED 
(
	[Work_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Config_ComplaintsMail]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Config_ComplaintsMail](
	[comp_Id] [int] IDENTITY(1,1) NOT NULL,
	[comp_ReportType] [nvarchar](15) NULL,
	[comp_Bind] [nvarchar](3) NULL,
	[comp_MailID] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Config_ComplaintsMail] PRIMARY KEY CLUSTERED 
(
	[comp_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Config_ComplaintsSMS]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Config_ComplaintsSMS](
	[qcsms_Id] [int] IDENTITY(1,1) NOT NULL,
	[qcsms_Name] [nvarchar](50) NULL,
	[qcsms_No] [nvarchar](50) NULL,
	[qcsms_Site] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Config_ComplaintsSMS] PRIMARY KEY CLUSTERED 
(
	[qcsms_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Config_DailyMail]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Config_DailyMail](
	[dal_Id] [int] IDENTITY(1,1) NOT NULL,
	[dal_ReportType] [nvarchar](15) NULL,
	[dal_Bind] [nvarchar](3) NULL,
	[dal_MailID] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Config_DailyMail] PRIMARY KEY CLUSTERED 
(
	[dal_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Config_MachinePerformance]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Config_MachinePerformance](
	[Auto_Id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Machine_Report_Type] [varchar](15) NULL,
	[Machine_Bind] [varchar](5) NULL,
	[Machine_Mail_Id] [varchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Config_MachinePerformance] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Config_MaintenanceReport]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Config_MaintenanceReport](
	[Auto_Id] [int] IDENTITY(1,1) NOT NULL,
	[Report_Type] [nvarchar](15) NULL,
	[Bind] [nvarchar](3) NULL,
	[Mail] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Config_MaintenanceReport] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Config_Old]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Config_Old](
	[id] [int] NOT NULL,
	[conf_email_username] [nvarchar](50) NULL,
	[conf_email_password] [nvarchar](50) NULL,
	[conf_smtpserver_name] [nvarchar](50) NULL,
	[conf_DailyRep_EmailID] [nvarchar](30) NULL,
	[conf_DailyRep_ReptReq] [int] NULL,
	[conf_DailyRep_WantMail] [int] NULL,
	[conf_QC_EventEmailID] [nvarchar](30) NULL,
	[conf_QC_NonEventEmailId] [nvarchar](30) NULL,
	[conf_QC_RepReq] [int] NULL,
	[conf_QC_WantMail] [int] NULL,
	[conf_Comp_EventEmailID] [nvarchar](30) NULL,
	[conf_Comp_NonEventEmailId] [nvarchar](30) NULL,
	[conf_Comp_RepReq] [int] NULL,
	[conf_Comp_WantMail] [int] NULL,
	[conf_WorkOrd_EmailID] [nvarchar](30) NULL,
	[conf_WorkOrd_ReptReq] [int] NULL,
	[conf_WorkOrd_WantMail] [int] NULL,
	[conf_Westage_EventEmailID] [nvarchar](30) NULL,
	[conf_Westage_NonEventEmailId] [nvarchar](30) NULL,
	[conf_Westage_RepReq] [int] NULL,
	[conf_Westage_WantMail] [int] NULL,
	[conf_Mail_From] [nvarchar](30) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Config_Old] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Config_OpenJobCatdMail]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Config_OpenJobCatdMail](
	[oj_Id] [int] IDENTITY(1,1) NOT NULL,
	[oj_ReportType] [nvarchar](15) NULL,
	[oj_Bind] [nvarchar](3) NULL,
	[oj_MailID] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Config_OpenJobCatdMail] PRIMARY KEY CLUSTERED 
(
	[oj_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Config_QCMail]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Config_QCMail](
	[qc_Id] [int] IDENTITY(1,1) NOT NULL,
	[qc_ReportType] [nvarchar](15) NULL,
	[qc_Bind] [nvarchar](3) NULL,
	[qc_MailID] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Config_QCMail] PRIMARY KEY CLUSTERED 
(
	[qc_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Config_QCSMS]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Config_QCSMS](
	[qcsms_Id] [int] IDENTITY(1,1) NOT NULL,
	[qcsms_Name] [nvarchar](50) NULL,
	[qcsms_No] [nvarchar](50) NULL,
	[qcsms_Site] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Config_QCSMS] PRIMARY KEY CLUSTERED 
(
	[qcsms_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Config_SMS]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Config_SMS](
	[sms_Id] [int] IDENTITY(1,1) NOT NULL,
	[sms_UserName] [nvarchar](50) NULL,
	[sms_Password] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Config_SMS] PRIMARY KEY CLUSTERED 
(
	[sms_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Config_UserPerformance]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Config_UserPerformance](
	[Auto_Id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[User_Report_Type] [varchar](15) NULL,
	[User_Bind] [varchar](5) NULL,
	[User_Mail_Id] [varchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Config_UserPerformance] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Config_WestageMail]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Config_WestageMail](
	[wes_Id] [int] IDENTITY(1,1) NOT NULL,
	[wes_ReportType] [nvarchar](15) NULL,
	[wes_Bind] [nvarchar](3) NULL,
	[wes_MailID] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Config_WestageMail] PRIMARY KEY CLUSTERED 
(
	[wes_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_CostingAdditionalRequirement]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_CostingAdditionalRequirement](
	[ID] [nvarchar](50) NOT NULL,
	[CostingID] [nvarchar](50) NULL,
	[AdditionalCategoryName] [nvarchar](50) NULL,
	[AdditionalTypeName] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[Cost] [decimal](10, 2) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_CostingAdditionalRequirement] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_CostingMaster]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_CostingMaster](
	[CostingID] [nvarchar](50) NOT NULL,
	[CostingTitle] [nvarchar](max) NULL,
	[ProductCategoryID] [nvarchar](50) NULL,
	[ProductTypeID] [nvarchar](50) NULL,
	[ItemTypeID] [nvarchar](50) NULL,
	[PartPly] [decimal](18, 0) NULL,
	[Width] [decimal](10, 2) NULL,
	[WidthUnit] [nvarchar](50) NULL,
	[Height] [decimal](10, 2) NULL,
	[HeightUnit] [nvarchar](50) NULL,
	[Quantity] [decimal](10, 2) NULL,
	[Unit] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_CostingMaster] PRIMARY KEY CLUSTERED 
(
	[CostingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_CostingMaterialRequirement]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_CostingMaterialRequirement](
	[ID] [nvarchar](50) NOT NULL,
	[CostingID] [nvarchar](50) NULL,
	[CategoryID] [nvarchar](50) NULL,
	[ProductCategoryID] [nvarchar](50) NULL,
	[ItemID] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[Quantity] [decimal](10, 2) NULL,
	[Unit] [nvarchar](50) NULL,
	[Cost] [decimal](10, 2) NULL,
	[Wastage] [decimal](10, 2) NULL,
	[TotalCost] [decimal](10, 2) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_CostingMaterialRequirement] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_CostingProcessRequirement]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_CostingProcessRequirement](
	[ID] [nvarchar](50) NOT NULL,
	[CostingID] [nvarchar](50) NULL,
	[ProcessCategoryID] [nvarchar](50) NULL,
	[ProcessID] [nvarchar](50) NULL,
	[TimeRequire] [decimal](10, 2) NULL,
	[NoOfLabours] [decimal](10, 2) NULL,
	[CostPerLabourPerHour] [decimal](10, 2) NULL,
	[MachineUsed] [nvarchar](50) NULL,
	[MachineCost] [decimal](10, 2) NULL,
	[Wastage] [decimal](10, 2) NULL,
	[TotalCost] [decimal](10, 2) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_CostingProcessRequirement] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_CostSheet]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_CostSheet](
	[ID] [nvarchar](50) NOT NULL,
	[CustomerName] [nvarchar](50) NULL,
	[CustomerAddress] [nvarchar](max) NULL,
	[ContactPerson] [nvarchar](50) NULL,
	[ContactPhone] [nvarchar](50) NULL,
	[ContactEmail] [nvarchar](50) NULL,
	[ProductTitle] [nvarchar](max) NULL,
	[ProductCategoryID] [nvarchar](50) NULL,
	[ProductTypeID] [nvarchar](50) NULL,
	[OrderQuantity] [decimal](10, 2) NULL,
	[FGOrderQuantity] [decimal](10, 2) NULL,
	[FGWidth] [decimal](10, 2) NULL,
	[FGHeight] [decimal](10, 2) NULL,
	[PrintWidth] [decimal](10, 2) NULL,
	[PrintHeight] [decimal](10, 2) NULL,
	[PaperTypeID] [nvarchar](50) NULL,
	[Ups] [decimal](10, 2) NULL,
	[Plys] [decimal](10, 2) NULL,
	[InkPrintingType] [nvarchar](50) NULL,
	[TotalMaterialCost] [decimal](10, 2) NULL,
	[TotalInkCost] [decimal](10, 2) NULL,
	[NoOfPiecesPerBox] [decimal](10, 2) NULL,
	[WeightOfBox] [decimal](10, 2) NULL,
	[TotalMaterialWeight] [decimal](10, 2) NULL,
	[TotalInkWeight] [decimal](10, 2) NULL,
	[NetWeight] [decimal](10, 2) NULL,
	[GrossWeight] [decimal](10, 2) NULL,
	[TotalPackingCost] [decimal](10, 2) NULL,
	[TotalProcessCost] [decimal](10, 2) NULL,
	[TotalCostAmount] [decimal](10, 2) NULL,
	[TotalCostPerPiece] [decimal](10, 2) NULL,
	[FreightPercentage] [decimal](10, 2) NULL,
	[FreightAmount] [decimal](10, 2) NULL,
	[TotalAmountAfterFreight] [decimal](10, 2) NULL,
	[TotalAmountAfterFreightPerPiece] [decimal](10, 2) NULL,
	[PercentageIndirectCost] [decimal](10, 2) NULL,
	[IndirectCostAmount] [decimal](10, 2) NULL,
	[TotalAmount] [decimal](10, 2) NULL,
	[TotalAmountAfterAdditionalPerPiece] [decimal](10, 2) NULL,
	[ProfitPercentage] [decimal](10, 2) NULL,
	[ProfitAmount] [decimal](10, 2) NULL,
	[TotalAmountAfterProfit] [decimal](10, 2) NULL,
	[TotalAmountAfterProfitPerPiece] [decimal](10, 2) NULL,
	[Tax] [decimal](10, 2) NULL,
	[TaxAmount] [decimal](10, 2) NULL,
	[GrandTotal] [decimal](10, 2) NULL,
	[GrandTotalPerPiece] [decimal](10, 2) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_CostSheet] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_CostSheet_InkCostDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_CostSheet_InkCostDetails](
	[ID] [nvarchar](50) NOT NULL,
	[CostSheetID] [nvarchar](50) NULL,
	[Ply] [nvarchar](50) NULL,
	[InputQuantity] [decimal](10, 2) NULL,
	[Rate] [decimal](10, 2) NULL,
	[Amount] [decimal](10, 2) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_CostSheet_InkCostDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_CostSheet_MaterialCostDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_CostSheet_MaterialCostDetails](
	[ID] [nvarchar](50) NOT NULL,
	[CostSheetID] [nvarchar](50) NULL,
	[Ply] [nvarchar](50) NULL,
	[InputQuantity] [decimal](10, 2) NULL,
	[Rate] [decimal](10, 2) NULL,
	[Amount] [decimal](10, 2) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_CostSheet_MaterialCostDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_CostSheet_PlyDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_CostSheet_PlyDetails](
	[ID] [nvarchar](50) NOT NULL,
	[CostSheetID] [nvarchar](50) NULL,
	[Ply] [nvarchar](50) NULL,
	[GSM] [decimal](10, 2) NULL,
	[StandardInk] [decimal](10, 2) NULL,
	[SpecialInk] [decimal](10, 2) NULL,
	[UVInk] [decimal](10, 2) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_CostSheet_PlyDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_CostSheet_ProcessCostDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_CostSheet_ProcessCostDetails](
	[ID] [nvarchar](50) NOT NULL,
	[CostSheetID] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[ProcessName] [nvarchar](50) NULL,
	[FixedCost] [decimal](10, 2) NULL,
	[RunningCost] [decimal](10, 2) NULL,
	[TotalAmount] [decimal](10, 2) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_CostSheet_ProcessCostDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Country]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Country](
	[Country_Id] [nvarchar](50) NOT NULL,
	[Country_Name] [nvarchar](50) NULL,
	[Country_Code] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_Country_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_Country_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[Country_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Currency]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Currency](
	[curr_Id] [nvarchar](50) NOT NULL,
	[curr_Name] [varchar](50) NULL,
	[curr_Value] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_Currency_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_Currency_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_Currency] PRIMARY KEY CLUSTERED 
(
	[curr_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_CustFeedback]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_CustFeedback](
	[CustFd_Id] [nvarchar](50) NOT NULL,
	[SO_Id] [nvarchar](50) NULL,
	[Q1] [int] NULL,
	[Q2] [int] NULL,
	[Q3] [int] NULL,
	[Q4] [int] NULL,
	[Q5] [int] NULL,
	[Q6] [int] NULL,
	[Q7] [int] NULL,
	[Q8] [int] NULL,
	[Q9] [int] NULL,
	[Q10] [int] NULL,
	[Suggestion] [nvarchar](500) NULL,
	[Status] [int] NULL,
	[Link] [nvarchar](550) NULL,
	[CreateDate] [datetime] NULL CONSTRAINT [DF_PMS_CustFeedback_CreateDate_1]  DEFAULT (getdate()),
	[UpdateDate] [date] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime2](7) NULL CONSTRAINT [DF_PMS_CustFeedback_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime2](7) NULL CONSTRAINT [DF_PMS_CustFeedback_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_CustFeedback] PRIMARY KEY CLUSTERED 
(
	[CustFd_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Customer]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Customer](
	[cust_Id] [nvarchar](50) NOT NULL,
	[cust_UId] [nvarchar](50) NOT NULL,
	[cust_No] [varchar](100) NULL,
	[cust_Address] [nvarchar](max) NULL,
	[cust_PBoxNo] [nvarchar](15) NULL,
	[cust_Name] [nvarchar](550) NULL,
	[cust_Company] [nvarchar](50) NULL,
	[cust_City] [nvarchar](50) NULL,
	[cust_State] [nvarchar](50) NULL,
	[cust_Country] [nvarchar](50) NULL,
	[cust_PhoneNo] [nvarchar](15) NULL,
	[cust_FaxNo] [nvarchar](15) NULL,
	[cust_Email] [nvarchar](30) NULL,
	[cust_BillToCust] [nvarchar](20) NULL,
	[cust_GenBusPostGr] [nvarchar](30) NULL,
	[cust_VatBusPostGr] [nvarchar](30) NULL,
	[cust_ExBusPostGr] [nvarchar](30) NULL,
	[cust_CustPostGr] [nvarchar](30) NULL,
	[cust_PayTermCode] [nvarchar](250) NULL,
	[cust_PayMethodCode] [nvarchar](20) NULL,
	[cust_ShippMethodCode] [nvarchar](20) NULL,
	[cust_ExTradeCurrencyCode] [nvarchar](10) NULL,
	[cust_ExTradeVatRegs] [nvarchar](30) NULL,
	[GST_No] [nvarchar](50) NULL,
	[ARN_No] [nvarchar](50) NULL,
	[cust_Tax_LSTNo] [nvarchar](30) NULL,
	[cust_Tax_CSTNo] [nvarchar](30) NULL,
	[cust_Tax_Liable] [nvarchar](2) NULL,
	[cust_Tax_ECCNo] [nvarchar](30) NULL,
	[cust_Tax_Range] [nvarchar](30) NULL,
	[cust_Tax_Collectorate] [nvarchar](30) NULL,
	[cust_IncTax_PanNo] [nvarchar](30) NULL,
	[cust_IncTax_PanStatus] [nvarchar](30) NULL,
	[cust_IncTax_PanRefNo] [nvarchar](30) NULL,
	[cust_Vat_TINNo] [nvarchar](30) NULL,
	[cust_Vat_Export] [nvarchar](30) NULL,
	[cust_SerTax_NatureOfServ] [nvarchar](30) NULL,
	[cust_ExTrade_CompName] [nvarchar](30) NULL,
	[cust_ExTrade_PartyName] [nvarchar](30) NULL,
	[cust_ExTrade_BoxNo] [nvarchar](30) NULL,
	[cust_ExTrade_Size] [nvarchar](20) NULL,
	[cust_ExTrade_Country] [nvarchar](30) NULL,
	[cust_ExTrade_Products] [nvarchar](50) NULL,
	[cust_Vat_Exampted] [nvarchar](30) NULL,
	[cust_SalesPerson] [nvarchar](30) NULL,
	[cust_CommPerName] [nvarchar](30) NULL,
	[cust_VendorCode] [nvarchar](20) NULL,
	[cust_CoOrdinator] [nvarchar](20) NULL,
	[cust_Bank_Name] [varchar](250) NULL,
	[cust_Bank_Branch] [varchar](250) NULL,
	[cust_Bank_Acc_No] [varchar](250) NULL,
	[cust_Vat_No] [varchar](250) NULL,
	[cust_Credit_Limit] [varchar](50) NULL,
	[cust_Tax_LBTNo] [nvarchar](30) NULL,
	[Office_Assistant] [varchar](100) NULL,
	[cust_Tax_LSTNo_dated] [datetime] NULL,
	[cust_Tax_CSTNo_dated] [datetime] NULL,
	[cust_Vat_No_dated] [datetime] NULL,
	[cust_Tax_LBTNo_dated] [datetime] NULL,
	[Cust_Version] [nvarchar](150) NULL,
	[Active_Flag] [bit] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Customer_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[Cust_UnderTally] [varchar](500) NULL,
	[ImportTally] [int] NULL,
	[ShippingAgentName] [nvarchar](50) NULL,
	[ShippingAgentAddress] [nvarchar](max) NULL,
 CONSTRAINT [PK_PMS_Customer] PRIMARY KEY CLUSTERED 
(
	[cust_UId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Customer_Communication]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Customer_Communication](
	[CC_Id] [nvarchar](50) NOT NULL,
	[CC_CustId] [nvarchar](50) NULL,
	[CC_CustUID] [nvarchar](50) NULL,
	[CC_Name] [nvarchar](50) NULL,
	[CC_Phone] [nvarchar](50) NULL,
	[CC_Fax] [nvarchar](150) NULL,
	[CC_Email] [nvarchar](100) NULL,
	[CC_IsDefault] [nvarchar](2) NULL,
	[CC_Designation] [nvarchar](50) NULL,
	[CC_Department] [nvarchar](50) NULL,
	[CC_Version] [nvarchar](30) NULL,
	[CC_ActiveFlag] [bit] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Customer_Communication_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [Pk_Customer_Communication] PRIMARY KEY CLUSTERED 
(
	[CC_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_CustomerDeliveryLocation]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_CustomerDeliveryLocation](
	[custLoc_Id] [nvarchar](50) NOT NULL,
	[custLoc_LocationId] [nvarchar](50) NULL,
	[custLoc_CustomerId] [nvarchar](50) NULL,
	[custLoc_CustomerUId] [nvarchar](50) NULL,
	[custLoc_Address] [nvarchar](max) NULL,
	[TIN_No] [varchar](50) NULL,
	[Cust_DeletedFlag] [char](10) NULL CONSTRAINT [DF_PMS_CustomerDeliveryLocation_Cust_DeletedFlag]  DEFAULT ('N'),
	[CustLoc_Version] [nvarchar](30) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_CustomerDeliveryLocation_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_CustomerDeliveryLocation] PRIMARY KEY CLUSTERED 
(
	[custLoc_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_CustomerShippingAgentContactDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_CustomerShippingAgentContactDetails](
	[ShippingAgentContactID] [nvarchar](50) NOT NULL,
	[CustomerID] [nvarchar](50) NULL,
	[PersonName] [nvarchar](50) NULL,
	[PositionID] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Mobile] [nvarchar](max) NULL,
	[IsDefault] [varchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_CustomerShippingAgentContactDetails] PRIMARY KEY CLUSTERED 
(
	[ShippingAgentContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_CustShipAddress]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_CustShipAddress](
	[sip_shipId] [nvarchar](50) NOT NULL,
	[sip_custId] [nvarchar](50) NULL,
	[sip_shipAddress] [nvarchar](200) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_CustShipAddress_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_CustShipAddress] PRIMARY KEY CLUSTERED 
(
	[sip_shipId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_DebitNote_Details]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_DebitNote_Details](
	[Debit_Det_ID] [nvarchar](50) NOT NULL,
	[Debit_ID] [nvarchar](50) NULL,
	[Item_ID] [int] NULL,
	[Perticulers] [nvarchar](4000) NULL,
	[DebitCredit] [nvarchar](50) NULL,
	[Debit] [float] NULL,
	[Credit] [float] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_DebitNote_Details_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[Deleted_Detail] [char](1) NULL CONSTRAINT [DF_PMS_DebitNote_Details_Deleted_Detail]  DEFAULT ('N'),
 CONSTRAINT [PK_PMS_Debit_] PRIMARY KEY CLUSTERED 
(
	[Debit_Det_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_DebitNote_Master]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_DebitNote_Master](
	[Debit_ID] [varchar](500) NOT NULL,
	[Debit_No] [varchar](500) NULL,
	[Master_CompanyID] [varchar](500) NULL,
	[DebitNote_No] [varchar](500) NULL,
	[InvoiceOrRef_No] [varchar](500) NULL,
	[Attenation] [varchar](5000) NULL,
	[Debit_CompanyID] [varchar](500) NULL,
	[Debit_Date] [datetime] NULL,
	[SalesPerson_ID] [varchar](500) NULL,
	[ChkInvoice] [int] NULL,
	[Reason] [varchar](4000) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_DebitNote_Master_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[Deleted] [char](1) NULL CONSTRAINT [DF_PMS_DebitNote_Master_Deleted]  DEFAULT ('N'),
 CONSTRAINT [PK_Debit_Note] PRIMARY KEY CLUSTERED 
(
	[Debit_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Pms_DefaultLookup]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pms_DefaultLookup](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NULL,
	[LookupTypeCode] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_Pms_DefaultLookup_CreatedOn_1]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [Pk_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_DelivetyLocations]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_DelivetyLocations](
	[delLoc_Id] [int] IDENTITY(1,1) NOT NULL,
	[delLoc_Name] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_DelivetyLocations_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_DelivetyLocations] PRIMARY KEY CLUSTERED 
(
	[delLoc_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Department]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Department](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[Dept_Name] [varchar](100) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Department_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Designation]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Designation](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[Designation] [varchar](100) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Designation_CreatedOn_1]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_Designation] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Dispatch_Partial_Part2]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Dispatch_Partial_Part2](
	[ID] [nvarchar](50) NOT NULL,
	[Part1_ID] [nvarchar](50) NULL,
	[Description] [nvarchar](255) NULL,
	[Qty_Return] [nvarchar](50) NULL,
	[Waste_Scrap_return] [nvarchar](50) NULL,
	[Waste_Scrap_nonRecoverable] [nvarchar](50) NULL,
	[Place] [nvarchar](50) NULL,
	[Place_Date] [date] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Dispatch_Partial_Part2] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Dispatch_Partial_Part3]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Dispatch_Partial_Part3](
	[ID] [nvarchar](50) NOT NULL,
	[Part1_ID] [nvarchar](50) NULL,
	[Description] [nvarchar](255) NULL,
	[ValueOfGood] [nvarchar](50) NULL,
	[Amt_Debited] [nvarchar](50) NULL,
	[Debit_EntryDate] [nvarchar](250) NULL,
	[Qty_Received] [nvarchar](50) NULL,
	[Amt_Credit_Restore] [nvarchar](50) NULL,
	[CreditEntryNo_Date] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Dispatch_Partial_Part3] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Dispatch_Partiat_Part1]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Dispatch_Partiat_Part1](
	[ID] [nvarchar](50) NOT NULL,
	[Name_Address_Comp_Supp] [nvarchar](255) NULL,
	[ECC_NO] [nvarchar](50) NULL,
	[Date] [date] NULL,
	[SrNo] [nvarchar](50) NULL,
	[Goods_Description] [nvarchar](255) NULL,
	[Qty] [nvarchar](50) NULL,
	[Value] [nvarchar](50) NULL,
	[Purpose] [nvarchar](50) NULL,
	[Name_Address_Job] [nvarchar](50) NULL,
	[Name_Address] [nvarchar](250) NULL,
	[Name_Address_JobName] [nvarchar](250) NULL,
	[Place] [nvarchar](50) NULL,
	[Place_Date] [date] NULL,
	[Status] [int] NULL CONSTRAINT [DF_PMS_Dispatch_Partiat_Part1_Status]  DEFAULT ((1)),
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Dispatch_Partiat_Part1_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL,
 CONSTRAINT [PK_PMS_Dispatch_Partiat_Part1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_DispatchProDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_DispatchProDetails](
	[dpd_Id] [varchar](20) NOT NULL,
	[dpd_WEId] [nvarchar](50) NULL,
	[dpd_FGQty] [nvarchar](10) NULL,
	[dpd_Unit] [nvarchar](50) NULL,
	[dpd_Boxes] [nvarchar](10) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_DispatchProDetails_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_DispatchProDetails_UpdatedOn]  DEFAULT (getdate()),
	[dpd_POQty] [nvarchar](50) NULL,
	[dpd_POUnit] [nvarchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_email]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_email](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[CC_Name] [varchar](max) NULL,
	[CC_Email] [varchar](max) NULL,
	[Customer_name] [varchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_email] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_EnquiryChannel]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_EnquiryChannel](
	[EnquiryChannelID] [nvarchar](50) NOT NULL,
	[EnquiryChannelName] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_EnquiryChannel] PRIMARY KEY CLUSTERED 
(
	[EnquiryChannelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_EnquiryDescription]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_EnquiryDescription](
	[EnquiryDescriptionID] [nvarchar](50) NOT NULL,
	[EnquiryID] [nvarchar](50) NULL,
	[ItemID] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[GSM] [nvarchar](50) NULL,
	[PaperMakeID] [nvarchar](50) NULL,
	[Size] [nvarchar](50) NULL,
	[ColorShadeID] [nvarchar](50) NULL,
	[Quantity] [decimal](18, 2) NULL,
	[Rate] [decimal](18, 2) NULL,
	[Details] [nvarchar](max) NULL,
	[Ply] [nvarchar](50) NULL,
	[PreviousRate] [decimal](18, 2) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_EnquiryDescription] PRIMARY KEY CLUSTERED 
(
	[EnquiryDescriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_EnquiryForm]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_EnquiryForm](
	[EnquiryID] [nvarchar](50) NOT NULL,
	[CompanyID] [nvarchar](50) NULL,
	[CustomerID] [nvarchar](50) NULL,
	[EnquiryDate] [date] NULL,
	[ExpectedClosingDate] [date] NULL,
	[EnquiryTitle] [nvarchar](max) NULL,
	[EnquiryChannelID] [nvarchar](50) NULL,
	[SalesPersonID] [nvarchar](50) NULL,
	[IsExistingCustomer] [int] NULL,
	[CustomerName] [nvarchar](50) NULL,
	[ContactPerson] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[Comments] [nvarchar](max) NULL,
	[Budget] [decimal](18, 2) NULL,
	[Currency] [nvarchar](50) NULL,
	[Probability] [decimal](18, 2) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_EnquiryForm] PRIMARY KEY CLUSTERED 
(
	[EnquiryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Excise_Master]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Excise_Master](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[Excise_Code] [varchar](50) NULL,
	[Excise_Description] [varchar](255) NULL,
	[Duty] [float] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Excise_Master_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_Excise_Master] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_ExportInvoice]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_ExportInvoice](
	[ID] [nvarchar](50) NOT NULL,
	[PackingSheetID] [nvarchar](50) NULL,
	[ExportOrderID] [nvarchar](50) NULL,
	[ExporterID] [nvarchar](50) NULL,
	[ConsigneeID] [nvarchar](50) NULL,
	[BuyerOtherID] [nvarchar](50) NULL,
	[ExporterBankID] [nvarchar](50) NULL,
	[ConsigneeBank] [nvarchar](50) NULL,
	[BuyerOrderNo] [nvarchar](50) NULL,
	[ExporterRefNo] [nvarchar](50) NULL,
	[OtherRefNo] [nvarchar](50) NULL,
	[ExportInvoiceDate] [date] NULL,
	[Total] [decimal](10, 2) NULL,
	[AdminCost] [decimal](10, 2) NULL,
	[AirFreight] [decimal](10, 2) NULL,
	[SeaFreight] [decimal](10, 2) NULL,
	[LocalCost] [decimal](10, 2) NULL,
	[BankCharges] [decimal](10, 2) NULL,
	[TotalAmount] [decimal](10, 2) NULL,
	[GrandTotalAmount] [decimal](10, 2) NULL,
	[RoundedGrandTotal] [decimal](10, 2) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_ExportInvoice] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_ExportInvoiceNotify]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_ExportInvoiceNotify](
	[ID] [nvarchar](50) NOT NULL,
	[ExportInvoiceID] [nvarchar](50) NULL,
	[NotifyPartyID] [nvarchar](50) NULL,
	[OriginCountryID] [nvarchar](50) NULL,
	[DestinationCountryID] [nvarchar](50) NULL,
	[PreCarriageID] [nvarchar](50) NULL,
	[PlaceReceiptID] [nvarchar](50) NULL,
	[VesselFINo] [nvarchar](50) NULL,
	[LoadingPortID] [nvarchar](50) NULL,
	[DischargePortID] [nvarchar](50) NULL,
	[FinalDestinationID] [nvarchar](50) NULL,
	[ContainerNo] [nvarchar](50) NULL,
	[SealNo] [nvarchar](50) NULL,
	[CreditDays] [nvarchar](50) NULL,
	[DueDate] [date] NULL,
	[ExchangeRate] [nvarchar](50) NULL,
	[TermOfDeliveryPaymentID] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_ExportInvoiceNotify] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_ExportInvoiceTaxChargesDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_ExportInvoiceTaxChargesDetails](
	[ID] [nvarchar](50) NOT NULL,
	[ExportInvoiceID] [nvarchar](50) NULL,
	[TaxOrChargesID] [nvarchar](50) NULL,
	[TaxValue] [nvarchar](50) NULL,
	[TaxOrChargesAmount] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_ExportInvoiceTaxChargesDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_ExportOrderSheet]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_ExportOrderSheet](
	[ExportOrderID] [nvarchar](50) NOT NULL,
	[ProformaInvoiceID] [nvarchar](50) NULL,
	[CustomerID] [nvarchar](50) NULL,
	[ExportOrderDate] [date] NULL,
	[OrderNo] [nvarchar](50) NULL,
	[OrderDate] [date] NULL,
	[SourceFrom] [nvarchar](50) NULL,
	[InvoiceFrom] [varchar](50) NULL,
	[ShipmentBy] [varchar](50) NULL,
	[FreightPaymentBy] [varchar](50) NULL,
	[ShippingMarks] [nvarchar](max) NULL,
	[CertificateOfOrigin] [varchar](50) NULL,
	[TestCertificate] [varchar](50) NULL,
	[ClearingAgentID] [nvarchar](50) NULL,
	[CommercialInvoice] [varchar](50) NULL,
	[ValueInCommercialInvoice] [nvarchar](50) NULL,
	[SchemeName1] [nvarchar](50) NULL,
	[SchemeType1] [nvarchar](50) NULL,
	[LicenceNumber1] [nvarchar](50) NULL,
	[OurFileNumber1] [nvarchar](50) NULL,
	[BenefitPercentage1] [decimal](10, 2) NULL,
	[SchemeName2] [nvarchar](50) NULL,
	[SchemeType2] [nvarchar](50) NULL,
	[LicenceNumber2] [nvarchar](50) NULL,
	[OurFileNumber2] [nvarchar](50) NULL,
	[BenefitPercentage2] [decimal](10, 2) NULL,
	[SchemeName3] [nvarchar](50) NULL,
	[SchemeType3] [nvarchar](50) NULL,
	[LicenceNumber3] [nvarchar](50) NULL,
	[OurFileNumber3] [nvarchar](50) NULL,
	[BenefitPercentage3] [decimal](10, 2) NULL,
	[PalatisationRequired] [varchar](50) NULL,
	[FumicationRequired] [varchar](50) NULL,
	[CartingPointID] [nvarchar](50) NULL,
	[ShippingNomination] [varchar](50) NULL,
	[ProductionEmail] [nvarchar](50) NULL,
	[ProductionContact] [nvarchar](50) NULL,
	[FinanceEmail] [nvarchar](50) NULL,
	[FinanceContact] [nvarchar](50) NULL,
	[BackOfficeEmail] [nvarchar](50) NULL,
	[PreparedBy] [nvarchar](50) NULL,
	[ApprovedBy] [nvarchar](50) NULL,
	[ProductionApprovalStatus] [int] NULL,
	[ProductionReason] [nvarchar](max) NULL,
	[FinanceApprovalStatus] [int] NULL,
	[FinanceReason] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_ExportOrderSheet_1] PRIMARY KEY CLUSTERED 
(
	[ExportOrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_ExportOrderSheet_Audit]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_ExportOrderSheet_Audit](
	[ExportOrderAuditID] [nvarchar](50) NOT NULL,
	[CustomerID] [nvarchar](50) NULL,
	[ExportOrderDate] [date] NULL,
	[OrderNo] [nvarchar](50) NULL,
	[OrderDate] [date] NULL,
	[SourceFrom] [nvarchar](50) NULL,
	[InvoiceFrom] [varchar](50) NULL,
	[ShipmentBy] [varchar](50) NULL,
	[FreightPaymentBy] [varchar](50) NULL,
	[ShippingMarks] [nvarchar](max) NULL,
	[CertificateOfOrigin] [varchar](50) NULL,
	[TestCertificate] [varchar](50) NULL,
	[ClearingAgentID] [nvarchar](50) NULL,
	[CommercialInvoice] [varchar](50) NULL,
	[ValueInCommercialInvoice] [nvarchar](50) NULL,
	[SchemeName1] [nvarchar](50) NULL,
	[SchemeType1] [nvarchar](50) NULL,
	[LicenceNumber1] [nvarchar](50) NULL,
	[OurFileNumber1] [nvarchar](50) NULL,
	[BenefitPercentage1] [decimal](10, 2) NULL,
	[SchemeName2] [nvarchar](50) NULL,
	[SchemeType2] [nvarchar](50) NULL,
	[LicenceNumber2] [nvarchar](50) NULL,
	[OurFileNumber2] [nvarchar](50) NULL,
	[BenefitPercentage2] [decimal](10, 2) NULL,
	[SchemeName3] [nvarchar](50) NULL,
	[SchemeType3] [nvarchar](50) NULL,
	[LicenceNumber3] [nvarchar](50) NULL,
	[OurFileNumber3] [nvarchar](50) NULL,
	[BenefitPercentage3] [decimal](10, 2) NULL,
	[PalatisationRequired] [varchar](50) NULL,
	[FumicationRequired] [varchar](50) NULL,
	[CartingPointID] [nvarchar](50) NULL,
	[ShippingNomination] [varchar](50) NULL,
	[ProductionEmail] [nvarchar](50) NULL,
	[ProductionContact] [nvarchar](50) NULL,
	[FinanceEmail] [nvarchar](50) NULL,
	[FinanceContact] [nvarchar](50) NULL,
	[BackOfficeEmail] [nvarchar](50) NULL,
	[PreparedBy] [nvarchar](50) NULL,
	[ApprovedBy] [nvarchar](50) NULL,
	[ProductionApprovalStatus] [int] NULL,
	[ProductionReason] [nvarchar](max) NULL,
	[FinanceApprovalStatus] [int] NULL,
	[FinanceReason] [nvarchar](max) NULL,
	[EditCount] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_ExportOrderSheetDescription]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_ExportOrderSheetDescription](
	[ExportOrderDescriptionID] [nvarchar](50) NULL,
	[ExportOrderID] [nvarchar](50) NULL,
	[JobOrderID] [nvarchar](50) NULL,
	[ProductCategoryID] [nvarchar](50) NULL,
	[ItemID] [nvarchar](50) NULL,
	[ItemSizeID] [nvarchar](50) NULL,
	[HSCode] [nvarchar](50) NULL,
	[Quantity] [decimal](10, 2) NULL,
	[Unit] [nvarchar](50) NULL,
	[Price] [decimal](10, 2) NULL,
	[Currency] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_ExportOrderSheetDescription_Audit]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_ExportOrderSheetDescription_Audit](
	[ExportOrderDescriptionAuditID] [nvarchar](50) NULL,
	[ExportOrderAuditID] [nvarchar](50) NULL,
	[JobOrderID] [nvarchar](50) NULL,
	[ProductCategoryID] [nvarchar](50) NULL,
	[ItemID] [nvarchar](50) NULL,
	[ItemSizeID] [nvarchar](50) NULL,
	[HSCode] [nvarchar](50) NULL,
	[Quantity] [decimal](10, 2) NULL,
	[Unit] [nvarchar](50) NULL,
	[Price] [decimal](10, 2) NULL,
	[Currency] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[EditCount] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_FGEntry]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_FGEntry](
	[cc_ID] [nvarchar](50) NOT NULL,
	[cc_WorkOrderId] [nvarchar](50) NULL,
	[cc_Unit] [nvarchar](50) NULL CONSTRAINT [DF_PMS_Unit]  DEFAULT (NULL),
	[cc_Boxes] [nvarchar](50) NULL CONSTRAINT [DF_PMS_CalChallan_cc_Boxes2]  DEFAULT ((0)),
	[cc_QtyProd] [nvarchar](50) NULL CONSTRAINT [DF_PMS_CalChallan_cc_QtyProd2]  DEFAULT ((0)),
	[cc_QtyDispatch] [nvarchar](50) NULL CONSTRAINT [DF_PMS_CalChallan_cc_QtyDispatch2]  DEFAULT ((0)),
	[cc_Date] [nvarchar](50) NULL,
	[cc_FGqty] [nvarchar](50) NULL CONSTRAINT [DF_PMS_CalChallan_cc_FGqty]  DEFAULT ((0)),
	[QtyinKG] [decimal](10, 2) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[FGPOQty] [nvarchar](50) NULL,
	[FGPOQty_Unit] [nvarchar](50) NULL,
 CONSTRAINT [PK_cc_ID] PRIMARY KEY CLUSTERED 
(
	[cc_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_FileTransfer]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_FileTransfer](
	[ID] [varchar](50) NOT NULL,
	[Vikhroli] [datetime] NULL CONSTRAINT [DF_PMS_FileTransfer_Vikhroli]  DEFAULT ((0)),
	[Bhiwandi] [datetime] NULL CONSTRAINT [DF_PMS_FileTransfer_Bhiwandi]  DEFAULT ((0)),
	[Cloud] [datetime] NULL CONSTRAINT [DF_PMS_FileTransfer_Cloud]  DEFAULT ((0)),
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_FileTransfer_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_FileTransfer_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_DailyFileTransfer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_GeneralMaterialAllotment]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_GeneralMaterialAllotment](
	[Material_Id] [nvarchar](50) NOT NULL,
	[RM_Cat] [nvarchar](50) NULL,
	[RM_ProdCat] [nvarchar](50) NULL,
	[RM_Item] [nvarchar](50) NULL,
	[Qty] [decimal](10, 2) NULL,
	[Unit] [nvarchar](50) NULL,
	[Machinary] [nvarchar](100) NULL,
	[PersonName] [nvarchar](50) NULL,
	[EntryDate] [date] NULL,
	[MaterialStatus] [nvarchar](10) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [date] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedDate] [date] NULL,
	[CreatedOn] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL,
 CONSTRAINT [PK_PMS_GeneralMaterialAllotment] PRIMARY KEY CLUSTERED 
(
	[Material_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_GenerateChallan]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_GenerateChallan](
	[chal_ID] [nvarchar](50) NOT NULL,
	[chal_No] [nvarchar](25) NULL,
	[chal_Date2] [nvarchar](50) NULL,
	[chal_Comment] [nvarchar](1000) NULL,
	[chal_SO_No] [nvarchar](50) NULL,
	[chal_ModeOfTrans] [nvarchar](50) NULL,
	[chal_VehlNo] [nvarchar](25) NULL,
	[chal_LrRrNo] [nvarchar](20) NULL,
	[chal_LrRrDate] [nvarchar](50) NULL,
	[chal_LrRrFileName] [nvarchar](50) NULL,
	[chal_TransName] [nvarchar](500) NULL,
	[chal_ACK_RCP_FileName] [varchar](50) NULL,
	[chal_Other_DOC_FileName] [varchar](255) NULL,
	[LR_Location] [varchar](255) NULL,
	[Ack_Location] [varchar](255) NULL,
	[Other_Location] [varchar](255) NULL,
	[Date_Removal] [date] NULL,
	[Time_Removal] [time](7) NULL,
	[Item_Description] [varchar](255) NULL,
	[ExternalDocNo] [varchar](50) NULL,
	[DeliveryLoc] [nvarchar](50) NULL,
	[Reason] [nvarchar](350) NULL,
	[flag] [int] NULL,
	[DispatchQty] [decimal](10, 2) NULL,
	[chal_Date] [date] NULL,
	[MailFlag] [char](1) NULL CONSTRAINT [DF_PMS_GenerateChallan_MailFlag]  DEFAULT ('N'),
	[SMS_Location] [nvarchar](150) NULL,
	[LR_Status] [char](1) NULL CONSTRAINT [DF_PMS_GenerateChallan_LR_Status]  DEFAULT ('N'),
	[Edit_Reason] [nvarchar](250) NULL,
	[TransportMode] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_GenerateChallan_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_GenerateChallan_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_GenerateChallan] PRIMARY KEY CLUSTERED 
(
	[chal_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_GenerateChallanDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_GenerateChallanDetails](
	[chalDet_Id] [nvarchar](50) NOT NULL,
	[chal_ID] [nvarchar](50) NULL,
	[chalDet_QtyTaken] [decimal](18, 2) NULL,
	[chalDet_JobOrderId] [nvarchar](50) NULL,
	[chalDet_WorkOrderId] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_GenerateChallanDetails_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_GenerateChallanDetails_UpdatedOn]  DEFAULT (getdate()),
	[POQty] [decimal](10, 2) NULL,
	[POUnit] [nvarchar](50) NULL,
	[chalDet_BoxTaken] [int] NULL,
 CONSTRAINT [PK_PMS_GenerateChallanDetails] PRIMARY KEY CLUSTERED 
(
	[chalDet_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[pms_GoDown]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pms_GoDown](
	[ID] [nvarchar](50) NOT NULL,
	[Godown_Id] [nvarchar](255) NULL,
	[Godown_Name] [nvarchar](255) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_pms_GoDown_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL CONSTRAINT [DF_pms_GoDown_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_Godown1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_GRNMaster]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_GRNMaster](
	[GRN_ID] [nvarchar](50) NOT NULL,
	[Inward_ID] [nvarchar](20) NULL,
	[Date] [date] NULL,
	[Time] [time](7) NULL,
	[Package_No] [nvarchar](250) NULL,
	[place] [nvarchar](50) NULL,
	[LR_No] [nvarchar](50) NULL,
	[Receiver] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_GRNMaster_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_GRNMaster] PRIMARY KEY CLUSTERED 
(
	[GRN_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Gum]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Gum](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[Gum_Name] [varchar](50) NULL,
	[Status] [char](50) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Gum_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_Gum] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Ink]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Ink](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[Ink_Name] [varchar](50) NOT NULL,
	[Status] [char](50) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Ink_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_Ink] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Ink_Mixture]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Ink_Mixture](
	[ID] [nvarchar](50) NOT NULL,
	[NewColour] [nvarchar](250) NULL,
	[status] [int] NULL CONSTRAINT [DF_PMS_Ink_Mixture_status]  DEFAULT ((1)),
	[Remark] [varchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_Ink_Mixture] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Ink_Mixture_Color]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Ink_Mixture_Color](
	[ID] [nvarchar](50) NOT NULL,
	[InkId] [nvarchar](50) NULL,
	[InkName] [nvarchar](50) NULL,
	[percentage] [decimal](18, 2) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_Ink_Mixture_Color_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_Ink_Mixture_Color_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_Ink_Mixture_Color] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Ink_Mixture_Created]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Ink_Mixture_Created](
	[ID] [nvarchar](50) NOT NULL,
	[InkMixture] [nvarchar](50) NULL,
	[Qty_Ink_Kg] [nvarchar](500) NULL,
	[InkPercentage] [nvarchar](500) NULL,
	[Job_Name] [nvarchar](500) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Ink_Mixture_Created] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_InternalRequestForm]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_InternalRequestForm](
	[RequestNumber] [nvarchar](100) NOT NULL,
	[RequestDepartment] [nvarchar](50) NULL,
	[RequiredByName] [nvarchar](50) NULL,
	[ApprovedByName] [nvarchar](50) NULL,
	[JobOrderNo] [nvarchar](100) NULL,
	[WorkOrderNo] [nvarchar](100) NULL,
	[MachineNo] [nvarchar](100) NULL,
	[RequestDate] [datetime] NULL,
	[RMCategory] [nvarchar](50) NULL,
	[RMProductCategory] [nvarchar](50) NULL,
	[RMProductSubCategory] [nvarchar](50) NULL,
	[RequiredQuantity] [decimal](13, 2) NULL,
	[UnitForQuantity] [nvarchar](50) NULL,
	[RequestStatus] [int] NULL,
	[Remark] [nvarchar](300) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_InternalRequestForm] PRIMARY KEY CLUSTERED 
(
	[RequestNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Inventory]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Inventory](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[RM_Category] [nvarchar](50) NULL,
	[RM_Product_Category] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[Total] [varchar](50) NULL,
	[Total_Unit] [varchar](50) NULL,
	[Threshold] [varchar](50) NULL,
	[Threshold_Unit] [varchar](50) NULL,
	[Quantity] [varchar](50) NULL,
	[Quantity_Unit] [varchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Inventory_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_Inventory1] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Invoice_Details]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Invoice_Details](
	[Invoice_Det_Id] [nvarchar](50) NOT NULL,
	[Invoice_ID] [nvarchar](500) NULL,
	[Item_Id] [int] NULL,
	[Item_Desc] [nvarchar](max) NULL,
	[Qty] [float] NULL,
	[Disc] [float] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[Amount] [float] NULL,
	[Tarrif_HSN] [nvarchar](max) NULL,
	[Rate] [float] NULL,
	[Per] [nvarchar](500) NULL,
	[Deleted_Detail] [char](1) NULL CONSTRAINT [DF_PMS_Invoice_Details_Deleted_Detail]  DEFAULT ('N'),
	[WorkOrderID] [nvarchar](500) NULL,
	[Product_Desc] [nvarchar](max) NULL,
	[Item_Code] [nvarchar](max) NULL,
 CONSTRAINT [PK_PMS_Invoice_Details] PRIMARY KEY CLUSTERED 
(
	[Invoice_Det_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Invoice_Details_Audit]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Invoice_Details_Audit](
	[Invoice_Det_Id] [nvarchar](50) NOT NULL,
	[Invoice_ID] [nvarchar](500) NULL,
	[Item_Id] [int] NULL,
	[Item_Desc] [nvarchar](max) NULL,
	[Qty] [float] NULL,
	[Disc] [float] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[Amount] [float] NULL,
	[Tarrif_HSN] [nvarchar](max) NULL,
	[Rate] [float] NULL,
	[Per] [nvarchar](500) NULL,
	[Deleted_Detail] [char](1) NULL CONSTRAINT [DF_PMS_Invoice_Details_Audit_Deleted_Detail]  DEFAULT ('N'),
	[WorkOrderID] [nvarchar](500) NULL,
	[Product_Desc] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Invoice_Master]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Invoice_Master](
	[Invoice_ID] [nvarchar](300) NOT NULL,
	[Invoice_No] [nvarchar](500) NULL,
	[Invoice_Date] [nvarchar](500) NULL,
	[Dispatch_Through] [nvarchar](500) NULL,
	[Destination] [nvarchar](500) NULL,
	[moter_VehicleNo] [nvarchar](500) NULL,
	[Removal_Date] [nvarchar](500) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[Challan_ID] [nvarchar](50) NULL,
	[IssueinvoiceDate] [nvarchar](50) NULL,
	[TotalAmount] [float] NULL,
	[Customer] [nvarchar](500) NULL,
	[Buyer] [nvarchar](500) NULL,
	[flag] [char](1) NULL,
	[Mode_Of_Payment] [nvarchar](max) NULL,
	[Other_Reference] [nvarchar](max) NULL,
	[Terms_Of_Delivery] [nvarchar](max) NULL,
	[Invoice_Trans_Option] [nvarchar](500) NULL,
	[Invoice_Trans_Location] [nvarchar](500) NULL,
	[Invoice_TrCat] [nvarchar](500) NULL,
	[OctroiCharges] [decimal](10, 2) NULL,
	[OtherCharges] [decimal](10, 2) NULL,
	[FreightCharges] [decimal](10, 2) NULL,
	[BankCharges] [decimal](10, 2) NULL,
	[Bank_ID] [nvarchar](500) NULL,
	[Account_No] [nvarchar](500) NULL,
	[deleted] [char](1) NULL CONSTRAINT [DF_PMS_Invoice_Master_deleted]  DEFAULT ('N'),
	[SupplierRefNo] [nvarchar](max) NULL,
	[BuyerOrdNo] [nvarchar](max) NULL,
	[BuyerDate] [nvarchar](500) NULL,
	[DispatchDocNo] [nvarchar](max) NULL,
	[DispatchDate] [nvarchar](500) NULL,
	[GrandTotal] [float] NULL,
	[ChkCommercial] [int] NULL,
	[chkFreight] [int] NULL,
	[chkBank] [int] NULL,
	[chkOctroi] [int] NULL,
	[chkOtherCharges] [int] NULL,
	[chkInsurance] [int] NULL,
	[chkLoadingPacking] [int] NULL,
	[InsuranceCharges] [decimal](10, 2) NULL,
	[LoadingPackingCharges] [decimal](10, 2) NULL,
	[chkroundoff] [int] NULL,
	[chkEffectedWO] [int] NULL,
	[AdminCharges] [float] NULL,
 CONSTRAINT [PK_PMS_Invoice_Master] PRIMARY KEY CLUSTERED 
(
	[Invoice_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Invoice_Master_Audit]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Invoice_Master_Audit](
	[Invoice_ID] [nvarchar](300) NOT NULL,
	[Invoice_No] [nvarchar](500) NULL,
	[Invoice_Date] [nvarchar](500) NULL,
	[Dispatch_Through] [nvarchar](500) NULL,
	[Destination] [nvarchar](500) NULL,
	[moter_VehicleNo] [nvarchar](500) NULL,
	[Removal_Date] [nvarchar](500) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[Challan_ID] [nvarchar](50) NULL,
	[IssueinvoiceDate] [nvarchar](50) NULL,
	[TotalAmount] [float] NULL,
	[Customer] [nvarchar](500) NULL,
	[Buyer] [nvarchar](500) NULL,
	[flag] [char](1) NULL,
	[Mode_Of_Payment] [nvarchar](max) NULL,
	[Other_Reference] [nvarchar](max) NULL,
	[Terms_Of_Delivery] [nvarchar](max) NULL,
	[Invoice_Trans_Option] [nvarchar](500) NULL,
	[Invoice_Trans_Location] [nvarchar](500) NULL,
	[Invoice_TrCat] [nvarchar](500) NULL,
	[OctroiCharges] [decimal](10, 2) NULL,
	[OtherCharges] [decimal](10, 2) NULL,
	[FreightCharges] [decimal](10, 2) NULL,
	[BankCharges] [decimal](10, 2) NULL,
	[Bank_ID] [nvarchar](500) NULL,
	[Account_No] [nvarchar](500) NULL,
	[deleted] [char](1) NULL CONSTRAINT [DF_PMS_Invoice_Master_Audit_deleted]  DEFAULT ('N'),
	[SupplierRefNo] [nvarchar](max) NULL,
	[BuyerOrdNo] [nvarchar](max) NULL,
	[BuyerDate] [nvarchar](500) NULL,
	[DispatchDocNo] [nvarchar](max) NULL,
	[DispatchDate] [nvarchar](500) NULL,
	[GrandTotal] [float] NULL,
	[ChkCommercial] [int] NULL,
	[chkFreight] [int] NULL,
	[chkBank] [int] NULL,
	[chkOctroi] [int] NULL,
	[chkOtherCharges] [int] NULL,
	[chkroundoff] [int] NULL,
	[chkEffectedWO] [int] NULL,
	[AdminCharges] [float] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_InwardDocuments]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_InwardDocuments](
	[ID] [nvarchar](20) NOT NULL,
	[Inward_ID] [nvarchar](20) NULL,
	[Doc_Name] [nvarchar](max) NULL,
	[Doc_Loc] [nvarchar](max) NULL,
	[Doc_Type] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_InwardDocuments_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_InwardDocuments_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_InwardDoc_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_InwardMaster]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_InwardMaster](
	[ID] [nvarchar](20) NOT NULL,
	[Supplier_Id] [varchar](20) NULL,
	[Challan_No] [nvarchar](25) NULL,
	[PO_No] [nvarchar](25) NULL,
	[PO_Date] [date] NULL,
	[Receiver_Name] [nvarchar](50) NULL,
	[Cost_Center] [int] NULL,
	[Inward_Date] [date] NULL,
	[status] [int] NULL CONSTRAINT [DF_Inward_Status]  DEFAULT ('1'),
	[Supplier] [nvarchar](max) NULL,
	[Trans_Courier_Name] [nvarchar](250) NULL,
	[Invoice_No] [nvarchar](50) NULL,
	[Invoice_Date] [date] NULL,
	[Gate_entry_date] [date] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_InwardMaster_CreatedOn_1]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[Gate_entry_No] [nvarchar](50) NULL,
	[StockType] [nvarchar](50) NULL CONSTRAINT [DF_PMS_InwardMaster_StockType]  DEFAULT ((1)),
 CONSTRAINT [PK_InwardID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_InwardMaterial]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_InwardMaterial](
	[ID] [nvarchar](20) NOT NULL,
	[Inward_ID] [nvarchar](20) NULL,
	[RM_Cat] [nvarchar](50) NULL,
	[RM_Prod_Cat] [nvarchar](50) NULL,
	[Material] [nvarchar](50) NULL,
	[Unit] [nvarchar](50) NULL,
	[Unit_Price] [decimal](10, 2) NULL,
	[Quantity] [decimal](10, 3) NULL,
	[Total] [decimal](18, 2) NULL,
	[CurrentQty] [nvarchar](15) NULL,
	[GRNQty] [decimal](10, 2) NULL,
	[GRN_QC] [varchar](10) NULL,
	[GRN_QCRemarks] [nvarchar](255) NULL,
	[GRN_LRNo] [nvarchar](100) NULL,
	[GRN_Receiver] [nvarchar](50) NULL,
	[InventoryStatus] [int] NULL CONSTRAINT [DF_PMS_InwardMaterial_InventoryStatus_1]  DEFAULT ((1)),
	[Status] [int] NULL CONSTRAINT [DF_PMS_InwardMaterial_Status]  DEFAULT ('1'),
	[ItemDescription] [nvarchar](max) NULL,
	[Barcode_ID] [nvarchar](50) NULL,
	[QuanChngDesc] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_InwardMaterial_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_Mat_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_JobCard_History]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_JobCard_History](
	[Id] [nvarchar](50) NOT NULL,
	[Auto_Id] [nvarchar](50) NULL,
	[Normal_Text] [varchar](max) NULL,
	[JobCard_Paper] [varchar](max) NULL,
	[Perforation] [varchar](max) NULL,
	[Updated_Date] [datetime] NOT NULL,
	[Specification_Details] [varchar](max) NULL,
	[Pre_Press_PritingUPS] [varchar](max) NULL,
	[Colour_Details] [varchar](max) NULL,
	[Press_PaperDetails] [varchar](max) NULL,
	[Press_InkDetails] [varchar](max) NULL,
	[Press_Spare] [varchar](max) NULL,
	[Press_CoatingDetails] [varchar](max) NULL,
	[PostPress_Details] [varchar](max) NULL,
	[PostPress_Packaging] [varchar](max) NULL,
	[Process_Selec_PrePress] [varchar](max) NULL,
	[Process_Selec_Press] [varchar](max) NULL,
	[Process_Selec_Post_Press] [varchar](max) NULL,
	[Material_Requirement] [varchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_History_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_History_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_JobCard_History1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_JobCard_Mac_CoatingDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_JobCard_Mac_CoatingDetails](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[Printing] [varchar](50) NULL,
	[Coating] [varchar](50) NULL,
	[JobCard_Id] [nvarchar](50) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_Mac_CoatingDetails_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_Mac_CoatingDetails_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_JobCard_Mac_CoatingDetails1] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_JobCard_Machines]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_JobCard_Machines](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[JobCart_Id] [nvarchar](50) NULL,
	[Machines] [varchar](1000) NULL,
	[Status] [char](5) NOT NULL CONSTRAINT [DF_PMS_JobCard_Machines1_Status]  DEFAULT ('I'),
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_Machines_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_Machines_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_JobCard_Machines1] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_JobCard_Machines_InkDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_JobCard_Machines_InkDetails](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[JobCart_Id] [nvarchar](50) NULL,
	[JobCart_Machine_Id] [nvarchar](50) NULL,
	[Ink_Color] [varchar](255) NULL,
	[Ink_Shade] [varchar](100) NULL,
	[Ink_Company] [varchar](100) NULL,
	[Ink_Quantity] [varchar](100) NULL,
	[Status] [char](5) NULL CONSTRAINT [DF_PMS_JobCard_Machines_InkDetails1_Status]  DEFAULT ('I'),
	[Ink_Units] [varchar](255) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_Machines_InkDetails_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_Machines_InkDetails_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_JobCard_Machines_InkDetails1] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_JobCard_Machines_PaperDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_JobCard_Machines_PaperDetails](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[JobCart_Machine_Id] [nvarchar](50) NULL,
	[Thick_Proposed] [varchar](100) NULL,
	[Proposed_GSM_Make] [nvarchar](50) NULL,
	[Thick_Actual] [varchar](100) NULL,
	[Actual_GSM_Make] [varchar](100) NULL,
	[Status] [char](5) NULL CONSTRAINT [DF_PMS_JobCard_Machines_PaperDetails1_Status]  DEFAULT ('I'),
	[JobCart_Id] [nvarchar](50) NULL,
	[Units] [varchar](50) NULL,
	[Quantity] [varchar](50) NULL,
	[Papers] [varchar](255) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_Machines_PaperDetails_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_Machines_PaperDetails_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_JobCard_Machines_PaperDetails1] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_JobCard_Machines_Spares]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_JobCard_Machines_Spares](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[JobCart_Machine_Id] [nvarchar](50) NULL,
	[Spare] [nvarchar](50) NULL,
	[Quantity] [varchar](100) NULL,
	[Status] [char](5) NULL CONSTRAINT [DF_PMS_JobCard_Machines_Spares1_Status]  DEFAULT ('I'),
	[jobcart_Id] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_Machines_Spares_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_Machines_Spares_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_JobCard_Machines_Spares1] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_JobCard_Material_Requirement]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_JobCard_Material_Requirement](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[RM_Category] [nvarchar](50) NULL,
	[RM_Product_Category] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NULL,
	[Quantity] [varchar](250) NULL,
	[Pcs] [varchar](250) NULL,
	[job_Card_id] [nvarchar](50) NULL,
	[Material_Units] [nvarchar](50) NULL,
	[wastage] [decimal](18, 0) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_Material_Requirement_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_Material_Requirement_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_JobCard_Material_Requirement1] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_JobCard_Paper]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_JobCard_Paper](
	[Auto_Id] [varchar](50) NOT NULL,
	[JobCart_Id] [nvarchar](50) NULL,
	[Paper_Thickness] [varchar](10) NOT NULL,
	[Paper_Make] [varchar](100) NULL,
	[Print_Color_Front] [varchar](100) NOT NULL,
	[Print_Color_Back] [varchar](100) NOT NULL,
	[Copy_Mark] [varchar](100) NOT NULL,
	[Status] [char](5) NOT NULL CONSTRAINT [DF_PMS_JobCard_Paper2_Status]  DEFAULT ('I'),
	[Color_Shade] [varchar](100) NULL,
	[Remark] [varchar](100) NULL,
	[Front_Coating] [varchar](10) NULL,
	[Back_Coating] [varchar](10) NULL,
	[CoatingSide] [nvarchar](10) NULL,
	[NonCoatingSide] [nvarchar](10) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_Paper_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_Paper_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_JobCard_Paper2] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_JobCard_Perforation_Details]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_JobCard_Perforation_Details](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[JobCart_Id] [nvarchar](50) NOT NULL,
	[Perforation] [varchar](5) NULL,
	[Position] [varchar](100) NULL,
	[Direction] [varchar](100) NULL,
	[Status] [char](5) NULL CONSTRAINT [DF_PMS_JobCard_Perforation_Details1_Status]  DEFAULT ('I'),
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_Perforation_Details_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_Perforation_Details_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_JobCard_Perforation_Details1] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_JobCard_PostPress]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_JobCard_PostPress](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[JobCart_Id] [nvarchar](50) NOT NULL,
	[Carboning] [varchar](10) NULL,
	[Size_Width] [varchar](10) NULL,
	[Numbering_Box] [varchar](100) NULL,
	[Numbering_Style] [varchar](50) NULL,
	[Numbering_Machine] [varchar](150) NULL,
	[Numbering_Skip] [varchar](100) NULL,
	[Numbering_Orientation] [varchar](10) NULL,
	[Gum_Position] [varchar](100) NULL,
	[Gum_GumMake] [varchar](50) NULL,
	[Gum_Quantity] [varchar](100) NULL,
	[Status] [char](5) NULL CONSTRAINT [DF_PMS_JobCard_PostPress1_Status]  DEFAULT ('I'),
	[Size_Type] [varchar](10) NULL,
	[Numbering_Sequence] [varchar](50) NULL,
	[Carboning_on_Ply] [varchar](100) NULL,
	[Gumming_on_Ply] [varchar](100) NULL,
	[hotspot_Width] [varchar](100) NULL,
	[hotspot_Height] [varchar](100) NULL,
	[Cutting_Width] [varchar](100) NULL,
	[Cutting_Width_Units] [nvarchar](50) NULL,
	[Cutting_Length] [varchar](100) NULL,
	[Cutting_Length_Units] [nvarchar](50) NULL,
	[Cutting_Diameter] [varchar](100) NULL,
	[Barcode_Type] [varchar](255) NULL,
	[Barcode_Height] [varchar](50) NULL,
	[Barcode_Weight] [varchar](50) NULL,
	[Barcode_Orientation] [varchar](50) NULL,
	[Barcode_text] [varchar](20) NULL,
	[HotSpotCarbonPly] [varchar](50) NULL,
	[BabyRoll_Coating] [varchar](50) NULL,
	[Carbon_Option] [varchar](100) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_PostPress_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_PostPress_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_JobCard_PostPress1] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_JobCard_PostPress_Packaging1]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_JobCard_PostPress_Packaging1](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[PostPress_Id] [nvarchar](50) NULL,
	[Pack_Pcs1] [varchar](50) NULL,
	[Pack_Items1] [varchar](100) NULL,
	[Length] [varchar](50) NULL,
	[Length_Units] [varchar](50) NULL,
	[Width] [varchar](50) NULL,
	[Width_Units] [varchar](50) NULL,
	[Heigth] [varchar](50) NULL,
	[Heigth_Units] [varchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_PostPress_Packaging1_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_PostPress_Packaging1_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_JobCard_PostPress_Packaging2] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_JobCard_PrePress]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_JobCard_PrePress](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[JobCart_Id] [nvarchar](50) NOT NULL,
	[Printing_Columns] [int] NULL,
	[Printing_Rows] [int] NULL,
	[Plates_length] [nvarchar](50) NULL,
	[Plates_Width] [nvarchar](50) NULL,
	[Plates_Thickness] [varchar](5) NULL,
	[Status] [char](5) NULL CONSTRAINT [DF_PMS_JobCard_PrePress1_Status]  DEFAULT ('I'),
	[Plates_length_Units] [nvarchar](50) NULL,
	[Plates_Width_Units] [nvarchar](50) NULL,
	[Plates_Thickness_Units] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_PrePress_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_PrePress_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_JobCard_PrePress1] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_JobCard_PrePress_PrintingPlates]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_JobCard_PrePress_PrintingPlates](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[PrePress_Id] [nvarchar](50) NOT NULL,
	[Color] [nvarchar](50) NULL,
	[Film_Type] [varchar](50) NULL,
	[Ply] [varchar](100) NULL,
	[Plate_Type] [varchar](100) NULL,
	[Status] [char](5) NULL CONSTRAINT [DF_PMS_JobCard_PrePress_PrintingPlates1_Status]  DEFAULT ('I'),
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_PrePress_PrintingPlates_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_PrePress_PrintingPlates_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_JobCard_PrePress_PrintingPlates1] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_JobCard_ProcessSelection]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_JobCard_ProcessSelection](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[JobCart_Id] [nvarchar](50) NULL,
	[Process] [nvarchar](50) NULL,
	[Category_Id] [varchar](100) NULL,
	[Status] [char](5) NULL CONSTRAINT [DF_PMS_JobCard_ProcessSelection1_Status]  DEFAULT ('I'),
	[Machines] [nvarchar](50) NULL,
	[add_Machines] [nvarchar](50) NULL,
	[QC] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_ProcessSelection_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_ProcessSelection_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_JobCard_ProcessSelection1] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_JobCard_SpecificDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_JobCard_SpecificDetails](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[JobCart_Id] [nvarchar](50) NULL,
	[jobcart_Prod_Type] [varchar](100) NULL,
	[Coating_Side] [varchar](100) NULL,
	[Core_Side_Diameter] [varchar](10) NULL,
	[Core_Side_Width] [varchar](10) NULL,
	[Printing_Side] [varchar](100) NULL,
	[Cutting_Machine] [nvarchar](50) NULL,
	[CF_Patch] [varchar](10) NULL,
	[CB_patch] [varchar](10) NULL,
	[Coalating] [varchar](10) NULL,
	[Smoothing] [varchar](10) NULL,
	[Tearing] [varchar](10) NULL,
	[Gathering] [varchar](10) NULL,
	[Cutting] [varchar](10) NULL,
	[Binding] [varchar](255) NULL,
	[No_Leaves] [varchar](100) NULL,
	[Record_Slip] [bit] NULL,
	[Requisition_Slip] [bit] NULL,
	[No_Cover] [varchar](10) NULL,
	[Status] [char](5) NULL CONSTRAINT [DF_PMS_JobCard_SpecificDetails1_Status]  DEFAULT ('I'),
	[microline] [bit] NULL,
	[invisble] [bit] NULL,
	[void_pantography] [bit] NULL,
	[invisible_numbering] [bit] NULL,
	[foiling_foil_stamping] [bit] NULL,
	[heat_resistance] [bit] NULL,
	[guiloche_design] [bit] NULL,
	[raised_image] [bit] NULL,
	[fugitive_ink] [bit] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_SpecificDetails_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_SpecificDetails_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_JobCard_SpecificDetails1] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_JobCard_UploadFile]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_JobCard_UploadFile](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[JobCart_Id] [nvarchar](50) NOT NULL,
	[Upload_File] [varchar](100) NOT NULL,
	[File_Title] [varchar](150) NOT NULL,
	[Status] [char](5) NULL CONSTRAINT [DF_PMS_JobCard_UploadFile1_Status]  DEFAULT ('I'),
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_UploadFile_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_JobCard_UploadFile_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_JobCard_UploadFile1] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_JobOrder]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_JobOrder](
	[ID] [nvarchar](50) NOT NULL,
	[Order_Id] [varchar](150) NULL,
	[Order_Name] [varchar](255) NULL,
	[jobcart_Prod_Cat] [varchar](50) NULL,
	[jobcart_Width] [varchar](50) NULL,
	[jobcart_Height] [varchar](50) NULL,
	[jobart_Parts] [varchar](5) NULL,
	[jobcart_Prod_Type] [varchar](255) NULL,
	[Special_Instructions] [varchar](max) NULL,
	[jobcart_Heights_Unit] [nvarchar](50) NULL,
	[JobCart_Company_Name] [varchar](255) NULL,
	[jobcart_Width_Unit] [nvarchar](50) NULL,
	[Item_Type] [varchar](100) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_JobOrder_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[Jobcard_runningMeter] [nvarchar](50) NULL,
	[Jobcard_PrintWidth] [nvarchar](50) NULL,
	[ProductNameCustomer] [nvarchar](500) NULL,
 CONSTRAINT [PK_PMS_MasterJobCart2] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [OrderId] UNIQUE NONCLUSTERED 
(
	[Order_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_JobOrder_Old]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_JobOrder_Old](
	[ID] [int] NOT NULL,
	[Order_Id] [nvarchar](255) NULL,
	[Order_Name] [nvarchar](40) NULL,
	[Client_Name] [nvarchar](40) NULL,
	[End_Date] [datetime] NULL,
	[Start_Date] [datetime] NULL,
	[Location] [int] NULL,
	[Address] [nvarchar](255) NULL,
	[StartDate_Type] [nvarchar](255) NULL,
	[Order_ProductImage] [nvarchar](max) NULL,
	[Specification] [nvarchar](255) NULL,
	[FGSpecification] [nvarchar](255) NULL,
	[Labeling] [nvarchar](255) NULL,
	[Packaging] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_JobOrderDesign]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_JobOrderDesign](
	[jd_Id] [nvarchar](50) NOT NULL,
	[jd_JobOrderId] [nvarchar](50) NOT NULL,
	[jd_DesignId] [nvarchar](50) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_JobOrderDesign_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_JobOrderDesign_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_JobOrderDesign] PRIMARY KEY CLUSTERED 
(
	[jd_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_JobOrderProcesses]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_JobOrderProcesses](
	[Id] [nvarchar](50) NOT NULL,
	[joborder_Id] [nvarchar](50) NOT NULL,
	[joborder_Process] [nvarchar](50) NULL,
	[joborder_Qc] [nvarchar](50) NULL,
	[joborder_Bom] [nvarchar](50) NULL,
	[joborder_Spares] [nvarchar](50) NULL,
	[joborder_SpInstruction] [nvarchar](50) NULL,
	[joborder_Images] [nvarchar](500) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_JobOrderProcesses_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_JobOrderProcesses_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_JobOrderProcesses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_JobProcessImages]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_JobProcessImages](
	[Id] [nvarchar](50) NOT NULL,
	[JobProcess_Id] [nvarchar](50) NULL,
	[JobProcess_Images] [nvarchar](500) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_JobProcessImages_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_JobProcessImages_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_JobProcessImages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_LicenceSchemeMaster]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_LicenceSchemeMaster](
	[LicenceID] [nvarchar](50) NOT NULL,
	[LicenceNumber] [nvarchar](50) NULL,
	[OurFileNumber] [nvarchar](50) NULL,
	[SchemeName] [nvarchar](50) NULL,
	[MotherCompanyID] [nvarchar](50) NULL,
	[SchemeType] [nvarchar](50) NULL,
	[Status] [nchar](10) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_LicenceSchemeMaster] PRIMARY KEY CLUSTERED 
(
	[LicenceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Login]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Login](
	[ID] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Username] [nvarchar](255) NULL,
	[Password] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL,
	[Type] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_Login_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_Login_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_Login] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_MachinenMaintenance]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_MachinenMaintenance](
	[mm_Id] [nvarchar](50) NOT NULL,
	[mm_MaintTitle] [nvarchar](100) NULL,
	[mm_Machine] [nvarchar](50) NULL,
	[mm_MainCompDet] [nvarchar](max) NULL,
	[mm_MainSolnTaken] [nvarchar](max) NULL,
	[mm_Operators] [nvarchar](50) NULL,
	[mm_EntryDate2] [nvarchar](20) NULL,
	[mm_TimeStamp] [datetime] NULL,
	[mm_ExternalPerson] [nvarchar](50) NULL,
	[mm_WorkType] [nvarchar](50) NULL,
	[mm_MaintType] [nvarchar](20) NULL,
	[mm_MaintTypeFrom] [nvarchar](20) NULL,
	[mm_MaintTypeTo] [nvarchar](20) NULL,
	[mm_EntryDate] [date] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_MachinenMaintenance_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[mm_SparePart] [nvarchar](50) NULL,
 CONSTRAINT [PK_MachinenMaintenance3] PRIMARY KEY CLUSTERED 
(
	[mm_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Machines]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Machines](
	[ID] [nvarchar](50) NOT NULL,
	[UniqueID] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[Category] [nvarchar](50) NULL,
	[Site] [nvarchar](50) NULL,
	[Capacity] [float] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Machines_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_Machines] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_MasterInvoiceTax]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_MasterInvoiceTax](
	[wstax_Id] [nvarchar](100) NOT NULL,
	[wstax_Name] [nvarchar](500) NULL,
	[InvoiceId] [nvarchar](500) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_MasterInvoiceTax_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_MasterInvoiceTax_UpdatedOn]  DEFAULT (getdate())
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_MasterJCProcess_Press]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_MasterJCProcess_Press](
	[Press_ID] [nvarchar](50) NOT NULL,
	[Press_JCProcessID] [nvarchar](50) NULL,
	[Press_PaperGSM] [nvarchar](50) NULL,
	[Press_NoOfColours] [int] NULL,
	[Press_FrontSideColour] [nvarchar](100) NULL,
	[Press_ScreenRainbowIN] [nvarchar](50) NULL,
	[Press_CopyMarkPostn] [nvarchar](50) NULL,
	[Press_BackSite] [nvarchar](20) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_MasterJCProcess_Press_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_MasterJCProcess_Press_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PressID] PRIMARY KEY CLUSTERED 
(
	[Press_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_MasterJobCart_Process]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_MasterJobCart_Process](
	[proc_ID] [nvarchar](50) NOT NULL,
	[proc_JobCart_Id] [nvarchar](50) NULL,
	[proc_Description] [nvarchar](500) NULL,
	[proc_Details] [nvarchar](500) NULL,
	[proc_Main_Id] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_MasterJobCart_Process_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_MasterJobCart_Process_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_ProcID] PRIMARY KEY CLUSTERED 
(
	[proc_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_MasterProduct]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_MasterProduct](
	[prod_Id] [int] IDENTITY(1,1) NOT NULL,
	[prod_cat] [int] NULL,
	[prod_Title] [nvarchar](50) NULL,
	[prod_Excise_Head] [nvarchar](50) NULL,
	[prod_Excise_Percentage] [varchar](5) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_MasterProduct_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_MasterProduct_UpdatedOn]  DEFAULT (getdate())
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_MasterProduct_Process]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_MasterProduct_Process](
	[proc_ID] [int] IDENTITY(1,1) NOT NULL,
	[proc_Prod_Id] [int] NULL,
	[proc_ProcessId] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_MasterProduct_Process_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_MasterProduct_Process_UpdatedOn]  DEFAULT (getdate())
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_MasterSalesWorkOrderTax]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_MasterSalesWorkOrderTax](
	[wstax_Id] [nvarchar](50) NOT NULL,
	[wstax_Name] [nvarchar](50) NULL,
	[wstax_WorkSaleOrderId] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_MasterSalesWorkOrderTax_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [Pk_MasterSalesWorkOrderTax1] PRIMARY KEY CLUSTERED 
(
	[wstax_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_MasterTax]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_MasterTax](
	[tax_Id] [nvarchar](50) NOT NULL,
	[tax_Name] [nvarchar](50) NULL,
	[tax_Value] [nvarchar](50) NULL,
	[Other_tax_Name] [varchar](50) NULL,
	[Base_tax_Check] [varchar](10) NULL,
	[FlatRate] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_MasterTax_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_MasterTax_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_MasterTax] PRIMARY KEY CLUSTERED 
(
	[tax_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_MasterTaxStructure]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_MasterTaxStructure](
	[taxStr_Id] [nvarchar](50) NOT NULL,
	[taxStr_Name] [nvarchar](50) NULL,
	[flag] [int] NULL CONSTRAINT [DF_PMS_MasterTaxStructure_flag]  DEFAULT ((1)),
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_MasterTaxStructure_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_MasterTaxStructure_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_MasterTaxStructure2] PRIMARY KEY CLUSTERED 
(
	[taxStr_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_MasterTaxStructureDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_MasterTaxStructureDetails](
	[taxStrDet_Id] [nvarchar](50) NOT NULL,
	[taxStrDet_taxSrtId] [nvarchar](50) NULL,
	[taxStr_Name] [varchar](10) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_MasterTaxStructureDetails_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_MasterTaxStructureDetails_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_MasterTaxStructureDetails] PRIMARY KEY CLUSTERED 
(
	[taxStrDet_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_MasterTransport]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_MasterTransport](
	[trans_Id] [nvarchar](50) NOT NULL,
	[trans_Address] [nvarchar](500) NULL,
	[trans_Phone_No] [nvarchar](100) NULL,
	[trans_Name] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_MasterTransport_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_MasterTransport] PRIMARY KEY CLUSTERED 
(
	[trans_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_MasterTransportLocation]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_MasterTransportLocation](
	[transLoc_Id] [nvarchar](50) NOT NULL,
	[transLoc_Location] [int] NULL,
	[transLoc_transpoter] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_MasterTransportLocation_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_MasterTransportLocation] PRIMARY KEY CLUSTERED 
(
	[transLoc_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_MasterWorkSalesOrder]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_MasterWorkSalesOrder](
	[work_ID] [int] IDENTITY(1,1) NOT NULL,
	[work_WorkOrder_No] [nvarchar](50) NULL,
	[work_Cust_Id] [nvarchar](50) NULL,
	[work_Trans_Option] [int] NULL,
	[work_Trans_Location] [int] NULL,
	[work_Delivery_Location] [int] NULL,
	[work_Trans_DebitNote] [nchar](10) NULL,
	[work_Delivery_Date] [nvarchar](50) NULL,
	[work_Promice_Date] [nvarchar](50) NULL,
	[work_po_date] [nvarchar](50) NULL,
	[work_po_no] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_MasterWorkSalesOrder_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_MasterWorkSalesOrder_UpdatedOn]  DEFAULT (getdate())
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_MasterWorkSalesOrderDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_MasterWorkSalesOrderDetails](
	[workDet_Id] [nvarchar](50) NOT NULL,
	[workDet_SalesWorkOrderID] [nvarchar](50) NULL,
	[workDet_JobCartId] [nvarchar](50) NULL,
	[workDet_Qty] [nvarchar](10) NULL,
	[workDet_Unit] [nvarchar](50) NULL,
	[workDet_No_From] [int] NOT NULL,
	[workDet_No_To] [int] NULL,
	[workDet_LBL_Desc] [nvarchar](500) NULL,
	[workDet_CompName] [nvarchar](50) NULL,
	[workDet_PrintFor] [nvarchar](50) NULL,
	[workDet_Item] [nvarchar](50) NULL,
	[workDet_InlineText] [nvarchar](50) NULL,
	[workDet_SpcInst] [nvarchar](250) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_MasterWorkSalesOrderDetails_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_MasterWorkSalesOrderDetails_UpdatedOn]  DEFAULT (getdate())
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_MaterialRateMaster]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_MaterialRateMaster](
	[ID] [nvarchar](50) NOT NULL,
	[MaterialCategory] [nvarchar](50) NULL,
	[CategoryType] [nvarchar](50) NULL,
	[GSM] [nvarchar](50) NULL,
	[Rate] [decimal](10, 2) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_MaterialRateMaster] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_NewEmails_Config]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_NewEmails_Config](
	[Auto_Id] [nvarchar](500) NULL,
	[Bind] [varchar](500) NULL,
	[Mail] [varchar](500) NULL,
	[Identity_Type] [varchar](5000) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_NewEmails_Config_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_OfficeWorkEntry]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_OfficeWorkEntry](
	[Auto_Id] [varchar](50) NOT NULL,
	[Date] [datetime] NULL,
	[Task_Details] [varchar](max) NULL,
	[From_Time] [time](7) NULL,
	[To_Time] [time](7) NULL,
	[Result] [varchar](100) NULL,
	[Current_Status] [varchar](100) NULL,
	[Task_Id] [varchar](20) NULL,
	[EntryBy] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_OfficeWorkEntry_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [Pk1_Auto_Id] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_OfficeWorkTask]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_OfficeWorkTask](
	[Auto_Id] [varchar](20) NOT NULL,
	[Customer] [nvarchar](50) NULL,
	[Activity] [nvarchar](50) NULL,
	[Job_Card] [nvarchar](50) NULL,
	[Work_Order] [nvarchar](50) NULL,
	[Date] [datetime] NULL,
	[Description] [varchar](max) NULL,
	[Is_Assigned] [bit] NULL,
	[Completed] [varchar](5) NULL,
	[BWF_Id] [varchar](15) NULL,
	[Position_Id] [nvarchar](50) NULL,
	[Assigned_To] [int] NULL,
	[ExpectedEndDate] [date] NULL,
	[Priority] [int] NULL,
	[status] [int] NULL,
	[type] [int] NULL,
	[UserID] [nvarchar](50) NULL,
	[ActualDateOfCompletion] [date] NULL,
	[WorkFlowEntryId] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_OfficeWorkTask_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_OfficeWorkTask_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [Pk_AutoId] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Outward]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Outward](
	[Id] [nvarchar](50) NOT NULL,
	[Buyer_Name] [nvarchar](50) NULL,
	[Sold_By] [nvarchar](50) NULL,
	[Date] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_Outward_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_Outward_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_Outward] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_OutwardDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_OutwardDetails](
	[Id] [nvarchar](50) NOT NULL,
	[Outward_Id] [nvarchar](50) NULL,
	[Item] [nvarchar](50) NULL,
	[Quantity] [nvarchar](50) NULL,
	[Rate] [nvarchar](50) NULL,
	[Total] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_OutwardDetails_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_OutwardDetails_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_OutwardDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Paper]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Paper](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[Paper_Name] [varchar](50) NULL,
	[Status] [char](50) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Paper_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_Paper] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Paper_Color_Shade]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Paper_Color_Shade](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[Paper_Color_Shade] [varchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Paper_Color_Shade_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_Paper_Color_Shade] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_PaymentDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_PaymentDetails](
	[ID] [nvarchar](50) NOT NULL,
	[BankName] [nvarchar](50) NULL,
	[BankAcNo] [nvarchar](50) NULL,
	[Date] [nvarchar](50) NULL,
	[Amount] [decimal](10, 4) NULL,
	[PartyName] [nvarchar](50) NULL,
	[Remarks] [nvarchar](max) NULL,
	[InvoiceNo] [nvarchar](max) NULL,
	[Banklbl] [nvarchar](50) NULL,
	[Branchlbl] [nvarchar](50) NULL,
	[IFSC] [nvarchar](50) NULL,
	[AcNo] [nvarchar](50) NULL,
	[Address] [nvarchar](max) NULL,
	[PayRefNo] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [nvarchar](50) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [nvarchar](50) NULL,
	[flag] [int] NULL,
 CONSTRAINT [PK_PMS_PaymentDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Permissions]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Permissions](
	[page_id] [int] IDENTITY(1,1) NOT NULL,
	[type] [varchar](50) NULL,
	[pagename] [varchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Plan_Work_Order1]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Plan_Work_Order1](
	[Auto_Id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[WorkOrder_Id] [varchar](50) NULL,
	[User_Name] [varchar](500) NULL,
	[Start_Date] [datetime] NULL,
	[End_Date] [datetime] NULL,
	[Instructions] [varchar](max) NULL,
	[process] [varchar](150) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_Plan_Work_Order1_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_Plan_Work_Order1_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_Plan_Work_Order] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_PO_Details]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_PO_Details](
	[PO_Det_ID] [nvarchar](50) NOT NULL,
	[PO_ID] [nvarchar](50) NULL,
	[Item_ID] [int] NULL,
	[Item_Desc] [nvarchar](max) NULL,
	[RMCategory_ID] [nvarchar](500) NULL,
	[ProductCategary_ID] [nvarchar](500) NULL,
	[Material_ID] [nvarchar](500) NULL,
	[Product_Desc] [nvarchar](max) NULL,
	[Qty] [int] NULL,
	[Rate] [float] NULL,
	[Per] [nvarchar](500) NULL,
	[Disc] [float] NULL,
	[Amount] [float] NULL,
	[Deleted_Details] [char](1) NULL CONSTRAINT [DF_PMS_PO_Details_Deleted]  DEFAULT ('N'),
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_PO_Details_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_PO_Details] PRIMARY KEY CLUSTERED 
(
	[PO_Det_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_PO_Master]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_PO_Master](
	[PO_ID] [nvarchar](50) NOT NULL,
	[Order_Number] [nvarchar](500) NULL,
	[PO_Number] [nvarchar](500) NULL,
	[Party_ID] [nvarchar](50) NULL,
	[PO_Date] [datetime] NULL,
	[Current_Balance] [float] NULL,
	[Company_ID] [varchar](50) NULL,
	[TotalAmt] [float] NULL,
	[GrandTotal] [float] NULL,
	[ChkTaxDet] [int] NULL CONSTRAINT [DF_PMS_PO_Master_ChkTaxDet]  DEFAULT ((0)),
	[dispatch_through] [nvarchar](4000) NULL,
	[Destination] [nvarchar](4000) NULL,
	[TermsOfDelivery] [nvarchar](4000) NULL,
	[ModeTermsOfPaymnet] [nvarchar](4000) NULL,
	[Other_Reference] [nvarchar](4000) NULL,
	[ExtraChrg_flag] [int] NULL CONSTRAINT [DF_PMS_PO_Master_ExtraChrg_flag]  DEFAULT ((0)),
	[Deleted] [char](1) NULL CONSTRAINT [DF_PMS_PO_Master_Deleted]  DEFAULT ('N'),
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_PO_Master_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[ChkCust] [int] NULL,
	[DiscountOnAmount] [float] NULL,
	[DiscountOnPer] [float] NULL,
	[chkDiscountOnAmount] [int] NULL CONSTRAINT [DF_PMS_PO_Master_chkDiscountOnAmount]  DEFAULT ((0)),
 CONSTRAINT [PK_PMS_PO_Master] PRIMARY KEY CLUSTERED 
(
	[PO_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Port]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Port](
	[ID] [nvarchar](50) NOT NULL,
	[PortName] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL,
 CONSTRAINT [PK_PMS_Port] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Position]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Position](
	[ID] [nvarchar](50) NOT NULL,
	[Position] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_Position_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_Position_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_Position] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_PoTaxDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_PoTaxDetails](
	[Po_Tax_ID] [varchar](50) NOT NULL,
	[PO_ID] [varchar](50) NULL,
	[Item_Tax_ID] [int] NULL,
	[Tax_ID] [varchar](50) NULL,
	[Tax_Value] [float] NULL,
	[TaxAmount] [float] NULL,
	[ChkInclude_Tax] [int] NULL CONSTRAINT [DF_PMS_PoTaxDetails_ChkInclude_Tax_1]  DEFAULT ((0)),
	[ExtraChrg] [int] NULL CONSTRAINT [DF_PMS_PoTaxDetails_ExtraChrg]  DEFAULT ((0)),
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_PoTaxDetails_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_PoTaxDetails] PRIMARY KEY CLUSTERED 
(
	[Po_Tax_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Pms_PriviledgeMaster]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pms_PriviledgeMaster](
	[Id] [nvarchar](50) NOT NULL,
	[Prilviledge_Name] [varchar](100) NULL,
	[Priviledge_Page] [varchar](100) NULL,
	[group_name] [nvarchar](100) NULL,
	[Parent_Id] [varchar](500) NULL,
	[MenuName] [varchar](500) NULL,
	[IsMenu] [char](1) NULL CONSTRAINT [DF_Pms_PriviledgeMaster_IsMenu]  DEFAULT ('N'),
	[Level1] [int] NULL,
	[Level2] [int] NULL,
	[Level3] [int] NULL,
	[IsFinal] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_Pms_PriviledgeMaster_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_Pms_PriviledgeMaster_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [Pk_PriviledgeMasterid] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Pms_PriviledgeRoleDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pms_PriviledgeRoleDetails](
	[Id] [nvarchar](50) NOT NULL,
	[RoleId] [nvarchar](50) NOT NULL,
	[PriviledgeID] [nvarchar](50) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_Pms_PriviledgeRoleDetails_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_Pms_PriviledgeRoleDetails_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [Pk_PriviledgeRoleDetailsid] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_ProcessCategory]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_ProcessCategory](
	[id] [nvarchar](50) NOT NULL,
	[Process_Category] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_ProcessCategory_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_ProcessCategory_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_ProcessCategory2] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Processes]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Processes](
	[ID] [nvarchar](50) NOT NULL,
	[ProcessID] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Category] [nvarchar](50) NULL,
	[Image] [nvarchar](500) NULL,
	[Is_Fixed] [nvarchar](10) NULL,
	[Process_Days] [varchar](10) NULL,
	[Image1] [nvarchar](500) NULL,
	[Image2] [nvarchar](500) NULL,
	[FixedCost] [decimal](10, 2) NULL CONSTRAINT [DF_PMS_Processes_FixedCost]  DEFAULT ((0)),
	[RunningCost] [decimal](10, 2) NULL CONSTRAINT [DF_PMS_Processes_RunningCost]  DEFAULT ((0)),
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Processes_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_Processes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Product]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Product](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[Product_Category] [nvarchar](50) NULL,
	[Product_Type] [varchar](200) NULL,
	[Status] [char](5) NOT NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Product_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_Product2] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_ProductMaster]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_ProductMaster](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[prod_cat] [nvarchar](255) NULL,
	[HS_Code] [nvarchar](50) NULL,
	[Excise_Code_Id] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_ProductMaster_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_ProductMaster1] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_ProductMaster_ProcessSelection]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_ProductMaster_ProcessSelection](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[ProductMaster_Id] [nvarchar](50) NULL,
	[Process] [nvarchar](50) NULL,
	[Category_Id] [varchar](100) NULL,
	[Status] [char](5) NULL CONSTRAINT [DF_PMS_ProductMaster_ProcessSelection_Status]  DEFAULT ('I'),
	[Machines] [nvarchar](50) NULL,
	[add_Machines] [nvarchar](50) NULL,
	[QC] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_ProductMaster_ProcessSelection_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_ProductMaster_ProcessSelection_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_ProductMaster_ProcessSelection] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_ProductSizeMaster]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_ProductSizeMaster](
	[ProductSizeID] [nvarchar](50) NOT NULL,
	[ProductSizeName] [nvarchar](50) NULL,
	[ProductItemCode] [nvarchar](50) NULL,
	[ProductCategoryID] [nvarchar](50) NULL,
	[ProductItemID] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_ProductSizeMaster] PRIMARY KEY CLUSTERED 
(
	[ProductSizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Proforma]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Proforma](
	[ID] [nvarchar](50) NOT NULL,
	[InvoiceNo] [nvarchar](50) NULL,
	[Consignee] [nvarchar](600) NULL,
	[DeliveryAddress] [nvarchar](600) NULL,
	[PONo] [nvarchar](50) NULL,
	[PODate] [datetime] NULL,
	[Supplier] [nvarchar](50) NULL,
	[QuotDate] [datetime] NULL,
	[DispatchThrough] [nvarchar](100) NULL,
	[SalesPerson] [nvarchar](50) NULL,
	[Taxes] [nvarchar](max) NULL,
	[TaxesAmount] [decimal](18, 2) NULL,
	[Total] [decimal](18, 2) NULL,
	[TotalAmount] [decimal](18, 2) NULL,
	[RoundedTotal] [decimal](18, 2) NULL,
	[TermsofPayment] [nvarchar](max) NULL,
	[TermsofDelivery] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[Oversis_Air] [decimal](18, 2) NULL,
	[Oversis_C] [decimal](18, 2) NULL,
	[Oversis_AdminCost] [decimal](18, 2) NULL,
	[Oversis_BankCharges] [decimal](18, 2) NULL,
	[Local_Transport] [decimal](18, 2) NULL,
	[Transport_ToPay] [int] NULL,
	[Consigner] [nvarchar](600) NULL,
	[Company_Bank] [nvarchar](600) NULL,
	[CorrBank_Name] [nvarchar](600) NULL,
	[Corr_AccountNo] [nvarchar](50) NULL,
	[Location] [nvarchar](100) NULL,
	[Swift_Bic_Code] [nvarchar](50) NULL,
	[Currency] [nvarchar](20) NULL,
	[ProformaType] [int] NULL,
	[Status] [int] NULL,
	[BuyerOtherConsignee] [nvarchar](50) NULL,
	[NotifyParty] [nvarchar](50) NULL,
	[CountryOfOrigin] [nvarchar](50) NULL,
	[CountryOfDestination] [nvarchar](50) NULL,
	[PreCarriageBy] [nvarchar](50) NULL,
	[PlaceOfReceipt] [nvarchar](50) NULL,
	[Vessel_FI_No] [nvarchar](50) NULL,
	[PortOfLanding] [nvarchar](50) NULL,
	[PortOfDischarge] [nvarchar](50) NULL,
	[FinalDestination] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_Proforma] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Proforma_Description]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Proforma_Description](
	[ID] [nvarchar](50) NOT NULL,
	[Proforma_ID] [nvarchar](50) NOT NULL,
	[widthofColumn] [nvarchar](300) NULL,
	[Proforma_1] [nvarchar](max) NULL,
	[Proforma_2] [nvarchar](max) NULL,
	[Proforma_3] [nvarchar](max) NULL,
	[Proforma_4] [nvarchar](max) NULL,
	[Proforma_5] [nvarchar](max) NULL,
	[Proforma_6] [nvarchar](max) NULL,
	[Proforma_7] [nvarchar](max) NULL,
	[Proforma_8] [nvarchar](max) NULL,
	[Proforma_9] [nvarchar](max) NULL,
	[Proforma_10] [nvarchar](max) NULL,
 CONSTRAINT [PK_PMS_Proforma_Description] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_ProformaInvoiceDescription]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_ProformaInvoiceDescription](
	[ID] [nvarchar](50) NOT NULL,
	[ProformaInvoiceID] [nvarchar](50) NULL,
	[ExportOrderID] [nvarchar](50) NULL,
	[ProductCategoryID] [nvarchar](50) NULL,
	[ItemID] [nvarchar](50) NULL,
	[ItemSizeID] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[HSCode] [nvarchar](50) NULL,
	[Quantity] [decimal](10, 2) NULL,
	[Price] [decimal](10, 2) NULL,
	[Unit] [nvarchar](50) NULL,
	[Amount] [decimal](10, 3) NULL,
	[JobOrderID] [nvarchar](50) NULL,
	[Currency] [nvarchar](50) NULL,
	[PackingDimension] [nvarchar](50) NULL,
	[PackingPerBox] [int] NULL,
	[BoxPerCarton] [int] NULL,
	[NetWtPerCarton] [decimal](10, 2) NULL,
	[GrossWtPerCarton] [decimal](10, 2) NULL,
	[TotalNetWt] [decimal](10, 2) NULL,
	[TotalGrossWt] [decimal](10, 2) NULL,
	[MarksAndNumbers] [nvarchar](50) NULL,
	[NumbersAndKindPackaging] [nvarchar](50) NULL,
	[ExportPreInvoiceID] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_ProjectClosureDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_ProjectClosureDetails](
	[Id] [nvarchar](50) NOT NULL,
	[Project_ClosureID] [nvarchar](50) NULL,
	[Ref_Doc_Name] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_ProjectClosureDetails_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_ProjectClosureDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_ProjectDocDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_ProjectDocDetails](
	[ID] [nvarchar](50) NOT NULL,
	[Project_Id] [nvarchar](50) NULL,
	[File_Name] [nvarchar](150) NULL,
	[File_Path] [nvarchar](250) NULL,
	[FileTitle] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_ProjectDocDetails_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_ProjectDocDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_ProjectDocument]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_ProjectDocument](
	[Id] [nvarchar](50) NOT NULL,
	[Project_Name] [nvarchar](50) NULL,
	[Customer_Name] [nvarchar](50) NULL,
	[TypeOfCust] [int] NULL,
	[Type] [nvarchar](50) NULL,
	[Amount] [nvarchar](50) NULL,
	[Tender_fee] [nvarchar](50) NULL,
	[DateOf_Upload] [date] NULL,
	[Remark] [nvarchar](150) NULL,
	[Uploaded_By] [nvarchar](50) NULL,
	[Project_Remark] [nvarchar](250) NULL,
	[Project_Closure] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_ProjectDocument_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_ProjectDocument] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Pms_PurchaseRequestForm]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pms_PurchaseRequestForm](
	[RequestNumber] [nvarchar](100) NOT NULL,
	[RequestDepartment] [nvarchar](50) NULL,
	[RequestDate] [datetime] NULL,
	[BrandName] [varchar](100) NULL,
	[ClientId] [nvarchar](50) NULL,
	[Remarks] [nvarchar](300) NULL,
	[RequesterSignature] [varchar](100) NULL,
	[RequesterName] [nvarchar](50) NULL,
	[CostCenter] [int] NULL,
	[Purpose] [int] NULL,
	[EntryDate] [datetime] NULL,
	[RMProductCategory] [nvarchar](50) NULL,
	[RMCategory] [nvarchar](50) NULL,
	[RMProductSubCategory] [nvarchar](50) NULL,
	[RequiredQuantity] [decimal](13, 2) NULL,
	[UnitForRequiredQuantity] [nvarchar](50) NULL,
	[Status] [int] NULL,
	[ApprovalStatus] [int] NULL CONSTRAINT [DF_Pms_PurchaseRequestForm_ApprovalStatus]  DEFAULT ((0)),
	[PONo] [nvarchar](50) NULL,
	[PODate] [datetime] NULL,
	[Supplier] [nvarchar](50) NULL,
	[Reason] [nvarchar](200) NULL,
	[PricePerUnit] [decimal](18, 0) NULL,
	[Qty] [decimal](18, 0) NULL,
	[Inventory_Remark] [nvarchar](200) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_Pms_PurchaseRequestForm_CreatedOn_1]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [Pk_PurchaseRequestForm] PRIMARY KEY CLUSTERED 
(
	[RequestNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_QcChkPoints]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_QcChkPoints](
	[qcChk_Id] [nvarchar](50) NOT NULL,
	[qcChk_Name] [nvarchar](150) NULL,
	[qcChk_ProcessId] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_QcChkPoints_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_QcChkPoints1] PRIMARY KEY CLUSTERED 
(
	[qcChk_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_QueryTest]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_QueryTest](
	[Auto_Id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Type] [varchar](50) NULL,
	[Value] [ntext] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_QueryTest_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_QueryTest_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_QueryTest] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Quotation_Description]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Quotation_Description](
	[ID] [nvarchar](50) NOT NULL,
	[Quot_ID] [nvarchar](50) NULL,
	[widthofColumn] [nvarchar](300) NULL,
	[Quot_1] [nvarchar](max) NULL,
	[Quot_2] [nvarchar](max) NULL,
	[Quot_3] [nvarchar](max) NULL,
	[Quot_4] [nvarchar](max) NULL,
	[Quot_5] [nvarchar](max) NULL,
	[Quot_6] [nvarchar](max) NULL,
	[Quot_7] [nvarchar](max) NULL,
	[Quot_8] [nvarchar](max) NULL,
	[Quot_9] [nvarchar](max) NULL,
	[Quot_10] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_Quotation_Description_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_Quotation_Description_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_Quotation_Description] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Quotation_Master]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Quotation_Master](
	[ID] [nvarchar](50) NOT NULL,
	[RefIDNum] [nvarchar](50) NULL,
	[Reference_ID] [nvarchar](50) NULL,
	[Address] [nvarchar](max) NULL,
	[AttentionOf] [nvarchar](50) NULL,
	[QuotDate] [nvarchar](50) NULL,
	[Subject] [nvarchar](200) NULL,
	[Refrence] [nvarchar](200) NULL,
	[Rows] [nvarchar](50) NULL CONSTRAINT [DF_PMS_Quotation_Master_Rows]  DEFAULT (NULL),
	[Excise] [nvarchar](max) NULL,
	[Taxes] [nvarchar](max) NULL,
	[LBT] [nvarchar](max) NULL,
	[DischargePoint] [nvarchar](300) NULL,
	[BankCharge] [nvarchar](300) NULL,
	[SamplingCharges] [nvarchar](300) NULL,
	[LCHandling] [nvarchar](300) NULL,
	[CancellationCharges] [nvarchar](300) NULL,
	[DeliveryPoint] [nvarchar](300) NULL,
	[OtherCharges] [nvarchar](300) NULL,
	[TDS] [nvarchar](300) NULL,
	[Packing] [nvarchar](300) NULL,
	[StatutoryClause] [nvarchar](300) NULL,
	[Delivery] [nvarchar](max) NULL,
	[Payment] [nvarchar](max) NULL,
	[Freight] [nvarchar](max) NULL,
	[Validity] [nvarchar](max) NULL,
	[Jurisdiction] [nvarchar](max) NULL,
	[Prices] [nvarchar](max) NULL,
	[Documents] [nvarchar](max) NULL,
	[Columns] [nvarchar](50) NULL,
	[Note] [nvarchar](max) NULL,
	[SalesPerson] [nvarchar](200) NULL,
	[SPDD] [nvarchar](50) NULL,
	[InstallationCharges] [nvarchar](300) NULL,
	[Warranty] [nvarchar](300) NULL,
	[Training] [nvarchar](300) NULL,
	[QuotationType] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Quotation_Master] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Rate]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Rate](
	[Id] [nvarchar](50) NOT NULL,
	[Buyer] [nvarchar](50) NULL,
	[Item] [nvarchar](50) NULL,
	[Unit] [nvarchar](50) NULL,
	[Rate] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Rate_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Rate] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_RawMaterial]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_RawMaterial](
	[ID] [nvarchar](50) NOT NULL,
	[RMID] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Field1] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[Unit] [nvarchar](50) NULL,
	[RM_Cat] [nvarchar](50) NULL,
	[Product_Cat] [nvarchar](50) NULL,
	[Opening_Balance] [decimal](10, 2) NULL,
	[HS_Code] [nvarchar](50) NULL,
	[Status_Flag] [bit] NULL,
	[mat_height] [nvarchar](50) NULL,
	[mat_height_unit] [nvarchar](50) NULL,
	[mat_width] [nvarchar](50) NULL,
	[mat_width_unit] [nvarchar](50) NULL,
	[mat_length] [nvarchar](50) NULL,
	[mat_length_unit] [nvarchar](50) NULL,
	[mat_thickness] [nvarchar](50) NULL,
	[mat_thickness_unit] [nvarchar](50) NULL,
	[mat_GSM] [nvarchar](50) NULL,
	[mat_carbon] [nvarchar](50) NULL,
	[mat_color] [nvarchar](50) NULL,
	[mat_part] [nvarchar](50) NULL,
	[mat_make] [nvarchar](200) NULL,
	[mat_special] [nvarchar](200) NULL,
	[mat_diameter] [nvarchar](50) NULL,
	[mat_diameter_unit] [nvarchar](50) NULL,
	[mat_type] [nvarchar](50) NULL,
	[mat_HS_Code] [nvarchar](50) NULL,
	[mat_Format] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_RawMaterial_New] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_RawMaterial_backup]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_RawMaterial_backup](
	[ID] [nvarchar](50) NOT NULL,
	[RMID] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Field1] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[Unit] [nvarchar](50) NULL,
	[RM_Cat] [nvarchar](50) NULL,
	[Product_Cat] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_RawMaterial_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_RawMaterial1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_RawMaterialParameterDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_RawMaterialParameterDetails](
	[ID] [nvarchar](50) NOT NULL,
	[RawMaterialID] [nvarchar](50) NULL,
	[StoreID] [nvarchar](50) NULL,
	[RMAllotementID] [nvarchar](50) NULL,
	[ReelNo] [nvarchar](50) NULL,
	[Weight] [nvarchar](50) NULL,
	[GSM] [nvarchar](50) NULL,
	[Size] [nvarchar](50) NULL,
	[Return_Qty] [decimal](10, 2) NULL CONSTRAINT [DF_PMS_RawMaterialParameterDetails_Return_Qty]  DEFAULT ((0)),
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_RawMaterialParameterDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_RecruitmentDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_RecruitmentDetails](
	[ID] [nvarchar](50) NOT NULL,
	[Rec_Name] [nvarchar](50) NOT NULL,
	[Rec_Address] [nvarchar](max) NULL,
	[Rec_Contact] [nvarchar](15) NULL,
	[Rec_Refrence] [nvarchar](40) NULL,
	[Rec_InterviewDate] [date] NULL,
	[Rec_Department] [nvarchar](50) NULL,
	[Rec_Position] [nvarchar](50) NULL,
	[Rec_CunductedBy] [nvarchar](150) NULL,
	[Rec_Status] [nvarchar](10) NOT NULL,
	[Rec_Reason] [nvarchar](max) NULL,
	[Rec_JoiningDate] [date] NULL,
	[Rec_Remark] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_RecruitmentDetails_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[Download] [nvarchar](150) NULL,
 CONSTRAINT [PK_PMS_RecruitmentDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Reference_Document]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Reference_Document](
	[Id] [nvarchar](50) NOT NULL,
	[document_name] [nvarchar](500) NULL,
	[uploaded_on] [datetime] NULL,
	[with_effect_from] [date] NULL,
	[file_name] [nvarchar](500) NULL,
	[file_path] [nvarchar](150) NULL,
	[Doc_FileType] [nvarchar](10) NULL,
	[Doc_DeptUse] [nvarchar](10) NULL,
	[Doc_Author] [nvarchar](10) NULL,
	[Doc_TypeOfDoc] [nvarchar](10) NULL,
	[Doc_Version] [nvarchar](max) NULL,
	[Doc_Keyword] [nvarchar](max) NULL,
	[Doc_DownloadCount] [int] NULL CONSTRAINT [DF_PMS_Reference_Document_Count]  DEFAULT ('0'),
	[Doc_CompBrnd] [int] NULL,
	[Doc_PrintPaper] [int] NULL,
	[Doc_PrintPaperSize] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_Reference_Document_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_Reference_Document_UpdatedOn]  DEFAULT (getdate()),
	[RoleId] [varchar](max) NULL,
 CONSTRAINT [PK_PMS_Reference_Document] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_ReqstModule_Details]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_ReqstModule_Details](
	[FileDetails_Id] [nvarchar](50) NOT NULL,
	[Request_ID] [nvarchar](50) NULL,
	[FileTittle] [nvarchar](150) NULL,
	[FileName] [nvarchar](250) NULL,
	[FilePath] [nvarchar](450) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_ReqstModule_Details] PRIMARY KEY CLUSTERED 
(
	[FileDetails_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_RM_Parameters]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_RM_Parameters](
	[ID] [nvarchar](50) NOT NULL,
	[Para_ID] [nvarchar](50) NULL,
	[Para_Name] [nvarchar](255) NULL,
	[Prod_Cat] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_RM_Parameters_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_RM_Parameters1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_RMAllotementForStore]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_RMAllotementForStore](
	[ID] [nvarchar](50) NOT NULL,
	[Store_ID] [nvarchar](50) NULL,
	[RM_Category] [nvarchar](50) NULL,
	[RM_ProductCat] [nvarchar](50) NULL,
	[RM_Resource] [nvarchar](50) NULL,
	[Qty_Issue] [nvarchar](50) NULL,
	[Unit] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_RMAllotementForStore] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Pms_RoleMaster]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pms_RoleMaster](
	[Id] [nvarchar](50) NOT NULL,
	[RoleName] [varchar](100) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_Pms_RoleMaster_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [Pk_RoleMasterid] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_SalesReport_Config]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_SalesReport_Config](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[SalesPersonName] [nvarchar](50) NULL,
	[SalesCo_Name] [nvarchar](50) NULL,
	[Sales_Email] [nvarchar](50) NULL,
	[Co_Email] [nvarchar](50) NULL,
	[CreatedOn] [datetime2](7) NULL CONSTRAINT [DF_PMS_SalesReport_Config_CreatedOn]  DEFAULT (getdate()),
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime2](7) NULL,
 CONSTRAINT [PK_PMS_SalesReport_Config] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Shift_Category_Master]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Shift_Category_Master](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[Shift_Category] [varchar](150) NULL,
	[Set_Default] [bit] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_Shift_Category_Master_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_Shift_Category_Master_UpdatedOn]  DEFAULT (getdate())
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Shift_Master1]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Shift_Master1](
	[Auto_Id] [numeric](18, 0) NOT NULL,
	[Shift_Category_Id] [varchar](150) NULL,
	[Shift_Name] [varchar](255) NULL,
	[Time_From] [time](7) NULL,
	[Time_To] [time](7) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Shift_Master1_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Sites]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Sites](
	[ID] [nvarchar](50) NOT NULL,
	[SiteID] [nvarchar](255) NULL,
	[Site] [nvarchar](255) NULL,
	[Name] [nvarchar](50) NULL,
	[Address] [nvarchar](255) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Sites_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_Sites] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_SMS_Config]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_SMS_Config](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[ModuleName] [nvarchar](50) NULL,
	[MblNo] [nvarchar](10) NULL,
	[SiteName] [nvarchar](20) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_SMS_Config_CreatedOn]  DEFAULT (getdate()),
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_SMS_Config] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_SMS_SendingStatus]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_SMS_SendingStatus](
	[sms_Id] [int] IDENTITY(1,1) NOT NULL,
	[sms_WorkEntry_Id] [nvarchar](50) NULL,
	[sms_AlertType] [nvarchar](12) NULL,
	[sms_RecName] [nvarchar](200) NULL,
	[sms_RecNo] [nvarchar](100) NULL,
	[sms_Mesg] [nvarchar](500) NULL,
	[sms_Status] [nvarchar](15) NULL,
	[sms_CompleteStatus] [nvarchar](60) NULL,
	[sms_TimeStamp] [nvarchar](25) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_SMS_SendingStatus_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_SpareParts]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_SpareParts](
	[sp_Id] [nvarchar](50) NOT NULL,
	[sp_Name] [nvarchar](50) NULL,
	[Unit] [nvarchar](50) NULL,
	[Type] [varchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_SpareParts_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_SpareParts] PRIMARY KEY CLUSTERED 
(
	[sp_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_State]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_State](
	[State_Id] [nvarchar](50) NOT NULL,
	[State_Name] [nvarchar](50) NULL,
	[State_Code] [nvarchar](50) NULL,
	[country_Id] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_State_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_State_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_State2] PRIMARY KEY CLUSTERED 
(
	[State_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Stock]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Stock](
	[RMID] [nvarchar](50) NOT NULL,
	[InStock] [float] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Stock_Transactions]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Stock_Transactions](
	[ST_ID] [nvarchar](50) NOT NULL,
	[Inward_Id] [nvarchar](50) NULL,
	[StoreID] [nvarchar](50) NULL,
	[JobCard] [nvarchar](150) NULL,
	[WorkOrder] [nvarchar](150) NULL,
	[RM_ID] [nvarchar](50) NULL,
	[Type] [varchar](30) NULL,
	[Unit] [nvarchar](50) NULL,
	[CurrentStock] [decimal](10, 2) NULL,
	[IssueQty] [decimal](10, 2) NULL,
	[BalanceQty] [decimal](10, 2) NULL,
	[Inw_Date] [nvarchar](50) NULL,
	[Ow_Date] [nvarchar](50) NULL,
	[AllotedBy] [nvarchar](350) NULL,
	[CreatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Stock_Transactions] PRIMARY KEY CLUSTERED 
(
	[ST_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Stock1]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Stock1](
	[RMID] [nvarchar](50) NOT NULL,
	[InStock] [float] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_StockInventory]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_StockInventory](
	[ID] [nvarchar](25) NOT NULL,
	[StoreMatID] [nvarchar](50) NULL,
	[StoreID] [nvarchar](50) NULL,
	[InwardID] [nvarchar](20) NULL,
	[QtyBfrAssign] [nvarchar](50) NULL,
	[QtyAssign] [nvarchar](50) NULL,
	[QtyRemain] [nvarchar](50) NULL,
	[QtyReturn] [nvarchar](50) NULL,
	[ReturnBy] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_StockInventory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Store_Master]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Store_Master](
	[Auto_Id] [nvarchar](50) NOT NULL,
	[jobCard_Id] [nvarchar](50) NULL,
	[WorkOrder_Id] [nvarchar](50) NULL,
	[Customer_id] [nvarchar](50) NULL,
	[RM_Id] [nvarchar](50) NULL,
	[Quantity_Req] [varchar](50) NULL,
	[Status] [varchar](50) NULL,
	[Qty_available] [varchar](50) NULL,
	[Units] [nvarchar](50) NULL,
	[Qty_Alloted] [varchar](50) NULL,
	[Alloted_Unit] [nvarchar](50) NULL,
	[IssueDate] [date] NULL,
	[Qty_Return] [decimal](10, 2) NULL CONSTRAINT [DF_PMS_Store_Master_Qty_Return]  DEFAULT ((0)),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_StoreRawMaterial]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_StoreRawMaterial](
	[Auto_ID] [nvarchar](50) NOT NULL,
	[Store_ID] [nvarchar](50) NOT NULL,
	[RM_Category] [nvarchar](50) NULL,
	[RM_ProductCat] [nvarchar](50) NULL,
	[RM_Resource] [nvarchar](50) NULL,
	[Unit] [nvarchar](50) NULL,
	[Qty_Issue] [decimal](10, 2) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_StoreRawMaterial_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_StoreRawMaterial_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_AutoID_StoreRawMaterial] PRIMARY KEY CLUSTERED 
(
	[Auto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_StoreRawMaterial_Parameters]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_StoreRawMaterial_Parameters](
	[Auto_ID] [nvarchar](50) NOT NULL,
	[StoreRM_ID] [nvarchar](50) NOT NULL,
	[ParametersName] [varchar](50) NULL,
	[Parameters_Value] [varchar](100) NULL,
	[RM_ProductCat] [nvarchar](50) NULL,
	[StoreJCID] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_StoreRawMaterial_Parameters_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_StoreRawMaterial_Parameters_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_AutoID_StoreRMPara] PRIMARY KEY CLUSTERED 
(
	[Auto_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_SupervisorQcEntry]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_SupervisorQcEntry](
	[sq_Id] [nvarchar](50) NOT NULL,
	[sq_WorkOrder] [nvarchar](50) NULL,
	[sq_JobOrder] [nvarchar](50) NULL,
	[sq_Process] [nvarchar](50) NULL,
	[sq_Machine] [nvarchar](50) NULL,
	[sq_QcRemark] [nvarchar](500) NULL,
	[Operator] [varchar](150) NULL,
	[Helper] [varchar](150) NULL,
	[Assistant] [varchar](150) NULL,
	[Entry_Date] [datetime] NULL,
	[QC_Result] [varchar](50) NULL,
	[Location] [nvarchar](50) NULL,
	[Supervisor_Name] [varchar](255) NULL,
	[QC_Type] [varchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_SupervisorQcEntry_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_SupervisorQcEntry] PRIMARY KEY CLUSTERED 
(
	[sq_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_SupplierBankDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_SupplierBankDetails](
	[Supplier_UID] [varchar](20) NULL,
	[BankID] [varchar](50) NOT NULL,
	[VAT] [varchar](50) NULL,
	[TIN] [varchar](50) NULL,
	[PAN] [varchar](50) NULL,
	[BankName] [varchar](500) NULL,
	[BranchName] [varchar](100) NULL,
	[BankAcNo] [nvarchar](50) NULL,
	[IFSCCode] [varchar](50) NULL,
	[MICRCode] [varchar](50) NULL,
	[ECC_No] [varchar](50) NULL,
	[flag] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_SupplierBankDetails_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_SupplierBankDetails] PRIMARY KEY CLUSTERED 
(
	[BankID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_SupplierCategory]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_SupplierCategory](
	[Auto_Id] [int] IDENTITY(1,1) NOT NULL,
	[Supplier_UID] [varchar](20) NULL,
	[ProductCategory] [varchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_SupplierCategory_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_SupplierCategory_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_SupplierCategory] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_SupplierContactPerson]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_SupplierContactPerson](
	[supplier_UID] [varchar](20) NOT NULL,
	[ContactPersonID] [varchar](20) NOT NULL,
	[ContPerson] [varchar](100) NULL,
	[EmailId] [varchar](100) NULL,
	[MobileNo] [bigint] NULL,
	[FaxNo] [varchar](20) NULL,
	[LandlineNo] [bigint] NULL,
	[Designation] [varchar](50) NULL,
	[Department] [varchar](50) NULL,
	[Is_Default] [varchar](10) NULL,
	[PORaise] [varchar](10) NULL,
	[flag] [varchar](10) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_SupplierContactPerson_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_SupplierContactPerson] PRIMARY KEY CLUSTERED 
(
	[ContactPersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_SupplierMaster]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_SupplierMaster](
	[Supplier_UID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierCode] [varchar](20) NOT NULL,
	[SupplierName] [varchar](255) NULL,
	[BlacklistType] [int] NULL,
	[BlacklistedDate] [datetime] NULL,
	[BlacklistReason] [varchar](255) NULL,
	[CostCenter] [varchar](20) NULL,
	[SupplierType] [varchar](20) NULL,
	[SupplierLocation] [int] NULL,
	[VAT] [varchar](50) NULL,
	[TIN] [varchar](50) NULL,
	[PAN] [varchar](50) NULL,
	[ECC_No] [varchar](50) NULL,
	[CST] [varchar](50) NULL,
	[CountryCode] [varchar](10) NULL,
	[StateCode] [varchar](10) NULL,
	[CItyCode] [varchar](10) NULL,
	[Address] [varchar](255) NULL,
	[ZipCode] [varchar](20) NULL,
	[SupplierCategory] [varchar](10) NULL,
	[GST_No] [nvarchar](50) NULL,
	[ARN_No] [nvarchar](50) NULL,
	[CreatedDate] [date] NULL CONSTRAINT [DF_PMS_SupplierMaster_CreatedDate]  DEFAULT (getdate()),
	[CreatedBy] [varchar](50) NULL,
	[UpdatedDate] [date] NULL CONSTRAINT [DF_PMS_SupplierMaster_UpdatedDate]  DEFAULT (getdate()),
	[UpdatedBy] [varchar](50) NULL,
	[Status] [varchar](20) NULL,
	[ApprovalDate] [date] NULL,
	[ApprovalBy] [varchar](50) NULL,
	[FactoryAdd] [varchar](255) NULL,
	[FactoryZipCode] [varchar](20) NULL,
	[flag] [int] NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_SupplierMaster_CreatedOn]  DEFAULT (getdate()),
	[UpdatedOn] [datetime] NULL,
	[Type] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_SupplierMaster] PRIMARY KEY CLUSTERED 
(
	[SupplierCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_Supplier_ID] UNIQUE NONCLUSTERED 
(
	[SupplierCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_SupplierQuotation]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_SupplierQuotation](
	[QuoteID] [nvarchar](100) NOT NULL,
	[RefferenceID] [nvarchar](100) NOT NULL,
	[Payment] [nvarchar](max) NULL,
	[ShippingTerms] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](20) NULL,
	[UpdatedBy] [nvarchar](20) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
	[ApprovalStatus] [nvarchar](20) NULL,
	[CostPerUnit] [decimal](18, 2) NULL,
	[Total] [decimal](18, 2) NULL,
	[Taxes] [nvarchar](max) NULL,
	[QuoteAmount] [decimal](18, 2) NULL,
	[QuoteStatus] [nvarchar](10) NULL,
	[QuoteSupplier] [nvarchar](50) NULL,
	[Reason] [nvarchar](max) NULL,
	[UploadFileName] [nvarchar](max) NULL,
 CONSTRAINT [PK_PMS_SupplierQuotation] PRIMARY KEY CLUSTERED 
(
	[QuoteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_SupplierVariables]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[PMS_SupplierVariables](
	[Auto_Id] [int] IDENTITY(1,1) NOT NULL,
	[CostCenter] [varchar](50) NULL,
	[SupplierCategory] [varchar](50) NULL,
	[SupplierLocation] [varchar](50) NULL,
	[SupplierType] [varchar](50) NULL,
	[Status] [varchar](50) NULL,
	[Is_Default] [varchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_SupplierVariables_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_SupplierVariables_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_SupplierVariables] PRIMARY KEY CLUSTERED 
(
	[Auto_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Sync_File]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Sync_File](
	[File_ID] [int] IDENTITY(1,1) NOT NULL,
	[Sync_FileNM] [varchar](200) NULL,
	[V_From_Vikroli] [int] NULL,
	[V_From_Cloud] [int] NULL,
	[V_From_Bhinvandi] [int] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_Sync_File_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_Sync_File_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_Sync_File] PRIMARY KEY CLUSTERED 
(
	[File_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Synchronization]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Synchronization](
	[ID] [nvarchar](50) NOT NULL,
	[QueryString] [nvarchar](max) NULL,
	[Vikhroli] [int] NULL CONSTRAINT [DF_PMS_Synchronization_Status]  DEFAULT ('1'),
	[Bhiwandi] [int] NULL,
	[Cloud] [int] NULL,
	[LastUpdated] [date] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_Synchronization_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_Synchronization_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_Synchronization] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_TaxDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_TaxDetails](
	[wstax_Id] [nvarchar](100) NOT NULL,
	[tax_Name] [nvarchar](500) NULL,
	[InvoiceNo] [nvarchar](500) NULL,
	[Tax_Value] [float] NULL,
	[TaxAmountValue] [float] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_TaxDetails_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_TaxDetails_Audit]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_TaxDetails_Audit](
	[wstax_Id] [nvarchar](100) NOT NULL,
	[tax_Name] [nvarchar](500) NULL,
	[InvoiceNo] [nvarchar](500) NULL,
	[Tax_Value] [float] NULL,
	[TaxAmountValue] [float] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_TaxDetails_Audit_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_TermsAndCondition]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_TermsAndCondition](
	[ID] [nvarchar](50) NOT NULL,
	[TermsAndCondition] [nvarchar](max) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_TermsAndCondition] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_TraningEntry]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_TraningEntry](
	[tr_Id] [nvarchar](200) NOT NULL,
	[tr_Title] [nvarchar](50) NULL,
	[tr_Reciever] [nvarchar](50) NULL,
	[tr_Process] [nvarchar](50) NULL,
	[tr_Machine] [nvarchar](50) NULL,
	[tr_JobOrder] [nvarchar](50) NULL,
	[tr_WorkOrder] [nvarchar](50) NULL,
	[tr_EntryPerson] [nvarchar](50) NULL,
	[tr_TimeStmp] [datetime] NULL,
	[tr_Tutor] [nvarchar](50) NULL,
	[tr_TrainingDate] [date] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_TraningEntry_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_TraningEntry_UpdatedOn]  DEFAULT (getdate()),
	[TrUpload] [nvarchar](250) NULL,
 CONSTRAINT [PK_TraningEntry2] PRIMARY KEY CLUSTERED 
(
	[tr_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_TraningEntryDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_TraningEntryDetails](
	[td_ID] [nvarchar](100) NOT NULL,
	[td_TrEntryId] [nvarchar](50) NULL,
	[td_Issue] [nvarchar](1000) NULL,
	[td_Solution] [nvarchar](1000) NULL,
	[td_Analysis] [nvarchar](1000) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_TraningEntryDetails_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_TraningEntryDetails_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_TraningEntryDetails2] PRIMARY KEY CLUSTERED 
(
	[td_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_TransferDoc]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_TransferDoc](
	[ID] [nvarchar](50) NOT NULL,
	[Doc_Name] [nvarchar](max) NULL,
	[Send_By] [nvarchar](50) NULL,
	[Receiver_Name] [nvarchar](50) NULL,
	[Entry_Date] [datetime] NULL,
	[Entry_Made_By] [nvarchar](50) NULL,
	[Received_By] [nvarchar](50) NULL,
	[Received_Date] [date] NULL,
	[Status] [int] NULL,
	[Remark] [nvarchar](max) NULL,
	[SO_Number] [nvarchar](50) NULL,
	[DocumentType] [nvarchar](50) NULL,
	[SentFrom] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_TransferDoc_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_TransferDoc_UpdatedOn]  DEFAULT (getdate()),
	[Receiver_Remark] [nvarchar](max) NULL,
 CONSTRAINT [PK_PMS_TransferDoc] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_TransportLocation]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_TransportLocation](
	[loc_Id] [int] IDENTITY(1,1) NOT NULL,
	[loc_Name] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL,
 CONSTRAINT [PK_loc_Id] PRIMARY KEY CLUSTERED 
(
	[loc_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Tutorial]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Tutorial](
	[uid] [int] IDENTITY(1,1) NOT NULL,
	[Module] [varchar](max) NULL,
	[Tutorial] [varchar](max) NULL,
	[Auther] [varchar](max) NULL,
	[Download] [varchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_Tutorial_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_Tutorial_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_Tutorial] PRIMARY KEY CLUSTERED 
(
	[uid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Type]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Type](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](255) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_Type_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_Type_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_Type] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Units]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Units](
	[ID] [nvarchar](50) NOT NULL,
	[Unit] [nvarchar](255) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Units_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_Units] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_UploadDesign]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_UploadDesign](
	[up_ID] [nvarchar](50) NOT NULL,
	[up_DesgName] [nvarchar](250) NULL,
	[up_DesgFileName] [nvarchar](100) NULL,
	[up_JCNo] [nvarchar](50) NULL,
	[up_UserName] [nvarchar](250) NULL,
	[up_TimeStmp] [nvarchar](250) NULL,
	[Up_Production] [bit] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_UploadDesign_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_UploadDesign_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_UploadDesign] PRIMARY KEY CLUSTERED 
(
	[up_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_UploadDesign_Details]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_UploadDesign_Details](
	[Design_Id] [nvarchar](50) NOT NULL,
	[Design_Upload_Id] [nvarchar](50) NULL,
	[File_Name] [nvarchar](350) NULL,
	[File_Path] [nvarchar](350) NULL,
	[File_title] [nvarchar](350) NULL,
	[CreatedOn] [nvarchar](50) NULL CONSTRAINT [DF_PMS_UploadDesign_Details_CreatedOn]  DEFAULT (getdate()),
	[CreatedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_UploadDesign_Details] PRIMARY KEY CLUSTERED 
(
	[Design_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_UserLoginLog]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_UserLoginLog](
	[ID] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NULL,
	[UserName] [nvarchar](50) NULL,
	[DateTime] [datetime] NULL CONSTRAINT [DF_PMS_UserLoginLog_DateTime]  DEFAULT (getdate()),
	[IPAddress] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_UserLoginLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Pms_UserRoleMaster]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pms_UserRoleMaster](
	[Id] [nvarchar](50) NOT NULL,
	[RoleID] [nvarchar](50) NULL,
	[UserID] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_Pms_UserRoleMaster_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_Pms_UserRoleMaster_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [Pk_UserRoleMasterid] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_Users]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Users](
	[ID] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Username] [nvarchar](255) NULL,
	[Password] [nvarchar](255) NULL,
	[Type] [nvarchar](50) NULL,
	[Site] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
	[Designation] [nvarchar](50) NULL,
	[Position] [nvarchar](50) NULL,
	[Email_Id] [varchar](200) NULL,
	[Password2] [nvarchar](520) NULL,
	[makerchecker] [int] NULL,
	[EmpCode] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_Users_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_Users_UpdatedOn]  DEFAULT (getdate()),
	[UserType] [int] NULL,
 CONSTRAINT [PK_Users2] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Visitor]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_Visitor](
	[Id] [varchar](50) NOT NULL,
	[Date] [date] NULL,
	[TimeIn] [time](7) NULL,
	[Name] [nvarchar](200) NULL,
	[Organisation] [nvarchar](150) NULL,
	[PhoneNo] [nvarchar](50) NULL,
	[PersonToMeet] [nvarchar](50) NULL,
	[VisitType] [nvarchar](50) NULL,
	[ComingFrom] [nvarchar](100) NULL,
	[VisitArea] [nvarchar](50) NULL,
	[BatchId] [int] NULL,
	[Signature] [bit] NULL,
	[OutTime] [time](7) NULL,
	[ImagePath] [nvarchar](200) NULL,
	[Imagename] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_Visitor_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_Visitor_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_Visitor] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_Wastage]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_Wastage](
	[Wastage_Id] [nvarchar](50) NOT NULL,
	[Item] [nvarchar](50) NULL,
	[Unit] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_Wastage_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_Wastage] PRIMARY KEY CLUSTERED 
(
	[Wastage_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_WorkEntry]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_WorkEntry](
	[ID] [nvarchar](50) NOT NULL,
	[Work_JobOrder] [nvarchar](50) NULL,
	[Work_Godown] [nvarchar](255) NULL,
	[Work_Machinary] [nvarchar](50) NULL,
	[Work_Process] [nvarchar](50) NULL,
	[Work_DateFrom] [nvarchar](255) NULL,
	[Work_DateTo] [nvarchar](255) NULL,
	[UserId] [nvarchar](50) NULL,
	[EntryDate] [datetime] NULL,
	[Helper] [nvarchar](50) NULL,
	[Assistant] [nvarchar](50) NULL,
	[TimeStamp] [datetime] NULL,
	[Work_WorkOrder] [nvarchar](50) NULL,
	[Work_Comments] [nvarchar](max) NULL,
	[Work_QualityCheck] [nvarchar](max) NULL,
	[Work_Complains] [nvarchar](max) NULL,
	[Output] [nvarchar](50) NULL,
	[Unit] [nvarchar](50) NULL,
	[Operator] [nvarchar](50) NULL,
	[excelname] [nvarchar](500) NULL,
	[Process_Status] [varchar](100) NULL,
	[TotalTime] [nvarchar](250) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_WorkEntry_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
 CONSTRAINT [PK_PMS_WorkEntry] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_WorkEntryQcPoints]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_WorkEntryQcPoints](
	[weQc_Id] [varchar](20) NOT NULL,
	[weQc_WorkEntryID] [varchar](20) NULL,
	[weQc_QcPointId] [nvarchar](500) NULL,
	[weQc_QcOption] [nvarchar](500) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_WorkEntryQcPoints_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_WorkEntryQcPoints_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_WorkEntryQcPoints] PRIMARY KEY CLUSTERED 
(
	[weQc_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_WorkEntryRes_InPara1]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_WorkEntryRes_InPara1](
	[WERParaIn_Id] [nvarchar](50) NOT NULL,
	[WERParaIn_WorkEntryId] [varchar](20) NULL,
	[WERParaIn_InProId] [nvarchar](50) NULL,
	[WERParaIn_ParaId] [nvarchar](max) NULL,
	[WERParaIn_ParaValue] [nvarchar](max) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_WorkEntryRes_InPara1_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_WorkEntryRes_InPara1_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_WorkEntryRes_InPara1] PRIMARY KEY CLUSTERED 
(
	[WERParaIn_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_WorkEntryRes_OutPara1]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_WorkEntryRes_OutPara1](
	[WERParaOut_Id] [nvarchar](50) NOT NULL,
	[WERParaOut_WorkEntryId] [varchar](20) NULL,
	[WERParaOut_InProId] [nvarchar](50) NULL,
	[WERParaOut_ParaId] [nvarchar](50) NULL,
	[WERParaOut_ParaValue] [nvarchar](250) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_WorkEntryRes_OutPara1_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_WorkEntryRes_OutPara1_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_WorkEntryRes_OutPara1] PRIMARY KEY CLUSTERED 
(
	[WERParaOut_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_WorkEntryResources]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_WorkEntryResources](
	[ID] [int] NOT NULL,
	[WorkEntry_Id] [nvarchar](50) NULL,
	[Resources_Id] [nvarchar](50) NULL,
	[Resources_Qty] [float] NULL,
	[Resources_Size] [nvarchar](50) NULL,
	[Resources_Reel] [nvarchar](15) NULL,
	[Resources_Output] [int] NULL,
	[Resources_Unit] [nvarchar](15) NULL,
	[Prod_Cat] [nvarchar](50) NULL,
	[RM_Cat] [nvarchar](50) NULL,
	[Qc] [nvarchar](max) NULL,
	[Complains] [nvarchar](max) NULL,
	[Comments] [nvarchar](max) NULL,
	[OutPro_MatId] [int] NULL,
	[OutPro_ProdCatID] [int] NULL,
	[OutPro_ResId] [int] NULL,
	[OutPro_Unit] [int] NULL,
	[OutPro_Qty] [float] NULL,
	[OutPro_WestedQty] [float] NULL,
	[InPro_MatId] [int] NULL,
	[InPro_ProdCatID] [int] NULL,
	[InPro_ResId] [int] NULL,
	[InPro_Unit] [int] NULL,
	[InPro_Qty] [float] NULL,
	[IntPro_WestedQty] [float] NULL,
	[InPro_RetQty] [float] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_WorkEntryResources_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_WorkEntryResources_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_WorkEntryResources] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_WorkEntryResources_InputPro]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_WorkEntryResources_InputPro](
	[WERI_ID] [varchar](20) NOT NULL,
	[WERI_WorkEntryId] [varchar](20) NULL,
	[WERI_InPro_MatId] [varchar](20) NULL,
	[WERI_InPro_ProdCatID] [varchar](20) NULL,
	[WERI_InPro_ResId] [varchar](20) NULL,
	[WERI_InPro_Unit] [varchar](20) NULL,
	[WERI_InPro_Qty] [varchar](20) NULL,
	[WERI_IntPro_WestedQty] [float] NULL,
	[WERI_InPro_RetQty] [varchar](20) NULL,
	[Chked] [int] NULL,
	[WERI_IntPro_BalanceReel] [float] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_WorkEntryResources_InputPro_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_WorkEntryResources_InputPro_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_WorkEntryResources_InputPro] PRIMARY KEY CLUSTERED 
(
	[WERI_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_WorkEntryResources_OutputPro]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_WorkEntryResources_OutputPro](
	[WERO_ID] [varchar](20) NOT NULL,
	[WERO_WorkEntryId] [varchar](20) NULL,
	[WERO_InPro_MatId] [varchar](20) NULL,
	[WERO_InPro_ProdCatID] [varchar](20) NULL,
	[WERO_InPro_ResId] [varchar](20) NULL,
	[WERO_InPro_Unit] [varchar](20) NULL,
	[WERO_InPro_Qty] [varchar](20) NULL,
	[WERO_IntPro_WestedQty] [float] NULL,
	[WERO_IntPro_BalanceReel] [float] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_WorkEntryResources_OutputPro_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_WorkEntryResources_OutputPro_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_WorkEntryResources_OutputPro] PRIMARY KEY CLUSTERED 
(
	[WERO_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_WorkEntryResources_Para_Old]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_WorkEntryResources_Para_Old](
	[WorkEntry_Id] [nvarchar](50) NULL,
	[Resources_Id] [nvarchar](50) NULL,
	[Para_ID] [nvarchar](50) NULL,
	[Para_Value] [nvarchar](255) NULL,
	[WE_Resources_Id] [int] NULL,
	[ID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_WorkEntrySpareParts]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_WorkEntrySpareParts](
	[wsp_Id] [varchar](20) NOT NULL,
	[wsp_WorkEntryId] [varchar](20) NULL,
	[wsp_SparepartId] [nvarchar](50) NULL,
	[wsp_Qty] [float] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_WorkEntrySpareParts_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_WorkEntrySpareParts_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_WorkEntrySpareParts] PRIMARY KEY CLUSTERED 
(
	[wsp_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_WorkFlowEntry]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_WorkFlowEntry](
	[WorkFlowEntryId] [nvarchar](50) NOT NULL,
	[WorkFlow] [nvarchar](50) NULL,
	[EntryDate] [datetime] NULL,
	[UserId] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL,
 CONSTRAINT [Pk_WorkFlowEntryId] PRIMARY KEY CLUSTERED 
(
	[WorkFlowEntryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_WorkFlowMaster]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_WorkFlowMaster](
	[WorkFlowId] [nvarchar](50) NOT NULL,
	[WorkFlowName] [varchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL,
 CONSTRAINT [Pk_Workflowid] PRIMARY KEY CLUSTERED 
(
	[WorkFlowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Uk_WorkFlowName] UNIQUE NONCLUSTERED 
(
	[WorkFlowName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_WorkFlowMasterDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_WorkFlowMasterDetails](
	[WorkFlowMasterDetailsId] [nvarchar](50) NOT NULL,
	[ParentId] [nvarchar](50) NULL,
	[Activity] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL,
 CONSTRAINT [Pk_WorkFlowMasterDetailsId] PRIMARY KEY CLUSTERED 
(
	[WorkFlowMasterDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_WorkMaterialReturned]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_WorkMaterialReturned](
	[Id] [int] NOT NULL,
	[WorkEntry_Id] [varchar](20) NULL,
	[MatReturned_ResourceId] [nvarchar](50) NULL,
	[MatReturned_Qty] [float] NULL,
	[MatWasted_Qty] [float] NULL,
	[MatReturned_Size] [nvarchar](50) NULL,
	[Variety] [nvarchar](50) NULL,
	[WE_Resource_Id] [nvarchar](50) NULL,
	[test] [float] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_WorkMaterialReturned_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_WorkMaterialReturned_UpdatedOn]  DEFAULT (getdate()),
 CONSTRAINT [PK_PMS_WorkMaterialReturned] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_WorkOrder]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_WorkOrder](
	[ID] [nvarchar](50) NOT NULL,
	[WorkOrderID] [nvarchar](50) NULL,
	[CustomerID] [nvarchar](50) NULL,
	[work_Trans_Option] [nvarchar](50) NULL,
	[work_Trans_Location] [nvarchar](50) NULL,
	[work_Delivery_Location] [nvarchar](50) NULL,
	[work_Trans_DebitNote] [nchar](10) NULL,
	[Date] [nvarchar](50) NULL,
	[work_Promice_Date] [nvarchar](50) NULL,
	[work_po_date] [nvarchar](50) NULL,
	[work_po_no] [nvarchar](50) NULL,
	[work_TrCat] [varchar](50) NULL,
	[Status] [int] NULL,
	[WorkOrderName] [nvarchar](max) NULL,
	[JobOrderID] [nvarchar](50) NULL,
	[Quantity] [float] NULL,
	[Unit] [nvarchar](50) NULL,
	[work_No_From] [varchar](100) NULL,
	[work_No_To] [varchar](100) NULL,
	[work_CompName] [nvarchar](50) NULL,
	[work_PrintFor] [nvarchar](50) NULL,
	[work_Item] [nvarchar](50) NULL,
	[work_InlineText] [nvarchar](50) NULL,
	[work_SpcInst] [nvarchar](250) NULL,
	[work_LBL_Desc] [nvarchar](50) NULL,
	[SalesOrderDate] [datetime] NULL,
	[Unit_Price] [float] NULL,
	[Plan_Status] [varchar](10) NULL,
	[FreightCharges] [decimal](10, 2) NULL,
	[BankCharges] [decimal](10, 2) NULL,
	[OctroiCharges] [decimal](10, 2) NULL,
	[TotalAmt] [decimal](10, 2) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[chkFreight] [int] NULL CONSTRAINT [DF_chkFreight]  DEFAULT ('0'),
	[chkBank] [int] NULL CONSTRAINT [DF_chkBank]  DEFAULT ('0'),
	[chkOctroi] [int] NULL CONSTRAINT [DF_chkOctroi]  DEFAULT ('0'),
	[chkOther] [int] NULL CONSTRAINT [DF_chkOther]  DEFAULT ('0'),
	[OtherCharges] [decimal](10, 2) NULL,
	[InsuranceCharges] [decimal](10, 2) NULL,
	[LoadingPackingCharges] [decimal](10, 2) NULL,
	[chkInsurance] [int] NULL,
	[chkLoadingPacking] [int] NULL,
	[TtlINRincTAX] [decimal](10, 2) NULL,
	[JobInstruction] [nvarchar](max) NULL,
	[POUpload] [nvarchar](250) NULL,
	[mail_flag] [char](10) NULL,
	[POQty] [nvarchar](50) NULL,
	[POUnit] [nvarchar](50) NULL,
	[POChk] [int] NULL,
	[Currency] [nvarchar](50) NULL,
	[TransportMode] [nvarchar](50) NULL,
	[DispInv_Instruction] [nvarchar](max) NULL,
	[IsChallanMade] [int] NULL,
	[NumberOfLVS] [int] NULL,
	[OtherChargeLable] [nvarchar](50) NULL,
	[ChkOtherCharge] [int] NULL,
	[PO_Width] [nvarchar](50) NULL,
	[PO_Width_Unit] [nvarchar](50) NULL,
	[PO_Height] [nvarchar](50) NULL,
	[PO_Height_Unit] [nvarchar](50) NULL,
 CONSTRAINT [Pk_WorkOrder1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_WorkOrder_Audit]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[PMS_WorkOrder_Audit](
	[ID] [nvarchar](50) NOT NULL,
	[WorkOrderID] [nvarchar](50) NULL,
	[CustomerID] [nvarchar](50) NULL,
	[work_Trans_Option] [nvarchar](50) NULL,
	[work_Trans_Location] [nvarchar](50) NULL,
	[work_Delivery_Location] [nvarchar](50) NULL,
	[work_Trans_DebitNote] [nchar](10) NULL,
	[Date] [nvarchar](50) NULL,
	[work_Promice_Date] [nvarchar](50) NULL,
	[work_po_date] [nvarchar](50) NULL,
	[work_po_no] [nvarchar](50) NULL,
	[work_TrCat] [varchar](50) NULL,
	[Status] [int] NULL,
	[WorkOrderName] [nvarchar](max) NULL,
	[JobOrderID] [nvarchar](50) NULL,
	[Quantity] [float] NULL,
	[Unit] [nvarchar](50) NULL,
	[work_No_From] [varchar](100) NULL,
	[work_No_To] [varchar](100) NULL,
	[work_CompName] [nvarchar](50) NULL,
	[work_PrintFor] [nvarchar](50) NULL,
	[work_Item] [nvarchar](50) NULL,
	[work_InlineText] [nvarchar](50) NULL,
	[work_SpcInst] [nvarchar](250) NULL,
	[work_LBL_Desc] [nvarchar](50) NULL,
	[SalesOrderDate] [datetime] NULL,
	[Unit_Price] [float] NULL,
	[Plan_Status] [varchar](10) NULL,
	[FreightCharges] [decimal](10, 2) NULL,
	[BankCharges] [decimal](10, 2) NULL,
	[OctroiCharges] [decimal](10, 2) NULL,
	[TotalAmt] [decimal](10, 2) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[chkFreight] [int] NULL,
	[chkBank] [int] NULL,
	[chkOctroi] [int] NULL,
	[chkOther] [int] NULL,
	[OtherCharges] [decimal](10, 2) NULL,
	[TtlINRincTAX] [decimal](10, 2) NULL,
	[JobInstruction] [nvarchar](max) NULL,
	[POUpload] [nvarchar](250) NULL,
	[mail_flag] [char](10) NULL,
	[POQty] [nvarchar](50) NULL,
	[POUnit] [nvarchar](50) NULL,
	[POChk] [int] NULL,
	[Currency] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_WorkOrder_ClosureDetail]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_WorkOrder_ClosureDetail](
	[ID] [nvarchar](50) NOT NULL,
	[SO_ID] [nvarchar](50) NULL,
	[ProcessSign] [nvarchar](50) NULL,
	[QuanTT] [nvarchar](50) NULL,
	[Positive] [nvarchar](50) NULL,
	[Nylo] [nvarchar](50) NULL,
	[Plates] [nvarchar](50) NULL,
	[Sample] [nvarchar](50) NULL,
	[Remark] [nvarchar](300) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_WorkOrder_ClosureDetail_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_WorkOrder_ClosureDetail_UpdatedOn]  DEFAULT (getdate()),
	[MasterApproval] [nvarchar](50) NULL,
	[AllQCApproval] [nvarchar](50) NULL,
 CONSTRAINT [PK_PMS_WorkOrder_ClosureDetail] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_WorkOrder_Hold]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PMS_WorkOrder_Hold](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[WorkOrderID] [nvarchar](255) NULL,
	[WorkOrderName] [nvarchar](255) NULL,
	[CustomerID] [int] NULL,
	[JobOrderID] [int] NULL,
	[Date] [datetime] NULL,
	[Quantity] [bigint] NULL,
	[Location] [int] NULL,
	[Status] [int] NULL,
	[Unit] [varchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL CONSTRAINT [DF_PMS_WorkOrder_Hold_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL CONSTRAINT [DF_PMS_WorkOrder_Hold_UpdatedOn]  DEFAULT (getdate())
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PMS_WorkOrder_Multiple]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_WorkOrder_Multiple](
	[ID] [nvarchar](50) NOT NULL,
	[MultipleSO_ID] [nvarchar](50) NULL,
	[WorkOrderID] [nvarchar](50) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [date] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [date] NULL,
 CONSTRAINT [PK_PMS_WorkOrder_Multiple] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_WorkOrder_Multiple] UNIQUE NONCLUSTERED 
(
	[WorkOrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PMS_WorkOrder_Tax]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMS_WorkOrder_Tax](
	[ID] [nvarchar](50) NOT NULL,
	[WorkOrderID] [nvarchar](50) NULL,
	[TaxName] [nvarchar](150) NULL,
	[Value] [decimal](10, 2) NULL,
	[Date] [date] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedOn] [datetime] NULL CONSTRAINT [DF_PMS_WorkOrder_Tax_CreatedOn]  DEFAULT (getdate()),
	[UpdatedBy] [nvarchar](50) NULL,
	[UpdatedOn] [datetime] NULL,
	[flag] [int] NOT NULL CONSTRAINT [DF_PMS_WorkOrder_Tax_flag]  DEFAULT ((1)),
 CONSTRAINT [PK_PMS_WorkOrder_Tax] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SyncUser]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SyncUser](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[InternalID]  AS ('V/'+right('0000000'+CONVERT([varchar](7),[Id],0),(7))) PERSISTED,
	[UserID] [varchar](50) NULL,
	[Sync_On] [datetime] NULL CONSTRAINT [DF_SyncUser_Sync_On]  DEFAULT (getdate()),
 CONSTRAINT [PK_AutoInc] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[Challan_View]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Challan_View]
AS
SELECT     usr.Name, cdl.TIN_No, u.Unit, cc.cc_Boxes AS Boxes, j.Order_Id + ' ' + '(' + j.Order_Name + ')' AS JobOrder, w.WorkOrderName AS WorkOrder, 
                      c.cust_Name AS CustName, c.cust_Address, c.cust_IncTax_PanNo AS [Pan No], c.cust_Tax_ECCNo AS [Ecc No], c.cust_Vat_No AS [Vat No], 
                      c.cust_Vat_TINNo AS [Tin No], comp.comp_Name, comp.comp_RegsAdd, comp.comp_PhoneNo, comp.comp_FaxNo, comp.comp_VatRegsNo, comp.comp_GrioNo, 
                      comp.comp_Bank, comp.comp_AccNo, w.WorkOrderID AS [Batch No], j.Order_Id AS [Item No], j.Order_Name AS [Item Desc], gcd.chalDet_QtyTaken, 
                      gc.chal_Date AS [Chalan Date], gc.chal_Comment AS comments, comp.comp_Prefix, gc.chal_ID, w1.WorkOrderID AS [challan So No], 
                      c.cust_VendorCode AS [vendor code], w.work_po_date AS [PO date], w.work_po_no AS [PO No], c.cust_SalesPerson AS [sales person], 
                      cdl.custLoc_Address AS [Delivery loc], gc.chal_No AS [challan No], gc.chal_Date AS [challan Date], gcd.chalDet_QtyTaken AS Qty, 
                      gc.chal_ModeOfTrans AS [Mode Of Trans], gc.chal_VehlNo AS [Veh No], gc.chal_LrRrNo AS [LR RR No], gc.chal_LrRrDate AS [LR RR Date], 
                      gc.Date_Removal AS [Data Removal], gc.Time_Removal AS [Time Removal], comp.comp_SaleTaxDECL AS SalesTaxDed, comp.comp_TermsCond AS TermsAndCond, 
                      c.cust_No AS [Cust No], c.cust_CoOrdinator AS [Co Ordinator], gc.chal_TransName AS [Trans Name], comp.service_reg_no AS [Service Reg No1], 
                      comp.TIN_No AS [TIN NO1], comp.Pan_No AS [PAN NO1], comp.ECC_No AS [ECC NO1], comp.Excise_Range AS [Excise Range1], 
                      comp.Excise_division AS [Excise Division1], comp.Commissioner_rate AS [Commissioner Rate1], dbo.PMS_ProductMaster.prod_cat, gc.LR_Location, gc.Ack_Location,
                       gc.Other_Location, dbo.PMS_Excise_Master.Excise_Code, dbo.PMS_Excise_Master.Excise_Description, gc.ExternalDocNo, cdl.custLoc_Address AS DeliveryLoc, 
                      (CASE WHEN j.jobcart_Prod_Cat = '1' THEN ('(' + j.jobcart_Width + ' ' + x.Unit + ' * ' + j.jobcart_Height + ' ' + z.Unit + ' * ' + j.jobart_Parts + ') ' + j.jobart_Parts + ' Ply') 
                      ELSE ('(' + j.jobcart_Width + ' ' + x.Unit + ' * ' + j.jobcart_Height + ' ' + z.Unit + ') ' + j.jobart_Parts + ' Ply') END) AS JUnits, c.cust_ShippMethodCode, c.cust_Id, 
                      cc.QtyinKG, gcd.POQty, gcd.POUnit
FROM         dbo.PMS_Excise_Master INNER JOIN
                      dbo.PMS_ProductMaster ON dbo.PMS_Excise_Master.Auto_Id = dbo.PMS_ProductMaster.Excise_Code_Id RIGHT OUTER JOIN
                      dbo.PMS_GenerateChallan AS gc LEFT OUTER JOIN
                      dbo.PMS_GenerateChallanDetails AS gcd ON gc.chal_ID = gcd.chal_ID LEFT OUTER JOIN
                      dbo.PMS_WorkOrder AS w ON w.ID = gcd.chalDet_WorkOrderId LEFT OUTER JOIN
                      dbo.PMS_WorkOrder AS w1 ON w1.ID = gc.chal_SO_No LEFT OUTER JOIN
                      dbo.PMS_JobOrder AS j ON w.JobOrderID = j.ID LEFT OUTER JOIN
                      dbo.PMS_Customer AS c ON w.CustomerID = c.cust_Id LEFT OUTER JOIN
                      dbo.PMS_FGEntry AS cc ON w.ID = cc.cc_WorkOrderId LEFT OUTER JOIN
                      dbo.PMS_Units AS u ON u.ID = cc.cc_Unit LEFT OUTER JOIN
                      dbo.PMS_Units AS x ON x.ID = j.jobcart_Width_Unit LEFT OUTER JOIN
                      dbo.PMS_Units AS z ON z.ID = j.jobcart_Heights_Unit LEFT OUTER JOIN
                      dbo.PMS_Company AS comp ON comp.comp_Id = c.cust_Company ON dbo.PMS_ProductMaster.Auto_Id = j.jobcart_Prod_Cat LEFT OUTER JOIN
                      dbo.PMS_CustomerDeliveryLocation AS cdl ON gc.DeliveryLoc = cdl.custLoc_Id LEFT OUTER JOIN
                      dbo.PMS_Users AS usr ON usr.ID = c.cust_SalesPerson

GO
/****** Object:  View [dbo].[CityView]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CityView]
AS
SELECT     TOP (100) PERCENT a.city_Id, a.city_Name, a.city_Code, a.state_Id, a.CreatedBy, a.CreatedOn, a.UpdatedBy, a.UpdatedOn, b.Country_Name, c.State_Name, 
                      b.Country_Id
FROM         dbo.PMS_City AS a INNER JOIN
                      dbo.PMS_State AS c ON a.state_Id = c.State_Id INNER JOIN
                      dbo.PMS_Country AS b ON c.country_Id = b.Country_Id
ORDER BY CAST(SUBSTRING(a.city_Id, 6, 10) AS int) DESC, SUBSTRING(a.city_Id, 1, 1) DESC

GO
/****** Object:  View [dbo].[Cust_SuppView]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Cust_SuppView]
AS
SELECT     SupplierCode, SupplierName, Address, TIN, VAT
FROM         dbo.PMS_SupplierMaster
UNION
SELECT     cust_No, cust_Name, cust_Address, cust_Tax_CSTNo, cust_Vat_TINNo
FROM         dbo.PMS_Customer

GO
/****** Object:  View [dbo].[CustomerView]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CustomerView]
AS
SELECT     TOP (100) PERCENT dbo.PMS_Customer.cust_Id, dbo.PMS_Customer.cust_No, dbo.PMS_Customer.cust_PBoxNo, dbo.PMS_Customer.cust_Name, 
                      dbo.PMS_Company.comp_Name
FROM         dbo.PMS_Customer LEFT OUTER JOIN
                      dbo.PMS_Company ON dbo.PMS_Company.comp_Id = dbo.PMS_Customer.cust_Company
ORDER BY CAST(SUBSTRING(dbo.PMS_Customer.cust_Id, 6, 10) AS int) DESC, SUBSTRING(dbo.PMS_Customer.cust_Id, 1, 1) DESC

GO
/****** Object:  View [dbo].[CutomerSupplier_View]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[CutomerSupplier_View]
AS
SELECT     SupplierCode, SupplierName
FROM         dbo.PMS_SupplierMaster
UNION
SELECT     cust_No, cust_Name
FROM         dbo.PMS_Customer

GO
/****** Object:  View [dbo].[Gen_ChallanView]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Gen_ChallanView]
AS
SELECT DISTINCT 
                      c.cust_Name AS CustName, c.cust_Address, c.cust_Tax_ECCNo AS [Ecc No], c.cust_Vat_No AS Vat_No,c.ARN_No AS Cust_ARN_No,c.GST_No AS Cust_GST_No, c.cust_Vat_TINNo AS [Tin No], comp.comp_Name, 
                      comp.comp_RegsAdd, comp.comp_PhoneNo, comp.comp_FaxNo, comp.comp_VatRegsNo, comp.comp_GrioNo,comp.GST_No,comp.ARN_No, w.Date, w.work_SpcInst, w.WorkOrderID, 
                      w.WorkOrderID AS [Batch No], j.Order_Id AS [Item No], j.Order_Name AS [Item Desc], gc.chal_Date AS [Chalan Date], gc.chal_ID, w1.WorkOrderID AS [challan So No], 
                      w.work_po_date AS [PO date], w.work_po_no AS [PO No], c.cust_SalesPerson AS [sales person], cdl.custLoc_Address AS [Delivery loc], gc.chal_No AS challan_No, 
                      gc.chal_Date AS [challan Date], comp.Excise_Range, comp.Excise_division, gcd.chalDet_QtyTaken AS Qty, gc.chal_ModeOfTrans AS [Mode Of Trans], 
                      gc.chal_VehlNo AS [Veh No], gc.chal_LrRrNo AS [LR RR No], gc.chal_LrRrDate AS [LR RR Date], gc.Date_Removal AS [Data Removal], 
                      gcd.chalDet_QtyTaken * w1.Unit_Price AS Amount, comp.comp_SaleTaxDECL AS SalesTaxDed, comp.Pan_No, comp.Commissioner_rate, 
                      comp.comp_TermsCond AS TermsAndCond, dbo.PMS_Excise_Master.Excise_Code, cdl.custLoc_Address AS DeliveryLoc, c.cust_Id, comp.service_reg_no, 
                      comp.ECC_No, dbo.PMS_Company_BankDetails.IFSCCode, w1.ID, w1.TtlINRincTAX, gc.chal_SO_No, usr.Name, dbo.PMS_Company_BankDetails.BankName, 
                      dbo.PMS_Company_BankDetails.AcNo, dbo.PMS_Company_BankDetails.Branch, dbo.PMS_Units.Unit AS Unit_NM, w.Unit_Price, dbo.PMS_MasterTax.tax_Id, 
                      dbo.PMS_MasterTax.tax_Value, dbo.PMS_MasterTax.tax_Name, c.cust_Tax_CSTNo, gc.SMS_Location, gc.chal_Comment, dbo.PMS_MasterTax.FlatRate, 
                      cdl.TIN_No AS Del_Tin_No, w.FreightCharges, w.BankCharges, w.OctroiCharges, gc.flag, cc.cc_Boxes, w.TransportMode, c.cust_No, c.cust_VendorCode, u.Unit
FROM         dbo.PMS_MasterSalesWorkOrderTax INNER JOIN
                      dbo.PMS_Units INNER JOIN
                      dbo.PMS_WorkOrder AS w1 ON dbo.PMS_Units.ID = w1.Unit ON dbo.PMS_MasterSalesWorkOrderTax.wstax_WorkSaleOrderId = w1.ID INNER JOIN
                      dbo.PMS_MasterTaxStructureDetails ON dbo.PMS_MasterSalesWorkOrderTax.wstax_Name = dbo.PMS_MasterTaxStructureDetails.taxStrDet_taxSrtId INNER JOIN
                      dbo.PMS_MasterTax ON dbo.PMS_MasterTaxStructureDetails.taxStr_Name = dbo.PMS_MasterTax.tax_Id LEFT OUTER JOIN
                      dbo.PMS_GenerateChallan AS gc LEFT OUTER JOIN
                      dbo.PMS_FGEntry AS cc LEFT OUTER JOIN
                      dbo.PMS_WorkOrder AS w INNER JOIN
                      dbo.PMS_GenerateChallanDetails AS gcd ON w.ID = gcd.chalDet_WorkOrderId ON cc.cc_WorkOrderId = w.ID RIGHT OUTER JOIN
                      dbo.PMS_JobOrder AS j ON w.JobOrderID = j.ID ON gc.chal_ID = gcd.chal_ID ON w1.ID = gc.chal_SO_No LEFT OUTER JOIN
                      dbo.PMS_Customer AS c ON w.CustomerID = c.cust_Id LEFT OUTER JOIN
                      dbo.PMS_Units AS u ON cc.cc_Unit = u.ID LEFT OUTER JOIN
                      dbo.PMS_Units AS x ON j.jobcart_Width_Unit = x.ID LEFT OUTER JOIN
                      dbo.PMS_Units AS z ON j.jobcart_Heights_Unit = z.ID LEFT OUTER JOIN
                      dbo.PMS_Company AS comp INNER JOIN
                      dbo.PMS_Company_BankDetails ON comp.comp_Id = dbo.PMS_Company_BankDetails.Comp_ID ON c.cust_Company = comp.comp_Id LEFT OUTER JOIN
                      dbo.PMS_Excise_Master INNER JOIN
                      dbo.PMS_ProductMaster ON dbo.PMS_Excise_Master.Auto_Id = dbo.PMS_ProductMaster.Excise_Code_Id ON 
                      j.jobcart_Prod_Cat = dbo.PMS_ProductMaster.Auto_Id LEFT OUTER JOIN
                      dbo.PMS_CustomerDeliveryLocation AS cdl ON gc.DeliveryLoc = cdl.custLoc_Id LEFT OUTER JOIN
                      dbo.PMS_Users AS usr ON usr.ID = c.cust_SalesPerson


GO
/****** Object:  View [dbo].[Gen_ChallanView_old]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Gen_ChallanView_old]
AS
SELECT DISTINCT 
                      c.cust_Name AS CustName, c.cust_Address, c.cust_Tax_ECCNo AS [Ecc No], c.cust_Vat_No AS [Vat No], c.cust_Vat_TINNo AS [Tin No], comp.comp_Name, 
                      comp.comp_RegsAdd, comp.comp_PhoneNo, comp.comp_FaxNo, comp.comp_VatRegsNo, comp.comp_GrioNo, w.Date, w.work_SpcInst, w.WorkOrderID, 
                      w.WorkOrderID AS [Batch No], j.Order_Id AS [Item No], j.Order_Name AS [Item Desc], gc.chal_Date AS [Chalan Date], gc.chal_ID, w1.WorkOrderID AS [challan So No], 
                      w.work_po_date AS [PO date], w.work_po_no AS [PO No], c.cust_SalesPerson AS [sales person], cdl.custLoc_Address AS [Delivery loc], gc.chal_No AS challan_No, 
                      gc.chal_Date AS [challan Date], comp.Excise_Range, comp.Excise_division, gcd.chalDet_QtyTaken AS Qty, gc.chal_ModeOfTrans AS [Mode Of Trans], 
                      gc.chal_VehlNo AS [Veh No], gc.chal_LrRrNo AS [LR RR No], gc.chal_LrRrDate AS [LR RR Date], gc.Date_Removal AS [Data Removal], 
                      gcd.chalDet_QtyTaken * w1.Unit_Price AS Amount, comp.comp_SaleTaxDECL AS SalesTaxDed, comp.Pan_No, comp.Commissioner_rate, 
                      comp.comp_TermsCond AS TermsAndCond, dbo.PMS_Excise_Master.Excise_Code, cdl.custLoc_Address AS DeliveryLoc, c.cust_Id, comp.service_reg_no, 
                      comp.ECC_No, dbo.PMS_Company_BankDetails.IFSCCode, w1.ID, w1.TtlINRincTAX, dbo.PMS_WorkOrder_Tax.TaxName, dbo.PMS_WorkOrder_Tax.Value, 
                      gc.chal_SO_No, usr.Name, dbo.PMS_MasterTax.tax_Value, dbo.PMS_Company_BankDetails.BankName, dbo.PMS_Company_BankDetails.AcNo, 
                      dbo.PMS_Company_BankDetails.Branch, dbo.PMS_Units.Unit AS Unit_NM, w.Unit_Price
FROM         dbo.PMS_Units INNER JOIN
                      dbo.PMS_WorkOrder AS w1 INNER JOIN
                      dbo.PMS_WorkOrder_Tax ON w1.ID = dbo.PMS_WorkOrder_Tax.WorkOrderID INNER JOIN
                      dbo.PMS_MasterTax ON dbo.PMS_WorkOrder_Tax.TaxName = dbo.PMS_MasterTax.tax_Name ON dbo.PMS_Units.ID = w1.Unit LEFT OUTER JOIN
                      dbo.PMS_GenerateChallan AS gc LEFT OUTER JOIN
                      dbo.PMS_FGEntry AS cc LEFT OUTER JOIN
                      dbo.PMS_WorkOrder AS w INNER JOIN
                      dbo.PMS_GenerateChallanDetails AS gcd ON w.ID = gcd.chalDet_WorkOrderId ON cc.cc_WorkOrderId = w.ID RIGHT OUTER JOIN
                      dbo.PMS_JobOrder AS j ON w.JobOrderID = j.ID ON gc.chal_ID = gcd.chal_ID ON w1.ID = gc.chal_SO_No LEFT OUTER JOIN
                      dbo.PMS_Customer AS c ON w.CustomerID = c.cust_Id LEFT OUTER JOIN
                      dbo.PMS_Units AS u ON cc.cc_Unit = u.ID LEFT OUTER JOIN
                      dbo.PMS_Units AS x ON j.jobcart_Width_Unit = x.ID LEFT OUTER JOIN
                      dbo.PMS_Units AS z ON j.jobcart_Heights_Unit = z.ID LEFT OUTER JOIN
                      dbo.PMS_Company AS comp INNER JOIN
                      dbo.PMS_Company_BankDetails ON comp.comp_Id = dbo.PMS_Company_BankDetails.Comp_ID ON c.cust_Company = comp.comp_Id LEFT OUTER JOIN
                      dbo.PMS_Excise_Master INNER JOIN
                      dbo.PMS_ProductMaster ON dbo.PMS_Excise_Master.Auto_Id = dbo.PMS_ProductMaster.Excise_Code_Id ON 
                      j.jobcart_Prod_Cat = dbo.PMS_ProductMaster.Auto_Id LEFT OUTER JOIN
                      dbo.PMS_CustomerDeliveryLocation AS cdl ON gc.DeliveryLoc = cdl.custLoc_Id LEFT OUTER JOIN
                      dbo.PMS_Users AS usr ON usr.ID = c.cust_SalesPerson


GO
/****** Object:  View [dbo].[Gen_CreateInvoice]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Gen_CreateInvoice]
AS
SELECT DISTINCT 
                      0 AS Disc, cdl.custLoc_Address, w.WorkOrderName AS WorkOrder, c.cust_No, c.cust_PayTermCode, c.cust_Name AS CustName, c.cust_Address, 
                      c.cust_Tax_ECCNo AS [Ecc No], c.cust_Vat_No AS [Vat No], c.cust_Vat_TINNo AS [Tin No], c.cust_PayTermCode AS Expr1, comp.comp_Name, comp.comp_RegsAdd, 
                      comp.comp_PhoneNo, comp.comp_FaxNo, comp.comp_VatRegsNo, comp.comp_GrioNo, comp.comp_Bank, w.Date, w.work_SpcInst, comp.comp_AccNo, 
                      w.WorkOrderID, w.WorkOrderID AS [Batch No], j.Order_Id AS [Item No], j.Order_Name AS [Item _Desc], gc.chal_Date AS [Chalan Date], gc.chal_ID, 
                      w1.WorkOrderID AS [challan So No], w.work_po_date AS [PO date], w.work_po_no AS [PO No], c.cust_SalesPerson AS [sales person], 
                      cdl.custLoc_Address AS [Delivery loc], gc.chal_No AS challan_No, gc.chal_Date AS [challan Date], comp.Excise_Range, comp.Excise_division, 
                      gcd.chalDet_QtyTaken AS Qty, gc.chal_ModeOfTrans AS [Mode Of Trans], gc.chal_VehlNo AS [Veh No], gc.chal_LrRrNo AS [LR RR No], 
                      gc.chal_LrRrDate AS [LR RR Date], gc.Date_Removal AS [Data Removal], gcd.chalDet_QtyTaken * w1.Unit_Price AS Amount1, w.work_Delivery_Location, 
                      comp.comp_SaleTaxDECL AS SalesTaxDed, comp.Pan_No, comp.Commissioner_rate, comp.comp_TermsCond AS TermsAndCond, 
                      dbo.PMS_Excise_Master.Excise_Code, cdl.custLoc_Address AS DeliveryLoc, c.cust_Id, comp.comp_Branch, comp.service_reg_no, 
                      w.WorkOrderName + '' + (CASE WHEN j.jobcart_Prod_Cat = '1' THEN ('(' + j.jobcart_Width + ' ' + x.Unit + ' * ' + j.jobcart_Height + ' ' + z.Unit + ' * ' + j.jobart_Parts + ') ' +
                       j.jobart_Parts + ' Ply') ELSE ('(' + j.jobcart_Width + ' ' + x.Unit + ' * ' + j.jobcart_Height + ' ' + z.Unit + ') ' + j.jobart_Parts + ' Ply') END) AS [Item Desc], 
                      dbo.PMS_MasterTransport.trans_Name, w.Unit_Price, c.cust_Tax_CSTNo, gc.SMS_Location, w.FreightCharges, w.BankCharges, w.OctroiCharges, w.chkFreight, 
                      w.chkBank, w.chkOctroi, w.chkOther, w.OtherCharges
FROM         dbo.PMS_Company AS comp RIGHT OUTER JOIN
                      dbo.PMS_GenerateChallan AS gc LEFT OUTER JOIN
                      dbo.PMS_GenerateChallanDetails AS gcd INNER JOIN
                      dbo.PMS_WorkOrder AS w ON gcd.chalDet_WorkOrderId = w.ID LEFT OUTER JOIN
                      dbo.PMS_MasterTransport ON w.work_Trans_Option = dbo.PMS_MasterTransport.trans_Id ON gc.chal_ID = gcd.chal_ID LEFT OUTER JOIN
                      dbo.PMS_WorkOrder AS w1 ON w1.ID = gc.chal_SO_No LEFT OUTER JOIN
                      dbo.PMS_JobOrder AS j ON w.JobOrderID = j.ID LEFT OUTER JOIN
                      dbo.PMS_Customer AS c ON w.CustomerID = c.cust_Id LEFT OUTER JOIN
                      dbo.PMS_FGEntry AS cc ON w.ID = cc.cc_WorkOrderId LEFT OUTER JOIN
                      dbo.PMS_Units AS u ON u.ID = cc.cc_Unit LEFT OUTER JOIN
                      dbo.PMS_Units AS x ON x.ID = j.jobcart_Width_Unit LEFT OUTER JOIN
                      dbo.PMS_Units AS z ON z.ID = j.jobcart_Heights_Unit ON comp.comp_Id = c.cust_Company LEFT OUTER JOIN
                      dbo.PMS_Excise_Master INNER JOIN
                      dbo.PMS_ProductMaster ON dbo.PMS_Excise_Master.Auto_Id = dbo.PMS_ProductMaster.Excise_Code_Id ON 
                      j.jobcart_Prod_Cat = dbo.PMS_ProductMaster.Auto_Id LEFT OUTER JOIN
                      dbo.PMS_CustomerDeliveryLocation AS cdl ON gc.DeliveryLoc = cdl.custLoc_Id LEFT OUTER JOIN
                      dbo.PMS_Users AS usr ON usr.ID = c.cust_SalesPerson

GO
/****** Object:  View [dbo].[Invoice_TaxView]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Invoice_TaxView]
AS
SELECT     dbo.PMS_WorkOrder.ID, dbo.PMS_MasterSalesWorkOrderTax.wstax_Name, dbo.PMS_MasterTaxStructure.taxStr_Id, dbo.PMS_MasterTaxStructure.taxStr_Name, 
                      dbo.PMS_WorkOrder.WorkOrderID
FROM         dbo.PMS_MasterTaxStructure INNER JOIN
                      dbo.PMS_MasterSalesWorkOrderTax ON dbo.PMS_MasterTaxStructure.taxStr_Id = dbo.PMS_MasterSalesWorkOrderTax.wstax_Name LEFT OUTER JOIN
                      dbo.PMS_WorkOrder ON dbo.PMS_MasterSalesWorkOrderTax.wstax_WorkSaleOrderId = dbo.PMS_WorkOrder.ID

GO
/****** Object:  View [dbo].[misreports]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[misreports] As select ROW_NUMBER() OVER(ORDER BY pwe.entrydate DESC)AS RowNumber,pjo.Order_Name +'('+ pjo.Order_Id + ')' as Job_Card, c.cust_Id,w.id as workID, w.workOrderId,pwe.Unit as outunit,pwe.id, pjo.order_name,pm.name 'machine',pst.site, ps.name, work_datefrom, work_dateto, pjo.order_Id,pwe.userid, pwe.helper, pwe.Operator, pwe.assistant,CONVERT(Date, pwe.entrydate, 103) as entrydate, dd.dpd_FGQty, u.Unit, dd.dpd_Boxes,(select sum(Resources_Output) from pms_workentryresources pwer where pwer.workentry_id = pwe.id) 'Total Output' from pms_workentry pwe Left join PMS_sites pst on pst.id = pwe.Work_Godown Left join PMS_Machines pm on pm.id = pwe.Work_Machinary Left join PMS_Processes ps on ps.id = pwe.Work_Process Left join pms_joborder pjo on pjo.id = pwe.work_joborder Left join PMS_WorkOrder w on pwe.Work_WorkOrder = w.ID Left join PMS_Customer c on w.CustomerID = c.cust_id LEFT JOIN PMS_DispatchProDetails dd ON pwe.id = dd.dpd_WEId Left join PMS_Units u on dd.dpd_Unit = u.ID
GO
/****** Object:  View [dbo].[misreports_Export]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[misreports_Export]
AS
SELECT top 2000    ROW_NUMBER() OVER (ORDER BY pwe.id DESC) AS RowNumber, pwe.Operator, U.Name AS [Operator Name], pwe.assistant, 
U1.Name AS [Assistant Name], pwe.helper, U2.Name AS [Helper Name], c.cust_Id, c.cust_Name, pjo.order_Id, pjo.order_name, w.WorkOrderName, 
w.id AS workID, ps.name, pwe.Unit AS outunit, pwe.id, pm.name 'machine', pwe.entrydate, work_datefrom, work_dateto, pst.site, pwe.userid,
    (SELECT     sum(Resources_Output)
      FROM          pms_workentryresources pwer
      WHERE      pwer.workentry_id = pwe.id) 'Total Output'
FROM         pms_workentry pwe INNER JOIN
                      PMS_sites pst ON pst.id = pwe.Work_Godown INNER JOIN
                      PMS_Machines pm ON pm.id = pwe.Work_Machinary INNER JOIN
                      PMS_Processes ps ON ps.id = pwe.Work_Process INNER JOIN
                      pms_joborder pjo ON pjo.id = pwe.work_joborder INNER JOIN
                      PMS_WorkOrder w ON pwe.Work_WorkOrder = w.ID INNER JOIN
                      PMS_Customer c ON w.CustomerID = c.cust_id LEFT OUTER JOIN
                      PMS_Users U ON pwe.Operator = U.Username LEFT OUTER JOIN
                      PMS_Users U1 ON pwe.Assistant = U1.Username LEFT OUTER JOIN
                      PMS_Users U2 ON Pwe.Helper = U2.Username

GO
/****** Object:  View [dbo].[misreports1]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[misreports1]
AS
SELECT     ROW_NUMBER() OVER (ORDER BY pwe.id DESC) AS RowNumber, c.cust_Id, w.id AS workID, pwe.Unit AS outunit, pwe.id, pjo.order_name, pm.name 'machine', 
pst.site, ps.name, work_datefrom, work_dateto, pjo.order_Id, pwe.userid, pwe.helper, uoper.Name as Operator, pwe.assistant, CONVERT(Date, pwe.entrydate, 103) AS entrydate,
    (SELECT     sum(Resources_Output)
      FROM          pms_workentryresources pwer
      WHERE      pwer.workentry_id = pwe.id) 'Total Output'
FROM         pms_workentry pwe INNER JOIN
                      PMS_sites pst ON pst.id = pwe.Work_Godown INNER JOIN
                      PMS_Machines pm ON pm.id = pwe.Work_Machinary INNER JOIN
                      PMS_Processes ps ON ps.id = pwe.Work_Process INNER JOIN
                      pms_joborder pjo ON pjo.id = pwe.work_joborder INNER JOIN
                      PMS_WorkOrder w ON pwe.Work_WorkOrder = w.ID INNER JOIN
                      PMS_Customer c ON w.CustomerID = c.cust_id left join pms_users uoper on pwe.Operator=uoper.ID

GO
/****** Object:  View [dbo].[misreportsCount]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[misreportsCount] as
SELECT count(c.cust_Id) as totalRec        
	from  
	pms_workentry pwe  
	inner join PMS_sites pst on pst.id = pwe.Work_Godown  
	inner join PMS_Machines pm on pm.id = pwe.Work_Machinary  
	inner join PMS_Processes ps on ps.id = pwe.Work_Process   
	inner join pms_joborder pjo on pjo.id = pwe.work_joborder  
	inner join PMS_WorkOrder w on pwe.Work_WorkOrder = w.ID  
	inner join PMS_Customer c on w.CustomerID = c.cust_id

GO
/****** Object:  View [dbo].[openjobreports]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[openjobreports]
As
select pwe.Unit as outunit,pwe.id, pjo.order_name,pm.name 'machine',pst.site, ps.name, work_datefrom, work_dateto,
pjo.order_Id,pwe.userid, pwe.helper, pwe.assistant,pwe.entrydate,pwo.Status as openjob        
from
pms_workentry pwe
inner join PMS_sites pst on pst.id = pwe.Work_Godown
inner join PMS_Machines pm on pm.id = pwe.Work_Machinary
inner join PMS_Processes ps on ps.id = pwe.Work_Process 
inner join pms_joborder pjo on pjo.id = pwe.work_joborder
inner join pms_workorder pwo on pwo.id = pwe.work_workorder

GO
/****** Object:  View [dbo].[PerformaInvoice_View]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PerformaInvoice_View]
AS
SELECT     dbo.PMS_WorkOrder.work_Trans_Option, dbo.PMS_WorkOrder.work_Trans_Location, dbo.PMS_WorkOrder.work_Delivery_Location, 
                      dbo.PMS_WorkOrder.work_Trans_DebitNote, dbo.PMS_WorkOrder.Date, dbo.PMS_WorkOrder.WorkOrderID, dbo.PMS_WorkOrder.CustomerID, 
                      dbo.PMS_WorkOrder.work_po_no, dbo.PMS_WorkOrder.work_TrCat, dbo.PMS_WorkOrder.Status, dbo.PMS_WorkOrder.WorkOrderName, 
                      dbo.PMS_WorkOrder.JobOrderID, dbo.PMS_WorkOrder.Quantity, dbo.PMS_WorkOrder.Unit, dbo.PMS_WorkOrder.work_PrintFor, dbo.PMS_WorkOrder.Unit_Price, 
                      dbo.PMS_WorkOrder.SalesOrderDate, dbo.PMS_WorkOrder.FreightCharges, dbo.PMS_WorkOrder.BankCharges, dbo.PMS_WorkOrder.OctroiCharges, 
                      dbo.PMS_WorkOrder.TotalAmt, dbo.PMS_WorkOrder.chkFreight, dbo.PMS_WorkOrder.chkBank, dbo.PMS_WorkOrder.chkOctroi, dbo.PMS_WorkOrder.chkOther, 
                      dbo.PMS_WorkOrder.OtherCharges, dbo.PMS_WorkOrder.TtlINRincTAX, dbo.PMS_WorkOrder.JobInstruction, dbo.PMS_WorkOrder.POUnit, 
                      dbo.PMS_WorkOrder.POQty, dbo.PMS_WorkOrder.POChk, dbo.PMS_Customer.cust_Name, dbo.PMS_Customer.cust_Address, dbo.PMS_Customer.cust_No, 
                      dbo.PMS_Customer.cust_Company, dbo.PMS_Customer.cust_City, dbo.PMS_Customer.cust_State, dbo.PMS_Customer.cust_Country, 
                      dbo.PMS_Customer.cust_PhoneNo, dbo.PMS_Customer.cust_FaxNo, dbo.PMS_Customer.cust_Email, dbo.PMS_JobOrder.Order_Name, 
                      dbo.PMS_MasterTransport.trans_Name, dbo.PMS_TransportLocation.loc_Name, dbo.PMS_CustomerDeliveryLocation.custLoc_Address, 
                      dbo.PMS_Company.comp_Name, dbo.PMS_Company.comp_RegsAdd, dbo.PMS_Company.comp_corrAdd, dbo.PMS_Company.comp_PhoneNo, 
                      dbo.PMS_Company.comp_FaxNo, dbo.PMS_Company.comp_VatRegsNo, dbo.PMS_Company.comp_Bank, dbo.PMS_Company.comp_Branch, 
                      dbo.PMS_Company.comp_AccNo, dbo.PMS_Company.TIN_No, dbo.PMS_Company.ECC_No, dbo.PMS_Company.Pan_No, dbo.PMS_WorkOrder.work_po_date, 
                      dbo.PMS_Customer.cust_PayTermCode, dbo.PMS_GenerateChallan.chal_No, dbo.PMS_GenerateChallan.chal_Date, dbo.PMS_Invoice_Master.Invoice_No, 
                      dbo.PMS_Invoice_Master.Invoice_Date, dbo.PMS_Units.Unit AS Unit_Name, dbo.PMS_WorkOrder.ID
FROM         dbo.PMS_Units RIGHT OUTER JOIN
                      dbo.PMS_WorkOrder LEFT OUTER JOIN
                      dbo.PMS_Customer ON dbo.PMS_WorkOrder.CustomerID = dbo.PMS_Customer.cust_Id LEFT OUTER JOIN
                      dbo.PMS_JobOrder ON dbo.PMS_WorkOrder.JobOrderID = dbo.PMS_JobOrder.ID LEFT OUTER JOIN
                      dbo.PMS_TransportLocation ON dbo.PMS_WorkOrder.work_Trans_Location = dbo.PMS_TransportLocation.loc_Id LEFT OUTER JOIN
                      dbo.PMS_MasterTransport ON dbo.PMS_WorkOrder.work_Trans_Option = dbo.PMS_MasterTransport.trans_Id LEFT OUTER JOIN
                      dbo.PMS_CustomerDeliveryLocation ON dbo.PMS_WorkOrder.work_Delivery_Location = dbo.PMS_CustomerDeliveryLocation.custLoc_Id RIGHT OUTER JOIN
                      dbo.PMS_Company ON dbo.PMS_Customer.cust_Company = dbo.PMS_Company.comp_Id ON dbo.PMS_Units.ID = dbo.PMS_WorkOrder.Unit LEFT OUTER JOIN
                      dbo.PMS_Invoice_Master RIGHT OUTER JOIN
                      dbo.PMS_GenerateChallan ON dbo.PMS_Invoice_Master.Challan_ID = dbo.PMS_GenerateChallan.chal_ID ON 
                      dbo.PMS_WorkOrder.ID = dbo.PMS_GenerateChallan.chal_SO_No

GO
/****** Object:  View [dbo].[PMS_RMCATVeiw]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PMS_RMCATVeiw]
AS
SELECT     name, id
FROM         dbo.PMS_Category
WHERE     (categorytype = 1)

GO
/****** Object:  View [dbo].[RMCombined]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[RMCombined]
AS
SELECT     rw.ID, CASE rw.RM_Cat WHEN '20' THEN (CASE WHEN rw.mat_width IS NULL THEN rw.Name ELSE (CASE WHEN rw.mat_make IS NULL 
                      THEN ' ' ELSE mat_make + ' ' END + CASE WHEN rw.mat_width IS NULL THEN ' ' ELSE rw.mat_width + ' ' END + CASE WHEN rw.mat_width_unit IS NULL 
                      THEN ' X ' ELSE rw.mat_width_unit + ' X ' END + CASE WHEN rw.mat_GSM IS NULL THEN ' ' ELSE rw.mat_GSM + ' GSM ' END + CASE WHEN rw.mat_color IS NULL 
                      THEN ' ' ELSE rw.mat_color + ' ' END + CASE WHEN rw.mat_carbon IS NULL THEN ' ' ELSE rw.mat_carbon + ' ' END + CASE WHEN rw.mat_special IS NULL 
                      THEN ' ' ELSE rw.mat_special END) END) WHEN '121' THEN (CASE WHEN mat_height IS NULL THEN rw.Name ELSE (CASE WHEN mat_height IS NULL 
                      THEN ' ' ELSE mat_height + ' ' END + CASE WHEN mat_height_unit IS NULL THEN ' X ' ELSE mat_height_unit + ' X ' END + CASE WHEN mat_width IS NULL 
                      THEN ' ' ELSE mat_width + ' ' END + CASE WHEN mat_width_unit IS NULL THEN ' X ' ELSE mat_width_unit + ' X ' END + CASE WHEN mat_length IS NULL 
                      THEN ' ' ELSE mat_length + ' ' END + CASE WHEN mat_length_unit IS NULL THEN ' ' ELSE mat_length_unit END) END) 
                      WHEN '123' THEN (CASE WHEN mat_height IS NULL THEN rw.Name ELSE (CASE WHEN mat_height IS NULL 
                      THEN ' ' ELSE mat_height + ' ' END + CASE WHEN mat_height_unit IS NULL THEN ' X ' ELSE mat_height_unit + ' X ' END + CASE WHEN mat_width IS NULL 
                      THEN ' ' ELSE mat_width + ' ' END + CASE WHEN mat_width_unit IS NULL THEN ' ' ELSE mat_width_unit + ' ' END + CASE WHEN mat_color IS NULL 
                      THEN ' ' ELSE mat_color END) END) WHEN '148' THEN (CASE WHEN rw.mat_width = '' THEN rw.Name ELSE (CASE WHEN mat_width IS NULL 
                      THEN ' ' ELSE mat_width + ' ' END + CASE WHEN mat_width_unit IS NULL THEN ' ' ELSE mat_width_unit END + CASE WHEN mat_diameter IS NULL 
                      THEN ' ' ELSE mat_diameter + ' ' END + CASE WHEN mat_diameter_unit IS NULL THEN ' ' ELSE mat_diameter_unit END) END) 
                      WHEN '162' THEN (CASE WHEN rw.mat_width IS NULL THEN rw.Name ELSE (CASE WHEN mat_width IS NULL 
                      THEN ' ' ELSE mat_width + ' ' END + CASE WHEN mat_width_unit IS NULL THEN ' X ' ELSE mat_width_unit + ' X ' END + CASE WHEN mat_length IS NULL 
                      THEN ' ' ELSE mat_length + ' ' END + CASE WHEN mat_length_unit IS NULL THEN ' X ' ELSE mat_length_unit + ' X ' END + CASE WHEN mat_thickness IS NULL 
                      THEN ' ' ELSE mat_thickness END + CASE WHEN mat_thickness_unit IS NULL THEN ' ' ELSE mat_thickness_unit END) END) 
                      WHEN '21' THEN (CASE WHEN mat_color IS NULL THEN rw.Name ELSE (CASE WHEN mat_special IS NULL 
                      THEN ' ' ELSE mat_special + ' ' END + CASE WHEN mat_color IS NULL THEN ' ' ELSE mat_color + ' ' END) END) WHEN '134' THEN (CASE WHEN rw.mat_width IS NULL
                       THEN rw.Name ELSE (CASE WHEN mat_width IS NULL THEN ' ' ELSE mat_width + ' ' END + CASE WHEN mat_width_unit IS NULL 
                      THEN ' ' ELSE mat_width_unit END + CASE WHEN mat_diameter IS NULL THEN ' ' ELSE mat_diameter + ' ' END + CASE WHEN mat_diameter_unit IS NULL 
                      THEN ' ' ELSE mat_diameter_unit END) END) WHEN '171' THEN (CASE WHEN rw.mat_width IS NULL THEN rw.Name ELSE (CASE WHEN mat_width IS NULL 
                      THEN ' ' ELSE mat_width + ' ' END + CASE WHEN mat_width_unit IS NULL THEN ' X ' ELSE mat_width_unit + ' X ' END + CASE WHEN mat_length IS NULL 
                      THEN ' ' ELSE mat_length + ' ' END + CASE WHEN mat_length_unit IS NULL THEN ' X ' ELSE mat_length_unit + ' X ' END + CASE WHEN mat_thickness IS NULL 
                      THEN ' ' ELSE mat_thickness END + CASE WHEN mat_thickness_unit IS NULL THEN ' ' ELSE mat_thickness_unit END) END) ELSE rw.Name END AS Name
FROM         dbo.PMS_RawMaterial AS rw LEFT OUTER JOIN
                      dbo.PMS_Units AS unw ON rw.mat_width_unit = unw.ID LEFT OUTER JOIN
                      dbo.PMS_Units AS unh ON rw.mat_height_unit = unh.ID LEFT OUTER JOIN
                      dbo.PMS_Units AS unl ON rw.mat_length_unit = unl.ID LEFT OUTER JOIN
                      dbo.PMS_Units AS unt ON rw.mat_height_unit = unt.ID

GO
/****** Object:  View [dbo].[StateView]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[StateView]
AS
SELECT     TOP (100) PERCENT a.State_Id, a.State_Name, a.country_Id, a.State_Code, a.CreatedBy, a.CreatedOn, a.UpdatedBy, a.UpdatedOn, b.Country_Name
FROM         dbo.PMS_State AS a INNER JOIN
                      dbo.PMS_Country AS b ON a.country_Id = b.Country_Id
ORDER BY CAST(SUBSTRING(a.State_Id, 6, 10) AS int) DESC, SUBSTRING(a.State_Id, 1, 1) DESC

GO
/****** Object:  View [dbo].[SupplierView]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[SupplierView] As SELECT Row_Number() Over (Order by cast(substring(SupplierCode,6,6)as int)) As RowNum,a.CostCenter,a.SupplierCode,a.SupplierName,a.SupplierCategory,(Select c.city_Name from PMS_City c where c.City_Code=a.CityCode) AS city_Name,a.CityCode,a.StateCode,a.Status,a.SupplierType,(Select b.State_Name from PMS_State b where b.state_Code=a.StateCode) AS state_Name,(Select d.Status from PMS_SupplierVariables d where d.Auto_Id=a.Status) AS Status1 ,(Select d.CostCenter from PMS_SupplierVariables d where d.Auto_Id=a.CostCenter) AS CostCenter1,(Select d.SupplierCategory from PMS_SupplierVariables d where d.Auto_Id=a.SupplierType) AS SupplierCategory1,(Select d.SupplierLocation from PMS_SupplierVariables d where d.Auto_Id=a.SupplierLocation) AS SupplierLocation FROM (select SupplierCode,SupplierName,Supplier_UID,SupplierCategory,CityCode,StateCode,Status,Flag,CostCenter, SupplierType,SupplierLocation,Row_Number() Over (Order by cast(substring(SupplierCode,6,6)as int)) As RowNum from PMS_SupplierMaster) As a where   SupplierName like '%lipi%' 
GO
/****** Object:  View [dbo].[SupplierView1]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SupplierView1]
AS
SELECT     Row_Number() OVER (ORDER BY cast(substring(SupplierCode, 6, 6) AS int)) AS RowNum, a.CostCenter, a.SupplierCode, a.SupplierName, 
a.SupplierCategory,
    (SELECT     c.city_Name
      FROM          PMS_City c
      WHERE      c.City_Code = a.CityCode) AS city_Name, a.CityCode, a.StateCode, a.Status, a.SupplierType,
    (SELECT     b.State_Name
      FROM          PMS_State b
      WHERE      b.state_Code = a.StateCode) AS state_Name,
    (SELECT     d .Status
      FROM          PMS_SupplierVariables d
      WHERE      d .Auto_Id = a.Status) AS Status1,
    (SELECT     d .CostCenter
      FROM          PMS_SupplierVariables d
      WHERE      d .Auto_Id = a.CostCenter) AS CostCenter1,
    (SELECT     d .SupplierCategory
      FROM          PMS_SupplierVariables d
      WHERE      d .Auto_Id = a.SupplierType) AS SupplierCategory1,
    (SELECT     d .SupplierLocation
      FROM          PMS_SupplierVariables d
      WHERE      d .Auto_Id = a.SupplierLocation) AS SupplierLocation
FROM         (SELECT     SupplierCode, SupplierName, Supplier_UID, SupplierCategory, CityCode, StateCode, Status, Flag, CostCenter, SupplierType, 
                                              SupplierLocation, Row_Number() OVER (ORDER BY cast(substring(SupplierCode, 6, 6) AS int)) AS RowNum
FROM         PMS_SupplierMaster) AS a


GO
/****** Object:  View [dbo].[View_1]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_1]
AS
SELECT dbo.PMS_JobOrder.Order_Name, dbo.PMS_RawMaterial.Name AS Expr1, dbo.PMS_JobCard_Material_Requirement.Quantity, dbo.PMS_Units.Unit, 
               dbo.PMS_JobCard_Material_Requirement.wastage
FROM  dbo.PMS_JobOrder LEFT OUTER JOIN
               dbo.PMS_Product LEFT OUTER JOIN
               dbo.PMS_RawMaterial ON dbo.PMS_Product.Product_Category = dbo.PMS_RawMaterial.Product_Cat ON 
               dbo.PMS_JobOrder.jobcart_Prod_Cat = dbo.PMS_Product.Product_Category LEFT OUTER JOIN
               dbo.PMS_JobCard_Material_Requirement ON 
               dbo.PMS_Product.Product_Category = dbo.PMS_JobCard_Material_Requirement.RM_Product_Category LEFT OUTER JOIN
               dbo.PMS_Units ON dbo.PMS_JobCard_Material_Requirement.Material_Units = dbo.PMS_Units.ID

GO
/****** Object:  View [dbo].[View_ManageOpenJob]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_ManageOpenJob]
AS
SELECT TOP (100) PERCENT dbo.PMS_JobOrder.Order_Id, dbo.PMS_WorkOrder.WorkOrderID, dbo.PMS_Customer.cust_Name, dbo.PMS_WorkOrder.Quantity, 
               dbo.PMS_Units.Unit, dbo.PMS_Processes.Name, dbo.PMS_FGEntry.cc_FGqty AS [FG Quantity], dbo.PMS_FGEntry.cc_QtyDispatch AS [Dispatch Quantity]
FROM  dbo.PMS_WorkOrder LEFT OUTER JOIN
               dbo.PMS_Invoice_Master LEFT OUTER JOIN
               dbo.PMS_GenerateChallanDetails ON dbo.PMS_Invoice_Master.Challan_ID = dbo.PMS_GenerateChallanDetails.chal_ID ON 
               dbo.PMS_WorkOrder.WorkOrderID = dbo.PMS_GenerateChallanDetails.chalDet_WorkOrderId LEFT OUTER JOIN
               dbo.PMS_FGEntry ON dbo.PMS_WorkOrder.ID = dbo.PMS_FGEntry.cc_WorkOrderId LEFT OUTER JOIN
               dbo.PMS_Units ON dbo.PMS_WorkOrder.Unit = dbo.PMS_Units.ID LEFT OUTER JOIN
               dbo.PMS_JobOrder ON dbo.PMS_WorkOrder.JobOrderID = dbo.PMS_JobOrder.ID LEFT OUTER JOIN
               dbo.PMS_Customer ON dbo.PMS_WorkOrder.CustomerID = dbo.PMS_Customer.cust_Id LEFT OUTER JOIN
               dbo.PMS_JobOrderProcesses ON dbo.PMS_WorkOrder.JobOrderID = dbo.PMS_JobOrderProcesses.Id LEFT OUTER JOIN
               dbo.PMS_Processes ON dbo.PMS_JobOrderProcesses.joborder_Process = dbo.PMS_Processes.ID
ORDER BY dbo.PMS_WorkOrder.WorkOrderID

GO
/****** Object:  View [dbo].[View_OLD_ProductionREPORT]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_OLD_ProductionREPORT]
AS
SELECT dbo.PMS_Machines.Name AS [M/C Name], dbo.PMS_Users.Name, dbo.PMS_JobOrder.Order_Name AS [Order], dbo.PMS_RawMaterial.Name AS Resources, 
               dbo.PMS_WorkEntryResources_OutputPro.WERO_InPro_Qty AS Quantity, dbo.PMS_Units.Unit AS Units, 
               dbo.PMS_WorkEntryResources_OutputPro.WERO_IntPro_WestedQty AS Wastage, dbo.PMS_WorkEntry.EntryDate
FROM  dbo.PMS_JobOrder LEFT OUTER JOIN
               dbo.PMS_Users LEFT OUTER JOIN
               dbo.PMS_WorkEntry ON dbo.PMS_Users.ID = dbo.PMS_WorkEntry.Operator LEFT OUTER JOIN
               dbo.PMS_Machines ON dbo.PMS_WorkEntry.Work_Machinary = dbo.PMS_Machines.ID ON 
               dbo.PMS_JobOrder.ID = dbo.PMS_WorkEntry.Work_JobOrder LEFT OUTER JOIN
               dbo.PMS_WorkEntryResources_OutputPro LEFT OUTER JOIN
               dbo.PMS_Units ON dbo.PMS_WorkEntryResources_OutputPro.WERO_InPro_Unit = dbo.PMS_Units.ID LEFT OUTER JOIN
               dbo.PMS_RawMaterial ON dbo.PMS_WorkEntryResources_OutputPro.WERO_InPro_ResId = dbo.PMS_RawMaterial.ID ON 
               dbo.PMS_WorkEntry.ID = dbo.PMS_WorkEntryResources_OutputPro.WERO_WorkEntryId

GO
/****** Object:  View [dbo].[View_Production]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Production]
AS
SELECT dbo.PMS_Machines.Name, dbo.PMS_WorkEntry.Operator, dbo.PMS_JobOrder.Order_Name, dbo.PMS_RawMaterial.Name AS Resources, 
               dbo.PMS_JobCard_Material_Requirement.Quantity, dbo.PMS_Units.Unit, dbo.PMS_JobCard_Material_Requirement.wastage
FROM  dbo.PMS_RawMaterial LEFT OUTER JOIN
               dbo.PMS_JobCard_Material_Requirement ON 
               dbo.PMS_RawMaterial.Product_Cat = dbo.PMS_JobCard_Material_Requirement.RM_Product_Category LEFT OUTER JOIN
               dbo.PMS_WorkEntry LEFT OUTER JOIN
               dbo.PMS_Machines ON dbo.PMS_WorkEntry.Work_Machinary = dbo.PMS_Machines.ID LEFT OUTER JOIN
               dbo.PMS_JobOrder ON dbo.PMS_WorkEntry.Work_JobOrder = dbo.PMS_JobOrder.ID ON 
               dbo.PMS_JobCard_Material_Requirement.job_Card_id = dbo.PMS_JobOrder.ID LEFT OUTER JOIN
               dbo.PMS_Units ON dbo.PMS_WorkEntry.Unit = dbo.PMS_Units.ID

GO
/****** Object:  View [dbo].[View_Sales%20Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Sales%20Report]
AS
SELECT TOP (100) PERCENT dbo.PMS_Invoice_Master.Invoice_No, dbo.PMS_Invoice_Master.Invoice_Date, dbo.PMS_Invoice_Master.Destination, 
               dbo.PMS_WorkOrder_Tax.WorkOrderID AS Chal_So_No, dbo.PMS_Invoice_Master.Customer, dbo.PMS_Invoice_Master.GrandTotal, 
               dbo.PMS_Invoice_Master.TotalAmount AS Total, dbo.PMS_TaxDetails.tax_Name, dbo.PMS_TaxDetails.TaxAmountValue
FROM  dbo.PMS_Invoice_Master LEFT OUTER JOIN
               dbo.PMS_TaxDetails ON dbo.PMS_Invoice_Master.Invoice_No = dbo.PMS_TaxDetails.InvoiceNo LEFT OUTER JOIN
               dbo.PMS_WorkOrder_Tax ON dbo.PMS_TaxDetails.wstax_Id = dbo.PMS_WorkOrder_Tax.ID
ORDER BY dbo.PMS_Invoice_Master.Invoice_No

GO
/****** Object:  View [dbo].[workorder]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[workorder] As
select ROW_NUMBER() OVER(ORDER BY PMS_WorkOrder.id DESC)AS RowNumber, PMS_WorkOrder.id, workorderid, PMS_JobOrder.Order_Name + ' (' + PMS_JobOrder.Order_ID + ')' as Order_Name, CASE Status WHEN '0' THEN 'Closed' WHEN '1' THEN 'Open' END AS 'Status', workordername, 
CONVERT(VARCHAR(10),PMS_WorkOrder.Date,105) AS Date,PMS_WorkOrder.Quantity,cust.cust_Name 
FROM 
PMS_WorkOrder inner join PMS_JobOrder ON joborderid = PMS_JobOrder.ID 
LEFT JOIN PMS_Customer cust ON PMS_WorkOrder.CustomerID = cust.cust_Id

GO
/****** Object:  View [dbo].[workordercount]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[workordercount] As
select count(PMS_WorkOrder.id) as totalRec
FROM 
PMS_WorkOrder inner join PMS_JobOrder ON joborderid = PMS_JobOrder.ID 
LEFT JOIN PMS_Customer cust ON PMS_WorkOrder.CustomerID = cust.cust_Id

GO
ALTER TABLE [dbo].[ob_customer_feedback] ADD  CONSTRAINT [DF_ob_customer_feedback_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ob_customer_feedback] ADD  CONSTRAINT [DF_ob_customer_feedback_UpdatedOn]  DEFAULT (getdate()) FOR [UpdatedOn]
GO
ALTER TABLE [dbo].[ob_daily_report] ADD  CONSTRAINT [DF_ob_daily_report_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ob_daily_report] ADD  CONSTRAINT [DF_ob_daily_report_UpdatedOn]  DEFAULT (getdate()) FOR [UpdatedOn]
GO
ALTER TABLE [dbo].[PMS_Auto_Synchronise] ADD  CONSTRAINT [DF_PMS_Auto_Synchronise_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PMS_Dispatch_Partial_Part3] ADD  CONSTRAINT [DF_PMS_Dispatch_Partial_Part3_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PMS_Permissions] ADD  CONSTRAINT [DF_PMS_Permissions_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PMS_Permissions] ADD  CONSTRAINT [DF_PMS_Permissions_UpdatedOn]  DEFAULT (getdate()) FOR [UpdatedOn]
GO
ALTER TABLE [dbo].[PMS_ReqstModule_Details] ADD  CONSTRAINT [DF_PMS_ReqstModule_Details_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PMS_Stock_Transactions] ADD  CONSTRAINT [DF_PMS_Stock_Transactions_CurrentStock]  DEFAULT ((0)) FOR [CurrentStock]
GO
ALTER TABLE [dbo].[PMS_Stock_Transactions] ADD  CONSTRAINT [DF_PMS_Stock_Transactions_IssueQty]  DEFAULT ((0)) FOR [IssueQty]
GO
ALTER TABLE [dbo].[PMS_Stock_Transactions] ADD  CONSTRAINT [DF_PMS_Stock_Transactions_BalanceQty]  DEFAULT ((0)) FOR [BalanceQty]
GO
ALTER TABLE [dbo].[PMS_Stock_Transactions] ADD  CONSTRAINT [DF_PMS_Stock_Transactions_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PMS_WorkFlowEntry] ADD  CONSTRAINT [DF_PMS_WorkFlowEntry_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PMS_WorkFlowEntry] ADD  CONSTRAINT [DF_PMS_WorkFlowEntry_UpdatedOn]  DEFAULT (getdate()) FOR [UpdatedOn]
GO
ALTER TABLE [dbo].[PMS_WorkFlowMaster] ADD  CONSTRAINT [DF_PMS_WorkFlowMaster_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PMS_WorkFlowMaster] ADD  CONSTRAINT [DF_PMS_WorkFlowMaster_UpdatedOn]  DEFAULT (getdate()) FOR [UpdatedOn]
GO
ALTER TABLE [dbo].[PMS_WorkFlowMasterDetails] ADD  CONSTRAINT [DF_PMS_WorkFlowMasterDetails_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PMS_WorkFlowMasterDetails] ADD  CONSTRAINT [DF_PMS_WorkFlowMasterDetails_UpdatedOn]  DEFAULT (getdate()) FOR [UpdatedOn]
GO
ALTER TABLE [dbo].[PMS_WorkOrder_Multiple] ADD  CONSTRAINT [DF_PMS_WorkOrder_Multiple_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[PMS_WorkOrder_Multiple] ADD  CONSTRAINT [DF_PMS_WorkOrder_Multiple_UpdatedOn]  DEFAULT (getdate()) FOR [UpdatedOn]
GO
ALTER TABLE [dbo].[ob_customer_feedback]  WITH CHECK ADD  CONSTRAINT [FK_ob_customer_feedback_daily_report] FOREIGN KEY([report_id])
REFERENCES [dbo].[ob_daily_report] ([report_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ob_customer_feedback] CHECK CONSTRAINT [FK_ob_customer_feedback_daily_report]
GO
ALTER TABLE [dbo].[ob_new_ply_table]  WITH CHECK ADD  CONSTRAINT [FK_ob_new_ply_table_ob_new_order_booking] FOREIGN KEY([booking_id])
REFERENCES [dbo].[ob_new_order_booking] ([booking_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ob_new_ply_table] CHECK CONSTRAINT [FK_ob_new_ply_table_ob_new_order_booking]
GO
ALTER TABLE [dbo].[ply_table]  WITH CHECK ADD  CONSTRAINT [FK_ply_table] FOREIGN KEY([booking_id])
REFERENCES [dbo].[order_booking] ([booking_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ply_table] CHECK CONSTRAINT [FK_ply_table]
GO
ALTER TABLE [dbo].[PMS_AppraisalDetail]  WITH CHECK ADD FOREIGN KEY([AppraisalID])
REFERENCES [dbo].[PMS_Appraisal] ([ID])
GO
ALTER TABLE [dbo].[PMS_City]  WITH CHECK ADD  CONSTRAINT [FK_State_Id] FOREIGN KEY([state_Id])
REFERENCES [dbo].[PMS_State] ([State_Id])
GO
ALTER TABLE [dbo].[PMS_City] CHECK CONSTRAINT [FK_State_Id]
GO
ALTER TABLE [dbo].[PMS_CollectionDetails]  WITH CHECK ADD  CONSTRAINT [FK_PMS_CollectionDetails_PMS_CollectionForm] FOREIGN KEY([CollectionID])
REFERENCES [dbo].[PMS_CollectionForm] ([Collection_Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_CollectionDetails] CHECK CONSTRAINT [FK_PMS_CollectionDetails_PMS_CollectionForm]
GO
ALTER TABLE [dbo].[PMS_CollectionsDetails]  WITH CHECK ADD  CONSTRAINT [FK_PMS_CollectionsDetails_PMS_Collection] FOREIGN KEY([Collection_ID])
REFERENCES [dbo].[PMS_Collection] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_CollectionsDetails] CHECK CONSTRAINT [FK_PMS_CollectionsDetails_PMS_Collection]
GO
ALTER TABLE [dbo].[PMS_Company_BankDetails]  WITH CHECK ADD  CONSTRAINT [FK_PMS_Company_BankDetails_PMS_Company] FOREIGN KEY([Comp_ID])
REFERENCES [dbo].[PMS_Company] ([comp_Id])
GO
ALTER TABLE [dbo].[PMS_Company_BankDetails] CHECK CONSTRAINT [FK_PMS_Company_BankDetails_PMS_Company]
GO
ALTER TABLE [dbo].[PMS_Company_RTGS]  WITH CHECK ADD  CONSTRAINT [FK_Company_Supplier] FOREIGN KEY([Supplier_ID])
REFERENCES [dbo].[PMS_SupplierMaster] ([SupplierCode])
GO
ALTER TABLE [dbo].[PMS_Company_RTGS] CHECK CONSTRAINT [FK_Company_Supplier]
GO
ALTER TABLE [dbo].[PMS_Company_RTGS]  WITH CHECK ADD  CONSTRAINT [FK_PMS_Company_RTGS] FOREIGN KEY([Comp_BD_ID])
REFERENCES [dbo].[PMS_Company_BankDetails] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_Company_RTGS] CHECK CONSTRAINT [FK_PMS_Company_RTGS]
GO
ALTER TABLE [dbo].[PMS_CompanyPlants]  WITH CHECK ADD  CONSTRAINT [FK_PMS_CompanyPlants_Company] FOREIGN KEY([comp_ID])
REFERENCES [dbo].[PMS_Company] ([comp_Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_CompanyPlants] CHECK CONSTRAINT [FK_PMS_CompanyPlants_Company]
GO
ALTER TABLE [dbo].[PMS_Complain_Mgmt_System]  WITH CHECK ADD  CONSTRAINT [FK_User_Name] FOREIGN KEY([User_Name])
REFERENCES [dbo].[PMS_Users] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_Complain_Mgmt_System] CHECK CONSTRAINT [FK_User_Name]
GO
ALTER TABLE [dbo].[PMS_Config]  WITH CHECK ADD  CONSTRAINT [FK_PMS_Config_CreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[PMS_Users] ([ID])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[PMS_Config] CHECK CONSTRAINT [FK_PMS_Config_CreatedBy]
GO
ALTER TABLE [dbo].[PMS_Customer]  WITH CHECK ADD  CONSTRAINT [FK_Comp_Name_Tbl_Compny] FOREIGN KEY([cust_Company])
REFERENCES [dbo].[PMS_Company] ([comp_Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_Customer] CHECK CONSTRAINT [FK_Comp_Name_Tbl_Compny]
GO
ALTER TABLE [dbo].[PMS_Customer]  WITH CHECK ADD  CONSTRAINT [FK_CountryName_Tbl_Country] FOREIGN KEY([cust_Country])
REFERENCES [dbo].[PMS_Country] ([Country_Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_Customer] CHECK CONSTRAINT [FK_CountryName_Tbl_Country]
GO
ALTER TABLE [dbo].[PMS_Customer]  WITH CHECK ADD  CONSTRAINT [FK_Cust_State_Tbl_State] FOREIGN KEY([cust_State])
REFERENCES [dbo].[PMS_State] ([State_Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_Customer] CHECK CONSTRAINT [FK_Cust_State_Tbl_State]
GO
ALTER TABLE [dbo].[PMS_Customer]  WITH CHECK ADD  CONSTRAINT [FK_CustCity_Tbl_City] FOREIGN KEY([cust_City])
REFERENCES [dbo].[PMS_City] ([city_Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_Customer] CHECK CONSTRAINT [FK_CustCity_Tbl_City]
GO
ALTER TABLE [dbo].[PMS_Customer_Communication]  WITH CHECK ADD  CONSTRAINT [FK_cc_Department_Tbl_Departmnt] FOREIGN KEY([CC_Department])
REFERENCES [dbo].[PMS_Department] ([Auto_Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_Customer_Communication] CHECK CONSTRAINT [FK_cc_Department_Tbl_Departmnt]
GO
ALTER TABLE [dbo].[PMS_Dispatch_Partial_Part2]  WITH CHECK ADD  CONSTRAINT [FK_Dispatch_Partial_Part2_Part1] FOREIGN KEY([Part1_ID])
REFERENCES [dbo].[PMS_Dispatch_Partiat_Part1] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_Dispatch_Partial_Part2] CHECK CONSTRAINT [FK_Dispatch_Partial_Part2_Part1]
GO
ALTER TABLE [dbo].[PMS_Dispatch_Partial_Part3]  WITH CHECK ADD  CONSTRAINT [FK_PMS_Dispatch_Partial_Part3_Part1] FOREIGN KEY([Part1_ID])
REFERENCES [dbo].[PMS_Dispatch_Partiat_Part1] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_Dispatch_Partial_Part3] CHECK CONSTRAINT [FK_PMS_Dispatch_Partial_Part3_Part1]
GO
ALTER TABLE [dbo].[PMS_DispatchProDetails]  WITH CHECK ADD  CONSTRAINT [FK_PMS_DispatchProDetails_PMS_DispatchProDetails] FOREIGN KEY([dpd_WEId])
REFERENCES [dbo].[PMS_WorkEntry] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_DispatchProDetails] CHECK CONSTRAINT [FK_PMS_DispatchProDetails_PMS_DispatchProDetails]
GO
ALTER TABLE [dbo].[PMS_FGEntry]  WITH CHECK ADD  CONSTRAINT [FK_cc_WorkOrderId] FOREIGN KEY([cc_WorkOrderId])
REFERENCES [dbo].[PMS_WorkOrder] ([ID])
GO
ALTER TABLE [dbo].[PMS_FGEntry] CHECK CONSTRAINT [FK_cc_WorkOrderId]
GO
ALTER TABLE [dbo].[PMS_FGEntry]  WITH CHECK ADD  CONSTRAINT [FK_FGUnit] FOREIGN KEY([cc_Unit])
REFERENCES [dbo].[PMS_Units] ([ID])
GO
ALTER TABLE [dbo].[PMS_FGEntry] CHECK CONSTRAINT [FK_FGUnit]
GO
ALTER TABLE [dbo].[PMS_GeneralMaterialAllotment]  WITH CHECK ADD  CONSTRAINT [FK_RMItem] FOREIGN KEY([RM_Item])
REFERENCES [dbo].[PMS_RawMaterial] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_GeneralMaterialAllotment] CHECK CONSTRAINT [FK_RMItem]
GO
ALTER TABLE [dbo].[PMS_GeneralMaterialAllotment]  WITH CHECK ADD  CONSTRAINT [FK_Units] FOREIGN KEY([Unit])
REFERENCES [dbo].[PMS_Units] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_GeneralMaterialAllotment] CHECK CONSTRAINT [FK_Units]
GO
ALTER TABLE [dbo].[PMS_GeneralMaterialAllotment]  WITH CHECK ADD  CONSTRAINT [FK_Users] FOREIGN KEY([PersonName])
REFERENCES [dbo].[PMS_Users] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_GeneralMaterialAllotment] CHECK CONSTRAINT [FK_Users]
GO
ALTER TABLE [dbo].[PMS_GenerateChallan]  WITH CHECK ADD  CONSTRAINT [FK_chalan_SO_No_GenerateChalan] FOREIGN KEY([chal_SO_No])
REFERENCES [dbo].[PMS_WorkOrder] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_GenerateChallan] CHECK CONSTRAINT [FK_chalan_SO_No_GenerateChalan]
GO
ALTER TABLE [dbo].[PMS_GenerateChallan]  WITH CHECK ADD  CONSTRAINT [FK_DeliveryLoc] FOREIGN KEY([DeliveryLoc])
REFERENCES [dbo].[PMS_CustomerDeliveryLocation] ([custLoc_Id])
GO
ALTER TABLE [dbo].[PMS_GenerateChallan] CHECK CONSTRAINT [FK_DeliveryLoc]
GO
ALTER TABLE [dbo].[PMS_GenerateChallan]  WITH CHECK ADD  CONSTRAINT [FK_Generate_Challan_DelvLoc] FOREIGN KEY([DeliveryLoc])
REFERENCES [dbo].[PMS_CustomerDeliveryLocation] ([custLoc_Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_GenerateChallan] CHECK CONSTRAINT [FK_Generate_Challan_DelvLoc]
GO
ALTER TABLE [dbo].[PMS_GenerateChallanDetails]  WITH CHECK ADD  CONSTRAINT [FK_ChalD_ID] FOREIGN KEY([chal_ID])
REFERENCES [dbo].[PMS_GenerateChallan] ([chal_ID])
GO
ALTER TABLE [dbo].[PMS_GenerateChallanDetails] CHECK CONSTRAINT [FK_ChalD_ID]
GO
ALTER TABLE [dbo].[PMS_GenerateChallanDetails]  WITH CHECK ADD  CONSTRAINT [FK_chalDet_JobOrderId] FOREIGN KEY([chalDet_JobOrderId])
REFERENCES [dbo].[PMS_JobOrder] ([ID])
GO
ALTER TABLE [dbo].[PMS_GenerateChallanDetails] CHECK CONSTRAINT [FK_chalDet_JobOrderId]
GO
ALTER TABLE [dbo].[PMS_GRNMaster]  WITH CHECK ADD  CONSTRAINT [FK_GRN_Inward] FOREIGN KEY([Inward_ID])
REFERENCES [dbo].[PMS_InwardMaster] ([ID])
GO
ALTER TABLE [dbo].[PMS_GRNMaster] CHECK CONSTRAINT [FK_GRN_Inward]
GO
ALTER TABLE [dbo].[PMS_GRNMaster]  WITH CHECK ADD  CONSTRAINT [FK_Inward_GRN] FOREIGN KEY([Inward_ID])
REFERENCES [dbo].[PMS_InwardMaster] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_GRNMaster] CHECK CONSTRAINT [FK_Inward_GRN]
GO
ALTER TABLE [dbo].[PMS_GRNMaster]  WITH CHECK ADD  CONSTRAINT [FK_User_GRN] FOREIGN KEY([Receiver])
REFERENCES [dbo].[PMS_Users] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_GRNMaster] CHECK CONSTRAINT [FK_User_GRN]
GO
ALTER TABLE [dbo].[PMS_Ink_Mixture_Color]  WITH CHECK ADD  CONSTRAINT [FK_PMS_Ink_Mixture_Color_InkID_Ink_Mixture_ID] FOREIGN KEY([InkId])
REFERENCES [dbo].[PMS_Ink_Mixture] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_Ink_Mixture_Color] CHECK CONSTRAINT [FK_PMS_Ink_Mixture_Color_InkID_Ink_Mixture_ID]
GO
ALTER TABLE [dbo].[PMS_Ink_Mixture_Created]  WITH CHECK ADD  CONSTRAINT [FK_PMS_Ink_Mixture_Created_InkMixture_Ink_Mixture_Id] FOREIGN KEY([InkMixture])
REFERENCES [dbo].[PMS_Ink_Mixture] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_Ink_Mixture_Created] CHECK CONSTRAINT [FK_PMS_Ink_Mixture_Created_InkMixture_Ink_Mixture_Id]
GO
ALTER TABLE [dbo].[PMS_Inventory]  WITH CHECK ADD  CONSTRAINT [FK_NameInventory] FOREIGN KEY([Name])
REFERENCES [dbo].[PMS_RawMaterial] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_Inventory] CHECK CONSTRAINT [FK_NameInventory]
GO
ALTER TABLE [dbo].[PMS_InwardDocuments]  WITH CHECK ADD  CONSTRAINT [FK_Inward_ID] FOREIGN KEY([Inward_ID])
REFERENCES [dbo].[PMS_InwardMaster] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_InwardDocuments] CHECK CONSTRAINT [FK_Inward_ID]
GO
ALTER TABLE [dbo].[PMS_InwardMaster]  WITH CHECK ADD  CONSTRAINT [FK_CostCenter] FOREIGN KEY([Cost_Center])
REFERENCES [dbo].[PMS_SupplierVariables] ([Auto_Id])
GO
ALTER TABLE [dbo].[PMS_InwardMaster] CHECK CONSTRAINT [FK_CostCenter]
GO
ALTER TABLE [dbo].[PMS_InwardMaster]  WITH CHECK ADD  CONSTRAINT [FK_SupplierCode] FOREIGN KEY([Supplier_Id])
REFERENCES [dbo].[PMS_SupplierMaster] ([SupplierCode])
GO
ALTER TABLE [dbo].[PMS_InwardMaster] CHECK CONSTRAINT [FK_SupplierCode]
GO
ALTER TABLE [dbo].[PMS_InwardMaster]  WITH CHECK ADD  CONSTRAINT [FK_UserID] FOREIGN KEY([Receiver_Name])
REFERENCES [dbo].[PMS_Users] ([ID])
GO
ALTER TABLE [dbo].[PMS_InwardMaster] CHECK CONSTRAINT [FK_UserID]
GO
ALTER TABLE [dbo].[PMS_InwardMaterial]  WITH CHECK ADD  CONSTRAINT [FK_MaterialID] FOREIGN KEY([Inward_ID])
REFERENCES [dbo].[PMS_InwardMaster] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_InwardMaterial] CHECK CONSTRAINT [FK_MaterialID]
GO
ALTER TABLE [dbo].[PMS_JobCard_Machines]  WITH CHECK ADD  CONSTRAINT [FK_PMS_JobCard_Machines_PMS_JobOrder] FOREIGN KEY([JobCart_Id])
REFERENCES [dbo].[PMS_JobOrder] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_JobCard_Machines] CHECK CONSTRAINT [FK_PMS_JobCard_Machines_PMS_JobOrder]
GO
ALTER TABLE [dbo].[PMS_JobCard_Material_Requirement]  WITH NOCHECK ADD  CONSTRAINT [FK_MaterialUnit_jobCardMachines] FOREIGN KEY([Material_Units])
REFERENCES [dbo].[PMS_Units] ([ID])
ON UPDATE CASCADE
NOT FOR REPLICATION 
GO
ALTER TABLE [dbo].[PMS_JobCard_Material_Requirement] NOCHECK CONSTRAINT [FK_MaterialUnit_jobCardMachines]
GO
ALTER TABLE [dbo].[PMS_JobCard_Material_Requirement]  WITH CHECK ADD  CONSTRAINT [FK_PMS_JobCard_Material_Requirement_PMS_JobOrder] FOREIGN KEY([job_Card_id])
REFERENCES [dbo].[PMS_JobOrder] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_JobCard_Material_Requirement] CHECK CONSTRAINT [FK_PMS_JobCard_Material_Requirement_PMS_JobOrder]
GO
ALTER TABLE [dbo].[PMS_JobCard_Paper]  WITH CHECK ADD  CONSTRAINT [FK_PMS_JobCard_Paper_PMS_JobOrder] FOREIGN KEY([JobCart_Id])
REFERENCES [dbo].[PMS_JobOrder] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_JobCard_Paper] CHECK CONSTRAINT [FK_PMS_JobCard_Paper_PMS_JobOrder]
GO
ALTER TABLE [dbo].[PMS_JobCard_Perforation_Details]  WITH CHECK ADD  CONSTRAINT [FK_PMS_JobCard_Perforation_Details_PMS_JobOrder] FOREIGN KEY([JobCart_Id])
REFERENCES [dbo].[PMS_JobOrder] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_JobCard_Perforation_Details] CHECK CONSTRAINT [FK_PMS_JobCard_Perforation_Details_PMS_JobOrder]
GO
ALTER TABLE [dbo].[PMS_JobCard_PostPress]  WITH CHECK ADD  CONSTRAINT [FK_Cuting_LengthUnit_jobCardPostPress] FOREIGN KEY([Cutting_Length_Units])
REFERENCES [dbo].[PMS_Units] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_JobCard_PostPress] CHECK CONSTRAINT [FK_Cuting_LengthUnit_jobCardPostPress]
GO
ALTER TABLE [dbo].[PMS_JobCard_PostPress]  WITH CHECK ADD  CONSTRAINT [FK_Cuting_WidthUnit_jobCardPostPress] FOREIGN KEY([Cutting_Width_Units])
REFERENCES [dbo].[PMS_Units] ([ID])
GO
ALTER TABLE [dbo].[PMS_JobCard_PostPress] CHECK CONSTRAINT [FK_Cuting_WidthUnit_jobCardPostPress]
GO
ALTER TABLE [dbo].[PMS_JobCard_PostPress]  WITH CHECK ADD  CONSTRAINT [FK_PMS_JobCard_PostPress_PMS_JobOrder] FOREIGN KEY([JobCart_Id])
REFERENCES [dbo].[PMS_JobOrder] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_JobCard_PostPress] CHECK CONSTRAINT [FK_PMS_JobCard_PostPress_PMS_JobOrder]
GO
ALTER TABLE [dbo].[PMS_JobCard_PostPress_Packaging1]  WITH CHECK ADD  CONSTRAINT [FK_PMS_JobCard_PostPress_Packaging1_PMS_JobOrder] FOREIGN KEY([PostPress_Id])
REFERENCES [dbo].[PMS_JobOrder] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_JobCard_PostPress_Packaging1] CHECK CONSTRAINT [FK_PMS_JobCard_PostPress_Packaging1_PMS_JobOrder]
GO
ALTER TABLE [dbo].[PMS_JobCard_PrePress]  WITH CHECK ADD  CONSTRAINT [FK_Plates_length_Units_jobCardPrePress] FOREIGN KEY([Plates_length_Units])
REFERENCES [dbo].[PMS_Units] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_JobCard_PrePress] CHECK CONSTRAINT [FK_Plates_length_Units_jobCardPrePress]
GO
ALTER TABLE [dbo].[PMS_JobCard_PrePress]  WITH CHECK ADD  CONSTRAINT [FK_Plates_Thickness_Units_jobCardPrePress] FOREIGN KEY([Plates_Thickness_Units])
REFERENCES [dbo].[PMS_Units] ([ID])
GO
ALTER TABLE [dbo].[PMS_JobCard_PrePress] CHECK CONSTRAINT [FK_Plates_Thickness_Units_jobCardPrePress]
GO
ALTER TABLE [dbo].[PMS_JobCard_PrePress]  WITH CHECK ADD  CONSTRAINT [FK_PMS_JobCard_PrePress_PMS_JobOrder] FOREIGN KEY([JobCart_Id])
REFERENCES [dbo].[PMS_JobOrder] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_JobCard_PrePress] CHECK CONSTRAINT [FK_PMS_JobCard_PrePress_PMS_JobOrder]
GO
ALTER TABLE [dbo].[PMS_JobCard_PrePress_PrintingPlates]  WITH CHECK ADD  CONSTRAINT [FK_Color_jobCardPrintingPlates] FOREIGN KEY([Color])
REFERENCES [dbo].[PMS_Color] ([Auto_Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_JobCard_PrePress_PrintingPlates] CHECK CONSTRAINT [FK_Color_jobCardPrintingPlates]
GO
ALTER TABLE [dbo].[PMS_JobCard_PrePress_PrintingPlates]  WITH CHECK ADD  CONSTRAINT [FK_PrePress_PrintingPlates] FOREIGN KEY([PrePress_Id])
REFERENCES [dbo].[PMS_JobOrder] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_JobCard_PrePress_PrintingPlates] CHECK CONSTRAINT [FK_PrePress_PrintingPlates]
GO
ALTER TABLE [dbo].[PMS_JobCard_ProcessSelection]  WITH CHECK ADD  CONSTRAINT [FK_add_Machines_jobCardSelection] FOREIGN KEY([add_Machines])
REFERENCES [dbo].[PMS_Machines] ([ID])
GO
ALTER TABLE [dbo].[PMS_JobCard_ProcessSelection] CHECK CONSTRAINT [FK_add_Machines_jobCardSelection]
GO
ALTER TABLE [dbo].[PMS_JobCard_ProcessSelection]  WITH CHECK ADD  CONSTRAINT [FK_Machines_jobCardSelection] FOREIGN KEY([Machines])
REFERENCES [dbo].[PMS_Machines] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_JobCard_ProcessSelection] CHECK CONSTRAINT [FK_Machines_jobCardSelection]
GO
ALTER TABLE [dbo].[PMS_JobCard_ProcessSelection]  WITH CHECK ADD  CONSTRAINT [FK_PMS_JobCard_ProcessSelection_PMS_JobOrder] FOREIGN KEY([JobCart_Id])
REFERENCES [dbo].[PMS_JobOrder] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_JobCard_ProcessSelection] CHECK CONSTRAINT [FK_PMS_JobCard_ProcessSelection_PMS_JobOrder]
GO
ALTER TABLE [dbo].[PMS_JobCard_ProcessSelection]  WITH CHECK ADD  CONSTRAINT [FK_Process_jobCardSelection] FOREIGN KEY([Process])
REFERENCES [dbo].[PMS_Processes] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_JobCard_ProcessSelection] CHECK CONSTRAINT [FK_Process_jobCardSelection]
GO
ALTER TABLE [dbo].[PMS_JobCard_SpecificDetails]  WITH CHECK ADD  CONSTRAINT [FK_PMS_JobCard_SpecificDetails_PMS_JobCard_SpecificDetails] FOREIGN KEY([Cutting_Machine])
REFERENCES [dbo].[PMS_Machines] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_JobCard_SpecificDetails] CHECK CONSTRAINT [FK_PMS_JobCard_SpecificDetails_PMS_JobCard_SpecificDetails]
GO
ALTER TABLE [dbo].[PMS_JobCard_SpecificDetails]  WITH CHECK ADD  CONSTRAINT [FK_PMS_JobCard_SpecificDetails_PMS_JobOrder] FOREIGN KEY([JobCart_Id])
REFERENCES [dbo].[PMS_JobOrder] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_JobCard_SpecificDetails] CHECK CONSTRAINT [FK_PMS_JobCard_SpecificDetails_PMS_JobOrder]
GO
ALTER TABLE [dbo].[PMS_JobCard_UploadFile]  WITH CHECK ADD  CONSTRAINT [FK_PMS_JobCard_UploadFile_PMS_JobOrder] FOREIGN KEY([JobCart_Id])
REFERENCES [dbo].[PMS_JobOrder] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_JobCard_UploadFile] CHECK CONSTRAINT [FK_PMS_JobCard_UploadFile_PMS_JobOrder]
GO
ALTER TABLE [dbo].[PMS_JobOrder]  WITH CHECK ADD  CONSTRAINT [FK_Height_jobOrder] FOREIGN KEY([jobcart_Heights_Unit])
REFERENCES [dbo].[PMS_Units] ([ID])
GO
ALTER TABLE [dbo].[PMS_JobOrder] CHECK CONSTRAINT [FK_Height_jobOrder]
GO
ALTER TABLE [dbo].[PMS_JobOrder]  WITH CHECK ADD  CONSTRAINT [FK_Width_jobOrder] FOREIGN KEY([jobcart_Width_Unit])
REFERENCES [dbo].[PMS_Units] ([ID])
GO
ALTER TABLE [dbo].[PMS_JobOrder] CHECK CONSTRAINT [FK_Width_jobOrder]
GO
ALTER TABLE [dbo].[PMS_MachinenMaintenance]  WITH CHECK ADD  CONSTRAINT [Fk_machine_Mach_Mainteanance] FOREIGN KEY([mm_Machine])
REFERENCES [dbo].[PMS_Machines] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_MachinenMaintenance] CHECK CONSTRAINT [Fk_machine_Mach_Mainteanance]
GO
ALTER TABLE [dbo].[PMS_MasterJobCart_Process]  WITH CHECK ADD  CONSTRAINT [FK_proc_JobCart_Id] FOREIGN KEY([proc_JobCart_Id])
REFERENCES [dbo].[PMS_JobOrder] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_MasterJobCart_Process] CHECK CONSTRAINT [FK_proc_JobCart_Id]
GO
ALTER TABLE [dbo].[PMS_MasterSalesWorkOrderTax]  WITH CHECK ADD  CONSTRAINT [FK_wstax_name_SalesOrderTax] FOREIGN KEY([wstax_Name])
REFERENCES [dbo].[PMS_MasterTaxStructure] ([taxStr_Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_MasterSalesWorkOrderTax] CHECK CONSTRAINT [FK_wstax_name_SalesOrderTax]
GO
ALTER TABLE [dbo].[PMS_MasterTaxStructureDetails]  WITH CHECK ADD  CONSTRAINT [FK_taxStrDet_taxSrtId] FOREIGN KEY([taxStrDet_taxSrtId])
REFERENCES [dbo].[PMS_MasterTaxStructure] ([taxStr_Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_MasterTaxStructureDetails] CHECK CONSTRAINT [FK_taxStrDet_taxSrtId]
GO
ALTER TABLE [dbo].[PMS_MasterTransportLocation]  WITH CHECK ADD  CONSTRAINT [FK_transLoc_Location] FOREIGN KEY([transLoc_Location])
REFERENCES [dbo].[PMS_TransportLocation] ([loc_Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_MasterTransportLocation] CHECK CONSTRAINT [FK_transLoc_Location]
GO
ALTER TABLE [dbo].[PMS_MasterTransportLocation]  WITH CHECK ADD  CONSTRAINT [FK_transLoc_transpoter] FOREIGN KEY([transLoc_transpoter])
REFERENCES [dbo].[PMS_MasterTransport] ([trans_Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_MasterTransportLocation] CHECK CONSTRAINT [FK_transLoc_transpoter]
GO
ALTER TABLE [dbo].[PMS_OfficeWorkEntry]  WITH CHECK ADD  CONSTRAINT [Fk_Task_Id] FOREIGN KEY([Task_Id])
REFERENCES [dbo].[PMS_OfficeWorkTask] ([Auto_Id])
GO
ALTER TABLE [dbo].[PMS_OfficeWorkEntry] CHECK CONSTRAINT [Fk_Task_Id]
GO
ALTER TABLE [dbo].[PMS_OfficeWorkTask]  WITH CHECK ADD  CONSTRAINT [Fk_Officeworktask_Activity] FOREIGN KEY([Activity])
REFERENCES [dbo].[PMS_Activity] ([Auto_Id])
GO
ALTER TABLE [dbo].[PMS_OfficeWorkTask] CHECK CONSTRAINT [Fk_Officeworktask_Activity]
GO
ALTER TABLE [dbo].[PMS_OfficeWorkTask]  WITH CHECK ADD  CONSTRAINT [Fk_Officeworktask_Job_Card] FOREIGN KEY([Job_Card])
REFERENCES [dbo].[PMS_JobOrder] ([ID])
GO
ALTER TABLE [dbo].[PMS_OfficeWorkTask] CHECK CONSTRAINT [Fk_Officeworktask_Job_Card]
GO
ALTER TABLE [dbo].[PMS_OfficeWorkTask]  WITH CHECK ADD  CONSTRAINT [Fk_Officeworktask_work_order] FOREIGN KEY([Work_Order])
REFERENCES [dbo].[PMS_WorkOrder] ([ID])
GO
ALTER TABLE [dbo].[PMS_OfficeWorkTask] CHECK CONSTRAINT [Fk_Officeworktask_work_order]
GO
ALTER TABLE [dbo].[PMS_OfficeWorkTask]  WITH CHECK ADD  CONSTRAINT [FK_PMS_OfficeWorkTask_PMS_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[PMS_Users] ([ID])
GO
ALTER TABLE [dbo].[PMS_OfficeWorkTask] CHECK CONSTRAINT [FK_PMS_OfficeWorkTask_PMS_Users]
GO
ALTER TABLE [dbo].[PMS_OfficeWorkTask]  WITH CHECK ADD  CONSTRAINT [FK_PMS_OfficeWorkTask_PMS_Users1] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[PMS_Users] ([ID])
GO
ALTER TABLE [dbo].[PMS_OfficeWorkTask] CHECK CONSTRAINT [FK_PMS_OfficeWorkTask_PMS_Users1]
GO
ALTER TABLE [dbo].[PMS_Outward]  WITH CHECK ADD  CONSTRAINT [FK_Buyer_Name] FOREIGN KEY([Buyer_Name])
REFERENCES [dbo].[PMS_Buyer] ([Buyer_Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_Outward] CHECK CONSTRAINT [FK_Buyer_Name]
GO
ALTER TABLE [dbo].[PMS_Outward]  WITH CHECK ADD  CONSTRAINT [FK_SoldBy] FOREIGN KEY([Sold_By])
REFERENCES [dbo].[PMS_Users] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_Outward] CHECK CONSTRAINT [FK_SoldBy]
GO
ALTER TABLE [dbo].[PMS_OutwardDetails]  WITH CHECK ADD  CONSTRAINT [FK_PMS_OutwardDetails_PMS_Outward] FOREIGN KEY([Outward_Id])
REFERENCES [dbo].[PMS_Outward] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_OutwardDetails] CHECK CONSTRAINT [FK_PMS_OutwardDetails_PMS_Outward]
GO
ALTER TABLE [dbo].[PMS_OutwardDetails]  WITH CHECK ADD  CONSTRAINT [FK_PMS_OutwardDetails_PMS_Wastage] FOREIGN KEY([Item])
REFERENCES [dbo].[PMS_Wastage] ([Wastage_Id])
GO
ALTER TABLE [dbo].[PMS_OutwardDetails] CHECK CONSTRAINT [FK_PMS_OutwardDetails_PMS_Wastage]
GO
ALTER TABLE [dbo].[Pms_PriviledgeRoleDetails]  WITH CHECK ADD  CONSTRAINT [Fk_PriviledgeID] FOREIGN KEY([PriviledgeID])
REFERENCES [dbo].[Pms_PriviledgeMaster] ([Id])
GO
ALTER TABLE [dbo].[Pms_PriviledgeRoleDetails] CHECK CONSTRAINT [Fk_PriviledgeID]
GO
ALTER TABLE [dbo].[Pms_PriviledgeRoleDetails]  WITH CHECK ADD  CONSTRAINT [Fk_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Pms_RoleMaster] ([Id])
GO
ALTER TABLE [dbo].[Pms_PriviledgeRoleDetails] CHECK CONSTRAINT [Fk_RoleId]
GO
ALTER TABLE [dbo].[PMS_Processes]  WITH CHECK ADD  CONSTRAINT [FK_PCategory] FOREIGN KEY([Category])
REFERENCES [dbo].[PMS_ProcessCategory] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_Processes] CHECK CONSTRAINT [FK_PCategory]
GO
ALTER TABLE [dbo].[PMS_ProductMaster_ProcessSelection]  WITH CHECK ADD  CONSTRAINT [FK_PMS_ProductMaster_ProcessSelection_PMS_Product] FOREIGN KEY([ProductMaster_Id])
REFERENCES [dbo].[PMS_Product] ([Auto_Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_ProductMaster_ProcessSelection] CHECK CONSTRAINT [FK_PMS_ProductMaster_ProcessSelection_PMS_Product]
GO
ALTER TABLE [dbo].[PMS_Proforma_Description]  WITH CHECK ADD  CONSTRAINT [FK_PMS_Proforma_Description_PMS_Proforma] FOREIGN KEY([Proforma_ID])
REFERENCES [dbo].[PMS_Proforma] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_Proforma_Description] CHECK CONSTRAINT [FK_PMS_Proforma_Description_PMS_Proforma]
GO
ALTER TABLE [dbo].[PMS_ProjectClosureDetails]  WITH CHECK ADD  CONSTRAINT [FK_PMS_ProjectClosureDetails_PMS_ProjectDocument] FOREIGN KEY([Project_ClosureID])
REFERENCES [dbo].[PMS_ProjectDocument] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_ProjectClosureDetails] CHECK CONSTRAINT [FK_PMS_ProjectClosureDetails_PMS_ProjectDocument]
GO
ALTER TABLE [dbo].[PMS_ProjectDocDetails]  WITH CHECK ADD  CONSTRAINT [FK_PMS_ProjectDocDetails_PMS_ProjectDocument] FOREIGN KEY([Project_Id])
REFERENCES [dbo].[PMS_ProjectDocument] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_ProjectDocDetails] CHECK CONSTRAINT [FK_PMS_ProjectDocDetails_PMS_ProjectDocument]
GO
ALTER TABLE [dbo].[Pms_PurchaseRequestForm]  WITH CHECK ADD  CONSTRAINT [FK_Pms_PurchaseRequestForm_PMS_RawMaterial] FOREIGN KEY([RMProductSubCategory])
REFERENCES [dbo].[PMS_RawMaterial] ([ID])
GO
ALTER TABLE [dbo].[Pms_PurchaseRequestForm] CHECK CONSTRAINT [FK_Pms_PurchaseRequestForm_PMS_RawMaterial]
GO
ALTER TABLE [dbo].[PMS_Quotation_Description]  WITH CHECK ADD  CONSTRAINT [FK_PMS_Quotation_Description_PMS_Quotation_Description] FOREIGN KEY([Quot_ID])
REFERENCES [dbo].[PMS_Quotation_Master] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_Quotation_Description] CHECK CONSTRAINT [FK_PMS_Quotation_Description_PMS_Quotation_Description]
GO
ALTER TABLE [dbo].[PMS_Quotation_Master]  WITH CHECK ADD  CONSTRAINT [FK_PMS_Quotation_Master_PMS_Quotation_Master] FOREIGN KEY([ID])
REFERENCES [dbo].[PMS_Quotation_Master] ([ID])
GO
ALTER TABLE [dbo].[PMS_Quotation_Master] CHECK CONSTRAINT [FK_PMS_Quotation_Master_PMS_Quotation_Master]
GO
ALTER TABLE [dbo].[PMS_Rate]  WITH CHECK ADD  CONSTRAINT [FK_PMS_Rate_PMS_Buyer] FOREIGN KEY([Buyer])
REFERENCES [dbo].[PMS_Buyer] ([Buyer_Id])
GO
ALTER TABLE [dbo].[PMS_Rate] CHECK CONSTRAINT [FK_PMS_Rate_PMS_Buyer]
GO
ALTER TABLE [dbo].[PMS_ReqstModule_Details]  WITH CHECK ADD  CONSTRAINT [FK_PMS_ReqstModule_Details_PMS_ChangeRequestModule] FOREIGN KEY([Request_ID])
REFERENCES [dbo].[PMS_ChangeRequestModule] ([Reqst_Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_ReqstModule_Details] CHECK CONSTRAINT [FK_PMS_ReqstModule_Details_PMS_ChangeRequestModule]
GO
ALTER TABLE [dbo].[Pms_RoleMaster]  WITH CHECK ADD  CONSTRAINT [FK_Pms_RoleMaster_PMS_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[PMS_Users] ([ID])
GO
ALTER TABLE [dbo].[Pms_RoleMaster] CHECK CONSTRAINT [FK_Pms_RoleMaster_PMS_Users]
GO
ALTER TABLE [dbo].[PMS_Sites]  WITH CHECK ADD  CONSTRAINT [FK_Comp_Name_Tbl_Sites] FOREIGN KEY([Name])
REFERENCES [dbo].[PMS_Company] ([comp_Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_Sites] CHECK CONSTRAINT [FK_Comp_Name_Tbl_Sites]
GO
ALTER TABLE [dbo].[PMS_Sites]  WITH CHECK ADD  CONSTRAINT [FK_PMS_Site] FOREIGN KEY([Name])
REFERENCES [dbo].[PMS_Company] ([comp_Id])
GO
ALTER TABLE [dbo].[PMS_Sites] CHECK CONSTRAINT [FK_PMS_Site]
GO
ALTER TABLE [dbo].[PMS_SpareParts]  WITH CHECK ADD  CONSTRAINT [FK_PMS_SpareParts_PMS_SpareParts] FOREIGN KEY([Unit])
REFERENCES [dbo].[PMS_Units] ([ID])
GO
ALTER TABLE [dbo].[PMS_SpareParts] CHECK CONSTRAINT [FK_PMS_SpareParts_PMS_SpareParts]
GO
ALTER TABLE [dbo].[PMS_State]  WITH CHECK ADD  CONSTRAINT [FK_PMS_State_PMS_Country] FOREIGN KEY([country_Id])
REFERENCES [dbo].[PMS_Country] ([Country_Id])
GO
ALTER TABLE [dbo].[PMS_State] CHECK CONSTRAINT [FK_PMS_State_PMS_Country]
GO
ALTER TABLE [dbo].[PMS_SupplierBankDetails]  WITH CHECK ADD  CONSTRAINT [FK_PMS_SupplierBankDetails_PMS_SupplierMaster] FOREIGN KEY([Supplier_UID])
REFERENCES [dbo].[PMS_SupplierMaster] ([SupplierCode])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_SupplierBankDetails] CHECK CONSTRAINT [FK_PMS_SupplierBankDetails_PMS_SupplierMaster]
GO
ALTER TABLE [dbo].[PMS_SupplierCategory]  WITH CHECK ADD  CONSTRAINT [FK_PMS_SupplierCategory_PMS_SupplierMaster1] FOREIGN KEY([Supplier_UID])
REFERENCES [dbo].[PMS_SupplierMaster] ([SupplierCode])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_SupplierCategory] CHECK CONSTRAINT [FK_PMS_SupplierCategory_PMS_SupplierMaster1]
GO
ALTER TABLE [dbo].[PMS_SupplierContactPerson]  WITH CHECK ADD  CONSTRAINT [FK_PMS_SupplierContactPerson_PMS_SupplierMaster] FOREIGN KEY([supplier_UID])
REFERENCES [dbo].[PMS_SupplierMaster] ([SupplierCode])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_SupplierContactPerson] CHECK CONSTRAINT [FK_PMS_SupplierContactPerson_PMS_SupplierMaster]
GO
ALTER TABLE [dbo].[PMS_TraningEntry]  WITH CHECK ADD  CONSTRAINT [FK_TrJobOrder_Tbl_TrainingEntry] FOREIGN KEY([tr_JobOrder])
REFERENCES [dbo].[PMS_JobOrder] ([ID])
GO
ALTER TABLE [dbo].[PMS_TraningEntry] CHECK CONSTRAINT [FK_TrJobOrder_Tbl_TrainingEntry]
GO
ALTER TABLE [dbo].[PMS_TraningEntry]  WITH CHECK ADD  CONSTRAINT [FK_TrMachine_TblTraningentry] FOREIGN KEY([tr_Machine])
REFERENCES [dbo].[PMS_Machines] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_TraningEntry] CHECK CONSTRAINT [FK_TrMachine_TblTraningentry]
GO
ALTER TABLE [dbo].[PMS_TraningEntry]  WITH CHECK ADD  CONSTRAINT [FK_TrProcess_TblTraningEntry] FOREIGN KEY([tr_Process])
REFERENCES [dbo].[PMS_Processes] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_TraningEntry] CHECK CONSTRAINT [FK_TrProcess_TblTraningEntry]
GO
ALTER TABLE [dbo].[PMS_TraningEntry]  WITH CHECK ADD  CONSTRAINT [FK_TrWorkOrder_Tbl_TrainingEntry] FOREIGN KEY([tr_WorkOrder])
REFERENCES [dbo].[PMS_WorkOrder] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_TraningEntry] CHECK CONSTRAINT [FK_TrWorkOrder_Tbl_TrainingEntry]
GO
ALTER TABLE [dbo].[PMS_TransferDoc]  WITH CHECK ADD  CONSTRAINT [FK_PMS_TransferDoc_Receiver] FOREIGN KEY([Receiver_Name])
REFERENCES [dbo].[PMS_Users] ([ID])
GO
ALTER TABLE [dbo].[PMS_TransferDoc] CHECK CONSTRAINT [FK_PMS_TransferDoc_Receiver]
GO
ALTER TABLE [dbo].[PMS_TransferDoc]  WITH CHECK ADD  CONSTRAINT [FK_PMS_TransferDoc_Sender] FOREIGN KEY([Send_By])
REFERENCES [dbo].[PMS_Users] ([ID])
GO
ALTER TABLE [dbo].[PMS_TransferDoc] CHECK CONSTRAINT [FK_PMS_TransferDoc_Sender]
GO
ALTER TABLE [dbo].[PMS_UploadDesign_Details]  WITH CHECK ADD  CONSTRAINT [FK_PMS_UploadDesign_Details_PMS_UploadDesign1] FOREIGN KEY([Design_Upload_Id])
REFERENCES [dbo].[PMS_UploadDesign] ([up_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_UploadDesign_Details] CHECK CONSTRAINT [FK_PMS_UploadDesign_Details_PMS_UploadDesign1]
GO
ALTER TABLE [dbo].[PMS_UserLoginLog]  WITH CHECK ADD  CONSTRAINT [FK_PMS_UserLoginLog_PMS_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[PMS_Users] ([ID])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[PMS_UserLoginLog] CHECK CONSTRAINT [FK_PMS_UserLoginLog_PMS_Users]
GO
ALTER TABLE [dbo].[Pms_UserRoleMaster]  WITH CHECK ADD  CONSTRAINT [FK_Pms_UserRoleMaster_Pms_RoleMaster] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Pms_RoleMaster] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Pms_UserRoleMaster] CHECK CONSTRAINT [FK_Pms_UserRoleMaster_Pms_RoleMaster]
GO
ALTER TABLE [dbo].[PMS_Wastage]  WITH CHECK ADD  CONSTRAINT [FK_PMS_Wastage_PMS_Units] FOREIGN KEY([Unit])
REFERENCES [dbo].[PMS_Units] ([ID])
GO
ALTER TABLE [dbo].[PMS_Wastage] CHECK CONSTRAINT [FK_PMS_Wastage_PMS_Units]
GO
ALTER TABLE [dbo].[PMS_Wastage]  WITH CHECK ADD  CONSTRAINT [FK_PMS_Wastage_PMS_Users] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[PMS_Users] ([ID])
GO
ALTER TABLE [dbo].[PMS_Wastage] CHECK CONSTRAINT [FK_PMS_Wastage_PMS_Users]
GO
ALTER TABLE [dbo].[PMS_WorkFlowEntry]  WITH CHECK ADD  CONSTRAINT [Fk_WorkFlowEntry_Workflow] FOREIGN KEY([WorkFlow])
REFERENCES [dbo].[PMS_WorkFlowMaster] ([WorkFlowId])
GO
ALTER TABLE [dbo].[PMS_WorkFlowEntry] CHECK CONSTRAINT [Fk_WorkFlowEntry_Workflow]
GO
ALTER TABLE [dbo].[PMS_WorkFlowMasterDetails]  WITH CHECK ADD  CONSTRAINT [Fk_WorkFlowMasterDetails_Activity] FOREIGN KEY([Activity])
REFERENCES [dbo].[PMS_Activity] ([Auto_Id])
GO
ALTER TABLE [dbo].[PMS_WorkFlowMasterDetails] CHECK CONSTRAINT [Fk_WorkFlowMasterDetails_Activity]
GO
ALTER TABLE [dbo].[PMS_WorkFlowMasterDetails]  WITH CHECK ADD  CONSTRAINT [Fk_WorkFlowMasterDetails_ParentId] FOREIGN KEY([ParentId])
REFERENCES [dbo].[PMS_WorkFlowMaster] ([WorkFlowId])
GO
ALTER TABLE [dbo].[PMS_WorkFlowMasterDetails] CHECK CONSTRAINT [Fk_WorkFlowMasterDetails_ParentId]
GO
ALTER TABLE [dbo].[PMS_WorkOrder]  WITH CHECK ADD  CONSTRAINT [FK_JobOderId_workorder] FOREIGN KEY([JobOrderID])
REFERENCES [dbo].[PMS_JobOrder] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_WorkOrder] CHECK CONSTRAINT [FK_JobOderId_workorder]
GO
ALTER TABLE [dbo].[PMS_WorkOrder]  WITH CHECK ADD  CONSTRAINT [fk_unit] FOREIGN KEY([Unit])
REFERENCES [dbo].[PMS_Units] ([ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[PMS_WorkOrder] CHECK CONSTRAINT [fk_unit]
GO
ALTER TABLE [dbo].[PMS_WorkOrder_ClosureDetail]  WITH CHECK ADD  CONSTRAINT [FK_PMS_WorkOrder_ClosureDetail_PMS_WorkOrder] FOREIGN KEY([SO_ID])
REFERENCES [dbo].[PMS_WorkOrder] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_WorkOrder_ClosureDetail] CHECK CONSTRAINT [FK_PMS_WorkOrder_ClosureDetail_PMS_WorkOrder]
GO
ALTER TABLE [dbo].[PMS_WorkOrder_Tax]  WITH CHECK ADD  CONSTRAINT [FK_PMS_WorkOrder_Tax] FOREIGN KEY([WorkOrderID])
REFERENCES [dbo].[PMS_WorkOrder] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PMS_WorkOrder_Tax] CHECK CONSTRAINT [FK_PMS_WorkOrder_Tax]
GO
/****** Object:  StoredProcedure [dbo].[bhavin]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[bhavin]
	@RecordCount INT OUTPUT,
	@RecordCount2 INT OUTPUT,
	@RecordCount3 INT OUTPUT,
	@RecordCount4 INT OUTPUT,
	@RecordCount5 INT OUTPUT,
	@RecordCount6 INT OUTPUT,
	@RecordCount7 INT OUTPUT,
	@RecordCount8 INT OUTPUT,
	@RecordCount9 INT OUTPUT,
	@RecordCount10 INT OUTPUT
AS
BEGIN

	SET NOCOUNT ON;
	declare @tablevar table(count int)
	
	SELECT @RecordCount=count(*) FROM PMS_Visitor where ID like '%v%' AND Date = Convert ( varchar (10),GETDATE(),102)
	insert into @tablevar values(@RecordCount)

		SELECT @RecordCount2=count(*) FROM PMS_Visitor where ID like '%B%' AND Date = Convert ( varchar (10),GETDATE(),102)
	insert into @tablevar values(@RecordCount2)
		select @RecordCount3=count(*) from PMS_TransferDoc where ID like '%V%' AND  CAST (CONVERT(VARCHAR(10),Entry_Date,101)AS DATETIME)= CAST (CONVERT(VARCHAR(10),GETDATE(),101)AS DATETIME)
	
		select @RecordCount4=count(*) from PMS_TransferDoc where ID like '%B%' AND  CAST (CONVERT(VARCHAR(10),Entry_Date,101)AS DATETIME)= CAST (CONVERT(VARCHAR(10),GETDATE(),101)AS DATETIME)
	
		SELECT @RecordCount5=count (*)   FROM PMS_Complain_Mgmt_System where status='1'
	
		SELECT @RecordCount6=count (*)   FROM PMS_Complain_Mgmt_System where Entry_Date=GETDATE() and status='2'
	
		SELECT @RecordCount7=count (*)   FROM Pms_PurchaseRequestForm where Status='0' and RequestDate=Convert ( varchar (10),GETDATE(),102)
	
		SELECT @RecordCount8=count (*)   FROM Pms_PurchaseRequestForm where Status='0'
	
		SELECT @RecordCount9=count(*) FROM order_booking WHERE  (DATEPART(yy, order_date_time) = DATEPART(MM,GETDATE()) AND    DATEPART(mm, order_date_time) = DATEPART(MM,GETDATE()) AND    DATEPART(dd, order_date_time) = DATEPART(DD,GETDATE()))
		
		SELECT @RecordCount10=count(*) FROM order_booking where Remark is NULL

		SELECT count FROM @tablevar


END

GO
/****** Object:  StoredProcedure [dbo].[daily_count2]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[daily_count2]
(
@RecordCount varchar(50) OUTPUT,
@date datetime
)
AS
BEGIN
	SET NOCOUNT ON;
	
	declare @tablevar table(count varchar(50))
	
--1.Visitors:

--Vikhroli Count
		SELECT @RecordCount=COUNT(*) FROM PMS_Visitor where  SUBSTRING(ID, 1, 1)='V' and CONVERT(datetime,Date,105)=CONVERT(datetime,@date,105)
	insert into @tablevar values(@RecordCount)
--Bhiwandi Count
		SELECT @RecordCount=count(*) FROM PMS_Visitor where SUBSTRING(ID, 1, 1)='B' AND Date = Convert ( varchar (10),@date,102)
	insert into @tablevar values(@RecordCount)
	
--2.Document Transfer

--Vikhroli count
		select @RecordCount=count(*) from PMS_TransferDoc where SUBSTRING(ID, 1, 1)='V' AND  CAST (CONVERT(VARCHAR(10),Entry_Date,101)AS DATETIME)= CAST (CONVERT(VARCHAR(10),@date,101)AS DATETIME)
	insert into @tablevar values(@RecordCount)
--Vikhroli Pending to be acknowladge today
	select @RecordCount=count(*) from PMS_TransferDoc where SUBSTRING(ID, 1, 1)='V' AND Status='2' 
 AND (DATEPART(DD,CONVERT(datetime,Received_Date,105))=DATEPART(DD,CONVERT(datetime,@date,105)) 
 and DATEPART(MM,CONVERT(datetime,Received_Date,105))=DATEPART(MM,CONVERT(datetime,@date,105)) 
 and DATEPART(YY,CONVERT(datetime,Received_Date,105))=DATEPART(YY,CONVERT(datetime,@date,105)))
	insert into @tablevar values(@RecordCount)
-- Bhiwandi Count
		select @RecordCount=count(*) from PMS_TransferDoc where SUBSTRING(ID, 1, 1)='B' AND  CAST (CONVERT(VARCHAR(10),Entry_Date,101)AS DATETIME)= CAST (CONVERT(VARCHAR(10),@date,101)AS DATETIME)
	insert into @tablevar values(@RecordCount)
--Bhiwandi Acknowladge Pending today
	select @RecordCount=count(*) from PMS_TransferDoc where SUBSTRING(ID, 1, 1)='B' AND Status='2' 
 AND (DATEPART(DD,CONVERT(datetime,Received_Date,105))=DATEPART(DD,CONVERT(datetime,@date,105)) 
 and DATEPART(MM,CONVERT(datetime,Received_Date,105))=DATEPART(MM,CONVERT(datetime,@date,105)) 
 and DATEPART(YY,CONVERT(datetime,Received_Date,105))=DATEPART(YY,CONVERT(datetime,@date,105)))
	insert into @tablevar values(@RecordCount)
--Pending ack	
	select @RecordCount=COUNT(*) from PMS_TransferDoc where Status='0'
	insert into @tablevar values(@RecordCount)
	
--3. Complains:
--Overall Pending complaints
		SELECT @RecordCount=count (*)   FROM PMS_Complain_Mgmt_System where status='1'
	insert into @tablevar values(@RecordCount)
--  Complaints closed today
		SELECT @RecordCount=count (*)   FROM PMS_Complain_Mgmt_System where 
		(DATEPART(yy,Entry_Date) = DATEPART(yy,CONVERT(datetime,@date,105)) AND
		DATEPART(mm, Entry_Date) = DATEPART(MM,CONVERT(datetime,@date,105)) AND
		DATEPART(dd, Entry_Date) = DATEPART(DD,CONVERT(datetime,@date,105))) and status='2'
	insert into @tablevar values(@RecordCount)
	
--4.Purchase Request
--Total no. of New pending request today
		SELECT @RecordCount=count (*)   FROM Pms_PurchaseRequestForm where Status='0' and
(DATEPART(yy,RequestDate) = DATEPART(yy,CONVERT(datetime,@date,105)) AND
    DATEPART(mm, RequestDate) = DATEPART(MM,CONVERT(datetime,@date,105)) AND
        DATEPART(dd, RequestDate) = DATEPART(DD,CONVERT(datetime,@date,105)))
	insert into @tablevar values(@RecordCount)
--Total no. of Pending Purchase request
		SELECT @RecordCount=count (*)   FROM Pms_PurchaseRequestForm where Status='0'
	insert into @tablevar values(@RecordCount)
--5 CLOUD
	--	SELECT @RecordCount=count(*) FROM order_booking WHERE  (DATEPART(yy, order_date_time) = DATEPART(MM,@date) AND    DATEPART(mm, order_date_time) = DATEPART(MM,@date) AND    DATEPART(dd, order_date_time) = DATEPART(DD,@date))
	--insert into @tablevar values(@RecordCount)
		
	--	SELECT @RecordCount=count(*) FROM order_booking where Remark is NULL
	--insert into @tablevar values(@RecordCount)
--6.Production Entries:
--Total number of work entries today
		select @RecordCount=COUNT(*) from PMS_WorkEntry where EntryDate=Convert ( varchar (10),@date,102)
	insert into @tablevar values(@RecordCount)
	
--7. FG & CHALLAN:
--Total number of FG entries today
		select @RecordCount=COUNT(*)
             from PMS_DispatchProDetails dd 
             inner join PMS_WorkEntry we on dd.dpd_WEId = we.Id 
             inner join PMS_JobOrder j on we.Work_JobOrder = j.id 
             inner join PMS_WorkOrder w on we.Work_WorkOrder = w.id
             inner join PMS_Customer c on w.CustomerID = c.cust_Id 
             inner join PMS_Units u on dd.dpd_Unit = u.ID 
             WHERE  (DATEPART(yy, EntryDate) = DATEPART(yy,@date) AND    DATEPART(mm, EntryDate) = DATEPART(MM,@date) AND    DATEPART(dd, EntryDate) = DATEPART(DD,@date))
		insert into @tablevar values(@RecordCount)
--Total number of challan mode today
select @RecordCount=COUNT(*) from PMS_GenerateChallan GNCH
  inner join PMS_GenerateChallanDetails GNCHD on GNCH.chal_ID=GNCHD.chal_ID
  inner join PMS_WorkOrder WO on GNCHD.chalDet_WorkOrderId=WO.ID
  where convert(datetime,chal_Date,105)=Convert ( datetime,@date,105)
		insert into @tablevar values(@RecordCount)
--Total weight of FG outward Today
		select @RecordCount=SUM(CAST(QtyinKG as float)) from PMS_FGEntry where (DATEPART(DD,CONVERT(datetime,cc_Date,105))=DATEPART(DD,CONVERT(datetime,@date,105)) and DATEPART(MM,CONVERT(datetime,cc_Date,105))=DATEPART(MM,CONVERT(datetime,@date,105)) and DATEPART(YY,CONVERT(datetime,cc_Date,105))=DATEPART(YY,CONVERT(datetime,@date,105)))
        insert into @tablevar values(@RecordCount)
--Total weight of FG outward in last 30 days
		SELECT @RecordCount=SUM(CAST(QtyinKG as float))  FROM PMS_FGEntry 
		where  DATEPART(MM,CONVERT(datetime,cc_Date,105))=DATEPART(MM,CONVERT(datetime,@date,105)) 
and DATEPART(YY,CONVERT(datetime,cc_Date,105))=DATEPART(YY,CONVERT(datetime,@date,105))
        insert into @tablevar values(@RecordCount)
--8. Job Card and SO Detais:
--Total number of JobCard created today
		SELECT @RecordCount=COUNT(*) FROM PMS_JobOrder 
		WHERE  (DATEPART(yy, CreatedOn) = DATEPART(yy,@date) AND    DATEPART(mm, CreatedOn) = DATEPART(MM,@date) AND    DATEPART(dd, CreatedOn) = DATEPART(DD,@date))
		insert into @tablevar values(@RecordCount)
		
--Total number of Jobcard updated(repeated) today		
		SELECT @RecordCount=COUNT(*) FROM PMS_JobOrder where
		(DATEPART(yy, UpdatedOn) = DATEPART(yy,@date) AND    
		DATEPART(mm, UpdatedOn) = DATEPART(MM,@date) AND DATEPART(dd, UpdatedOn) = DATEPART(DD,@date))
		insert into @tablevar values(@RecordCount)
--Commented on 18 AUg 2015 Satish Pawar
       -- SELECT @RecordCount=COUNT(*) FROM PMS_JobOrder where CAST (CONVERT(VARCHAR(10),CreatedOn,101)AS DATETIME)= CAST(CONVERT(VARCHAR(10),@date,101)AS DATETIME)
        -- insert into @tablevar values(@RecordCount)
--Comment End		 
		 --SELECT @RecordCount=COUNT(*) from PMS_JobCard_History where Updated_Date= Convert ( varchar (10),@date,102)
		--insert into @tablevar values(@RecordCount)
--Total number of WorkOrder created today
		select @RecordCount=COUNT(*) from PMS_WorkOrder 
		WHERE  (DATEPART(yy, CreatedOn) = DATEPART(yy,@date) AND    DATEPART(mm, CreatedOn) = DATEPART(MM,@date) AND    DATEPART(dd, CreatedOn) = DATEPART(DD,@date))
		insert into @tablevar values(@RecordCount)
--total value of SO created today
		select @RecordCount=Sum(TtlINRincTAX) from PMS_WorkOrder 
		WHERE  (DATEPART(yy, CreatedOn) = DATEPART(yy,@date) AND 
		   DATEPART(mm, CreatedOn) = DATEPART(MM,@date) AND   
		    DATEPART(dd, CreatedOn) = DATEPART(DD,@date))
		    insert into @tablevar values(@RecordCount)
--9 job Design
--Total number of design uploded today
		select @RecordCount=COUNT(*) from PMS_UploadDesign where substring(up_TimeStmp, 1,10)=CONVERT(varchar,@date,105)
	insert into @tablevar values(@RecordCount)	
--Total number of design uploaded last 30 days		

		select @RecordCount=COUNT(*) from PMS_UploadDesign where DATEDIFF(MONTH,convert(datetime,up_TimeStmp,105),@date) < 1
	insert into @tablevar values(@RecordCount)	
--10 Store details
--Total number of material assigned to job today
		SELECT @RecordCount=COUNT(*)
		FROM PMS_Store_Master left outer JOIN
		PMS_WorkOrder ON PMS_Store_Master.WorkOrder_Id = PMS_WorkOrder.ID left outer JOIN
		PMS_Customer ON PMS_Store_Master.Customer_id = PMS_Customer.cust_Id left outer JOIN
		PMS_RawMaterial ON PMS_Store_Master.RM_Id = PMS_RawMaterial.ID left outer JOIN
		PMS_JobOrder ON PMS_Store_Master.jobCard_Id=PMS_JobOrder.Id left outer JOIN 
		PMS_Units ON PMS_Store_Master.Units=PMS_Units.ID 
		WHERE  (DATEPART(yy, PMS_Store_Master.IssueDate) = DATEPART(yy,convert(datetime,@date,105)) AND    DATEPART(mm, PMS_Store_Master.IssueDate) = DATEPART(MM,convert(datetime,@date,105)) AND    DATEPART(dd, PMS_Store_Master.IssueDate) = DATEPART(DD,convert(datetime,@date,105)))
	insert into @tablevar values(@RecordCount)
--Total number of material in general today  
				select @RecordCount=count(*)
		from PMS_GeneralMaterialAllotment a 
		left outer join PMS_Category b on a.RM_Cat=b.id 
		left outer join PMS_Category c on a.RM_ProdCat =c.id 
		left outer join PMS_RawMaterial rm on a.RM_Item=rm.ID 
		left outer join PMS_Users us on a.PersonName=us.ID 
		left outer join PMS_Units un on a.Unit=un.ID 
		WHERE  (DATEPART(yy, a.EntryDate) = DATEPART(yy,convert(datetime,@date,105)) AND    DATEPART(mm, a.EntryDate) = DATEPART(MM,convert(datetime,@date,105)) AND    DATEPART(dd, a.EntryDate) = DATEPART(DD,convert(datetime,@date,105)))and a.MaterialStatus='0'
	insert into @tablevar values(@RecordCount)	
--11 Wastage outword
--Number of wastage outward items today
		Select @RecordCount=COUNT(*) from PMS_Outward a 
		inner join PMS_OutwardDetails b on a.Id=b.Outward_Id 
		inner join PMS_Buyer c on a.Buyer_Name=c.Buyer_Id 
		inner join PMS_Users d 
		on a.Sold_By=d.ID inner join PMS_Wastage f on f.Wastage_Id=b.Item 
		where (DATEPART(DD,CONVERT(datetime,a.Date,105))=DATEPART(DD,CONVERT(datetime,@date,105)) and
		 DATEPART(MM,CONVERT(datetime,a.Date,105))=DATEPART(MM,CONVERT(datetime,@date,105)) and
		 DATEPART(YY,CONVERT(datetime,a.Date,105))=DATEPART(YY,CONVERT(datetime,@date,105)))
	insert into @tablevar values(@RecordCount)
--Number of wastage outward items today		 
		 Select @RecordCount=SUM(CAST(b.Total as float))  from PMS_Outward a 
        inner join PMS_OutwardDetails b on a.Id=b.Outward_Id 
        inner join PMS_Buyer c on a.Buyer_Name=c.Buyer_Id 
        inner join PMS_Users d on a.Sold_By=d.ID 
        inner join PMS_Wastage f on f.Wastage_Id=b.Item 
        where (DATEPART(DD,CONVERT(datetime,a.Date,105))=DATEPART(DD,CONVERT(datetime,@date,105)) and
		 DATEPART(MM,CONVERT(datetime,a.Date,105))=DATEPART(MM,CONVERT(datetime,@date,105)) and
		 DATEPART(YY,CONVERT(datetime,a.Date,105))=DATEPART(YY,CONVERT(datetime,@date,105)))
	insert into @tablevar values(@RecordCount)
--Number of wastage outward items in last 30 days
		Select @RecordCount=COUNT(*)from PMS_Outward a 
        inner join PMS_OutwardDetails b on a.Id=b.Outward_Id 
        inner join PMS_Buyer c on a.Buyer_Name=c.Buyer_Id 
        inner join PMS_Users d 
		on a.Sold_By=d.ID inner join PMS_Wastage f on f.Wastage_Id=b.Item 
		where DATEDIFF(MONTH,convert(datetime,a.Date,105),convert(datetime,@date,105)) < 1
	insert into @tablevar values(@RecordCount)
 --Number of wastage outward amount in last 30 days
		Select @RecordCount=SUM(CAST(b.Total as float))  from PMS_Outward a 
        inner join PMS_OutwardDetails b on a.Id=b.Outward_Id 
        inner join PMS_Buyer c on a.Buyer_Name=c.Buyer_Id 
        inner join PMS_Users d on a.Sold_By=d.ID 
        inner join PMS_Wastage f on f.Wastage_Id=b.Item 
		where DATEDIFF(MONTH,convert(datetime,a.Date,105),convert(datetime,@date,105)) < 1
	insert into @tablevar values(@RecordCount)
-- 12 reference document
--Total number of reference documents uploaded in last 30 days
		SELECT @RecordCount=COUNT (*)   FROM PMS_Reference_Document where DATEDIFF(MONTH,uploaded_on,@date)< 1
	insert into @tablevar values(@RecordCount)

-- 13 Inward Count
 --Total number of inward today
		SELECT @RecordCount=COUNT(*)   FROM PMS_InwardMaster where 
		DATEPART(DD, CONVERT(datetime,Inward_Date,105))=DATEPART(DD, CONVERT(datetime,@date,105)) and
		DATEPART(MM, CONVERT(datetime,Inward_Date,105))=DATEPART(MM, CONVERT(datetime,@date,105)) and
		DATEPART(YY, CONVERT(datetime,Inward_Date,105))=DATEPART(YY, CONVERT(datetime,@date,105)) 
		 and StockType<>0
	insert into @tablevar values(@RecordCount)
--Total number of inwards in last 30 days
		SELECT @RecordCount=COUNT(*)  FROM PMS_InwardMaster where 
		DATEPART(MM, CONVERT(datetime,Inward_Date,105))=DATEPART(MM, CONVERT(datetime,@date,105)) and
		DATEPART(YY, CONVERT(datetime,Inward_Date,105))=DATEPART(YY, CONVERT(datetime,@date,105))  and StockType<>0
	insert into @tablevar values(@RecordCount)
--Total number of GRN today
		SELECT @RecordCount=COUNT(*)FROM PMS_GRNMaster where 
		DATEPART(DD, CONVERT(datetime,date,105))=DATEPART(DD, CONVERT(datetime,@date,105)) and
		DATEPART(MM, CONVERT(datetime,date,105))=DATEPART(MM, CONVERT(datetime,@date,105)) and
		DATEPART(YY, CONVERT(datetime,date,105))=DATEPART(YY, CONVERT(datetime,@date,105))
	insert into @tablevar values(@RecordCount)
--Total number of GRN in last 30 days
		SELECT @RecordCount=COUNT(*)  FROM PMS_GRNMaster where 
		DATEPART(MM, CONVERT(datetime,date,105))=DATEPART(MM, CONVERT(datetime,@date,105)) and
		DATEPART(YY, CONVERT(datetime,date,105))=DATEPART(YY, CONVERT(datetime,@date,105))
	insert into @tablevar values(@RecordCount)
--14 Training
--Total number of new training in last 30 days
		SELECT @RecordCount=count(*) FROM PMS_TraningEntry WHERE   DATEDIFF(MONTH,tr_TrainingDate,@date)< 1
	insert into @tablevar values(@RecordCount)
--15 User Stastics
--Total number of active PMS user
		SELECT @RecordCount=COUNT (*)  FROM PMS_Users where Status='1'
	insert into @tablevar values(@RecordCount)
--Total number of inactive PMS user
		SELECT @RecordCount=COUNT (*)  FROM PMS_Users where Status='0'
	insert into @tablevar values(@RecordCount)
--16MACHINE MAINTENANCE
--Number of Machine machine maintainance entry last 6 months
		SELECT @RecordCount=COUNT (*) FROM PMS_MachinenMaintenance where DATEDIFF(MONTH,CONVERT(datetime,mm_EntryDate,105),CONVERT(datetime,@date,105))< 6 and  mm_MaintType<>'Breakdown' 
		insert into @tablevar values(@RecordCount)
--Number of Machine BreakDown last 6 months		
		SELECT @RecordCount=COUNT (*)FROM PMS_MachinenMaintenance where DATEDIFF(MONTH,CONVERT(datetime,mm_EntryDate,105),CONVERT(datetime,@date,105))< 6 and  mm_MaintType='Breakdown'
		insert into @tablevar values(@RecordCount)
		
--17BMS ENTRIES
--Total number of task added today
		SELECT @RecordCount=COUNT (*)FROM PMS_OfficeWorkTask where status='9' and  CONVERT(datetime,Date,105)=
        CONVERT(datetime,@date,105)
		insert into @tablevar values(@RecordCount)
		
--Total number of work entries made today	
		SELECT @RecordCount=COUNT (*) FROM PMS_OfficeWorkEntry where CONVERT(datetime,Date,105)= CONVERT(datetime,@date,101)
		insert into @tablevar values(@RecordCount)
--Total number of task closed today		
		SELECT @RecordCount=COUNT (*)FROM PMS_OfficeWorkTask where status='11' 
        and CONVERT(datetime,Date,101)= CONVERT(datetime,@date,105)
		insert into @tablevar values(@RecordCount)
--Total number of pending task overall		
		SELECT @RecordCount=COUNT (*)FROM PMS_OfficeWorkTask WHERE status='10' or status='12' or status='9'
		insert into @tablevar values(@RecordCount)
		
--Supervisor QC

--Supervisor QCs today	
		  select @RecordCount=COUNT (*) from PMS_SupervisorQcEntry where 
		  DATEPART(MONTH, CONVERT(datetime, Entry_Date,105))=DATEPART(MONTH,CONVERT(datetime,@date,105)) and
		  DATEPART(DAY, CONVERT(datetime, Entry_Date,105))=DATEPART(DAY,CONVERT(datetime,@date,105)) and
		  DATEPART(YEAR, CONVERT(datetime, Entry_Date,105))=DATEPART(YEAR,CONVERT(datetime,@date,105))	
		  insert into @tablevar values(@RecordCount)	
--Supervisor QCs in last 30 days: 
		select @RecordCount=COUNT(*) from PMS_SupervisorQcEntry where 
(DATEPART(MONTH, CONVERT(datetime, Entry_Date,105))=DATEPART(MONTH,CONVERT(datetime,@date,105))
and DATEPART(YEAR, CONVERT(datetime, Entry_Date,105))=DATEPART(YEAR,CONVERT(datetime,@date,105)))
		 insert into @tablevar values(@RecordCount)
		 
--ink kitchen
--No. of ink mixtures created today
				select @RecordCount=COUNT(*) from PMS_Ink_Mixture 
				where (DATEPART(DD,CONVERT(datetime,CreatedOn,105))=DATEPART(DD,CONVERT(datetime,@date,105)) and
				 DATEPART(MM,CONVERT(datetime,CreatedOn,105))=DATEPART(MM,CONVERT(datetime,@date,105)) and
				 DATEPART(YY,CONVERT(datetime,CreatedOn,105))=DATEPART(YY,CONVERT(datetime,@date,105)))
				  insert into @tablevar values(@RecordCount)
-- No. of ink mixtures created in last 60 days: 
				select @RecordCount=COUNT(NewColour) from PMS_Ink_Mixture 
				where CONVERT(datetime,CreatedOn,105) 
				between DATEADD(MM,-6,CONVERT(datetime,@date,105)) and CONVERT(datetime,@date,105)
				insert into @tablevar values(@RecordCount)
--Latest ink mixture produced:
				select @RecordCount=NewColour from PMS_Ink_Mixture order by CreatedOn asc
				insert into @tablevar values(@RecordCount)
--Total no. of unique ink mixtures used till date:					
				select distinct @RecordCount=Count(IMC.InkMixture) from PMS_Ink_Mixture_Created IMC
				insert into @tablevar values(@RecordCount)
				
--Invoice module
--Invoice  genrated this month
	select @RecordCount=COUNT(*) from PMS_Invoice_Master
    where Deleted='N' and 
    (DATEPART(MM,CONVERT(datetime,Invoice_Date,105))=DATEPART(MM,CONVERT(datetime,@date,105)) and 
    DATEPART(YY,CONVERT(datetime,Invoice_Date,105))=DATEPART(YY,CONVERT(datetime,@date,105)))
				insert into @tablevar values(@RecordCount)
 
--Invoice amount this month
		select   @RecordCount=case  when cast(ROUND(SUM(CAST(GrandTotal  as decimal(20,2))),2) as Varchar(200)) is null then cast(0 as varchar) else
cast(ROUND(SUM(CAST(GrandTotal  as decimal(20,2))),2) as Varchar(200)) END from PMS_Invoice_Master
 where Deleted='N' and
 (datepart(MM,convert(datetime,Invoice_Date,105))=datepart(MM,convert(datetime,@date,105)) and 
 datepart(YY,convert(datetime,Invoice_Date,105))=datepart(YY,convert(datetime,@date,105)))
insert into @tablevar values(@RecordCount)
--Invoice Generated today
select @RecordCount=COUNT(*) from PMS_Invoice_Master where Deleted='N' and
(datepart(DD,convert(datetime,Invoice_Date,105))=datepart(DD,convert(datetime,@date,105)) and
datepart(MM,convert(datetime,Invoice_Date,105))=datepart(MM,convert(datetime,@date,105))
and datepart(YY,convert(datetime,Invoice_Date,105))=datepart(YY,convert(datetime,@date,105)))
insert into @tablevar values(@RecordCount)
--Invoice amount today
		select @RecordCount=  case  when cast(ROUND(SUM(CAST(GrandTotal  as decimal(20,2))),2) as Varchar(200)) is null then cast(0 as varchar) else
		cast(ROUND(SUM(CAST(GrandTotal  as decimal(20,2))),2) as Varchar(200)) END from PMS_Invoice_Master
			where Deleted='N' and convert(varchar,Invoice_Date,105) >=convert(varchar,CONVERT(date,@date,105),105)
           AND convert(varchar,Invoice_Date,105)<=convert(varchar,CONVERT(date,@date,105),105)
				insert into @tablevar values(@RecordCount)
				
				
--File upload
--GRN uploads today
	select @RecordCount=COUNT(*) from PMS_InwardMaster IWM
	inner join PMS_InwardDocuments IWDoc on IWM.ID=IWDoc.Inward_ID 
	where IWDoc.Doc_Name is not null and
	DATEPART(MONTH, CONVERT(datetime, Inward_Date,105))=DATEPART(MONTH,CONVERT(datetime,@date,105)) and
	DATEPART(DAY, CONVERT(datetime, Inward_Date,105))=DATEPART(DAY,CONVERT(datetime,@date,105)) and
	DATEPART(YEAR, CONVERT(datetime, Inward_Date,105))=DATEPART(YEAR,CONVERT(datetime,@date,105))
	insert into @tablevar values(@RecordCount)
--LR copy upload today
	select @RecordCount=count(chal_LrRrFileName)
	+(select count(chal_ACK_RCP_FileName) from PMS_GenerateChallan where chal_ACK_RCP_FileName is not null and chal_ACK_RCP_FileName <>'' and CONVERT(datetime,chal_Date,105) = CONVERT(datetime,@date,105))
	+(select count(chal_Other_DOC_FileName) from PMS_GenerateChallan where chal_Other_DOC_FileName is not null and chal_Other_DOC_FileName <> '' and CONVERT(datetime,chal_Date,105) = CONVERT(datetime,@date,105))
	from PMS_GenerateChallan where chal_LrRrFileName is not null and chal_LrRrFileName <> ''
	and CONVERT(datetime,chal_Date,105) = CONVERT(datetime,@date,105)
	insert into @tablevar values(@RecordCount)
--Inward copy upload today	
	select @RecordCount=count(*) from PMS_InwardDocuments IMD
	inner join PMS_InwardMaster IM on IMD.Inward_ID=IM.ID
	where (DATEPART(DD,CONVERT(datetime,IM.CreatedOn,105))=DATEPART(DD,CONVERT(datetime,@date,105)) and
	 DATEPART(MM,CONVERT(datetime,IM.CreatedOn,105))=DATEPART(MM,CONVERT(datetime,@date,105)) and
	 DATEPART(YY,CONVERT(datetime,IM.CreatedOn,105))=DATEPART(YY,CONVERT(datetime,@date,105)))
	insert into @tablevar values(@RecordCount)

						SELECT count FROM @tablevar
END
GO
/****** Object:  StoredProcedure [dbo].[DailySO]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DailySO]
	@no		varchar(10),
	@date	date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	if(@no='1')
    --so count
    select COUNT(*) from PMS_WorkOrder 
	WHERE  (DATEPART(yy, CreatedOn) = DATEPART(yy,@date) AND    DATEPART(mm, CreatedOn) = DATEPART(MM,@date) AND    DATEPART(dd, CreatedOn) = DATEPART	(DD,@date))
	if(@no='2')
	--SO name
	select distinct c.Product_Type from PMS_WorkOrder a
	INNER JOIN PMS_JobOrder b on a.JobOrderID=b.ID
	INNER JOIN PMS_Product c on c.Auto_Id = b.jobcart_Prod_Type
	WHERE  (DATEPART(yy, a.CreatedOn) = DATEPART(yy,@date) AND    DATEPART(mm, a.CreatedOn) = DATEPART(MM,@date) AND    DATEPART(dd, a.CreatedOn) = DATEPART(DD,@date))

	if(@no='3')
	--SO BOM  
	select e.name,sum(CAST(a.Quantity_Req as float)) as Quantity,un.Unit from PMS_Store_Master a 
	inner join PMS_WorkOrder c on a.WorkOrder_Id=c.ID
	inner join PMS_RawMaterial d on a.RM_Id=d.ID
	inner join PMS_Category e on d.RM_Cat=e.id
	inner join PMS_Units un on a.Units = un.ID
	WHERE  (DATEPART(yy, c.CreatedOn) = DATEPART(yy,@date) AND    DATEPART(mm, c.CreatedOn) = DATEPART(MM,@date) AND DATEPART(dd, c.CreatedOn) = DATEPART	(DD,@date))
	group by e.name,un.Unit
	order by e.name asc
	if(@no='4')
	-- total amount
	select Sum(TtlINRincTAX) from PMS_WorkOrder
	WHERE  (DATEPART(yy, CreatedOn) = DATEPART(yy,@date) AND    DATEPART(mm, CreatedOn) = DATEPART(MM,@date) AND DATEPART(dd, CreatedOn) = DATEPART	(DD,@date))
    
END

GO
/****** Object:  StoredProcedure [dbo].[Dashboard]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<mandar	>
-- Create date: <11-08-2015>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Dashboard]
	@type varchar(10),
	@subtype varchar(10),
	@machine varchar(10),
	@date	date
AS
BEGIN
	
	SET NOCOUNT ON;
	IF(@type='1')
		IF(@subtype='0')--last 30 days
			select b.prod_cat as Product,COUNT(b.prod_cat) as Count from PMS_JobOrder a 
			inner join PMS_ProductMaster b on a.jobcart_Prod_Cat= b.Auto_Id 
			where DATEDIFF(DAY,CONVERT(datetime,a.CreatedOn,105),CONVERT(datetime,@date,105))<30
			group by b.prod_cat
			order by COUNT(b.prod_cat) desc
		else IF(@subtype='1')--last 3 months
			select b.prod_cat as Product,COUNT(b.prod_cat) as Count from PMS_JobOrder a 
			inner join PMS_ProductMaster b on a.jobcart_Prod_Cat= b.Auto_Id 
			where DATEDIFF(MONTH,CONVERT(datetime,a.CreatedOn,105),CONVERT(datetime,@date,105))<3
			group by b.prod_cat
			order by COUNT(b.prod_cat) desc
		else if(@subtype='2')--last 6 months
			select b.prod_cat as Product,COUNT(b.prod_cat) as Count from PMS_JobOrder a 
			inner join PMS_ProductMaster b on a.jobcart_Prod_Cat= b.Auto_Id 
			where DATEDIFF(MONTH,CONVERT(datetime,a.CreatedOn,105),CONVERT(datetime,@date,105))<6
			group by b.prod_cat
			order by COUNT(b.prod_cat) desc
		else if(@subtype='3')--last 1 year
			select b.prod_cat as Product,COUNT(b.prod_cat) as Count from PMS_JobOrder a 
			inner join PMS_ProductMaster b on a.jobcart_Prod_Cat= b.Auto_Id 
			where DATEDIFF(YEAR,CONVERT(datetime,a.CreatedOn,105),CONVERT(datetime,@date,105))<1
			group by b.prod_cat
			order by COUNT(b.prod_cat) desc
		else if(@subtype='4')--all time
			select b.prod_cat as Product,COUNT(b.prod_cat) as Count from PMS_JobOrder a 
			inner join PMS_ProductMaster b on a.jobcart_Prod_Cat= b.Auto_Id 
			group by b.prod_cat
			order by COUNT(b.prod_cat) desc
	IF(@type='2')
		IF(@subtype='0')
			select CAST(DATEPART(DD,EntryDate) AS varchar(5))+'/'+CAST(DATEPART(MM,EntryDate)AS varchar(10))+' '+
			SUBSTRING(DATENAME(DW,EntryDate),1,3) AS Entry_date
			,COUNT(*) AS Entry_Count from PMS_WorkEntry 
			where EntryDate between DATEADD(DD,-7,convert(datetime,@date,105)) and convert(datetime,@date,105)
			group by EntryDate
			order by EntryDate
		else IF(@subtype='1')
			select CAST(DATEPART(DD,EntryDate) AS varchar(5))+'/'+CAST(DATEPART(MM,EntryDate) AS varchar(10)) AS Entry_date,COUNT(*) AS Entry_Count from PMS_WorkEntry 
			where  EntryDate between DATEADD(DD,-30,convert(datetime,@date,105)) and convert(datetime,@date,105)
			group by EntryDate
			order by EntryDate
	If(@type='3')
		IF(@subtype='0')
			select c.Name,
			SUM(case ISNUMERIC(b.WERO_InPro_Qty+ 'e0')
			when 1 then convert(float,b.WERO_InPro_Qty)
			else CAST(0 AS int)
			end) as Quantity,SUM(case ISNUMERIC(b.WERO_IntPro_WestedQty)
			when 1 then convert(float,b.WERO_IntPro_WestedQty)
			else CAST(0 AS int)
			end) as Wastage from PMS_WorkEntry a
			inner join PMS_WorkEntryResources_OutputPro b on a.ID=b.WERO_WorkEntryId
			inner join PMS_Machines c on a.Work_Machinary=c.ID
			where  DATEDIFF(DAY,convert(datetime,a.EntryDate,105),convert(datetime,@date,105))<30 and c.Category=@machine
			group by a.Work_Machinary,c.Name
			order by c.Name
		else IF(@subtype='1')
			select c.Name,
			SUM(case ISNUMERIC(b.WERO_InPro_Qty+ 'e0')
			when 1 then convert(float,b.WERO_InPro_Qty)
			else CAST(0 AS int)
			end) as Quantity,SUM(case ISNUMERIC(b.WERO_IntPro_WestedQty)
			when 1 then convert(float,b.WERO_IntPro_WestedQty)
			else CAST(0 AS int)
			end) as Wastage from PMS_WorkEntry a
			inner join PMS_WorkEntryResources_OutputPro b on a.ID=b.WERO_WorkEntryId
			inner join PMS_Machines c on a.Work_Machinary=c.ID
			where  DATEDIFF(DAY,convert(datetime,a.EntryDate,105),convert(datetime,@date,105))<90 and c.Category=@machine
			group by a.Work_Machinary,c.Name
			order by c.Name
	    else IF(@subtype='2')
			select c.Name,
			SUM(case ISNUMERIC(b.WERO_InPro_Qty+ 'e0')
			when 1 then convert(float,b.WERO_InPro_Qty)
			else CAST(0 AS int)
			end) as Quantity,SUM(case ISNUMERIC(b.WERO_IntPro_WestedQty)
			when 1 then convert(float,b.WERO_IntPro_WestedQty)
			else CAST(0 AS int)
			end) as Wastage from PMS_WorkEntry a
			inner join PMS_WorkEntryResources_OutputPro b on a.ID=b.WERO_WorkEntryId
			inner join PMS_Machines c on a.Work_Machinary=c.ID
			where  DATEDIFF(DAY,convert(datetime,a.EntryDate,105),convert(datetime,@date,105))<180 and c.Category=@machine
			group by a.Work_Machinary,c.Name
			order by c.Name
		else IF(@subtype='3')
			select c.Name,
			SUM(case ISNUMERIC(b.WERO_InPro_Qty+ 'e0')
			when 1 then convert(float,b.WERO_InPro_Qty)
			else CAST(0 AS int)
			end) as Quantity,SUM(case ISNUMERIC(b.WERO_IntPro_WestedQty)
			when 1 then convert(float,b.WERO_IntPro_WestedQty)
			else CAST(0 AS int)
			end) as Wastage from PMS_WorkEntry a
			inner join PMS_WorkEntryResources_OutputPro b on a.ID=b.WERO_WorkEntryId
			inner join PMS_Machines c on a.Work_Machinary=c.ID
			where  DATEDIFF(YEAR,convert(datetime,a.EntryDate,105),convert(datetime,@date,105))<1 and c.Category=@machine
			group by a.Work_Machinary,c.Name
			order by c.Name
		else IF(@subtype='4')
			select c.Name,
			SUM(case ISNUMERIC(b.WERO_InPro_Qty+ 'e0')
			when 1 then convert(float,b.WERO_InPro_Qty)
			else CAST(0 AS int)
			end) as Quantity,SUM(case ISNUMERIC(b.WERO_IntPro_WestedQty)
			when 1 then convert(float,b.WERO_IntPro_WestedQty)
			else CAST(0 AS int)
			end) as Wastage from PMS_WorkEntry a
			inner join PMS_WorkEntryResources_OutputPro b on a.ID=b.WERO_WorkEntryId
			inner join PMS_Machines c on a.Work_Machinary=c.ID
			where c.Category=@machine
			group by a.Work_Machinary,c.Name
			order by c.Name
	If(@type='4')
		IF(@subtype='0')
			select b.Product_Type,COUNT(b.Product_Type)as countt
			from PMS_JobOrder a
			inner join PMS_Product b on a.jobcart_Prod_Type=b.Auto_Id
			where jobcart_Prod_Cat=@machine 
			and DATEDIFF(DAY,CONVERT(datetime,a.CreatedOn,105),CONVERT(datetime,@date,105))<30
			group by b.Product_Type
			order by countt desc
		else IF(@subtype='1')
			select b.Product_Type,COUNT(b.Product_Type)as countt
			from PMS_JobOrder a
			inner join PMS_Product b on a.jobcart_Prod_Type=b.Auto_Id
			where DATEDIFF(MM,CONVERT(datetime,a.CreatedOn,105),CONVERT(datetime,@date,105))<3 
			and jobcart_Prod_Cat=@machine
			group by b.Product_Type
			order by countt desc
		else IF(@subtype='2')
			select b.Product_Type,COUNT(b.Product_Type)as countt
			from PMS_JobOrder a
			inner join PMS_Product b on a.jobcart_Prod_Type=b.Auto_Id
			where DATEDIFF(MM,CONVERT(datetime,a.CreatedOn,105),CONVERT(datetime,@date,105))<6 
			and jobcart_Prod_Cat=@machine
			group by b.Product_Type
			order by countt desc
		else IF(@subtype='3')
			select b.Product_Type,COUNT(b.Product_Type)as countt
			from PMS_JobOrder a
			inner join PMS_Product b on a.jobcart_Prod_Type=b.Auto_Id
			where DATEDIFF(YY,CONVERT(datetime,a.CreatedOn,105),CONVERT(datetime,@date,105))<1 
			and jobcart_Prod_Cat=@machine
			group by b.Product_Type
			order by countt desc
		else IF(@subtype='4')
			select b.Product_Type,COUNT(b.Product_Type)as countt
			from PMS_JobOrder a
			inner join PMS_Product b on a.jobcart_Prod_Type=b.Auto_Id
			where jobcart_Prod_Cat=@machine
			group by b.Product_Type
			order by countt desc
			
			
			
			--RM Cat--
				
		IF(@type='5')
		IF(@subtype='0')--last 30 days
			select b.name,SUM(a.GRNQty)
			from PMS_InwardMaterial a inner join PMS_Category b on a.RM_Cat=b.id
			where DATEDIFF(DAY,CONVERT(datetime,a.CreatedOn,105),CONVERT(datetime,@date,105))<30
			group by b.name
			order by COUNT(b.name) desc
			else IF(@subtype='1')--last 3 months
			select b.name,SUM(a.GRNQty)
			from PMS_InwardMaterial a inner join PMS_Category b on a.RM_Cat=b.id
			where DATEDIFF(MONTH,CONVERT(datetime,a.CreatedOn,105),CONVERT(datetime,@date,105))<3
			group by b.name
			order by COUNT(b.name) desc
	
		
			else if(@subtype='2')--last 1 year
			select b.name,SUM(a.GRNQty)
			from PMS_InwardMaterial a inner join PMS_Category b on a.RM_Cat=b.id
			where DATEDIFF(YEAR,CONVERT(datetime,a.CreatedOn,105),CONVERT(datetime,@date,105))<1
			group by b.name
			order by COUNT(b.name) desc
			
			else if(@subtype='3')--all time
			select b.name,SUM(a.GRNQty)
			from PMS_InwardMaterial a inner join PMS_Category b on a.RM_Cat=b.id
			group by b.name
			order by COUNT(b.name) desc
			
			
END

GO
/****** Object:  StoredProcedure [dbo].[factoryReports]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================

-- =============================================
CREATE PROCEDURE [dbo].[factoryReports]
	@Type int,
	@month int,
	@year int,
	@machine varchar(100)=null
AS
BEGIN
	
	if(@Type=1)
		select distinct WO.WorkOrderID,jc.Order_Name,CUS.cust_Name,
		Convert(varchar,WO.SalesOrderDate,105) as 'SO Date',
		Convert(varchar,convert(datetime,Case When LEN(WO.Date)=10 then WO.Date else null END,105),105) as 'Shipping Date in SO',
		Convert(varchar,convert(datetime,(select MAX(convert(datetime,chal_Date,105)) from PMS_GenerateChallan where chal_SO_No=WO.ID),105),105) as 'Challan Date',
		DATEDIFF(DD,Case When LEN(WO.Date)=10 then  convert(datetime,WO.Date,105) else null END,
		convert(datetime,(select MAX(convert(datetime,chal_Date,105)) from PMS_GenerateChallan where chal_SO_No=WO.ID ),105) ) as 'Difference (in Days)',
		US.Name as 'Sales Person Name',USCreated.Name as 'SO Prepared by'
		from PMS_GenerateChallan CHL
		left outer join PMS_WorkOrder WO on WO.ID=CHL.chal_SO_No
		left outer join PMS_JobOrder JC on WO.JobOrderID=JC.ID
		left outer join PMS_Customer CUS on WO.CustomerID=CUS.cust_Id
		left outer join PMS_Users US on CUS.cust_SalesPerson=US.ID
		left outer join PMS_Users USCreated on WO.CreatedBy=USCreated.ID
		where  chal_Date is not null and
		Datepart(MM,CONVERT(datetime,(select MAX(convert(datetime,chal_Date,105)) from PMS_GenerateChallan where chal_SO_No=WO.ID),105))= 05 and
		Datepart(YY,CONVERT(datetime,(select MAX(convert(datetime,chal_Date,105)) from PMS_GenerateChallan where chal_SO_No=WO.ID),105))= 2016
		group by WO.WorkOrderID,jc.Order_Name,CUS.cust_Name,WO.SalesOrderDate,WO.Date,WO.ID,US.Name,USCreated.Name,chal_Date
		order by 'Challan Date' asc
	if(@Type=2)
		select ROW_NUMBER() OVER(order BY MCH.Name asc) as 'Sr. No.',MCH.Name  as  'Machine Name',ProCat.Process_Category as 'Process Category','Bhiwandi' as Location, 
		 CAST(SUM(CAST(CASE  
		  WHEN  
			  Work_DateFrom is not null and Work_DateFrom <> ''  
		  then  
			  DATEDIFF(HH,Convert(DATETIME,CAST(REPLACE(Work_DateFrom,'/','-')+':00.000' as datetime),105),Convert(DATETIME,CAST(REPLACE(Work_DateTo,'/','-')+':00.000' as datetime),105)) 
		  ELSE 
			  '0'	 
		  END as int)) as VArchar)+ ' Hrs '+ 
		  CAST(SUM(CAST(CASE  
		  WHEN  
			  Work_DateFrom is not null and Work_DateFrom <> ''  
		  then  
			  DATEDIFF(MI,Convert(DATETIME,CAST(REPLACE(Work_DateFrom,'/','-')+':00.000' as datetime),105),Convert(DATETIME,CAST(REPLACE(Work_DateTo,'/','-')+':00.000' as datetime),105)) 
		  ELSE 
			  '0'	 
		  END as int))%60 as Varchar)+ ' Mins ' as 'Usage (Hrs: Minues)','' as 'No. of workers' 
		  , SUM(CAST(Replace(Replace(WEOP.WERO_InPro_Qty,',',''),'.','') as int)) as 'Output Quantity',UN.Unit as 'Unit' 
		   from PMS_WorkEntry WE 
		  left outer join PMS_Machines MCH on WE.Work_Machinary=MCH.ID 
		  left outer join PMS_Processes PRO on WE.Work_Process=PRO.ID 
		  left outer join PMS_ProcessCategory ProCat on ProCat.id=PRO.Category  
		  left outer join PMS_WorkEntryResources_OutputPro WEOP on WE.ID=WEOP.WERO_WorkEntryId 
		  left outer join PMS_Units UN on WEOP.WERO_InPro_Unit = UN.ID 
		  where ISNUMERIC(WEOP.WERO_InPro_Qty) = 1  
		  AND DATEPART(MM,CONVERT(Datetime, WE.CreatedOn, 105))=@month and DATEPART(YY,CONVERT(Datetime, WE.CreatedOn, 105))=@year
		  AND (DATEPART(MM,CONVERT(DATETIME,CASE WHEN Work_DateFrom IS NOT NULL AND Work_DateFrom <> '' THEN CAST(REPLACE(Work_DateFrom, '/', '-') + ':00.000' AS datetime) ELSE null END, 105)) =@month)
		  AND (DATEPART(YY,CONVERT(DATETIME,CASE WHEN Work_DateFrom IS NOT NULL AND Work_DateFrom <> '' THEN CAST(REPLACE(Work_DateFrom, '/', '-') + ':00.000' AS datetime) ELSE null END, 105)) =@year)
		  group by MCH.Name,ProCat.Process_Category,UN.Unit
	if(@Type=3)
		  select distinct Operator,Assistant,Helper 
			from PMS_WorkEntry WE inner join PMS_Machines MCH on WE.Work_Machinary=MCH.ID 
			where Operator is not null and MCH.Name=@machine 
			AND DATEPART(MM,CONVERT(Datetime, WE.CreatedOn, 105))=@month and DATEPART(YY,CONVERT(Datetime, WE.CreatedOn, 105))=@year
			AND (DATEPART(MM,CONVERT(DATETIME,CASE WHEN Work_DateFrom IS NOT NULL AND Work_DateFrom <> '' THEN CAST(REPLACE(Work_DateFrom, '/', '-') + ':00.000' AS datetime) ELSE null END, 105)) =@month)
			AND (DATEPART(YY,CONVERT(DATETIME,CASE WHEN Work_DateFrom IS NOT NULL AND Work_DateFrom <> '' THEN CAST(REPLACE(Work_DateFrom, '/', '-') + ':00.000' AS datetime) ELSE null END, 105)) =@year)
			group by  Operator,Assistant,Helper
	if(@Type=4)
		select ROW_NUMBER() OVER(order BY MCH.Name asc) as 'Sr. No.',MCH.Name as 'Machine',MchMaint.mm_EntryDate as 'Date',MchMaint.mm_MaintType as 'Maintainance Type' 
		,MchMaint.mm_MaintTitle as 'Title',MchMaint.mm_MainCompDet as 'Details',MchMaint.mm_MainSolnTaken as 'Solution',MchMaint.mm_Operators as 'Operator' from PMS_MachinenMaintenance MchMaint 
		inner join PMS_Machines Mch on MchMaint.mm_Machine = Mch.ID
		where DATEPART(MM,CONVERT(datetime,MchMaint.mm_EntryDate,105))=@month and  DATEPART(YY,CONVERT(datetime,MchMaint.mm_EntryDate,105))=@year
	if(@Type=5)
		select ROW_NUMBER() OVER(order BY MCH.Name asc) as 'Sr. No.',US.Name,MCH.Name  as  'Machine Name',
		SUM(CAST(Replace(Replace(WEOP.WERO_InPro_Qty,',',''),'.','') as int)) as 'Output Quantity',UN.Unit as 'Unit'
		from PMS_WorkEntry WE
		left outer join PMS_Machines MCH on WE.Work_Machinary=MCH.ID 
		left outer join PMS_WorkEntryResources_OutputPro WEOP on WE.ID=WEOP.WERO_WorkEntryId
		left outer join PMS_Units UN on WEOP.WERO_InPro_Unit = UN.ID
		left outer join PMS_Users US on WE.Operator=US.ID
		where ISNUMERIC(WEOP.WERO_InPro_Qty) = 1 and 
		DATEPART(MM,CONVERT(Datetime, WE.CreatedOn, 105))=@month and DATEPART(YY,CONVERT(Datetime, WE.CreatedOn, 105))=@year
		AND (DATEPART(MM,CONVERT(DATETIME,CASE WHEN Work_DateFrom IS NOT NULL AND Work_DateFrom <> '' THEN CAST(REPLACE(Work_DateFrom, '/', '-') + ':00.000' AS datetime) ELSE null END, 105)) =@month)
		AND (DATEPART(YY,CONVERT(DATETIME,CASE WHEN Work_DateFrom IS NOT NULL AND Work_DateFrom <> '' THEN CAST(REPLACE(Work_DateFrom, '/', '-') + ':00.000' AS datetime) ELSE null END, 105)) =@year)
		group by MCH.Name,UN.Unit,US.Name
	if(@Type=6)
		select ROW_NUMBER() OVER(order BY MCH.Name asc) as 'Sr. No.',US.EmpCode as 'Operators Emp Code',US.Name as 'Operator Name' 
		,MCH.Name as  'Machine Name', 
		CASE  
			WHEN  
				Work_DateFrom is not null and Work_DateFrom <> ''  
			then  
				CONVERT(VARCHAR(10),Convert(DATETIME,CAST(REPLACE(Work_DateFrom,'/','-')+':00.000' as datetime),105),105) 
			ELSE 
				null	 
		END, 
		SUM(CAST(Replace(Replace(WEOP.WERO_InPro_Qty,',',''),'.','') as int)) as 'Output Quantity',UN.Unit as 'Unit', 
		CAST(SUM(CAST(
		CASE  
			WHEN  
				Work_DateFrom is not null and Work_DateFrom <> ''  
			then  
				DATEDIFF(HH,Convert(DATETIME,CAST(REPLACE(Work_DateFrom,'/','-')+':00.000' as datetime),105),Convert(DATETIME,CAST(REPLACE(Work_DateTo,'/','-')+':00.000' as datetime),105)) 
			ELSE 
				'0'	 
		END as int)) as VArchar)+ ' Hrs '+ 
		CAST(SUM(CAST(
		CASE  
			WHEN  
				Work_DateFrom is not null and Work_DateFrom <> ''  
			then  
				DATEDIFF(MI,Convert(DATETIME,CAST(REPLACE(Work_DateFrom,'/','-')+':00.000' as datetime),105),Convert(DATETIME,CAST(REPLACE(Work_DateTo,'/','-')+':00.000' as datetime),105)) 
			ELSE 
				'0'	 
		END as int))%60 as Varchar)+ ' Mins ' as 'Usage (Hrs: Minues)' 
		from PMS_WorkEntry WE 
		left outer join PMS_Machines MCH on WE.Work_Machinary=MCH.ID 
		left outer join PMS_Processes PRO on WE.Work_Process=PRO.ID 
		left outer join PMS_ProcessCategory ProCat on ProCat.id=PRO.Category  
		left outer join PMS_WorkEntryResources_OutputPro WEOP on WE.ID=WEOP.WERO_WorkEntryId 
		left outer join PMS_Units UN on WEOP.WERO_InPro_Unit = UN.ID 
		left outer join PMS_Users US on WE.Operator=US.ID 
		where ISNUMERIC(WEOP.WERO_InPro_Qty) = 1  
		AND DATEPART(MM,CONVERT(Datetime, WE.CreatedOn, 105))=@month and DATEPART(YY,CONVERT(Datetime, WE.CreatedOn, 105))=@year
		AND (DATEPART(MM,CONVERT(DATETIME,CASE WHEN Work_DateFrom IS NOT NULL AND Work_DateFrom <> '' THEN CAST(REPLACE(Work_DateFrom, '/', '-') + ':00.000' AS datetime) ELSE null END, 105)) =@month)
		AND (DATEPART(YY,CONVERT(DATETIME,CASE WHEN Work_DateFrom IS NOT NULL AND Work_DateFrom <> '' THEN CAST(REPLACE(Work_DateFrom, '/', '-') + ':00.000' AS datetime) ELSE null END, 105)) =@year)
		group by MCH.Name,ProCat.Process_Category,UN.Unit,US.EmpCode,US.Name,Work_DateFrom 
		order by 
		CASE  
			WHEN  
				Work_DateFrom is not null and Work_DateFrom <> ''  
			then  
				Convert(DATETIME,CAST(REPLACE(Work_DateFrom,'/','-')+':00.000' as datetime),105) 
			ELSE 
				null	 
		END asc
	if(@Type=7)
		select ROW_NUMBER() OVER(order BY ProMaster.prod_cat asc) as 'Sr. No.', ProMaster.prod_cat as 'Product Category',ProMaster.prod_cat as 'Product Type',SUM(CAST(FG.cc_QtyDispatch as float)) as 'FG quantity' 
		,UNFG.Unit,SUM(CAST(FG.QtyinKG as float)) as 'FG in Kgs' , 
		SUM(CASE 
		WHEN  
		WEIP.WERI_InPro_MatId='20' and WEOP.WERO_InPro_MatId='20' 
		THEN 
		CAST(WEIP.WERI_IntPro_WestedQty as float)+CAST(WEOP.WERO_IntPro_WestedQty as float) 
		ELSE 
		CAST(WEOP.WERO_IntPro_WestedQty as float) 
		END) as 'Wastage (i/p & o/p)' 
		,UNWE.Unit as 'Unit (w)',SUM(CAST(INV.GrandTotal as float)) as 'Invoice Rs.' 
		from PMS_WorkOrder WO 
		left outer join PMS_JobOrder JC on WO.JobOrderID=JC.ID 
		left outer join PMS_ProductMaster ProMaster on JC.jobcart_Prod_Cat=ProMaster.Auto_Id 
		left outer join PMS_Product Pro on JC.jobcart_Prod_Type=Pro.Auto_Id 
		left outer join PMS_WorkEntry WE on WO.ID=WE.Work_WorkOrder 
		left outer join PMS_WorkEntryResources_InputPro WEIP on WE.ID=WEIP.WERI_WorkEntryId 
		left outer join PMS_WorkEntryResources_OutputPro WEOP on WE.ID=WEOP.WERO_WorkEntryId 
		left outer join PMS_Units UNWE on WEIP.WERI_InPro_Unit=UNWE.ID 
		left outer join PMS_FGEntry FG on WO.ID=FG.cc_WorkOrderId 
		left outer join PMS_Units UNFG on FG.cc_Unit=UNFG.ID 
		left outer join PMS_GenerateChallan CHL on WO.ID=CHL.chal_SO_No 
		left outer join PMS_Invoice_Master INV on CHL.chal_ID=INV.Challan_ID 
		where DATEPART(MM,CONVERT(Datetime,FG.cc_Date,105)) =@month
		and DATEPART(YY,CONVERT(Datetime,FG.cc_Date,105)) =@year
		group by ProMaster.prod_cat,ProMaster.prod_cat,UNFG.Unit,UNWE.Unit
	if(@Type=8)
		select ROW_NUMBER() OVER(order BY ProMaster.prod_cat asc) as 'Sr. No.', ProMaster.prod_cat as 'Product Category',ProMaster.prod_cat as 'Product Type', 
		JC.Item_Type as 'Product/Item Name',SUM(CAST(FG.cc_QtyDispatch as float)) as 'FG quantity' 
		,UNFG.Unit,SUM(CAST(FG.QtyinKG as float)) as 'FG in Kgs'  
		from PMS_WorkOrder WO 
		left outer join PMS_JobOrder JC on WO.JobOrderID=JC.ID 
		left outer join PMS_ProductMaster ProMaster on JC.jobcart_Prod_Cat=ProMaster.Auto_Id 
		left outer join PMS_Product Pro on JC.jobcart_Prod_Type=Pro.Auto_Id 
		left outer join PMS_WorkEntry WE on WO.ID=WE.Work_WorkOrder 
		left outer join PMS_FGEntry FG on WO.ID=FG.cc_WorkOrderId 
		left outer join PMS_Units UNFG on FG.cc_Unit=UNFG.ID 
		where DATEPART(MM,CONVERT(Datetime,FG.cc_Date,105)) =@month
		and DATEPART(YY,CONVERT(Datetime,FG.cc_Date,105)) =@year
		group by ProMaster.prod_cat,ProMaster.prod_cat,UNFG.Unit,JC.Item_Type

END

GO
/****** Object:  StoredProcedure [dbo].[fillAllRM]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[fillAllRM]
	-- Add the parameters for the stored procedure here
	@RMCat VARCHAR(255)
AS
BEGIN
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    --Paper
    select rw.ID , case rw.RM_Cat when '20' then  ( Case when rw.mat_width is null then rw.Name else 
														(case when rw.mat_make is null then ' ' else mat_make+' ' END+
														case  when rw.mat_width is null then ' ' else rw.mat_width+' ' END+
														case  when rw.mat_width_unit is null then ' X ' else rw.mat_width_unit+' X ' END+
														case  when rw.mat_GSM is null then ' ' else rw.mat_GSM+' GSM ' END+
														case  when rw.mat_color is null then ' ' else rw.mat_color+' ' END+
														case  when rw.mat_carbon is null then ' ' else rw.mat_carbon+' ' END+
														case  when rw.mat_special is null then ' ' else rw.mat_special END)
													 END)
									--Box				
									when '121' then  (case  when mat_height is null then rw.Name Else 
														 (case  when mat_height is null then ' ' else mat_height+' ' END+
														  case  when mat_height_unit is null then ' X ' else mat_height_unit+' X ' END+
														  case  when mat_width is null then ' ' else mat_width+' ' END+
														  case  when mat_width_unit is null then ' X ' else mat_width_unit+' X ' END+
														  case  when mat_length is null then ' ' else mat_length+' ' END+
														  case  when mat_length_unit is null then ' ' else mat_length_unit END) 
													 END)
									--Plastic Bag			  
									when '123' then  (case  when mat_height is null then rw.Name Else
														   (case  when mat_height is null then ' ' else mat_height+' ' END+
															case  when mat_height_unit is null then ' X ' else mat_height_unit+' X ' END+
															case  when mat_width is null then ' ' else mat_width+' ' END+
															case  when mat_width_unit is null then ' ' else mat_width_unit+' ' END+
															case  when mat_color is null then ' ' else mat_color END)
												     END)		
									--CORE		
									when '148' then  ( Case when rw.mat_width is null then rw.Name else
													   (case  when mat_width is null then ' ' else mat_width+' ' END+
														case  when mat_width_unit is null then ' ' else mat_width_unit END+
														case  when mat_diameter is null then ' ' else mat_diameter+' ' END+
														case  when mat_diameter_unit is null then ' ' else mat_diameter_unit END)
													 END)	
									--Blanket		
									when '162' then  ( Case when rw.mat_width is null then rw.Name else
														(case  when mat_width is null then ' ' else mat_width+' ' END+
														case  when mat_width_unit is null then ' X ' else mat_width_unit+' X ' END+
														case  when mat_length is null then ' ' else mat_length+' ' END+
														case  when mat_length_unit is null then ' X ' else mat_length_unit+' X ' END+
														case  when mat_thickness is null then ' ' else mat_thickness END+
														case  when mat_thickness_unit is null then ' ' else mat_thickness_unit END)
													END)
									--INK
									when '21' then  (case  when mat_color is null then rw.Name else 
														(case  when mat_special is null then ' ' else mat_special+' ' END+
														case  when mat_color is null then ' ' else mat_color+' ' END)
													END)
									
									--CORE		
									when '134' then  ( Case when rw.mat_width is null then rw.Name else
														(case  when mat_width is null then ' ' else mat_width+' ' END+
														case  when mat_width_unit is null then ' ' else mat_width_unit END+
														case  when mat_diameter is null then ' ' else mat_diameter+' ' END+
														case  when mat_diameter_unit is null then ' ' else mat_diameter_unit END)
													 END)	
									--printed products				
									--when '46' then  (rw.Name+' '+
									--				case  when mat_height is null then ' ' else mat_height+' ' END+
									--				case  when unh.Unit is null then ' ' else unh.Unit+'*' END+
									--				case  when mat_width is null then ' ' else mat_width+' ' END+
									--				case  when unw.Unit is null then ' ' else unw.Unit+'*' END+
									--				case  when mat_part is null then ' ' else mat_part END)
									
									--P.S.Plates
									when '171' then ( Case when rw.mat_width is null then rw.Name else 
														(case  when mat_width is null then ' ' else mat_width+' ' END+
														case  when mat_width_unit is null then ' X ' else mat_width_unit+' X ' END+
														case  when mat_length is null then ' ' else mat_length+' ' END+
														case  when mat_length_unit is null then ' X ' else mat_length_unit+' X ' END+
														case  when mat_thickness is null then ' ' else mat_thickness END+
														case  when mat_thickness_unit is null then ' ' else mat_thickness_unit END)
													END)
													ELSE
													rw.Name
													end
													as Name
													from PMS_RawMaterial rw
													
								  left outer join PMS_Units unw on rw.mat_width_unit=unw.ID
								  left outer join PMS_Units unh on rw.mat_height_unit=unh.ID
								  left outer join PMS_Units unl on rw.mat_length_unit=unl.ID
								  left outer join PMS_Units unt on rw.mat_height_unit=unt.ID
END



GO
/****** Object:  StoredProcedure [dbo].[fillRM]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[fillRM]
	@RMCat VARCHAR(255),
	@ProdCat VARCHAR(255)
AS
BEGIN
SET NOCOUNT ON;
	if(@RMCat='PAPER')
		BEGIN
			select rw.ID ,
			( Case when rw.mat_width is null then rw.Name else 
				(case when rw.mat_make is null then ' ' else mat_make+' ' END+
				case  when rw.mat_width is null then ' ' else rw.mat_width+' ' END+
				case  when rw.mat_width_unit is null then ' X ' else rw.mat_width_unit+' X ' END+
				case  when rw.mat_GSM is null then ' ' else rw.mat_GSM+' GSM ' END+
				case  when rw.mat_color is null then ' ' else rw.mat_color+' ' END+
				case  when rw.mat_carbon is null then ' ' else rw.mat_carbon+' ' END+
				case  when rw.mat_special is null then ' ' else rw.mat_special END)
			 END)
			 as Name 
			from PMS_RawMaterial_New rw
			where Product_Cat=@ProdCat
		END
    else if(@RMCat='CORR.BOXES')
    Begin
		  select rw.ID ,
		  (case  when mat_height is null then rw.Name Else 
			 (case  when mat_height is null then ' ' else mat_height+' ' END+
			  case  when mat_height_unit is null then ' X ' else mat_height_unit+' X ' END+
			  case  when mat_width is null then ' ' else mat_width+' ' END+
			  case  when mat_width_unit is null then ' X ' else mat_width_unit+' X ' END+
			  case  when mat_length is null then ' ' else mat_length+' ' END+
			  case  when mat_length_unit is null then ' ' else mat_length_unit END) 
		  END)
		  as Name 
		  from PMS_RawMaterial_New rw
		  where Product_Cat=@ProdCat
    End
    else if(@RMCat='PLASTIC BAGS')
    Begin
		select rw.ID ,
		(case  when mat_height is null then rw.Name Else
			   (case  when mat_height is null then ' ' else mat_height+' ' END+
				case  when mat_height_unit is null then ' X ' else mat_height_unit+' X ' END+
				case  when mat_width is null then ' ' else mat_width+' ' END+
				case  when mat_width_unit is null then ' ' else mat_width_unit+' ' END+
				case  when mat_color is null then ' ' else mat_color END)
		 END)	
		 as Name
		from PMS_RawMaterial_New rw
		where Product_Cat=@ProdCat
    End
    else if(@RMCat='CORE')
    Begin
		select rw.ID ,
		 ( Case when rw.mat_width is null then rw.Name else
		   (case  when mat_width is null then ' ' else mat_width+' ' END+
			case  when mat_width_unit is null then ' ' else mat_width_unit END+
			case  when mat_diameter is null then ' ' else mat_diameter+' ' END+
			case  when mat_diameter_unit is null then ' ' else mat_diameter_unit END)
		 END)	
		as Name
		from PMS_RawMaterial_New rw
		where Product_Cat=@ProdCat
    End
    else if(@RMCat='BLANKETS')
    Begin
		select rw.ID ,
		case  when mat_width is null then ' ' else mat_width+' ' END+
		case  when mat_width_unit is null then ' X ' else mat_width_unit+' X ' END+
		case  when mat_length is null then ' ' else mat_length+' ' END+
		case  when mat_length_unit is null then ' X ' else mat_length_unit+' X ' END+
		case  when mat_thickness is null then ' ' else mat_thickness END+
		case  when mat_thickness_unit is null then ' ' else mat_thickness_unit END as Name
		from PMS_RawMaterial_New rw
		where Product_Cat=@ProdCat
    End
    else if(@RMCat='INK')
    Begin
		select rw.ID ,
		(case  when mat_color is null then rw.Name else 
			(case  when mat_special is null then ' ' else mat_special+' ' END+
			case  when mat_color is null then ' ' else mat_color+' ' END)
		END) 
		as Name
		from PMS_RawMaterial_New rw
		where Product_Cat=@ProdCat
    End
    else if(@RMCat='OTC PAPER')
    Begin
		select rw.ID ,
		( Case when rw.mat_width is null then rw.Name else
			(case  when mat_width is null then ' ' else mat_width+' ' END+
			case  when mat_width_unit is null then ' ' else mat_width_unit END+
			case  when mat_diameter is null then ' ' else mat_diameter+' ' END+
			case  when mat_diameter_unit is null then ' ' else mat_diameter_unit END)
		 END) 
		as Name
		from PMS_RawMaterial_New rw
		where Product_Cat=@ProdCat
    End
  --  else if(@RMCat='PRINTED PRODUCTS')
  --  Begin
		--select rw.ID ,rw.Name+ ' '+
		--case  when mat_height is null then ' ' else mat_height+' ' END+
		--case  when unh.Unit is null then ' ' else unh.Unit+'*' END+
		--case  when mat_width is null then ' ' else mat_width+' ' END+
		--case  when unw.Unit is null then ' ' else unw.Unit+'*' END+
		--case  when mat_part is null then ' ' else mat_part END as Name 
		--from PMS_RawMaterial_New rw
		--left outer join PMS_Units unw on rw.mat_width_unit=unw.ID
		--left outer join PMS_Units unh on rw.mat_height_unit=unh.ID
		--where Product_Cat=@ProdCat
  --  End
    else if(@RMCat='P.S.PLATE')
    Begin
    select rw.ID ,
		( Case when rw.mat_width is null then rw.Name else 
			(case  when mat_width is null then ' ' else mat_width+' ' END+
			case  when mat_width_unit is null then ' X ' else mat_width_unit+' X ' END+
			case  when mat_length is null then ' ' else mat_length+' ' END+
			case  when mat_length_unit is null then ' X ' else mat_length_unit+' X ' END+
			case  when mat_thickness is null then ' ' else mat_thickness END+
			case  when mat_thickness_unit is null then ' ' else mat_thickness_unit END)
		END) 
		as Name 
		from PMS_RawMaterial_New rw
		where Product_Cat=@ProdCat
    End
    else 
    Begin
		select rw.ID ,rw.Name as Name  from PMS_RawMaterial_New rw where Product_Cat=@ProdCat
    End
END

GO
/****** Object:  StoredProcedure [dbo].[Get_Barcode_Number]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get_Barcode_Number]
	@RM_Cat as varchar(10),
	@Resource_cat as varchar(10),
	@count as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
			--select @count= Max(Barcode_ID)+1 from PMS_InwardMaterial where RM_Cat=@RM_Cat and Barcode_ID is not null  group by Barcode_ID,RM_Cat
			if(@RM_Cat='20')
				select 
				case  
					when mat_GSM is null then '000' 
					when LEN(mat_GSM)=1 then '00'+mat_GSM
					when LEN(mat_GSM)=2 then '0'+mat_GSM 
					when LEN(mat_GSM)=3 then mat_GSM  
				else 
					'000'
				END
				+
				case  
					when LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ) is null then '000' 
					when LEN(LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ))=1 then '00'+LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END )
					when LEN(LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ))=2 then '0'+LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ) 
					when LEN(LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ))=3 then LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END )  
				else 
					'000' 
				END 

				as Barcode 

				from PMS_RawMaterial rw
				where rw.ID=@Resource_cat
				group by rw.ID,mat_make,mat_GSM,mat_width
				
			--Blanket
			if(@RM_Cat='162' or @RM_Cat='B/CA/27')
					select 
					'SAB'

					+
					case  
						when LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ) is null then '000' 
						when LEN(LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ))=1 then '00'+LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END )
						when LEN(LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ))=2 then '0'+LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ) 
						when LEN(LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ))=3 then LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END )  
					else 
						'000' 
					END
					+
					case  
						when LEFT(cast(mat_length as varchar(50)), Case when CHARINDEX('.',cast(mat_length as varchar(50)))=0 then LEN(mat_length) else CHARINDEX('.',cast(mat_length as varchar(50))) - 1 END ) is null then '000' 
						when LEN(LEFT(cast(mat_length as varchar(50)), Case when CHARINDEX('.',cast(mat_length as varchar(50)))=0 then LEN(mat_length) else CHARINDEX('.',cast(mat_length as varchar(50))) - 1 END ))=1 then '00'+LEFT(cast(mat_length as varchar(50)), Case when CHARINDEX('.',cast(mat_length as varchar(50)))=0 then LEN(mat_length) else CHARINDEX('.',cast(mat_length as varchar(50))) - 1 END )
						when LEN(LEFT(cast(mat_length as varchar(50)), Case when CHARINDEX('.',cast(mat_length as varchar(50)))=0 then LEN(mat_length) else CHARINDEX('.',cast(mat_length as varchar(50))) - 1 END ))=2 then '0'+LEFT(cast(mat_length as varchar(50)), Case when CHARINDEX('.',cast(mat_length as varchar(50)))=0 then LEN(mat_length) else CHARINDEX('.',cast(mat_length as varchar(50))) - 1 END ) 
						when LEN(LEFT(cast(mat_length as varchar(50)), Case when CHARINDEX('.',cast(mat_length as varchar(50)))=0 then LEN(mat_length) else CHARINDEX('.',cast(mat_length as varchar(50))) - 1 END ))=3 then LEFT(cast(mat_length as varchar(50)), Case when CHARINDEX('.',cast(mat_length as varchar(50)))=0 then LEN(mat_length) else CHARINDEX('.',cast(mat_length as varchar(50))) - 1 END )  
					else 
						'000' 
					END
					+
					case  
						when LEFT(cast(mat_thickness as varchar(50)), Case when CHARINDEX('.',cast(mat_thickness as varchar(50)))=0 then LEN(mat_thickness) else CHARINDEX('.',cast(mat_thickness as varchar(50))) - 1 END ) is null then '000' 
						when LEN(LEFT(cast(mat_thickness as varchar(50)), Case when CHARINDEX('.',cast(mat_thickness as varchar(50)))=0 then LEN(mat_thickness) else CHARINDEX('.',cast(mat_thickness as varchar(50))) - 1 END ))=1 then '00'+LEFT(cast(mat_thickness as varchar(50)), Case when CHARINDEX('.',cast(mat_thickness as varchar(50)))=0 then LEN(mat_thickness) else CHARINDEX('.',cast(mat_thickness as varchar(50))) - 1 END )
						when LEN(LEFT(cast(mat_thickness as varchar(50)), Case when CHARINDEX('.',cast(mat_thickness as varchar(50)))=0 then LEN(mat_thickness) else CHARINDEX('.',cast(mat_thickness as varchar(50))) - 1 END ))=2 then '0'+LEFT(cast(mat_thickness as varchar(50)), Case when CHARINDEX('.',cast(mat_thickness as varchar(50)))=0 then LEN(mat_thickness) else CHARINDEX('.',cast(mat_thickness as varchar(50))) - 1 END ) 
						when LEN(LEFT(cast(mat_thickness as varchar(50)), Case when CHARINDEX('.',cast(mat_thickness as varchar(50)))=0 then LEN(mat_thickness) else CHARINDEX('.',cast(mat_thickness as varchar(50))) - 1 END ))=3 then LEFT(cast(mat_thickness as varchar(50)), Case when CHARINDEX('.',cast(mat_thickness as varchar(50)))=0 then LEN(mat_thickness) else CHARINDEX('.',cast(mat_thickness as varchar(50))) - 1 END )  
					else 
						'000' 
					END
					from PMS_RawMaterial
					where RM_Cat='162' or RM_Cat='B/CA/27' and ID=@Resource_cat
			
			--Core		
			if(@RM_Cat='148')
					select
					case  
						when LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ) is null then '000' 
						when LEN(LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ))=1 then '00'+LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END )
						when LEN(LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ))=2 then '0'+LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ) 
						when LEN(LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ))=3 then LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END )  
					else 
						'000' 
					END
					+
					case  
						when LEFT(cast(mat_diameter as varchar(50)), Case when CHARINDEX('.',cast(mat_diameter as varchar(50)))=0 then LEN(mat_diameter) else CHARINDEX('.',cast(mat_diameter as varchar(50))) - 1 END ) is null then '000' 
						when LEN(LEFT(cast(mat_diameter as varchar(50)), Case when CHARINDEX('.',cast(mat_diameter as varchar(50)))=0 then LEN(mat_diameter) else CHARINDEX('.',cast(mat_diameter as varchar(50))) - 1 END ))=1 then '00'+LEFT(cast(mat_diameter as varchar(50)), Case when CHARINDEX('.',cast(mat_diameter as varchar(50)))=0 then LEN(mat_diameter) else CHARINDEX('.',cast(mat_diameter as varchar(50))) - 1 END )
						when LEN(LEFT(cast(mat_diameter as varchar(50)), Case when CHARINDEX('.',cast(mat_diameter as varchar(50)))=0 then LEN(mat_diameter) else CHARINDEX('.',cast(mat_diameter as varchar(50))) - 1 END ))=2 then '0'+LEFT(cast(mat_diameter as varchar(50)), Case when CHARINDEX('.',cast(mat_diameter as varchar(50)))=0 then LEN(mat_diameter) else CHARINDEX('.',cast(mat_diameter as varchar(50))) - 1 END ) 
						when LEN(LEFT(cast(mat_diameter as varchar(50)), Case when CHARINDEX('.',cast(mat_diameter as varchar(50)))=0 then LEN(mat_diameter) else CHARINDEX('.',cast(mat_diameter as varchar(50))) - 1 END ))=3 then LEFT(cast(mat_diameter as varchar(50)), Case when CHARINDEX('.',cast(mat_diameter as varchar(50)))=0 then LEN(mat_diameter) else CHARINDEX('.',cast(mat_diameter as varchar(50))) - 1 END )  
					else 
						'000' 
					END
					from PMS_RawMaterial
					where ID=@Resource_cat
					
			--BOX
			if(@RM_Cat='121')
					select  
					case  
						when LEFT(cast(mat_height as varchar(50)), Case when CHARINDEX('.',cast(mat_height as varchar(50)))=0 then LEN(mat_height) else CHARINDEX('.',cast(mat_height as varchar(50))) - 1 END ) is null then '000' 
						when LEN(LEFT(cast(mat_height as varchar(50)), Case when CHARINDEX('.',cast(mat_height as varchar(50)))=0 then LEN(mat_height) else CHARINDEX('.',cast(mat_height as varchar(50))) - 1 END ))=1 then '00'+LEFT(cast(mat_height as varchar(50)), Case when CHARINDEX('.',cast(mat_height as varchar(50)))=0 then LEN(mat_height) else CHARINDEX('.',cast(mat_height as varchar(50))) - 1 END )
						when LEN(LEFT(cast(mat_height as varchar(50)), Case when CHARINDEX('.',cast(mat_height as varchar(50)))=0 then LEN(mat_height) else CHARINDEX('.',cast(mat_height as varchar(50))) - 1 END ))=2 then '0'+LEFT(cast(mat_height as varchar(50)), Case when CHARINDEX('.',cast(mat_height as varchar(50)))=0 then LEN(mat_height) else CHARINDEX('.',cast(mat_height as varchar(50))) - 1 END ) 
						when LEN(LEFT(cast(mat_height as varchar(50)), Case when CHARINDEX('.',cast(mat_height as varchar(50)))=0 then LEN(mat_height) else CHARINDEX('.',cast(mat_height as varchar(50))) - 1 END ))=3 then LEFT(cast(mat_height as varchar(50)), Case when CHARINDEX('.',cast(mat_height as varchar(50)))=0 then LEN(mat_height) else CHARINDEX('.',cast(mat_height as varchar(50))) - 1 END )  
					else 
						'000' 
					END
					+
					case  
						when LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ) is null then '000' 
						when LEN(LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ))=1 then '00'+LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END )
						when LEN(LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ))=2 then '0'+LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ) 
						when LEN(LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ))=3 then LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END )  
					else 
						'000' 
					END
					+
					case  
						when LEFT(cast(mat_length as varchar(50)), Case when CHARINDEX('.',cast(mat_length as varchar(50)))=0 then LEN(mat_length) else CHARINDEX('.',cast(mat_length as varchar(50))) - 1 END ) is null then '000' 
						when LEN(LEFT(cast(mat_length as varchar(50)), Case when CHARINDEX('.',cast(mat_length as varchar(50)))=0 then LEN(mat_length) else CHARINDEX('.',cast(mat_length as varchar(50))) - 1 END ))=1 then '00'+LEFT(cast(mat_length as varchar(50)), Case when CHARINDEX('.',cast(mat_length as varchar(50)))=0 then LEN(mat_length) else CHARINDEX('.',cast(mat_length as varchar(50))) - 1 END )
						when LEN(LEFT(cast(mat_length as varchar(50)), Case when CHARINDEX('.',cast(mat_length as varchar(50)))=0 then LEN(mat_length) else CHARINDEX('.',cast(mat_length as varchar(50))) - 1 END ))=2 then '0'+LEFT(cast(mat_length as varchar(50)), Case when CHARINDEX('.',cast(mat_length as varchar(50)))=0 then LEN(mat_length) else CHARINDEX('.',cast(mat_length as varchar(50))) - 1 END ) 
						when LEN(LEFT(cast(mat_length as varchar(50)), Case when CHARINDEX('.',cast(mat_length as varchar(50)))=0 then LEN(mat_length) else CHARINDEX('.',cast(mat_length as varchar(50))) - 1 END ))=3 then LEFT(cast(mat_length as varchar(50)), Case when CHARINDEX('.',cast(mat_length as varchar(50)))=0 then LEN(mat_length) else CHARINDEX('.',cast(mat_length as varchar(50))) - 1 END )  
					else 
						'000' 
					END
					from PMS_RawMaterial
					where  ID=@Resource_cat
				
			--Plate
			if(@RM_Cat='171')		
					select 'PLT'
					+
					case  
						when LEFT(cast(mat_height as varchar(50)), Case when CHARINDEX('.',cast(mat_height as varchar(50)))=0 then LEN(mat_height) else CHARINDEX('.',cast(mat_height as varchar(50))) - 1 END ) is null then '000' 
						when LEN(LEFT(cast(mat_height as varchar(50)), Case when CHARINDEX('.',cast(mat_height as varchar(50)))=0 then LEN(mat_height) else CHARINDEX('.',cast(mat_height as varchar(50))) - 1 END ))=1 then '00'+LEFT(cast(mat_height as varchar(50)), Case when CHARINDEX('.',cast(mat_height as varchar(50)))=0 then LEN(mat_height) else CHARINDEX('.',cast(mat_height as varchar(50))) - 1 END )
						when LEN(LEFT(cast(mat_height as varchar(50)), Case when CHARINDEX('.',cast(mat_height as varchar(50)))=0 then LEN(mat_height) else CHARINDEX('.',cast(mat_height as varchar(50))) - 1 END ))=2 then '0'+LEFT(cast(mat_height as varchar(50)), Case when CHARINDEX('.',cast(mat_height as varchar(50)))=0 then LEN(mat_height) else CHARINDEX('.',cast(mat_height as varchar(50))) - 1 END ) 
						when LEN(LEFT(cast(mat_height as varchar(50)), Case when CHARINDEX('.',cast(mat_height as varchar(50)))=0 then LEN(mat_height) else CHARINDEX('.',cast(mat_height as varchar(50))) - 1 END ))=3 then LEFT(cast(mat_height as varchar(50)), Case when CHARINDEX('.',cast(mat_height as varchar(50)))=0 then LEN(mat_height) else CHARINDEX('.',cast(mat_height as varchar(50))) - 1 END )  
					else 
						'000' 
					END
					+
					case  
						when LEFT(cast(mat_length as varchar(50)), Case when CHARINDEX('.',cast(mat_length as varchar(50)))=0 then LEN(mat_length) else CHARINDEX('.',cast(mat_length as varchar(50))) - 1 END ) is null then '000' 
						when LEN(LEFT(cast(mat_length as varchar(50)), Case when CHARINDEX('.',cast(mat_length as varchar(50)))=0 then LEN(mat_length) else CHARINDEX('.',cast(mat_length as varchar(50))) - 1 END ))=1 then '00'+LEFT(cast(mat_length as varchar(50)), Case when CHARINDEX('.',cast(mat_length as varchar(50)))=0 then LEN(mat_length) else CHARINDEX('.',cast(mat_length as varchar(50))) - 1 END )
						when LEN(LEFT(cast(mat_length as varchar(50)), Case when CHARINDEX('.',cast(mat_length as varchar(50)))=0 then LEN(mat_length) else CHARINDEX('.',cast(mat_length as varchar(50))) - 1 END ))=2 then '0'+LEFT(cast(mat_length as varchar(50)), Case when CHARINDEX('.',cast(mat_length as varchar(50)))=0 then LEN(mat_length) else CHARINDEX('.',cast(mat_length as varchar(50))) - 1 END ) 
						when LEN(LEFT(cast(mat_length as varchar(50)), Case when CHARINDEX('.',cast(mat_length as varchar(50)))=0 then LEN(mat_length) else CHARINDEX('.',cast(mat_length as varchar(50))) - 1 END ))=3 then LEFT(cast(mat_length as varchar(50)), Case when CHARINDEX('.',cast(mat_length as varchar(50)))=0 then LEN(mat_length) else CHARINDEX('.',cast(mat_length as varchar(50))) - 1 END )  
					else 
						'000' 
					END
					+
					case  
						when LEFT(cast(mat_thickness as varchar(50)), Case when CHARINDEX('.',cast(mat_thickness as varchar(50)))=0 then LEN(mat_thickness) else CHARINDEX('.',cast(mat_thickness as varchar(50))) - 1 END ) is null then '000' 
						when LEN(LEFT(cast(mat_thickness as varchar(50)), Case when CHARINDEX('.',cast(mat_thickness as varchar(50)))=0 then LEN(mat_thickness) else CHARINDEX('.',cast(mat_thickness as varchar(50))) - 1 END ))=1 then '00'+LEFT(cast(mat_thickness as varchar(50)), Case when CHARINDEX('.',cast(mat_thickness as varchar(50)))=0 then LEN(mat_thickness) else CHARINDEX('.',cast(mat_thickness as varchar(50))) - 1 END )
						when LEN(LEFT(cast(mat_thickness as varchar(50)), Case when CHARINDEX('.',cast(mat_thickness as varchar(50)))=0 then LEN(mat_thickness) else CHARINDEX('.',cast(mat_thickness as varchar(50))) - 1 END ))=2 then '0'+LEFT(cast(mat_thickness as varchar(50)), Case when CHARINDEX('.',cast(mat_thickness as varchar(50)))=0 then LEN(mat_thickness) else CHARINDEX('.',cast(mat_thickness as varchar(50))) - 1 END ) 
						when LEN(LEFT(cast(mat_thickness as varchar(50)), Case when CHARINDEX('.',cast(mat_thickness as varchar(50)))=0 then LEN(mat_thickness) else CHARINDEX('.',cast(mat_thickness as varchar(50))) - 1 END ))=3 then LEFT(cast(mat_thickness as varchar(50)), Case when CHARINDEX('.',cast(mat_thickness as varchar(50)))=0 then LEN(mat_thickness) else CHARINDEX('.',cast(mat_thickness as varchar(50))) - 1 END )  
					else 
						'000' 
					END
					from PMS_RawMaterial
					where ID=@Resource_cat
					
			--Plastic Bag
			if(@RM_Cat='171')
					select 'PB'+
					SUBSTRING(mat_color,1,3)
					+
					case  
						when LEFT(cast(mat_height as varchar(50)), Case when CHARINDEX('.',cast(mat_height as varchar(50)))=0 then LEN(mat_height) else CHARINDEX('.',cast(mat_height as varchar(50))) - 1 END ) is null then '000' 
						when LEN(LEFT(cast(mat_height as varchar(50)), Case when CHARINDEX('.',cast(mat_height as varchar(50)))=0 then LEN(mat_height) else CHARINDEX('.',cast(mat_height as varchar(50))) - 1 END ))=1 then '00'+LEFT(cast(mat_height as varchar(50)), Case when CHARINDEX('.',cast(mat_height as varchar(50)))=0 then LEN(mat_height) else CHARINDEX('.',cast(mat_height as varchar(50))) - 1 END )
						when LEN(LEFT(cast(mat_height as varchar(50)), Case when CHARINDEX('.',cast(mat_height as varchar(50)))=0 then LEN(mat_height) else CHARINDEX('.',cast(mat_height as varchar(50))) - 1 END ))=2 then '0'+LEFT(cast(mat_height as varchar(50)), Case when CHARINDEX('.',cast(mat_height as varchar(50)))=0 then LEN(mat_height) else CHARINDEX('.',cast(mat_height as varchar(50))) - 1 END ) 
						when LEN(LEFT(cast(mat_height as varchar(50)), Case when CHARINDEX('.',cast(mat_height as varchar(50)))=0 then LEN(mat_height) else CHARINDEX('.',cast(mat_height as varchar(50))) - 1 END ))=3 then LEFT(cast(mat_height as varchar(50)), Case when CHARINDEX('.',cast(mat_height as varchar(50)))=0 then LEN(mat_height) else CHARINDEX('.',cast(mat_height as varchar(50))) - 1 END )  
					else 
						'000' 
					END
					+
					case  
						when LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ) is null then '000' 
						when LEN(LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ))=1 then '00'+LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END )
						when LEN(LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ))=2 then '0'+LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ) 
						when LEN(LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ))=3 then LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END )  
					else 
						'000' 
					END
					from PMS_RawMaterial
					where ID=@Resource_cat
					
			--OTC Paper
			if(@RM_Cat='134')
					select  
					case  
						when LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ) is null then '000' 
						when LEN(LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ))=1 then '00'+LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END )
						when LEN(LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ))=2 then '0'+LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ) 
						when LEN(LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END ))=3 then LEFT(cast(mat_width as varchar(50)), Case when CHARINDEX('.',cast(mat_width as varchar(50)))=0 then LEN(mat_width) else CHARINDEX('.',cast(mat_width as varchar(50))) - 1 END )  
					else 
						'000' 
					END
					+
					mat_diameter


					as Barcode 

					from PMS_RawMaterial rw
					where ID=@Resource_cat
					group by rw.ID,mat_make,mat_GSM,mat_width,mat_diameter
					
			--INK
			if(@RM_Cat='21')
					select 'INK'
					+
					UPPER(SUBSTRING(mat_color,1,3))
					+
					UPPER(SUBSTRING(mat_special,1,3))

					as Barcode 
					from PMS_RawMaterial rw
					where ID=@Resource_cat
			
			
END



GO
/****** Object:  StoredProcedure [dbo].[GetManageCity_Pager]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetManageCity_Pager]
       @SearchTerm VARCHAR(100) = ''
      ,@PageIndex INT = 1
      ,@PageSize INT = 10
      ,@SearchTerm1 VARCHAR(100) = ''
      ,@SearchTerm2 VARCHAR(100) = ''
      
      ,@RecordCount INT OUTPUT
AS
BEGIN
      SET NOCOUNT ON;
      SELECT ROW_NUMBER() OVER
      (
            ORDER BY [city_Id] ASC
      )AS RowNumber
      ,[city_Id]      
      ,[Country_Name]
      ,[country_Id]
      ,[State_Name]
      ,[city_Name]
      ,[city_Code]
      ,[state_Id]
      
      
      
      INTO #Results
      FROM CityView
      WHERE ([Country_Id] like @SearchTerm + '%'  OR [Country_Name]= '')
     and ([State_Id] like @SearchTerm1 + '%'  OR [state_Name] = '')
      and ([city_id] like @SearchTerm2 + '%' OR [city_Name] = '')
      
     
	ORDER BY CAST(SUBSTRING(city_Id, 6, 10) AS int) DESC, SUBSTRING(city_Id, 1, 1) DESC
        
     
      SELECT @RecordCount = COUNT(*)
      FROM #Results
       
          
      SELECT * FROM #Results
      where RowNumber BETWEEN(@PageIndex -1) * @PageSize + 1 AND(((@PageIndex -1) * @PageSize + 1) + @PageSize) - 1
          
     
          
  
    
      DROP TABLE #Results
END

GO
/****** Object:  StoredProcedure [dbo].[GetManageCustomer_Pager]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetManageCustomer_Pager]
       @SearchTerm VARCHAR(100) = ''
      ,@PageIndex INT = 1
      ,@PageSize INT = 10
      ,@RecordCount INT OUTPUT
AS
BEGIN
      SET NOCOUNT ON;
      SELECT ROW_NUMBER() OVER
      (
            ORDER BY [cust_Id] ASC
      )AS RowNumber
      ,[cust_Id]
      ,[cust_No]
      ,[cust_PBoxNo]
      ,[cust_Name]
       ,[comp_Name]
      
      
      INTO #Results
      FROM [CustomerView]
      WHERE ([cust_PBoxNo] like @SearchTerm + '%'  OR [cust_PBoxNo] = '')
    
     
 
        
     
      SELECT @RecordCount = COUNT(*)
      FROM #Results
       
          
      SELECT * FROM #Results
      where RowNumber BETWEEN(@PageIndex -1) * @PageSize + 1 AND(((@PageIndex -1) * @PageSize + 1) + @PageSize) - 1
          
     
          
  
    
      DROP TABLE #Results
END
GO
/****** Object:  StoredProcedure [dbo].[GetManageState_Pager]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetManageState_Pager]
       @SearchTerm VARCHAR(100) = ''
      ,@PageIndex INT = 1
      ,@PageSize INT = 10
      ,@SearchTerm1 VARCHAR(100) = ''
     
      
      ,@RecordCount INT OUTPUT
AS
BEGIN
      SET NOCOUNT ON;
      SELECT ROW_NUMBER() OVER
      (
            ORDER BY [State_Id] ASC
      )AS RowNumber
      ,[State_Id]      
      ,[Country_Name]
      ,[State_Name]      
      ,[Country_Id]
      
      
      
      INTO #Results
      FROM StateView
      WHERE ([Country_Id] like @SearchTerm + '%'  OR [Country_Name]= '')
     and ([State_Id] like @SearchTerm1 + '%'  OR [state_Name] = '')
     
      
     
	ORDER BY CAST(SUBSTRING(State_Id, 6, 10) AS int) DESC, SUBSTRING(State_Id, 1, 1) DESC
        
     
      SELECT @RecordCount = COUNT(*)
      FROM #Results
       
          
      SELECT * FROM #Results
      where RowNumber BETWEEN(@PageIndex -1) * @PageSize + 1 AND(((@PageIndex -1) * @PageSize + 1) + @PageSize) - 1
          
     
          
  
    
      DROP TABLE #Results
END

GO
/****** Object:  StoredProcedure [dbo].[GetManageSupplier_Pager]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetManageSupplier_Pager]
       @SearchTerm VARCHAR(100) = ''
      ,@PageIndex INT = 1
      ,@PageSize INT = 10
      ,@SearchTerm1 VARCHAR(100) = ''
      ,@SearchTerm2 VARCHAR(100) = ''
      ,@SearchTerm3 VARCHAR(100) = ''
      ,@SearchTerm4 VARCHAR(100) = ''
      ,@SearchTerm5 VARCHAR(100) = ''
      ,@RecordCount INT OUTPUT
AS
BEGIN
      SET NOCOUNT ON;
      SELECT ROW_NUMBER() OVER
      (
            ORDER BY [SupplierCode] ASC
      )AS RowNumber
      ,[SupplierCode]
      ,[SupplierName]
      ,[SupplierCategory1]
      ,[state_Name]
       ,[city_Name]
      ,[Status1]
      ,[CostCenter1]
    ,[StateCode]
       ,[CityCode]
     , [CostCenter]
      
      
      INTO #Results
      FROM [SupplierView1]
      WHERE ([SupplierName] like @SearchTerm + '%'  OR [SupplierName] = '')
     and ([StateCode] like @SearchTerm1 + '%'  OR [state_Name] = '')
      and ([CityCode] LIKE @SearchTerm2 + '%' OR [city_Name] = '') 
      and ([CostCenter1] LIKE @SearchTerm3 + '%' OR [CostCenter1] = '')
      and ([SupplierCategory1] LIKE @SearchTerm4 + '%' OR [SupplierCategory1] = '')
      and ([Status1] LIKE @SearchTerm5 + '%' OR [Status1] = '') 
     order by cast(substring(SupplierCode,6,10)as int) desc , 
     substring(SupplierCode,1,1) desc
      
      
     
 
        
     
      SELECT @RecordCount = COUNT(*)
      FROM #Results
       
          
      SELECT * FROM #Results
      where RowNumber BETWEEN(@PageIndex -1) * @PageSize + 1 AND(((@PageIndex -1) * @PageSize + 1) + @PageSize) - 1
          
     
          
  
    
      DROP TABLE #Results
END

GO
/****** Object:  StoredProcedure [dbo].[Inward_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inward_Report]
	-- Add the parameters for the stored procedure here
	@po_no nvarchar(25)=null,
	@received_by nvarchar(50)=null,
	@supplier nvarchar(MAX)=null,
	@rmcat nvarchar(50)=null,
	@rmprod_cat nvarchar(50)=null,
	@material nvarchar(50)=null,
	@uid nvarchar(20)=null,
	@inward_no nvarchar(20)=null,
	@invoice_no nvarchar(50)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@costcenter int=null,
	@received_at nvarchar(20)=null,
	@gate_entry nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
select inwrd_mat.ID as 'UID',inwrd.Inward_Date as 'Date',inwrd_mat.Inward_ID as 'Inward ID',
cat.name as 'RM Product Category',rm.Name as 'Material',inwrd.Supplier,
inwrd_mat.GRNQty as 'GRN Qty',inwrd_mat.Total,inwrd.PO_No,inwrd.Invoice_No as 'Invoice No.'
from PMS_InwardMaterial inwrd_mat 
left outer join PMS_InwardMaster inwrd on inwrd.ID=inwrd_mat.Inward_ID
left outer join PMS_RawMaterial rm on inwrd_mat.Material=rm.ID
left outer join PMS_Category cat on inwrd_mat.RM_Prod_Cat=cat.id

where
(inwrd.PO_No like '%'+@po_no+'%'  or @po_no  is null)
and
(inwrd.Receiver_Name = @received_by or @received_by is null)
and
(inwrd.Supplier like '%'+@supplier+'%'  or @supplier  is null)
and
(RM_Prod_Cat = @rmcat or @rmcat is null)
and
(RM_Prod_Cat = @rmprod_cat or @rmprod_cat is null)
and
(Material = @material or @material is null)
and
(inwrd_mat.ID like '%'+@uid+'%'  or @uid  is null)
and
(inwrd.Invoice_No like '%'+@invoice_no+'%'  or @invoice_no  is null)
and
(CASE When LEN(inwrd.Inward_Date)=10 then  convert(datetime,inwrd.Inward_Date,105) else null END between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 
and
(inwrd.Cost_Center = @costcenter or @costcenter is null)
and
--( = @received_at or @received_at is null)

(inwrd.Gate_entry_No like '%'+@gate_entry+'%'  or @gate_entry  is null)
END

GO
/****** Object:  StoredProcedure [dbo].[p1]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[p1] AS
   EXEC ('create any table')

GO
/****** Object:  StoredProcedure [dbo].[pro1]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pro1] AS
   EXEC ('create any table')

GO
/****** Object:  StoredProcedure [dbo].[pro2]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE  PROCEDURE [dbo].[pro2] AS
   EXEC ('create any table')

GO
/****** Object:  StoredProcedure [dbo].[pro3]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE  PROCEDURE [dbo].[pro3] AS
   EXEC ('create any database')

GO
/****** Object:  StoredProcedure [dbo].[processJobCard]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[processJobCard]
(
	@QCOUNT varchar(50),
	@WOID varchar(50),
	@JCID varchar(50),
	@PROID varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	if(@QCOUNT='1')
	select Pro.ID as ProID ,Pro.Name as ProName from PMS_JobCard_ProcessSelection JCProcSelc
	inner join PMS_Processes PRO on JCProcSelc.Process=PRO.ID
	left outer join PMS_Machines MCH on JCProcSelc.Machines=MCH.ID
	where JCProcSelc.JobCart_Id=@JCID
	
	if(@QCOUNT='2')
	select 
	--MCH.Name+' - '+
	 CAST(WEOP.WERO_InPro_Qty as varchar)+ ' ' + UN.Unit
	--+CAST(
	--	CASE 
	--		WHEN 
	--			WE.CreatedOn is not null then ' (' +Convert(varchar,WE.CreatedOn,105) +')' 
	--		else 
	--			'' 
	--	END 
	--as VARCHAR)
	as Process from PMS_WorkOrder WO
	inner join PMS_WorkEntry WE on WO.ID=WE.Work_WorkOrder
	inner join PMS_WorkEntryResources_OutputPro WEOP on WE.ID=WEOP.WERO_WorkEntryId
	inner join PMS_Units UN on WEOP.WERO_InPro_Unit=UN.ID
	inner join PMS_Machines MCH on WE.Work_Machinary=MCH.ID
	where WE.ID=@WOID and WE.Work_Process=@PROID
	
END

GO
/****** Object:  StoredProcedure [dbo].[Search_Activity]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Activity]
	-- Add the parameters for the stored procedure here
	@act_name varchar(150)= null,
	@position varchar(50)= null,
	@senior varchar(50)= null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
Select a.Auto_Id,a.Activity_Name,a.Office_Position as Office_Position,a.Senior,c.Name
from
PMS_Activity a 
left outer join PMS_Users c
on a.Senior=c.ID
where
--a.Activity_Name like '%'+COALESCE(@act_name,a.Activity_Name)+'%' 
--	and 
--	a.Office_Position = COALESCE(@position,a.Office_Position) 
--	and  
--	a.Senior =COALESCE(@senior,a.Senior)
	
	(a.Activity_Name like '%'+@act_name+'%' or @act_name is null)
	and 
	(a.Office_Position like '%'+@position+'%' or @position is null) 
	and  
	(a.Senior like '%'+@senior+'%' or @senior is null )
	and a.Senior != '0'
	order by Cast(Substring(a.Auto_Id,6,10) as int) Desc, substring(a.Auto_Id,1,1) desc
END


GO
/****** Object:  StoredProcedure [dbo].[Search_Challan_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[Search_Challan_Report]
	-- Add the parameters for the stored procedure here
	@customer nvarchar(50)=null,
	@workorder nvarchar(50)=null,
	@jobcard varchar(150)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@challan_no nvarchar(25)=null,
	@status int=null,
	@lr_status char(1)=null,
	@sortby varchar(20)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	


select gc.chal_ID,gc.chal_No,cust.cust_Name,jo.order_Id + ' ' + '(' + jo.Order_Name + ')'  as 'JobOrder',
wo.WorkOrderID + ' ' + '(' + wo.WorkOrderName + ')'  as 'Workrder',wo.Quantity,
convert(nvarchar,gc.chal_Date,105) as 'Date',
case when gc.LR_Status = 'y' then 'Done'
when gc.LR_Status = 'N' then 'Not_done'
else '' end as 'LR Status'
from PMS_GenerateChallan gc 
left outer join PMS_WorkOrder wo on wo.ID=gc.chal_SO_No
left outer join PMS_JobOrder jo on wo.JobOrderID=jo.ID
LEFT outer join PMS_Customer cust on cust.cust_Id=wo.CustomerID
left outer join PMS_Invoice_Master im on gc.chal_ID=im.Challan_ID

where 
(cust.cust_Id = @customer  or @customer  is null)
and
(gc.chal_SO_No = @workorder or @workorder is null)
and
(jo.ID = @jobcard or @jobcard is null)
and
(CASE When LEN(gc.chal_Date)=10 then  convert(datetime,gc.chal_Date,105) else null END between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 
and
(gc.chal_ID = @challan_no or @challan_no is null)
and
(gc.flag = @status or @status is null)
and
(gc.LR_Status = @lr_status or @lr_status is null)
and
--(gc. =@sortby or @sortby is null)
 (gc.chal_ID =@sortby or @sortby is null)
 order by gc.chal_Date desc


END

GO
/****** Object:  StoredProcedure [dbo].[Search_ChallanListingPage]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_ChallanListingPage]
	-- Add the parameters for the stored procedure here
	@customer nvarchar(50)=null,
	@workorder nvarchar(50)=null,
	@jobcard varchar(150)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@challan_no nvarchar(25)=null,
	@status int=null,
	@lr_status char(1)=null,
	@sortby varchar(20)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	


select gc.chal_ID as 'ChallanID' ,gc.chal_No as 'ChallanNo',cust.cust_Name as 'CustName',jo.order_Id + ' ' + '(' + jo.Order_Name + ')'  as 'JobOrder',
wo.WorkOrderID + ' ' + '(' + wo.WorkOrderName + ')'  as 'WorkOrder',wo.Quantity,
convert(nvarchar,gc.chal_Date,105) as 'Date',
gc.chal_Date as 'Challan Date',(Select Case When gcd.POQty =0.00 then gcd.chalDet_QtyTaken else gcd.POQty end) as 'Qty Disp',
case when gc.LR_Status = 'y' then 'Done'
when gc.LR_Status = 'N' then 'Not_done'
else '' end as 'LR_Status'
from PMS_GenerateChallan gc 
left join PMS_GenerateChallanDetails gcd on gc.chal_ID = gcd.chal_ID 
left outer join PMS_WorkOrder wo on wo.ID=gc.chal_SO_No
left outer join PMS_JobOrder jo on wo.JobOrderID=jo.ID
LEFT outer join PMS_Customer cust on cust.cust_Id=wo.CustomerID
left outer join PMS_Invoice_Master im on gc.chal_ID=im.Challan_ID

where 
(cust.cust_Id = @customer  or @customer  is null)
and
(gc.chal_SO_No = @workorder or @workorder is null)
and
(jo.ID = @jobcard or @jobcard is null)
and
(CASE When LEN(gc.chal_Date) >=10 then  convert(datetime,gc.chal_Date,105) else null END between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 
and
(gc.chal_ID = @challan_no or @challan_no is null)
and
(gc.flag = @status or @status is null)
and
(gc.LR_Status = @lr_status or @lr_status is null)
and
--(gc. =@sortby or @sortby is null)
 (gc.chal_ID =@sortby or @sortby is null)
 order by gc.chal_Date desc


END


GO
/****** Object:  StoredProcedure [dbo].[Search_City]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_City]
	-- Add the parameters for the stored procedure here
	@Country_name nvarchar(50)=null,
	@State_name nvarchar(50)=null,
	@City_name nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select a.city_Id,c.Country_Name,b.State_Name,a.city_Name,a.city_Code
	from
	PMS_City a left outer join PMS_State b
	on a.state_Id=b.State_Id
	left outer join
	PMS_Country c
	on b.country_Id=c.Country_Id
	
	where 
	(@City_name is null or a.city_id = @City_name)
	and
	(@State_name is null or b.State_Id = @State_name)
	and
	(@Country_name is null or c.Country_Id = @Country_name)
	order by cast(Substring(city_Id,6,10)as int) Desc , substring(city_Id,1,1) desc
	
END
GO
/****** Object:  StoredProcedure [dbo].[Search_CompanyRTGS_NEFT]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Search_CompanyRTGS_NEFT] 
	@comp_name nvarchar(50)=null,
	@sname varchar(20)=null,
	@Amount nvarchar(50)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@chequeno nvarchar(50)=null,
	@Status int =null
AS
BEGIN
	SET NOCOUNT ON;

	select a.ID,c.comp_Name,a.Date,d.SupplierName,a.CreatedOn,a.Amount,a.Cheque_No,a.NEFTStatus,Case when b.BankName='Saraswat Bank' then 'saraswat'
		 when b.BankName='UNION BANK OF INDIA' then 'unionbank'
		 when b.BankName='HDFC BANK' then 'hdfc'
		 when b.BankName='DEUTSCHE BANK' then 'deutscheBank'
		 when b.BankName='ICICI BANK' then 'icici' 
		 ELSE 'saraswat' END as bank,
	CASE when a.NEFTStatus =1 then 'Cancel' 
	When a.NEFTStatus =0 then 'Approved' 
	ELSE '' END  as Status,a.Reason
	from PMS_Company_RTGS a 
	left outer join PMS_Company_BankDetails b on a.Comp_BD_ID=b.ID
	left outer join PMS_Company c on b.Comp_ID=c.comp_Id
	left outer join PMS_SupplierMaster d on a.Supplier_ID=d.SupplierCode
	where 
	--c.comp_Name like '%'+COALESCE(@comp_name,c.comp_Name)+'%' 
	--and 
	--a.Supplier_ID=COALESCE(@sname,a.Supplier_ID) 
	--and
	--CAST(a.Amount as varchar) like '%'+CAST(COALESCE(@Amount,a.Amount) as VARCHAR)+'%' 
	--and
	--a.createdon between convert(datetime,''+coalesce(@fromdate,convert(varchar(10), a.CreatedOn, 110))+'',105) and convert(datetime,''+coalesce(@todate,convert(varchar(10),a.CreatedOn,110))+'',105)	
	--and 
	--a.Cheque_No like '%'+COALESCE(@chequeno,a.Cheque_No)+'%' 
	--and  
	--a.NEFTStatus =CAST(COALESCE(@Status, a.NEFTStatus) as int) 

	(c.comp_Name like '%'+@comp_name+'%' or @comp_name is null) 
	and 
	(a.Supplier_ID=@sname or @sname is null) 
	and
	(CAST(a.Amount as varchar) like '%'+CAST(@Amount as VARCHAR)+'%' or @Amount is null) 
	and
	(a.createdon between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)	or (@fromdate is null or @todate is null))
	and 
	(a.Cheque_No like '%'+@chequeno+'%' or @chequeno is null)
	and  
	(a.NEFTStatus =CAST(@Status as int) or @Status is null)
	order by substring(a.ID,1,1) asc, cast(substring(a.ID,6,10) as int) desc, cast(substring(a.ID,12,10) as int) desc
END


GO
/****** Object:  StoredProcedure [dbo].[Search_Complaint_Reports]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Complaint_Reports] 
	-- Add the parameters for the stored procedure here
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@reports nvarchar(max)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

Select ID,SUBSTRING(Work_Complains, 1, 100) AS Work_Complains,
EntryDate  from PMS_WorkEntry we

where

--(CASE When LEN(we.EntryDate)=10 
--then  
convert(datetime,we.EntryDate,105) 
--else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)
--)
 and
(we.ID = @reports or @reports is null)
  

END

GO
/****** Object:  StoredProcedure [dbo].[Search_Customer]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:        <Author,,Name>
-- Create date: <Create Date,,>
-- Description:   <Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Customer]
      -- Add the parameters for the stored procedure here
      @Sales_person nvarchar(30)= null, 
      @Custname nvarchar(550) =null,
      @flag bit =1,
      @Sort nvarchar(15)
AS
BEGIN
      SET NOCOUNT ON;
if(@Sort='Default')
BEGIN
 SELECT a.cust_Id,a.cust_UId,a.cust_No,b.comp_Name,a.cust_Name, a.cust_PBoxNo,a.Active_Flag,
 a.cust_SalesPerson
      from PMS_Customer a 
      left outer join PMS_Company b on a.cust_Company=b.comp_Id 
      left outer join PMS_Users c on a.cust_SalesPerson=c.Id
	  where 
	  --a.cust_Name like '%'+COALESCE(@Custname, a.cust_Name)+'%' 
	  --and 
	  --a.cust_SalesPerson =COALESCE(@Sales_person, a.cust_SalesPerson)
	  
	  (a.Active_Flag =@flag )
	  and
	  (a.cust_Name like '%'+@Custname+'%' or @Custname is null)
	  and 
	  (a.cust_SalesPerson = @Sales_person or @Sales_person is null)
	  --order by a.CreatedOn desc
	   order by cast(substring(cust_UId,6,10)as int) desc , substring(cust_UId,1,1) desc
	   END
  else
  begin
     SELECT a.cust_Id,a.cust_UId,a.cust_No,b.comp_Name,a.cust_Name, a.cust_PBoxNo,a.Active_Flag,
 a.cust_SalesPerson
      from PMS_Customer a 
      left outer join PMS_Company b on a.cust_Company=b.comp_Id 
      left outer join PMS_Users c on a.cust_SalesPerson=c.Id
	  where 
	  --a.cust_Name like '%'+COALESCE(@Custname, a.cust_Name)+'%' 
	  --and 
	  --a.cust_SalesPerson =COALESCE(@Sales_person, a.cust_SalesPerson)
	  
	  (a.Active_Flag =@flag )
	  and
	  (a.cust_Name like '%'+@Custname+'%' or @Custname is null)
	  and 
	  (a.cust_SalesPerson = @Sales_person or @Sales_person is null)
	  order by a.CreatedOn desc
	   --order by cast(substring(cust_UId,6,10)as int) desc , substring(cust_UId,1,1) desc
  end	   
END
GO
/****** Object:  StoredProcedure [dbo].[Search_Daily_Reports]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Daily_Reports] 
	-- Add the parameters for the stored procedure here
	@process nvarchar(255)=null,
	@machine nvarchar(255)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	


select pwe.id,pwe.Operator,pwe.Assistant,pwe.Output + '-' + pwe.Unit as outunit, 
pjo.order_name,pjo.order_Id,pwo.WorkOrderID,c.cust_Name, pst.site,
 pm.name 'machine',ps.Name,
pwe.entrydate 
from 
pms_workentry pwe 
inner join pms_joborder pjo on pjo.id = pwe.work_joborder 
left outer join pms_workorder pwo on pwo.id = pwe.work_workorder
inner join PMS_Machines pm on pm.id = pwe.Work_Machinary 
inner join PMS_Processes ps on ps.id = pwe.Work_Process 
inner join PMS_sites pst on pst.id = pwe.Work_Godown 
inner join PMS_Customer c on pwo.CustomerID = c.cust_Id 
 left join PMS_Users pu on pwe.Assistant=pu.ID 
 left join PMS_Users pu1 on pwe.UserId=pu1.ID 
 left join PMS_Users pu2 on pwe.Helper=pu2.ID 
 
 
 where
 (pwe.Work_Process = @process or @process is null)
 and
 (pwe.Work_Machinary = @machine or @machine is null)            
END

GO
/****** Object:  StoredProcedure [dbo].[Search_DebitMaster]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_DebitMaster] 
	-- Add the parameters for the stored procedure here
	@debit varchar(500)=null,
	@comp nvarchar(50)=null,
	@inv varchar(500)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

select dbtm.Debit_ID,dbtm.Debit_Date,comp.comp_Name,dbtd.Perticulers
from PMS_DebitNote_Master dbtm
left outer join PMS_DebitNote_Details dbtd on dbtd.Debit_ID=dbtm.Debit_ID
left outer join PMS_Company comp on comp.comp_Id=dbtm.Master_CompanyID

where 

(dbtm.Debit_ID = @debit or @debit is null)
and
(dbtm.Master_CompanyID = @comp or @comp is null)
and
(dbtm.InvoiceOrRef_No like '%'+@inv+'%' or '%'+@inv+'%' is null)
and
(CASE When LEN(dbtm.Debit_Date)=10 
then  
convert(datetime,dbtm.Debit_Date,105) 
else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)
) 
END

GO
/****** Object:  StoredProcedure [dbo].[Search_DebitNote_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_DebitNote_Report] 
	-- Add the parameters for the stored procedure here
	@company nvarchar(50)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

SELECT DISTINCT comp.comp_Name,
isnull
(SUM (dbtn.Debit),0) AS DebitAmount,
isnull
(SUM(im.TotalAmount),0) AS InvTotAmount 
FROM  dbo.PMS_Company comp
left OUTER JOIN dbo.PMS_DebitNote_Master dbtm  ON dbtm.Master_CompanyID =comp.comp_Id 
LEFT OUTER JOIN dbo.PMS_DebitNote_Details dbtn ON dbtm.Debit_ID = dbtn.Debit_ID 
LEFT OUTER JOIN dbo.Gen_ChallanView gcv 
INNER JOIN  dbo.PMS_Invoice_Master im ON gcv.chal_ID = im.Challan_ID 
ON comp.comp_Name = gcv.comp_Name

where 
(dbtm.Master_CompanyID = @company or @company is null)
and
--(CASE When LEN(dbtm.CreatedOn)=10 
--then   
(dbtm.CreatedOn)
--else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)	or (@fromdate is null or @todate is null)
--)						

GROUP BY comp.comp_Name
END

GO
/****** Object:  StoredProcedure [dbo].[Search_FinishGoods_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_FinishGoods_Report]
	-- Add the parameters for the stored procedure here
	--@entryNo nvarchar(50)=null,
	@cust varchar(255)=null,
	@wo nvarchar(50)=null,
	@jo nvarchar(50)=null,
	--@location varchar(50)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

select distinct we.ID,jo.Order_Name+' '+(jo.Order_Id)as 'Job Cart',wo.WorkOrderID,
Cust.cust_Name,
fg.cc_QtyProd,un.Unit,fg.cc_Boxes,convert(nvarchar,we.EntryDate,105)as 'Entry Date'
from PMS_WorkEntry we 
left outer join PMS_JobOrder jo on we.Work_JobOrder=jo.ID
left outer join PMS_WorkOrder wo on we.Work_WorkOrder=wo.ID
--left outer join pms_GoDown gd on we.Work_Godown=gd.ID
--left outer join PMS_Sites st on we.Work_Godown=st.ID
left outer join PMS_FGEntry fg on fg.cc_WorkOrderId = wo.ID
left outer join PMS_Units un on un.ID=fg.cc_Unit
left outer join PMS_Customer cust on cust.cust_Id=wo.CustomerID
where

--(we.ID like '%'+@entryNo+'%' or @entryNo is null)
--and
(wo.CustomerID = @cust or @cust is null)
and
(wo.ID = @wo or @wo is null)
and
(we.Work_JobOrder = @jo or @jo is null)
and
--(we.Work_Godown = @location or @location is null)
--and
(CASE When LEN(we.EntryDate)>10 
then  
convert(datetime,we.EntryDate,105) 
else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)
)



END

GO
/****** Object:  StoredProcedure [dbo].[Search_GenerateChallan]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_GenerateChallan] 
	-- Add the parameters for the stored procedure here
	@customer nvarchar(255)=null,
	@wo nvarchar(50)=null,
	@jo nvarchar(50)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@status int =null, 
	@fgcnt nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
select distinct fg.cc_ID,jo.Order_Id as 'order_Id',jo.Order_Name,
wo.WorkOrderName+' (' + WorkOrderID +')' as 'WorkOrder',wo.Quantity as 'Qty',
fg.cc_QtyProd as 'Prod Qty',
fg.cc_QtyDispatch as 'Disp Qty',fg.cc_FGqty as 'FG Qty',
fg.cc_Date as 'Last Update',cust.cust_Name as 'Cust Name'
from PMS_FGEntry fg 
left outer join PMS_WorkOrder wo on wo.ID=fg.cc_WorkOrderId
left outer join PMS_JobOrder jo on wo.JobOrderID=jo.ID
left outer join PMS_Customer cust on wo.CustomerID=cust.cust_Id


where
(wo.CustomerID = @customer or @customer is null)
and
(fg.cc_WorkOrderId = @wo or @wo is null)
and
(wo.JobOrderID =@jo or @jo is null)
and
(CASE When LEN(fg.cc_Date)=10 
then  
convert(datetime,fg.cc_Date,105) 
else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)
) 

and

(wo.Status =@status or @status is null)
and
(fg.cc_ID = @fgcnt or @fgcnt is null)




END

GO
/****** Object:  StoredProcedure [dbo].[Search_InkMixture]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_InkMixture]
	-- Add the parameters for the stored procedure here
	@EntryNo nvarchar(50)=null,
	@FinalInk nvarchar(50)=null,
	@Datefrom nvarchar(50) =null,
	@dateto nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select a.ID,a.NewColour,c.Color_Shade
	 from PMS_Ink_Mixture a 
	 left outer join PMS_Ink_Mixture_Color b 
	 on a.ID=b.InkId 
	 left outer join PMS_ColorShade c
	 on b.InkName=c.Auto_Id
	 
	where 
	--a.ID like '%'+COALESCE(@EntryNo,a.ID)+'%' and 
	--a.NewColour like '%'+COALESCE(@FinalInk,a.NewColour)+'%' 
	--and 
	--convert(datetime,a.CreatedOn,105) between convert(datetime,@Datefrom,105) and convert(datetime,@dateto,105)
	 
	 
	 (a.ID like '%'+@EntryNo+'%'  or @EntryNo is null)
	 and 
	(a.NewColour like '%'+@FinalInk+'%' or @FinalInk is null)
	and
	(a.CreatedOn between convert(datetime,''+@Datefrom+'',105) and convert(datetime,''+@dateto+'',105)	or (@Datefrom is null or @dateto is null)) 
	
	
	
END

GO
/****** Object:  StoredProcedure [dbo].[Search_InkMixture_2]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Search_InkMixture_2] 
	-- Add the parameters for the stored procedure here
	@jobname2 nvarchar(500)=null,
	@inkname nvarchar(50)=null,
	@inkqty nvarchar(500)=null,
	@createdby nvarchar(50)=null,
	@Datefrom nvarchar(50) =null,
	@dateto nvarchar(50)=null
AS
BEGIN
		DECLARE
        @Query varchar(MAX),
        @searchCount int=0
        
		set @Query='select a.ID,b.NewColour,a.Job_Name,a.Qty_Ink_Kg,c.Name,a.CreatedOn
					 from PMS_Ink_Mixture_Created a 
					 left outer join PMS_Ink_Mixture b on a.InkMixture=b.ID 
					 left outer join PMS_Users c on a.CreatedBy=c.ID '

		 if(@inkname is not null)
			if(@searchCount=0)
					set @Query+=' where b.NewColour like ''%'+@inkname+'%'' '
			ELSE
					set @Query+=' and b.NewColour like ''%'+@inkname+'%'' '
					
			SET @searchCount=@searchCount+1
		 
		 if(@jobname2 is not null)
			if(@searchCount=0)
					set @Query+=' where a.Job_Name like ''%'+@jobname2+'%'' '
			ELSE
					set @Query+=' and a.Job_Name like ''%'+@jobname2+'%'' '
			
			SET @searchCount=@searchCount+1
			
		 if(@inkqty is not null)
			if(@searchCount=0)
				set @Query+=' where a.Qty_Ink_Kg like ''%'+@inkqty+'%'' '
			ELSE
				set @Query+=' and a.Qty_Ink_Kg like ''%'+@inkqty+'%'' '
			
			SET @searchCount=@searchCount+1
			
		 if(@createdby is not null)
			if(@searchCount=0)
				set @Query+=' where c.ID = '''+@createdby+''' '
			ELSE
				set @Query+=' and c.ID = '''+@createdby+''' '
				
			SET @searchCount=@searchCount+1
			
		 if(@Datefrom is not null and @dateto is not null)
			if(@searchCount=0)
				set @Query+=' where convert(datetime,a.CreatedOn,105) between convert(datetime,'''+@Datefrom+''',105) and convert(datetime,'''+@dateto+''',105) '
			ELSE
				set @Query+=' and convert(datetime,a.CreatedOn,105) between convert(datetime,'''+@Datefrom+''',105) and convert(datetime,'''+@dateto+''',105) '
				
			SET @searchCount=@searchCount+1

	  exec (@Query)
END

GO
/****** Object:  StoredProcedure [dbo].[Search_InkMixtureCreated]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_InkMixtureCreated] 
	-- Add the parameters for the stored procedure here
	@jobname nvarchar(500)=null,
	@inkname nvarchar(50)=null,
	@inkqty nvarchar(500)=null,
	@createdby nvarchar(50)=null,
	@Datefrom nvarchar(50) =null,
	@dateto nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select a.ID,b.NewColour,a.Job_Name,a.Qty_Ink_Kg,c.Name,a.CreatedOn
 from 
 PMS_Ink_Mixture_Created a left outer join PMS_Ink_Mixture b 
 on a.InkMixture=b.ID 
 left outer join PMS_Users c 
 on 
 a.CreatedBy=c.ID
where 
--a.Job_Name like '%'+COALESCE(@jobname,a.Job_Name)+'%' 
--and 
--b.NewColour like '%'+COALESCE(@inkname,b.NewColour)+'%' 
--and 
--a.Qty_Ink_Kg like '%'+COALESCE(@inkqty ,a.Qty_Ink_Kg)+'%' 
--and
--c.ID = COALESCE(@createdby ,c.ID) 
--and 
--a.CreatedOn between 
--convert(datetime,''+COALESCE(@Datefrom,convert(varchar(10), a.CreatedOn, 110))+'',105) and convert(datetime,''+coalesce(@dateto,convert(varchar(10),a.CreatedOn,110))+'',105)


(a.Job_Name like '%'+@jobname+'%' or @jobname is null) 
and 
(b.NewColour like '%'+@inkname+'%' or @inkname is null) 
and 
(a.Qty_Ink_Kg like '%'+@inkqty+'%' or @inkqty is null ) 
and
(c.ID =@createdby or @createdby is null ) 
and 
(a.CreatedOn between convert(datetime,''+@Datefrom+'',105) and convert(datetime,''+@dateto+'',105)	or (@Datefrom is null or @dateto is null))

order by cast(substring(a.ID,12,10) as int)desc
END

GO
/****** Object:  StoredProcedure [dbo].[Search_Inward_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Inward_Report] 
	-- Add the parameters for the stored procedure here
	@po nvarchar(25)=null,
	@received_by nvarchar(50)=null,
	@supplier nvarchar(MAX)=null,
	@rmcat nvarchar(50)=null,
	@rm_prod nvarchar(50)=null,
	@material nvarchar(255)=null,
	@uid nvarchar(20)=null,
	@inward nvarchar(20)=null,
	@invoice nvarchar(50)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@cost_center varchar(100)=null,
	@received_at nvarchar(255)=null,
	@gate_entry nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

select distinct iwd.ID as 'UID',iwm.ID as 'Inward No.',cat.name as 'RM Prod Cat',
rm.Name as 'Material',
im.Quantity,iwm.Supplier,iwm.PO_No,
convert(nvarchar,iwm.Inward_Date,105)as 'Date',
iwm.Gate_entry_No
from  PMS_InwardDocuments iwd
left outer join PMS_InwardMaster iwm on iwm.ID=iwd.Inward_ID
left outer join PMS_InwardMaterial im on iwm.ID=im.Inward_ID
left outer join PMS_Category cat on im.RM_Prod_Cat=cat.id
left outer join PMS_RawMaterial rm on im.Material=rm.ID
left outer join PMS_Users usr on usr.ID=iwm.Receiver_Name
left outer join PMS_Sites st on st.ID=usr.Site


where
(iwm.PO_No like '%'+@po+'%'  or @po is null )
and 
(iwm.ID = @received_by or @received_by is null) 
and  
(iwm.Supplier like '%'+@supplier+'%'  or @supplier is null )
and
(im.RM_Cat = @rmcat or @rmcat is null) 
and  
(im.RM_Prod_Cat = @rm_prod or @rm_prod is null) 
and  
(iwm.Cost_Center = @cost_center or @cost_center is null) 
and  
(iwd.ID like '%'+@uid+'%'  or @uid is null )
and
(iwm.ID like '%'+@inward+'%'  or @inward is null )
and
(iwm.Invoice_No like '%'+@invoice+'%'  or @invoice is null )
and
(CASE When LEN(iwm.Inward_Date)=10
 then  
convert(datetime,iwm.Inward_Date,105) else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 

and
(iwm.ID = @received_at or @received_at is null) 
and  
(iwm.Gate_entry_No like '%'+@gate_entry+'%'  or @gate_entry is null )

	
	
END

GO
/****** Object:  StoredProcedure [dbo].[Search_Machines]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Machines] 
	-- Add the parameters for the stored procedure here
	@mname nvarchar(255)=null,
	@pcat nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select a.ID,a.UniqueID,a.Name,a.Description,
	b.Process_Category AS 'Category',c.Site,a.Capacity
	from
	PMS_Machines a 
	left outer join PMS_ProcessCategory b 
	on a.Category=b.id
	left outer join PMS_Sites c 
	on a.Site=c.ID
	where
	
	--a.Name like '%'+COALESCE(@mname,a.Name)+'%' and 
	--a.Category = COALESCE(@pcat ,a.Category)
	
	(a.Name like '%'+@mname+'%' or @mname is null) 
	and 
	(a.Category = @pcat or @pcat is null)
	Order By cast (substring(a.ID,6,10)as int) desc, substring(a.ID,1,1) desc
END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_Appraisal]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_Appraisal] 
	-- Add the parameters for the stored procedure here
	@appraisal_by nvarchar(255)=null,
	@appraisal_to nvarchar(255)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

select ap.ID,usr.Name as 'Appraisal By',usr1.Name as 'Appraisal To'
from PMS_Appraisal ap
left outer join PMS_Users usr on ap.AppraisalBy=usr.ID
left outer join PMS_Users usr1 on ap.AppraisalTo=usr1.ID

where
(ap.ID = @appraisal_by or @appraisal_by is null)
and
(ap.ID = @appraisal_to or @appraisal_to is null)

END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_ChallanMovement]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_ChallanMovement] 
	-- Add the parameters for the stored procedure here
	@id nvarchar(50)=null,
	@pd1 nvarchar(255)=null,
	@pd2 nvarchar(255)=null,
	@pd3 nvarchar(255)=null,
	@status int=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
select dp1.SrNo as RowNumber,dp1.ID as ID, dp1.Goods_Description  as Goods_Description,
dp2.Description as Description2,
dp3.Description as Description3,dp1.Status
 from PMS_Dispatch_Partiat_Part1 dp1
left outer join PMS_Dispatch_Partial_Part2 dp2 on dp1.ID=dp2.Part1_ID
left outer join PMS_Dispatch_Partial_Part3 dp3 on dp1.ID=dp3.Part1_ID

where
(dp1.ID like '%'+@id+'%' or @id is null) 
 and 
 (dp1.Goods_Description like '%'+@pd1+'%' or @pd1 is null) 
 and 
 (dp2.Description like '%'+@pd2+'%' or @pd2 is null) 
 and 
 (dp3.Description like '%'+@pd3+'%' or @pd3 is null) 
 and
 (dp1.Status = @status or @status is null)
 
order by  substring(dp1.ID,1,1) Desc,cast(substring(dp1.ID,6,2) as int) desc,cast(substring(dp1.ID,12,10) as int) desc
END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_ChangeRequest]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_ChangeRequest] 
	-- Add the parameters for the stored procedure here
	
	@modulename nvarchar(50)=null,
	@reqname varchar(100)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

Select a.Reqst_Id,a.DateTime,a.ModuleName,(case when c.MenuName!='' then c.MenuName else a.ModuleName end) as ModuleName1, 
a.Reqst_Details,a.TypeofModule,a.TypeofReqst,b.Name,a.Status from PMS_ChangeRequestModule a 
left join PMS_Users b 
on a.UserId=b.ID left join Pms_PriviledgeMaster c on a.ModuleName=c.Id

where
(a.ModuleName = @modulename or @modulename is null)
and
(CASE When LEN(a.DateTime)>=10 then  convert(date,a.DateTime,105) else null END between convert(date,''+@fromdate+'',105) and convert(date,''+@todate+'',105)or (@fromdate is null or @todate is null)) 
and
(a.UserId = @reqname or @reqname is null)
order by cast(substring(a.Reqst_Id,6,14) as int) desc, substring(a.Reqst_Id,1,1) desc
END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_ComplaintSystem]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_ComplaintSystem] 
	-- Add the parameters for the stored procedure here
	@complain_No varchar(50)=null,
	@category varchar(100)=null,
	@title varchar(100)=null,
	@complain_by nvarchar(50)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@status int=null,
	@fromdate1 nvarchar(50)=null,
	@todate1 nvarchar(50)=null,
	@location nvarchar(20)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
 SELECT cmpln.Auto_Id,usr1.Name,cmpln.Entry_Date, cmpln.Complain_Category,
  cmpln.Complain_Title,
 CASE when cmpln.status='1' then 'New' 
	When cmpln.status='2' then 'Resolved' 
	ELSE '' END as 'Status',
  --case when a.status='2' then 'Resolved' else 'New' end as Status
--a.Complain_Text, 
--CAST ((select case when a.status='2' then 'Resolved' else 'New' end) as nvarchar(10)) 
--as Status
usr2.Name as UpdatedBy,cmpln.UpdatedOn 
FROM PMS_Complain_Mgmt_System cmpln 
left outer join PMS_Users usr1 on cmpln.User_Name=usr1.ID 
left outer join PMS_Users usr2 on cmpln.UpdatedBy=usr2.ID 


where

(cmpln.Auto_Id like '%'+@complain_No + '%' or @complain_No  is null)
and
(cmpln.Complain_Category = @category or @category is null)
and
(cmpln.Complain_Title like '%'+@title+ '%' or @title is null)
and
(cmpln.User_Name = @complain_by or @complain_by is null)
and
(CASE When LEN(cmpln.Entry_Date)>=10 then  
convert(datetime,cmpln.Entry_Date,105) 
else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)
)
and
(cmpln.status = @status or @status is null)
and
(CASE When LEN(cmpln.UpdatedOn)>=10 then  convert(datetime,cmpln.UpdatedOn,105) else null END between convert(datetime,''+@fromdate1+'',105) and convert(datetime,''+@todate1+'',105)or (@fromdate1 is null or @todate1 is null)) 
and
(cmpln.Auto_Id like '%' + @location + '%' or @location is null)
order by cast(substring(cmpln.Auto_Id,9,2) as int)desc, cast(substring(cmpln.Auto_Id,12,10) as int)desc, substring(cmpln.Auto_Id,1,1) desc
END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_CustFeedback]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_CustFeedback]
	-- Add the parameters for the stored procedure here
	@customer nvarchar(550)=null,
	@wo nvarchar(50)=null,
	@status int =null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

Select  cf.CustFd_Id,cust.cust_Name ,cf.SO_Id,
wo.WorkOrderName,cf.Suggestion,
cf.CreateDate as 'UpdateDate',cf.Status,
cf.Link
from PMS_CustFeedback cf
left outer join PMS_WorkOrder wo on cf.SO_Id = wo.ID
left outer join PMS_Customer cust on cust.cust_Id=wo.CustomerID

where
(wo.CustomerID = @customer or @customer is null) 
and  
(cf.SO_Id =@wo or @wo is null)
and 
((CASE When LEN(cf.CreateDate) >=10 then  convert(date,cf.CreateDate,105) else null END between convert(date,''+@fromdate+'',105) and convert(date,''+@todate+'',105))or (@fromdate is null or @todate is null)) 
and
(cf.Status =@status or @status is null)
order by cast(substring(cf.CustFd_Id,6,10)as int) desc , substring(cf.CustFd_Id,1,1) desc
END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_DocumentTransfer]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_DocumentTransfer]
	-- Add the parameters for the stored procedure here
	@docname nvarchar(MAX)=null,
	@personname nvarchar(50)=null,
	@status int=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@fromdate1 nvarchar(50)=null,
	@todate1 nvarchar(50)=null,
	@location nvarchar(20)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

select td.ID,td.Doc_Name as 'Document Name',td.Remark,usr.Name as 'Sent by',
usr1.Name as 'Expected Receiver',usr2.Name as 'Actual_Receiver',
convert(nvarchar,td.Entry_Date,105) 'Sent Date',
convert(nvarchar,td.Received_Date,105) as 'Received Date',
CASE when td.Status='2' then 'Sent' 
	when td.Status='1' then 'Received at Reception'
	When td.Status='0' then 'Acknowledge' 
	ELSE '' END as Status,
td.Remark
from PMS_TransferDoc td 
left outer join PMS_Users usr on td.Send_By=usr.ID
left outer join PMS_Users usr1 on td.Receiver_Name=usr1.ID
left outer join PMS_Users usr2 on td.Received_By=usr2.ID
left outer join PMS_Sites st on st.ID=usr.Site

where 

(td.Doc_Name like '%' +@docname+ '%' or @docname is null)
and
(td.Send_By = @personname or @personname is null)
and
(td.Status = @status or @status is null)
and
(CASE When LEN(td.Entry_Date)>10 then  
convert(datetime,td.Entry_Date,105) 
else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null))
and
(CASE When LEN(td.Received_Date)=10 then  convert(datetime,td.Received_Date,105) else null END between convert(datetime,''+@fromdate1+'',105) and convert(datetime,''+@todate1+'',105)or (@fromdate1 is null or @todate1 is null)) 
and
(usr.Site = @location or @location is null)


END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_FGEntry]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_FGEntry]
	-- Add the parameters for the stored procedure here
	@entryNo nvarchar(50)=null,
	@cust varchar(255)=null,
	@wo nvarchar(50)=null,
	@jo nvarchar(50)=null,
	@location varchar(50)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

select  we.ID,jo.Order_Name+' '+(jo.Order_Id)as 'Job Cart',wo.WorkOrderID,
st.Site,convert(nvarchar,we.EntryDate,105)as 'Entry Date',fg.cc_QtyProd,fg.cc_Boxes
from PMS_WorkEntry we 
left outer join PMS_JobOrder jo on we.Work_JobOrder=jo.ID
left outer join PMS_WorkOrder wo on we.Work_WorkOrder=wo.ID
--left outer join pms_GoDown gd on we.Work_Godown=gd.ID
left outer join PMS_Sites st on we.Work_Godown=st.ID
left outer join PMS_FGEntry fg on fg.cc_WorkOrderId = wo.ID

where

(we.ID like '%'+@entryNo+'%' or @entryNo is null)
and
(wo.CustomerID = @cust or @cust is null)
and
(wo.ID = @wo or @wo is null)
and
(we.Work_JobOrder = @jo or @jo is null)
and
(we.Work_Godown = @location or @location is null)
and
(CASE When LEN(we.EntryDate)>10 
then  
convert(datetime,we.EntryDate,105) 
else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)
)



END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_GeneralMaterialAllotment]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_GeneralMaterialAllotment]
	-- Add the parameters for the stored procedure here
	@rm_cat nvarchar(50)=null,
	@prod_cat nvarchar(50)=null,
	@prod nvarchar(255)=null,
	@users nvarchar(50)=null,
	@machines nvarchar(255)=null,
	@status nvarchar(10)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	
select gma.Material_Id as 'Material_Id',rm.Name as 'Item',gma.Qty as 'Qty',
gma.Machinary as 'Machine',usr.Name ,convert(nvarchar,gma.EntryDate,105) as 'EntryDate',
case when gma.MaterialStatus='0' then 'Alloted'
when gma.MaterialStatus='1' then 'Returned'
when gma.MaterialStatus='2' then 'Consumed'
else ' ' end as 'Status'
from PMS_GeneralMaterialAllotment gma 
left outer join PMS_RawMaterial rm on gma.RM_Item=rm.ID
left outer join PMs_users usr on gma.PersonName=usr.ID
left outer join PMS_Machines mchn on mchn.ID = gma.Machinary

where
(gma.RM_Cat = @rm_cat or @rm_cat is null)
and 
(gma.RM_ProdCat = @prod_cat or @prod_cat is null)
and 
(rm.ID =@prod or @prod is null)
and 
(usr.ID = @users or @users is null)
and 
(gma.Machinary =@machines or @machines is null)
and 
(gma.MaterialStatus = @status or @status is null)
and 
(gma.EntryDate between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)	or (@fromdate is null or @todate is null)) 
order by CAST(substring(Material_Id,9,2) as int) desc, CAST(substring(Material_Id,12,10) as int) desc, substring(Material_Id,1,1) desc

END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_GRNMaster]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_GRNMaster] 
	-- Add the parameters for the stored procedure here
	@inward_no nvarchar(20)=null,
	@grn nvarchar(50)=null,
	@supplier nvarchar(MAX)=null,
	@rmcat nvarchar(50)=null,
	@rmprod_cat nvarchar(50)=null,
	@material nvarchar(50)=null,
	@received_at nvarchar(20)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
Select im.Inward_ID,gm.GRN_ID,cat.name as 'Material Category',us.Name,un.Unit,cat.id,
rm.Name as 'Material',im.GRNQty,sm.SupplierName as Supplier,im.Quantity,im.GRN_QCRemarks,
(Select case when im.GRN_QC ='1' Then 'OK' Else 'Not OK' End) as GRN_QC,inwrd.Gate_entry_No
from PMS_InwardMaterial im 
left outer join PMS_InwardMaster inwrd on inwrd.ID=im.Inward_ID
left join PMS_SupplierMaster sm on sm.SupplierCode = inwrd.Supplier_Id
left outer join PMS_GRNMaster gm on gm.Inward_ID=inwrd.ID
inner join PMS_RawMaterial  rm on rm.ID=im.Material
inner join PMS_Units un on im.Unit=un.ID
left outer join PMS_Category cat  on im.RM_Prod_Cat=cat.id
inner join PMS_Users us on us.ID=gm.Receiver
where
(inwrd.ID like '%'+@inward_no+'%'  or @inward_no  is null)
and
(gm.GRN_ID = @grn or @grn is null)
and
(inwrd.Supplier like '%'+@supplier+'%' or @supplier is null)
and
(im.RM_Cat = @rmcat or @rmcat is null)
and
(im.RM_Prod_Cat = @rmprod_cat or @rmprod_cat is null)
and
(rm.ID = @material or @material is null)
and
(CASE When LEN(gm.Date)=10 then  convert(datetime,gm.Date,105) else null END between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 
and
(gm.Receiver = @received_at or @received_at is null)
 and inwrd.status='1' order by  cast(substring(gm.GRN_ID,9,2) as int)desc,cast(substring(gm.GRN_ID,12,10) as int)desc
END



GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_JobCardMaster]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_JobCardMaster] 
	-- Add the parameters for the stored procedure here
	@jc_no varchar(150)=null,
	@jc_name varchar(255)=null,
	@cust nvarchar(50)=null,
	@prod_cat varchar(255)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@Sort nvarchar(15),
	@Year nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
if(@Sort='Default')	
begin
SELECT  jo.ID,jo.Order_Id ,jo.Order_Name,
'('+jo.jobcart_Width+' X '+jo.jobcart_Height+' X '+jo.jobart_Parts +')' as Order_Size,
pm.prod_cat,pr.Product_Type 
FROM PMS_JobOrder jo
left OUTER JOIN PMS_Product pr ON pr.Auto_Id = jo.jobcart_Prod_Type 
LEFT OUTER JOIN PMS_ProductMaster pm ON jo.jobcart_Prod_Cat = pm.Auto_Id
left outer join PMS_WorkOrder wo on wo.JobOrderID=jo.ID
left outer join PMS_Customer cust on cust.cust_Id=wo.CustomerID
 

where
(jo.Order_Id like '%'+@jc_no+'%' or @jc_no is null) 
 and 
(jo.ID = @jc_name or @jc_name IS NULL)
and
(wo.CustomerID = @cust or @cust IS NULL)
and
(jo.jobcart_Prod_Cat = @prod_cat or @prod_cat IS NULL)
and
(jo.CreatedOn between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)	or (@fromdate is null or @todate is null))
and
(Year(jo.CreatedOn) = @Year or @Year IS NULL)
group by jo.ID,jo.Order_Id ,jo.Order_Name,'('+jo.jobcart_Width+' X '+jo.jobcart_Height+' X '+jo.jobart_Parts +')',pm.prod_cat,pr.Product_Type
--order by jo.CreatedOn desc
order by cast(SubString(jo.ID,9,2)as int) Desc, cast(SubString(jo.ID,12,10)as int) Desc, substring(jo.ID,1,1)desc
--order by cast(SubString(jo.ID,9,2)as int) Desc, cast(SubString(jo.ID,12,10)as int) Desc, substring(jo.ID,1,1)desc
	end
else
	begin
       SELECT  jo.ID,jo.Order_Id ,jo.Order_Name,
'('+jo.jobcart_Width+' X '+jo.jobcart_Height+' X '+jo.jobart_Parts +')' as Order_Size,
pm.prod_cat,pr.Product_Type 
FROM PMS_JobOrder jo
left OUTER JOIN PMS_Product pr ON pr.Auto_Id = jo.jobcart_Prod_Type 
LEFT OUTER JOIN PMS_ProductMaster pm ON jo.jobcart_Prod_Cat = pm.Auto_Id
left outer join PMS_WorkOrder wo on wo.JobOrderID=jo.ID
left outer join PMS_Customer cust on cust.cust_Id=wo.CustomerID
 

where
(jo.Order_Id like '%'+@jc_no+'%' or @jc_no is null) 
 and 
(jo.ID = @jc_name or @jc_name IS NULL)
and
(wo.CustomerID = @cust or @cust IS NULL)
and
(jo.jobcart_Prod_Cat = @prod_cat or @prod_cat IS NULL)
and
(jo.CreatedOn between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)	or (@fromdate is null or @todate is null))
and
(Year(jo.CreatedOn) = @Year or @Year IS NULL)
group by jo.ID,jo.Order_Id ,jo.Order_Name,'('+jo.jobcart_Width+' X '+jo.jobcart_Height+' X '+jo.jobart_Parts +')',pm.prod_cat,pr.Product_Type,jo.CreatedOn
order by jo.CreatedOn desc
--order by cast(SubString(jo.ID,9,2)as int) Desc, cast(SubString(jo.ID,12,10)as int) Desc, substring(jo.ID,1,1)desc
--order by cast(SubString(jo.ID,9,2)as int) Desc, cast(SubString(jo.ID,12,10)as int) Desc, substring(jo.ID,1,1)desc
	end
END


GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_MachineMaintenance]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_MachineMaintenance] 
	-- Add the parameters for the stored procedure here
	@machine nvarchar(255)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@title nvarchar(100)=null,
	@type nvarchar(20)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
select mm.mm_Id as 'Id',mm.mm_MaintTitle as 'Title',m.Name as 'Machine',
mm.mm_WorkType as 'WorkType',
mm.mm_MaintType,
convert(nvarchar,mm.mm_EntryDate,105) as 'EntryDate'
from PMS_MachinenMaintenance mm 
left outer join PMS_Machines m on mm.mm_Machine = m.Id 

where
(mm.mm_Machine = @machine or @machine is null)
and
(CASE When LEN(mm.mm_EntryDate)>=10 then  convert(datetime,mm.mm_EntryDate,105) else null END between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 
and
(mm.mm_MaintTitle like '%'+@title+'%' or '%'+@title+'%' is null)
and
(mm.mm_MaintType = @type or @type is null)

order by cast(substring(mm_Id,9,2) as int) desc, 
cast(substring(mm_Id,12,10) as int) desc, substring(mm_Id,1,1) desc

END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_OrderBoooking]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_OrderBoooking] 
	-- Add the parameters for the stored procedure here
	@id varchar(50)=null,
	@prodcut varchar(255)=null,
	@customer varchar(1000)=null,
	@status int = null,
	@person varchar(255)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
Select ob.booking_id,usr.Name,ob.name,ob.product,ob.size,ob.quantity,ob.delivery_location,
CAST ((select case when ob.Status= 1 then 'New' when ob.Status= 3 then 'Completed' 
when ob.Status= 4 then 'On Hold' else 'In Process' end) as nvarchar) as Status, 
ob.Remark
from order_booking ob 
left outer join PMS_Users usr on usr.ID = ob.UserId


where
(ob.booking_id like '%'+@id+'%' or '%'+@id+'%' is null)
and
(ob.product like '%'+@prodcut+'%' or '%'+@prodcut+'%' is null)
and
(ob.name like '%'+@customer+'%' or '%'+@customer+'%' is null)
and
(ob.Status = @status or @status is null)
and
(ob.UserId = @person or @person is null)
 

END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_PlanWorkOrder]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_PlanWorkOrder] 
	-- Add the parameters for the stored procedure here
@id nvarchar(50)=null,	
@joborder varchar(255)=null,
@workorder_no nvarchar(50)=null,
@workorder_name nvarchar(MAX)=null,
@customer nvarchar(50)=null,
@status int=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT DISTINCT wo.ID, wo.WorkOrderID ,jo.Order_Id , 
jo.Order_Name ,cust.cust_Name , 
 CONVERT(VARCHAR(10),wo.SalesOrderDate,111) as 'SalesOrderDate',
 CONVERT(VARCHAR(10),wo.Date,111) as 'Date', 
 CASE when wo.Status='1' then 'Opened' 
	When wo.Status='0' then 'Closed'  
	ELSE '' END as Status, wo.Plan_Status
FROM PMS_WorkOrder wo
LEFT OUTER JOIN PMS_Customer cust ON wo.CustomerID = cust.cust_Id
LEFT OUTER JOIN PMS_JobOrder jo ON wo.JobOrderID = jo.ID 

where
(jo.Order_Id like '%'+@id+'%'  or @id is null )
and 
(jo.ID= @joborder or @joborder is null) 
and  
(wo.WorkOrderID like '%'+@workorder_no+'%'  or @workorder_no is null )
and 
(wo.ID = @workorder_name or @workorder_name is null) 
and 
(wo.CustomerID = @customer or @customer is null) 
and
(wo.Status = @status or @status is null) 
 order by SalesOrderDate desc
END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_ProformaInvoice]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_ProformaInvoice] 
	-- Add the parameters for the stored procedure here
	@invoice nvarchar(50)=null,
	@consignee nvarchar(600)=null,
	@salesperson nvarchar(50)=null,
	@dispatch nvarchar(100)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

select prf.ID,prf.InvoiceNo,prf.Consignee,usr.Name,prf.DispatchThrough 
from PMS_Proforma prf
left outer join PMS_Users usr on usr.ID = prf.SalesPerson

where
(prf.InvoiceNo = @invoice or @invoice is null)
and
(prf.Consignee like '%'+@consignee+'%' or '%'+@consignee+'%' is null)
and
(prf.SalesPerson = @salesperson or @salesperson is null)
and
(prf.DispatchThrough like '%'+@dispatch+'%' or '%'+@dispatch+'%' is null)
END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_ProjectDocument]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_ProjectDocument] 
	-- Add the parameters for the stored procedure here
	@Project_Name nvarchar(50)=null,
	@custname nvarchar(50)=null,
	@Uploaded_By nvarchar(40)=null,
	@Type nvarchar(50)=null,
	@Amount nvarchar(50)=null,
	@DateOf_Upload nvarchar(50)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
Select a.Id,a.Project_Name,a.Customer_Name,(case when b.cust_Name!='' then b.cust_Name else a.Customer_Name end) as cust_Name,
a.DateOf_Upload,a.Remark,a.Amount,a.Uploaded_By,a.Type as ab,(CASE when a.type= 0 then 'Tender' when a.type=1 then 'Proposed' else '' end) 'Type',
d.File_Name,d.File_Path,d.FileTitle,a.Tender_fee, b.cust_Name as cName,c.Name,a.Project_Closure from PMS_ProjectDocument a  
left join PMS_Customer b on a.Customer_Name=b.cust_Id left join PMS_Users c on a.Uploaded_By = c.ID
left join PMS_ProjectDocDetails d on d.File_Name=a.Id and d.File_Path=a.Id 

where 
(a.Project_Name like '%'+ @Project_Name+ '%' or @Project_Name  is null )
and
(a.Customer_Name = @custname or @custname is null)
and
(a.DateOf_Upload = @DateOf_Upload or @DateOf_Upload is null  )
and
(a.Type = @Type or @Type is null)
and
(a.Uploaded_By = @Uploaded_By or @Uploaded_By is null)
and
(CASE When LEN(a.DateOf_Upload)>=10 then convert(datetime,a.DateOf_Upload,105) else null END between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 
order by cast(substring(a.Id,6,10) as int)desc, substring(a.Id,1,1) desc
END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_PurchaseOrder]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_PurchaseOrder]
	-- Add the parameters for the stored procedure here
	@po nvarchar(50)=null,
	@party nvarchar(255)=null,
	@order nvarchar(255)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

select pm.Order_Number,pm.PO_Number,
pm.PO_Date as Date,cust.cust_Name,pd.Item_Desc,pm.TotalAmt
from PMS_PO_Master pm
left outer join PMS_PO_Details pd on pd.PO_ID=pm.PO_ID
left outer join PMS_Customer cust on cust.cust_No=pm.Party_ID

where
(pm.PO_ID = @po or @po is null)
and
(pm.Party_ID =@party or @party is null)
and
(pm.PO_ID = @order or @order is null)
and
 (CASE When LEN(pm.PO_Date)>10 
then  
convert(datetime,pm.PO_Date,105) 
else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)
) 



END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_PurchaseRequest]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_PurchaseRequest] 
	-- Add the parameters for the stored procedure here
	@req nvarchar(100)=null,
	@dept nvarchar(50)=null,
	@brand varchar(100)=null,
	@desc nvarchar(255)=null,
	@client nvarchar(255)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@status int =null,
	@approvalstatus int = null
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

Select prf.RequestNumber as RequestNumber,rm.Name as ProductDescription,prf.RequesterSignature,prf.EntryDate,
prf.BrandName,cust.cust_Name as cust_Name,prf.RequesterName,
convert(nvarchar,prf.RequestDate,105) as RequestDate,
case when prf.Status='0' then 'Pending'
when prf.Status='1' then 'Purchased'
when prf.Status='2' then 'Rejected'
else ' ' end as 'Status',
case when prf.ApprovalStatus = '0' then 'Pending'
when prf.ApprovalStatus = '1' then 'Approved'
when prf.ApprovalStatus = '2' then 'Rejected'
else ' ' end as 'ApprovalStatus'
from Pms_PurchaseRequestForm prf
left outer join PMS_RawMaterial rm on prf.RMProductSubCategory=rm.ID
left outer join PMS_Customer cust on cust.cust_Id=prf.ClientId

where

(prf.RequestNumber like '%'+@req+'%' or @req is null) 
and
(prf.RequestDepartment = @dept or @dept is null)
and
(prf.BrandName = @brand or @brand is null)
and
(prf.RMProductSubCategory = @desc or @desc is null)
and
(prf.ClientId like '%'+@client+'%' or @client is null)
and
convert(datetime,prf.RequestDate,105) 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)
and
(prf.Status = @status or @status is null)
and
(prf.ApprovalStatus = @approvalstatus or @approvalstatus is null)
 order by CAST(substring(RequestNumber,9,2)as int) Desc, CAST(substring(RequestNumber,12,10)as int) Desc, SUBSTRING(RequestNumber,1,1)desc

END


GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_Recruitment]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_Recruitment] 
	-- Add the parameters for the stored procedure here
	@candidate nvarchar(50)=null,
	@dept nvarchar(50)=null,
	@ref nvarchar(40)=null,
	@date nvarchar(50)=null,
	@status int =null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
select rd.ID,convert(VARCHAR(10),Rec_InterviewDate,105) as Rec_InterviewDate,rd.Rec_Name,rd.Rec_Contact,rd.Rec_Refrence,
dept.Dept_Name as Rec_Department,rd.Rec_Position,
case Rec_Status when '1' then 'Pending' when '2' then 'Selected' when '3' then 'Rejected' end as Rec_Status,Download
from PMS_RecruitmentDetails rd
left outer join PMS_Department dept on rd.Rec_Department=dept.Auto_Id

where
(rd.Rec_Name like '%'+@candidate+'%' or '%'+@candidate+'%' is null)
and
(rd.Rec_Department = @dept or @dept is null)
and
(rd.ID= @ref or @ref is null)
and
(convert(nvarchar,rd.Rec_InterviewDate,105) like '%'+@date+'%' or '%'+@date+'%' is null)
and 
(rd.Rec_Status = @status or @status is null)
order by Cast(SUBSTRING(ID,6,10) as int) desc
END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_SalesWorkOrder]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_SalesWorkOrder] 
	-- Add the parameters for the stored procedure here
	@id nvarchar(50)=null,
	@joborder varchar(255)=null,
	@workorder_no nvarchar(50)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@workorder_name nvarchar(MAX)=null,
	@customer nvarchar(550)=null,
	@status int=null,
	@salesperson nvarchar(255)=null,
	@postatus int=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
select wo.ID,jo.Order_Id +'('+ jo.Order_Name + ')'
as 'joborder ID',wo.WorkOrderID as 'WorkOrderID',
wo.WorkOrderName,cust.cust_Name, 
(case when wo.Status ='0' then 'Closed' when wo.Status='1' then 'Open'end)as 'Status1',wo.Status,
Convert(varchar(10),wo.SalesOrderDate,105)as Date,wo.Quantity,
fg.cc_QtyProd ,cc_QtyDispatch ,wo.POUpload,jo.jobcart_Prod_Cat
--(select sum(a.chalDet_QtyTaken)
 --from PMS_GenerateChallanDetails a 
 --inner join PMS_GenerateChallan b on a.chal_ID=b.chal_ID 
 --where chalDet_WorkOrderId=w.ID and b.flag='1') as cc_QtyDispatch 
from PMS_WorkOrder wo 
left outer join PMS_JobOrder jo on wo.JobOrderID = jo.ID 
left outer join PMS_Customer cust on wo.CustomerID = cust.cust_Id 
left outer join PMS_FGEntry fg on wo.ID=fg.cc_WorkOrderId
left outer join PMS_Users usr on cust.cust_SalesPerson=usr.ID
left outer join PMS_Units un on jo.jobcart_Width_Unit=un.ID

where 
(jo.Order_Id like '%'+@id+'%'  or @id is null)
and
(jo.ID = @joborder or @joborder is null)
and
(wo.WorkOrderID like '%'+@workorder_no+'%' or @workorder_no is null)
and
((CASE When LEN(WO.SalesOrderDate) >=10 then  convert(date,WO.SalesOrderDate,105) else null END between convert(date,''+@fromdate+'',105) and convert(date,''+@todate+'',105))or (@fromdate is null or @todate is null)) 
and
(wo.ID = @workorder_name or @workorder_name is null)
and
(wo.CustomerID = @customer or @customer is null)
and
(wo.Status = @status or @status is null)
and
(cust.cust_SalesPerson = @salesperson or @salesperson is null)
and
(wo.POChk = @postatus or @postatus is null)
order by cast(substring(wo.ID,9,2) as int)desc, cast(substring(wo.ID,12,10) as int)desc ,substring(wo.ID,1,1)desc
END
GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_StockInventory]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_StockInventory]
	-- Add the parameters for the stored procedure here
	@rm_cat varchar(50)=null,
	@prod_cat varchar(50)=null,
	@resources nvarchar(255)=null,
	@qty nvarchar(15)=null
	
	AS
BEGIN
    DECLARE
        @Query varchar(MAX)
        
set @Query='select distinct rm.ID,c.name as RM,b.name as Product,rm.Name as Resources,
	Sum(CAST(d.CurrentQty as float)) as InStock
	,rm.Unit as Unit from PMS_RawMaterial rm
	inner join RMCombined RMC on rm.ID=RMC.ID
	left outer join PMS_Category b on rm.Product_Cat=b.id
	left outer join PMS_Category c on rm.RM_Cat=c.id
	left outer join PMS_InwardMaterial d on rm.ID=d.Material 
	where
	(rm.RM_Cat = '''+@rm_cat+''' or '''+@rm_cat+''' is null) and
	(rm.Product_Cat = '''+@prod_cat+''' or '''+@prod_cat+''' is null) and
	(rm.ID = '''+@resources+''' or '''+@resources+''' is null) and '

	if(@qty is not null)
		if(@qty='1')
				set @Query+='  CAST(d.CurrentQty as float)>0 '
		ELSE IF (@qty='2')
				set @Query+='  CAST(d.CurrentQty as float)>500 '
		ELSE IF (@qty='3')
				set @Query+='  CAST(d.CurrentQty as float)>1000  '
		ELSE
				set @Query+=' d.CurrentQty is not null '
	ELSE
		Set @Query+=' d.CurrentQty is not null '
	
	set @Query+=' group by rm.ID,rm.Name,b.name,c.name,rm.Unit order by InStock  asc '

	exec (@Query)

END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_StoreManager]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_StoreManager]
	-- Add the parameters for the stored procedure here
	@wo nvarchar(50)=null,
	@cust nvarchar(550)=null,
	@rm nvarchar(255)=null,
	@status varchar(50)=null,
	@jc_no varchar(150)=null,
	@fromdate1 nvarchar(50)=null,
	@todate1 nvarchar(50)=null,
	@fromdate2 nvarchar(50)=null,
	@todate2 nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
SELECT  sm.Auto_Id,jo.Order_Name + ' ' + '(' + jo.Order_Id + ')' as 'Order_Id', 
wo.SalesOrderDate as 'Date',
wo.WorkOrderID ,
cust.cust_Name, rm.Name,
(Cast(sm.Quantity_Req as varchar(20)) +' ' +un.Unit) as 'Quantity_Req',  
sm.Qty_Alloted as 'Qty_Alloted',sm.Status,
--CASE when sm.Status='1' then 'Pending' 
--	When sm.Status='0' then 'Alloted' 
--	ELSE '' END as Status,
 sm.Qty_available,sm.IssueDate 
FROM PMS_Store_Master sm
Left outer JOIN PMS_WorkOrder wo ON sm.WorkOrder_Id = wo.ID 
Left outer JOIN PMS_Customer cust ON sm.Customer_id = cust.cust_Id 
Left outer JOIN PMS_RawMaterial rm ON sm.RM_Id = rm.ID 
Left outer JOIN RMCombined rc on rc.ID=sm.RM_Id
Left outer JOIN PMS_JobOrder jo ON sm.jobCard_Id=jo.Id 
Left outer JOIN  PMS_Units un ON sm.Units=un.ID 


where

(wo.WorkOrderID like '%'+@wo+'%'  or @wo is null)
and
(sm.Customer_id = @cust  or @cust  is null)
and
(sm.RM_Id = @rm or @rm is null)
and
(sm.Status = @status or @status is null)
and
(sm.jobCard_Id = @jc_no or @jc_no is null)
and
(CASE When LEN(sm.IssueDate)=10 
then 
convert(datetime,sm.IssueDate,105) 
else null END 
between convert(datetime,''+@fromdate1+'',105) and convert(datetime,''+@todate1+'',105)or (@fromdate1 is null or @todate1 is null)
) 

and
(CASE When LEN(wo.SalesOrderDate)>10 
then  
convert(datetime,wo.SalesOrderDate,105) 
else null END 
between convert(datetime,''+@fromdate2+'',105) and convert(datetime,''+@todate2+'',105)or (@fromdate2 is null or @todate2 is null)
) 
order by Cast(Substring(sm.Auto_Id,3,10) as int) Desc , substring(sm.Auto_Id,1,1) desc
END


GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_SupervisorQcEntry]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_SupervisorQcEntry]
	-- Add the parameters for the stored procedure here
	@operator varchar(150)=null,
	@process nvarchar(50)=null,
	@jo nvarchar(50)=null,
	@wo nvarchar(50)=null,
	@supervisor varchar(255)=null,
	@location varchar(255)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@qc varchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

Select sq.sq_Id as 'ID',sq.Supervisor_Name as 'Supervisor_Name',sq.Operator,
usr.Name as 'Operator1',sq.Entry_Date as 'Entry_Date',jo.Order_Name +' (' + jo.Order_Id + ') ' as 'JobOrder',
wo.WorkOrderName +' (' + wo.WorkOrderID + ')' as 'WorkOrder' ,
pr.Name as 'Process',st.Site,sq.QC_Result
from PMS_SupervisorQcEntry sq
left outer join PMS_Users usr on sq.Operator=usr.ID
left outer join PMS_JobOrder jo on sq.sq_JobOrder=jo.ID
left outer join PMS_WorkOrder wo on sq.sq_WorkOrder=wo.ID
left outer join PMS_Processes pr on sq.sq_Process=pr.ID
left outer join PMS_Sites st on sq.Location=st.ID

where
(sq.Operator = @operator or @operator is null)
and
(sq.sq_Process = @process or @process is null)
and
(sq.sq_JobOrder= @jo or @jo is null)
and
(sq.sq_WorkOrder= @wo or @wo is null)
and
(sq.Supervisor_Name = @supervisor or @supervisor is null)
and
(sq.Location = @location or @location is null)
and
(sq.QC_Result= @qc or @qc is null)
and
(CASE When LEN(sq.Entry_Date)>10
 then  
convert(datetime,sq.Entry_Date,105) else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 
 --sq.Entry_Date  between
--convert(datetime,''+COALESCE(@fromdate,convert(varchar(10),sq.Entry_Date,25))+'',105) 
--and 
--convert(datetime,''+coalesce(@todate,convert(varchar(10),sq.Entry_date,25))+'',105)
--or
--@fromdate is null or @todate is null
--sq.Entry_Date  
--between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null) 
 order by cast(substring(sq.sq_Id,9,2) as int)desc, cast(substring(sq.sq_Id,12,10) as int)desc ,substring(sq.sq_Id,1,1)desc
END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_TrainingEntry]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_TrainingEntry] 
	-- Add the parameters for the stored procedure here
	@process nvarchar(255)=null,
	@machine nvarchar(255)=null,
	@title nvarchar(50)=null,
	@jo varchar(150)=null,
	@wo nvarchar(MAX)=null,
	@receiver nvarchar(255)=null,
	@tutor nvarchar(255)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

Select te.tr_Id as 'Id', jo.order_Id as 'JobOrder',wo.WorkOrderName as 'WorkOrder',pr.Name as 'Process',mchn.name as 'Machine',
te.tr_Title AS 'TraningTitle',te.tr_TrainingDate as 'Training_Date',
convert(nvarchar,te.tr_TrainingDate,105) as 'Date',te.TrUpload 
from PMS_TraningEntry te
left outer join PMS_JobOrder jo on te.tr_JobOrder=jo.ID
left outer join PMS_WorkOrder wo on te.tr_WorkOrder=wo.ID
left outer join PMS_Processes pr on te.tr_Process=pr.ID
left outer join PMS_Machines mchn on te.tr_Machine=mchn.ID
left outer join PMS_Users usr1 on te.tr_Reciever=usr1.ID
left outer join PMS_Users usr2 on te.tr_Tutor=usr2.ID

where
(te.tr_Process = @process or @process is null)
and
(te.tr_Machine = @machine or @machine is null)
and
(te.tr_Title like '%'+@title+'%' or @title is null)
and
(te.tr_JobOrder = @jo or @jo is null)
and
(te.tr_WorkOrder = @wo or @wo is null)
and
(te.tr_Id = @receiver or @receiver is null)
and
(te.tr_Id = @tutor or @tutor is null)
and
(CASE When LEN(te.tr_TrainingDate) >=10 then  convert(datetime,te.tr_TrainingDate,105) else null END between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 

order by Cast(Substring(te.tr_Id,9,2) as int)desc , Cast(Substring(te.tr_Id,12,10) as int)desc , substring(te.tr_Id,1,1) desc

END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_UploadFile]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_UploadFile] 
	-- Add the parameters for the stored procedure here
	@jc_name varchar(255)=null,
	@dsg_name nvarchar(250)=null,
	@file_name nvarchar(100)=null,
	@user nvarchar(255)=null,
	@jc_no nvarchar(50)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

SELECT   ud.up_ID ,jo.Order_Name ,ud.up_JCNo,ud.up_DesgName ,UDD.File_Name,UDD.File_title,UDD.File_Path ,
ud.up_DesgFileName ,us.Username as up_UserName,
 ud.up_TimeStmp,UD.up_JCNo
 FROM PMS_UploadDesign ud 
 left outer join PMS_JobOrder jo on ud.up_JCNo=jo.ID
 left outer join PMS_UploadDesign_Details UDD on ud.up_ID=UDD.Design_Upload_Id
INNER JOIN PMS_Users us ON ud.up_UserName = us.ID
  --order by cast(SubString(ud.up_ID,6,10)as int) Desc
where

(jo.ID =@jc_name or @jc_name is null ) 
and
(UDD.File_title like '%'+@dsg_name+'%' or @dsg_name is null) 
and 
(UDD.File_Name like '%'+@file_name+'%' or @file_name is null) 
and 
(ud.up_UserName =@user or @user is null ) 
and
(jo.Order_Id like '%'+@jc_no+'%' or @jc_no is null)
and
(CASE When LEN(ud.up_TimeStmp)>10
 then  
convert(date,ud.up_TimeStmp,105) else null END 
between convert(date,''+@fromdate+'',105) and convert(date,''+@todate+'',105)or (@fromdate is null or @todate is null)) 


 ORDER BY CAST(SUBSTRING(UD.up_ID, 6, 10) AS int) DESC

END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_Visitor]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_Visitor] 
	-- Add the parameters for the stored procedure here
	@id varchar(50)=null,
	@visitor_type nvarchar(50)=null,
	@organisation nvarchar(150)=null,
	@person_to_meet nvarchar(50)=null,
	@name nvarchar(200)=null,
	@sign varchar(50)=null,
	@location nvarchar(100)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
Select vstr.Id,vstr.Name,convert(nvarchar,vstr.Date,105)as 'Date',
vstr.Organisation,vstr.TimeIn,vstr.OutTime,
Case when vstr.Signature='1' then 'Yes'
when vstr.Signature='0' then 'No'
else '' end as 'Signature'
from PMS_Visitor vstr 
left outer join PMS_Users usr on vstr.PersonToMeet=usr.ID
left outer join PMS_Sites st on usr.Site=st.ID
where

(vstr.Id like '%'+@id+ '%' or @id  is null)
and
(vstr.Id = @visitor_type or @visitor_type is null)
and
(vstr.Organisation like '%'+@organisation+ '%' or @organisation is null)
and
(vstr.PersonToMeet = @person_to_meet or @person_to_meet is null)
and
(vstr.Name like '%'+@name+ '%' or @name  is null)
and
(vstr.Signature = @sign or @sign is null)
and
(st.ID = @location or @location is null)
and
--(CASE When LEN(cmpln.Entry_Date)=10 then  
(CASE When LEN(vstr.Date)=10 then  convert(datetime,vstr.Date,105) else null END between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 


END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_WastageOutward]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_WastageOutward]
	-- Add the parameters for the stored procedure here
	@Buyer nvarchar(50)=null,
	@item nvarchar(50)=null,
	@measure_by nvarchar(50)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

select distinct ot.Outward_Id as 'ID',byr.Buyer_Name as 'Buyer Name', wst.Item ,ot.Quantity,
ot.Rate,ot.Total,
outwrd.Date as 'Date',usr.Name as 'Measured By'
from PMS_Outward outwrd  
left outer join PMS_OutwardDetails ot  on outwrd.Id=ot.Outward_Id
left outer join PMS_Buyer byr on outwrd.Buyer_Name=byr.Buyer_Id
left outer join PMS_Wastage wst on wst.Wastage_Id=ot.Item
left outer join PMS_Units un on un.ID=wst.Unit
left outer join PMS_Users usr on outwrd.Sold_By=usr.ID

where
(outwrd.Buyer_Name = @Buyer or @Buyer is null)
and
(ot.Item = @item or @item is null)
and
(outwrd.Sold_By = @measure_by or @measure_by is null)
and
(CASE When LEN(outwrd.Date)=10 then  convert(datetime,outwrd.Date,105) else null END between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 



END

GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_WorkOrderDesign]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Search_Manage_WorkOrderDesign] 
	-- Add the parameters for the stored procedure here
	@jc varchar(255)=null,
	@dsgn nvarchar(250)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
select jd.jd_Id as id,j.Order_Name + ' ' +'(' + j.Order_Id + ')' as joborder,d.up_DesgName as designname 
from PMS_JobOrderDesign jd 
inner join PMS_JobOrder j on jd.jd_JobOrderId = j.ID 
inner join PMS_UploadDesign d on jd.jd_DesignId = d.up_ID
where
(j.Order_Name + ' ' +'(' + j.Order_Id + ')' like '%'+@jc+'%' or @jc is null ) 
and
(d.up_DesgName like '%'+@dsgn+'%' or @dsgn is null)
 
END
GO
/****** Object:  StoredProcedure [dbo].[Search_Manage_WorkOrderProgress_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Manage_WorkOrderProgress_Report] 
	-- Add the parameters for the stored procedure here
	@wo nvarchar(50)=null,
	@jo nvarchar(50)=null,
	@jc varchar(255)=null,
	@cust nvarchar(255)=null,
	@po nvarchar(50)=null,
	@trans nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

select w.ID,w.WorkOrderID,j.Order_Id +'('+ j.Order_Name + ')' as 'joborder ID',c.cust_Name,
Convert(varchar(10),
w.Date,105) as Date,CAST(w.Quantity as nvarchar(20)) + space(1) + d.unit as Quantity,
 work_po_date,
 case when w.Status='0' then 'Closed'
 when w.Status='1' then 'Opened'
 else ' ' end as Status
 
 from PMS_WorkOrder w Left join PMS_JobOrder j on w.JobOrderID = j.ID  
 Left join PMS_Customer c on w.CustomerID = c.cust_Id 
 Left join PMS_Units d on w.Unit = d.ID 
 
 where
 (w.ID = @wo or @wo is null) 
 and
 (w.JobOrderID= @jo or @jo is null) 
 and
 (w.JobOrderID= @jc or @jc is null) 
 and
 (w.CustomerID= @cust or @cust is null) 
 and
 (w.ID= @po or @po is null) 
 and
 (w.ID = @trans or @trans is null) 
 
 
 order by cast(substring (w.ID,9,2)as int ) desc , cast(substring(w.ID,12,10) as int)desc
END

GO
/****** Object:  StoredProcedure [dbo].[Search_ManageInoice_Master]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_ManageInoice_Master] 
	-- Add the parameters for the stored procedure here
	@challan_no nvarchar(25)=null,
	@invoice_no nvarchar(500)=null,
	@customer nvarchar(500)=null,
	@flag varchar(50)=null,
	@wo_no nvarchar(50)=null,
	@fromdate nvarchar(500)=null,
	@todate nvarchar(500)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

Select distinct im.Invoice_ID,im.Invoice_No as 'Invoice_No',
im.Invoice_Date 'Invoice_Date',
im.Customer as 'Customer',STUFF((SELECT ', ' + A.Item_Desc FROM PMS_invoice_details A Where A.Invoice_ID=id.Invoice_ID 
and Deleted_Detail='N' FOR XML PATH('')),1,1,'') as 'Item_Desc',
(CASE WHEN im.flag='D' then ROUND(TotalAmount,0)  else GrandTotal END) as 'TotalAmount',
(CASE WHEN im.flag='I' then 'Normal'  else 'Direct' END) as Flag, im.CreatedOn
from  PMS_Invoice_Master im 
left outer join PMS_Invoice_Details id on im.Invoice_No=id.Invoice_ID
left outer join PMS_GenerateChallan CHL on im.Challan_ID=CHL.chal_ID
left outer join PMS_WorkOrder WO on CHL.chal_SO_No=wo.ID where deleted='N' and Deleted_Detail='N'
--left outer join PMS_GenerateChallan gc on gc.chal_ID=im.Challan_ID

                            


AND im.Challan_ID =CASE WHEN @challan_no > '' THEN @challan_no
                                 ELSE im.Challan_ID END
  AND im.Invoice_ID =CASE WHEN @invoice_no > '' THEN @invoice_no
                                 ELSE im.Invoice_ID END
 AND CustomerID =CASE WHEN @customer > '' THEN @customer
                                 ELSE CustomerID   END 
AND im.flag =@flag                              
                                                             

                              
      AND wo.ID =CASE WHEN @wo_no > '' THEN @wo_no
                                 ELSE wo.ID   END 






--and
--(im.Challan_ID = @challan_no or @challan_no is null)
--and
--(im.Invoice_ID = @invoice_no or @invoice_no is null)
--and
--(im.Customer like '%'+@customer+'%' or @customer is null)
--and
--(im.flag = @flag or @flag is null)
--and
--(wo.ID = @wo_no or @wo_no is null)
--and
--(td.InvoiceNo = @wo_no or @wo_no is null)
and

((CASE When LEN(im.Invoice_Date) >=10 
then   
convert(datetime,im.Invoice_Date,105)
else null END) 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)	or (@fromdate is null or @todate is null))

order by im.CreatedOn desc
END

GO
/****** Object:  StoredProcedure [dbo].[Search_ManageInward]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Search_ManageInward]
	-- Add the parameters for the stored procedure here
	@po_no nvarchar(25)=null,
	@received_by nvarchar(50)=null,
	@supplier nvarchar(MAX)=null,
	@rmcat nvarchar(50)=null,
	@rmprod_cat nvarchar(50)=null,
	@material nvarchar(50)=null,
	@uid nvarchar(20)=null,
	@inward_no nvarchar(20)=null,
	@invoice_no nvarchar(50)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@costcenter int=null,
	@received_at nvarchar(20)=null,
	@gate_entry nvarchar(50)=null,
	@stockType nvarchar(50)=null,
	@barcode nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
select inwrd_mat.ID as 'UID',inwrd_mat.Inward_ID as 'Inward No.',inwrd.ID,
cat.name as 'RM Prod. Cat',rm.Name as 'Material',inwrd_mat.Quantity,inwrd_mat.Total,sm.SupplierName,
CASE when cast(inwrd_mat.GRNQty as varchar) is null then '' else cast(inwrd_mat.GRNQty as varchar) END as GRNQty,
inwrd.PO_No,inwrd.Inward_Date,inwrd.Gate_entry_No,inwrd.Cost_Center,inwrd.Invoice_No,inwrd_mat.Barcode_ID,inwrd.StockType
from PMS_InwardMaterial inwrd_mat 
left outer join PMS_InwardMaster inwrd on inwrd.ID=inwrd_mat.Inward_ID
left outer join PMS_SupplierMaster sm on sm.SupplierCode = inwrd.Supplier_Id
left outer join PMS_RawMaterial rm on inwrd_mat.Material=rm.ID
left outer join PMS_Category cat  on inwrd_mat.RM_Prod_Cat=cat.id
left outer join PMS_Users usr on inwrd.Receiver_Name=usr.ID
left outer join PMS_Sites st on usr.Site=st.ID
left outer join RMCombined  rmc on rmc.ID=rm.ID

where
(inwrd.PO_No like '%'+@po_no+'%'  or @po_no  is null)
and
(inwrd.Receiver_Name = @received_by or @received_by is null)
and
(inwrd.Supplier_Id = @supplier or @supplier  is null)
and
(rm.RM_Cat = @rmcat or @rmcat is null)
and
(inwrd_mat.RM_Prod_Cat = @rmprod_cat or @rmprod_cat is null)
and
(inwrd_mat.Material = @material or @material is null)
and
(inwrd_mat.ID like '%'+@uid+'%'  or @uid  is null)
and
(inwrd.ID like '%'+@inward_no+'%'  or @inward_no  is null)
and
(inwrd.Invoice_No like '%'+@invoice_no+'%'  or @invoice_no  is null)
and
(CASE When LEN(inwrd.Inward_Date)=10 then  convert(datetime,inwrd.Inward_Date,105) else null END between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 
and
(inwrd.Cost_Center = @costcenter or @costcenter is null)
and
(inwrd.ID like '%'+@received_at+'%' or @received_at is null)
and
(inwrd.Gate_entry_No like '%'+@gate_entry+'%'  or @gate_entry  is null)
and
(inwrd_mat.Barcode_ID like '%'+@barcode+'%'  or @barcode  is null)
and
(inwrd.StockType like '%'+@stockType+'%' or @stockType is null)
 and inwrd.status='1' order by cast(substring(inwrd.ID,9,2) as int) desc,cast(substring(inwrd.ID,12,10) as int) desc
END



GO
/****** Object:  StoredProcedure [dbo].[Search_ManageOfficeTaskAssignment]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_ManageOfficeTaskAssignment]
	-- Add the parameters for the stored procedure here
	
	@cust nvarchar(255)=null,
	@activity nvarchar(255)=null,
	@jc nvarchar(255)=null,
	@wo nvarchar(255)=null,
	@status varchar(10)=null,
	@desc varchar(max)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

select owt.Auto_Id,cust.cust_Name,act.Activity_Name,jo.Order_Name,
wo.WorkOrderName,owt.Description,
convert(nvarchar,owt.Date,105)as 'DOA',
convert(nvarchar,owt.ExpectedEndDate,105) as 'EDOC',
convert(nvarchar,owt.ActualDateOfCompletion,105) as 'ADOC',
convert(varchar(5),DateDiff(s,owe.From_Time, owe.To_Time)/3600)+'Hrs '
+convert(varchar(5),DateDiff(s,owe.From_Time, owe.To_Time)%3600/60)+'Mins' as 'Total Time',


case when owt.status='9' then 'New'
when owt.status='10' then 'In Progress'
when owt.status='11' then 'Completed'
else '' end as 'Status'

from
PMS_OfficeWorkTask owt
left outer join PMS_Activity act on  act.Auto_Id=owt.Activity
left outer join PMS_Customer cust on cust.cust_Id=owt.Customer
left outer join PMS_JobOrder jo on jo.ID=owt.Job_Card
left outer join PMS_WorkOrder wo on wo.ID=owt.Work_Order
left outer join PMS_Users usr on usr.ID=owt.UserID
left outer join PMS_OfficeWorkEntry owe on owe.Task_Id=owt.Auto_Id

where
(cust.cust_Name = @cust or @cust is null)
and
(act.Activity_Name = @activity or @activity is null)
and
(owt.Job_Card = @jc or @jc is null)
and
(owt.Work_Order = @wo or @wo is null)
and
(CASE When LEN(owt.Date)>10 
then   
convert(datetime,owt.Date,105)
else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)	or (@fromdate is null or @todate is null)
)						
and
(owt.status =@status or @status is null)
and
(owt.Description like '%'+@desc+'%' or @desc is null)

END

GO
/****** Object:  StoredProcedure [dbo].[Search_ManageOfficeTasks]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_ManageOfficeTasks]
	-- Add the parameters for the stored procedure here
	@assignedby nvarchar(255)=null,
	@activity nvarchar(255)=null,
	@cust nvarchar(255)=null,
	@jc nvarchar(255)=null,
	@wo nvarchar(255)=null,
	@priority varchar(10)=null,
	@status varchar(10)=null,
	@type varchar(10)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

select owt.Auto_Id,usr.Name,act.Activity_Name,cust.cust_Name,jo.Order_Name,
wo.WorkOrderName,
case when owt.Priority='4' then 'Normal'
when owt.Priority='5' then 'Medium'
when owt.Priority='6' then 'High'
else '' end as 'Priority',
convert(nvarchar,owt.Date,105)as 'Date',convert(nvarchar,owt.ActualDateOfCompletion,105) as 'EDOC',
owt.Description,

case when owt.status='9' then 'New'
when owt.status='10' then 'In Progress'
when owt.status='11' then 'Completed'
else '' end as 'Status',

case when owt.type='7' then 'Assigned'
when owt.type='8' then 'Self Assigned'
else '' end as 'Type'

from
PMS_OfficeWorkTask owt
left outer join PMS_Activity act on  act.Auto_Id=owt.Activity
left outer join PMS_Customer cust on cust.cust_Id=owt.Customer
left outer join PMS_JobOrder jo on jo.ID=owt.Job_Card
left outer join PMS_WorkOrder wo on wo.ID=owt.Work_Order
left outer join PMS_Users usr on usr.ID=owt.UserID


where
(usr.Name = @assignedby or @assignedby is null)
and
(act.Activity_Name = @activity or @activity is null)
and
(cust.cust_Name = @cust or @cust is null)
and
(owt.Job_Card = @jc or @jc is null)
and
(owt.Work_Order = @wo or @wo is null)
and
(owt.Priority = @priority or @priority is null)
and
(owt.status =@status or @status is null)
and
(owt.type = @type or @type is null)
and
(CASE When LEN(owt.Date)>10 
then   
convert(datetime,owt.Date,105)
else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)	or (@fromdate is null or @todate is null)
)						

END

GO
/****** Object:  StoredProcedure [dbo].[Search_ManageQuotation]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_ManageQuotation]
	-- Add the parameters for the stored procedure here
	@company nvarchar(200)=null,
	@subject nvarchar(200)=null,
	@salesperson nvarchar(200)=null,
	@created_by varchar(200)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
select qm.ID,qm.CreatedOn,qm.Address,qm.Subject,qm.AttentionOf,usr.Name
from PMS_Quotation_Master qm 
left outer join PMS_Users usr on usr.ID=qm.CreatedBy

where
(qm.Address like '%'+@company+'%' or '%'+@company+'%' is null)
and
(qm.Subject like '%'+@subject+'%' or '%'+@subject+'%' is null)
and
(qm.SalesPerson like '%'+@salesperson+'%' or '%'+@salesperson+'%' is null)
and
(qm.CreatedBy = @created_by or @created_by is null)


END

GO
/****** Object:  StoredProcedure [dbo].[Search_MISReport]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
CREATE PROCEDURE [dbo].[Search_MISReport]
	-- Add the parameters for the stored procedure here
	@DsiplayLength int=null,
	@DisplayStart int=null,	
	@customer nvarchar(50)=null,
	@workorder nvarchar(50)=null,
	@joborder varchar(150)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@process nvarchar(25)=null,	
	@username nvarchar(50)=null,
	@machine nvarchar(50)=null,
	@location nvarchar(50)=null,
	@entryno nvarchar(50)=null
	
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @FirstRec int, @LastRec int
	Set @FirstRec = @DisplayStart;
	Set @LastRec = @DisplayStart + @DsiplayLength;
	
    -- Insert statements for procedure here
    
	SELECT ROW_NUMBER() over (Order by pwe.ID desc) as RowNo, COUNT(*) over()
	as totalcount, pjo.Order_Name +'('+ pjo.Order_Id + ')' as Job_Card,c.cust_Id,w.id as workID, w.workOrderId,
pwe.Unit as outunit,pwe.id, pjo.order_name,pm.name 'machine',pst.site, ps.name , work_datefrom, 
work_dateto, pjo.order_Id,pwe.userid, pwe.helper, us.Name as 'Operator',pwe.assistant,
CONVERT(Date, pwe.entrydate, 103) as entrydate, dd.dpd_FGQty, u.Unit, dd.dpd_Boxes,
(select sum(Resources_Output) from pms_workentryresources pwer 
where pwer.workentry_id = pwe.id) 'Total Output' from pms_workentry pwe Left join 
PMS_sites pst on pst.id = pwe.Work_Godown Left join PMS_Machines pm on pm.id = pwe.Work_Machinary 
Left join PMS_Processes ps on ps.id = pwe.Work_Process Left join pms_joborder pjo on pjo.id = pwe.work_joborder 
Left join PMS_WorkOrder w on pwe.Work_WorkOrder = w.ID Left join PMS_Customer c on w.CustomerID = c.cust_id 
LEFT JOIN PMS_DispatchProDetails dd ON pwe.id = dd.dpd_WEId 
Left join PMS_Units u on dd.dpd_Unit = u.ID left join PMS_Users us on pwe.Operator = us.ID

where 

(w.CustomerID = @customer  or @customer  is null)
and
(pwe.Work_WorkOrder = @workorder or @workorder is null)
and
(pwe.Work_JobOrder = @joborder or @joborder is null)
and
(CASE When LEN(pwe.EntryDate) >=10 then  convert(datetime,pwe.EntryDate,105) else null END between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 
and
(pwe.Work_Machinary = @machine or @machine is null)
and
(pwe.ID = @entryno or @entryno is null)
and
(pwe.Work_Godown = @location or @location is null)
and
(pwe.Operator =@username or @username is null)
and
(pwe.Work_Process =@process or @process is null)
order by entrydate desc

END

GO
/****** Object:  StoredProcedure [dbo].[Search_MyOfficeWorkEntry]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_MyOfficeWorkEntry]
	-- Add the parameters for the stored procedure here
	@task nvarchar(50)=null,
	@activity nvarchar(255)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

select owe.Auto_Id,owt.Auto_Id as 'Task No.',act.Activity_Name,usr.Name,cust.cust_Name,owt.Date,
convert(varchar(5),DateDiff(s,owe.From_Time, owe.To_Time)/3600)+'Hrs '
+convert(varchar(5),DateDiff(s,owe.From_Time, owe.To_Time)%3600/60)+'Mins' as 'Total Time'
--+':'+convert(varchar(5),(DateDiff(s, owe.From_Time, owe.To_Time)%60))+'Sec'
from
PMS_OfficeWorkTask owt
left outer join PMS_Activity act on  act.Auto_Id=owt.Activity
left outer join PMS_Customer cust on cust.cust_Id=owt.Customer
left outer join PMS_JobOrder jo on jo.ID=owt.Job_Card
left outer join PMS_WorkOrder wo on wo.ID=owt.Work_Order
left outer join PMS_Users usr on usr.ID=owt.UserID
left outer join PMS_OfficeWorkEntry owe on owe.Task_Id=owt.Auto_Id



where
(owe.Task_Id like '%'+@task+'%' or @task is null)
and
(act.Activity_Name = @activity or @activity is null)
and
----(owt.status =@status or @status is null)
--and
--(owt.type = @type or @type is null)
--and
(CASE When LEN(owt.Date)>10 
then   
convert(datetime,owt.Date,105)
else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)	or (@fromdate is null or @todate is null)
)						

END

GO
/****** Object:  StoredProcedure [dbo].[Search_MyWorkEntry]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_MyWorkEntry] 
	-- Add the parameters for the stored procedure here
	@we_no nvarchar(50)=null,
	@jo nvarchar(255)=null,
	@process nvarchar(255)=null,
	@site nvarchar(255)=null,
	@wo nvarchar(50)=null,
	@machine nvarchar(255)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@userid nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
select  we.ID as 'ID',usr1.Name as 'Operator',
usr2.Name as 'Assistant',usr3.Name as 'Helper', 
jo.order_name as 'order_name', wo.workordername as 'workordername', 
pst.site as 'Site',
pm.name 'Machine', ps.name 'Process',
 we.entrydate as 'entrydate'
from pms_workentry we
left outer join PMS_Users usr1 on we.Operator=usr1.ID
left outer join PMS_Users usr2 on we.Assistant=usr2.ID
left outer join PMS_Users usr3 on we.Helper=usr3.ID
left outer join pms_joborder jo on jo.id = we.work_joborder 
left outer join pms_workorder wo on wo.id = we.work_workorder 
left outer join PMS_Machines pm on pm.id = we.Work_Machinary 
left outer join PMS_Processes ps on ps.id = we.Work_Process
left outer join PMS_sites pst on pst.id = we.Work_Godown

where
(we.UserId=@userid or @userid is null)
and
(we.ID=@we_no or @we_no is null ) 
and
(we.Work_JobOrder =@jo or @jo is null ) 
and
(we.Work_Process =@process or @process is null ) 
and
(we.Work_Godown =@site or @site is null ) 
and
(wo.ID =@wo or @wo is null ) 
and
(we.Work_Machinary =@machine or @machine is null ) 
and
(CASE When LEN(we.EntryDate)>10
 then  
convert(datetime,we.EntryDate,105) else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 
order by entrydate desc

--we.EntryDate  
--between convert(nvarchar,''+@fromdate+'',105) and convert(nvarchar,''+@todate+'',105)or (@fromdate is null or @todate is null) 

--we.EntryDate  between
--convert(datetime,''+COALESCE(@fromdate,convert(varchar(10),we.EntryDate,110))+'',105) 
--and 
--convert(datetime,''+coalesce(@todate,convert(varchar(10),we.Entrydate,110))+'',105)
--or
--@fromdate is null or @todate is null

END

GO
/****** Object:  StoredProcedure [dbo].[Search_NPMachineReports]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_NPMachineReports] 
	-- Add the parameters for the stored procedure here
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
select m.name as Machine,pc.process_category as ProcessCat,
(cast(count(distinct we.EntryDate)as varchar ) + ' / ' + 'All') as totaldays 
 from PMS_Machines m left join PMS_WorkEntry we 
 on m.id = we.Work_Machinary inner join PMS_ProcessCategory pc 
 on m.category = pc.id 
 
 
 where
 (CASE When LEN(we.EntryDate)>10 
then   
convert(datetime,we.EntryDate,105)
else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)	or (@fromdate is null or @todate is null)
)						
 
 group by m.id,m.name,pc.process_category  order by m.name asc 
END

GO
/****** Object:  StoredProcedure [dbo].[Search_NPProcessReports]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_NPProcessReports]
	-- Add the parameters for the stored procedure here
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	


select p.name as Process,pc.process_category as ProcessCat,
(cast(count(distinct we.EntryDate)as varchar ) + ' / ' + 'All') as totaldays 
 from PMS_Processes p left join PMS_WorkEntry we 
 on p.id = we.Work_Process inner join PMS_ProcessCategory pc
 on p.category = pc.id 
 
where
(CASE When LEN(we.EntryDate)>10 
then   
convert(datetime,we.EntryDate,105)
else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)	or (@fromdate is null or @todate is null)
)						

group by p.id,p.name,pc.process_category  order by p.name asc 


END

GO
/****** Object:  StoredProcedure [dbo].[Search_NPUserReports]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_NPUserReports] 
	-- Add the parameters for the stored procedure here
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@user varchar(255)=null
	AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
select u.Name as UserName,
(cast(count(distinct we.EntryDate)as varchar ) + ' / ' + 'All') as totaldays 
 from PMS_Users u left join PMS_WorkEntry we 
 on u.Username = we.UserId 
 
 
 where
 (CASE When LEN(we.EntryDate)>10 
then   
convert(datetime,we.EntryDate,105)
else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)	or (@fromdate is null or @todate is null)
)	
and
(u.Name = @user or @user is null)					

 group by u.id,u.name order by u.name asc 

END

GO
/****** Object:  StoredProcedure [dbo].[Search_OpenJob_Reports]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_OpenJob_Reports] 
	-- Add the parameters for the stored procedure here
	@cust_name nvarchar(550)=null,
	@jo_name varchar(255)=null,
	@status int = null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
select c.cust_Name,j.Order_Name,w.WorkOrderName,
case when w.Status='0' then 'Closed'
when w.Status='1' then 'Opened'
else ' ' end as 'Status',
sum(cast(w.Quantity as bigint)) as DesireQty,
sum(cast(wer.Resources_Output as bigint))as ProdQty ,
count(we.ID) as RecCount,
convert(nvarchar,we.EntryDate,105) as EntryDate
--w.ID
from  
PMS_WorkOrder w 
Left outer join PMS_Customer c on w.CustomerID = cust_Id 
Left outer join PMS_JobOrder j on w.JobOrderID = j.ID 
Left outer join PMS_WorkEntry we on we.Work_WorkOrder = w.ID 
Left  outer join PMS_WorkEntryResources wer on wer.WorkEntry_Id = we.ID 


where

(w.CustomerID = @cust_name or @cust_name is null)
and
(w.JobOrderID = @jo_name or @jo_name is null)
and
(w.Status = @status or @status is null)

and
(CASE When LEN(we.EntryDate)>10 
then  
convert(datetime,we.EntryDate,105) 
else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)
)

group by w.ID,w.WorkOrderName,j.Order_Name,c.cust_Name,w.Status,we.EntryDate

END

GO
/****** Object:  StoredProcedure [dbo].[Search_OperatorsEntryCount_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_OperatorsEntryCount_Report] 
	-- Add the parameters for the stored procedure here
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@user varchar(255)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

select u.Name as UserName,
(cast(count(distinct we.EntryDate)as varchar ) + ' / ' + 'All') as totaldays 
 from PMS_Users u 
 left outer join PMS_WorkEntry we on u.Username = we.UserId 
 
 where 
 (CASE When LEN(we.EntryDate)=10 then 
  convert(datetime,we.EntryDate,105)
  else null END 
  between 
   convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)
   ) 
 and
 (we.UserId = @user or @user is null)
 
 group by u.id,u.name order by u.name asc 
END

GO
/****** Object:  StoredProcedure [dbo].[Search_Parameters]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Parameters] 
	-- Add the parameters for the stored procedure here
	@para_name nvarchar(255)=null,
	@para_Cat varchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select a.ID,a.Para_ID,a.Para_Name,b.name as cat_name
	from 
	PMS_RM_Parameters a 
	left outer join PMS_Category b
	on a.Prod_Cat=b.id
	where
	--a.ID = COALESCE(@para_name,a.ID) 
	--and
	-- a.Prod_Cat = COALESCE(@para_Cat, a.Prod_Cat) 
	
	
	(a.Para_Name like '%'+@para_name+'%' or @para_name is null) 
	and
	 (a.Prod_Cat = @para_Cat or @para_Cat is null)
	  Order by cast(substring(a.ID,6,10)as int) desc,substring(a.ID,1,1)desc
END

GO
/****** Object:  StoredProcedure [dbo].[Search_PendingSupplier]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Search_PendingSupplier]
	-- Add the parameters for the stored procedure here
	@sname varchar(500)=null,
	@costcenter varchar(100)=null,
	@category varchar(100)=null,
	@state varchar(10)=null,
	@city varchar(10)=null,
	@status varchar(20)=null,
	@fromdate nvarchar(50) =null,
	@todate nvarchar(50) =null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   
	SELECT a.SupplierName,a.SupplierCode,a.SupplierCategory,b.State_Name,c.City_Name,
	 (case when a.Status=1 then 'Pending' when a.Status=2 then 'Approved' else '' end) as 'status'
	from PMS_SupplierMaster a 
	left outer join PMS_State b on a.StateCode=b.State_Code 
	left outer join PMS_City c on a.CityCode = c.city_Code
	
	where Flag='1' and a.Status <>'2' 
	and	
	(a.SupplierName like '%'+@sname+'%' or @sname is null)
	and 
	(a.CostCenter = @costcenter or  @costcenter is null) 
	and  
	(a.SupplierType = @category or @category is null)
	and		
	((CASE When LEN(a.CreatedDate) >=10 then  convert(datetime,a.CreatedDate,105) else null END 
	between convert(date,''+@fromdate+'',105) and convert(date,''+@todate+'',105))or (@fromdate is null or @todate is null)) 
	and
	(b.State_Code = @state or @state is null) 
	and 
	(c.city_Code = @city or @city is null) 
	and 
	(a.Status = @status or @status is null)
	
	order by cast(substring(SupplierCode,6,10)as int) desc , substring(SupplierCode,1,1) desc
END

 
 

GO
/****** Object:  StoredProcedure [dbo].[Search_Processes]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Processes]
	-- Add the parameters for the stored procedure here
	@pname nvarchar(255)= null,
	@p_cat nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select a.ID,a.Name,a.ProcessID,b.Process_Category as Category,a.Is_Fixed
	from PMS_Processes a 
	left outer join PMS_ProcessCategory b
	on
	a.Category=b.id
	where 
	
	--a.Name like '%'+COALESCE(@pname,a.Name)+'%' and 
	--b.Process_Category = COALESCE(@p_cat,b.Process_Category)
	
	
	(a.Name like '%'+@pname+'%' or @pname is null )
	 and 
	(a.Category = @p_cat or @p_cat is null)
	order by cast(SubString(a.ID,6,10)as int) Desc,substring(a.ID,1,1)desc
END

GO
/****** Object:  StoredProcedure [dbo].[Search_ProdcutCategory]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_ProdcutCategory]
	-- Add the parameters for the stored procedure here
	@rm_mat_cat nvarchar(50)=null,
	@rm_prod_Cat nvarchar(200)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT cat1.*,cat2.name as rmname FROM PMS_Category cat1 
	LEFT JOIN PMS_Category cat2 ON cat1.rmid = cat2.id  
	 WHERE cat1.id=COALESCE(@rm_mat_cat,cat1.id) and
	cat2.id =COALESCE(@rm_prod_Cat, cat2.id) and cat1.rmid > '0'
	Order by cast(substring(cat1.id,6,10)as int) desc , substring(cat1.id,1,1) desc
END



GO
/****** Object:  StoredProcedure [dbo].[SEarch_QC_Reports]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SEarch_QC_Reports] 
	-- Add the parameters for the stored procedure here
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@reports nvarchar(MAX)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
Select we.ID,SUBSTRING(we.Work_QualityCheck, 1, 100) AS Work_QualityCheck,
j.Order_Name as JobOrder,w.WorkOrderName as WorkOrder,p.name as Process,we.EntryDate
 from PMS_WorkEntry we 
inner join PMS_WorkOrder w on we.Work_WorkOrder = w.ID
 inner join PMS_JobOrder j on we.Work_JobOrder = j.ID
 inner join PMS_Processes p on we.Work_Process = p.id
 
 where 


--(CASE When LEN(we.EntryDate)=10 
--then  
convert(datetime,we.EntryDate,105) 
--else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)
--)
 and
(we.ID = @reports or @reports is null)
  
END

GO
/****** Object:  StoredProcedure [dbo].[Search_QcText]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_QcText] 
	-- Add the parameters for the stored procedure here
	@pname nvarchar(50)=null,
	@qctxt nvarchar(150)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select a.qcChk_Id,c.Process_Category,b.Name,a.qcChk_Name 
	from
	PMS_QcChkPoints a 
	left outer join PMS_Processes b  
	on a.qcChk_ProcessId=b.ID 
	 left outer join PMS_ProcessCategory c
	 on b.Category=c.id
	 where 
	 -- a.qcChk_ProcessId = COALESCE(@pname, a.qcChk_ProcessId) 
	 --  and
	 --a.qcChk_Name like '%'+COALESCE(@qctxt ,a.qcChk_Name)+'%'
	 
	 (b.ID =@qctxt  or @qctxt is null) 
	   and
	 (a.qcChk_Name like '%'+@pname+'%' or @pname is null)
	 
	 order by Cast(SubString(a.qcChk_Id,6,10)as int ) desc, substring(a.qcChk_Id,1,1)desc
END

GO
/****** Object:  StoredProcedure [dbo].[Search_RawMaterial]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_RawMaterial]
	-- Add the parameters for the stored procedure here
	@Name nvarchar(255)=null,
	@RM_Cat nvarchar(50)=null,
	@Product_Cat nvarchar(50)=null
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select RM.ID,RM.RMID,RM.Name as Name,prodCat.name as RMCategory,prodCat1.name as ProductCategory,
	RM.Description,RM.Unit
	from PMS_RawMaterial RM
	left outer join PMS_Category prodCat1 on prodCat1.id=RM.RM_Cat
	left outer join PMS_Category prodCat on prodCat.id=RM.Product_Cat
	left outer join RMCombined RMC on RM.ID=RMC.ID
	where 
	--RM.Name like '%'+COALESCE(@Name,RM.Name)+'%' 
	--and 
	--RM.RM_Cat=COALESCE(@RM_Cat,RM.RM_Cat) 
	--and 
	--RM.Product_Cat=COALESCE(@Product_Cat,RM.Product_Cat)
	
	(RM.Name like '%'+@Name+'%' or @Name is null) 
	and 
	(RM.RM_Cat = @RM_Cat or  @RM_Cat is null ) 
	and 
	(RM.Product_Cat = @Product_Cat or @Product_Cat is null )
	 order by cast(SubString(RM.ID,6,10)as int) Desc , substring(RM.ID,1,1) desc
END


GO
/****** Object:  StoredProcedure [dbo].[Search_Role]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Role]
	-- Add the parameters for the stored procedure here
	@rolename varchar(100)=null,
	@priviledge varchar(100)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select a.Id,a.RoleName,COUNT(b.PriviledgeID) as 'NoofPriviledge'
	from
	Pms_RoleMaster a left outer join Pms_PriviledgeRoleDetails b 
	on a.Id=b.RoleId 
	left outer join Pms_PriviledgeMaster c 
	on b.PriviledgeID =c.Id
	where
	(a.Id = @rolename or @rolename is null)
	and 
	(b.PriviledgeID = @priviledge or @priviledge is null) 
	group by a.Id,a.RoleName
	order by Cast(Substring(a.Id,6,10) as int) desc
	
END

GO
/****** Object:  StoredProcedure [dbo].[Search_Sales_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Sales_Report]
	-- Add the parameters for the stored procedure here
	@invoice nvarchar(255)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT  Invoice_ID,im.Invoice_No, im.Invoice_Date,im.CreatedOn,
im.Destination,wt.WorkOrderID AS Chal_So_No, 
im.Customer, im.GrandTotal,im.TotalAmount AS Total,
td.tax_Name,td.TaxAmountValue
FROM  dbo.PMS_Invoice_Master im
LEFT OUTER JOIN
dbo.PMS_TaxDetails td ON im.Invoice_No = td.InvoiceNo
LEFT OUTER JOIN
dbo.PMS_WorkOrder_Tax wt ON td.wstax_Id = wt.ID
			
			
where
(im.Invoice_ID = @invoice or @invoice is null ) 
and
(CASE When LEN(im.Invoice_Date)=10 
then   
convert(datetime,im.Invoice_Date,105)
else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)	or (@fromdate is null or @todate is null)
)						
END

GO
/****** Object:  StoredProcedure [dbo].[Search_Shift]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Shift]
	-- Add the parameters for the stored procedure here
	@shift_cat varchar(150)=null,
	@shift_name varchar(255)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select a.Auto_Id,b.Shift_Category,a.Shift_Name,a.Time_From,a.Time_To
	from
	PMS_Shift_Master1 a 
	left outer join PMS_Shift_Category_Master b
	on a.Shift_Category_Id=b.Auto_Id
	where
	
	--a.Shift_Category_Id = COALESCE(@shift_cat,a.Shift_Category_Id) and 
	--a.Shift_Name like '%'+COALESCE(@shift_name,a.Shift_Name)+'%' 
	
	
	(a.Shift_Category_Id = @shift_cat or @shift_cat is null) 
	and 
	(a.Shift_Name like '%'+@shift_name+'%' or @shift_name is null)
END

GO
/****** Object:  StoredProcedure [dbo].[Search_State]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_State]
	-- Add the parameters for the stored procedure here
	@Country_name nvarchar(50)=null,
	@State_name nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select a.State_Id,b.Country_Name,a.State_Name,a.State_Code
	from
	PMS_State a left outer join PMS_Country b
	on a.country_Id=b.Country_Id
	where 
	--a.country_Id= COALESCE(@Country_name ,a.country_Id) and
	--a.State_Id = COALESCE(@State_name ,a.State_Id) 
	
	(a.country_Id= @Country_name or @Country_name is null) 
	and
	(a.State_Id = @State_name or @State_name is null) 
	order by cast(Substring(State_Id,6,10)as int) Desc , substring(State_Id,1,1) desc
END

GO
/****** Object:  StoredProcedure [dbo].[Search_Supplier]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Search_Supplier]
	-- Add the parameters for the stored procedure here
	@sname varchar(500)=null,
	@costcenter varchar(100)=null,
	@category varchar(100)=null,
	@state varchar(10)=null,
	@city varchar(10)=null,
	@status varchar(20)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   
	SELECT a.SupplierName,a.SupplierCode,s.ContPerson,s.MobileNo,s.LandlineNo,s.EmailId,a.SupplierType,a.SupplierCategory,a.StateCode,b.State_Name,a.CItyCode,c.City_Name,a.Address
	,CASE when a.Status='1' then 'Pending' 
	When a.Status='2' then 'Approved' 
	When a.Status='3' then 'Black List' 
	ELSE '' END as Status1,a.Status
	from PMS_SupplierMaster a 
	left outer join PMS_State b on a.StateCode=b.State_Code 
	left outer join PMS_City c on a.CityCode = c.city_Code
	left outer join PMS_SupplierContactPerson s on s.supplier_UID=a.SupplierCode
	where 
	--a.SupplierName like '%'+COALESCE(@sname,a.SupplierName)+'%' 
	--and 
	--a.CostCenter = COALESCE(@costcenter,a.CostCenter) 
	--and  
	--a.SupplierType =COALESCE(@category,a.SupplierType)
	--and
	-- a.StateCode = COALESCE(@state,a.StateCode) 
	--and
	-- a.CityCode = COALESCE(@city,a.CityCode) 
	--and 
	--a.Status = COALESCE(@status,a.Status)
	
	
	(a.SupplierName like '%'+@sname+'%'  or @sname is null )
	and 
	(a.CostCenter = @costcenter or @costcenter is null) 
	and  
	(a.SupplierType =@category or @category is null)
	and
	 (a.StateCode = @state or @state is null) 
	and
	 (a.CityCode = @city or @city is null ) 
	and 
	(a.Status = @status or @status is null )
	 order by cast(substring(SupplierCode,6,10)as int) desc , substring(SupplierCode,1,1) desc 
END
 

GO
/****** Object:  StoredProcedure [dbo].[Search_Tutorial]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Tutorial] 
	-- Add the parameters for the stored procedure here
	@module  nvarchar(MAX)=null,
	@tutorial nvarchar(MAX)=null,
	@author nvarchar(MAX)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	


select t.uid,t.Module,t.Auther,t.Download
from PMS_Tutorial t

where 
(t.uid = @module or @module is null)
and
(t.Tutorial like '%'+@tutorial+'%' or '%'+@tutorial+'%' is null)
and
(t.Auther = @author or @author is null)

END

GO
/****** Object:  StoredProcedure [dbo].[Search_User]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_User]
	-- Add the parameters for the stored procedure here
	@fullname nvarchar(255)=null,
	@username nvarchar(255)=null,
	@empcode nvarchar(50)=null,
	@site nvarchar(50)=null,
	@status nvarchar(50)=null,
	@roll nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select a.ID,a.EmpCode,a.Name,a.Username,b.Type,e.Site,
	CASE when a.Status='1' then 'Active' 
	When a.Status='0' then 'Inactive' 
	ELSE '' END as Status,
	c.Designation,d.Position
	from
	PMS_Users a left outer join PMS_Type b
	on a.Type=b.ID
	left outer join PMS_Designation c 
	on a.Designation=c.Auto_Id
	left outer join PMS_Position d 
	on a.Position=d.ID
	left outer join PMS_Sites e
	on a.Site=e.ID
	left outer join Pms_UserRoleMaster urm 
	on urm.UserID = a.ID
	left outer join Pms_RoleMaster rm 
	on rm.Id = urm.RoleID
	
	where
	-- a.Name like '%'+COALESCE(@fullname,a.Name)+'%' and 
	--a.Username like '%'+COALESCE(@username,a.Username)+'%' and 
	--a.EmpCode like '%'+COALESCE(@empcode ,a.EmpCode)+'%' and
	--a.Site = COALESCE(@site ,a.Site) and
	-- a.Status like '%'+COALESCE(@status,a.Status)+'%'
	 a.UserType='0' and
	 
	 
	 (a.Name like '%'+@fullname+'%' or @fullname is null) 
	 and 
	(a.Username like '%'+@username+'%' or @username is null)
	 and 
	(a.EmpCode like '%'+@empcode+'%' or @empcode is null)
	 and
	(e.Site = @site or @site IS NULL)
	 and
	(a.Status like '%'+@status+'%' or @status is null)
	and
	(rm.Id = @roll or @roll IS NULL)
	 order by CAst(SUBSTRING(a.ID,6,10) as int) desc
END






GO
/****** Object:  StoredProcedure [dbo].[Search_UserOperator]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Search_UserOperator] 
	-- Add the parameters for the stored procedure here
	@Name nvarchar(300)=null,
	@Status nvarchar(300)=null,
	@Username nvarchar(50)=null,
	@EmpCode nvarchar(50)=null
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select a.ID,a.Name,b.Site,a.Status,
	CASE when a.Status='1' then 'Active' 
	When a.Status='0' then 'Inactive' 
	ELSE '' END as Status1,a.Username,a.EmpCode
	from PMS_Users a left outer join PMS_Sites b 
	on
	a.Site=b.ID
	where 
	
	--a.Full_Name like '%'+COALESCE(@Full_Name,a.Full_Name)+'%' 
	--and a.Status=COALESCE(@Status,a.Status) 
	--and a.User_Name like '%'+COALESCE(@User_Name,a.User_Name)+'%' 
	--and a.Emp_Code like '%'+COALESCE(@Emp_Code,a.Emp_Code)+'%' or 
	--a.Emp_Code like '%'+@Emp_Code+'%'
	a.UserType='1' and
	
	(a.Name like '%'+@Name+'%' or @Name is null) 
	 and 
	 (a.Status like '%'+@Status+'%' or @Status is null)
	and 
	 (a.Username  like '%'+@Username+'%' or @Username is null)
	and
	(a.EmpCode like '%'+@EmpCode+'%' or @EmpCode is null)
	order by cast(substring(a.ID,12,10) as int)desc
	
END

GO
/****** Object:  StoredProcedure [dbo].[Search_ViewCompletedTask]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[Search_ViewCompletedTask]
	-- Add the parameters for the stored procedure here
	@assignedby nvarchar(255)=null,
	@activity nvarchar(255)=null,
	@cust nvarchar(255)=null,
	@jc nvarchar(255)=null,
	@wo nvarchar(255)=null,
	@priority varchar(10)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

select owt.Auto_Id,usr.Name,act.Activity_Name,cust.cust_Name,jo.Order_Name,
wo.WorkOrderName,
convert(nvarchar,owt.ExpectedEndDate,105) as 'EDOC',
convert(nvarchar,owt.ActualDateOfCompletion,105) as 'ADOC',
owt.Description,owe.From_Time,owe.To_Time, 
convert(varchar(5),DateDiff(s,owe.From_Time, owe.To_Time)/3600)+'Hrs '
+convert(varchar(5),DateDiff(s,owe.From_Time, owe.To_Time)%3600/60)+'Mins' as 'Total Time'
--+':'+convert(varchar(5),(DateDiff(s, owe.From_Time, owe.To_Time)%60))+'Sec'
from
PMS_OfficeWorkTask owt
left outer join PMS_Activity act on  act.Auto_Id=owt.Activity
left outer join PMS_Customer cust on cust.cust_Id=owt.Customer
left outer join PMS_JobOrder jo on jo.ID=owt.Job_Card
left outer join PMS_WorkOrder wo on wo.ID=owt.Work_Order
left outer join PMS_Users usr on usr.ID=owt.UserID
left outer join PMS_OfficeWorkEntry owe on owe.Task_Id=owt.Auto_Id



where
(usr.Name = @assignedby or @assignedby is null)
and
(act.Activity_Name = @activity or @activity is null)
and
(cust.cust_Name = @cust or @cust is null)
and
(owt.Job_Card = @jc or @jc is null)
and
(owt.Work_Order = @wo or @wo is null)
and
(owt.Priority = @priority or @priority is null)
and
----(owt.status =@status or @status is null)
--and
--(owt.type = @type or @type is null)
--and
(CASE When LEN(owt.Date)>10 
then   
convert(datetime,owt.Date,105)
else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)	or (@fromdate is null or @todate is null)
)						

END

GO
/****** Object:  StoredProcedure [dbo].[Search_Wastage]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_Wastage]
	-- Add the parameters for the stored procedure here
	@id nvarchar(50)=null,
	@Wname nvarchar(50)=null,
	@unit nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select a.Wastage_Id,a.Item,b.Unit from PMS_Wastage a 
	left outer join 
	PMS_Units b on a.Unit=b.ID 
	where 
	--a.Wastage_Id like '%'+COALESCE(@id,a.Wastage_Id)+'%' 
	--and 
	--a.Item like '%'+COALESCE(@Wname,a.Item)+'%' 
	--and
	--b.Unit = COALESCE(@unit,b.Unit)
	
	
	(a.Wastage_Id like '%'+@id+'%' or @id is null)
	and 
	(a.Item like '%'+@Wname+'%' or @Wname is null)
	and
	(a.Unit = @unit or @unit is null)
	order by  cast(substring(a.Wastage_Id,12,10) as int) desc, substring(a.Wastage_Id,1,1) desc
END

GO
/****** Object:  StoredProcedure [dbo].[Search_WastageBuyer]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_WastageBuyer]
	-- Add the parameters for the stored procedure here
	@id nvarchar(50)= null,
	@buyer_name nvarchar(50)= null,
	@org nvarchar(100)= null
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	
    -- Insert statements for procedure here
	
	SELECT Buyer_Id,Buyer_Name,Organisation,Address,PhoneNo from PMS_Buyer 
	where 
	--Buyer_Id like '%'+COALESCE(@id,Buyer_Id)+'%' 
	--and
	-- Buyer_Name like '%'+COALESCE(@buyer_name,Buyer_Name)+'%'
	--and  
	--Organisation like '%'+COALESCE(@org,Organisation)+'%'


	(Buyer_Id like '%'+@id+'%' or @id is null) 
	and
	 (Buyer_Name like '%'+@buyer_name+'%' or @buyer_name is null)
	and  
	(Organisation like '%'+@org+'%' or @org is null )
	order by cast(substring(Buyer_Id,6,10) as int) desc, cast(substring(Buyer_Id,12,10) as int) desc, substring(Buyer_Id,1,1) desc
END


GO
/****** Object:  StoredProcedure [dbo].[Search_WastageRate]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_WastageRate] 
	-- Add the parameters for the stored procedure here
	@id nvarchar(50)=null,
	@bname nvarchar(50)=null,
	@item nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select a.Id,c.Buyer_Name as Buyer,b.Item,a.Rate,a.Unit
	from
	PMS_Rate a
	 left outer join PMS_Wastage b 
	on a.Item=b.Wastage_Id
	left outer join PMS_Buyer c
	on a.Buyer=c.Buyer_Id
	where
	-- a.Id like '%'+ COALESCE(@id,a.Id)+'%' 
	-- and 
	--a.Buyer = COALESCE(@bname,a.Buyer) 
	--and 
	--a.Item = COALESCE(@item ,a.Item)
	
	(a.Id like '%'+@id+'%'or @id is null) 
	 and 
	(a.Buyer = @bname or @bname is null) 
	and 
	(a.Item =@item or @item is null)
	 order by  cast(substring(a.Id,12,10) as int) desc, substring(a.Id,1,1) desc
	 
END

GO
/****** Object:  StoredProcedure [dbo].[Search_WorkEntry_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Search_WorkEntry_Report] 
	-- Add the parameters for the stored procedure here
	@process nvarchar(255)=null,
	@Machine nvarchar(255)=null,
	@entry_no nvarchar(50)=null,
	@customer nvarchar(550)=null,
	@workorder nvarchar(50)=null,
	@joborder nvarchar(50)=null,
	@site_location nvarchar(255)=null,
	@username nvarchar(255)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

select distinct we.ID,we.Operator as 'Operator',
jo.Order_Name +' '+(jo.Order_Id)as 'Job Cart',wo.WorkOrderID,pst.Site,
mchn.Name as 'Machine',
pr.Name as 'Process',
(wor.WERO_InPro_Qty)+'  '+(un.Unit) as 'Output',un.unit as 'Total Output',
convert(nvarchar,we.EntryDate,105) as 'Entry Date'
from PMS_WorkEntry we 
left outer join PMS_Users op on we.Operator=op.ID 
left outer join PMS_Users hlp on we.Helper=hlp.ID
left outer join PMS_Users ast on we.Assistant=ast.ID
left outer join PMS_JobOrder jo on we.Work_JobOrder=jo.ID
left outer join PMS_WorkOrder wo on we.Work_WorkOrder=wo.ID 
left outer join PMS_JobOrderProcesses jop on jop.joborder_Id=jo.ID
left outer join PMS_Processes pr on pr.ID=jop.joborder_Process
left outer join PMS_WorkEntryResources_InputPro wi on wi.WERI_WorkEntryId=we.ID
left outer join PMS_WorkEntryResources_OutputPro wor on wor.WERO_WorkEntryId=we.ID
left outer join PMS_RawMaterial rm on rm.ID=wi.WERI_InPro_ResId
left outer join PMS_FGEntry fg on fg.cc_WorkOrderId=wo.ID
left outer join PMS_Units un on un.ID=fg.cc_Unit
left outer join PMS_Machines mchn on mchn.ID=we.Work_Machinary
left outer join PMS_sites pst ON pst.id = we.Work_Godown



where 
(jop.joborder_Process = @process or @process is null)
and
(we.Work_Machinary = @Machine or @Machine is null)
and
(we.ID like '%'+@entry_no+'%'  or @entry_no is null)
and
(wo.CustomerID = @customer or @customer is null)
and

(wo.WorkOrderID = @workorder or @workorder is null)
and
(jo.Order_Id = @joborder or @joborder is null)
and
(we.Work_Godown = @site_location or @site_location is null)
and
(we.Operator= @username or @username is null)
and 
(we.EntryDate between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)	or (@fromdate is null or @todate is null)) 



END

GO
/****** Object:  StoredProcedure [dbo].[SearchGetValue]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[SearchGetValue]
(@String  VARCHAR(500))
 
AS
BEGIN


DECLARE @SQL nvarchar(max)= @String 

 


EXEC sp_executeSQL @SQL


end
GO
/****** Object:  StoredProcedure [dbo].[sp_addextendedproc]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create procedure [dbo].[sp_addextendedproc] --- 1996/08/30 20:13
@functname nvarchar(517),/* (owner.)name of function to call */
@dllname varchar(255)/* name of DLL containing function */
as
set implicit_transactions off
if @@trancount > 0
begin
raiserror(15002,-1,-1,'sp_addextendedproc')
return (1)
end
dbcc addextendedproc( @functname, @dllname)
return (0) -- sp_addextendedproc

GO
/****** Object:  StoredProcedure [dbo].[SP_ChallanDispatch_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ChallanDispatch_Report]
	-- Add the parameters for the stored procedure here
	@customer nvarchar(50)=null,
	@workorder nvarchar(50)=null,
	@jobcard varchar(150)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@challan_no nvarchar(25)=null,
	@status int=null,
	@lr_status char(1)=null,
	@sortby varchar(20)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

select gc.chal_No,wo.WorkOrderID,gc.Item_Description,cust.cust_No,cust.cust_Name,
gc.DispatchQty,gc.chal_Date,gc.chal_ID,wo.work_po_no,im.Invoice_No
from PMS_GenerateChallan gc 
left outer join PMS_WorkOrder wo on wo.ID=gc.chal_SO_No
LEFT outer join PMS_Customer cust on cust.cust_Id=wo.CustomerID
left outer join PMS_Invoice_Master im on gc.chal_ID=im.Challan_ID

where 
(cust.cust_Id = @customer  or @customer  is null)
and
(wo.WorkOrderID = @workorder or @workorder is null)
and
(wo.JobOrderID = @jobcard or @jobcard is null)
and
(CASE When LEN(gc.chal_Date)=10 then  convert(datetime,gc.chal_Date,105) else null END between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 
and
(gc.chal_ID = @challan_no or @challan_no is null)
and
(gc.flag = @status or @status is null)
and
(gc.LR_Status = @lr_status or @lr_status is null)
and
--(gc. =@sortby or @sortby is null)
 (gc.chal_ID =@sortby or @sortby is null)
 order by gc.chal_Date desc


END

GO
/****** Object:  StoredProcedure [dbo].[sp_Collection]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Collection] 
	-- Add the parameters for the stored procedure here
	@Invoice_No	nvarchar(50)=null, 
	@Bank_Name	nvarchar(50)=null,
	@AmtRecev nvarchar(50)=null,
	@CreatedOnFrom nvarchar(50)=null,
	@CreatedOnTo nvarchar(50)=null
AS
BEGIN
	
	SET NOCOUNT ON;
Select cf.*, (cb.BankName+ ' ' + '-' + ' ' +cb.AcNo) as Bankdetails,cb.ID from PMS_CollectionForm  cf inner join PMS_Company_BankDetails  cb 
   on cf.Bank_Name=cb.ID
    -- Insert statements for procedure here
	where 
	(@Invoice_No is null or Invoice_No like '%'+@Invoice_No+'%')and
	(@Bank_Name is null or Bank_Name=@Bank_Name )and
	(@AmtRecev is null or CAST(AmtRecev as varchar) like '%'+@AmtRecev+'%')and 	
	(cf.CreatedOn between convert(datetime,''+@CreatedOnFrom+'',105) and
	 convert(datetime,''+@CreatedOnTo+'',105)	or (@CreatedOnFrom is null or @CreatedOnTo is null))
	 
	 order by cast(substring(cf.Collection_Id,6,10) as int) desc, cast(substring(cf.Collection_Id,12,10) as int) desc, substring(cf.Collection_Id,1,1) Desc 
	
END


GO
/****** Object:  StoredProcedure [dbo].[SP_Customer_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_Customer_Report]
	-- Add the parameters for the stored procedure here
	@cust_name nvarchar(550)=null,
	@salesperson nvarchar(30)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

select usr.Name as 'SalesPerson',cust.cust_No as 'ID',cust.cust_Name as 'Customer Name',
cust.cust_Address as 'Customer Address',cust.cust_Vat_No as 'VAT',
cust.cust_Vat_TINNo as 'TIN',cc.CC_Name as 'Contact Person',
cc.CC_Phone as 'Contact No.',cc.CC_Email as 'Email ID'
from PMS_Customer cust
left outer join PMS_Customer_Communication cc on cust.cust_Id=cc.CC_CustId
left outer join PMS_Users usr on cust.cust_SalesPerson=usr.ID


where

(cust.cust_Name like '%'+@cust_name+'%' or @cust_name is null)
and
(cust.cust_SalesPerson = @salesperson or @salesperson is null)
order by cust.cust_Name
END

GO
/****** Object:  StoredProcedure [dbo].[sp_dropextendedproc]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create procedure [dbo].[sp_dropextendedproc] 
@functname nvarchar(517) -- name of function 
as 
-- If we're in a transaction, disallow the dropping of the 
-- extended stored procedure. 
set implicit_transactions off 
if @@trancount > 0 
begin 
raiserror(15002,-1,-1,'sys.sp_dropextendedproc') 
return (1) 
end 
-- Drop the extended procedure mapping. 
dbcc dropextendedproc( @functname ) 
return (0) -- sp_dropextendedproc

GO
/****** Object:  StoredProcedure [dbo].[SP_FillProduct_Category]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_FillProduct_Category]
@rmid as nvarchar(20)
as
select * from PMS_Category where rmid = @rmid

GO
/****** Object:  StoredProcedure [dbo].[SP_GeneralMaterial_Allotment_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GeneralMaterial_Allotment_Report] 
	-- Add the parameters for the stored procedure here
	@rm_cat nvarchar(50)=null,
	@prod_cat nvarchar(50)=null,
	@prod nvarchar(255)=null,
	@users nvarchar(50)=null,
	@machines nvarchar(255)=null,
	@status nvarchar(10)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
select gma.Material_Id as 'ID',gma.EntryDate as 'Date',rm.Name as 'Product',gma.Qty as 'Quantity',
usr.Name as 'Person',gma.MaterialStatus as 'Status'
from PMS_GeneralMaterialAllotment gma 
left outer join PMS_RawMaterial rm on gma.RM_Item=rm.ID
left outer join PMs_users usr on gma.PersonName=usr.ID

where
(gma.RM_Cat = @rm_cat or @rm_cat is null)
and 
(gma.RM_ProdCat = @prod_cat or @prod_cat is null)
and 
(rm.ID =@prod or @prod is null)
and 
(usr.ID = @users or @users is null)
and 
(gma.Machinary =@machines or @machines is null)
and 
(gma.Material_Id = @status or @status is null)
and 
(gma.EntryDate between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)	or (@fromdate is null or @todate is null)) 


END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetLastUpdatedDate]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_GetLastUpdatedDate]
(
@colName varchar(500)
)
as
Declare @Query varchar(MAX)

set @Query= '
Select top 1 * from PMS_FileTransfer
order by '+@colName+ ' desc'

exec (@Query)


GO
/****** Object:  StoredProcedure [dbo].[SP_InkCreated_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_InkCreated_Report] 
	-- Add the parameters for the stored procedure here
	@jobname nvarchar(500)=null,
	@inkname nvarchar(250)=null,
	@inkqty nvarchar(500)=null,
	@createdby nvarchar(50)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


Select imc.CreatedOn as 'Date',imc.ID,imc.Job_Name as 'Job Name',
im.NewColour as 'Ink Name',imc.Qty_Ink_Kg as 'Kilogram',
usr.Name as 'Operator Name',im.Remark
from PMS_Ink_Mixture_Created imc 
left outer join PMS_Ink_Mixture im on imc.InkMixture=im.ID
left outer join PMS_Users usr on imc.CreatedBy=usr.ID

where 

(imc.Job_Name like  '%'+@jobname+'%' or @jobname is null)
and
(im	.NewColour like  '%'+@inkname+'%' or @inkname is null)
and
(imc.Qty_Ink_Kg like  '%'+@inkqty+'%' or @inkqty is null)
and
(imc.CreatedBy = @createdby or @createdby is null)
and
--(CASE When LEN(imc.CreatedOn)=10 then  
convert(datetime,imc.CreatedOn,105) 
--else null END 
between 
convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null) 


END

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertProforma]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_InsertProforma]
@ID nvarchar(50) ,
@InvoiceNo nvarchar(50),
@Consignee nvarchar(600),
@Consigner nvarchar(600),
@DeliveryAddress nvarchar(600),
@Company_Bank nvarchar(600),
@Supplier nvarchar(50),
@DispatchThrough nvarchar(50),
@SalesPerson nvarchar(50),
@Taxes nvarchar(max),
@TaxesAmount nvarchar(max),
@Total nvarchar(50),
@TotalAmount nvarchar(50),
@RoundedTotal nvarchar(50),
@TermsofPayment nvarchar(max),
@NumberofRows nvarchar(50),
@Oversis_Air decimal(18,2),
@Oversis_C decimal(18,2),
@Oversis_AdminCost decimal(18,2),
@Local_Transport decimal(18,2),
@Transport_ToPay int,
@OverseasL int,
@CorrBank_Name nvarchar(600),
@Corr_AccountNo nvarchar(50),
@Location nvarchar(100),
@Swift_Bic_Code nvarchar(50),
@Currency nvarchar(20),
@CreatedBy nvarchar(50),
@CreatedOn datetime
as

insert into PMS_Proforma (ID ,InvoiceNo,Consignee,Consigner,DeliveryAddress,Company_Bank,Supplier,DispatchThrough ,SalesPerson ,Taxes ,TaxesAmount,Total ,TotalAmount ,RoundedTotal,TermsofPayment,NumberofRows,Oversis_Air,Oversis_C,Oversis_AdminCost,Local_Transport,Transport_ToPay,OverseasL,CorrBank_Name,Corr_AccountNo,Location,Swift_Bic_Code,Currency,CreatedBy,CreatedOn )
values (
@ID ,
@InvoiceNo ,
@Consignee,
@Consigner,
@DeliveryAddress ,
@Company_Bank,
@Supplier ,
@DispatchThrough ,
@SalesPerson ,
@Taxes,
@TaxesAmount ,
@Total ,
@TotalAmount ,
@RoundedTotal ,
@TermsofPayment ,
@NumberofRows ,
cast(@Oversis_Air as decimal(18,2)) ,
cast(@Oversis_C as decimal(18,2)) ,
cast (@Oversis_AdminCost as decimal(18,2)) ,
cast (@Local_Transport as decimal(18,2)),
@Transport_ToPay ,
@OverseasL,
@CorrBank_Name,
@Corr_AccountNo,
@Location,
@Swift_Bic_Code,
@Currency,
@CreatedBy ,
convert(datetime,@CreatedOn,105)
)
GO
/****** Object:  StoredProcedure [dbo].[SP_Invoice_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_Invoice_Report] 
	-- Add the parameters for the stored procedure here
	@challan_no nvarchar(25)=null,
	@invoice_no nvarchar(500)=null,
	@customer nvarchar(500)=null,
	@wo_no nvarchar(50)=null,
	@fromdate nvarchar(500)=null,
	@todate nvarchar(500)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

Select distinct im.Invoice_No as 'Invoice NO.',im.Invoice_Date 'Invoice Date',im.IssueinvoiceDate as 'Issue Date',
im.Customer as 'Cosignee',dbo.Gen_ChallanView.comp_VatRegsNo as 'VAT NO',
dbo.Gen_ChallanView.cust_Tax_CSTNo AS 'CST NO',
im.Challan_ID as 'Dispatch Doc No',id.Item_Desc as 'Item Desc',id.Tarrif_HSN as 'Tariff',
id.Qty as 'Quantity',id.Rate,id.Per,id.Disc as 'Discount',
id.Amount,
im.TotalAmount as 'Gross Total',im.GrandTotal as 'Incl Tax Gross Total',
td.tax_Name,td.TaxAmountValue
from PMS_Invoice_Master im 
left outer join PMS_Invoice_Details id on im.Invoice_ID=id.Invoice_ID
LEFT OUTER JOIN dbo.PMS_TaxDetails td ON im.Invoice_No = td.InvoiceNo
LEFT OUTER JOIN dbo.PMS_WorkOrder_Tax wt ON td.wstax_Id = wt.ID
left outer join PMS_GenerateChallan gc on gc.chal_ID=im.Challan_ID
left outer JOIN dbo.Gen_ChallanView 
  ON im.Challan_ID = dbo.Gen_ChallanView.chal_ID 


where
(im.Challan_ID = @challan_no or @challan_no is null)
and
(im.Invoice_No = @invoice_no or @invoice_no is null)
and
(Gen_ChallanView.cust_Id = @customer or @customer is null)
--and
--(td.InvoiceNo = @wo_no or @wo_no is null)
and
(CASE When LEN(im.Invoice_Date)=10 then  convert(datetime,im.Invoice_Date,105) else null END between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 

END

GO
/****** Object:  StoredProcedure [dbo].[SP_Inward_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_Inward_Report]
	-- Add the parameters for the stored procedure here
	@po_no nvarchar(25)=null,
	@received_by nvarchar(50)=null,
	@supplier nvarchar(MAX)=null,
	@rmcat nvarchar(50)=null,
	@rmprod_cat nvarchar(50)=null,
	@material nvarchar(50)=null,
	@uid nvarchar(20)=null,
	@inward_no nvarchar(20)=null,
	@invoice_no nvarchar(50)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@costcenter int=null,
	@received_at nvarchar(20)=null,
	@gate_entry nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
select inwrd_mat.ID as 'UID',inwrd.Inward_Date as 'Date',inwrd_mat.Inward_ID as 'Inward ID',
cat.name as 'RM Product Category',rm.Name as 'Material',inwrd.Supplier,
inwrd_mat.GRNQty as 'GRN Qty',inwrd_mat.Total,inwrd.PO_No,inwrd.Invoice_No as 'Invoice No.'
from PMS_InwardMaterial inwrd_mat 
left outer join PMS_InwardMaster inwrd on inwrd.ID=inwrd_mat.Inward_ID
left outer join PMS_RawMaterial rm on inwrd_mat.Material=rm.ID
left outer join PMS_Category cat  on inwrd_mat.RM_Prod_Cat=cat.id
left outer join PMS_Users usr on inwrd.Receiver_Name=usr.ID
left outer join PMS_Sites st on usr.Site=st.ID

where
(inwrd.PO_No like '%'+@po_no+'%'  or @po_no  is null)
and
(inwrd.Receiver_Name = @received_by or @received_by is null)
and
(inwrd.Supplier like '%'+@supplier+'%'  or @supplier  is null)
and
(rm.RM_Cat = @rmcat or @rmcat is null)
and
(inwrd_mat.RM_Prod_Cat = @rmprod_cat or @rmprod_cat is null)
and
(inwrd_mat.Material = @material or @material is null)
and
(inwrd_mat.ID like '%'+@uid+'%'  or @uid  is null)
and
(inwrd.Invoice_No like '%'+@invoice_no+'%'  or @invoice_no  is null)
and
(CASE When LEN(inwrd.Inward_Date)=10 then  convert(datetime,inwrd.Inward_Date,105) else null END between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 
and
(inwrd.Cost_Center = @costcenter or @costcenter is null)
and
(usr.Site = @received_at or @received_at is null)
and
(inwrd.Gate_entry_No like '%'+@gate_entry+'%'  or @gate_entry  is null)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ManageComplaint_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ManageComplaint_Report] 
	-- Add the parameters for the stored procedure here
	@complain_No varchar(50)=null,
	@category varchar(100)=null,
	@title varchar(100)=null,
	@complain_by nvarchar(50)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@status int=null,
	@fromdate1 nvarchar(50)=null,
	@todate1 nvarchar(50)=null,
	@location nvarchar(20)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
select cmpln.Auto_Id as 'CNO',cmpln.Complain_Title as 'Category',
cmpln.Complain_Text as 'Title',
cmpln.Entry_Date as 'Entry Date',
usr.Name as 'Registered By',CASE when cmpln.status='1' then 'New' 
	When cmpln.status='2' then 'Resolved' 
	ELSE '' END as 'Status',cmpln.Resolution as 'Resolution'
from PMS_Complain_Mgmt_System cmpln
left outer join PMS_Users usr on cmpln.User_Name=usr.ID
left outer join PMS_Sites st on st.ID=usr.Site

where

(cmpln.Auto_Id like '%'+@complain_No + '%' or @complain_No  is null)
and
(cmpln.Auto_Id = @category or @category is null)
and
(cmpln.Complain_Title like '%'+@title+ '%' or @title is null)
and
(cmpln.User_Name = @complain_by or @complain_by is null)
and
--(CASE When LEN(cmpln.Entry_Date)=10 then  
convert(datetime,cmpln.Entry_Date,105) 
--else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)
and
(cmpln.status = @status or @status is null)
and
(CASE When LEN(cmpln.UpdatedOn)=10 then  convert(datetime,cmpln.UpdatedOn,105) else null END between convert(datetime,''+@fromdate1+'',105) and convert(datetime,''+@todate1+'',105)or (@fromdate1 is null or @todate1 is null)) 
and
(usr.Site = @location or @location is null)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ManageJOb_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ManageJOb_Report]
	-- Add the parameters for the stored procedure here
	@joborder_id nvarchar(50)=null,
	@workorder_id nvarchar(50)=null,
	@workorder_name nvarchar(max)=null,
	@cust_name nvarchar(550)=null,
	@salesperson nvarchar(50)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
SELECT  jo.Order_Id, wo.WorkOrderID, cus.cust_Name, wo.Quantity, 
un.Unit, pr.Name, fg.cc_FGqty AS [FG Quantity], fg.cc_QtyDispatch AS [Dispatch Quantity] 
--COUNT(im.Invoice_No) AS total_Invoice
FROM  dbo.PMS_WorkOrder wo
 LEFT OUTER JOIN
dbo.PMS_Invoice_Master im
LEFT OUTER JOIN
dbo.PMS_GenerateChallanDetails gcd ON im.Challan_ID = gcd.chal_ID ON 
wo.WorkOrderID = gcd.chalDet_WorkOrderId 
LEFT OUTER JOIN
dbo.PMS_FGEntry fg ON wo.ID = fg.cc_WorkOrderId 
LEFT OUTER JOIN
dbo.PMS_Units un ON wo.Unit = un.ID 
LEFT OUTER JOIN
dbo.PMS_JobOrder jo ON wo.JobOrderID = jo.ID 
LEFT OUTER JOIN
dbo.PMS_Customer cus ON wo.CustomerID = cus.cust_Id 
LEFT OUTER JOIN
dbo.PMS_JobOrderProcesses jop ON wo.JobOrderID = jop.Id
 LEFT OUTER JOIN
dbo.PMS_Processes pr ON jop.joborder_Process = pr.ID
--order by jo.Order_Id


where 
(jo.Order_Id like '%'+@joborder_id+'%'  or @joborder_id is null)
 and 
(wo.WorkOrderID like '%'+@workorder_id+'%' or @workorder_id is null)
and
(wo.WorkOrderID = @workorder_name or @workorder_name is null)
and
(cus.cust_Id= @cust_name or @cust_name is null)
and
(wo.CreatedBy = @salesperson or @salesperson is null)
and
(wo.UpdatedOn between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)	or (@fromdate is null or @todate is null)) 


END

GO
/****** Object:  StoredProcedure [dbo].[sp_ManagePaymentDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_ManagePaymentDetails] 
	-- Add the parameters for the stored procedure here
	@ID nvarchar(50),
	
	@PartyName nvarchar(50)=null,
	@InvoiceNo varchar(255)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@RefNo nvarchar(MAX)=null,
	@StatementType nvarchar(20) = ''
AS
BEGIN
	
	
	IF @StatementType = 'Select'
	BEGIN
		select * from PMS_PaymentDetails as a 
		where (a.ID like '%'+@ID+'%'  or @ID is null) 
			and
			(a.PartyName = @PartyName or @PartyName is null)
			and
			(a.InvoiceNo  like '%'+ @InvoiceNo +'%' or @InvoiceNo is null)
			and
			((CASE When LEN(a.Date) >=10 then  convert(date,a.Date,105) else null END between convert(date,''+@fromdate+'',105) and convert(date,''+@todate+'',105))or (@fromdate is null or @todate is null)) 
			and
			(a.PayRefNo like '%'+ @RefNo+'%' or @RefNo is null)
		order by cast(substring(a.ID,9,2) as int)desc, cast(substring(a.ID,12,10) as int)desc ,substring(a.ID,1,1)desc
			
	END 
	
	IF @StatementType = 'SelectAll'
	BEGIN
		select p.*,s.SupplierName,c.BankName as 'Bank' 
		from PMS_PaymentDetails p inner join PMS_SupplierMaster s on p.PartyName=s.SupplierCode 
		inner join PMS_Company_BankDetails c on p.BankName=c.ID 
		where 
			(p.PartyName = @PartyName or @PartyName is null)
			and
			(p.InvoiceNo  like '%'+ @InvoiceNo +'%' or @InvoiceNo is null)
			and
			((CASE When LEN(p.Date) >=10 then  convert(date,p.Date,105) else null END between convert(date,''+@fromdate+'',105) and convert(date,''+@todate+'',105))or (@fromdate is null or @todate is null)) 
			and
			(p.PayRefNo like '%'+ @RefNo+'%' or @RefNo is null)
			order by cast(substring(p.ID,9,2) as int)desc, cast(substring(p.ID,12,10) as int)desc ,substring(p.ID,1,1)desc
	END 
	
	else IF @StatementType = 'Delete'
	BEGIN
		UPDATE PMS_PaymentDetails SET flag=0  where ID=@ID ;
	END
END



GO
/****** Object:  StoredProcedure [dbo].[SP_OLd_Prod_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_OLd_Prod_Report]
	-- Add the parameters for the stored procedure here
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

select  MCH.Name as 'M/C Name',USOprtr.Name as 'Operator',JC.Order_Name as 'Order Name',
RM.Name as 'Resources',
WEOP.WERO_InPro_Qty as 'Quantity',
UN.Unit,WEOP.WERO_IntPro_WestedQty as 'Wastage'
,'QC'+'--->  '+(WE.Work_QualityCheck)+'  '+'Complains'+'--->'+(WE.Work_Complains)+'   '+'Comments'+'--->'+(WE.Work_Comments) as 'Other Queries'
from PMS_WorkEntry WE
left outer join PMS_Machines MCH on WE.Work_Machinary=MCH.ID
left outer join PMS_Users USOprtr on WE.Operator=USOprtr.ID
left outer join PMS_JobOrder JC on WE.Work_JobOrder=JC.ID
left outer join PMS_WorkEntryResources_OutputPro WEOP on WE.ID = WEOP.WERO_WorkEntryId
left outer join PMS_RawMaterial RM on WEOP.WERO_InPro_ResId=RM.ID
left outer join PMS_Units UN on WEOP.WERO_InPro_Unit=UN.ID

where 
(WE.EntryDate between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105) or (@fromdate is null or @todate is null))
END

GO
/****** Object:  StoredProcedure [dbo].[sp_PaymentDetails]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_PaymentDetails] 
	-- Add the parameters for the stored procedure here
	@ID nvarchar(50),
	@BankName nvarchar(50),
	@BankAcNo nvarchar(50),
	@Date nvarchar(50),
	@Amount decimal(10,4),
	@PartyName nvarchar(50),
	@Remarks nvarchar(max),
	@InvoiceNo nvarchar(50),
	@Banklbl nvarchar(50),
	@Branchlbl nvarchar(50),
	@IFSC nvarchar(50),
	@AcNo nvarchar(50),
	@Address nvarchar(max),
	@PayRefNo nvarchar(50),
	@CreatedBy nvarchar(50),
	@CreatedOn nvarchar(50),
	@UpdatedBy nvarchar(50),
	@UpdatedOn nvarchar(50),
	
	@StatementType nvarchar(20) = ''
AS
BEGIN
	
	IF @StatementType = 'Insert'
	BEGIN
		Insert Into PMS_PaymentDetails (ID,BankName,BankAcNo,Date,Amount,PartyName,Remarks,InvoiceNo,Banklbl,
		Branchlbl,IFSC,AcNo,Address,PayRefNo,CreatedBy,CreatedOn,flag) Values(@ID,@BankName,@BankAcNo,@Date,@Amount,@PartyName,@Remarks,@InvoiceNo,@Banklbl,
		@Branchlbl,@IFSC,@AcNo,@Address,@PayRefNo,@CreatedBy,@CreatedOn,1);
	END
 
	IF @StatementType = 'Select'
	BEGIN
		select * from PMS_PaymentDetails where ID=@ID;
	END 

	IF @StatementType = 'Update'
	BEGIN
		UPDATE PMS_PaymentDetails SET BankName=@BankName,BankAcNo=@BankAcNo,Date=@Date,Amount=@Amount,
		PartyName=@PartyName,Remarks=@Remarks,InvoiceNo=@InvoiceNo,Banklbl=@Banklbl,
		Branchlbl=@Branchlbl,IFSC=@IFSC,AcNo=@AcNo,Address=@Address,PayRefNo=@PayRefNo,UpdatedBy=@UpdatedBy,
		UpdatedOn=@UpdatedOn where ID=@ID ;
	END
 
	else IF @StatementType = 'Delete'
	BEGIN
		UPDATE PMS_PaymentDetails SET flag=0  where ID=@ID ;
	END
END


GO
/****** Object:  StoredProcedure [dbo].[SP_ProductCategory]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ProductCategory]
AS
SELECT * FROM PMS_Category order by name asc


GO
/****** Object:  StoredProcedure [dbo].[SP_RM_ProductCategory]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RM_ProductCategory]
AS 
SELECT * FROM PMS_Category order by name asc



GO
/****** Object:  StoredProcedure [dbo].[SP_RM_ProductItem]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RM_ProductItem]
AS 
select * from PMS_RawMaterial order by Name



GO
/****** Object:  StoredProcedure [dbo].[SP_Sales_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_Sales_Report]
	-- Add the parameters for the stored procedure here
	@invoice nvarchar(255)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT  im.Invoice_No, im.Invoice_Date,
im.Destination,wt.WorkOrderID AS Chal_So_No, 
im.Customer, im.GrandTotal,im.TotalAmount AS Total,
td.tax_Name,td.TaxAmountValue
FROM  dbo.PMS_Invoice_Master im
LEFT OUTER JOIN
dbo.PMS_TaxDetails td ON im.Invoice_No = td.InvoiceNo
LEFT OUTER JOIN
dbo.PMS_WorkOrder_Tax wt ON td.wstax_Id = wt.ID
			
			
where
(im.Invoice_ID = @invoice or @invoice is null ) 
and 
(im.CreatedOn between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)	or (@fromdate is null or @todate is null))			
			
END

GO
/****** Object:  StoredProcedure [dbo].[SP_SetLastUpdatedDate]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_SetLastUpdatedDate]
(
@ID varchar(50),
@Vikhroli datetime,
@Bhiwandi datetime,
@Cloud datetime
)
as
Insert into PMS_FileTransfer(ID,Vikhroli,Bhiwandi,Cloud)
values(@ID,@Vikhroli,@Bhiwandi,@Cloud)

GO
/****** Object:  StoredProcedure [dbo].[SP_TransferDoc_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_TransferDoc_Report]
	-- Add the parameters for the stored procedure here
	@docname nvarchar(MAX)=null,
	@personname nvarchar(50)=null,
	@status int=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@fromdate1 nvarchar(50)=null,
	@todate1 nvarchar(50)=null,
	@location nvarchar(20)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
select td.Doc_Name as 'Document Name',usr.Name as 'Sent by',td.Entry_Date as 'Sent Date',usr1.Name as 'Expected Receiver',
td.Received_Date,
CASE when td.Status='2' then 'Sent' 
	when td.Status='1' then 'Received at Reception'
	When td.Status='0' then 'Acknowledge' 
	ELSE '' END as Status,
td.Remark
from PMS_TransferDoc td 
left outer join PMS_Users usr on td.Send_By=usr.ID
left outer join PMS_Users usr1 on td.Receiver_Name=usr1.ID
left outer join PMS_Sites st on st.ID=usr.Site

where 

(td.Doc_Name like '%' +@docname+ '%' or @docname is null)
and
(td.Send_By = @personname or @personname is null)
and
(td.Status = @status or @status is null)
and
--(CASE When LEN(td.Entry_Date)=10 then  
convert(datetime,td.Entry_Date,105) 
--else null END 
between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null) 
and
(CASE When LEN(td.Received_Date)=10 then  convert(datetime,td.Received_Date,105) else null END between convert(datetime,''+@fromdate1+'',105) and convert(datetime,''+@todate1+'',105)or (@fromdate1 is null or @todate1 is null)) 
and
(usr.Site = @location or @location is null)


END

GO
/****** Object:  StoredProcedure [dbo].[SP_Unit]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Unit]
as
select * from PMS_Units order by Unit


GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateProforma]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_UpdateProforma]
@ID nvarchar(50),
@Consignee nvarchar(600),
@Consigner nvarchar(600),
@DeliveryAddress nvarchar(600),
@Company_Bank nvarchar (600),
@Supplier nvarchar(50),
@DispatchThrough nvarchar(50),
@SalesPerson nvarchar(50),
@Taxes nvarchar(max),
@TaxesAmount nvarchar(max),
@Total nvarchar(50),
@TotalAmount nvarchar(50),
@RoundedTotal nvarchar(50),
@TermsofPayment nvarchar(max),
@NumberofRows nvarchar(50),
@Oversis_Air decimal(18,2),
@Oversis_C decimal(18,2),
@Oversis_AdminCost decimal(18,2),
@Local_Transport decimal(18,2),
@Transport_ToPay int,
@OverseasL int,
@CorrBank_Name nvarchar(600),
@Corr_AccountNo nvarchar(50),
@Location nvarchar(100),
@Swift_Bic_Code nvarchar(50),
@Currency nvarchar(20),
@UpdatedBy nvarchar(50),
@UpdatedOn datetime
as

 Update PMS_Proforma SET
Consignee=@Consignee ,
Consigner=@Consigner,
DeliveryAddress= @DeliveryAddress,
Company_Bank=@Company_Bank,
Supplier=@Supplier, 
DispatchThrough=@DispatchThrough ,
SalesPerson= @SalesPerson,
Taxes=@Taxes,
TaxesAmount=@TaxesAmount,
Total= @Total,
TotalAmount= @TotalAmount,
RoundedTotal=@RoundedTotal ,
TermsofPayment=@TermsofPayment,
NumberofRows=@NumberofRows,
Oversis_Air=@Oversis_Air ,
Oversis_C=@Oversis_C ,
Oversis_AdminCost=@Oversis_AdminCost ,
Local_Transport=@Local_Transport ,
Transport_ToPay=@Transport_ToPay ,
OverseasL=@OverseasL,
CorrBank_Name=@CorrBank_Name,
Corr_AccountNo=@Corr_AccountNo,
Location=@Location,
Swift_Bic_Code=@Swift_Bic_Code,
Currency=@Currency,
UpdatedBy=@UpdatedBy,
UpdatedOn=@UpdatedOn where ID=@ID
GO
/****** Object:  StoredProcedure [dbo].[SP_Users]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Users]
as
select Id, Name,Username from PMS_Users where UserType ='1' and status='1' order by Name

GO
/****** Object:  StoredProcedure [dbo].[SP_Visitor_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_Visitor_Report] 
	-- Add the parameters for the stored procedure here
	@id varchar(50)=null,
	@visitor_type nvarchar(50)=null,
	@organisation nvarchar(150)=null,
	@person_to_meet nvarchar(50)=null,
	@name nvarchar(200)=null,
	@sign varchar(50)=null,
	@location nvarchar(100)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
select vstr.Date,vstr.Name as 'Visitor Name',vstr.ComingFrom as 'Come From',
usr.Name as 'Meet To',vstr.TimeIn as 'In Time',
vstr.OutTime as 'Out Time',vstr.PhoneNo as 'Contact To',vstr.VisitType as 'Purpose'
from PMS_Visitor vstr 
left outer join PMS_Users usr on vstr.PersonToMeet=usr.ID
left outer join PMS_Sites st on usr.Site=st.ID

where

(vstr.Id like '%'+@id+ '%' or @id  is null)
and
(vstr.Id = @visitor_type or @visitor_type is null)
and
(vstr.Organisation like '%'+@organisation+ '%' or @organisation is null)
and
(vstr.PersonToMeet = @person_to_meet or @person_to_meet is null)
and
(vstr.Name like '%'+@name+ '%' or @name  is null)
and
(vstr.Signature = @sign or @sign is null)
and
(st.ID = @location or @location is null)
and
--(CASE When LEN(cmpln.Entry_Date)=10 then  
(CASE When LEN(vstr.Date)=10 then  convert(datetime,vstr.Date,105) else null END between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 

END

GO
/****** Object:  StoredProcedure [dbo].[SP_wastage_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_wastage_Report]
	-- Add the parameters for the stored procedure here
	@Buyer nvarchar(50)=null,
	@item nvarchar(50)=null,
	@measure_by nvarchar(50)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

select ot.Outward_Id as 'ID',byr.Buyer_Name as 'Buyer Name', wst.Item ,ot.Quantity,
un.Unit,ot.Rate,ot.Total,
outwrd.Date as 'Date',usr.Name as 'Measured By'
from PMS_Outward outwrd  
left outer join PMS_OutwardDetails ot  on outwrd.Id=ot.Outward_Id
left outer join PMS_Buyer byr on outwrd.Buyer_Name=byr.Buyer_Id
left outer join PMS_Wastage wst on wst.Wastage_Id=ot.Item
left outer join PMS_Units un on un.ID=wst.Unit
left outer join PMS_Users usr on outwrd.Sold_By=usr.ID

where
(outwrd.Buyer_Name = @Buyer or @Buyer is null)
and
(ot.Item = @item or @item is null)
and
(outwrd.Sold_By = @measure_by or @measure_by is null)
and
(CASE When LEN(outwrd.Date)=10 then  convert(datetime,outwrd.Date,105) else null END between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 



END

GO
/****** Object:  StoredProcedure [dbo].[SP_WorkEntry_Report]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_WorkEntry_Report] 
	-- Add the parameters for the stored procedure here
	@process nvarchar(255)=null,
	@Machine nvarchar(255)=null,
	@entry_no nvarchar(50)=null,
	@customer nvarchar(550)=null,
	@workorder nvarchar(50)=null,
	@joborder nvarchar(50)=null,
	@site_location nvarchar(255)=null,
	@username nvarchar(255)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


select op.Name as 'Operator',hlp.Name as 'Helper',ast.Name as 'Assistant',
jo.Order_Name as 'Order Name',wo.WorkOrderName as 'WorkOrder',pr.Name as 'Process',
(rm.Name)+'  '+(wi.WERI_InPro_Qty)+' '+(wi.WERI_InPro_Unit)as 'Input',
(wor.WERO_InPro_Qty)+'  '+(wor.WERO_InPro_Unit) as 'Output',
(fg.cc_FGqty)+'  '+(un.Unit) as 'FG',mchn.Name as 'Machine',we.CreatedOn as 'DateTime'
from PMS_WorkEntry we 
left outer join PMS_Users op on we.Operator=op.ID 
left outer join PMS_Users hlp on we.Helper=hlp.ID
left outer join PMS_Users ast on we.Assistant=ast.ID
left outer join PMS_JobOrder jo on we.Work_JobOrder=jo.ID
left outer join PMS_WorkOrder wo on we.Work_WorkOrder=wo.ID 
left outer join PMS_JobOrderProcesses jop on jop.joborder_Id=jo.ID
left outer join PMS_Processes pr on pr.ID=jop.joborder_Process
left outer join PMS_WorkEntryResources_InputPro wi on wi.WERI_WorkEntryId=we.ID
left outer join PMS_WorkEntryResources_OutputPro wor on wor.WERO_WorkEntryId=we.ID
left outer join PMS_RawMaterial rm on rm.ID=wi.WERI_InPro_ResId
left outer join PMS_FGEntry fg on fg.cc_WorkOrderId=wo.ID
left outer join PMS_Units un on un.ID=fg.cc_Unit
left outer join PMS_Machines mchn on mchn.ID=we.Work_Machinary
--where Jo.Order_Name like '%ent%'




where 
(pr.ID = @process or @process is null)
and
(mchn.ID = @Machine or @Machine is null)
and
(we.ID like '%'+@entry_no+'%'  or @entry_no is null)
and
(wo.CustomerID = @customer or @customer is null)
and

(wo.WorkOrderID = @workorder or @workorder is null)
and
(jo.Order_Id = @joborder or @joborder is null)
and
(wo.work_Trans_Location = @site_location or @site_location is null)
and
(op.ID = @username or @username is null)
and 
(we.EntryDate between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)	or (@fromdate is null or @todate is null)) 


END

GO
/****** Object:  StoredProcedure [dbo].[SP_WorkOrder_GenerateReport]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_WorkOrder_GenerateReport]
	-- Add the parameters for the stored procedure here
	@id nvarchar(50)=null,
	@joborder varchar(255)=null,
	@workorder_no nvarchar(50)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@workorder_name nvarchar(MAX)=null,
	@customer nvarchar(550)=null,
	@status int=null,
	@salesperson nvarchar(255)=null,
	@postatus int=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

Select usr.Name as 'SalesPerson',cust.cust_No as 'Customer No.',
cust.cust_Name as 'Customer Name',wo.WorkOrderID as 'Order No.',
wo.Date as 'Order Date',jo.Order_Id as 'Item No.',wo.work_po_no as 'PO No.',
jo.Order_Name as 'Description',wo.Quantity,CASE  WHEN ISNUMERIC(dpd.dpd_FGQty)=1 then cast(dpd.dpd_FGQty as decimal) ELSE NULL END as 'Dispatch Quantity',
cast(wo.Quantity as float )- (CASE  WHEN ISNUMERIC(dpd.dpd_FGQty)=1 then cast(dpd.dpd_FGQty as float) ELSE 0 END )as 'Outstanding Quantity',un.Unit
from PMS_WorkOrder wo 
left outer join PMS_JobOrder jo on wo.JobOrderID=jo.ID
left outer join PMS_WorkEntry we on wo.ID=we.Work_WorkOrder
left outer join PMS_Customer cust on wo.CustomerID=cust.cust_Id
left outer join PMS_Users usr on cust.cust_SalesPerson=usr.ID
left outer join PMS_DispatchProDetails dpd on dpd.dpd_WEId=we.ID
left outer join PMS_Units un on wo.Unit=un.ID


where 
(wo.ID like '%'+@id+'%'  or @id is null)
and
(jo.ID = @joborder or @joborder is null)
and
(wo.WorkOrderID like '%'+@workorder_no+'%' or @workorder_no is null)
and
(CASE When LEN(WO.Date)=10 then  convert(datetime,WO.Date,105) else null END between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 
and
(wo.WorkOrderID = @workorder_name or @workorder_name is null)
and
(cust.cust_Id = @customer or @customer is null)
and
(wo.Status = @status or @status is null)
and
(usr.ID = @salesperson or @salesperson is null)
and
(wo.POChk = @postatus or @postatus is null)



END

GO
/****** Object:  StoredProcedure [dbo].[SP_WorkOrder_SalesReport]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_WorkOrder_SalesReport] 
	-- Add the parameters for the stored procedure here
	@id nvarchar(50)=null,
	@joborder varchar(255)=null,
	@workorder_no nvarchar(50)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@workorder_name nvarchar(MAX)=null,
	@customer nvarchar(550)=null,
	@status int=null,
	@salesperson nvarchar(255)=null,
	@postatus int=null
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
Select usr.Name as 'SalesPerson',wo.Date,wo.WorkOrderID as 'SO No.',
cust.cust_Name,CustDL.custLoc_Address as 'Location',jo.Order_Name as 'Product Type',
(jo.jobcart_Width)+' '+(un.Unit)+' * '+(jo.jobcart_Height)+' '+(un1.Unit) as 'Size',
wo.Quantity,wo.Unit_Price as 'Unit Price in INR',(wo.Quantity*wo.Unit_Price) 
as 'Value In Rs.',COUNT(wo.WorkOrderID) as 'Total No. of Work order',
sum(wo.Quantity) as 'Total Work Order Quantity'
from
PMS_WorkOrder wo 
left outer join PMS_JobOrder jo on wo.JobOrderID=jo.ID
left outer join PMS_Customer cust on wo.CustomerID=cust.cust_Id
left outer join PMS_Users usr on cust.cust_SalesPerson=usr.ID
left outer join PMS_CustomerDeliveryLocation CustDL on cust.cust_Id=CustDL.custLoc_CustomerId
left outer join PMS_Units un on jo.jobcart_Width_Unit=un.ID
left outer join PMS_Units un1 on jo.jobcart_Heights_Unit=un1.ID

where 
(wo.ID like '%'+@id+'%'  or @id is null)
and
(jo.ID = @joborder or @joborder is null)
and
(wo.WorkOrderID like '%'+@workorder_no+'%' or @workorder_no is null)
and
(CASE When LEN(WO.Date)=10 then  convert(datetime,WO.Date,105) else null END between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 
and
(wo.WorkOrderID = @workorder_name or @workorder_name is null)
and
(cust.cust_Id = @customer or @customer is null)
and
(wo.Status = @status or @status is null)
and
(usr.ID = @salesperson or @salesperson is null)
and
(wo.POChk = @postatus or @postatus is null)

group by usr.Name,wo.Date,wo.WorkOrderID,cust.cust_Name,CustDL.custLoc_Address,
jo.Order_Name,jo.jobcart_Width,un.Unit,jo.jobcart_Height,un1.Unit,
wo.Quantity,wo.Unit_Price

END

GO
/****** Object:  StoredProcedure [dbo].[sprocCreateDynamicTrigger]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[sprocCreateDynamicTrigger](@UserID varchar(50),
    @tableName varchar(500),@tableID varchar(50),@Mode char(1),@MaxID varchar(500))
AS
BEGIN

if @Mode='A'
begin
	exec('update ' + @tableName + ' set CreatedBy = ''' + @UserID + ''' where ' + @tableId + '=''' + @MaxID + '''');
end

if @Mode='U'
begin
	exec('update ' + @tableName + ' set UpdatedOn= GETDATE(), UpdatedBy = ''' + @UserID + ''' where ' + @tableId + '=''' + @MaxID + '''');
end
END



GO
/****** Object:  StoredProcedure [dbo].[WorkOrder_GenerateReport]    Script Date: 4/27/2023 5:45:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[WorkOrder_GenerateReport]
	-- Add the parameters for the stored procedure here
	@id nvarchar(50)=null,
	@joborder varchar(255)=null,
	@workorder_no nvarchar(50)=null,
	@fromdate nvarchar(50)=null,
	@todate nvarchar(50)=null,
	@workorder_name nvarchar(MAX)=null,
	@customer nvarchar(550)=null,
	@status int=null,
	@salesperson nvarchar(255)=null,
	@postatus int=null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	

Select usr.Name as 'SalesPerson',cust.cust_No as 'Customer No.',
cust.cust_Name as 'Customer Name',wo.WorkOrderID as 'Order No.',
wo.Date as 'Order Date',jo.Order_Id as 'Item No.',wo.work_po_no as 'PO No.',
jo.Order_Name as 'Description',wo.Quantity,CASE  WHEN ISNUMERIC(dpd.dpd_FGQty)=1 then cast(dpd.dpd_FGQty as decimal) ELSE NULL END as 'Dispatch Quantity',
cast(wo.Quantity as float )- (CASE  WHEN ISNUMERIC(dpd.dpd_FGQty)=1 then cast(dpd.dpd_FGQty as float) ELSE 0 END )as 'Outstanding Quantity',un.Unit
from PMS_WorkOrder wo 
left outer join PMS_JobOrder jo on wo.JobOrderID=jo.ID
left outer join PMS_WorkEntry we on wo.ID=we.Work_WorkOrder
left outer join PMS_Customer cust on wo.CustomerID=cust.cust_Id
left outer join PMS_Users usr on cust.cust_SalesPerson=usr.ID
left outer join PMS_DispatchProDetails dpd on dpd.dpd_WEId=we.ID
left outer join PMS_Units un on wo.Unit=un.ID


where 
(wo.ID like '%'+@id+'%'  or @id is null)
and
(jo.ID = @joborder or @joborder is null)
and
(wo.WorkOrderID like '%'+@workorder_no+'%' or @workorder_no is null)
and
(CASE When LEN(WO.Date)=10 then  convert(datetime,WO.Date,105) else null END between convert(datetime,''+@fromdate+'',105) and convert(datetime,''+@todate+'',105)or (@fromdate is null or @todate is null)) 
and
(wo.WorkOrderID = @workorder_name or @workorder_name is null)
and
(cust.cust_Id = @customer or @customer is null)
and
(wo.Status = @status or @status is null)
and
(usr.ID = @salesperson or @salesperson is null)
and
(wo.POChk = @postatus or @postatus is null)



END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[59] 4[5] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PMS_Excise_Master"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_ProductMaster"
            Begin Extent = 
               Top = 6
               Left = 254
               Bottom = 125
               Right = 420
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "gc"
            Begin Extent = 
               Top = 6
               Left = 458
               Bottom = 125
               Right = 677
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "gcd"
            Begin Extent = 
               Top = 6
               Left = 715
               Bottom = 125
               Right = 909
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "w"
            Begin Extent = 
               Top = 106
               Left = 61
               Bottom = 225
               Right = 264
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "w1"
            Begin Extent = 
               Top = 43
               Left = 746
               Bottom = 249
               Right = 952
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "j"
            Begin Extent = 
               Top = 148
               Left = 361
               Bottom = 267
               Right = 572
            End
            DisplayFlags = 344
          ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Challan_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'  TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 76
               Left = 694
               Bottom = 181
               Right = 918
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cc"
            Begin Extent = 
               Top = 233
               Left = 0
               Bottom = 355
               Right = 168
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "u"
            Begin Extent = 
               Top = 245
               Left = 267
               Bottom = 364
               Right = 427
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "x"
            Begin Extent = 
               Top = 177
               Left = 790
               Bottom = 296
               Right = 950
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "z"
            Begin Extent = 
               Top = 204
               Left = 740
               Bottom = 323
               Right = 900
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "comp"
            Begin Extent = 
               Top = 366
               Left = 38
               Bottom = 485
               Right = 235
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cdl"
            Begin Extent = 
               Top = 366
               Left = 273
               Bottom = 485
               Right = 460
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "usr"
            Begin Extent = 
               Top = 246
               Left = 838
               Bottom = 365
               Right = 998
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 70
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 5955
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2130
         Width = 4635
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width =' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Challan_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane3', @value=N' 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Challan_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=3 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Challan_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 236
               Bottom = 125
               Right = 396
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 434
               Bottom = 125
               Right = 595
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4185
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CityView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CityView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[14] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Cust_SuppView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Cust_SuppView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PMS_Customer"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 262
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_Company"
            Begin Extent = 
               Top = 6
               Left = 300
               Bottom = 125
               Right = 497
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CustomerView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CustomerView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[21] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 3180
         Width = 3615
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CutomerSupplier_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'CutomerSupplier_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[15] 4[4] 2[80] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[56] 4[39] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[79] 2[5] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[56] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PMS_MasterSalesWorkOrderTax"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 121
               Right = 245
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "PMS_Units"
            Begin Extent = 
               Top = 72
               Left = 375
               Bottom = 191
               Right = 535
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "w1"
            Begin Extent = 
               Top = 18
               Left = 393
               Bottom = 171
               Right = 596
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "PMS_MasterTaxStructureDetails"
            Begin Extent = 
               Top = 1
               Left = 684
               Bottom = 105
               Right = 866
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "PMS_MasterTax"
            Begin Extent = 
               Top = 54
               Left = 53
               Bottom = 254
               Right = 225
            End
            DisplayFlags = 344
            TopColumn = 1
         End
         Begin Table = "gc"
            Begin Extent = 
               Top = 47
               Left = 703
               Bottom = 327
               Right = 922
            End
            DisplayFlags = 344
            TopColumn = 20
         End
         Begin Table = "cc"
            Begin Extent = 
               Top = 127
               Left = 470
               Bottom = 282
               Right = 638
            End
  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Gen_ChallanView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'          DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "w"
            Begin Extent = 
               Top = 74
               Left = 168
               Bottom = 335
               Right = 371
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "gcd"
            Begin Extent = 
               Top = 157
               Left = 13
               Bottom = 276
               Right = 207
            End
            DisplayFlags = 344
            TopColumn = 2
         End
         Begin Table = "j"
            Begin Extent = 
               Top = 105
               Left = 720
               Bottom = 300
               Right = 931
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 109
               Left = 45
               Bottom = 402
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 34
         End
         Begin Table = "u"
            Begin Extent = 
               Top = 219
               Left = 431
               Bottom = 408
               Right = 591
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "x"
            Begin Extent = 
               Top = 354
               Left = 38
               Bottom = 473
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "z"
            Begin Extent = 
               Top = 171
               Left = 673
               Bottom = 290
               Right = 833
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "comp"
            Begin Extent = 
               Top = 366
               Left = 236
               Bottom = 485
               Right = 433
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_Company_BankDetails"
            Begin Extent = 
               Top = 366
               Left = 471
               Bottom = 485
               Right = 631
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_Excise_Master"
            Begin Extent = 
               Top = 474
               Left = 38
               Bottom = 593
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_ProductMaster"
            Begin Extent = 
               Top = 474
               Left = 669
               Bottom = 593
               Right = 835
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cdl"
            Begin Extent = 
               Top = 599
               Left = 785
               Bottom = 785
               Right = 972
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "usr"
            Begin Extent = 
               Top = 486
               Left = 479
               Bottom = 605
               Right = 639
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 69
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width =' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Gen_ChallanView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane3', @value=N' 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4575
         Alias = 4080
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Gen_ChallanView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=3 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Gen_ChallanView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[38] 4[12] 2[18] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1[50] 4[25] 3) )"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[43] 2[16] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1[88] 3) )"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4[47] 3) )"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3) )"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4) )"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PMS_Units"
            Begin Extent = 
               Top = 175
               Left = 285
               Bottom = 294
               Right = 445
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "w1"
            Begin Extent = 
               Top = 100
               Left = 19
               Bottom = 283
               Right = 222
            End
            DisplayFlags = 280
            TopColumn = 14
         End
         Begin Table = "PMS_WorkOrder_Tax"
            Begin Extent = 
               Top = 30
               Left = 938
               Bottom = 248
               Right = 1194
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_MasterTax"
            Begin Extent = 
               Top = 6
               Left = 1232
               Bottom = 125
               Right = 1404
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "j"
            Begin Extent = 
               Top = 62
               Left = 498
               Bottom = 181
               Right = 709
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "w"
            Begin Extent = 
               Top = 57
               Left = 15
               Bottom = 374
               Right = 218
            End
            DisplayFlags = 344
            TopColumn = 8
         End
         Begin Table = "cc"
            Begin Extent = 
               Top = 59
               Left = 747
               Bottom = 178
               Right = 915
            End
            DisplayFlags = 280
 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Gen_ChallanView_old'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'           TopColumn = 2
         End
         Begin Table = "gc"
            Begin Extent = 
               Top = 6
               Left = 458
               Bottom = 252
               Right = 677
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "gcd"
            Begin Extent = 
               Top = 326
               Left = 196
               Bottom = 477
               Right = 390
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 399
               Left = 266
               Bottom = 758
               Right = 490
            End
            DisplayFlags = 344
            TopColumn = 41
         End
         Begin Table = "u"
            Begin Extent = 
               Top = 16
               Left = 771
               Bottom = 221
               Right = 931
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "x"
            Begin Extent = 
               Top = 134
               Left = 505
               Bottom = 253
               Right = 665
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "z"
            Begin Extent = 
               Top = 121
               Left = 709
               Bottom = 240
               Right = 869
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "comp"
            Begin Extent = 
               Top = 34
               Left = 436
               Bottom = 291
               Right = 633
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_Company_BankDetails"
            Begin Extent = 
               Top = 98
               Left = 542
               Bottom = 344
               Right = 788
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_Excise_Master"
            Begin Extent = 
               Top = 16
               Left = 0
               Bottom = 135
               Right = 178
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "PMS_ProductMaster"
            Begin Extent = 
               Top = 6
               Left = 254
               Bottom = 125
               Right = 420
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "cdl"
            Begin Extent = 
               Top = 127
               Left = 275
               Bottom = 246
               Right = 462
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "usr"
            Begin Extent = 
               Top = 196
               Left = 721
               Bottom = 315
               Right = 881
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 59
         Width = 284
         Width = 3705
         Width = 13890
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
        ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Gen_ChallanView_old'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane3', @value=N' Width = 1500
         Width = 1500
         Width = 1500
         Width = 1815
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3255
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3195
         Alias = 5025
         Table = 4620
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Gen_ChallanView_old'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=3 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Gen_ChallanView_old'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[78] 4[15] 2[5] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "comp"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 235
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "gc"
            Begin Extent = 
               Top = 22
               Left = 657
               Bottom = 382
               Right = 876
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "gcd"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 232
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "w"
            Begin Extent = 
               Top = 28
               Left = 424
               Bottom = 407
               Right = 627
            End
            DisplayFlags = 280
            TopColumn = 23
         End
         Begin Table = "PMS_MasterTransport"
            Begin Extent = 
               Top = 6
               Left = 273
               Bottom = 125
               Right = 442
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "w1"
            Begin Extent = 
               Top = 69
               Left = 292
               Bottom = 188
               Right = 495
            End
            DisplayFlags = 344
            TopColumn = 25
         End
         Begin Table = "j"
            Begin Extent = 
               Top = 342
               Left = 917
               Bottom = 461
               Right = 1128
            End
            DisplayFlags = 344
            TopC' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Gen_CreateInvoice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'olumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 127
               Left = 536
               Bottom = 477
               Right = 760
            End
            DisplayFlags = 344
            TopColumn = 20
         End
         Begin Table = "cc"
            Begin Extent = 
               Top = 126
               Left = 760
               Bottom = 245
               Right = 928
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "u"
            Begin Extent = 
               Top = 202
               Left = 251
               Bottom = 321
               Right = 411
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "x"
            Begin Extent = 
               Top = 177
               Left = 496
               Bottom = 296
               Right = 656
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "z"
            Begin Extent = 
               Top = 246
               Left = 696
               Bottom = 365
               Right = 856
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_Excise_Master"
            Begin Extent = 
               Top = 366
               Left = 38
               Bottom = 485
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_ProductMaster"
            Begin Extent = 
               Top = 366
               Left = 254
               Bottom = 485
               Right = 420
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cdl"
            Begin Extent = 
               Top = 147
               Left = 251
               Bottom = 380
               Right = 438
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "usr"
            Begin Extent = 
               Top = 366
               Left = 683
               Bottom = 485
               Right = 843
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 58
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
        ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Gen_CreateInvoice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane3', @value=N' Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 4590
         Alias = 2865
         Table = 2175
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Gen_CreateInvoice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=3 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Gen_CreateInvoice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[34] 4[30] 2[13] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PMS_MasterTaxStructure"
            Begin Extent = 
               Top = 5
               Left = 543
               Bottom = 124
               Right = 703
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_MasterSalesWorkOrderTax"
            Begin Extent = 
               Top = 6
               Left = 279
               Bottom = 168
               Right = 486
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_WorkOrder"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 241
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Invoice_TaxView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Invoice_TaxView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[10] 4[24] 2[35] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 24
         Width = 284
         Width = 1005
         Width = 1020
         Width = 975
         Width = 2025
         Width = 1920
         Width = 1515
         Width = 1785
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'misreports'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'misreports'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[10] 4[18] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 24
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'misreports_Export'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'misreports_Export'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -192
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 19
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'misreports1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'misreports1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[33] 4[17] 2[18] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PMS_Units"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_WorkOrder"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 241
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_Customer"
            Begin Extent = 
               Top = 160
               Left = 355
               Bottom = 279
               Right = 579
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "PMS_JobOrder"
            Begin Extent = 
               Top = 289
               Left = 138
               Bottom = 408
               Right = 349
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "PMS_TransportLocation"
            Begin Extent = 
               Top = 111
               Left = 435
               Bottom = 230
               Right = 595
            End
            DisplayFlags = 344
            TopColumn = 0
         End
         Begin Table = "PMS_MasterTransport"
            Begin Extent = 
               Top = 0
               Left = 390
               Bottom = 119
               Right = 559
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_CustomerDeliveryLocation"
            Begin Extent = 
               Top = 140
               Left = 27
               Bottom = 259
             ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PerformaInvoice_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'  Right = 214
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_Company"
            Begin Extent = 
               Top = 86
               Left = 699
               Bottom = 205
               Right = 896
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_Invoice_Master"
            Begin Extent = 
               Top = 408
               Left = 38
               Bottom = 527
               Right = 241
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_GenerateChallan"
            Begin Extent = 
               Top = 528
               Left = 38
               Bottom = 647
               Right = 257
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 59
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PerformaInvoice_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PerformaInvoice_View'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PMS_Category"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 195
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PMS_RMCATVeiw'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PMS_RMCATVeiw'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "rw"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 219
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "unw"
            Begin Extent = 
               Top = 6
               Left = 257
               Bottom = 125
               Right = 417
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "unh"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "unl"
            Begin Extent = 
               Top = 126
               Left = 236
               Bottom = 245
               Right = 396
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "unt"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 365
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 264075
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RMCombined'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RMCombined'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'RMCombined'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 236
               Bottom = 125
               Right = 397
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'StateView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'StateView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[29] 4[33] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SupplierView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SupplierView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[17] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -384
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 16
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SupplierView1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'SupplierView1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[55] 4[23] 2[18] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PMS_RawMaterial"
            Begin Extent = 
               Top = 4
               Left = 687
               Bottom = 172
               Right = 851
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "PMS_JobOrder"
            Begin Extent = 
               Top = 7
               Left = 465
               Bottom = 176
               Right = 656
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_Product"
            Begin Extent = 
               Top = 212
               Left = 588
               Bottom = 391
               Right = 784
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_JobCard_Material_Requirement"
            Begin Extent = 
               Top = 192
               Left = 269
               Bottom = 393
               Right = 490
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "PMS_Units"
            Begin Extent = 
               Top = 199
               Left = 13
               Bottom = 364
               Right = 197
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'= 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[55] 4[20] 2[21] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = -133
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PMS_WorkOrder"
            Begin Extent = 
               Top = 133
               Left = 14
               Bottom = 378
               Right = 243
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_FGEntry"
            Begin Extent = 
               Top = 419
               Left = 295
               Bottom = 610
               Right = 483
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_Units"
            Begin Extent = 
               Top = 8
               Left = 542
               Bottom = 166
               Right = 726
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_JobOrder"
            Begin Extent = 
               Top = 7
               Left = 274
               Bottom = 220
               Right = 512
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "PMS_Customer"
            Begin Extent = 
               Top = 184
               Left = 542
               Bottom = 369
               Right = 794
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_JobOrderProcesses"
            Begin Extent = 
               Top = 400
               Left = 20
               Bottom = 541
               Right = 246
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_Processes"
            Begin Extent = 
               Top = 247
               Left = 297
               Bottom = 388
               Right = 481
  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ManageOpenJob'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'          End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_GenerateChallanDetails"
            Begin Extent = 
               Top = 385
               Left = 709
               Bottom = 595
               Right = 886
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_Invoice_Master"
            Begin Extent = 
               Top = 419
               Left = 494
               Bottom = 622
               Right = 651
            End
            DisplayFlags = 280
            TopColumn = 35
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ManageOpenJob'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_ManageOpenJob'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[59] 4[19] 2[19] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PMS_WorkEntryResources_OutputPro"
            Begin Extent = 
               Top = 143
               Left = 483
               Bottom = 401
               Right = 684
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_Units"
            Begin Extent = 
               Top = 300
               Left = 277
               Bottom = 417
               Right = 453
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_RawMaterial"
            Begin Extent = 
               Top = 0
               Left = 475
               Bottom = 121
               Right = 628
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_Machines"
            Begin Extent = 
               Top = 18
               Left = 15
               Bottom = 143
               Right = 169
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_WorkEntry"
            Begin Extent = 
               Top = 28
               Left = 233
               Bottom = 254
               Right = 429
            End
            DisplayFlags = 280
            TopColumn = 11
         End
         Begin Table = "PMS_JobOrder"
            Begin Extent = 
               Top = 186
               Left = 15
               Bottom = 349
               Right = 164
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_Users"
            Begin Extent = 
               Top = 54
               Left = 717
               Bottom = 195
               Right =' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_OLD_ProductionREPORT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' 901
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_OLD_ProductionREPORT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_OLD_ProductionREPORT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[66] 4[13] 2[19] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PMS_WorkEntry"
            Begin Extent = 
               Top = 1
               Left = 227
               Bottom = 276
               Right = 430
            End
            DisplayFlags = 280
            TopColumn = 9
         End
         Begin Table = "PMS_Machines"
            Begin Extent = 
               Top = 8
               Left = 13
               Bottom = 149
               Right = 197
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_JobOrder"
            Begin Extent = 
               Top = 6
               Left = 477
               Bottom = 176
               Right = 666
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_RawMaterial"
            Begin Extent = 
               Top = 10
               Left = 695
               Bottom = 227
               Right = 900
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_JobCard_Material_Requirement"
            Begin Extent = 
               Top = 285
               Left = 252
               Bottom = 495
               Right = 473
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "PMS_Units"
            Begin Extent = 
               Top = 161
               Left = 8
               Bottom = 342
               Right = 192
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidt' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Production'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'hs = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Production'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Production'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "PMS_Invoice_Master"
            Begin Extent = 
               Top = 0
               Left = 52
               Bottom = 245
               Right = 281
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_TaxDetails"
            Begin Extent = 
               Top = 0
               Left = 335
               Bottom = 246
               Right = 531
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PMS_WorkOrder_Tax"
            Begin Extent = 
               Top = 7
               Left = 565
               Bottom = 263
               Right = 795
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 924
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Sales%20Report'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_Sales%20Report'
GO
