USE [DWH]
GO
/****** Object:  StoredProcedure [dbo].[SP_USUARIOS_ALTA]    Script Date: 07/03/2022 08:08:41 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Catalogo Usuarios
ALTER procedure [dbo].[SP_MODIFICA_ARTICULO_PEDIDO]


@USUARIO_ALTA  AS varchar(200),
@PEDIDO        AS varchar(200),
@CANTIDAD      AS varchar(200),
@ARTICULO      AS varchar(200)


AS
BEGIN

UPDATE [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA]
   SET unidad_base =  @CANTIDAD,
       USUARIO_CAMBIO_CANTIDAD = @CANTIDAD ,
	   FECHA_CAMBIO_CANTIDAD = GETDATE()
 WHERE documento = @PEDIDO 
   AND descripcion_del_articulo = @ARTICULO 

-- SELECT * FROM [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA]

 
END