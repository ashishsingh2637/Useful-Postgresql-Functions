-- Function: public.array_elment_count(text[], text)

-- DROP FUNCTION public.array_elment_count(text[], text);

CREATE OR REPLACE FUNCTION public.array_elment_count(
    text[],
    text)
  RETURNS bigint AS
$BODY$
---------------------------------------------------------------------------------------------------
-- Developer : ASHISH SINGH
-- Description : Get the occurence count of an element in an array
---------------------------------------------------------------------------------------------------
        SELECT count(*) FROM unnest($1) as x WHERE x=  $2;
        
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;