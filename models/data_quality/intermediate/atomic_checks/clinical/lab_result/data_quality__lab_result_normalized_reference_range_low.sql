{{ config(
    enabled = var('clinical_enabled', False)
) }}


            SELECT
                M.Data_SOURCE
                ,coalesce(M.RESULT_DATE,cast('1900-01-01' as date)) AS SOURCE_DATE
                ,'LAB_RESULT' AS TABLE_NAME
                ,'Lab Result ID' as DRILL_DOWN_KEY
                , coalesce(lab_result_id, 'NULL') AS DRILL_DOWN_VALUE
                -- ,M.CLAIM_TYPE AS CLAIM_TYPE
                ,'NORMALIZED_REFERENCE_RANGE_LOW' AS FIELD_NAME
                ,case when M.NORMALIZED_REFERENCE_RANGE_LOW is not null then 'valid' else 'null' end as BUCKET_NAME
                ,cast(null as {{ dbt.type_string() }}) as INVALID_REASON
                ,CAST(NORMALIZED_REFERENCE_RANGE_LOW as {{ dbt.type_string() }}) AS FIELD_VALUE
                , '{{ var('tuva_last_run')}}' as tuva_last_run
            FROM {{ ref('lab_result')}} M
            