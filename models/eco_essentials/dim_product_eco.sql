{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
)}}

select
    {{ dbt_utils.generate_surrogate_key(['cast(product_id as varchar)']) }} as product_key,
    cast(product_id as varchar) as product_id,
    product_name,
    product_type
from {{ source('rds_source', 'PRODUCT') }}