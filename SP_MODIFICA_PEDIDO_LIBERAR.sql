USE [DWH]
GO
/****** Object:  StoredProcedure [dbo].[SP_MODIFICA_PEDIDO_LIBERAR]    Script Date: 09/03/2022 05:38:43 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Catalogo Almacenes
ALTER procedure [dbo].[SP_MODIFICA_PEDIDO_LIBERAR]

@Usuario_Alta    AS varchar(200),
@Pedido          AS varchar(200)

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
      FROM [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA] AS PEDIDOS
     WHERE EXISTS (SELECT * 
	                 FROM [dbo].[INTERFAZ_CFDI_CATALOGO_RUTAS] AS RUTAS 
	                WHERE PEDIDOS.DESTINO = RUTAS.NUMBER AND RUTAS.Logistica=0  ) 
      AND documento = @Pedido

-- Envia Pedidos para Atencion de Logistica
	 
INSERT INTO [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA_LOGISTICA]
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
      FROM [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA] AS PEDIDOS
     WHERE EXISTS (SELECT * FROM [dbo].[INTERFAZ_CFDI_CATALOGO_RUTAS] AS RUTAS WHERE PEDIDOS.DESTINO = RUTAS.NUMBER AND RUTAS.Logistica=1  ) 
	   AND documento = @Pedido
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
      FROM [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA] 
	 WHERE documento = @Pedido


	 	 
-- Elimina el registro pre-liberado

    DELETE INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA
	 WHERE documento = @Pedido


-- Elimina los articulos cuya cantidad sea cero, por que almancen no lo va surtir

DELETE [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI] WHERE CAST(unidad_base AS FLOAT) = 0
DELETE [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA_LOGISTICA] WHERE CAST(unidad_base AS FLOAT) = 0


UPDATE dbo.INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA_LOGISTICA
   SET ESTATUS_PEDIDO = 0
 WHERE ESTATUS_PEDIDO IS NULL

END