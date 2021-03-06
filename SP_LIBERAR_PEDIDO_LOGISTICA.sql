USE [DWH]
GO
/****** Object:  StoredProcedure [dbo].[SP_PEDIDO_LIBERAR_CAMBIOS]    Script Date: 11/03/2022 06:47:28 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Catalogo Almacenes
CREATE procedure [dbo].[SP_LIBERAR_PEDIDO_LOGISTICA]

@USUARIO_ALTA    AS varchar(200),
@PEDIDO          AS varchar(200)

AS
BEGIN

-- Envia sin enviarlos a logistica

INSERT INTO [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI]
          (
           documento,
	       origen,
		   destino,
		   fecha,
		   informacion_general,
		   referencia,
		   posicion,
		   id_del_articulo,
		   id_de_la_unidad,
		   cantidad,
		   unidad_base,
		   descripcion_del_articulo,
		   #_del_articulo,
		   unidad,
		   unidad_embarque,
		   consecutivo,
		   almacen,
		   [codigo id],
		   [iva %],
		   precio,
		   archivo,
		   FECHA_ALTA
      )

    SELECT documento,
	       origen,
		   destino,
		   fecha,
		   informacion_general,
		   referencia,
		   posicion,
		   id_del_articulo,
		   id_de_la_unidad,
		   cantidad,
		   unidad_base,
		   descripcion_del_articulo,
		   #_del_articulo,
		   unidad,
		   unidad_embarque,
		   consecutivo,
		   almacen,
		   [codigo id],
		   [iva %],
		   precio,
		   archivo,
		   FECHA_ALTA
      FROM [DWH].[dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA_LOGISTICA] AS PEDIDOS
  
	 -- Envia Información a la tabla historica
	 
INSERT INTO [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_HISTORICO]
          (
           documento,
	       origen,
		   destino,
		   fecha,
		   informacion_general,
		   referencia,
		   posicion,
		   id_del_articulo,
		   id_de_la_unidad,
		   cantidad,
		   unidad_base,
		   descripcion_del_articulo,
		   #_del_articulo,
		   unidad,
		   unidad_embarque,
		   consecutivo,
		   almacen,
		   [codigo id],
		   [iva %],
		   precio,
		   archivo,
		   FECHA_ALTA,
		   [USUARIO_ANTENDIO],
		   FECHA_ATENCION
      )

    SELECT documento,
	       origen,
		   destino,
		   fecha,
		   informacion_general,
		   referencia,
		   posicion,
		   id_del_articulo,
		   id_de_la_unidad,
		   cantidad,
		   unidad_base,
		   descripcion_del_articulo,
		   #_del_articulo,
		   unidad,
		   unidad_embarque,
		   consecutivo,
		   almacen,
		   [codigo id],
		   [iva %],
		   precio,
		   archivo,
		   FECHA_ALTA,
		   @Usuario_Alta,
		   GETDATE()
      FROM [DWH].[dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA_LOGISTICA]
	  WHERE documento = @PEDIDO


	 	 
-- Elimina el registro pre-liberado

    DELETE [DWH].[dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA_LOGISTICA]
	 WHERE documento = @PEDIDO


END