{{ config(
    materialized='table',
    pre_hook="{{ drop_backup_relation() }}"
) }}

select
    clientes.codigo_de_cliente as client_id,
    clientes.nombre_del_cliente as client_name,
    grupos.nombre_del_grupo as client_group,
    clientes.pais as country,
    provincias.nombre_de_provincia as state,
    clientes.ciudad as city,
    distritos.nombre_de_distrito as district,
    corregimientos.nombre_de_corregimiento as subdistrict,
from {{ source('raw', 'clientes') }}
left join client_data.src_ladona.grupos
    on grupos.codigo_de_grupo = clientes.codigo_de_grupo
left join client_data.src_ladona.distritos
    on distritos.codigo_de_distrito = clientes.codigo_de_distrito
left join client_data.src_ladona.corregimientos
    on corregimientos.codigo_de_corregimiento = clientes.codigo_de_corregimiento
left join client_data.src_ladona.provincias
    on provincias.codigo_de_provincia = clientes.codigo_de_provincia