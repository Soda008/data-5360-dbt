{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}
SELECT
    customer_id AS cust_key,
    customer_id AS customerid,
    first_name AS firstname,
    last_name AS lastname,
    email,
    phone_number AS phonenumber,
    state
FROM {{ source('oliver_landing', 'customer') }}