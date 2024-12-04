WITH src_event AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'events') }}
    ),

event_renamed_casted AS (
    SELECT
          event_id
        , order_id
        , user_id
        , product_id
        , session_id
        , page_url
        , event_type
        , convert_timezone('UTC', created_at) AS created_at
        , convert_timezone('UTC', _fivetran_synced) AS loaded_at
        , _fivetran_deleted
    FROM src_event
    )

SELECT * FROM event_renamed_casted