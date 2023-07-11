WITH cf AS
	(SELECT tf.ticket_no, count(*) AS count_flights
	FROM ticket_flights tf
	GROUP BY tf.ticket_no)
SELECT t.passenger_name, contact_data, count_flights 
FROM cf JOIN
	tickets t ON cf.ticket_no = t.ticket_no
	WHERE count_flights > 1;
