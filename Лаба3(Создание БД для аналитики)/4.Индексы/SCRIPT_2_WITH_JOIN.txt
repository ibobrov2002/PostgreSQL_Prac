--Запрос
SELECT * FROM payment WHERE date_entry = '2001-08-15';--16.21c

--План запроса
EXPLAIN SELECT * FROM payment WHERE date_entry = '2001-08-15';
--Gather  (cost=1000.00..4218264.16 rows=5312 width=118)
--  Workers Planned: 2
--  ->  Parallel Seq Scan on payment  (cost=0.00..4216732.96 rows=2213 width=118)

--Статистика запроса
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM payment WHERE date_entry = '2001-08-15';
--Buffers: shared hit=16107 read=3681851
--Execution Time: 16388.735 ms

--Создание индекса
CREATE INDEX indx_date_entry ON payment(date_entry);

--Новый план

SELECT * FROM payment WHERE date_entry = '2001-08-15'; --0.32c
EXPLAIN SELECT * FROM payment WHERE date_entry = '2001-08-15';
--Bitmap Index Scan on indx_date_entry  (cost=0.00..60.41 rows=5312 width=0)

--Новая статистика
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM payment WHERE date_entry = '2001-08-15';
--Buffers: shared hit=5300
--Execution Time: 4.754 ms


--Запрос
SELECT p.id, month, year, amount, housing_data, name_owner, tenants, title_service 
FROM housing h JOIN  payment p ON h.id_housing=p.id_housing
WHERE p.month = 2 AND p.year = 2000; --18.24c

--План запроса и статистика
EXPLAIN (ANALYZE, BUFFERS) SELECT p.id, month, year, amount, housing_data, name_owner, tenants, title_service 
FROM housing h JOIN  payment p ON h.id_housing=p.id_housing
WHERE p.month = 2 AND p.year = 2000;
--Gather  (cost=189584.00..4554512.82 rows=163629 width=575) (actual time=17689.380..18075.634 rows=159604 loops=1)
--  Workers Planned: 2
--  Workers Launched: 2
--  Buffers: shared hit=16107 read=3835543, temp read=125696 written=127608
--  ->  Parallel Hash Join  (cost=188584.00..4537149.92 rows=68179 width=575) (actual time=17670.013..17922.007 rows=53201 loops=3)
--        Hash Cond: (p.id_housing = h.id_housing)
--        Buffers: shared hit=16107 read=3835543, temp read=125696 written=127608
--        ->  Parallel Seq Scan on payment p  (cost=0.00..4320487.95 rows=68179 width=105) (actual time=20.522..16840.802 rows=53201 loops=3)
--              Filter: ((month = 2) AND (year = 2000))
--              Rows Removed by Filter: 33148395
--              Buffers: shared hit=15829 read=3682129
--        ->  Parallel Hash  (cost=157740.67..157740.67 rows=416667 width=478) (actual time=761.416..761.417 rows=333333 loops=3)
--              Buckets: 8192 (originally 8192)  Batches: 256 (originally 128)  Memory Usage: 2144kB
--              Buffers: shared hit=160 read=153414, temp read=61129 written=124524
--              ->  Parallel Seq Scan on housing h  (cost=0.00..157740.67 rows=416667 width=478) (actual time=80.536..489.462 rows=333333 loops=3)
--                    Buffers: shared hit=160 read=153414
--Execution Time: 18080.903 ms

--Создание индекса
CREATE INDEX indx_year_month ON payment(year, month);

--Новые план и статистика
SELECT p.id, month, year, amount, housing_data, name_owner, tenants, title_service 
FROM housing h JOIN  payment p ON h.id_housing=p.id_housing
WHERE p.year = 2000 AND p.month = 2; --6.34с

EXPLAIN (ANALYZE, BUFFERS) SELECT p.id, month, year, amount, housing_data, name_owner, tenants, title_service 
FROM housing h JOIN  payment p ON h.id_housing=p.id_housing
WHERE p.year = 2000 AND p.month = 2;
--Gather  (cost=189584.57..878359.95 rows=163629 width=575) (actual time=621.771..805.403 rows=159604 loops=1)
--  Workers Planned: 1
--  Workers Launched: 1
--  Buffers: shared hit=31 read=307174, temp read=63752 written=64540
--  ->  Parallel Hash Join  (cost=188584.57..860997.05 rows=96252 width=575) (actual time=608.908..694.198 rows=79802 loops=2)
--        Hash Cond: (p.id_housing = h.id_housing)
--        Buffers: shared hit=31 read=307174, temp read=63752 written=64540
--        ->  Parallel Index Scan using indx_year_month on payment p  (cost=0.57..643329.38 rows=96252 width=105) (actual time=0.063..186.991 rows=79802 loops=2)
--              Index Cond: ((year = 2000) AND (month = 2))
--              Buffers: shared hit=8 read=153594
--        ->  Parallel Hash  (cost=157740.67..157740.67 rows=416667 width=478) (actual time=393.376..393.377 rows=500000 loops=2)
--              Buckets: 8192  Batches: 128  Memory Usage: 4160kB
--              Buffers: shared read=153574, temp written=61532
--              ->  Parallel Seq Scan on housing h  (cost=0.00..157740.67 rows=416667 width=478) (actual time=65.838..200.623 rows=500000 loops=2)
--                    Buffers: shared read=153574
--Execution Time: 809.503 ms
