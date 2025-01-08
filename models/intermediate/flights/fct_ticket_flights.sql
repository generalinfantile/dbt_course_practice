{{
    config(
        materialized = 'table'
    )
}}
select
    ticket_no,
    flight_id,
    fare_conditions,
    amount,
    now()::timestamp as load_date
from
    {{ ref('stg_flights__ticket_flights') }} as tf
