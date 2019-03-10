-- Function: public.array_diff(anyarray, anyarray)

-- DROP FUNCTION public.array_diff(anyarray, anyarray);

CREATE OR REPLACE FUNCTION public.array_diff(
    anyarray,
    anyarray)
  RETURNS anyarray AS
$BODY$
---------------------------------------------------------------------------------------------------
-- Developer : ASHISH SINGH
-- Description : Get the difference between two arrays
---------------------------------------------------------------------------------------------------
select array_agg(elements)
from    (
        (select unnest($1) except select unnest($2))
        ) as r (elements)
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;