{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
)}}

select
    -- Macro handles the casting, so we can keep the input clean
    {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_key,
    cast(product_id as varchar) as product_id,
    product_name,
    product_type
-- Updated to 'rds_source' and uppercase 'PRODUCT'
from {{ source('rds_source', 'PRODUCT') }}