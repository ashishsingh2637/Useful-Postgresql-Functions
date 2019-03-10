-- Function: public.array_sort(anyarray)

-- DROP FUNCTION public.array_sort(anyarray);

CREATE OR REPLACE FUNCTION public.array_sort(anyarray)
  RETURNS anyarray AS
$BODY$
---------------------------------------------------------------------------------------------------
-- Developer : ASHISH SINGH
-- Description : Sort the array by element in ascending order
---------------------------------------------------------------------------------------------------
SELECT ARRAY(
    SELECT 
    unnest($1) AS x
ORDER BY 
    x ASC
);
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;