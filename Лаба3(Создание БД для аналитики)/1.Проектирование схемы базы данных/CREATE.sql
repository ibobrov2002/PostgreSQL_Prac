CREATE TABLE Housing 
(
	id_housing 		SERIAL PRIMARY KEY,
	housing_data		jsonb,
	owner_details		text,
	tenants			text[]
);

CREATE TABLE Service 
(
	id_service 		SERIAL PRIMARY KEY,
	title			varchar(128) NOT NULL UNIQUE,
	presence_counter	boolean NOT NULL,
	price			integer NOT NULL CHECK (price > 0),
	payment_frequency	varchar(40) NOT NULL DEFAULT 'monthly'
);

CREATE TABLE Payment 
(
	id			SERIAL PRIMARY KEY,
	id_housing		integer REFERENCES Housing ON DELETE CASCADE,
	id_service		integer REFERENCES Service ON DELETE CASCADE,
	month			integer NOT NULL CHECK (month > 0 AND month < 13),
	year			integer NOT NULL CHECK (year > 1970),
	amount			integer NOT NULL CHECK (amount > 0),
	date_entry		date NOT NULL DEFAULT CURRENT_DATE CHECK (date_entry >= '1970-01-01' AND date_entry <= CURRENT_DATE),
	counter_units		integer NOT NULL CHECK (counter_units > 0),
	title_service		varchar(128) NOT NULL,
	presence_counter	boolean NOT NULL,
	name_owner		varchar(150) NOT NULL,
	UNIQUE (id_housing, month, year, id_service)
);
