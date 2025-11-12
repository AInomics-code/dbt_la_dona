{{ config(
    materialized='table',
    pre_hook="{{ drop_backup_relation() }}"
) }}

select
    ventas.fecha as date,
    'SALE' as transaction_type,
    ventas.codigo_de_producto as product_id,
    ventas.precio as unit_price,
    ventas.cantidad as quantity,
    ventas.costo as unit_cost,
    (
		CASE 
            WHEN ventas.tipo_de_transaccion = 'FACTURA' 
                 THEN ventas.importe_de_la_linea - ventas.descuento_de_la_linea
            ELSE 0
        END
	) as gross_amount,
	(
		CASE 
            WHEN ventas.tipo_de_transaccion = 'FACTURA' 
                 THEN ventas.importe_de_la_linea - ventas.descuento_de_la_linea
            WHEN ventas.tipo_de_transaccion = 'NOTA DE CREDITO' 
                 AND motivos_de_devolucion.es_gasto = 'NO'
                 THEN -(ventas.importe_de_la_linea - ventas.descuento_de_la_linea)
            ELSE 0
        END
	) as net_amount,
    ventas.cantidad as discount_amount,
    ventas.codigo_de_cliente as client_id,
    vendedores.nombre_de_vendedor as seller_name
from {{ source('raw', 'ventas') }}
left join client_data.src_ladona.vendedores
    on vendedores.codigo_de_vendedor = ventas.codigo_de_vendedor
left join client_data.src_ladona.motivos_de_devolucion
    on lower(motivos_de_devolucion.codigo_de_motivo_de_devolucion) = lower(ventas.codigo_de_motivo_de_devolucion)