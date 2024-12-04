WITH stg_orders AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__orders') }}
    ),

stg_order_items AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__order_items') }}
    ),

stg_promos AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__promos') }}
    ),

stg_products AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__products') }}
    ),

products_total as (
    SELECT
        soi.order_id
        ,soi.quantity
        , soi.product_id
        , pt.name
        , so.promo_id
        , p.status
        , COALESCE(COALESCE(DATE(so.delivered_at), DATE(so.estimated_delivery_at)),DATE(created_at)) as delivered_date
    FROM stg_order_items soi 
    inner JOIN stg_orders so on soi.order_id = so.order_id
    inner join stg_products pt on soi.product_id = pt.product_id
    left join stg_promos p on so.promo_id = p.promo_id
)

select * from products_total

