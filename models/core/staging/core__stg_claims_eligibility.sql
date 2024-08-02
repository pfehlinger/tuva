
{{ config(
     enabled = var('claims_enabled',var('tuva_marts_enabled',False)) | as_bool
   )
}}

-- *************************************************
-- This dbt model creates the eligibility table in core.
-- *************************************************




select
        {% if target.type == 'fabric' %}
            cast(member_id as {{ dbt.type_string() }} ) + '-' + cast(enrollment_start_date as {{ dbt.type_string() }} ) + '-' + cast(enrollment_end_date as {{ dbt.type_string() }} )
                + '-' +  cast(payer as {{ dbt.type_string() }} ) + '-' + cast("plan" as {{ dbt.type_string() }} ) as eligibility_id
        {% else %}
             cast(member_id as {{ dbt.type_string() }} ) || '-' || cast(enrollment_start_date as {{ dbt.type_string() }} ) || '-' || cast(enrollment_end_date as {{ dbt.type_string() }} )
            || '-' ||  cast(payer as {{ dbt.type_string() }} ) || '-' || cast("plan" as {{ dbt.type_string() }} ) as eligibility_id
        {% endif %}
       , cast(patient_id as {{ dbt.type_string() }} ) as patient_id
       , cast(member_id as {{ dbt.type_string() }} ) as member_id
       , cast(subscriber_id as {{ dbt.type_string() }} ) as subscriber_id
       , cast(birth_date as date) as birth_date
       , cast(death_date as date) as death_date
       , cast(enrollment_start_date as date ) as enrollment_start_date
       , cast(enrollment_end_date as date ) as enrollment_end_date
       , cast(payer as {{ dbt.type_string() }} ) as payer
       , cast(payer_type as {{ dbt.type_string() }} ) as payer_type
       , cast("plan" as {{ dbt.type_string() }} ) as "plan"
       , cast(original_reason_entitlement_code as {{ dbt.type_string() }} ) as original_reason_entitlement_code
       , cast(dual_status_code as {{ dbt.type_string() }} ) as dual_status_code
       , cast(medicare_status_code as {{ dbt.type_string() }} ) as medicare_status_code
       , cast(subscriber_relation as {{ dbt.type_string() }} ) as subscriber_relation
       , cast(data_source as {{ dbt.type_string() }} ) as data_source
       , '{{ var('tuva_last_run')}}' as tuva_last_run
from {{ ref('normalized_input__eligibility') }} 
