{{ config(
    materialized='table',
    pre_hook="{{ drop_backup_relation() }}"
) }}

select
    backorder."FECHA DE PEDIDO" as date,
    backorder."NUMERO DE PEDIDO" as order_id,
    backorder."CODIGO DE DEPOSITO" as location_id,
    backorder."CODIGO DE CLIENTE" as client_id,
    vendedores."CODIGO DE VENDEDOR" as seller_code,
    vendedores."NOMBRE DE VENDEDOR" as seller_name,
    provincias_vendedor."CODIGO DE PROVINCIA" as seller_province_code,
    provincias_vendedor."NOMBRE DE PROVINCIA" as seller_province_name,
    backorder."CODIGO DE PRODUCTO" as product_id,
    backorder."FECHA DE PEDIDO" as expected_delivery_date,
    backorder."FECHA DE PEDIDO" as actual_delivery_date,
    0 as days_delayed,
    backorder."CANTIDAD PEDIDA" as order_qty,
    backorder."CANTIDAD ENTREGADA" as delivery_qty,
    backorder."CANTIDAD PENDIENTE" as backorder_qty,
    backorder."PRECIO" as unit_price,
    backorder."VENTA" as total
from client_data.dbo."BACKORDER" AS backorder
left join client_data.dbo."VENDEDORES" AS vendedores
    on vendedores."CODIGO DE VENDEDOR" = backorder."CODIGO DE VENDEDOR" and vendedores._fivetran_deleted = false
left join client_data.dbo."PROVINCIAS" as provincias_vendedor
    on provincias_vendedor."CODIGO DE PROVINCIA" = vendedores."CODIGO DE PROVINCIA" and provincias_vendedor._fivetran_deleted = false
where backorder._fivetran_deleted = false