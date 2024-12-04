WITH src_order_item AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'order_items') }}
    ),

order_item_renamed_casted AS (
    SELECT
        concat(order_id, '_', product_id) as order_item_id
        , order_id
        , product_id
        , quantity
        , convert_timezone('UTC', _fivetran_synced) AS loaded_at
        , _fivetran_deleted
    FROM src_order_item
    )

select * from order_item_renamed_casted