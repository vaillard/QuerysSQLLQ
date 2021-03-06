USE [DWH]
GO
/****** Object:  StoredProcedure [dbo].[SP_CHOFERES_ALTA]    Script Date: 05/03/2022 06:19:52 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Catalogo Choferes

ALTER procedure [dbo].[SP_CHOFERES_ALTA]

@Nombres          AS varchar(50),
@Apaterno         AS varchar(50),
@Amaterno         AS varchar(50),
@RFC              AS varchar(50),
@Vigencia         AS varchar(50),
@NoSeguro         AS varchar(50),
@TipoLicencia     AS varchar(50),
@NoLicencia       AS varchar(50),
@USUARIO_ALTA     AS varchar(200)

AS
BEGIN

INSERT [dbo].[INTERFAZ_CFDI_CATALOGO_DE_CHOFERES] 
      (
	   [NOMBRE (S)]
      ,[APELLIDO MATERNO]
	  ,[APELLIDO PATERNO ]
      ,[RFC]
	  ,[Vigencia]
	  ,[NUMERO DE LICENCIA ]
	  ,[NUMERO DE SEGURO SOCIAL ]
	  ,[TIPO LICENCIA ]
	  ,[USUARIO_ALTA]
	  ,[FECHA_ALTA]
	  ,[ESTATUS]
       )
VALUES
		(
		 UPPER(@Nombres) 
		,UPPER(@Apaterno)
		,UPPER(@Amaterno)
		,UPPER(@RFC)
		,@Vigencia
		,UPPER(@NoLicencia)
		,UPPER(@NoSeguro)
		,UPPER(@TipoLicencia) 
		,@USUARIO_ALTA
		,GETDATE()
		,1
 		)       


--  Asigna el consecutivo chofer con el numero mas alto

UPDATE [dbo].[INTERFAZ_CFDI_CATALOGO_DE_CHOFERES]
   SET [dbo].[INTERFAZ_CFDI_CATALOGO_DE_CHOFERES].chofer = FOLIO.NCHOFER 
  FROM (SELECT MAX(CAST(CHOFER AS FLOAT))+1 AS NCHOFER FROM [dbo].[INTERFAZ_CFDI_CATALOGO_DE_CHOFERES] ) AS FOLIO
 WHERE CHOFER IS NULL



-- Inserta información al Historico

INSERT INTO [dbo].[INTERFAZ_WEB_CATALOGO_DE_CHOFERES_HIST]
     (
      [chofer],
      [NOMBRE (S)],
	  [APELLIDO PATERNO ],
      [APELLIDO MATERNO],
      [RFC],
      [TIPO LICENCIA ],
      [NUMERO DE LICENCIA ],
      [ESTATUS],
      [VIGENCIA],
      [USUARIO_ALTA],
      [FECHA_ALTA]
	 )
      SELECT  [chofer],
			  [NOMBRE (S)],
			  [APELLIDO PATERNO ],
			  [APELLIDO MATERNO],
			  [RFC],
			  [TIPO LICENCIA ],
			  [NUMERO DE LICENCIA ],
			  [ESTATUS],
			  [VIGENCIA],
			  [USUARIO_ALTA],
			  [FECHA_ALTA]
	FROM [dbo].[INTERFAZ_CFDI_CATALOGO_DE_CHOFERES]
	WHERE  [chofer] = (SELECT MAX(CHOFER) FROM [dbo].[INTERFAZ_CFDI_CATALOGO_DE_CHOFERES])

END