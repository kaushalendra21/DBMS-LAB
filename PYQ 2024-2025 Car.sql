
create database prac1;
use prac1;
CREATE TABLE Person (
    driver_id INT PRIMARY KEY,
    name VARCHAR(50),
    address VARCHAR(100)
);

CREATE TABLE Car (
    license VARCHAR(20) PRIMARY KEY,
    model VARCHAR(50),
    year INT
);

CREATE TABLE Accident (
    report_number INT PRIMARY KEY,
    date DATE,
    location VARCHAR(50)
);

CREATE TABLE Owns (
    driver_id INT,
    license VARCHAR(20),
    PRIMARY KEY (driver_id, license),
    FOREIGN KEY (driver_id) REFERENCES Person(driver_id),
    FOREIGN KEY (license) REFERENCES Car(license)
);

CREATE TABLE Participated (
    driver_id INT,
    license VARCHAR(20),
    report_number INT,
    damage_amount INT,
    PRIMARY KEY (driver_id, license, report_number),
    FOREIGN KEY (driver_id) REFERENCES Person(driver_id),
    FOREIGN KEY (license) REFERENCES Car(license),
    FOREIGN KEY (report_number) REFERENCES Accident(report_number)
);

-- Person
INSERT INTO Person VALUES
(1, 'Amit Sharma', 'Delhi'),
(2, 'Ravi Kumar', 'Lucknow'),
(3, 'Neha Singh', 'Kanpur'),
(4, 'Rahul Verma', 'Mumbai');

-- Car
INSERT INTO Car VALUES
('C101', 'Hyundai', 2021),
('C102', 'Honda City', 2020),
('C103', 'Hyundai', 2022),
('C104', 'Toyota', 2019);

-- Accident
INSERT INTO Accident VALUES
(201, '2024-01-15', 'Lucknow'),
(202, '2024-03-10', 'Delhi'),
(203, '2023-06-20', 'Mumbai'),
(204, '2022-08-12', 'Lucknow');

-- Owns
INSERT INTO Owns VALUES
(1, 'C101'),
(2, 'C102'),
(3, 'C103'),
(4, 'C104');

-- Participated
INSERT INTO Participated VALUES
(1, 'C101', 201, 7000),
(1, 'C101', 202, 4000),
(3, 'C103', 203, 9000),
(2, 'C102', 204, 3000);

select * from person p join owns o on p.driver_id=o.driver_id join participated pt on o.license=pt.license join accident a on pt.report_number=a.report_number;

select p.name from person p join owns o on p.driver_id=o.driver_id join participated pt on o.license=pt.license join accident a on pt.report_number=a.report_number where year(a.date)!=2024;

select count(pt.report_number) as total_accident from car c join participated pt on c.license=pt.license where c.model='Hyundai';

select year(a.date) as year,a.location from accident a join participated pt on a.report_number=pt.report_number where pt.damage_amount>5000;

select p.name from person p join participated pt on p.driver_id=pt.driver_id join accident a on pt.report_number=a.report_number where a.location='Lucknow'; 

select location  from accident group by location order by count(*) desc limit 1;

SELECT DISTINCT model
FROM Car
WHERE license NOT IN (
    SELECT DISTINCT license
    FROM Participated
);