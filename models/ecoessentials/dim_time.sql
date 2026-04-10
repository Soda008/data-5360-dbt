{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
)}}

with time_spine as (
    select distinct
        cast(eventtimestamp as time) as time_of_day
    from {{ ref('stg_marketingemails') }}
),

final as (
    select
        time_of_day,
        date_part('hour', time_of_day) as hour,
        date_part('minute', time_of_day) as minute,
        date_part('second', time_of_day) as second,
        case
            when date_part('hour', time_of_day) < 12 then 'AM'
            else 'PM'
        end as am_pm,
        case
            when date_part('hour', time_of_day) between 0 and 11 then 'Morning'
            when date_part('hour', time_of_day) between 12 and 16 then 'Afternoon'
            else 'Evening'
        end as time_of_day_category
    from time_spine
)

select
    {{ dbt_utils.generate_surrogate_key(['cast(time_of_day as varchar)']) }} as time_key,
    *
from final
