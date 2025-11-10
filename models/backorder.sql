{{ config(
    materialized='table',
    pre_hook="{{ drop_backup_relation() }}"
) }}

select
    backorder.fecha_de_factura as date,
    backorder.numero_de_pedido as order_id,
    backorder.codigo_de_deposito as location_id,
    backorder.codigo_de_cliente as client_id,
    vendedores.nombre_de_vendedor as seller_name,
    backorder.codigo_de_producto as product_id,
    backorder.fecha_de_factura as expected_delivery_date,
    backorder.fecha_de_factura as actual_delivery_date,
    0 as days_delayed,
    backorder.cantidad_pedida as order_qty,
    backorder.cantidad_entregada as delivery_qty,
    backorder.cantidad_pendiente as backorder_qty,
    backorder.precio as unit_price
from {{ source('raw', 'backorder') }}
left join client_data.src_ladona.vendedores
    on vendedores.codigo_de_vendedor = backorder.codigo_de_vendedor