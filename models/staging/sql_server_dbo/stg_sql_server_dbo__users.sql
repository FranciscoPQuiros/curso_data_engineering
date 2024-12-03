WITH src_user AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'users') }}
    ),

users_renamed_casted AS (
    SELECT
          user_id
        , address_id
        , first_name
        , last_name
        , email
        , phone_number
        , convert_timezone('UTC', created_at) AS created_at
        , convert_timezone('UTC', updated_at) AS updated_at
        , convert_timezone('UTC', _fivetran_synced) AS date_load
        , _fivetran_deleted
    FROM src_user
    )

SELECT * FROM users_renamed_casted