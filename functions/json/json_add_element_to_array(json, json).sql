-- Function: public.json_add_element_to_array(json, json)

-- DROP FUNCTION public.json_add_element_to_array(json, json);

CREATE OR REPLACE FUNCTION public.json_add_element_to_array(
    data_json json,
    json_to_add json)
  RETURNS json AS
$BODY$
---------------------------------------------------------------------------------------------------
-- Developer : ASHISH SINGH
-- Description : Add an element to json array containing integer or text values.
---------------------------------------------------------------------------------------------------
  DECLARE
    res_json json;
  BEGIN
	SELECT 
		array_to_json(array_agg(a.a) ||json_to_add )  
	FROM
		(
			SELECT 
				value a 
			FROM 
				json_array_elements(data_json) 
		)a
	INTO res_json;
	return res_json;
  END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;