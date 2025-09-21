{% macro cleanup_tmp_objects(model_name) %}
    {% set sql %}
    DECLARE @sql NVARCHAR(MAX) = N'';

    -- Eliminar vistas temporales dbt
    SELECT @sql += 'IF OBJECT_ID(''' + s.name + '.' + o.name + ''',''V'') IS NOT NULL DROP VIEW [' + s.name + '].[' + o.name + '];'
    FROM sys.objects o
    JOIN sys.schemas s ON o.schema_id = s.schema_id
    WHERE o.type = 'V' AND o.name LIKE '{{ model_name }}__dbt_tmp%';

    -- Eliminar tablas temporales dbt
    SELECT @sql += 'IF OBJECT_ID(''' + s.name + '.' + o.name + ''',''U'') IS NOT NULL DROP TABLE [' + s.name + '].[' + o.name + '];'
    FROM sys.objects o
    JOIN sys.schemas s ON o.schema_id = s.schema_id
    WHERE o.type = 'U' AND o.name LIKE '{{ model_name }}__dbt_tmp%';

    EXEC sp_executesql @sql;
    {% endset %}

    {{ return(sql) }}
{% endmacro %}
