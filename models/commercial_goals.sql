{{ config(
    materialized='table',
    pre_hook="{{ drop_backup_relation() }}"
) }}

select
    make_date(
        pp."AÑO"::int,
        case upper(pp."MES")
            when 'ENERO' then 1
            when 'FEBRERO' then 2
            when 'MARZO' then 3
            when 'ABRIL' then 4
            when 'MAYO' then 5
            when 'JUNIO' then 6
            when 'JULIO' then 7
            when 'AGOSTO' then 8
            when 'SEPTIEMBRE' then 9
            when 'OCTUBRE' then 10
            when 'NOVIEMBRE' then 11
            when 'DICIEMBRE' then 12
        end,
        1
    ) as date,
    pp."PRESUPUESTO" as goal,
    v."CODIGO DE VENDEDOR" as commercial_id,
    v."NOMBRE DE VENDEDOR" as commercial_name,
    c."CODIGO DE CLASE" as client_group_code,
    c."NOMBRE DE CLASE" as client_group
from dbo."PRESUPUESTO POR VENDEDORES CLASE" pp
inner join dbo."VENDEDORES" v
    on v."CODIGO DE VENDEDOR" = pp."CODIGO DE VENDEDOR" and v._fivetran_deleted = false
inner join dbo."CLASES" c
    on c."CODIGO DE CLASE" = pp."CODIGO DE CLASE" and c._fivetran_deleted = false
where pp._fivetran_deleted = false
