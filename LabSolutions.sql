-- Task 1

CREATE DATABASE IF NOT EXISTS blog;

use blog;

CREATE TABLE IF NOT EXISTS authors (
    author_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS articles (
    article_id INT PRIMARY KEY,
    author_id INT NOT NULL,
    title VARCHAR(255)  NOT NULL,
    word_count INT NOT NULL,
    views INT NOT NULL DEFAULT 0,
    CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

INSERT INTO authors (author_id, name) VALUES
    (1,'Maria Charlotte'),
    (2,'Juan Perez'),
    (3,'Kenan Gafarov');


INSERT INTO articles (article_id, author_id, title, word_count, views) VALUES
	(1,3,'Best Paint Colors',814,14),
    (2,2,'Small Space Decorating Tips',1146, 221),
    (3,1,'Hot Accessories',986,105),
    (4,1,'Mixing Textures',765,22),
    (5,2,'Kitchen Refresh', 1242,307),
    (6,1,'Homemade Art Hacks',1002,193),
    (7,3,'Refinishing Wood Floors',1571,7542);

    
    -- Task 2

CREATE TABLE aircrafts (
    aircraft_id   INT          PRIMARY KEY,
    model         VARCHAR(50)  NOT NULL,
    total_seats   INT          NOT NULL
);

CREATE TABLE flights (
    flight_id       INT         PRIMARY KEY,
    flight_number   VARCHAR(10) NOT NULL UNIQUE,
    aircraft_id     INT         NOT NULL,
    flight_mileage  INT         NOT NULL,
    CONSTRAINT fk_flight_aircraft
        FOREIGN KEY (aircraft_id) REFERENCES aircrafts(aircraft_id)
);

CREATE TABLE customers (
    customer_id     INT          PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    status          VARCHAR(20)  NOT NULL DEFAULT 'None',
    total_mileage   INT          NOT NULL DEFAULT 0
);

CREATE TABLE bookings (
    booking_id    INT  PRIMARY KEY,
    customer_id   INT  NOT NULL,
    flight_id     INT  NOT NULL,
    CONSTRAINT fk_booking_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_booking_flight
        FOREIGN KEY (flight_id)   REFERENCES flights(flight_id),
    CONSTRAINT uq_booking
        UNIQUE (customer_id, flight_id) 
);


INSERT INTO aircrafts (aircraft_id, model, total_seats) VALUES
    (1, 'Boeing 747',   400),
    (2, 'Airbus A330',  236),
    (3, 'Boeing 777',   264);

INSERT INTO flights (flight_id, flight_number, aircraft_id, flight_mileage) VALUES
    (1, 'DL143', 1, 1351),
    (2, 'DL122', 2, 4370),
    (3, 'DL53',  3, 2078),
    (4, 'DL222', 3, 1765),
    (5, 'DL37',  1,  531);

INSERT INTO customers (customer_id, name, status, total_mileage) VALUES
    (1, 'Agustine Riviera',  'Silver', 115235),
    (2, 'Alaina Sepulvida',  'None',     6008),
    (3, 'Tom Jones',         'Gold',   205767),
    (4, 'Sam Rio',           'None',     2653),
    (5, 'Jessica James',     'Silver', 127656),
    (6, 'Ana Janco',         'Silver', 136773),
    (7, 'Jennifer Cortez',   'Gold',   300582),
    (8, 'Christian Janco',   'Silver',  14642);

INSERT INTO bookings (booking_id, customer_id, flight_id) VALUES
    ( 1, 1, 1),  
    ( 2, 1, 2),  
    ( 3, 2, 2),  
    ( 4, 3, 2),  
    ( 5, 3, 3),  
    ( 6, 3, 4),  
    ( 7, 4, 1),  
    ( 8, 4, 5),  
    ( 9, 5, 1),  
    (10, 5, 2),  
    (11, 6, 4),  
    (12, 7, 4),  
    (13, 8, 4);  
    
-- Task 3

SELECT COUNT(DISTINCT flight_number) FROM flights;
SELECT AVG(mileage) FROM flights;
SELECT AVG(total_seats) FROM aircrafts;
SELECT status, AVG(total_mileage) FROM customers GROUP BY status;
SELECT status, MAX(total_mileage) FROM customers GROUP BY status;
SELECT COUNT(*) FROM aircrafts WHERE name LIKE '%Boeing%';
SELECT * FROM flights WHERE mileage BETWEEN 300 AND 2000;

SELECT c.status,
 AVG(f.flight_mileage)
FROM bookings b
JOIN customers c ON b.customer_id = c.customer_id
JOIN flights f ON b.flight_id = f.flight_id
GROUP BY c.status;

SELECT 
    a.name, 
    SUM(f.mileage) AS total_mileage
FROM bookings b
JOIN customers c ON b.customer_id = c.id
JOIN flights f ON b.flight_id = f.flight_id
JOIN aircrafts a ON f.aircraft_id = a.id
WHERE c.status = 'Gold'
GROUP BY a.name
ORDER BY total_mileage DESC
LIMIT 1;

