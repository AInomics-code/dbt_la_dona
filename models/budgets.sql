{{ config(
    materialized='table',
    pre_hook="{{ drop_backup_relation() }}"
) }}

select
    CAST(
        CAST(presupuesto_por_cliente.anio AS VARCHAR(4)) || '-' ||
        RIGHT('0' || CAST(presupuesto_por_cliente.MES AS VARCHAR(2)), 2) || '-01'
        AS DATE
    ) AS date,
   presupuesto_por_cliente."PRESUPUESTO" as budget,
    presupuesto_por_cliente.codigo_de_cliente as client_id,clientes."CODIGO DE CLIENTE" as client_code, 
    clientes."NOMBRE DE CLIENTE" as client_name
from client_data.dbo.presupuesto_por_cliente as presupuesto_por_cliente
inner join client_data.dbo."CLIENTES" as clientes
    on presupuesto_por_cliente.codigo_de_cliente = clientes."CODIGO DE CLIENTE" and clientes._fivetran_deleted = false
where presupuesto_por_cliente._fivetran_deleted = false