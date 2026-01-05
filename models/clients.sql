{{ config(
    materialized='table',
    pre_hook="{{ drop_backup_relation() }}"
) }}

select
    clientes."CODIGO DE CLIENTE" as client_id,
    clientes."NOMBRE DE CLIENTE" as client_name,
    clientes."CODIGO DE GRUPO" as client_group_code,
    grupos."NOMBRE DE GRUPO" as client_group,
    clientes."PAIS" as country,
    clientes."CODIGO DE PROVINCIA" as state_code,
    provincias."NOMBRE DE PROVINCIA" as state,
    clientes."CODIGO DE DISTRITO" as district_code,
    clientes."CIUDAD" as city,
    distritos."NOMBRE DE DISTRITO" as district,
    clientes."CODIGO DE CORREGIMIENTO" as subdistrict_code,
    corregimientos."NOMNBRE DE CORREGIMIENTO" as subdistrict
from client_data.dbo."CLIENTES" as clientes
left join client_data.dbo."GRUPOS" as grupos
    on grupos."CODIGO DE GRUPO" = clientes."CODIGO DE GRUPO"
left join client_data.dbo."DISTRITOS" as distritos
    on distritos."CODIGO DE DISTRITO" = clientes."CODIGO DE DISTRITO"
left join client_data.dbo."CORREGIMIENTOS" as corregimientos
    on corregimientos."CODIGO DE CORREGIMIENTO" = clientes."CODIGO DE CORREGIMIENTO"
left join client_data.dbo."PROVINCIAS" as provincias
    on provincias."CODIGO DE PROVINCIA" = clientes."CODIGO DE PROVINCIA"
where clientes._fivetran_deleted = false
    and grupos._fivetran_deleted = false
    and distritos._fivetran_deleted = false
    and corregimientos._fivetran_deleted = false
    and provincias._fivetran_deleted = false