CREATE OR REPLACE FUNCTION update_ticket_price()
RETURNS TRIGGER AS '
BEGIN
    NEW.Price := CASE
                    WHEN NEW.DateOfPurchase <= (CURRENT_DATE + INTERVAL ''30 days'') THEN NEW.BasePrice * 0.8
                    WHEN NEW.DateOfPurchase <= (CURRENT_DATE + INTERVAL ''60 days'') THEN NEW.BasePrice * 0.9
                    ELSE NEW.BasePrice
                END;
    RETURN NEW;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER update_ticket_price_trigger
BEFORE INSERT ON Ticket
FOR EACH ROW
EXECUTE FUNCTION update_ticket_price();

CREATE OR REPLACE FUNCTION add_loyalty_card()
RETURNS TRIGGER AS '
BEGIN
    IF (SELECT COUNT(*) FROM Ticket WHERE CustomerID = NEW.CustomerID) >= 10 THEN
        INSERT INTO LoyaltyCard (CustomerID, ExpirationDate)
        VALUES (NEW.CustomerID, (CURRENT_DATE + INTERVAL ''5 years''));
    END IF;
    RETURN NEW;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER add_loyalty_card_trigger
AFTER INSERT ON Ticket
FOR EACH ROW
EXECUTE FUNCTION add_loyalty_card();


