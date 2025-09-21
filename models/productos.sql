{{ config(materialized='table') }}

select
    [CODIGO DE PRODUCTO]  as producto_id,
    [NOMBRE DE PRODUCTO]  as nombre,
    ESTADO as estado,
    COSTO as costo,
    MARCA as marca
from AINOMICS.dbo.PRODUCTOS