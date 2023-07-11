--Расчёт для каждого счёта суммы долга
SELECT a.id_debt, a.id_housing, a.month, a.year, a.number_units*s.unit_price AS sum FROM
	accounts a JOIN service_type s ON a.service = s.service
	
--Соответсвие определённой квартире из определённого дома суммы непогашенных счетов
WITH th AS 
	(SELECT a.id_housing, sum(a.number_units*s.unit_price) AS sum_debt FROM
		accounts a JOIN service_type s ON a.service = s.service
		GROUP BY id_housing)
SELECT apartment, house, sum_debt FROM housing
	JOIN th ON id = id_housing
	ORDER BY sum_debt DESC
	
--Соответсвие квартирам их хозяев
WITH th AS 
	(SELECT id_housing, first_name, last_name, phone_number FROM residents
		WHERE "owner/no" = True)
SELECT apartment, house, first_name, last_name, phone_number FROM
	th JOIN housing ON id = id_housing
	
--Таблийца с услугами в порядке убывания суммы долга за них
SELECT a.service, sum(a.number_units*s.unit_price) AS sum_debt_serv FROM
	accounts a JOIN service_type s ON a.service = s.service
	GROUP BY a.service
	ORDER BY sum_debt_serv DESC
	
--Таблица, показывающая в каких квартирах пора менять счётчики по определённым услугам
WITH th AS 
	(SELECT c.id_housing, date_part('years', age(c.istallation_date))>ct.life_time AS need_change, ct.service FROM
		counters c JOIN counter_types ct ON c.id_type = ct.id_type
		WHERE c.istallation_date IS NOT NULL)
SELECT apartment, house, need_change, service FROM
	housing JOIN th ON id = id_housing
	ORDER BY need_change DESC
