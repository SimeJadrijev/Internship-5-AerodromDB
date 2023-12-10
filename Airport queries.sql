--ispis imena i modela svih aviona s kapacitetom većim od 100
SELECT Airplane.Name, Model.Name FROM Airplane, Model
WHERE Airplane.ModelID = Model.ModelID AND Model.MaxCapacity > 100;

--ispis svih karata čija je cijena između 100 i 200 eura
SELECT * FROM Ticket
WHERE Price BETWEEN 100 AND 200;

--ispis svih pilotkinja s više od 20 odrađenih letova do danas
SELECT Staff.Name, Staff.Surname FROM Staff, FlightStaff, Flight
WHERE Staff.SexID = 'F'
      AND Staff.StaffID = FlightStaff.StaffID
      AND FlightStaff.FlightID = Flight.FlightID
      AND Flight.DateOfDeparture <= CURRENT_DATE
      AND (SELECT COUNT(FlightID) FROM FlightStaff WHERE StaffID = Staff.StaffID) > 20;
	  
--ispis svih domaćina/ca zrakoplova koji su trenutno u zraku
SELECT Staff.Name, Staff.Surname FROM Staff, FlightStaff, Flight
WHERE Staff.PositionID = (SELECT PositionID FROM Position WHERE Name = 'Host')
      AND Staff.StaffID = FlightStaff.StaffID
      AND FlightStaff.FlightID = Flight.FlightID
      AND Flight.DateOfDeparture <= CURRENT_DATE
      AND Flight.DateOfArrival IS NULL;
	 
--ispis broja letova u Split/iz Splita 2023. godine
SELECT COUNT(FlightID) FROM Flight, Airport
WHERE (Flight.AirportOfDeparture = Airport.AirportID AND Airport.Name = 'Split')
      OR (Flight.AirportOfArrival = Airport.AirportID AND Airport.Name = 'Split')
      AND EXTRACT(YEAR FROM Flight.DateOfDeparture) = 2023;

--ispis svih letova za Beč u prosincu 2023.
SELECT * FROM Flight, Airport
WHERE (Flight.AirportOfDeparture = Airport.AirportID AND Airport.Name = 'Vienna')
      OR (Flight.AirportOfArrival = Airport.AirportID AND Airport.Name = 'Vienna')
      AND EXTRACT(YEAR FROM Flight.DateOfDeparture) = 2023
      AND EXTRACT(MONTH FROM Flight.DateOfDeparture) = 12;

--ispis broj prodanih Economy letova kompanije AirDUMP u 2021.
SELECT COUNT(TicketID) FROM Ticket, Flight, Company, SeatType
WHERE Ticket.FlightID = Flight.FlightID
      AND Flight.CompanyID = Company.CompanyID
      AND Company.Name = 'AirDUMP'
      AND Ticket.SeatTypeID = SeatType.SeatTypeID
      AND SeatType.Name = 'Economy'
      AND EXTRACT(YEAR FROM Ticket.DateOfPurchase) = 2021;

--ispis prosječne ocjene letova kompanije AirDUMP
SELECT AVG(Grade.Grade) FROM Flight, Review, Grade, Company
WHERE Flight.FlightID = Review.FlightID
      AND Review.GradeID = Grade.GradeID
      AND Flight.CompanyID = Company.CompanyID
      AND Company.Name = 'AirDUMP';
	  
--ispis svih aerodroma u Londonu, sortiranih po broju Airbus aviona trenutno na njihovim pistama
-- ??

--ispis svih aerodroma udaljenih od Splita manje od 1500km
--??

--smanjite cijenu za 20% svim kartama čiji letovi imaju manje od 20 ljudi
UPDATE Ticket
SET Price = Price * 0.8
WHERE FlightID IN (
    SELECT FlightID
    FROM Flight
    WHERE NumberOfPassengers < 20
);

--povisite plaću za 100 eura svim pilotima koji su ove godine imali više od 10 letova duljih od 10 sati
UPDATE Staff
SET Salary = Salary + 100
WHERE PositionID = (SELECT PositionID FROM Position WHERE Name = 'Pilot')
      AND StaffID IN (
          SELECT FlightStaff.StaffID
          FROM FlightStaff, Flight
          WHERE FlightStaff.FlightID = Flight.FlightID
                AND EXTRACT(YEAR FROM Flight.DateOfDeparture) = EXTRACT(YEAR FROM CURRENT_DATE)
                AND Flight.DateOfArrival - Flight.DateOfDeparture > interval '10 hours'
		  
          AND (SELECT COUNT(FlightStaff2.FlightID)
               FROM FlightStaff FlightStaff2, Flight Flight2
               WHERE FlightStaff2.StaffID = FlightStaff.StaffID 
			   AND FlightStaff2.FlightID = Flight2.FlightID
                     AND EXTRACT(YEAR FROM Flight2.DateOfDeparture) = EXTRACT(YEAR FROM CURRENT_DATE)
               ) > 10
);












