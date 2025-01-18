{% snapshot dim_flights__seats %}

{{
   config(
       target_schema='snapshot',
       unique_key=['aircraft_code', 'seat_no'],

       strategy='check',
       check_cols=["fare_conditions"],
       dbt_valid_to_current="'9999-12-31'::date",

       snapshot_meta_column_names={
            "dbt_updated_at": "dbt_updated_at",
            "dbt_valid_from": "dbt_effective_date_from",
            "dbt_valid_to": "dbt_effective_date_to",
            "dbt_scd_id": "dbt_scd_id",
            "dbt_is_deleted": "dbt_is_deleted",

        },

        hard_deletes='new_record'
   )
}}

select
    aircraft_code,
    seat_no,
    fare_conditions
from
    {{ ref('stg_flights__seats') }}

{% endsnapshot %}