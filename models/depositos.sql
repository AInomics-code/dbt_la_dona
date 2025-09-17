{{ config(materialized='table') }}

select
	codigo_de_deposito as deposito_id,
	nombre_de_deposito as nombre
from {{ source('raw', 'depositos') }}