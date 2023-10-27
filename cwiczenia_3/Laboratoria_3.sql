CREATE DATABASE firma;
USE firma;

CREATE SCHEMA rozliczenia;
USE rozliczenia;

CREATE TABLE pracownicy(
id_pracownika INT AUTO_INCREMENT PRIMARY KEY,
imie VARCHAR(25) NOT NULL,
nazwisko VARCHAR(30) NOT NULL,
adres VARCHAR(100) NOT NULL,
telefon VARCHAR(12) NOT NULL
);
DESC pracownicy;

CREATE TABLE godziny(
id_godziny INT AUTO_INCREMENT PRIMARY KEY,
data date NOT NULL,
liczba_godzin INT NOT NULL,
id_pracownika INT NOT NULL
);  
DESC godziny;


CREATE TABLE pensje(
id_pensji INT AUTO_INCREMENT PRIMARY KEY,
stanowisko VARCHAR(40) NOT NULL,
kwota decimal(15,2) NOT NULL,
id_premii int NOT NULL
); 
DESC pensje;

CREATE TABLE premie(
id_premii INT  AUTO_INCREMENT PRIMARY KEY,
rodzaj VARCHAR(40) NOT NULL,
kwota decimal(15,2) NOT NULL);
DESC premie;


ALTER TABLE godziny
ADD FOREIGN KEY (id_pracownika) REFERENCES pracownicy(id_pracownika);

ALTER TABLE pensje
ADD FOREIGN KEY (id_premii) REFERENCES premie(id_premii);

INSERT INTO pracownicy(imie, nazwisko, adres, telefon)
VALUES
('Julia', 'Nowak', 'Jana Matejki 7', '123456789'),
('Julita', 'Nowak', 'Jana III Sobieskiego 10', '123456879'),
('Katarzyna', 'Kowalska', 'Jana Matejki 115', '999456789'),
('Patryk', 'Pik', 'Lesna 9', '120006789'),
('Jan', 'Piwowarski', 'KEN 67', '1234567098'),
('Karolina', 'Olszewska', 'Podlesna 99', '123111119'),
('Marek', 'Nowakowski', 'Sklodowskiej 56', '123457777'),
('Julian', 'Kot', 'Podolszyny 44', '888856789'),
('Mariusz', 'Kora', 'Nowa 7', '123666689'),
('Olaf', 'Banan', 'Karciana  37', '123454545');
SELECT * FROM pracownicy;


INSERT INTO godziny( data, liczba_godzin , id_pracownika)
VALUES
('2023-10-11', 8, 1),
('2023-11-11', 9, 2),
('2022-01-10', 2, 3),
('2023-05-01', 3, 4),
('2021-08-05', 9, 5),
('2023-02-28', 10, 6),
('2022-05-27', 5, 7),
('2020-10-12', 6, 8),
('2023-10-11', 13, 9),
('2021-03-03', 6, 10),
('2023-02-15', 10, 8),
('2022-01-12', 7, 3),
('2021-07-29', 13, 6);
SELECT * FROM godziny;

INSERT INTO premie(rodzaj, kwota)
VALUES
('Swiateczna', 200.50),
('Noworoczna', 500),
('Noworoczna', 500),
('Swiateczna', 200.50),
('Noworoczna', 500),
('Noworoczna', 500),
('Wielkanocna', 300),
('Swiateczna', 200.50),
('Swiateczna', 200.50),
('Wielkanocna', 300),
('Wielkanocna', 300),
('Wielkanocna', 300);
SELECT * FROM premie;

INSERT INTO pensje( stanowisko, kwota, id_premii)
VALUES
(' Nauczyciel', 2500, 1),
('Piekarz ', 2900, 2),
(' Lekarz', 3500, 3),
(' Radiolog', 2900, 4),
(' Kierowca zawodowy', 2500, 5),
(' Matemtyk', 3000, 6),
(' Sprzedawca', 2400, 7),
('Logopeda ', 2800, 8),
('Pracownik fizyczny ', 3000, 9),
(' Stomatolog', 4000, 10);
SELECT * FROM pensje;


SELECT nazwisko, adres 
FROM pracownicy;

-- dzień tygodnia i miesiąc
SELECT CONCAT(
   DAYNAME(data),
   ', ',
   MONTHNAME(data) ) AS 'dzien tygodnia i miesiac'
FROM godziny;

ALTER TABLE pensje
RENAME COLUMN kwota
TO kwota_brutto;
 
ALTER TABLE pensje
ADD COLUMN kwota_netto DECIMAL(15,2)
AFTER kwota_brutto;

DESC pensje;

UPDATE pensje
SET kwota_netto = kwota_brutto *0.7103;

SELECT * FROM pensje;


