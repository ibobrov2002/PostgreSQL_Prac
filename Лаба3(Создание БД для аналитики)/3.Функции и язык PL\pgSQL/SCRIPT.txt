CREATE OR REPLACE FUNCTION correct_entry_date(month integer, year integer, date_entry date)
RETURNS boolean AS
$$
DECLARE 
	month_entry integer = (SELECT DATE_PART('month', date_entry));
	year_entry integer = (SELECT DATE_PART('year', date_entry));
BEGIN
	IF year < year_entry THEN
		RETURN TRUE;
	ELSIF year > year_entry THEN
		RAISE EXCEPTION 'Wrong date entry';
	ELSIF month < month_entry THEN
		RETURN TRUE;
	ELSE
		RAISE EXCEPTION 'Wrong date entry';
	END IF;
END
$$ LANGUAGE plpgsql;

SELECT correct_entry_date(10, 2000, '2001-12-01'::date); --true
SELECT correct_entry_date(10, 2000, '1998-12-01'::date); --Wrong date entry
SELECT correct_entry_date(10, 2000, '2000-12-01'::date); --true
SELECT correct_entry_date(10, 2000, '2000-08-01'::date); --Wrong date entry

CREATE OR REPLACE FUNCTION percent_large_payments() 
RETURNS integer AS
$$
DECLARE
	payments CURSOR IS SELECT amount FROM Payment;
	num_large_payments integer = 0;
	num_payments integer = 0;
	ratio float = 0;
BEGIN
	FOR payment IN payments LOOP
		num_payments = num_payments + 1;
		IF payment.amount > 100000 THEN
			num_large_payments = num_large_payments + 1;
		END IF;
	END LOOP;
	BEGIN
		ratio = num_large_payments::float / num_payments;
		RAISE NOTICE 'Total payments: %, large payments: %, ratio: %',
			num_payments, num_large_payments, ratio;
	EXCEPTION
		WHEN division_by_zero THEN 
			RAISE NOTICE 'No payments, division by zero';
			RETURN 0;
	END;
	RETURN round(ratio * 100);
END
$$ LANGUAGE plpgsql;

SELECT percent_large_payments() --20
