{{ config(
    materialized='table',
    pre_hook="{{ drop_backup_relation() }}"
) }}

select
    productos_por_deposito."CODIGO DE PRODUCTO" as product_id,
    productos_por_deposito."EXISTENCIA" as inventory_qty,
    depositos."CODIGO DE DEPOSITO" as location_id,
    depositos."NOMBRE DE DEPOSITO" as location_name,
    depositos."CIUDAD" as city
from client_data.dbo."PRODUCTOS POR DEPOSITO" as productos_por_deposito
inner join client_data.dbo."DEPOSITOS" as depositos
    on depositos."CODIGO DE DEPOSITO" = productos_por_deposito."CODIGO DE DEPOSITO" and depositos._fivetran_deleted = false
where productos_por_deposito._fivetran_deleted = false