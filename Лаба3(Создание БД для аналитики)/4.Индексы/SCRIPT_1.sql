--Запрос
SELECT * FROM payment WHERE amount = 10000; --15.64c

--План запроса
EXPLAIN SELECT * FROM payment WHERE amount = 10000;
--Gather  (cost=1000.00..4246618.36 rows=288854 width=118)
--  Workers Planned: 2
--  ->  Parallel Seq Scan on payment  (cost=0.00..4216732.96 rows=120356 width=118)

--Статистика запроса
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM payment WHERE amount > 100000;
--Buffers: shared hit=187 read=3697771
--Execution Time: 15431.149 ms

--Создание индекса
CREATE INDEX indx_amount ON payment(amount);

--Новый план

SELECT * FROM payment WHERE amount = 10000; --0.57
EXPLAIN SELECT * FROM payment WHERE amount = 10000;
--Index Scan using indx_amount on payment  (cost=0.57..1117969.03 rows=288854 width=118)

--Новая статистика
EXPLAIN (ANALYZE, BUFFERS) SELECT * FROM payment WHERE amount = 10000;
--Buffers: shared read=234175
--Execution Time: 481.000 ms
