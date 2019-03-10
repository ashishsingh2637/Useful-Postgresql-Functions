-- Function: public.remove_json_array_object(jsonb, jsonb)

-- DROP FUNCTION public.remove_json_array_object(jsonb, jsonb);

CREATE OR REPLACE FUNCTION public.remove_json_array_object(
    json_array jsonb,
    object_to_remove jsonb)
  RETURNS jsonb AS
$BODY$
---------------------------------------------------------------------------------------------------
-- Developer : ASHISH SINGH
-- Description : Remove elements from from an json array
---------------------------------------------------------------------------------------------------
select jsonb_agg(x) from jsonb_array_elements($1) as x
where NOT x @> $2
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;