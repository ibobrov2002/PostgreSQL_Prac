CREATE OR REPLACE FUNCTION auto_insert() RETURNS trigger AS $$
DECLARE 
	numb_null integer;
	BEGIN
		FOR numb_null IN (SELECT id_type FROM counter_types WHERE model IS NULL ORDER BY id_type)
		LOOP
			INSERT INTO counters (id_housing, id_type) 
				VALUES (NEW.id, numb_null);
		END LOOP;
		RETURN NEW;
	END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER auto_insert AFTER INSERT ON housing
	FOR EACH ROW EXECUTE FUNCTION auto_insert();

BEGIN TRANSACTION;
	INSERT INTO housing (apartment, house, entrance, floor, number_room)
		VALUES (2, 3, 1, 1, 3);
	SELECT * FROM counters;
ROLLBACK;

--DROP TRIGGER IF EXISTS auto_insert ON housing;




CREATE OR REPLACE FUNCTION counter_date() RETURNS trigger AS $$
	BEGIN
		IF (SELECT model FROM counter_types WHERE id_type = NEW.id_type) IS NOT NULL AND NEW.istallation_date IS NULL THEN
			RAISE EXCEPTION 'Wrong istallation date'
				USING HINT = 'Specify date';
		END IF;
		IF NEW.istallation_date >= CURRENT_DATE THEN
			RAISE EXCEPTION 'Wrong istallation date'
				USING HINT = 'Date is greater than current';
		END IF;
		IF NEW.istallation_date < '1970-01-01' AND NOT NEW.id_type IN (SELECT id_type FROM counter_types WHERE model IS NULL) THEN
			RAISE EXCEPTION 'Wrong istallation date'
				USING HINT = 'Counter too old, specify NULL in MODEL';
		END IF;
		RETURN NEW;
	END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER counter_date BEFORE INSERT OR UPDATE OF istallation_date ON counters
	FOR EACH ROW EXECUTE FUNCTION counter_date();

BEGIN TRANSACTION;
	INSERT INTO counters (id_housing, id_type)
		VALUES (2, 8);
ROLLBACK;

--DROP TRIGGER IF EXISTS counter_date ON counters;
