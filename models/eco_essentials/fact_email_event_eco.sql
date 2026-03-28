{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
)}}

select
    c.customer_key,
    dc.campaign_key,
    e.email_key,
    ev.event_key,
    d.date_key,
    m.subscriberid
from {{ ref('stg_marketingemails') }} m
inner join {{ ref('dim_customer_eco') }} c
    on cast(m.customerid as varchar) = c.customer_id
inner join {{ ref('dim_campaign_eco') }} dc
    on cast(m.campaignid as varchar) = dc.campaign_id
inner join {{ ref('dim_email_eco') }} e
    on cast(m.emailid as varchar) = e.emailid
inner join {{ ref('dim_event_eco') }} ev
    on m.eventtype = ev.event_type
inner join {{ ref('dim_date_eco') }} d
    on d.date_key = cast(m.eventtimestamp as date)