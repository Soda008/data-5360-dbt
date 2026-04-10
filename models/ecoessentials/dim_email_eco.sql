{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
)}}

select distinct
    -- Generating the surrogate key based on the unique email ID
    {{ dbt_utils.generate_surrogate_key(['emailid']) }} as email_key,
    cast(emailid as varchar) as emailid,
    emailname
from {{ ref('stg_marketingemails') }}