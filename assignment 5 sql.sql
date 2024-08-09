
create database ass5;
use ass5;

CREATE TABLE Pieces (
 Code INTEGER PRIMARY KEY NOT NULL,
 Name TEXT NOT NULL
 );
 
CREATE TABLE Providers (
 Code VARCHAR(40) 
 PRIMARY KEY NOT NULL,  
 Name TEXT NOT NULL 
 );
CREATE TABLE Provides (
 Piece INTEGER, 
 FOREIGN KEY (Piece) REFERENCES Pieces(Code),
 Provider VARCHAR(40), 
 FOREIGN KEY (Provider) REFERENCES Providers(Code),  
 Price INTEGER NOT NULL,
 PRIMARY KEY(Piece, Provider) 
 );
 
-- alternative one for SQLite
  /* 
 CREATE TABLE Provides (
 Piece INTEGER,
 Provider VARCHAR(40),  
 Price INTEGER NOT NULL,
 PRIMARY KEY(Piece, Provider) 
 );
 */
 
 
INSERT INTO Providers(Code, Name) 
VALUES
('HAL','Clarke Enterprises'),
('RBT','Susan Calvin Corp.'),
('TNBC','Skellington Supplies');

INSERT INTO Pieces(Code, Name)
 VALUES
 (1,'Sprocket'),
 (2,'Screw'),
 (3,'Nut'),
(4,'Bolt');
select * from Provides ;
INSERT INTO Provides(Piece, Provider, Price) 
VALUES
(1,'HAL',10),
(1,'RBT',15),
(2,'HAL',20),
(2,'RBT',15),
(2,'TNBC',14),
(3,'RBT',50),
(3,'TNBC',45),
(4,'HAL',5),
(4,'RBT',7);


-- https://en.wikibooks.org/wiki/SQL_Exercises/Pieces_and_providers

-- 5.1 Select the name of all the pieces. 
 select name from pieces;

-- 5.2  Select all the providers' data.
select * from providers; 

-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).
select pieces.code,provides.avg(price) from provides 
group by provides.avg(price);

-- 5.4  Obtain the names of all providers who supply piece 1.
select pieces.name,provides.piece from pieces
join provides
on pieces.code=provides.piece
having provides.piece =1;

-- 5.5 Select the name of pieces provided by provider with code "HAL".
select name ,CODE from pieces providers
where code ="HAL" 
GROUP BY CODE; 

-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.

-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price 
-- (note that there could be two providers who supply the same piece at the most expensive price).
-- ---------------------------------------------
SELECT pieces.name, providers.name, provides.price from provides
join  providers
 on  provides.provider= providers.code
 join pieces
 on provides.piece =pieces.code
 where price =(select max(price) from provides where piece= pieces.code);


-- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
insert into providers (name ,code) value ("Skellington Supplies","TNBC");

-- 5.8 Increase all prices by one cent.
select price = price* 0.01  from provides;
update provides set price = (select price +(select price *0.01) )where piece = 1;
select * from provides;

-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
delete from providers where piece=4 and provider="RBT";

-- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces 
    -- (the provider should still remain in the database).
  delete from providers where  provider="RBT";
  
