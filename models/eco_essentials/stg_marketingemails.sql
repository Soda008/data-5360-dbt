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
from {{ source('s3_source', 'MARKETINGEMAILS') }}