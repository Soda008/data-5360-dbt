{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
)}}

select distinct
    {{ dbt_utils.generate_surrogate_key(['cast(emailid as varchar)']) }} as email_key,
    cast(emailid as varchar) as emailid,
    emailname
from {{ ref('stg_marketingemails') }}