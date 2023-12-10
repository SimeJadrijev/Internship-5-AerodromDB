ALTER TABLE Airport
ADD CONSTRAINT CheckMaxCapacityOfTheRunway CHECK (MaxCapacityOfTheRunway > 0);

ALTER TABLE Airport
ADD CONSTRAINT CheckMaxCapacityOfTheStorage CHECK (MaxCapacityOfTheStorage > 0);

ALTER TABLE Staff
ADD CONSTRAINT CheckValidBirthYear CHECK (BirthYear <= CURRENT_DATE);

ALTER TABLE Model
ADD CONSTRAINT CheckMaxCapacityPositive CHECK (MaxCapacity > 0);

ALTER TABLE Airplane
ADD CONSTRAINT CheckValidYearOfManufacture CHECK (YearOfManufacture <= EXTRACT(YEAR FROM CURRENT_DATE));

ALTER TABLE Sex
ADD CONSTRAINT CheckValidSexID CHECK (SexID IN ('M', 'F'));


ALTER TABLE Flight
ADD CONSTRAINT CheckDifferentAirports
CHECK (AirportOfArrival != AirportOfDeparture);

ALTER TABLE SeatType
ADD CONSTRAINT CheckValidSeatTypeName
CHECK (Name IN ('Economy', 'Business'));




