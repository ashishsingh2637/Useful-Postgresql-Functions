-- Function: public.json_each_index_and_value(json)

-- DROP FUNCTION public.json_each_index_and_value(json);

CREATE OR REPLACE FUNCTION public.json_each_index_and_value(json_data json)
  RETURNS json AS
$BODY$
---------------------------------------------------------------------------------------------------
-- Developer : ASHISH SINGH
-- Description : This function return an array by converting the json into row and columns values
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
			cols := cols||col||',';
			val :=  json_data->>col;
			IF val IS NULL THEN
				vals := vals||'NULL,';
			ELSE
				vals := vals||quote_literal(val)||',';
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