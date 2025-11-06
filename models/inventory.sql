{{ config(
    materialized='table',
    pre_hook="{{ drop_backup_relation() }}"
) }}

select
    codigo_de_producto as product_id,
    existencia as inventory_qty,
    codigo_de_deposito as location_id
from {{ source('raw', 'productos_por_deposito') }}