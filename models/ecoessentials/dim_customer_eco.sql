{{ config(materialized = 'table', schema = 'dw_ecoessentials') }}

with transactional_source as (
    select
        cast(customer_id as varchar) as customer_id, customer_first_name, customer_last_name,
        customer_email, customer_phone, customer_address, customer_city,
        customer_state, customer_zip, customer_country
    from {{ source('rds_source', 'CUSTOMER') }}
),
s3_source as (
    select distinct cast(customerid as varchar) as customerid, subscriberfirstname, subscriberlastname, subscriberemail
    from {{ ref('stg_marketingemails') }}
),
final as (
    select
        coalesce(t.customer_id, s.customerid) as customer_id,
        coalesce(t.customer_first_name, s.subscriberfirstname) as customer_first_name,
        coalesce(t.customer_last_name, s.subscriberlastname) as customer_last_name,
        coalesce(t.customer_email, s.subscriberemail) as customer_email,
        t.customer_phone, t.customer_address, t.customer_city, t.customer_state, t.customer_zip, t.customer_country
    from transactional_source t
    full join s3_source s on t.customer_id = s.customerid
)
select {{ dbt_utils.generate_surrogate_key(['customer_first_name', 'customer_last_name']) }} as customer_key, * from final