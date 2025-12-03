USE servicios_calidad;


-- A) ¿Que industrias contratan mas servicios ?--

SELECT industria, COUNT(*) AS cantidad_clientes
FROM clientes
GROUP BY industria
ORDER BY cantidad_clientes DESC;

-- B)  ¿Qué servicio tiene el mayor costo base? --

SELECT tipo_servicio, costo_base
FROM servicios
ORDER BY costo_base DESC
LIMIT 1;

-- C) ¿Cuántos empleados hay por rol?--

SELECT rol, COUNT(*) AS cantidad_empleados
FROM empleados
GROUP BY rol;

-- D) ¿Cual es el presupuesto por provincia? --

SELECT provincia, SUM(presupuesto) AS total_presupuesto
FROM departamentos
GROUP BY provincia
ORDER BY total_presupuesto DESC;

-- E) Top de 5 mas facturados (por monto total) -- 

SELECT s.tipo_servicio, SUM(f.monto_total) AS total_facturado
FROM facturas f
JOIN ordenes_servicio o ON f.id_orden = o.id_orden
JOIN servicios s ON o.id_servicio = s.id_servicio
GROUP BY s.tipo_servicio
ORDER BY total_facturado DESC
LIMIT 5;

-- F) Cantidad de órdenes por mes y total acumulado (1) Fecha de solicitud y/o (2) fecha de ejecucion (3) verificar los null -- 

-- F.1 Fecha de solicitud --
SELECT 
    MONTHNAME(fecha_solicitud) AS mes,
    COUNT(*) AS cantidad_ordenes,
    SUM(COUNT(*)) OVER (ORDER BY MONTH(fecha_solicitud)) AS total_acumulado
FROM ordenes_servicio
GROUP BY MONTH(fecha_solicitud), MONTHNAME(fecha_solicitud)
ORDER BY MONTH(fecha_solicitud);


-- F.2 Fecha de ejecucion -- 


SELECT 
    mes,
    cantidad_ordenes,
    SUM(cantidad_ordenes) OVER (ORDER BY orden_mes) AS total_acumulado
FROM (
    SELECT 
        IFNULL(MONTHNAME(fecha_ejecucion), 'SIN FECHA') AS mes,
        COUNT(*) AS cantidad_ordenes,
        CASE 
            WHEN fecha_ejecucion IS NULL THEN 13 
            ELSE MONTH(fecha_ejecucion) 
        END AS orden_mes
    FROM ordenes_servicio
    GROUP BY 
        IFNULL(MONTHNAME(fecha_ejecucion), 'SIN FECHA'),
        CASE 
            WHEN fecha_ejecucion IS NULL THEN 13 
            ELSE MONTH(fecha_ejecucion) 
        END
) AS sub
ORDER BY orden_mes;

-- F.3 verificar las ordenes sin fecha de ejecucion -- 
SELECT * FROM ordenes_servicio WHERE fecha_ejecucion IS NULL;

SELECT 
    id_orden,
    IFNULL(DATE_FORMAT(fecha_ejecucion, '%Y-%m-%d'), 'SIN FECHA') AS fecha_ejecucion_legible
FROM ordenes_servicio;


-- G) Promedio, mínimo y máximo facturado por cliente -- 

SELECT 
    c.nombre AS nombre_cliente,
    COUNT(f.id_factura) AS cantidad_facturas,
    MIN(f.monto_total) AS minimo,
    MAX(f.monto_total) AS maximo,
    AVG(f.monto_total) AS promedio
FROM clientes c
JOIN ordenes_servicio o ON c.id_cliente = o.id_cliente
JOIN facturas f ON o.id_orden = f.id_orden
GROUP BY c.nombre;

-- H) Cantidad de inspecciones por empleado + ranking -- 

SELECT 
    e.nombre AS nombre_empleado,
    COUNT(i.id_inspeccion) AS cantidad_inspecciones,
    ROW_NUMBER() OVER (ORDER BY COUNT(i.id_inspeccion) DESC, e.nombre ASC) AS ranking
FROM empleados e
JOIN inspecciones i ON e.id_empleado = i.id_empleado
GROUP BY e.id_empleado, e.nombre;


-- I) Total de órdenes gestionadas por departamento --  

SELECT 
    d.nombre_departamento,
    COUNT(o.id_orden) AS total_ordenes
FROM departamentos d
JOIN empleados e ON d.id_departamento = e.id_departamento
JOIN inspecciones i ON e.id_empleado = i.id_empleado
JOIN ordenes_servicio o ON i.id_orden = o.id_orden
GROUP BY d.nombre_departamento;

-- J) SP -- 

DELIMITER //

CREATE PROCEDURE sp_resumen_ordenes_servicio()
BEGIN
    SELECT 
        IFNULL(MONTHNAME(fecha_ejecucion), 'SIN FECHA') AS mes,
        COUNT(*) AS cantidad_ordenes,
        SUM(COUNT(*)) OVER (
            ORDER BY 
                CASE 
                    WHEN fecha_ejecucion IS NULL THEN 13 
                    ELSE MONTH(fecha_ejecucion) 
                END
        ) AS total_acumulado
    FROM ordenes_servicio
    GROUP BY 
        CASE 
            WHEN fecha_ejecucion IS NULL THEN 13 
            ELSE MONTH(fecha_ejecucion) 
        END,
        IFNULL(MONTHNAME(fecha_ejecucion), 'SIN FECHA')
    ORDER BY 
        CASE 
            WHEN fecha_ejecucion IS NULL THEN 13 
            ELSE MONTH(fecha_ejecucion) 
        END;
END //

DELIMITER ;


CALL sp_resumen_ordenes_servicio();

SET GLOBAL event_scheduler = ON;

-- K) Cree un evento, para que la query lanze en el minuto de intervalo las ordenes del mes de manera de ejemplo para verificar su funcionamiento -- 

CREATE EVENT IF NOT EXISTS evento_resumen_ordenes
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 MINUTE
DO
CALL sp_resumen_ordenes_servicio();

SHOW EVENTS;

CALL sp_resumen_ordenes_servicio();

