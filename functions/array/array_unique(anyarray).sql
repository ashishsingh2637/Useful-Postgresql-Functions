-- Function: public.array_unique(anyarray)

-- DROP FUNCTION public.array_unique(anyarray);

CREATE OR REPLACE FUNCTION public.array_unique(haystack anyarray)
  RETURNS anyarray AS
$BODY$
---------------------------------------------------------------------------------------------------
-- Developer : ASHISH SINGH
-- Description : Remove duplicate from array without changing the order of array
---------------------------------------------------------------------------------------------------
SELECT array_agg(m.a ORDER BY  ordinality) FROM (SELECT DISTINCT ON (a) a,ordinality from  UNNEST($1) WITH ORDINALITY as a) m;
$BODY$
  LANGUAGE sql STABLE
  COST 100;