-- Function: public.json_array_merge(json, json)

-- DROP FUNCTION public.json_array_merge(json, json);

CREATE OR REPLACE FUNCTION public.json_array_merge(
    json,
    json)
  RETURNS json AS
$BODY$	
---------------------------------------------------------------------------------------------------
-- Developer : ASHISH SINGH
-- Description : Merge two json arrays
---------------------------------------------------------------------------------------------------
	SELECT 
		json_agg(a.value) FROM
		(select * from json_array_elements($1)
		UNION ALL
		select * from json_array_elements($2)
		)a
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;