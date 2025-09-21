{{ config(materialized='table') }}

select
	[FECHA DE PEDIDO] as fecha,
	[CODIGO DE CLIENTE] as cliente_id,
	[CODIGO DE PRODUCTO] as producto_id,
	[CODIGO DE DEPOSITO] as deposito_id,
	[CANTIDAD PENDIENTE]  as cantidad,
	COSTO as costo
from AINOMICS.dbo.BACKORDER