{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}
SELECT
    employee_id AS employee_key,
    employee_id AS employeeid,
    first_name AS firstname,
    last_name AS lastname,
    email,
    phone_number,
    hire_date,
    position
FROM {{ source('oliver_landing', 'employee') }}