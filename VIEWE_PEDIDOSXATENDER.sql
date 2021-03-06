USE [DWH]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAMIONETAS_ALTA]    Script Date: 06/03/2022 10:20:38 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Catalogo Almacenes
ALTER procedure [dbo].[SP_PEDIDO_LIBERAR]

@Pedido          AS varchar(200),
@Usuario_Alta    AS varchar(200)

AS
BEGIN

-- Actualiza el estatus del pedido

UPDATE [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA]
   SET ESTATUS_PEDIDO = 1,
       USUARIO_ANTENDIO = @Usuario_Alta,
	   FECHA_ATENCION = GETDATE()
 WHERE RTRIM(LTRIM(documento)) = RTRIM(LTRIM(@Pedido))

 -- Envia el pedido para la generacion de los CFDI
 
 --INSERT INTO [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI]

 --SELECT 
 --documento,	
 --   origen,
	--destino,
	--fecha,
	--informacion_general,
	--referencia,
	--posicion,
	--id_del_articulo,
	--id_de_la_unidad,
	--cantidad,	
	--unidad_base,
	--Descripcion_del_articulo,
	--#_del_articulo,
	--unidad,
	--unidad_embarque,
	--consecutivo,
	--almacen,
	--[codigo id],
	--[iva %],	
	--precio,	
	--archivo,
	--FECHA_ALTA
	--FROM [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI]

 --SELECT * FROM [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA]
END