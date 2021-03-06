
SELECT  REPORTE.documento, 
        REPORTE.Fecha_Pedido, 
		REPORTE.Fecha_Actual, 
		REPORTE.Dias_Para_Entrega, 
		REPORTE.DESTINO, 
		REPORTE.No_Articulos, 
		INTEGRA.Unidad, 
		INTEGRA.placas, 
		INTEGRA.NoOPERADOR, 
        INTEGRA.NOMBRE
  FROM    (
     SELECT DISTINCT 
	        PEDIDO.documento, SUBSTRING(PEDIDO.fecha, 1, 4) + '-' + SUBSTRING(PEDIDO.fecha, 5, 2) + '-' + SUBSTRING(PEDIDO.fecha, 7, 2) AS Fecha_Pedido, CONVERT(char(10), GETDATE(), 126) AS Fecha_Actual, 
    	DATEDIFF(DAY, GETDATE(), CAST(SUBSTRING(PEDIDO.fecha, 1, 4) + '-' + SUBSTRING(PEDIDO.fecha, 5, 2) + '-' + SUBSTRING(PEDIDO.fecha, 7, 2) AS DATE)) AS Dias_Para_Entrega, UPPER(ALMACEN.[Cost Center]) 
	AS DESTINO, COUNT(PEDIDO.documento) AS No_Articulos
FROM            dbo.INTERFAZ_PEDIDOS_MICROS_CFDI_PREPARA_LOGISTICA AS PEDIDO INNER JOIN
	dbo.INTERFAZ_CFDI_CATALOGO_ALMACENES AS ALMACEN ON PEDIDO.destino = ALMACEN.Number
WHERE        (PEDIDO.ESTATUS_PEDIDO = 0)
GROUP BY PEDIDO.documento, SUBSTRING(PEDIDO.fecha, 1, 4) + '-' + SUBSTRING(PEDIDO.fecha, 5, 2) + '-' + SUBSTRING(PEDIDO.fecha, 7, 2), DATEDIFF(DAY, GETDATE(), CAST(SUBSTRING(PEDIDO.fecha, 1, 4) 
	+ '-' + SUBSTRING(PEDIDO.fecha, 5, 2) + '-' + SUBSTRING(PEDIDO.fecha, 7, 2) AS DATE)), UPPER(ALMACEN.[Cost Center])) AS REPORTE INNER JOIN
(SELECT        UNIDAD.Unidad, UNIDAD.placas, UNIDAD.RUTA AS NoRUTA, UPPER(RUTA.[Cost Center]) AS RUTA, UNIDAD.OPERADOR AS NoOPERADOR, 
			OPERADOR.[APELLIDO PATERNO ] + ' ' + OPERADOR.[APELLIDO MATERNO] + ' ' + OPERADOR.[NOMBRE (S)] AS NOMBRE
FROM            (SELECT        Unidad, placas, [ruta asignada 1] AS RUTA, [operador 1] AS OPERADOR
			FROM            dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA
			WHERE        ([ruta asignada 1] IS NOT NULL)
			UNION
			SELECT        Unidad, placas, [ruta asignada 2] AS RUTA, [operador 1] AS OPERADOR
			FROM            dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA AS INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA_4
			WHERE        ([ruta asignada 2] IS NOT NULL)
			UNION
			SELECT        Unidad, placas, [ruta asignada 3] AS RUTA, [operador 1] AS OPERADOR
			FROM            dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA AS INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA_3
			WHERE        ([ruta asignada 3] IS NOT NULL)
			UNION
			SELECT        Unidad, placas, [ruta asignada 4] AS RUTA, [operador 1] AS OPERADOR
			FROM            dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA AS INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA_2
			WHERE        ([ruta asignada 4] IS NOT NULL)
			UNION
			SELECT        Unidad, placas, [ruta asignada 5] AS RUTA, [operador 1] AS OPERADOR
			FROM            dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA AS INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA_1
			WHERE        ([ruta asignada 5] IS NOT NULL)) AS UNIDAD LEFT OUTER JOIN
			dbo.INTERFAZ_CFDI_CATALOGO_RUTAS AS RUTA ON RUTA.ID = UNIDAD.RUTA LEFT OUTER JOIN
			dbo.INTERFAZ_CFDI_CATALOGO_DE_CHOFERES AS OPERADOR ON OPERADOR.chofer = UNIDAD.OPERADOR) AS INTEGRA ON INTEGRA.RUTA = REPORTE.DESTINO

	