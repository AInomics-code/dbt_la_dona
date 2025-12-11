{{ config(
    materialized='table',
    pre_hook="{{ drop_backup_relation() }}"
) }}

select
    depositos."CODIGO DE DEPOSITO" as location_id,
    depositos."NOMBRE DE DEPOSITO" as location_name,
    depositos."CIUDAD" as city
from client_data.dbo."DEPOSITOS" as depositos