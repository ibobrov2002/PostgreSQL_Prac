SELECT id_housing FROM housing 
WHERE to_tsvector('russian', owner_details) @@ to_tsquery('russian', 'Жанна'); --1.67с

EXPLAIN ANALYZE SELECT id_housing FROM housing 
WHERE to_tsvector('russian', owner_details) @@ to_tsquery('russian', 'Жанна');
--Gather  (cost=1000.00..264449.00 rows=5000 width=4) (actual time=3.085..1711.560 rows=1031 loops=1)
--  Workers Planned: 2
--  Workers Launched: 2
--  ->  Parallel Seq Scan on housing  (cost=0.00..262949.00 rows=2083 width=4) (actual time=4.765..1700.222 rows=344 loops=3)
--        Filter: (to_tsvector('russian'::regconfig, owner_details) @@ '''жан'''::tsquery)
--        Rows Removed by Filter: 332990
--Execution Time: 1711.812 ms

CREATE INDEX indx_owner_details ON housing USING GIN(to_tsvector('russian', owner_details));

SELECT id_housing FROM housing 
WHERE to_tsvector('russian', owner_details) @@ to_tsquery('russian', 'Жанна');--0.09c

EXPLAIN ANALYZE SELECT id_housing FROM housing 
WHERE to_tsvector('russian', owner_details) @@ to_tsquery('russian', 'Жанна');
--Bitmap Heap Scan on housing  (cost=62.75..18413.39 rows=5000 width=4) (actual time=0.274..1.073 rows=1031 loops=1)"
--  Recheck Cond: (to_tsvector('russian'::regconfig, owner_details) @@ '''жан'''::tsquery)
--  Heap Blocks: exact=1020
--  ->  Bitmap Index Scan on indx_owner_details  (cost=0.00..61.50 rows=5000 width=0) (actual time=0.155..0.156 rows=1031 loops=1)
--        Index Cond: (to_tsvector('russian'::regconfig, owner_details) @@ '''жан'''::tsquery)
--Planning Time: 0.084 ms
--Execution Time: 1.117 ms
