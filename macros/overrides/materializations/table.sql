{% materialization table, adapter='sqlserver' %}
  {%- set identifier = model['alias'] -%}
  {%- set database = model['database'] -%}
  {%- set schema = model['schema'] -%}

  {%- set target_relation = api.Relation.create(
      database=database,
      schema=schema,
      identifier=identifier,
      type='table'
  ) -%}

  -- Borrar si ya existe
  {%- call statement('drop_existing', auto_begin=False) -%}
    if object_id('{{ target_relation }}', 'U') is not null
      drop table {{ target_relation }};
  {%- endcall -%}

  -- Crear tabla con SELECT INTO
  {%- call statement('main') -%}
    select * into {{ target_relation }} from (
      {{ sql }}
    ) as subquery
  {%- endcall -%}

  {{ return({'relations': [target_relation]}) }}
{% endmaterialization %}
