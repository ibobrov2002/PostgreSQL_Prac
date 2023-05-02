CREATE TABLE housing
(
    id SERIAL PRIMARY KEY,
    apartment integer NOT NULL CHECK (apartment > 0),
    house integer NOT NULL CHECK (house > 0),
    entrance integer NOT NULL DEFAULT 1 CHECK (entrance > 0),
    floor integer NOT NULL DEFAULT 1 CHECK (floor > 0),
    number_room integer NOT NULL CHECK (number_room > 0),
    UNIQUE (apartment, house)
)

CREATE TABLE residents
(
    id_resident SERIAL PRIMARY KEY,
    first_name varchar(40),
    last_name varchar(40),
    id_housing integer REFERENCES housing ON DELETE CASCADE,
    phone_number varchar(20),
    "owner/no" boolean NOT NULL
)

CREATE TABLE service_type
(
    service varchar(50) PRIMARY KEY,
    unit_price integer NOT NULL CHECK (unit_price > 0)
)

CREATE TABLE accounts
(
    id_debt SERIAL PRIMARY KEY,
    id_housing integer REFERENCES housing ON DELETE NO ACTION,
    month integer NOT NULL CHECK (month > 0 AND month < 13),
    year integer NOT NULL CHECK (year > 1970),
    service varchar(50) REFERENCES service_type ON DELETE CASCADE,
    number_units integer NOT NULL CHECK (number_units >= 0),
    UNIQUE (id_housing, month, year, service)
)

CREATE TABLE counter_types
(
    id_type SERIAL PRIMARY KEY,
    service varchar(50) REFERENCES service_type ON DELETE CASCADE,
    model varchar(50),
    life_time integer,
    UNIQUE (service, model, life_time)
)

CREATE TABLE counters
(
    id_counter SERIAL PRIMARY KEY,
    id_housing integer REFERENCES housing ON DELETE CASCADE,
    id_type integer REFERENCES counter_types ON DELETE NO ACTION,
    istallation_date date
)
