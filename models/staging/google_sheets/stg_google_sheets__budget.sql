WITH src_budget AS (
    SELECT * 
    FROM {{ source('google_sheets', 'budget') }}
    ),

budget_renamed_casted AS (
    SELECT
          _row
        , product_id
        , quantity
        , month as date
        , _fivetran_synced AS date_load
    FROM src_budget
    )

SELECT * FROM budget_renamed_casted