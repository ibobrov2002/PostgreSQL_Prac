SELECT * FROM housing 
WHERE ARRAY['''Наседкин Никанор Афанасьевич'''] <@ tenants;--0.20c

EXPLAIN ANALYZE SELECT * FROM housing 
WHERE ARRAY['''Наседкин Никанор Афанасьевич'''] <@ tenants;
--Gather  (cost=1000.00..160282.33 rows=5000 width=582) (actual time=3.397..131.329 rows=11 loops=1)
--  Workers Planned: 2
--  Workers Launched: 2
--  ->  Parallel Seq Scan on housing  (cost=0.00..158782.33 rows=2083 width=582) (actual time=40.571..119.643 rows=4 loops=3)
--        Filter: ('{""''Наседкин Никанор Афанасьевич''""}'::text[] <@ tenants)
--        Rows Removed by Filter: 333330
--Execution Time: 131.525 ms

CREATE INDEX indx_tenants ON housing USING GIN(tenants);

SELECT * FROM housing 
WHERE ARRAY['''Наседкин Никанор Афанасьевич'''] <@ tenants;--0.05c

EXPLAIN ANALYZE SELECT * FROM housing 
WHERE ARRAY['''Наседкин Никанор Афанасьевич'''] <@ tenants;
--Bitmap Heap Scan on housing  (cost=66.75..17167.39 rows=5000 width=582) (actual time=0.038..0.048 rows=11 loops=1)
--  Recheck Cond: ('{""''Наседкин Никанор Афанасьевич''""}'::text[] <@ tenants)
--  Heap Blocks: exact=3
--  ->  Bitmap Index Scan on indx_tenants  (cost=0.00..65.50 rows=5000 width=0) (actual time=0.031..0.031 rows=11 loops=1)
--        Index Cond: (tenants @> '{""''Наседкин Никанор Афанасьевич''""}'::text[])
--Planning Time: 2.327 ms
--Execution Time: 0.070 ms
