{% macro drop_backup_relation() %}
DO $$
DECLARE
    rel_type char;
BEGIN
    -- Verificar si existe y qué tipo es
    SELECT c.relkind INTO rel_type
    FROM pg_class c
    JOIN pg_namespace n ON n.oid = c.relnamespace
    WHERE n.nspname = '{{ this.schema }}'
    AND c.relname = '{{ this.name }}__dbt_backup';
    
    -- Eliminar según el tipo
    IF rel_type = 'r' THEN
        -- Es una tabla
        EXECUTE 'DROP TABLE IF EXISTS {{ this.schema }}.{{ this.name }}__dbt_backup CASCADE';
    ELSIF rel_type = 'v' THEN
        -- Es una vista
        EXECUTE 'DROP VIEW IF EXISTS {{ this.schema }}.{{ this.name }}__dbt_backup CASCADE';
    END IF;
END $$;
{% endmacro %}

