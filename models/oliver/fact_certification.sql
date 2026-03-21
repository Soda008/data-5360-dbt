{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    d.date_key,
    e.employee_key,
    s.certification_name,
    s.certification_cost
FROM {{ ref('stg_employee_certifications') }} s
LEFT JOIN {{ ref('oliver_dim_employee') }} e ON s.employee_id = e.employeeid
LEFT JOIN {{ ref('oliver_dim_date') }} d ON s.certification_awarded_date = d.date_day