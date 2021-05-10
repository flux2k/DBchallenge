IF OBJECT_ID('TOUR2556') IS NOT NULL
    DROP TABLE TOUR2556;

GO

IF OBJECT_ID('CLIENT2556') IS NOT NULL
    DROP TABLE CLIENT2556;

GO

IF OBJECT_ID('EVENT2556') IS NOT NULL
    DROP TABLE EVENT2556;

GO

IF OBJECT_ID('BOOKING2556') IS NOT NULL
    DROP TABLE BOOKING2556;

GO

CREATE TABLE TOUR2556 (
    TourName    NVARCHAR(100) PRIMARY KEY,
    Descrip     NVARCHAR(500)
);

CREATE TABLE CLIENT2556 (
    ClientID    INT PRIMARY KEY,
    Surname     NVARCHAR(100) NOT NULL,
    GivenName   NVARCHAR(100) NOT NULL,
    Gender      NVARCHAR(1) CHECK (Gender='M' OR Gender='F' OR Gender='I')
);

CREATE TABLE EVENT2556 (
    TourName    NVARCHAR(100) FOREIGN KEY REFERENCES TOUR2556(TourName),
    EventMonth  NVARCHAR(3) CHECK (EventMonth='Jan' OR EventMonth='Feb' OR EventMonth='Mar' OR EventMonth='Apr' OR EventMonth='May' OR EventMonth='Jun' OR EventMonth='Jul' OR EventMonth='Aug' OR EventMonth='Sep' OR EventMonth='Oct' OR EventMonth='Nov' OR EventMonth='Dec'),
    EventDay    INT CHECK (EventDay >=1 AND EventDay<=31),
    EventYear   INT CHECK (EventYear BETWEEN 1000 AND 9999),
    EventFee    MONEY NOT NULL CHECK (EventFee>0),
    PRIMARY KEY (TourName, EventMonth, EventDay, EventYear)
);

CREATE TABLE BOOKING2556 (
    ClientID    INT FOREIGN KEY REFERENCES CLIENT2556(ClientID),
    TourName    NVARCHAR(100) FOREIGN KEY REFERENCES EVENT2556(TourName),
    EventMonth  NVARCHAR(3) FOREIGN KEY REFERENCES EVENT2556(EventMonth),
    EventDay    INT FOREIGN KEY REFERENCES EVENT2556(EventDay),
    EventYear   INT FOREIGN KEY REFERENCES EVENT2556(EventYear),
    Payment     MONEY CHECK (Payment>0),
    DateBooked  DATE
    PRIMARY KEY (ClientID, TourName, EventMonth, EventDay, EventYear)
);

INSERT INTO TOUR2556 (TourName, Descrip) VALUES ('North', 'Tour of wineries and outlets of the Bedigo and Castlemaine region')
INSERT INTO TOUR2556 (TourName, Descrip) VALUES ('South', 'Tour of wineries and outlets of Mornington Penisula')
INSERT INTO TOUR2556 (TourName, Descrip) VALUES ('West', 'Tour of wineries and outlets of the Geelong and Otways region')
INSERT INTO CLIENT2556 (ClientID, Surname, GivenName, Gender) VALUES (1, 'Price', 'Taylor', 'M')
INSERT INTO CLIENT2556 (ClientID, Surname, GivenName, Gender) VALUES (2, 'Gamble', 'Ellyse', 'F')
INSERT INTO CLIENT2556 (ClientID, Surname, GivenName, Gender) VALUES (3, 'Tan', 'Tilly', 'F')
INSERT INTO CLIENT2556 (ClientID, Surname, GivenName, Gender) VALUES (103582556, 'Tran', 'John', 'M')

SELECT GivenName, Surname, TourName, Payment FROM CLIENT2556, BOOKING2556;