{{ config(
    materialized='table',
    pre_hook="{{ drop_backup_relation() }}"
) }}

select
    productos_por_deposito."CODIGO DE PRODUCTO" as product_id,
    productos_por_deposito."EXISTENCIA" as inventory_qty,
    productos_por_deposito."CODIGO DE DEPOSITO" as location_id
from client_data.dbo."PRODUCTOS POR DEPOSITO" as productos_por_deposito