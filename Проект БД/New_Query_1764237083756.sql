CREATE TABLE club (
    club_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    opening_time TIME NOT NULL,
    closing_time TIME NOT NULL
);

CREATE TABLE hall (
    hall_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    number_of_seats INT NOT NULL,
    type VARCHAR(255) NOT NULL,
    club_id INT NOT NULL,
    FOREIGN KEY (club_id) REFERENCES club(club_id)
);

CREATE TABLE trainer (
    trainer_id INT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    specialization VARCHAR(255) NOT NULL,
    hourly_rate DECIMAL(5,2) NOT NULL,
    email VARCHAR(150) NOT NULL
);

CREATE TABLE workoutclass (
    class_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    start_time TIME NOT NULL,
    duration INT NOT NULL,
    max_clients INT NOT NULL,
    hall_id INT NOT NULL,
    trainer_id INT NOT NULL,
    FOREIGN KEY (hall_id) REFERENCES hall(hall_id),
    FOREIGN KEY (trainer_id) REFERENCES trainer(trainer_id)
);

CREATE TABLE client (
    client_id INT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    registration_date DATE NOT NULL
);

CREATE TABLE membership (
    membership_id INT PRIMARY KEY,
    client_id INT NOT NULL,
    type VARCHAR(255) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (client_id) REFERENCES client(client_id)
);

CREATE TABLE registration (
    registration_id INT PRIMARY KEY,
    client_id INT NOT NULL,
    class_id INT NOT NULL,
    date DATE NOT NULL,
    visited BOOLEAN NOT NULL,
    FOREIGN KEY (client_id) REFERENCES client(client_id),
    FOREIGN KEY (class_id) REFERENCES workoutclass(class_id)
);