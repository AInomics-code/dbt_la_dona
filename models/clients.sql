{{ config(
    materialized='table',
    pre_hook="{{ drop_backup_relation() }}"
) }}

select
    clientes.codigo_de_cliente as client_id,
    clientes.nombre_del_cliente as client_name,
    grupos.nombre_del_grupo as client_group,
    clientes.pais as country,
    corregimientos.nombre_de_corregimiento as state,
    distritos.nombre_de_distrito as district,
    clientes.ciudad as city
from {{ source('raw', 'clientes') }}
left join client_data.src_ladona.grupos
    on grupos.codigo_de_grupo = clientes.codigo_de_grupo
left join client_data.src_ladona.distritos
    on distritos.codigo_de_distrito = clientes.codigo_de_distrito
left join client_data.src_ladona.corregimientos
    on corregimientos.codigo_de_corregimiento = clientes.codigo_de_corregimiento



    * pais            panama
* provincia       chiriqui
ciudad          david
* distrito        bugaba
corregimiento   concepcion