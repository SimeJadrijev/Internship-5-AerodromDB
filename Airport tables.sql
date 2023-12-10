create table City (
	CityId serial primary key,
	Name varchar(30) not null,
	GeoLocation POINT
)
create table Airport (
	AirportID serial primary key,
	CityId int references City(CityID),
	Name varchar(30) not null,
	MaxCapacityOfTheRunway int not null,
	MaxCapacityOfTheStorage int not null
)
create table Status (
	StatusID serial primary key,
	Condition varchar(30) not null
)
create table Model (
	ModelID serial primary key,
	Name varchar(30) not null,
	MaxCapacity int not null
)
create table Airplane (
	AirplaneID serial primary key,
	Name varchar(30),
	ModelID int references Model(ModelID),
	StatusID int references Status(StatusID),
	YearOfManufacture int not null
)
create table Company (
	CompanyID serial primary key,
	Name varchar(30) not null
)
create table Sex (
	SexID char(1) primary key,
	Name varchar (30) not null
)
alter table Sex
	add constraint CheckSexID check(SexID in ('M','F'))
create table Position (
	PositionID serial primary key,
	Name varchar(30) not null
)
create table Staff (
	StaffID serial primary key,
	Name varchar(30) not null,
	Surname varchar(30) not null,
	PositionID int references Position(PositionID),
	SexID char references Sex(SexID),
	BirthYear timestamp not null
)
create table Flight (
	FlightID serial primary key,
	AirplaneID int references Airplane(AirplaneID),
	AirportOfDeparture int references Airport(AirportID),
	AirportOfArrival int references Airport(AirportID),
	DateOfDeparture timestamp not null,
	DateOfArrival timestamp,
	NumberOfPassengers int not null,
	CompanyID int references Company(CompanyID)
)
create table FlightStaff (
	FlightID int references Flight(FlightID),
	StaffID int references Staff(StaffID)
)
create table FlightAirport (
	FlightID int references Flight(FlightID),
	AirportID int references Airport(AirportID),
	primary key (FlightID, AirportID)
)
create table Customer (
	CustomerID serial primary key,
	Name varchar(30),
	Surname varchar(30)
)
create table SeatType (
	SeatTypeID serial primary key,
	Name varchar(30)
)
create table Ticket (
	TicketID serial primary key,
	FlightID int references Flight(FlightID),
	CustomerID int references Customer(CustomerID),
	Price float not null,
	SeatMark varchar(30) not null,
	SeatTypeID int references SeatType(SeatTypeID),
	Name varchar(30) not null,
	Surname varchar(30) not null,
	DateOfPurchase timestamp not null
)
alter table Ticket
	add constraint CheckTicketPriceIsPositive check(Price > 0)
create table Grade (
	GradeID serial primary key,
	Grade int not null
)
alter table Grade
	add constraint CheckGrade check (Grade > 0 and Grade < 6)
create table Review (
	ReviewID serial primary key,
	FlightID int references Flight(FlightID),
	GradeID int references Grade(GradeID),
	Comment varchar(50)
)
create table LoyaltyCard (
	LoyaltyCardID serial primary key,
	CustomerID int references Customer(CustomerID),
	ExpirationDate timestamp 
)