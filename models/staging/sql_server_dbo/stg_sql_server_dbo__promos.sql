WITH src_promo AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'promos') }}
    ),

promo_renamed_casted AS (
    SELECT
          promo_id
        , discount
        , status
        , convert_timezone('UTC', _fivetran_synced) AS date_load
        , _fivetran_deleted
    FROM src_promo
    )

SELECT * FROM promo_renamed_casted