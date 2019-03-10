-- Function: public.log_error(error_log)

-- DROP FUNCTION public.log_error(error_log);

CREATE OR REPLACE FUNCTION public.log_error(error_log_record error_log)
  RETURNS void AS
$BODY$
-----------------------------------------------------------------------
--	Developer : ASHISH SINGH
-----------------------------------------------------------------------
DECLARE
sql text ;
error_id integer ;
error_message text ;
returned_sqlstate text;
function_name text;
counts integer;
current_count integer;
BEGIN 
	IF NOT error_log_record IS  NULL THEN
		error_message :=NULLIF(error_log_record.message_text,'');
		returned_sqlstate :=NULLIF(error_log_record.returned_sqlstate,'');
		function_name := current_setting('TEAL.function_name');
			INSERT INTO public.error_log(
				function_name,returned_sqlstate,column_name,constraint_name,
				pg_datatype_name,message_text,table_name,schema_name,
				pg_exception_detail,pg_exception_hint,pg_exception_context
			) values(
				current_setting('TEAL.function_name'),NULLIF(error_log_record.returned_sqlstate,''),NULLIF(error_log_record.column_name,''),NULLIF(error_log_record.constraint_name,''),
				NULLIF(error_log_record.pg_datatype_name,''),NULLIF(error_log_record.message_text,''),NULLIF(error_log_record.table_name,''),NULLIF(error_log_record.schema_name,''),
				NULLIF(error_log_record.pg_exception_detail,''),NULLIF(error_log_record.pg_exception_hint,''),NULLIF(error_log_record.pg_exception_context,'')
			);
	END IF;
	RETURN;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;