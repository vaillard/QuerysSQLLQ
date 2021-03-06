USE [DWH]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAMIONETAS_CAMBIOS]    Script Date: 05/03/2022 04:59:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Catalogo Almacenes
ALTER procedure [dbo].[SP_CAMIONETAS_CAMBIOS]

@Unidad           AS varchar(200),
@Modelo           AS varchar(200),
@Placas           AS varchar(200),
@Marca            AS varchar(200),
@Vigencia         AS varchar(200),
@Vigencia1        AS varchar(200),
@NoSeguro         AS varchar(200),
@Tarjeta          AS varchar(200),
@Expedida         AS varchar(200),
@Aseguradora      AS varchar(200),
@Operador         AS varchar(200),
@Ruta1            AS varchar(200),
@Ruta2            AS varchar(200),
@Ruta3            AS varchar(200),
@Ruta4            AS varchar(200),
@Ruta5            AS varchar(200),
@Estatus          AS varchar(200),
@Usuario_Modifica AS varchar(200)
AS
BEGIN


-- Limpia Tabla de Paso

TRUNCATE TABLE DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO]


INSERT DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO]
         (  
	     [unidad] 
		,[modelo]
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
		,ESTATUS
		,USUARIO_MODIFICA
		,[FECHA_MODIFICA]
       )
VALUES
		(   
		    @unidad          , 
			@Modelo          ,
			@Placas          ,
			@Marca           ,
			@Vigencia        ,
			@NoSeguro        ,
			@Tarjeta         ,
			@Aseguradora     ,
			@Operador        ,
			@Expedida        ,
			@Vigencia1       ,
			@Ruta1           ,
			@Ruta2           ,
			@Ruta3           ,
			@Ruta4           ,
			@Ruta5           ,
			@ESTATUS         ,
			UPPER(@Usuario_Modifica),
			GETDATE()
 		)       

-- Actualiza las rutas

UPDATE DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO]
   SET DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[ruta asignada 1 Real] = DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_RUTAS].ID
  FROM DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_RUTAS]
 WHERE DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[ruta asignada 1] = DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_RUTAS].[Cost Center]

UPDATE DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO]
   SET DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[ruta asignada 2 Real] = DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_RUTAS].ID
  FROM DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_RUTAS]
 WHERE DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[ruta asignada 2] = DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_RUTAS].[Cost Center]

 UPDATE DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO]
   SET DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[ruta asignada 3 Real] = DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_RUTAS].ID
  FROM DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_RUTAS]
 WHERE DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[ruta asignada 3] = DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_RUTAS].[Cost Center]

UPDATE DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO]
   SET DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[ruta asignada 4 Real] = DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_RUTAS].ID
  FROM DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_RUTAS]
 WHERE DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[ruta asignada 4] = DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_RUTAS].[Cost Center]

UPDATE DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO]
   SET DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[ruta asignada 5 Real] = DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_RUTAS].ID
  FROM DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_RUTAS]
 WHERE DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[ruta asignada 5] = DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_RUTAS].[Cost Center]

--  Actualiza los operadores
 
UPDATE DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO]
   SET DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[operador 1 Real] = DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CHOFERES].Chofer
  FROM DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CHOFERES]
 WHERE LTRIM(RTRIM(DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[operador 1])) = LTRIM(RTRIM(DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CHOFERES].[APELLIDO PATERNO] +
                                                                          ' ' +
																		  DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CHOFERES].[APELLIDO MATERNO] +
																		  ' ' +
																		  DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CHOFERES].[NOMBRE (S)])) 


-- Actualiza el estatus

 UPDATE DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO]
    SET [ESTATUS Real] = 1
  WHERE LTRIM(RTRIM([ESTATUS]))='ALTA'

  
 UPDATE DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO]
    SET [ESTATUS Real] = 0
  WHERE LTRIM(RTRIM([ESTATUS]))<>'ALTA'


-- Actualiza informacion el la base de datos fuente


UPDATE DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA]
   SET DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].modelo             = DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].MODELO,
       DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].PLACAS             = DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].PLACAS,
	   DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].VIGENCIA           = DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].VIGENCIA,
	   DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].vigencia1          = DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].vigencia1,
	   DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].aseguradora          = DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].aseguradora,
	   DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].[numero de seguro] = DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[numero de seguro],
	   DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].[operador 1]       = DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[operador 1 Real],
	   DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].expedida           = DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].expedida,
	   DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].[ruta asignada 1]  = DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[ruta asignada 1 Real],
	   DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].[ruta asignada 2]  = DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[ruta asignada 2 Real],
	   DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].[ruta asignada 3]  = DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[ruta asignada 3 Real],
	   DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].[ruta asignada 4]  = DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[ruta asignada 4 Real],
	   DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].[ruta asignada 5]  = DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[ruta asignada 5 Real],
	   DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].marca              = DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].marca,
	   DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].[tarjeta de circulacion] = DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[tarjeta de circulacion],
	   DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].ESTATUS  = DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[ESTATUS Real],
	   DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].[USUARIO_MODIFICA]  = DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[USUARIO_MODIFICA],
	   DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].[FECHA_MODIFICA]  = DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].[FECHA_MODIFICA]
  FROM DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO]
 WHERE DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO].Unidad = DWH.[dbo].[INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA].Unidad



--SELECT * FROM DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO]
--SELECT * FROM [dbo].[INTERFAZ_CFDI_CATALOGO_DE_CHOFERES]
END