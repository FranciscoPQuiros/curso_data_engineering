WITH src_product AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'products') }}
    ),

product_renamed_casted AS (
    SELECT
          product_id
        , price
        , name
        , inventory
        , convert_timezone('UTC', _fivetran_synced) AS date_load
        , _fivetran_deleted
    FROM src_product
    )

SELECT * FROM product_renamed_casted