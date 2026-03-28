{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
)}}

select distinct
    {{ dbt_utils.generate_surrogate_key(['eventtype']) }} as event_key,
    eventtype as event_type
from {{ ref('stg_marketingemails') }}