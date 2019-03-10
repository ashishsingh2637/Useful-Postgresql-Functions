-- Function: platform.get_weeks_between_two_dates(date, date)

-- DROP FUNCTION platform.get_weeks_between_two_dates(date, date);

CREATE OR REPLACE FUNCTION public.get_weeks_between_two_dates(
    start_day date,
    end_day date)
  RETURNS json AS
$BODY$
---------------------------------------------------------------------------------------------------
-- Developer : ASHISH SINGH
-- Description : Get week details between date range
-- select get_weeks_between_two_dates('2018-08-01'::date,'2018-10-01'::date)
---------------------------------------------------------------------------------------------------
	SELECT 	json_agg(json_build_object(
			'start_date',CASE
				WHEN a.week_start < start_day THEN start_day
				ELSE a.week_start END,
			'end_date',CASE
				WHEN a.week_end > end_day THEN end_day
				ELSE a.week_end END
		) ORDER BY week_start)
	FROM
		(SELECT
			i::date as week_start,
			(i::date + INTERVAL '6' day)::date week_end
		FROM
			(select DISTINCT  date_trunc('week', i) as i from  generate_series(start_day, end_day, '1 day'::interval) i) x
			--generate_series(start_day, end_day, '1 week'::interval) i
		) a

$BODY$
  LANGUAGE sql STABLE
  COST 100;