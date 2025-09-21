{{ config(materialized='table') }}

select
	[CODIGO DE DEPOSITO] as deposito_id,
	[NOMBRE DE DEPOSITO] as nombre
from AINOMICS.dbo.DEPOSITOS