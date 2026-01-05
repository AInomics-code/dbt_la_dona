{{ config(
    materialized='table',
    pre_hook="{{ drop_backup_relation() }}"
) }}

select
    CAST(
        CAST(anio AS VARCHAR(4)) || '-' ||
        RIGHT('0' || CAST(MES AS VARCHAR(2)), 2) || '-01'
        AS DATE
    ) AS date,
    "PRESUPUESTO" as budget,
    codigo_de_cliente as client_id,
    "NOMBRE DE CLIENTE" as client_name
from client_data.dbo.presupuesto_por_cliente
inner join client_data.dbo.clientes
    on presupuesto_por_cliente.codigo_de_cliente = clientes.id