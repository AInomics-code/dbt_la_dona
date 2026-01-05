{{ config(
    materialized='table',
    pre_hook="{{ drop_backup_relation() }}"
) }}

select
    productos."CODIGO DE PRODUCTO" as product_id,
    productos."NOMBRE DE PRODUCTO" as product_name,
    productos."CODIGO DE BARRA" as code,
    (productos."ESTADO" = 'ACTIVO') as state,
    productos."MARCA" as brand,
    productos."CODIGO DE TIPO" as category_code,
    tipos."NOMBRE DE TIPO" as category,
    productos."CODIGO DE CLASE" as subcategory_code,
    clases."NOMBRE DE CLASE" as subcategory,
    productos."UNIDAD DE MEDIDA" as measure,
    (productos."MAQUILA" = 'SI') as outsourced
from client_data.dbo."PRODUCTOS" as productos
left join client_data.dbo."TIPOS" as tipos
	on tipos."CODIGO DE TIPO" = productos."CODIGO DE TIPO"
left join client_data.dbo."CLASES" as clases
	on clases."CODIGO DE CLASE" = productos."CODIGO DE CLASE"
where productos._fivetran_deleted = false
    and tipos._fivetran_deleted = false
    and clases._fivetran_deleted = false