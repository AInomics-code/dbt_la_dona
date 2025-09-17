{{ config(materialized='table') }}

select
	fecha_de_pedido as fecha,
	codigo_de_cliente as cliente_id,
	codigo_de_producto as producto_id,
	codigo_de_deposito as deposito_id,
	cantidad_pendiente  as cantidad,
	costo
from {{ source('raw', 'backorder') }}