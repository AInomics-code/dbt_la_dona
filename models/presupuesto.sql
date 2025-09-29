{{ config(materialized='table') }}

select
    CAST(
        CAST(anio AS VARCHAR(4)) + '-' +
        RIGHT('0' + CAST(MES AS VARCHAR(2)), 2) + '-01'
        AS DATE
    ) AS fecha,
    PRESUPUESTO as presupuesto,
    clientes.[CODIGO DE CLIENTE] as cliente_id,
    clientes.[NOMBRE DE CLIENTE] as cliente_nombre
from AINOMICS.dbo.presupuesto_por_cliente
inner join AINOMICS.dbo.CLIENTES as clientes on presupuesto_por_cliente.codigo_de_cliente = clientes.[CODIGO DE CLIENTE]
where MES BETWEEN 1 AND 12 