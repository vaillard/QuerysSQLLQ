USE [DWH]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAMIONETAS_CAMBIOS]    Script Date: 05/03/2022 04:53:35 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Catalogo Almacenes
ALTER procedure [dbo].[SP_CAMIONETAS_CAMBIOS]


@Folio           AS varchar(50),
@Unidad          AS varchar(50),
@Modelo          AS varchar(50),
@Placas          AS varchar(50),
@Marca           AS varchar(50),
@Tarjeta         AS varchar(50),
@Vigencia        AS varchar(50),
@Expedida        AS varchar(50),
@NoSeguro        AS varchar(50),
@Aseguradora     AS varchar(50),
@Operador        AS varchar(50),
@Ruta1           AS varchar(50),
@Ruta2           AS varchar(50),
@Ruta3           AS varchar(50),
@Ruta4           AS varchar(50),
@Ruta5           AS varchar(50)

AS
BEGIN


INSERT DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO]
         (  
	     [unidad] 
       )
VALUES
		(   
		    @unidad          
 		)       



--SELECT * FROM DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO]

--INSERT DWH.[dbo].[INTERFAZ_WEB_CATALOGO_DE_CAMIONETA_PASO]
--         (  
--	     [unidad] 
--        ,[modelo]
--		,[placas]
--		,[marca]
--		,[vigencia]
--		,[numero de seguro]
--		,[tarjeta de circulacion]
--		,[aseguradora]
--		,[operador 1]
--		,[expedida]
--        ,[vigencia1]
--		,[ruta asignada 1]
--		,[ruta asignada 2]
--		,[ruta asignada 3]
--		,[ruta asignada 4]
--		,[ruta asignada 5]
		
--       )
--VALUES
--		(   
--		    @unidad          ,
--			@Modelo          ,
--			@Placas          ,
--			@Marca           ,
--			@Vigencia        ,
--			@NoSeguro        ,
--			@Tarjeta         ,
--			@Aseguradora     ,
--			@Operador        ,
--			@Expedida        ,
--			@Vigencia        ,
--			@Ruta1           ,
--			@Ruta2           ,
--			@Ruta3           ,
--			@Ruta4           ,
--			@Ruta5   
-- 		)       

END