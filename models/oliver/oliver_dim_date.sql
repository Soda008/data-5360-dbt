{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

WITH cte_date AS (
    {{ dbt_date.get_date_dimension("1990-01-01", "2050-12-31") }}
)

SELECT
    date_day AS date_key,
    date_day,
    day_of_week,
    month_of_year,
    quarter_of_year,
    year_number
FROM cte_date