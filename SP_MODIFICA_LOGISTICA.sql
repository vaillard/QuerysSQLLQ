USE [DWH]
GO
/****** Object:  StoredProcedure [dbo].[SP_MODIFICA_LOGISTICA]    Script Date: 11/03/2022 05:55:34 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Catalogo Almacenes
ALTER procedure [dbo].[SP_MODIFICA_LOGISTICA]

@PEDIDO          AS varchar(200),
@USUARIO_ALTA    AS varchar(200),
@UNIDAD          AS varchar(200),
@OPERADOR        AS varchar(200),
@DESTINO         AS varchar(200)

AS
BEGIN


--	SE LIMPIA TABLA DE ASIGNACION DE OPERADOR

TRUNCATE TABLE [dbo].[INTERFAZ_WEB_REASIGNACION_LOGISTICA]

-- Inserta la informacion en la tabla de control

INSERT INTO [dbo].[INTERFAZ_WEB_REASIGNACION_LOGISTICA]
  (
    PEDIDO,
	OPERADOR,
	UNIDAD,
	USUARIO_ALTA,
	FECHA_ALTA,
	DESTINO
  )
  VALUES
  (
    @PEDIDO,
	@OPERADOR,
	@UNIDAD,
	@USUARIO_ALTA,
	GETDATE(),
	@DESTINO
  )
  



-- Revisa que ninguna unidad tenga asignada la ruta de cambio de unidad

 
 UPDATE dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA
    SET [ruta asignada 1]=0
  WHERE [ruta asignada 1]=14

 UPDATE dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA
    SET [ruta asignada 2]=0
  WHERE [ruta asignada 2]=14

   UPDATE dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA
    SET [ruta asignada 3]=0
  WHERE [ruta asignada 3]=14

   UPDATE dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA
    SET [ruta asignada 4]=0
  WHERE [ruta asignada 4]=14

   UPDATE dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA
    SET [ruta asignada 5]=0
  WHERE [ruta asignada 5]=14

    
   -- En el caso de que la camioneta seleccionada tenga ocupadas todas las rutas. entonces la ultima ruta detectada se cambiaria por la actual
   
   UPDATE dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA
      SET [ruta asignada 5] = 14,
	      USUARIO_MODIFICA  = @USUARIO_ALTA,
		  FECHA_MODIFICA    = GETDATE()
     FROM [dbo].[INTERFAZ_WEB_REASIGNACION_LOGISTICA]
    WHERE [dbo].[INTERFAZ_WEB_REASIGNACION_LOGISTICA].UNIDAD = dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA.Unidad
      AND [ruta asignada 1]<>14 AND [ruta asignada 1]<>0 
	  AND [ruta asignada 2]<>14 AND [ruta asignada 2]<>0
	  AND [ruta asignada 3]<>14 AND [ruta asignada 3]<>0
	  AND [ruta asignada 4]<>14 AND [ruta asignada 4]<>0

  -- Busca la camioneta qie se le asigno la ruta

   UPDATE dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA
      SET [ruta asignada 1] = 14,
	      USUARIO_MODIFICA  = @USUARIO_ALTA,
		  FECHA_MODIFICA    = GETDATE()
     FROM [dbo].[INTERFAZ_WEB_REASIGNACION_LOGISTICA]
    WHERE [dbo].[INTERFAZ_WEB_REASIGNACION_LOGISTICA].UNIDAD = dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA.Unidad
      AND [ruta asignada 1] = 0  
   
   UPDATE dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA
      SET [ruta asignada 2] = 14,
	      USUARIO_MODIFICA  = @USUARIO_ALTA,
		  FECHA_MODIFICA    = GETDATE()
     FROM [dbo].[INTERFAZ_WEB_REASIGNACION_LOGISTICA]
    WHERE [dbo].[INTERFAZ_WEB_REASIGNACION_LOGISTICA].UNIDAD = dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA.Unidad
      AND [ruta asignada 2] = 0  

   UPDATE dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA
      SET [ruta asignada 3] = 14,
	      USUARIO_MODIFICA  = @USUARIO_ALTA,
		  FECHA_MODIFICA    = GETDATE()
     FROM [dbo].[INTERFAZ_WEB_REASIGNACION_LOGISTICA]
    WHERE [dbo].[INTERFAZ_WEB_REASIGNACION_LOGISTICA].UNIDAD = dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA.Unidad
      AND [ruta asignada 3] = 0  
	  
   UPDATE dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA
      SET [ruta asignada 4] = 14,
	      USUARIO_MODIFICA  = @USUARIO_ALTA,
		  FECHA_MODIFICA    = GETDATE()
     FROM [dbo].[INTERFAZ_WEB_REASIGNACION_LOGISTICA]
    WHERE [dbo].[INTERFAZ_WEB_REASIGNACION_LOGISTICA].UNIDAD = dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA.Unidad
      AND [ruta asignada 4] = 0  
	  
   UPDATE dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA
      SET [ruta asignada 5] = 14,
	      USUARIO_MODIFICA  = @USUARIO_ALTA,
		  FECHA_MODIFICA    = GETDATE()
     FROM [dbo].[INTERFAZ_WEB_REASIGNACION_LOGISTICA]
    WHERE [dbo].[INTERFAZ_WEB_REASIGNACION_LOGISTICA].UNIDAD = dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA.Unidad
      AND [ruta asignada 5] = 0  

-- Reasigna Operador a la camioneta

   UPDATE DBO.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA 
      SET DBO.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA.[operador 1] =  [dbo].[INTERFAZ_WEB_REASIGNACION_LOGISTICA].OPERADOR ,
	      USUARIO_MODIFICA  = @USUARIO_ALTA,
		  FECHA_MODIFICA    = GETDATE()
     FROM [dbo].[INTERFAZ_WEB_REASIGNACION_LOGISTICA]
    WHERE DBO.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA.Unidad  =  [dbo].[INTERFAZ_WEB_REASIGNACION_LOGISTICA].UNIDAD




 
END