#Лабораторная №1. Введение в SQL Постановка задачи

Первое практическое задание заключается в знакомстве со средой pgAdmin и написании SQL-запросов с использованием оператора SELECT. Для модельной базы данных должны быть составлены 4 произвольных SELECT-запроса, демонстрирующие полученные знания. Запросы должны охватывать проработанные темы и быть осмысленными, т.е. решать полезную задачу из предметной области. После составления запросов следует убедиться в их правильности при помощи более простых запросов. Дополнительные вопросы могут заключаться в построении более сложных запросов или объяснении работы подготовленных заданий. Скрипт для создания и заполнения модельной базы данных и её описание:
https://postgrespro.ru/education/demodb

#Лабораторные работы №2. Создание БД для приложения

##1.Проектирование схемы базы данных

Второе практическое задание связано с проектированием схемы базы данных для работы приложения (WEB/Mobile/Desktop). Каждый индивидуальный вариант содержит пред- метную область, из которой должна быть проектируемая база данных. Задачей студента является решить, для чего будет использоваться создаваемая база данных, и, исходя из этого, построить её концептуальную схему. Результатом данного практического задания является схема базы данных (в виде ER-диаграммы, содержащей таблицы и связи между ними, без уточнения типов столбцов). При сдаче задания студент должен обосновать соот- ветствие созданной схемы поставленной задаче. Для проектирования схемы и построения диаграммы можно использовать любые средства, один из вариантов использовать сайт:
https://www.lucidchart.com/pages/examples/er-diagram-tool
##2.Создание и заполнение таблиц
Третье практическое задание заключается в подготовке SQL-скрипта для создания таб- лиц согласно схеме, полученной в предыдущем задании (с уточнением типов столбцов). Необходимо определить первичные и внешние ключи, а также декларативные ограничения целостности (возможность принимать неопределенное значение, уникальные ключи, прове- рочные ограничения и т. д.). Таблицы следует создавать в отдельной базе данных. Кроме
того, нужно подготовить данные для заполнения созданных таблиц. Объем подготовленных данных должен составлять не менее 10 экземпляров для каждой из стержневых сущностей и 20 экземпляров для каждой из ассоциативных. На основе этих данных необходимо создать SQL-скрипт для вставки соответствующих строк в таблицы БД.
##3.Операторы манипулирования
Четвертое практическое задание посвящено манипулированию данными с помощью опера- торов SQL. В ходе выполнения четвертого практического задания необходимо:
    • Нужно подготовить 3-4 выборки, которые имеют осмысленное значение для предмет- ной области, и также составить для них SQL-скрипты.
    • Сформулировать 3-4 запроса на изменение и удаление из базы данных. Запросы должны быть сформулированы в терминах предметной области. Среди запросов обязательно должны быть такие, которые будут вызывать срабатывание ограничений целостности. Составить SQL-скрипты для выполнения этих запросов.
##4.Контроль целостности данных
Пятое практическое задание посвящено контролю целостности данных, который произво- дится с помощью механизма транзакций и триггеров. Транзакции позволяют рассматривать группу операций как единое целое, либо отрабатывают все операции, либо ни одной. Это позволяет избегать несогласованности данных. Триггеры позволяют проверять целостность
данных в момент выполнения транзакций, поддерживать целостность, внося изменения, и откатывать транзакции, приводящие к потере целостности. Необходимо подготовить SQL-скрипты для проверки наличия аномалий (потерянных изменений, грязных чтений, неповторяющихся чтений, фантомов) при параллельном исполнении транзакций на раз- личных уровнях изолированности SQL/92 (READ UNCOMMITTED, READ COMMITTED, REPEATABLE READ, SERIALIZABLE). Подготовленные скрипты должны работать с одной из таблиц, созданных в лабораторной №2.1. Для проверки наличия аномалий потре- буются два параллельных сеанса, операторы в которых выполняются пошагово:
    • Установить в обоих сеансах уровень изоляции READ UNCOMMITTED. Выполнить сценарии проверки наличия аномалий потерянных изменений и грязных чтений.
    • Установить в обоих сеансах уровень изоляции READ COMMITTED. Выполнить сценарии проверки наличия аномалий грязных чтений и неповторяющихся чтений.
    • Установить в обоих сеансах уровень изоляции REPEATABLE READ. Выполнить сценарии проверки наличия аномалий неповторяющихся чтений и фантомов.
    • Установить в обоих сеансах уровень изоляции SERIALIZABLE. Выполнить сценарий проверки наличия фантомов.
Необходимо составить скрипт для создания триггера, а также подготовить несколько запросов для проверки и демонстрации его полезных свойств:
    • Изменение данных для сохранения целостности.
    • Проверка транзакций и их откат в случае нарушения целостности.
#Лабораторные работы №3. Создание БД для аналитики
##1.Проектирование схемы базы данных
Шестое практическое задание связано с проектированием схемы базы данных для анали- тики. Будем исходить из того, что приложение, для которого была сделана база данных в задании №2.1, стало очень популярным и по нему каждый день можно собирать большой объем статистической информации. Что это будет за статистика? Почему именно ее необ- ходимо собирать, обрабатывать и анализировать? Задачей студента является ответить на эти вопросы, и, исходя из этого, разработать базу данных и заполнить ее данными. Ре- зультатом данного практического задания является схема базы данных, скрипты создания базы данных и ее заполнения, обладающие следующими свойствами:
    • Как минимум одна таблица должна содержать не меньше 100 млн. записей, которые со временем теряют актуальность.
    • Другая таблица, связанная с первой, должна содержать не меньше 1 млн. записей.
    • В одной из таблиц с количество записей больше 1 млн. должна быть колонка с текстом, по которой будет необходимо настроить полнотекстовый поиск.
    • В одной из таблиц с количество записей больше 1 млн. должна быть колонка с данными в json-формате.
    • В одной из таблиц с количество записей больше 1 млн. должна быть колонка с массивом.
При выполнении задания важно учитывать плюсы и минусы денормализации схемы данных и использования массивов и json-формата. При сдаче задания студент должен обосновать соответствие созданной схемы поставленной задаче.
Для проектирования схемы и построения диаграммы можно использовать любые средства, один из вариантов использовать сайт:
https://www.lucidchart.com/pages/examples/er-diagram-tool
##2.Управление доступом
Целью седьмого практического задания является освоение работы с представлениями и другими способами управления доступом. При выполнении задания необходимо:
    • Создать пользователя test и выдать ему доступ к базе данных.
    • Составить и выполнить скрипты присвоения новому пользователю прав доступа к таблицам, созданным в практическом задании №3.1. При этом права доступа к различным таблицам должны быть различными, а именно:
        ◦ По крайней мере, для одной таблицы новому пользователю присваиваются права SELECT, INSERT, UPDATE в полном объеме.
        ◦ По крайней мере, для одной таблицы новому пользователю присваиваются права SELECT и UPDATE только избранных столбцов.
        ◦ По крайней мере, для одной таблицы новому пользователю присваивается только право SELECT.
    • Составить SQL-скрипты для создания нескольких представлений, которые позволяли бы упростить манипуляции с данными или позволяли бы ограничить доступ к данным, предоставляя только необходимую информацию.
    • Присвоить новому пользователю право доступа (SELECT) к одному из представлений
    • Создать стандартную роль уровня базы данных, присвоить ей право доступа (UPDATE на некоторые столбцы) к одному из представлений, назначить новому пользователю созданную роль.
    • Выполнить от имени нового пользователя некоторые выборки из таблиц и представ- лений. Убедиться в правильности контроля прав доступа.
    • Выполнить от имени нового пользователя операторы изменения таблиц с ограничен- ными правами доступа. Убедиться в правильности контроля прав доступа.
##3.Функции и язык PL/pgSQL
Восьмое практическое задание посвящено упрощению работы аналитика с помощью созда- ния и использования функций. При выполнении задания необходимо:
    • Составить SQL-скрипты для создания нескольких функций, упрощающих манипуля- ции с данными.
    • Продемонстрировать полученные знания о возможностях языка PL/pgSQL. В скриптах должны использоваться:
        ◦ Циклы
        ◦ Ветвления
        ◦ Переменные
        ◦ Курсоры
        ◦ Исключения
    • Обосновать преимущества механизма функций перед механизмом представлений
##4.Индексы
Девятое практическое задание посвящено ускорению выполнения запросов. Для этого могут быть использованы механизмы секционирования, наследования и индексов. Для выполнения задания необходим достаточно большой объем данных, чтобы оптимизация была целесообразной (порядка 1 млн. строк в каждой таблице). Необходимо подготовить два запроса:
    • Запрос к одной таблице, содержащий фильтрацию по нескольким полям.
    • Запрос к нескольким связанным таблицам, содержащий фильтрацию по нескольким полям.
Для каждого из этих запросов необходимо провести следующие шаги:
    • Получить план выполнения запроса без использования индексов.
    • Получить статистику (IO и Time) выполнения запроса без использования индексов.
    • Создать нужные индексы, позволяющие ускорить запрос.
    • Получить план выполнения запроса с использованием индексов и сравнить с перво- начальным планом.
    • Получить статистику выполнения запроса с использованием индексов и сравнить с первоначальной статистикой.
    • Оценить эффективность выполнения оптимизированного запроса.
Также необходимо продемонстрировать полезность индексов для организации полнотексто- вого поиска, фильтрации с использованием массива и json-формата.
Для таблицы объемом больше 100 млн. записей произвести оптимизацию, позволяющую быстро удалять старые данные, ускорить вставку и чтение данных.
