-- Function: public.jsonb_merge(jsonb, jsonb)

-- DROP FUNCTION public.jsonb_merge(jsonb, jsonb);

CREATE OR REPLACE FUNCTION public.jsonb_merge(
    jsonb,
    jsonb)
  RETURNS jsonb AS
$BODY$
---------------------------------------------------------------------------------------------------
-- Developer : ASHISH SINGH
-- Description : Merge tow json 
---------------------------------------------------------------------------------------------------
select $1 || $2
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;