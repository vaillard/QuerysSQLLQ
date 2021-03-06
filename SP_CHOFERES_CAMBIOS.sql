USE [DWH]
GO
/****** Object:  StoredProcedure [dbo].[SP_CHOFERES_CAMBIOS]    Script Date: 05/03/2022 06:20:09 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Catalogo Usuarios
ALTER procedure [dbo].[SP_CHOFERES_CAMBIOS]

@Nochofer  			AS varchar(200),
@Nombres			AS varchar(200),
@Apaterno			AS varchar(200),
@Amaterno			AS varchar(200),
@RFC				AS varchar(200),
@NoSeguro			AS varchar(200),
@TipoLicencia		AS varchar(200),
@NoLicencia         AS varchar(200),
@Vigencia			AS varchar(200),
@Estatus			AS varchar(200),
@Usuario_Alta       AS varchar(200)

AS
BEGIN

-- Actualiza información

UPDATE [dbo].[INTERFAZ_CFDI_CATALOGO_DE_CHOFERES]
   SET [NOMBRE (S)]					=   @Nombres,
       [APELLIDO PATERNO ]			=   @Apaterno,
	   [APELLIDO MATERNO]			=	@Amaterno,
	   [RFC]						=	@RFC,
	   [NUMERO DE SEGURO SOCIAL ]	=	@NoSeguro,
	   [TIPO LICENCIA ]				=	@TipoLicencia,
       [NUMERO DE LICENCIA ]		=	@NoLicencia,
       [VIGENCIA]					=	@Vigencia,
       [USUARIO_MODIFICA]           =   @Usuario_Alta,
       [ESTATUS]                    =   @Estatus, 
	   [FECHA_MODIFICA]             =   GETDATE()
 WHERE LTRIM(RTRIM(chofer)) = LTRIM(RTRIM(@Nochofer)) 

------ Guarda Registros Historicos

--INSERT INTO [dbo].[INTERFAZ_WEB_USUARIOS_HIST]
--       (
--	   FOLIO,
--	   USUARIO,
--       CONTRASENA,
--	   NOMBRE,
--	   APELLIDO_PATERNO,
--	   APELLIDO_MATERNO,
--	   AREA,
--	   TIPO_USUARIO,
--	   ESTATUS,
--	   USUARIO_ALTA,
--	   FECHA_ALTA,
--	   USUARIO_MODIFICA,
--	   FECHA_MODIFICA
--	   )
--SELECT FOLIO,
--       USUARIO,
--       CONTRASENA,
--	   NOMBRE,
--	   APELLIDO_PATERNO,
--	   APELLIDO_MATERNO,
--	   AREA,
--	   TIPO_USUARIO,
--	   ESTATUS,
--	   USUARIO_ALTA,
--	   FECHA_ALTA,
--	   USUARIO_MODIFICA,
--	   FECHA_MODIFICA
--  FROM [dbo].[INTERFAZ_WEB_USUARIOS] WITH (NOLOCK)
-- WHERE USUARIO = @USUARIO




 
END