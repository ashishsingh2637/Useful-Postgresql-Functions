-- Function: public.json_each_index_and_value(json, text)

-- DROP FUNCTION public.json_each_index_and_value(json, text);

CREATE OR REPLACE FUNCTION public.json_each_index_and_value(
    json_data json,
    columns_to_add text)
  RETURNS json AS
$BODY$	
---------------------------------------------------------------------------------------------------
-- Developer : ASHISH SINGH
-- Description : This function return an array by converting the json into row and columns values by skipping the values not in the column_to_add array
---------------------------------------------------------------------------------------------------
DECLARE
    cols 	text := '';
    vals 	text := '';
    col 	text;
    val 	text;
    result	text;
    
    json_cur 	CURSOR FOR SELECT * FROM json_each(json_data);
BEGIN  
	--set standard_conforming_strings = on;

	OPEN json_cur;
	LOOP
		FETCH json_cur INTO col,val;
		EXIT WHEN NOT FOUND;
			IF val IS NOT NULL AND POSITION((','||col||',') IN columns_to_add) != 0 THEN
				cols := cols||col||',';
				val :=  json_data->>col;
				IF val IS NULL THEN
					vals := vals||'NULL,';
				ELSE
					vals := vals||quote_literal(val)||',';
				END IF;
			END IF;
	END LOOP; 
	close json_cur;
	cols := btrim(cols,',');
	vals := btrim(vals,',');
	result := '{"columns":"'||cols||'","values":'||to_json(vals)||'}';
	RETURN result;
				
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;