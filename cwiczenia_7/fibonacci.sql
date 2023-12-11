-- Zdanie 1

CREATE OR REPLACE FUNCTION Fibonacci(n INT) RETURNS INT AS $$
DECLARE
    f1 INT := 0;
    f2 INT := 1;
    i INT := 0;
    res INT;
BEGIN
    CREATE TEMP TABLE IF NOT EXISTS FibonacciTable (
        value INT
    );

    WHILE i < n LOOPh
        IF i <= 1 THEN
            res := i;
        ELSE
            res := f1 + f2;
            f1 := f2;
            f2 := res;
        END IF;

        INSERT INTO FibonacciTable (value) VALUES (res);
        i := i + 1;
    END LOOP;

    DROP TABLE IF EXISTS FibonacciTable;
    
    RETURN res;
END;
$$ LANGUAGE PLPGSQL;


-- Zadanie 2

SET search_path TO person;



SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'person' AND table_name = 'person' AND column_name = 'lastname';

CREATE OR REPLACE FUNCTION uppercase_lastname()
RETURNS TRIGGER AS $$
BEGIN
    NEW.lastname = UPPER(NEW.lastname);
    RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER uppercase_lastname_trigger
BEFORE INSERT OR UPDATE ON person.person
FOR EACH ROW
WHEN (NEW.lastname IS NOT NULL)
EXECUTE FUNCTION uppercase_lastname();

-- Zadanie 3

CREATE OR REPLACE FUNCTION RateMonitoring()		
RETURNS TRIGGER AS $$								
DECLARE												
    old_tax_rate numeric;							
    new_tax_rate numeric;							
    max_change_percent numeric := 30; 				
BEGIN													
    new_rate := COALESCE(NEW.TaxRate, 0);
	old_rate := COALESCE(OLD.TaxRate, 0);	

    IF abs(new_rate - old_rate) / old_tax_rate * 100 > max_change_percent THEN 			
        RAISE EXCEPTION, NEW.TaxRate;		
    END IF;

    RETURN NEW;
END;

$$ LANGUAGE plpgsql;

CREATE TRIGGER RateMonitoring			
BEFORE UPDATE ON sales.salestaxrate			
FOR EACH ROW								
EXECUTE FUNCTION RateMonitoring();



