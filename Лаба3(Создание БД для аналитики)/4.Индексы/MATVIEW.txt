CREATE MATERIALIZED VIEW payment_view AS SELECT * FROM payment 
WHERE year >= 2010 AND year < 2020;

SELECT * FROM payment 
WHERE year >= 2010 AND year < 2020;--27.517

SELECT * FROM payment_view;--10.929
