WITH src_promo AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'promos') }}
    ),

promo_renamed_casted AS (
    SELECT
          md5(promo_id) as promo_id,
          promo_id as name
        , discount
        , status
        , convert_timezone('UTC', _fivetran_synced) AS loaded_at
        , _fivetran_deleted
    FROM src_promo
    ),

add_no_promo as (

    select
        md5('no-promotion') as promo_id
        , 'no-promotion' as name
        , 0 as discount                 
        , 'active' as status
        , convert_timezone('UTC',current_timestamp) as loaded_at
        , null as _fivetran_deleted  
)

select * 
from promo_renamed_casted
union all
select *
from add_no_promo
