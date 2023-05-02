CREATE USER test;
GRANT ALL ON DATABASE mydb4 TO test;
GRANT USAGE ON SCHEMA public TO test;

--1
GRANT INSERT, SELECT, UPDATE ON TABLE payment TO test;
--2
GRANT SELECT, UPDATE(owner_details, tenants) ON housing to test;
--3
GRANT SELECT ON service to test;


CREATE OR REPLACE VIEW AMOUNT_PAYMENT AS
	WITH th AS(
		SELECT id_housing, sum(amount) AS sum_am
		FROM payment
		GROUP BY id_housing
		)
	SELECT owner_details, sum_am 
	FROM th t JOIN housing h ON t.id_housing = h.id_housing
	

CREATE OR REPLACE VIEW PAYMENTS_USERS AS
	SELECT name_owner, title_service, month, year, amount, date_entry
	FROM payment 
	ORDER BY date_entry DESC
	LIMIT 1000;


CREATE OR REPLACE VIEW SPENDING_ON_SERVICE AS
	SELECT title_service, sum(amount) AS sum_am
	FROM payment
	GROUP BY title_service;
	

GRANT SELECT ON AMOUNT_PAYMENT to test;

CREATE ROLE user_1;


GRANT ALL ON DATABASE mydb4 to user_1;
GRANT USAGE ON SCHEMA public to user_1;

-- 4
GRANT SELECT, UPDATE(date_entry) ON PAYMENTS_USERS TO user_1;
GRANT user_1 to test;


--1
SELECT name_owner, amount FROM payment LIMIT 100;
--2
SELECT title, price FROM service;
--3
SELECT owner_details FROM housing WHERE id_housing=1;
UPDATE housing SET owner_details='Елизарьева Мария Якубовна +70162545067 Женат/Замужем 6328219729'
WHERE id_housing=1;
SELECT owner_details FROM housing WHERE id_housing=1;
Нет прав:
UPDATE housing SET housing_data='{"floor": 1, "street": "Флегонтьева", "entrance": 4, "apartment": 352, "number room": 1}' WHERE id_housing=1;
--4
SELECT * FROM PAYMENTS_USERS LIMIT 100;
