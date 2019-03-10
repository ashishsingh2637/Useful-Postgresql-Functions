-- Function: public.jsonb_object_values(jsonb)

-- DROP FUNCTION public.jsonb_object_values(jsonb);

CREATE OR REPLACE FUNCTION public.jsonb_object_values(jsonb)
  RETURNS SETOF jsonb AS
$BODY$
---------------------------------------------------------------------------------------------------
-- Developer : ASHISH SINGH
-- Description : Get the value of json object
---------------------------------------------------------------------------------------------------
select value from jsonb_each($1) as x

$BODY$
  LANGUAGE sql VOLATILE
  COST 100
  ROWS 1000;