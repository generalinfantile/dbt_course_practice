{{
    config(
        materialized = 'table'
    )
}}
select
    passenger_id,
    is_employee
from
    {{ ref('employee_passangers') }}