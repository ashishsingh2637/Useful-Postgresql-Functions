-- Function: public.array_remove(anyelement, anyarray)

-- DROP FUNCTION public.array_remove(anyelement, anyarray);

CREATE OR REPLACE FUNCTION public.array_remove(
    needle anyelement,
    haystack anyarray)
  RETURNS anyarray AS
$BODY$
---------------------------------------------------------------------------------------------------
-- Developer : ASHISH SINGH
-- Description : Remove an element from an array
---------------------------------------------------------------------------------------------------
    SELECT array_agg(unnest) FROM unnest($2) WHERE unnest != $1
$BODY$
  LANGUAGE sql STABLE
  COST 100;