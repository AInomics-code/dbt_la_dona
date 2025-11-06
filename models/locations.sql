{{ config(
    materialized='table',
    pre_hook="{{ drop_backup_relation() }}"
) }}

select
    codigo_de_deposito as location_id,
    nombre_de_deposito as location_name,
    ciudad as city
from {{ source('raw', 'depositos') }}