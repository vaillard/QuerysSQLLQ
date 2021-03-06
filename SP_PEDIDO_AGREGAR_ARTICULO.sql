USE [DWH]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAMIONETAS_ALTA]    Script Date: 11/03/2022 01:20:31 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Catalogo Almacenes
ALTER PROCEDURE [dbo].[SP_PEDIDO_AGREGAR_ARTICULO]

@Pedido          AS varchar(200),
@Articulo        AS varchar(200),
@UnidadEmbarque  AS varchar(200),
@Usuario_Alta    AS varchar(200),
@Cantidad        AS float

AS
BEGIN

-- Limpia la tabla 

TRUNCATE TABLE [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO]

-- Inserta información

INSERT [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO]
       (
         documento,
		 descripcion_del_articulo,
		 unidad_embarque,
		 FECHA_ALTA,
		 TIPO_MOVIMIENTO,
		 USUARIO_ALTA,
		 cantidad,
		 unidad_base
       )
VALUES
		(
			@Pedido        ,
			@Articulo      ,
			@UnidadEmbarque,
			GETDATE(),
			'Alta Articulos',
			@Usuario_Alta,
			@Cantidad,
			@Cantidad
 		)       

-- Completa la información restante del pedido

     UPDATE [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO]
	    SET [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO].origen              =  [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA].origen,
		    [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO].destino             =  [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA].destino, 
			[dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO].fecha               =  [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA].fecha,
			[dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO].informacion_general =  [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA].informacion_general,
			[dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO].referencia          =  [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA].referencia,
			[dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO].posicion            =  [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA].posicion,
			[dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO].id_del_articulo     =  [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA].id_del_articulo, 
			[dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO].id_de_la_unidad     =  [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA].id_de_la_unidad,
			[dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO].consecutivo	       =  [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA].consecutivo,
			[dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO].archivo	           =  [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA].archivo, 
			[dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO].precio              =  0
	   FROM [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA]
      WHERE [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA].documento =  [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO].documento 
   
   -- Actualiza la info del articulo

   UPDATE [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO]
      SET [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO].[#_del_articulo] = [dbo].[INTERFAZ_PEDIDOS_CATALOGO_ARTICULOS_LPQ].[Codigo ID],
	      [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO].precio = [dbo].[INTERFAZ_PEDIDOS_CATALOGO_ARTICULOS_LPQ].precio,
	      [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO].unidad = [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO].unidad_embarque,
		  [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO].estatus_pedido  =0
     FROM [dbo].[INTERFAZ_PEDIDOS_CATALOGO_ARTICULOS_LPQ]
    WHERE [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO].descripcion_del_articulo = [dbo].[INTERFAZ_PEDIDOS_CATALOGO_ARTICULOS_LPQ].Producto 



-- Agrega el articulo nuevo a la lista de articulos

INSERT INTO [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA]
SELECT * FROM [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO]


select * from [dbo].[INTERFAZ_PEDIDOS_MICROS_CFDI_ALTA_ARTICULO]

END