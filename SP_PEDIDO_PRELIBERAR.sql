USE [DWH]
GO
/****** Object:  StoredProcedure [dbo].[SP_PEDIDO_PRELIBERAR]    Script Date: 07/03/2022 06:37:27 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Catalogo Almacenes
ALTER procedure [dbo].[SP_PEDIDO_PRELIBERAR]

@Pedido          AS varchar(200),
@Usuario_Alta    AS varchar(200)

AS
BEGIN

INSERT INTO [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PRELIBERA]
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
		   ESTATUS_PEDIDO,
		   USUARIO_ANTENDIO,
		   FECHA_ATENCION,
		   ELIMINA_ARTICULO,
		   USUARIO_ELIMINACION,
		   FECHA_ELIMINACION,
		   CAMBIO_CANTIDAD,
		   CANTIDAD_NUEVA,
		   USUARIO_CAMBIO_CANTIDAD,
		   FECHA_CAMBIO_CANTIDAD,
		   DIAS_PARA_ENTREGA
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
		   ESTATUS_PEDIDO,
		   @Usuario_Alta AS USUARIO_ANTENDIO,
		   GETDATE() AS FECHA_ATENCION,
		   ELIMINA_ARTICULO,
		   USUARIO_ELIMINACION,
		   FECHA_ELIMINACION,
		   CAMBIO_CANTIDAD,
		   CANTIDAD_NUEVA,
		   USUARIO_CAMBIO_CANTIDAD,
		   FECHA_CAMBIO_CANTIDAD,
		   DIAS_PARA_ENTREGA
      FROM [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA]
     WHERE LTRIM(RTRIM(DOCUMENTO)) = LTRIM(RTRIM(@Pedido))

-- Elimina el registro pre-liberado

    DELETE [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA]
     WHERE LTRIM(RTRIM(DOCUMENTO)) = LTRIM(RTRIM(@Pedido))


END