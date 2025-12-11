{{ config(
    materialized='table',
    pre_hook="{{ drop_backup_relation() }}"
) }}

select
    ventas."FECHA" as date,
    'SALE' as transaction_type,
    ventas."CODIGO DE PRODUCTO" as product_id,
    ventas."PRECIO" as unit_price,
    ventas."CANTIDAD" as quantity,
    ventas."COSTO" as unit_cost,
    (
		CASE 
            WHEN ventas."TIPO DE TRANSACCION" = 'FACTURA' 
                 THEN ventas."IMPORTE DE LA LINEA" - ventas."DESCUENTO DE LA LINEA"
            ELSE 0
        END
	) as gross_amount,
	(
		CASE 
            WHEN ventas."TIPO DE TRANSACCION" = 'FACTURA' 
                 THEN ventas."IMPORTE DE LA LINEA" - ventas."DESCUENTO DE LA LINEA"
            WHEN ventas."TIPO DE TRANSACCION" = 'NOTA DE CREDITO' 
                 AND motivos_de_devolucion."ES GASTO" = 'NO'
                 THEN -(ventas."IMPORTE DE LA LINEA" - ventas."DESCUENTO DE LA LINEA")
            ELSE 0
        END
	) as net_amount,
    ventas."CANTIDAD" as discount_amount,
    ventas."CODIGO DE CLIENTE" as client_id,
    vendedores."NOMBRE DE VENDEDOR" as seller_name
from client_data.dbo."VENTAS" as ventas
left join client_data.dbo."VENDEDORES" as vendedores
    on vendedores."CODIGO DE VENDEDOR" = ventas."CODIGO DE VENDEDOR"
left join client_data.dbo."MOTIVO DE DEVOLUCION" as motivos_de_devolucion
    on lower(motivos_de_devolucion."CODIGO DE MOTIVO DE DEVOLUCION") = lower(ventas."CODIGO DE MOTIVO DE DEVOLUCION")