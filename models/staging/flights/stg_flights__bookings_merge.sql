{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'merge',
        unique_key = ['book_ref'],
        merge_update_columns  = ['total_amount', 'book_date'],
        on_schema_change='sync_all_columns'
    )
}}
select
   book_ref,
   book_date,
   total_amount,
   1 as something_column
from
    {{ source('demo_src', 'bookings') }}
{% if is_incremental() %}
    where book_date > (select max(book_date) from {{ source('demo_src', 'bookings') }} ) - interval '97 day'
{% endif %}