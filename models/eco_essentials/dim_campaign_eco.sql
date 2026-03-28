{{ config(
    materialized = 'table',
)}}

with transactional_source as (
    select
        cast(campaign_id as varchar) as campaign_id,
        campaign_name,
        campaign_discount
    from {{ source('rds_source', 'PROMOTIONAL_CAMPAIGN') }}
),

s3_source as (
    select distinct
        cast(campaignid as varchar) as campaignid,
        campaignname
    from {{ ref('stg_marketingemails') }}
),

final as (
    select
        coalesce(t.campaign_id, s.campaignid) as campaign_id,
        coalesce(t.campaign_name, s.campaignname) as campaign_name,
        t.campaign_discount
    from transactional_source t
    full join s3_source s
        on t.campaign_id = s.campaignid
)

select
    {{ dbt_utils.generate_surrogate_key(['campaign_id']) }} as campaign_key,
    *
from final