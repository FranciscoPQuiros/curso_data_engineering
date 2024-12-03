WITH src_address AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}
    ),

addresses_renamed_casted AS (
    SELECT
          address_id
        , address
        , state
        , country
        , zipcode
        , convert_timezone('UTC', _fivetran_synced) AS date_load
        , _fivetran_deleted
    FROM src_address
    )

SELECT * FROM addresses_renamed_casted