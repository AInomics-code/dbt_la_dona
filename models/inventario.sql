{{ config(materialized='table') }}

select
	[CODIGO DE PRODUCTO] as producto_id,
	[CODIGO DE DEPOSITO] as deposito_id,
	EXISTENCIA as cantidad
from AINOMICS.dbo.[PRODUCTOS POR DEPOSITO]