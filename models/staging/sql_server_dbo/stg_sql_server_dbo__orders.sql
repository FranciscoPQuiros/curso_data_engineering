WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
    ),

orders_renamed_casted AS (
    SELECT
        order_id
        , user_id
        , address_id
        , case when promo_id = '' then md5('no-promotion') else md5(promo_id) end as promo_id
        , tracking_id
        , shipping_service
        , shipping_cost
        , order_cost
        , order_total
        , status
        , convert_timezone('UTC', created_at) as created_at
        , convert_timezone('UTC', estimated_delivery_at) as estimated_delivery_at
        , convert_timezone('UTC', delivered_at) as delivered_at
        , convert_timezone('UTC', _fivetran_synced) AS loaded_at
        , _fivetran_deleted
    FROM src_orders
    )

select * from orders_renamed_casted