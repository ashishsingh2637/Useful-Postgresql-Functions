-- Function: public.jsonarray_to_array(json)

-- DROP FUNCTION public.jsonarray_to_array(json);

CREATE OR REPLACE FUNCTION public.jsonarray_to_array(json_arr json)
  RETURNS text[] AS
$BODY$
---------------------------------------------------------------------------------------------------
-- Developer : ASHISH SINGH
-- Description : Convert json array to generic array
---------------------------------------------------------------------------------------------------
SELECT array_agg(value) FROM json_array_elements_text(json_arr)
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;