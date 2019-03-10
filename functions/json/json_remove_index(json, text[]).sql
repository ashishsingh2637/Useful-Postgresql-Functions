-- Function: public.json_remove_index(json, text[])

-- DROP FUNCTION public.json_remove_index(json, text[]);

CREATE OR REPLACE FUNCTION public.json_remove_index(
    data_json json,
    keys_to_be_removed text[])
  RETURNS json AS
$BODY$
---------------------------------------------------------------------------------------------------
-- Developer : ASHISH SINGH
-- Description : Remove given keys from json
---------------------------------------------------------------------------------------------------
  DECLARE
    res_json json;
  BEGIN
	SELECT
		json_object_agg(key,value)
	from json_each_text(data_json) WHERE key != ANY(keys_to_be_removed) INTO res_json;
	return res_json;
  END; 
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;