{{ config(
    materialized='table',
    pre_hook="{{ drop_backup_relation() }}"
) }}

select
    estado_cuenta."CODIGO DE CLIENTE" as client_id,
    estado_cuenta."DOCUMENTO" as document_number,
    estado_cuenta."FECHA DE VENCIMIENTO" as due_date,
    estado_cuenta."SALDO DEL DOCUMENTO" as balance,
    (CURRENT_DATE - estado_cuenta."FECHA DE VENCIMIENTO"::date) as days_overdue,
    CASE 
        WHEN (CURRENT_DATE - estado_cuenta."FECHA DE VENCIMIENTO"::date) > 120 THEN 'OVERDUE_120+'
        WHEN (CURRENT_DATE - estado_cuenta."FECHA DE VENCIMIENTO"::date) > 90 THEN 'OVERDUE_90'
        WHEN (CURRENT_DATE - estado_cuenta."FECHA DE VENCIMIENTO"::date) > 60 THEN 'OVERDUE_60'
        WHEN (CURRENT_DATE - estado_cuenta."FECHA DE VENCIMIENTO"::date) > 30 THEN 'OVERDUE_30'
        WHEN (CURRENT_DATE - estado_cuenta."FECHA DE VENCIMIENTO"::date) > 0 THEN 'OVERDUE'
        ELSE 'CURRENT'
    END as aging_bucket
from client_data.dbo."ESTADO DE CUENTA DE CLIENTES" as estado_cuenta
where estado_cuenta."SALDO DEL DOCUMENTO" > 0
