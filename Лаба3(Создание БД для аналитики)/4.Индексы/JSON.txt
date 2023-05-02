SELECT id_housing FROM housing
WHERE housing_data @> '{"street": "Бабаевская", "floor": 7, "number room": 5}'::jsonb;--0.20c

EXPLAIN ANALYZE SELECT id_housing FROM housing
WHERE housing_data @> '{"street": "Бабаевская", "floor": 7, "number room": 5}'::jsonb;
--Gather  (cost=1000.00..159792.33 rows=100 width=4) (actual time=107.404..119.018 rows=5 loops=1)
--  Workers Planned: 2
--  Workers Launched: 2
--  ->  Parallel Seq Scan on housing  (cost=0.00..158782.33 rows=42 width=4) (actual time=63.986..105.949 rows=2 loops=3)
--        Filter: (housing_data @> '{""floor"": 7, ""street"": ""Бабаевская"", ""number room"": 5}'::jsonb)
--        Rows Removed by Filter: 333332
--Execution Time: 119.225 ms

CREATE INDEX indx_housing_data ON housing USING GIN(housing_data);

SELECT id_housing FROM housing
WHERE housing_data @> '{"street": "Бабаевская", "floor": 7, "number room": 5}'::jsonb;--0.05c

EXPLAIN ANALYZE SELECT id_housing FROM housing
WHERE housing_data @> '{"street": "Бабаевская", "floor": 7, "number room": 5}'::jsonb;
--Bitmap Heap Scan on housing  (cost=96.78..490.37 rows=100 width=4) (actual time=9.427..9.446 rows=5 loops=1)
--  Recheck Cond: (housing_data @> '{""floor"": 7, ""street"": ""Бабаевская"", ""number room"": 5}'::jsonb)
--  Rows Removed by Index Recheck: 23
--  Heap Blocks: exact=28
--  ->  Bitmap Index Scan on indx_housing_data  (cost=0.00..96.75 rows=100 width=0) (actual time=9.410..9.410 rows=28 loops=1)
--        Index Cond: (housing_data @> '{""floor"": 7, ""street"": ""Бабаевская"", ""number room"": 5}'::jsonb)
--Planning Time: 0.078 ms
--Execution Time: 9.462 ms
