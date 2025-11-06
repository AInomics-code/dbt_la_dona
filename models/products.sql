{{ config(
    materialized='table',
    pre_hook="{{ drop_backup_relation() }}"
) }}

select
    productos.codigo_de_producto as product_id,
    productos.nombre_del_producto as product_name,
    productos.codigo_de_barra as code,
    (productos.estado = 'ACTIVO') as state,
    productos.marca as brand,
    tipos.nombre_de_tipo as category,
    clases.nombre_de_clase as subcategory,
    productos.unidad_de_medida as measure,
    (productos.maquila = 'SI') as outsourced
from {{ source('raw', 'productos') }}
left join client_data.src_ladona.tipos
	on tipos.codigo_de_tipo = productos.codigo_de_tipo
left join client_data.src_ladona.clases
	on clases.codigo_de_clase = productos.codigo_de_clase