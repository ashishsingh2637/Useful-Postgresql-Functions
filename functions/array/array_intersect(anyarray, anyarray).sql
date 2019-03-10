-- Function: public.array_intersect(anyarray, anyarray)

-- DROP FUNCTION public.array_intersect(anyarray, anyarray);

CREATE OR REPLACE FUNCTION public.array_intersect(
    anyarray,
    anyarray)
  RETURNS anyarray AS
$BODY$
---------------------------------------------------------------------------------------------------
-- Developer : ASHISH SINGH
-- Description : Get the intersection of two arrays
---------------------------------------------------------------------------------------------------
select array_agg(elements)
from    (
        (select unnest($1) INTERSECT select unnest($2))
        ) as r (elements)
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;