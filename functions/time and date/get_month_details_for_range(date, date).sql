-- Function: platform.get_month_details_for_range(date, date)

-- DROP FUNCTION platform.get_month_details_for_range(date, date);

CREATE OR REPLACE FUNCTION public.get_month_details_for_range(
    start_date date,
    end_date date)
  RETURNS jsonb AS
$BODY$
--------------------------------------------------------------------------------------------------------------------------------
-- Developer :: Ashish Singh
-- Description : Get the months list and (start,end) of every month between a given date range
-- select get_month_details_for_range('2018-08-01'::date,'2018-10-01'::date)
--------------------------------------------------------------------------------------------------------------------------------
	WITH t as
	(SELECT
	   trim(to_char(mn, 'month'))                                                    AS mon,
	   date_trunc('month', mn) :: DATE                                               AS sd,
	   (date_trunc('month', mn) + '1month' :: INTERVAL - '1sec' :: INTERVAL) :: DATE AS ed,
	   trim(to_char(mn, 'Month'))                                                    AS monn
	 FROM
	   (SELECT generate_series(start_date, end_date, INTERVAL '1 month') :: DATE AS mn
	   ) a
	)
	SELECT jsonb_object_agg(label,data) FROM
	  (SELECT
	     to_json(array_agg(mon)) AS data,
	     'months'                AS label
	   FROM t
	   UNION ALL
	   SELECT
	     json_object_agg(mon, json_build_object(


		 'start_date', sd,
		 'end_date', ed,
		 'name', monn
	     ))           AS data,
	     'month_list' AS label
	   FROM t

	  )a
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;