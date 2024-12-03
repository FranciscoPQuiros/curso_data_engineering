WITH stg_orders AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__orders') }}
    ),

stg_order_items AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo__order_items') }}
    ),

products_total as (
    SELECT
        soi.order_id
        ,sum(quantity) total_products_quantity
        
    FROM stg_order_items soi 
    inner JOIN stg_orders so on soi.order_id = so.order_id
    group by soi.order_id
),

order_total as (
    select 
         pt.total_products_quantity
        , so.promo_id
        , COALESCE(COALESCE(DATE(so.delivered_at), DATE(so.estimated_delivery_at)),DATE(created_at)) as delivered_date
    from products_total pt
    inner join stg_orders so on pt.order_id = so.order_id
)

select * from order_total

