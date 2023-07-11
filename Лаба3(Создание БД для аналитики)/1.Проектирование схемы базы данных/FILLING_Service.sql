INSERT INTO service (title, presence_counter, price, payment_frequency) VALUES
('Электричество', TRUE, 10, 'Ежемесячно'), 
('Горячая вода', TRUE, 15, 'Ежемесячно'), 
('Холодная вода', TRUE, 12, 'Ежемесячно'), 
('Газ', TRUE, 7, 'Ежемесячно'), 
('Канализация', TRUE, 5, 'Ежемесячно'), 
('Отопление', TRUE, 8, 'Ежемесячно'), 
('Вывоз мусора', FALSE, 40, 'Ежемесячно'), 
('Аренда', FALSE, 15000, 'Ежемесячно'), 
('Ремонт помещения', FALSE, 5000, 'Разово'), 
('Ремонт общего имущества', FALSE, 1000, 'Ежегодно'), 
('Уход за общим имуществом', FALSE, 500, 'Ежемесячно'), 
('Капитальный ремонт общего имущества', FALSE, 3000, 'Каждые 5 лет'), 
('Замена электропроводки', FALSE, 3000, 'Разово'), 
('Замена сантехприборов', FALSE, 1500, 'Разово'), 
('Замена водоразборной арматуры', FALSE, 3000, 'Разово'), 
('Смена неисправного выключателя, переключателя', FALSE, 800, 'Разово'), 
('Установка фильтров для воды', FALSE, 1000, 'Разово'), 
('Тепловая энергия', TRUE, 7, 'Ежемесячно'), 
('Твёрдое топливо', TRUE, 17, 'Ежемесячно'), 
('ППР', FALSE, 1000, 'Раз в полгода');


COPY Housing(id_housing, housing_data, owner_details, tenants)
FROM '/tmp/housing.txt'  USING DELIMITERS '|';

COPY Payment(id, id_housing, id_service, month, year, amount, date_entry, counter_units, title_service, presence_counter, name_owner)
FROM '/tmp/payment.txt' USING DELIMITERS '|';

