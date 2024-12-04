WITH stg_budget AS (
    SELECT * 
    FROM {{ ref('stg_google_sheets__budget') }}
    ),

budget_renamed as (
    SELECT
          _row
        , product_id
        , quantity
        , month(date) as month
        , loaded_at
    FROM stg_budget
)

select * from budget_renamed