#ASSIGNMENT 1
create database if not exists manufacturerdb;
use manufacturerdb;

CREATE TABLE Manufacturers (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL,
  PRIMARY KEY (Code)   
);

CREATE TABLE Products (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL ,
  Price DECIMAL NOT NULL ,
  Manufacturer INTEGER NOT NULL,
  PRIMARY KEY (Code), 
  FOREIGN KEY (Manufacturer) REFERENCES Manufacturers(Code)
) ENGINE=INNODB;

INSERT INTO Manufacturers(Code,Name)
 VALUES
 (1,'Sony'),
(2,'Creative Labs'),
(3,'Hewlett-Packard'),
(4,'Iomega'),
(5,'Fujitsu'),
(6,'Winchester');

select * from  Manufacturers;
INSERT INTO Products(Code,Name,Price,Manufacturer) 
VALUES
(1,'Hard drive',240,5),
(2,'Memory',120,6),
(3,'ZIP drive',150,4),
(4,'Floppy disk',5,6),
(5,'Monitor',240,1),
(6,'DVD drive',180,2),
(7,'CD drive',90,2),
(8,'Printer',270,3),
(9,'Toner cartridge',66,3),
(10,'DVD burner',180,2);
select * from  products;
select * from Manufacturers;
#QUESTION____________
-- LINK: https://en.wikibooks.org/wiki/SQL_Exercises/The_computer_store

-- 1.1 Select the names of all the products in the store.
    SELECT NAME FROM PRODUCTS;

-- 1.2 Select the names and the prices of all the products in the store.
    SELECT Name,Price FROM PRODUCTS;

-- 1.3 Select the name of the products with a price less than or equal to $200.
   select name,price from products where price<=200;

-- 1.4 Select all the products with a price between $60 and $120.
     select name ,price from products where price  between 60 and 120;

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
    select name ,price from products;

-- 1.6 Compute the average price of all the products.
       select avg(price) from products;

-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
            select avg(price) from products
            inner join manufacturers
            on manufacturers.code=products.Manufacturer;

-- 1.8 Compute the number of products with a price larger than or equal to $180.
       select * from products where price >=180;

-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
         select name,price from products where price>=180
         order by 	price asc,
           name desc ;

 -- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
        SELECT * FROM PRODUCTS p
        INNER JOIN manufacturers m
        on P.code=m.code;

-- 1.11 Select the product name, price, and manufacturer name of all the products.
          select name,price from product
          inner join manufacturers
         on manufacturers.code=products.Manufacturer;

-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
           select avg(price) manufacturer from products
           group by manufacturer ORDER BY manufacturer ASC  ;

-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
         select avg(price), m.name  from products p
         join manufacturers m
         on p.code=m.code
         group by m.name ;
         
-- 1.14 Select the names of manufacturer whose products have an average	 price larger than or equal to $150.
      select m.name, avg(p.price) from manufacturers m
      join products p
      on  m.code=p.code
      group by m.name
      having avg(p.price)<150;
      
-- 1.15 Select the name and price of the cheapest product.
          select name,price from products order by price asc limit 1;
		
-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
select m.name, p.price from manufacturers m
join products p 
on m.code=p.code
order by price desc limit 1;

-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
insert into products (code, name, price ,manufacturer) 
value (11,"Loudspeakers",70,2);
select * from products;

-- 1.18 Update the name of product 8 to "Laser Printer".
        update products
        set name="Laser Printer"
        where code=8;

-- 1.19 Apply a 10% discount to all products.
select price=price * 0.1 from products;

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
select price from products where price>=120
