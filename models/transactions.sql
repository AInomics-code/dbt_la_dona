{{ config(
    materialized='table',
    pre_hook="{{ drop_backup_relation() }}"
) }}

select
    ventas."FECHA" as date,
    'SALE' as transaction_type,
    ventas."TIPO DE TRANSACCION" as transaction_type_raw,
    ventas."CODIGO DE DEPOSITO" as location_id,
    ventas."CODIGO DE PRODUCTO" as product_id,
    ventas."PRECIO" as unit_price,
    ventas."CANTIDAD" as quantity,
    ventas."COSTO" as unit_cost,
    ventas."COSTO DE LA LINEA" as total_cost,
    ventas."IMPORTE DE LA LINEA" as line_amount,
    ventas."DESCUENTO DE LA LINEA" as line_discount,
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
    vendedores."CODIGO DE VENDEDOR" as seller_code,
    vendedores."NOMBRE DE VENDEDOR" as seller_name,
    provincias_vendedor."CODIGO DE PROVINCIA" as seller_province_code,
    provincias_vendedor."NOMBRE DE PROVINCIA" as seller_province_name
from client_data.dbo."VENTAS" as ventas
left join client_data.dbo."VENDEDORES" as vendedores
    on vendedores."CODIGO DE VENDEDOR" = ventas."CODIGO DE VENDEDOR"
left join client_data.dbo."PROVINCIAS" as provincias_vendedor
    on provincias_vendedor."CODIGO DE PROVINCIA" = vendedores."CODIGO DE PROVINCIA"
left join client_data.dbo."MOTIVO DE DEVOLUCION" as motivos_de_devolucion
    on lower(motivos_de_devolucion."CODIGO DE MOTIVO DE DEVOLUCION") = lower(ventas."CODIGO DE MOTIVO DE DEVOLUCION")