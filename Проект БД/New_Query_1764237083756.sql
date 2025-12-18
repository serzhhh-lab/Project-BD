-- Типы залов
CREATE TABLE hall_type (
    hall_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE
);

-- Типы тренировок
CREATE TABLE class_type (
    class_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE
);

-- Типы членства
CREATE TABLE membership_type (
    membership_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE
);

-- Клуб
CREATE TABLE club (
    club_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    opening_time TIME NOT NULL,
    closing_time TIME NOT NULL
);

-- Залы
CREATE TABLE hall (
    hall_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    number_of_seats INT NOT NULL,
    hall_type_id INT NOT NULL,
    club_id INT NOT NULL,
    FOREIGN KEY (hall_type_id) REFERENCES hall_type(hall_type_id),
    FOREIGN KEY (club_id) REFERENCES club(club_id)
);

-- Тренеры
CREATE TABLE trainer (
    trainer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    specialization VARCHAR(255) NOT NULL,
    hourly_rate DECIMAL(6,2) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL UNIQUE
);

-- Занятия
CREATE TABLE workoutclass (
    class_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    class_type_id INT NOT NULL,
    start_time TIME NOT NULL,
    duration INT NOT NULL,
    max_clients INT NOT NULL,
    hall_id INT NOT NULL,
    trainer_id INT NOT NULL,
    FOREIGN KEY (class_type_id) REFERENCES class_type(class_type_id),
    FOREIGN KEY (hall_id) REFERENCES hall(hall_id),
    FOREIGN KEY (trainer_id) REFERENCES trainer(trainer_id)
);

-- Клиенты
CREATE TABLE client (
    client_id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    phone VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE
);

-- Членство
CREATE TABLE membership (
    membership_id SERIAL PRIMARY KEY,
    client_id INT NOT NULL,
    membership_type_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (membership_type_id) REFERENCES membership_type(membership_type_id),
    FOREIGN KEY (client_id) REFERENCES client(client_id)
);

-- Регистрации
CREATE TABLE registration (
    registration_id SERIAL PRIMARY KEY,
    client_id INT NOT NULL,
    class_id INT NOT NULL,
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE,
    visited BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (client_id) REFERENCES client(client_id),
    FOREIGN KEY (class_id) REFERENCES workoutclass(class_id),
    UNIQUE (client_id, class_id)
);

-- Заполнение таблицы типов залов
INSERT INTO hall_type (type_name) VALUES
('Тренажерный зал'),
('Зал групповых занятий'),
('Бассейн'),
('Боксерский ринг'),
('Йога-студия'),
('Кардио-зона'),
('Спиннинг-зал'),
('Танцевальный зал');

-- Заполнение таблицы типов тренировок
INSERT INTO class_type (type_name) VALUES
('Йога'),
('Пилатес'),
('Кроссфит'),
('Бокс'),
('Танцы (Зумба)'),
('Аэробика'),
('Стретчинг'),
('Силовая тренировка'),
('Кардио-тренировка'),
('Аквааэробика'),
('Спиннинг'),
('Кикбоксинг'),
('Тай-бо'),
('Функциональный тренинг');

-- Заполнение таблицы типов членства
INSERT INTO membership_type (type_name) VALUES
('Разовое посещение'),
('Дневной абонемент (до 16:00)'),
('Полный абонемент'),
('Утренний (до 12:00)'),
('Выходного дня'),
('Студенческий'),
('Пенсионный'),
('VIP (безлимит)'),
('Семейный'),
('Корпоративный');

-- Заполнение таблицы клуба
INSERT INTO club (name, address, opening_time, closing_time) VALUES
('Фитнес-центр "Энергия"', 'г. Москва, ул. Спортивная, д. 15', '06:00:00', '23:00:00');

-- Заполнение таблицы тренеров(каждый тренер ведет несколько классов)
INSERT INTO trainer (full_name, specialization, hourly_rate, email, phone) VALUES
('Иванов Алексей Петрович', 'Кроссфит, силовые тренировки', 1500.00, 'alexey.ivanov@energy-fit.ru', '+79161234501'),
('Петрова Марина Сергеевна', 'Йога, пилатес, стретчинг', 1200.00, 'marina.petrova@energy-fit.ru', '+79161234502'),
('Сидоров Дмитрий Викторович', 'Бокс, кикбоксинг, тай-бо', 1800.00, 'dmitry.sidorov@energy-fit.ru', '+79161234503'),
('Козлова Анна Андреевна', 'Танцы, зумба, аэробика', 1100.00, 'anna.kozlova@energy-fit.ru', '+79161234504'),
('Волков Сергей Николаевич', 'Бодибилдинг, функциональный тренинг', 2000.00, 'sergey.volkov@energy-fit.ru', '+79161234505');

-- Заполнение таблицы залов
INSERT INTO hall (name, number_of_seats, hall_type_id, club_id) VALUES
('Главный тренажерный зал', 30, 1, 1),
('Зал групповых занятий A', 25, 2, 1),
('Бассейн "Олимпийский"', 15, 3, 1),
('Боксерский ринг', 10, 4, 1),
('Йога-студия "Гармония"', 20, 5, 1),
('Кардио-зона "Энергия"', 40, 6, 1),
('Спиннинг-зал', 15, 7, 1),
('Танцевальный зал "Грация"', 20, 8, 1);

-- Заполнение таблицы клиентов
INSERT INTO client (full_name, birth_date, phone, email) VALUES
('Иванов Иван Иванович', '12-03-1985', '+79001234561', 'ivanov@mail.ru'),
('Петрова Анна Сергеевна', '25-07-1992', '+79001234562', 'petrova_a@mail.ru'),
('Сидоров Дмитрий Викторович', '30-11-1978', '+79001234563', 'sidorov.d@mail.ru'),
('Козлова Елена Павловна', '15-01-2000', '+79001234564', 'kozlova.e@mail.ru'),
('Смирнов Алексей Юрьевич', '08-09-1989', '+79001234565', 'smirnov_a@mail.ru'),
('Волкова Мария Дмитриевна', '20-04-1995', '+79001234566', 'volkova.m@mail.ru'),
('Морозов Павел Андреевич', '05-12-1982', '+79001234567', 'morozov.p@mail.ru'),
('Лебедева Ольга Викторовна', '18-06-1998', '+79001234568', 'lebedeva.o@mail.ru'),
('Громов Андрей Сергеевич', '22-08-1975', '+79001234569', 'gromov.a@mail.ru'),
('Федорова Екатерина Игоревна', '30-03-1991', '+79001234570', 'fedorova.e@mail.ru');

-- Заполнение таблицы членства(для каждого клиента разный тип и сроки)
INSERT INTO membership (client_id, membership_type_id, start_date, end_date, price) VALUES
-- Действующие абонементы с разными датами окончания
(1, 3, CURRENT_DATE - INTERVAL '15 days', CURRENT_DATE + INTERVAL '15 days', 3000.00),
(2, 6, CURRENT_DATE - INTERVAL '10 days', CURRENT_DATE + INTERVAL '20 days', 2500.00),
(3, 3, CURRENT_DATE - INTERVAL '5 days', CURRENT_DATE + INTERVAL '25 days', 3000.00),
(4, 7, CURRENT_DATE, CURRENT_DATE + INTERVAL '1 month', 2000.00),
(5, 3, CURRENT_DATE - INTERVAL '10 days', CURRENT_DATE + INTERVAL '1 month', 3000.00),
(6, 10, CURRENT_DATE - INTERVAL '5 days', CURRENT_DATE + INTERVAL '20 days', 2800.00),
(7, 1, CURRENT_DATE, CURRENT_DATE, 500.00), -- Разовое
(8, 2, CURRENT_DATE - INTERVAL '20 days', CURRENT_DATE + INTERVAL '10 days', 2200.00),
(9, 9, CURRENT_DATE, CURRENT_DATE + INTERVAL '35 days', 4000.00),
(10, 3, CURRENT_DATE - INTERVAL '15 days', CURRENT_DATE + INTERVAL '15 days', 3000.00);

-- Заполнение таблицы занятий
INSERT INTO workoutclass (name, class_type_id, start_time, duration, max_clients, hall_id, trainer_id) VALUES
('Кроссфит утренний', 3, '08:00:00', 60, 15, 1, 1),
('Силовая тренировка', 8, '10:00:00', 90, 20, 1, 1),
('Кроссфит вечерний', 3, '18:00:00', 90, 15, 1, 1),
('Йога для начинающих', 1, '09:00:00', 60, 15, 5, 2),
('Пилатес', 2, '11:00:00', 60, 18, 2, 2),
('Стретчинг', 7, '17:00:00', 60, 20, 2, 2),
('Бокс начальный', 4, '12:00:00', 60, 10, 4, 3),
('Кикбоксинг', 12, '14:00:00', 90, 12, 4, 3),
('Тай-бо', 13, '19:00:00', 60, 15, 4, 3),
('Зумба', 5, '10:00:00', 60, 20, 8, 4),
('Танцевальная аэробика', 6, '16:00:00', 60, 18, 8, 4),
('Танцевальный микс', 5, '20:00:00', 60, 20, 8, 4),
('Функциональный тренинг', 14, '09:00:00', 60, 15, 1, 5),
('Бодибилдинг', 8, '15:00:00', 90, 15, 1, 5),
('Кардио-интервалы', 9, '19:00:00', 60, 25, 6, 5);

-- Заполнение таблицы регистраций
INSERT INTO registration (client_id, class_id, visited) VALUES
(1, 4, TRUE),
(2, 4, TRUE),
(3, 4, FALSE),
(4, 4, TRUE),
(5, 4, TRUE),
(6, 1, TRUE),
(7, 1, FALSE),
(8, 1, TRUE),
(9, 1, TRUE),
(10, 7, TRUE),
(1, 7, TRUE),
(2, 7, FALSE),
(3, 10, TRUE),
(4, 10, TRUE),
(5, 10, FALSE),
(6, 2, TRUE),
(7, 5, FALSE),
(8, 8, TRUE),
(9, 11, TRUE),
(10, 13, FALSE);
--Задание 1
SELECT 
    c.client_id,
    c.full_name,
    c.phone,
    c.email,
    w.name
FROM client c
JOIN registration r ON c.client_id = r.client_id
JOIN workoutclass w ON r.class_id = w.class_id
WHERE w.class_id = 4
ORDER BY c.full_name;
--Задание 2
SELECT 
    c.client_id,
    c.full_name,
    c.phone,
    mt.type_name,
    m.end_date,
    m.price
FROM client c
JOIN membership m ON c.client_id = m.client_id
JOIN membership_type mt ON m.membership_type_id = mt.membership_type_id
WHERE m.end_date >= CURRENT_DATE 
  AND m.end_date <= CURRENT_DATE + INTERVAL '1 month'
ORDER BY m.end_date;
--Задание 3
SELECT 
    t.trainer_id,
    t.full_name,
    t.specialization,
    JSON_AGG(
        JSON_BUILD_OBJECT(
            'class_name', w.name,
            'start_time', w.start_time,
            'hall', h.name
        )
    ) as classes_json
FROM trainer t
LEFT JOIN workoutclass w ON t.trainer_id = w.trainer_id
LEFT JOIN hall h ON w.hall_id = h.hall_id
GROUP BY t.trainer_id, t.full_name, t.specialization;