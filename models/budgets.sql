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
    presupuesto as budget,
    codigo_de_cliente as customer_id
from {{ source('raw', 'presupuesto_por_cliente') }}