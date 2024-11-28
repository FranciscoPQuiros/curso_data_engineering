WITH src_product AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'products') }}
    ),

renamed_casted AS (
    SELECT
          product_id
        , price
        , name
        , inventory
        , _fivetran_synced AS date_load
        , _fivetran_deleted
    FROM src_product
    )

SELECT * FROM renamed_casted