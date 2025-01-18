{% snapshot dim_flights__aircrafts %}

{{
   config(
       target_schema='snapshot',
       unique_key='aircraft_code',

       strategy='check',
       check_cols = ["range"],
       dbt_valid_to_current="'9999-12-31'::date",

       snapshot_meta_column_names={
            "dbt_valid_from": "dbt_effective_date_from",
            "dbt_valid_to": "dbt_effective_date_to"
        },

        hard_deletes='invalidate'
   )
}}

select
    aircraft_code,
    model,
    range
from
    {{ ref('stg_flights__aircrafts') }}

{% endsnapshot %}