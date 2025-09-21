{{ config(materialized='table') }}

select
	FECHA as fecha,
	[TIPO DE TRANSACCION] as tipo,
	CANTIDAD as cantidad,
	PRECIO as precio_unitario,
	COSTO as costo,
	[CODIGO DE CLIENTE] as cliente_id,
	[CODIGO DE PRODUCTO] as producto_id,
	(
		CASE 
            WHEN [TIPO DE TRANSACCION] = 'FACTURA' 
                 THEN [IMPORTE DE LA LINEA] - [DESCUENTO DE LA LINEA]
            ELSE 0
        END
	) as total_bruto,
	(
		CASE 
            WHEN [TIPO DE TRANSACCION] = 'FACTURA' 
                 THEN [IMPORTE DE LA LINEA] - [DESCUENTO DE LA LINEA]
            WHEN [TIPO DE TRANSACCION] = 'NOTA DE CREDITO' 
                 AND [ES GASTO] = 'NO'
                 THEN -([IMPORTE DE LA LINEA] - [DESCUENTO DE LA LINEA])
            ELSE 0
        END
	) as total_neto
from AINOMICS.dbo.VENTAS as v
LEFT JOIN AINOMICS.dbo.[MOTIVO DE DEVOLUCION] as md
    ON md.[CODIGO DE MOTIVO DE DEVOLUCION] = v.[CODIGO DE MOTIVO DE DEVOLUCION]