{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    employee_id,
    certification_json,
    PARSE_JSON(certification_json):certification_name::STRING AS certification_name,
    PARSE_JSON(certification_json):certification_cost::FLOAT AS certification_cost,
    PARSE_JSON(certification_json):certification_awarded_date::DATE AS certification_awarded_date
FROM {{ source('oliver_landing', 'employee_certifications') }}