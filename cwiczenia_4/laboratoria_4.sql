USE firma;

CREATE SCHEMA ksiegowosc;
USE ksiegowosc;

-- pracownicy
CREATE TABLE pracownicy(
id_pracownika INT AUTO_INCREMENT PRIMARY KEY,
imie VARCHAR(25) NOT NULL,
nazwisko VARCHAR(30) NOT NULL,
adres VARCHAR(100) NOT NULL,
telefon VARCHAR(12) NOT NULL
);

DESC pracownicy;

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


-- godziny
CREATE TABLE godziny(
id_godziny INT AUTO_INCREMENT PRIMARY KEY,
data date NOT NULL,
liczba_godzin INT NOT NULL,
id_pracownika INT NOT NULL,
FOREIGN KEY (id_pracownika) REFERENCES  pracownicy(id_pracownika)
);  
DESC godziny;

INSERT INTO godziny( data, liczba_godzin , id_pracownika)
VALUES
('2023-10-11', 20, 1),
('2023-10-19', 19, 1),
('2023-10-10', 22, 1),
('2023-10-01', 19, 1),
('2023-10-05', 23, 1),
('2023-10-28', 23, 1),
('2023-10-27', 22, 1),
('2023-10-12', 16, 1),
('2023-03-11', 13, 9),
('2021-03-03', 22, 9),
('2023-03-21', 20, 9),
('2023-03-19', 22, 9),
('2023-03-10', 18, 9),
('2023-03-19', 9, 9),
('2023-03-05', 23, 9),
('2023-03-28', 15, 9),
('2023-03-27', 22, 9),
('2023-03-12', 16, 9),
('2021-09-13', 13, 7),
('2021-09-03', 12, 7),
('2021-09-21', 9, 7),
('2021-09-19', 8, 7),
('2021-09-10', 18, 7),
('2021-09-19', 11, 7);

SELECT * FROM godziny;

-- pensje
CREATE TABLE pensja(
id_pensji INT AUTO_INCREMENT PRIMARY KEY,
stanowisko VARCHAR(40) NOT NULL,
kwota decimal(15,2) NOT NULL
); 
DESC pensja;

INSERT INTO pensja( stanowisko, kwota)
VALUES
('Nauczyciel', 2500 ),
('Piekarz', 2900),
('Lekarz', 3500),
('Radiolog', 2900),
('Kierowca zawodowy', 1100),
('Radiolog', 3100),
('Sprzedawca', 1900),
('Logopeda', 2800),
('Lekarz', 3000),
('Stomatolog', 4000);
SELECT * FROM pensja;


-- premie

CREATE TABLE premia(
id_premii INT  AUTO_INCREMENT PRIMARY KEY,
rodzaj VARCHAR(40) NOT NULL,
kwota decimal(15,2) NOT NULL
);
DESC premia;

INSERT INTO premia(rodzaj, kwota)
VALUES
('Swiateczna', 200.50),
('Noworoczna', 500),
('Noworoczna', 500),
('Swiateczna', 200.50),
('Noworoczna', 500),
('Noworoczna', 500),
('Wielkanocna', 300),
('Swiateczna', 200.50);


SELECT * FROM premia;

-- wynagrodzenie

CREATE TABLE wynagrodzenie(
id_wynagrodzenia INT AUTO_INCREMENT PRIMARY KEY,
data date NOT NULL,
id_pracownika INT NOT NULL,
id_pensji INT NOT NULL ,
id_premii INT,
FOREIGN KEY(id_pracownika) REFERENCES pracownicy(id_pracownika),
FOREIGN KEY(id_pensji) REFERENCES pensja(id_pensji),
FOREIGN KEY(id_premii) REFERENCES premia(id_premii)
);  

DESC wynagrodzenie;


INSERT INTO  wynagrodzenie ( data, id_pracownika, id_pensji, id_premii)
VALUES
('2023-11-11', 2, 2, 1),
('2023-11-11', 3, 3, 2),
('2023-11-11', 4, 4, 3),
('2023-11-11', 6, 6, 4),
('2021-10-19', 7, 7, 5),
('2023-11-11', 8, 8, 8),
('2023-04-13', 9, 9, 6),
('2021-10-19', 10, 10, 7);

INSERT INTO  wynagrodzenie ( data, id_pracownika, id_pensji)
VALUES
('2023-11-11', 1, 1),
('2023-11-11', 5, 5);

SELECT *
FROM wynagrodzenie;

-- a id_prac + nazwisko

SELECT
	id_pracownika, nazwisko
FROM
	pracownicy;


-- b  id_prac płaca > 1000

SELECT 
	pracownicy.id_pracownika, pensja.kwota
FROM
	pracownicy
		LEFT JOIN 
	wynagrodzenie ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika 
		LEFT JOIN
	pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
WHERE
	pensja.kwota > 1000;


-- c id_prac bez premii, płaca > 2000

SELECT 
pracownicy.id_pracownika
FROM
	pracownicy
		INNER JOIN
    wynagrodzenie ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
		LEFT JOIN 
	pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
WHERE
	wynagrodzenie.id_premii IS NULL
		AND
	pensja.kwota > 2000;
		
    
-- d pierwsza litera imienia zaczyna się na j

SELECT *
FROM pracownicy
WHERE
	imie LIKE "j%";


-- e nazwisko zawiwra n i imie konczy na a

SELECT * 
FROM 
	pracownicy
WHERE
	nazwisko LIKE '%n%' 
		AND
    imie LIKE '%a';


-- f imie i nazwisko pracownikow oraz liczba nadgodzin czas mies 160 godz

SELECT
	pracownicy.imie, pracownicy.nazwisko, 
    CASE
    WHEN  (SUM(godziny.liczba_godzin) - 160 ) > 0 THEN SUM(godziny.liczba_godzin) - 160
    ELSE 0
    END AS 'liczba nadgodzin' 
FROM
	pracownicy
		INNER JOIN 
    godziny ON godziny.id_pracownika = pracownicy.id_pracownika
GROUP BY 
	pracownicy.id_pracownika;


-- g imie i nazwisko pracowników których pensja mieści się pomiędzy 1500 a 3000

SELECT
	pracownicy.imie, pracownicy.nazwisko, pensja.kwota
FROM 
	pracownicy
		INNER JOIN 
	wynagrodzenie ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
		LEFT JOIN
	pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
WHERE
	pensja.kwota 
		BETWEEN
	1500
		AND
	3000;
    
       

-- h imie i nazwisko pracownikow ktorzy mieli nadgodziny i nie dostali premii Poprawka!!!!
SELECT
	pracownicy.imie, pracownicy.nazwisko
FROM
	pracownicy
		LEFT JOIN
    godziny ON godziny.id_pracownika = pracownicy.id_pracownika
		LEFT JOIN 
	wynagrodzenie ON wynagrodzenie.id_pracownika = godziny.id_pracownika
WHERE    
	wynagrodzenie.id_premii IS NULL
GROUP BY 
	pracownicy.id_pracownika
HAVING
    (SUM(godziny.liczba_godzin) - 160 ) > 0;

   


-- i uszereguj pracowników według pensji

SELECT * 
FROM pracownicy
		LEFT JOIN
	wynagrodzenie ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
		LEFT JOIN 
	pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
 ORDER BY pensja.kwota;


-- j według pensji malejąca

SELECT * 
FROM pracownicy
		LEFT JOIN
	wynagrodzenie ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
		LEFT JOIN 
	pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
 ORDER BY pensja.kwota DESC;


 -- k zlicz i pogrupuj pracowników według stanowiska
 
 SELECT
	CONCAT('Zawod: ', stanowisko,
					CASE
					WHEN
						COUNT(*) = 1 THEN CONCAT(' wykonuje ', COUNT(*),' osoba')
	                                        ELSE CONCAT(' wykonują ' , COUNT(*), ' osoby')
                                        END) AS 'ilosc osob na stanowisku'
FROM
	pensja
GROUP BY 
	pensja.stanowisko;
 
-- l średnia minimalna max dla lekarz	

SELECT
	AVG( pensja.kwota ) AS 'srednia placa',
    MIN( pensja.kwota ) AS 'placa minimalna',
    MAX( pensja.kwota ) AS 'placa maksymalna'
FROM
	pensja
WHERE
	pensja.stanowisko = 'lekarz'
GROUP BY 
	pensja.stanowisko;


-- m suma wszystkich wynagrodzeń

SELECT
	( SUM(pensja.kwota) + COALESCE(SUM(premia.kwota), 0) ) AS 'suma wynagrodzen'
FROM 
	pensja
		LEFT JOIN
	wynagrodzenie ON wynagrodzenie.id_pensji = pensja.id_pensji
		LEFT JOIN
	premia ON premia.id_premii = wynagrodzenie.id_premii;
    
    
    -- n suma wynagrodzeń według stanowiska
    
SELECT
	pensja.stanowisko,
	( SUM(pensja.kwota) + COALESCE(SUM(premia.kwota),0) ) AS 'suma wynagrodzeń na danym stanowisku'  
FROM 
	pensja
		LEFT JOIN
	wynagrodzenie ON wynagrodzenie.id_pensji = pensja.id_pensji
		LEFT JOIN
	premia ON premia.id_premii = wynagrodzenie.id_premii
GROUP BY pensja.stanowisko;


-- o wyznaqcz liczbę premii przyznanych dla pracowników dla danego stanowiska

SELECT
	pensja.stanowisko,
    COUNT(premia.id_premii) AS 'liczba premii'
FROM 
	wynagrodzenie
		LEFT JOIN
	pensja ON wynagrodzenie.id_pensji = pensja.id_pensji
		LEFT JOIN
	premia ON wynagrodzenie.id_premii = premia.id_premii
GROUP BY
	pensja.stanowisko;


-- p usuń wszystkich pracowników z pensją poniżej 1200zł

CREATE TEMPORARY TABLE 
	to_delete
SELECT 
	pracownicy.id_pracownika
FROM 
	pracownicy
		LEFT JOIN
	wynagrodzenie ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
		RIGHT JOIN
	pensja ON pensja.id_pensji = wynagrodzenie.id_pensji
WHERE 
pensja.kwota < 1200;


DELETE FROM 
	pracownicy
WHERE 
	id_pracownika IN 
						(SELECT
							id_pracownika
						FROM 
							to_delete);
                            
SELECT * 
FROM
	pracownicy;


DROP TEMPORARY TABLE IF EXISTS 
	to_delete;
		
    
