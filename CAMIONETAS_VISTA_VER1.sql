

SELECT        CAMIONETAS.FOLIO AS UNIDAD, CAMIONETAS.placas, CAMIONETAS.vigencia, CAMIONETAS.[numero de seguro] AS NoSEGURO, CAMIONETAS.aseguradora, CAMIONETAS.expedida, CAMIONETAS.vigencia1, 
                         CAMIONETAS.marca, CAMIONETAS.modelo, CAMIONETAS.[tarjeta de circulacion] AS TARJETA_CIRCULACION, R1.RUTA1, R2.RUTA2, R3.RUTA3, R4.RUTA4, R5.RUTA5, R6.CHOFER, 
                         (CASE WHEN CAMIONETAS.estatus = 1 THEN 'ALTA' ELSE 'BAJA' END) AS ESTATUS
FROM            dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA AS CAMIONETAS LEFT OUTER JOIN
                             (SELECT        CAMIONETAS.FOLIO, RUTAS.[Cost Center] AS RUTA1
                               FROM            dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA AS CAMIONETAS INNER JOIN
                                                         dbo.INTERFAZ_CFDI_CATALOGO_RUTAS AS RUTAS ON CAMIONETAS.[ruta asignada 1] = RUTAS.ID) AS R1 ON CAMIONETAS.FOLIO = R1.FOLIO LEFT OUTER JOIN
                             (SELECT        CAMIONETAS.FOLIO, RUTAS.[Cost Center]  AS RUTA2
                               FROM            dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA AS CAMIONETAS INNER JOIN
                                                         dbo.INTERFAZ_CFDI_CATALOGO_RUTAS AS RUTAS ON CAMIONETAS.[ruta asignada 2] = RUTAS.ID) AS R2 ON CAMIONETAS.FOLIO = R2.FOLIO LEFT OUTER JOIN
                             (SELECT        CAMIONETAS.FOLIO, RUTAS.[Cost Center] AS RUTA3
                               FROM            dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA AS CAMIONETAS INNER JOIN
                                                         dbo.INTERFAZ_CFDI_CATALOGO_RUTAS AS RUTAS ON CAMIONETAS.[ruta asignada 3] = RUTAS.ID) AS R3 ON CAMIONETAS.FOLIO = R3.FOLIO LEFT OUTER JOIN
                             (SELECT        CAMIONETAS.FOLIO, RUTAS.[Cost Center]  AS RUTA4
                               FROM            dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA AS CAMIONETAS INNER JOIN
                                                         dbo.INTERFAZ_CFDI_CATALOGO_RUTAS AS RUTAS ON CAMIONETAS.[ruta asignada 4] = RUTAS.ID) AS R4 ON CAMIONETAS.FOLIO = R4.FOLIO LEFT OUTER JOIN
                             (SELECT        CAMIONETAS.FOLIO, RUTAS.[Cost Center]  AS RUTA5
                               FROM            dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA AS CAMIONETAS INNER JOIN
                                                         dbo.INTERFAZ_CFDI_CATALOGO_RUTAS AS RUTAS ON CAMIONETAS.[ruta asignada 5] = RUTAS.ID) AS R5 ON CAMIONETAS.FOLIO = R5.FOLIO LEFT OUTER JOIN
                             (SELECT        CAMIONETAS.FOLIO, CHOFERES.[APELLIDO PATERNO ] + ' ' + CHOFERES.[APELLIDO MATERNO] + ' ' + CHOFERES.[NOMBRE (S)] AS CHOFER
                               FROM            dbo.INTERFAZ_CFDI_CATALOGO_DE_CAMIONETA AS CAMIONETAS INNER JOIN
                                                         dbo.INTERFAZ_CFDI_CATALOGO_DE_CHOFERES AS CHOFERES ON CAMIONETAS.[operador 1] = CHOFERES.chofer) AS R6 ON CAMIONETAS.FOLIO = R6.FOLIO