{{ config(materialized = 'table', schema = 'dw_ecoessentials') }}

select
    {{ dbt_utils.generate_surrogate_key(['ol.order_id', 'ol.product_id']) }} as sales_key,
    c.customer_key, p.product_key, dc.campaign_key, d.date_key,
    cast(o.order_id as varchar) as order_id, ol.quantity, ol.discount, ol.price_after_discount
from {{ source('rds_source', 'ORDER_LINE') }} ol
inner join {{ source('rds_source', 'ORDER') }} o on ol.order_id = o.order_id
inner join {{ ref('dim_customer_eco') }} c on cast(o.customer_id as varchar) = c.customer_id
inner join {{ ref('dim_product_eco') }} p on cast(ol.product_id as varchar) = p.product_id
left join {{ ref('dim_campaign_eco') }} dc on cast(ol.campaign_id as varchar) = dc.campaign_id
inner join {{ ref('dim_date_eco') }} d on d.date_key = cast(o.order_timestamp as date)