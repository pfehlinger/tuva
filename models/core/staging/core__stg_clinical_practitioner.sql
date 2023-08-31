{{ config(
     enabled = var('clinical_enabled',var('tuva_marts_enabled',False))
   )
}}

select
    practitioner_id
    , npi
    , first_name
    , last_name
    , practice_affiliation
    , specialty
    , sub_specialty
    , data_source
    , tuva_last_run
from {{ ref('practitioner') }}