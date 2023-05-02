CREATE TABLE payment_parted (
	id			SERIAL,
	month			integer,
	year			integer,
	amount			integer,
	date_entry		date,
	title_service		varchar(128),
	name_owner		varchar(150)
) PARTITION BY RANGE(year);

CREATE TABLE payment_parted_1970
PARTITION OF payment_parted FOR VALUES FROM (1970) TO (1980);

CREATE TABLE payment_parted_1980
PARTITION OF payment_parted FOR VALUES FROM (1980) TO (1990);

CREATE TABLE payment_parted_1990
PARTITION OF payment_parted FOR VALUES FROM (1990) TO (2000);

CREATE TABLE payment_parted_2000
PARTITION OF payment_parted FOR VALUES FROM (2000) TO (2010);

CREATE TABLE payment_parted_2010
PARTITION OF payment_parted FOR VALUES FROM (2010) TO (2020);

CREATE TABLE payment_parted_2020
PARTITION OF payment_parted FOR VALUES FROM (2020) TO (2030);

INSERT INTO payment_parted (id, month, year, amount, date_entry, title_service, name_owner)
SELECT id, month, year, amount, date_entry, title_service, name_owner FROM payment LIMIT 90000000;


EXPLAIN ANALYZE SELECT * FROM payment WHERE year >= 2010 AND year < 2020;
--Seq Scan on payment  (cost=0.00..5192029.88 rows=18802064 width=118) (actual time=9.093..16868.021 rows=19158049 loops=1)
--  Filter: ((year >= 2010) AND (year < 2020))
--  Rows Removed by Filter: 80446741
--Planning Time: 0.080 ms
--Execution Time: 17240.279 msE

EXPLAIN ANALYZE SELECT * FROM payment_parted WHERE year >= 2010 AND year < 2020;
--Seq Scan on payment_parted_2010 payment_parted  (cost=0.00..562872.12 rows=17929608 width=104) (actual time=17.868..6351.841 rows=17310434 loops=1)
--  Filter: ((year >= 2010) AND (year < 2020))
--Planning Time: 0.459 ms
--Execution Time: 6736.220 ms

EXPLAIN ANALYZE SELECT * FROM payment_parted_2010;
--Seq Scan on payment_parted_2010  (cost=0.00..473224.08 rows=17929608 width=104) (actual time=0.017..1078.631 rows=17310434 loops=1)
--Planning Time: 0.038 ms
--Execution Time: 1396.586 ms


EXPLAIN ANALYZE DELETE FROM payment WHERE year >= 2010 AND year < 2020;
--Delete on payment  (cost=0.00..5192029.88 rows=0 width=0) (actual time=90537.964..90537.965 rows=0 loops=1)
--  ->  Seq Scan on payment  (cost=0.00..5192029.88 rows=18802064 width=6) (actual time=15.749..40635.979 rows=19158049 loops=1)
--        Filter: ((year >= 2010) AND (year < 2020))
--        Rows Removed by Filter: 80446741
--Planning Time: 0.087 ms
--Execution Time: 90538.224 ms

DROP TABLE payment_parted_2010;--112 ms
