{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
)}}

select
    emaileventid,
    emailid,
    emailname,
    campaignid,
    campaignname,
    customerid,
    subscriberid,
    subscriberemail,
    subscriberfirstname,
    subscriberlastname,
    sendtimestamp,
    eventtype,
    eventtimestamp
-- Updated to match 's3_source' from your _src_ecoessentials.yml
from {{ source('s3_source', 'marketingemails') }}