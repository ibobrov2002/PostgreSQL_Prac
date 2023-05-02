--Рейс, по которому больше всего человек совершилo перелёт
WITH fp AS
	(SELECT flight_id, count(*) AS people_count
	FROM ticket_flights
		GROUP BY flight_id)
SELECT f.departure_airport, f.arrival_airport, count(people_count) AS people_sum
FROM fp JOIN
	flights f ON fp.flight_id = f.flight_id
	GROUP BY f.departure_airport, f.arrival_airport
	ORDER BY people_sum DESC LIMIT 1
