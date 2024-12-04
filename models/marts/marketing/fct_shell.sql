WITH int_order_product AS (
    SELECT * 
    FROM {{ ref('int_order_product_promo__joined') }}
    ),

dim_budget AS (
    SELECT * 
    FROM {{ ref('dim_budget') }}
),

fct_shell_total AS (
    select month(delivered_date) as month, product_id, name, sum(quantity) as quantity, status
    from int_order_product 
    group by month(delivered_date), product_id, name, status
),

total_with_budget as(
    select t.product_id, name, status, t.quantity as quantity, b.quantity as budget_quantity, t.quantity - b.quantity as quantity_diff
    from fct_shell_total t
    left join dim_budget b 
    on t.product_id = b.product_id and t.month = b.month
),
 total_inactive as (
    select product_id, name, quantity, budget_quantity, quantity_diff 
    from total_with_budget 
    where status = 'inactive' and quantity_diff > 0
    
 ),
 total_active as (
    select product_id, name, quantity, budget_quantity, quantity_diff 
    from total_with_budget where status = 'active'
    and product_id not in (select product_id from total_inactive)
 )

select *, 'inactive' as promo_main_status from total_inactive
union all 
select *, 'active' as promo_main_status from total_active
order by quantity