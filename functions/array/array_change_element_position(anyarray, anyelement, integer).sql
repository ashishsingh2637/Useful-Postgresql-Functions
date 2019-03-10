-- Function: public.array_change_element_position(anyarray, anyelement, integer)

-- DROP FUNCTION public.array_change_element_position(anyarray, anyelement, integer);

CREATE OR REPLACE FUNCTION public.array_change_element_position(
    anyarray,
    anyelement,
    new_postion integer)
  RETURNS text[] AS
$BODY$
---------------------------------------------------------------------------------------------------
-- Developer : ASHISH SINGH
-- Description : Change the index of an element in an array
---------------------------------------------------------------------------------------------------
select array_agg(a ORDER BY o)
from    (
		SELECT a,CASE 
			WHEN a = $2 AND  new_postion < array_position($1,$2) THEN new_postion -.5 
			WHEN a = $2 AND  new_postion > array_position($1,$2) THEN new_postion +.5 
			ELSE ordinality END 
		as o FROM unnest($1) WITH ORDINALITY AS a
        ) as r 
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;