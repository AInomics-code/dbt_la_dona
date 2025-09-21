{% macro create_or_replace_view(relation, sql) -%}
  -- Asegurar que la vista no exista antes
  IF OBJECT_ID('{{ relation.schema }}.{{ relation.identifier }}','V') IS NOT NULL
    DROP VIEW {{ relation.include(database=false) }};

  -- Crear la vista con el SQL compilado
  EXEC('CREATE VIEW {{ relation.include(database=false) }} AS {{ sql }}');
{%- endmacro %}
