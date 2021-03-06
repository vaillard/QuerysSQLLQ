USE [DWH]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAMIONETAS_ALTA]    Script Date: 05/03/2022 05:59:07 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Catalogo Almacenes
ALTER procedure [dbo].[SP_CAMIONETAS_ALTA]

@Modelo          AS varchar(200),
@Placas          AS varchar(200),
@Marca           AS varchar(200),
@Tarjeta         AS varchar(200),
@Vigencia        AS varchar(200),
@Expedida        AS varchar(200),
@NoSeguro        AS varchar(200),
@Aseguradora     AS varchar(200),
@Operador        AS varchar(200),
@Ruta1           AS varchar(200),
@Ruta2           AS varchar(200),
@Ruta3           AS varchar(200),
@Ruta4           AS varchar(200),
@Ruta5           AS varchar(200),
@Usuario_Alta    AS varchar(200)

AS
BEGIN

INSERT [dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA] 
      (
         [modelo]
		,[placas]
		,[marca]
		,[vigencia]
		,[numero de seguro]
		,[tarjeta de circulacion]
		,[aseguradora]
		,[operador 1]
		,[expedida]
        ,[vigencia1]
		,[ruta asignada 1]
		,[ruta asignada 2]
		,[ruta asignada 3]
		,[ruta asignada 4]
		,[ruta asignada 5]
		,[USUARIO_ALTA]
		,[FECHA_ALTA]
       )
VALUES
		(
			@Modelo          ,
			@Placas          ,
			@Marca           ,
			@Vigencia        ,
			@NoSeguro        ,
			@Tarjeta         ,
			@Aseguradora     ,
			@Operador       ,
			@Expedida        ,
			@Vigencia        ,
			@Ruta1   ,
			@Ruta2   ,
			@Ruta3   ,
			@Ruta4   ,
			@Ruta5   ,
			@Usuario_Alta ,
			GETDATE()
 		)       

-- Asigna consecutivo
		
UPDATE  [dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA]
  SET  [dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].Unidad  = FOLIO.NUnidad,
       [dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].[operador 2] = 0,
	   [dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].[operador 3] = 0,
	   [dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].[operador 4] = 0
FROM (SELECT MAX(CAST(Unidad AS FLOAT))+1 AS NUnidad FROM [dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA] ) AS FOLIO
WHERE Unidad  IS NULL


END