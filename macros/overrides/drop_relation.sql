{% macro drop_relation(relation) -%}
  {%- set schema = relation.schema -%}
  {%- set name = relation.identifier -%}

  {%- if relation.is_table -%}
    IF OBJECT_ID('{{ schema }}.{{ name }}','U') IS NOT NULL
      DROP TABLE {{ relation.include(database=false) }};
  {%- elif relation.is_view -%}
    IF OBJECT_ID('{{ schema }}.{{ name }}','V') IS NOT NULL
      DROP VIEW {{ relation.include(database=false) }};
  {%- elif relation.is_materialized_view -%}
    IF OBJECT_ID('{{ schema }}.{{ name }}','V') IS NOT NULL
      DROP VIEW {{ relation.include(database=false) }};
  {%- endif -%}
{%- endmacro %}
