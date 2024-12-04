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
        , convert_timezone('UTC', _fivetran_synced) AS loaded_at
    FROM src_budget
    )

SELECT * FROM budget_renamed_casted