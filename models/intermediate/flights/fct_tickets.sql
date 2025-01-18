{{
    config(
        materialized = 'table'
    )
}}
select
    t.ticket_no,
    t.book_ref,
    t.passenger_id,
    t.passenger_name,
    t.contact_data

from
    {{ ref('stg_flights__tickets') }} as t
left join {{ ref('stg_dict__employee_passangers') }} as ep
on t.passenger_id=ep.passenger_id
where ep.is_employee is null