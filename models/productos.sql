{{ config(materialized='table') }}

select
    codigo_de_producto as producto_id,
    nombre_de_producto as nombre,
    estado,
    costo,
    marca
from {{ source('raw', 'productos') }}