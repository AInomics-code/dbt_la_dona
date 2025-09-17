{{ config(materialized='table') }}

select
    CAST(
        CAST(anio AS VARCHAR(4)) + '-' +
            RIGHT('0' + CAST(
                CASE MES
                    WHEN 'ENERO' THEN 1
                    WHEN 'FEBRERO' THEN 2
                    WHEN 'MARZO' THEN 3
                    WHEN 'ABRIL' THEN 4
                    WHEN 'MAYO' THEN 5
                    WHEN 'JUNIO' THEN 6
                    WHEN 'JULIO' THEN 7
                    WHEN 'AGOSTO' THEN 8
                    WHEN 'SEPTIEMBRE' THEN 9
                    WHEN 'OCTUBRE' THEN 10
                    WHEN 'NOVIEMBRE' THEN 11
                    WHEN 'DICIEMBRE' THEN 12
                END
            AS VARCHAR(2)), 2) + '-01'
        AS DATE
    ) AS fecha,
    presupuesto,
    clientes.codigo_de_cliente as cliente_id,
    clientes.nombre_de_cliente as cliente_nombre
from {{ source('raw', 'export_all') }}
inner join {{ source('raw', 'clientes') }} on export_all.codigo_de_cliente = clientes.codigo_de_cliente