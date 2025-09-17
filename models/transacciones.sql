{{ config(materialized='table') }}

select
	fecha,
	tipo_de_transaccion as tipo,
	cantidad,
	precio as precio_unitario,
	costo,
	codigo_de_cliente as cliente_id,
	codigo_de_producto as producto_id,
	(
		CASE 
            WHEN [tipo_de_transaccion] = 'FACTURA' 
                 THEN [importe_de_la_linea] - [descuento_de_la_linea]
            ELSE 0
        END
	) as total_bruto,
	(
		CASE 
            WHEN [tipo_de_transaccion] = 'FACTURA' 
                 THEN [importe_de_la_linea] - [descuento_de_la_linea]
            WHEN [tipo_de_transaccion] = 'NOTA DE CREDITO' 
                 AND md.[es_gasto] = 'NO'
                 THEN -([importe_de_la_linea] - [descuento_de_la_linea])
            ELSE 0
        END
	) as total_neto
from {{ source('raw', 'ventas') }} as v
LEFT JOIN {{ source('raw', 'motivo_de_devolucion') }} as md
    ON md.codigo_de_motivo_de_devolucion = v.codigo_de_motivo_de_devolucion