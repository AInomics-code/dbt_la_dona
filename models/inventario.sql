{{ config(materialized='table') }}

select
	codigo_de_producto as producto_id,
	codigo_de_deposito as deposito_id,
	existencia as cantidad
from {{ source('raw', 'productos_por_deposito') }}