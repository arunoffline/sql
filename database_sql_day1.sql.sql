CREATE TABLE [Album]
(
    [AlbumId] INTEGER  NOT NULL,
    [Title] NVARCHAR(160)  NOT NULL,
    [ArtistId] INTEGER  NOT NULL,
    CONSTRAINT [PK_Album] PRIMARY KEY  ([AlbumId]),
    FOREIGN KEY ([ArtistId]) REFERENCES [Artist] ([ArtistId]) 
		ON DELETE NO ACTION ON UPDATE NO ACTION
);


--  

CREATE TABLE [Artist]
(
    [ArtistId] INTEGER  NOT NULL,
    [Name] NVARCHAR(120),
    CONSTRAINT [PK_Artist] PRIMARY KEY  ([ArtistId])
);

-- 

CREATE TABLE [Customer]
(
    [CustomerId] INTEGER  NOT NULL,
    [FirstName] NVARCHAR(40)  NOT NULL,
    [LastName] NVARCHAR(20)  NOT NULL,
    [Company] NVARCHAR(80),
    [Address] NVARCHAR(70),
    [City] NVARCHAR(40),
    [State] NVARCHAR(40),
    [Country] NVARCHAR(40),
    [PostalCode] NVARCHAR(10),
    [Phone] NVARCHAR(24),
    [Fax] NVARCHAR(24),
    [Email] NVARCHAR(60)  NOT NULL,
    [SupportRepId] INTEGER,
    CONSTRAINT [PK_Customer] PRIMARY KEY  ([CustomerId]),
    FOREIGN KEY ([SupportRepId]) REFERENCES [Employee] ([EmployeeId]) 
		ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- 

CREATE TABLE [Employee]
(
    [EmployeeId] INTEGER  NOT NULL,
    [LastName] NVARCHAR(20)  NOT NULL,
    [FirstName] NVARCHAR(20)  NOT NULL,
    [Title] NVARCHAR(30),
    [ReportsTo] INTEGER,
    [BirthDate] DATETIME,
    [HireDate] DATETIME,
    [Address] NVARCHAR(70),
    [City] NVARCHAR(40),
    [State] NVARCHAR(40),
    [Country] NVARCHAR(40),
    [PostalCode] NVARCHAR(10),
    [Phone] NVARCHAR(24),
    [Fax] NVARCHAR(24),
    [Email] NVARCHAR(60),
    CONSTRAINT [PK_Employee] PRIMARY KEY  ([EmployeeId]),
    FOREIGN KEY ([ReportsTo]) REFERENCES [Employee] ([EmployeeId]) 
		ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- 

CREATE TABLE [Genre]
(
    [GenreId] INTEGER  NOT NULL,
    [Name] NVARCHAR(120),
    CONSTRAINT [PK_Genre] PRIMARY KEY  ([GenreId])
);

--

CREATE TABLE [Invoice]
(
    [InvoiceId] INTEGER  NOT NULL,
    [CustomerId] INTEGER  NOT NULL,
    [InvoiceDate] DATETIME  NOT NULL,
    [BillingAddress] NVARCHAR(70),
    [BillingCity] NVARCHAR(40),
    [BillingState] NVARCHAR(40),
    [BillingCountry] NVARCHAR(40),
    [BillingPostalCode] NVARCHAR(10),
    [Total] NUMERIC(10,2)  NOT NULL,
    CONSTRAINT [PK_Invoice] PRIMARY KEY  ([InvoiceId]),
    FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([CustomerId]) 
		ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- 

CREATE TABLE [InvoiceLine]
(
    [InvoiceLineId] INTEGER  NOT NULL,
    [InvoiceId] INTEGER  NOT NULL,
    [TrackId] INTEGER  NOT NULL,
    [UnitPrice] NUMERIC(10,2)  NOT NULL,
    [Quantity] INTEGER  NOT NULL,
    CONSTRAINT [PK_InvoiceLine] PRIMARY KEY  ([InvoiceLineId]),
    FOREIGN KEY ([InvoiceId]) REFERENCES [Invoice] ([InvoiceId]) 
		ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY ([TrackId]) REFERENCES "Track" ([TrackId]) 
		ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- 

CREATE TABLE [MediaType]
(
    [MediaTypeId] INTEGER  NOT NULL,
    [Name] NVARCHAR(120),
    CONSTRAINT [PK_MediaType] PRIMARY KEY  ([MediaTypeId])
);

-- 

CREATE TABLE [Playlist]
(
    [PlaylistId] INTEGER  NOT NULL,
    [Name] NVARCHAR(120),
    CONSTRAINT [PK_Playlist] PRIMARY KEY  ([PlaylistId])
);

-- 

CREATE TABLE [PlaylistTrack]
(
    [PlaylistId] INTEGER  NOT NULL,
    [TrackId] INTEGER  NOT NULL,
    CONSTRAINT [PK_PlaylistTrack] PRIMARY KEY  ([PlaylistId], [TrackId]),
    FOREIGN KEY ([PlaylistId]) REFERENCES [Playlist] ([PlaylistId]) 
		ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY ([TrackId]) REFERENCES "Track" ([TrackId]) 
		ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- 

CREATE TABLE "Track" (
	"TrackId"	INTEGER NOT NULL,
	"Name"	NVARCHAR(200) NOT NULL,
	"AlbumId"	INTEGER,
	"MediaTypeId"	INTEGER NOT NULL,
	"GenreId"	INTEGER,
	"Composer"	NVARCHAR(220),
	"Milliseconds"	INTEGER NOT NULL,
	"Bytes"	INTEGER,
	"UnitPrice"	NUMERIC(10, 2) NOT NULL,
	CONSTRAINT "PK_Track" PRIMARY KEY("TrackId"),
	FOREIGN KEY("MediaTypeId") REFERENCES "MediaType"("MediaTypeId") ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY("GenreId") REFERENCES "Genre"("GenreId") ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY("AlbumId") REFERENCES "Album"("AlbumId") ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- 

CREATE INDEX [IFK_AlbumArtistId] ON [Album] ([ArtistId]);
CREATE INDEX [IFK_CustomerSupportRepId] ON [Customer] ([SupportRepId]);
CREATE INDEX [IFK_EmployeeReportsTo] ON [Employee] ([ReportsTo]);
CREATE INDEX [IFK_InvoiceCustomerId] ON [Invoice] ([CustomerId]);
CREATE INDEX [IFK_InvoiceLineInvoiceId] ON [InvoiceLine] ([InvoiceId]);
CREATE INDEX [IFK_InvoiceLineTrackId] ON [InvoiceLine] ([TrackId]);
CREATE INDEX [IFK_PlaylistTrackTrackId] ON [PlaylistTrack] ([TrackId]);
CREATE INDEX "IFK_TrackAlbumId" ON "Track" (
	"AlbumId"
);
CREATE INDEX "IFK_TrackGenreId" ON "Track" (
	"GenreId"
);

CREATE INDEX "IFK_TrackMediaTypeId" ON "Track" (
	"MediaTypeId"
);


-- View Creation--

CREATE VIEW [vw_Album]
AS
SELECT
    [AlbumId],
    [Title],
    [ArtistId]
FROM [Album];

-- Artist View

CREATE VIEW [vw_Artist]
AS
SELECT
    [ArtistId],
    [Name]
FROM [Artist];

-- Create Views for Other Tables



select AlbumId, Title from Album order by Title limit 10;

SELECT	1 + 1;

SELECT 
   10 / 5, 
   2 * 4 ;
   

SELECT DISTINCT column_list
FROM table_list
  JOIN table ON join_condition
WHERE row_filter
ORDER BY column
LIMIT count OFFSET offset
GROUP BY column
HAVING group_filter;


SELECT
	trackid,
	name,
	composer,
	unitprice
FROM
	track;
	
-- Addition of more columns

SELECT
	trackid,
	name,
	albumid,
	mediatypeid,
	genreid,
	composer,
	milliseconds,
	bytes,
	unitprice
FROM
	track;
	
-- Select all columns

SELECT * FROM track;	

-- Usage of Order By Clause

SELECT
   select_list
FROM
   table
ORDER BY
    column_1 ASC,
    column_2 DESC;

-- 	

SELECT
	name,
	milliseconds, 
        albumid
FROM
	track;
	
-- Order By Clause Sample

SELECT
	name,
	milliseconds, 
	albumid
FROM
	track
ORDER BY
	albumid ASC;
	
	
-- what is the default behavior?

SELECT
	name,
	milliseconds, 
	albumid
FROM
	track
ORDER BY
	albumid;
	
-- sorting by more than one field

SELECT
	name,
	milliseconds, 
	albumid
FROM
	track
ORDER BY
	albumid ASC,
    milliseconds DESC;
	
-- sorting using ordinal position

SELECT
	name,
	milliseconds, 
	albumid
FROM
	track
ORDER BY
	 3,2;

-- sort behavior when null values are part of the column

SELECT 
    TrackId, 
    Name, 
    Composer 
FROM 
   track
ORDER BY 
   Composer;
   
-- Nulls Last

SELECT 
    TrackId, 
    Name, 
    Composer 
FROM 
   track
ORDER BY 
   Composer nulls last;
   
-- Nulls First

SELECT 
    TrackId, 
    Name, 
    Composer 
FROM 
   track
ORDER BY 
   Composer nulls first;
   
   
-- Reason Null is considered smaller than any other VALUE in SQL Lite.

-- Select Distinct Behavior Syntax

SELECT DISTINCT	select_list
FROM table;

-- 

SELECT city
FROM customer
ORDER BY city;

-- Use of Distinct 

SELECT distinct city
FROM customer
ORDER BY city;

-- Select Distinct on Multiple Columns

SELECT
	city,
	country
FROM
	customer
ORDER BY
	country;
	
-- Remember the sequence of execution, observe resultant row count

SELECT  DISTINCT
	city,
	country
FROM
	customer
ORDER BY
	country;

-- fields with null value

SELECT company
FROM customer;

-- distinct value on field with null - observe row Country - Note - Null and Empty value is not same.

SELECT distinct company
FROM customer;

-- Restricting Result Using Where Condition

SELECT
	column_list
FROM
	table
WHERE
	search_condition;
	
left_expression COMPARISON_OPERATOR right_expression

WHERE column_1 = 100;

WHERE column_2 IN (1,2,3);

WHERE column_3 LIKE 'An%';

WHERE column_4 BETWEEN 10 AND 20;

Operator	Meaning
=	Equal to
<> or !=	Not equal to
<	Less than
>	Greater than
<=	Less than or equal to
>=	Greater than or equal to
	
-- Using Where Condition Sample

SELECT
   name,
   milliseconds,
   bytes,
   albumid
FROM
   track
WHERE
   albumid = 1;
   
--  Range Filter

SELECT
	name,
	milliseconds,
	bytes,
	albumid
FROM
	track
WHERE
	albumid = 1
AND milliseconds > 250000;

-- Range Filter with Logical Operator

SELECT
	name,
	albumid,
	composer
FROM
	track
WHERE
	composer LIKE '%Smith%'
ORDER BY
	albumid;
	
-- Filter with In List

SELECT
	name,
	albumid,
	mediatypeid
FROM
	track
WHERE
	mediatypeid IN (2, 3);
	
-- Limit Result with row number

SELECT
	column_list
FROM
	table
LIMIT row_count;

-- 

SELECT
	trackId,
	name
FROM
	track
LIMIT 10;


-- 

SELECT
	column_list
FROM
	table
LIMIT row_count OFFSET offset;

-- 

SELECT
	column_list
FROM
	table
LIMIT offset, row_count;

-- 

SELECT
	trackId,
	name
FROM
	track
LIMIT 10 OFFSET 10;

-- Order By & Limit Combination - Most of the Analytical Queries Use this

SELECT
   column_list
FROM
   table
ORDER BY column_1
LIMIT row_count;

-- Find top 10 tracks which is utilizing high storage

SELECT
	trackid,
	name,
	bytes
FROM
	track
ORDER BY
	bytes DESC
LIMIT 10;

-- Find top 5 duration tracks

SELECT
	trackid,
	name,
	milliseconds
FROM
	track
ORDER BY
	milliseconds ASC
LIMIT 5;

-- Find Second Longest Track

SELECT
	trackid,
	name,
	milliseconds
FROM
	track
ORDER BY
	milliseconds DESC
LIMIT 1 OFFSET 1;

-- Find third longest Track

SELECT
	trackid,
	name,
	bytes
FROM
	track
ORDER BY
	bytes
LIMIT 1 OFFSET 2;

-- Usage of Between Operator

test_expression NOT BETWEEN low_expression AND high_expression


SELECT
    InvoiceId,
    BillingAddress,
    Total
FROM
    invoice
WHERE
    Total BETWEEN 14.91 and 18.86    
ORDER BY
    Total; 

	
-- 

SELECT
    InvoiceId,
    BillingAddress,
    Total
FROM
    invoice
WHERE
    Total NOT BETWEEN 1 and 20
ORDER BY
    Total;   

-- 	Range Date Filter (Very Important)

SELECT
    InvoiceId,
    BillingAddress,
    InvoiceDate,
    Total
FROM
    invoice
WHERE
    InvoiceDate BETWEEN '2010-01-01' AND '2010-01-31'
ORDER BY
    InvoiceDate;    

-- Usage of Date Trunc (What is its use?)

SELECT
    InvoiceId,
    BillingAddress,
    date(InvoiceDate) InvoiceDate,
    Total
FROM
    invoice
WHERE
    InvoiceDate NOT BETWEEN '2009-01-03' AND '2013-12-01'
ORDER BY
    InvoiceDate;
	
-- Using In List (Database has limitation on no. of values that can be passed as In List. However, there is a way out - Sub Query)

expression [NOT] IN (value_list|subquery);


SELECT
	TrackId,
	Name,
	Mediatypeid
FROM
	Track
WHERE
	MediaTypeId IN (1, 2)
ORDER BY
	Name ASC;
	
-- Logical OR , AND Operator (Very Powerful to Impliment Business Rules - Entire Decision Tree Can be implemented using this)

SELECT
	TrackId,
	Name,
	MediaTypeId
FROM
	Track
WHERE
	MediaTypeId = 1 OR MediaTypeId = 2
ORDER BY
	Name ASC;
	

-- Find the album composed by specific artist

SELECT albumid
FROM album
WHERE artistid = 12;

-- Sub Query

SELECT
	TrackId, 
	Name, 
	AlbumId
FROM
	Track
WHERE
	AlbumId IN (
		SELECT
			AlbumId
		FROM
			Album
		WHERE
			ArtistId = 12
	);
	
-- Restrictive Genre ID

SELECT
	trackid,
	name,
	genreid
FROM
	track
WHERE
	genreid NOT IN (1, 2,3);
	
-- Syntax for Like Statement

SELECT
	column_list
FROM
	table_name
WHERE
	column_1 LIKE pattern;
	
-- Pattern Matching (Performance Intensive) - Useful for Name Search or using Pattern Matching (regex)

SELECT
	trackid,
	name	
FROM
	track
WHERE
	name LIKE 'Wild%'
	
-- Wild Card Search

SELECT
	trackid,
	name
FROM
	track
WHERE
	name LIKE '%Wild'
	
-- 

SELECT
	trackid,
	name	
FROM
	track
WHERE
	name LIKE '%Wild%';
	

SELECT
	trackid,
	name
FROM
	track
WHERE
	name LIKE '%Br_wn%';
	
-- Using escape characters
	
column_1 LIKE pattern ESCAPE expression;

column_1 LIKE '%10\%%' ESCAPE '\';

CREATE TABLE t(
	c TEXT
);


INSERT INTO t(c)
VALUES('10% increase'),
	('10 times decrease'),
	('100% vs. last year'),
	('20% increase next year');
	

SELECT * FROM t;


SELECT c 
FROM t 
WHERE c LIKE '%10%%';

-- Using ESCAPE

SELECT c 
FROM t 
WHERE c LIKE '%10\%%' ESCAPE '\';

-- Pattern Matching

SELECT
	trackid,
	name
FROM
	track
WHERE
	name GLOB 'Man*';	
	
	
SELECT
	trackid,
	name
FROM
	track
WHERE
	name GLOB '*Man';
	
SELECT
	trackid,
	name
FROM
	track
WHERE
	name GLOB '?ere*';
	

SELECT
	trackid,
	name
FROM
	track
WHERE
	name GLOB '*[1-9]*';
	
--  Does not contain any number

SELECT
	trackid,
	name
FROM
	track
WHERE
	name GLOB '*[^1-9]*';
	
-- whose names end with number

SELECT
	trackid,
	name
FROM
	track
WHERE
	name GLOB '*[1-9]';
	
-- Ends with a number

SELECT
	trackid,
	name
FROM
	track
WHERE
	name GLOB '*[1-9]';	
	
-- Null is not equal to NULL

NULL = NULL

SELECT
    Name, 
    Composer
FROM
    track
WHERE
    Composer = NULL;
	
	

SELECT
    Name, 
    Composer
FROM
    track
WHERE
    Composer IS NULL
ORDER BY 
    Name;   
	
SELECT
    Name, 
    Composer
FROM
    track
WHERE
    Composer IS NOT NULL
ORDER BY 
    Name;     

-- 	JOIN

SELECT 
    Title,
    Name
FROM 
    album
INNER JOIN artist
    ON artist.ArtistId = album.ArtistId;
	
-- Join with Alias

SELECT
    l.Title, 
    r.Name
FROM
    album l
INNER JOIN artist r ON
    r.ArtistId = l.ArtistId;

-- Left Outer JOIN

SELECT
    Name, 
    Title
FROM
    artist
LEFT JOIN album ON
    artist.ArtistId = album.ArtistId
ORDER BY Name;


-- 

SELECT
    Name,
    Title
FROM
    artist
LEFT JOIN album ON
    artist.ArtistId = album.ArtistId
WHERE Title IS NULL   
ORDER BY Name;

-- 

SELECT
    select_list
FROM table1
CROSS JOIN table2;



-- 


CREATE TABLE products(
    product text NOT null
);

INSERT INTO products(product)
VALUES('P1'),('P2'),('P3');



CREATE TABLE calendars(
    y int NOT NULL,
    m int NOT NULL
);

INSERT INTO calendars(y,m)
VALUES 
    (2019,1),
    (2019,2),
    (2019,3),
    (2019,4),
    (2019,5),
    (2019,6),
    (2019,7),
    (2019,8),
    (2019,9),
    (2019,10),
    (2019,11),
    (2019,12);
	
SELECT * 
FROM products
CROSS JOIN calendars;


-- Inner JOIN

SELECT a1, a2, b1, b2
FROM A
INNER JOIN B on B.f = A.f;




SELECT
	trackid,
	name,
	title
FROM
	track
INNER JOIN album ON album.albumid = track.albumid;


SELECT
    trackid,
    name,
    track.albumid AS album_id_tracks,
    album.albumid AS album_id_albums,
    title
FROM
    track
    INNER JOIN album ON album.albumid = track.albumid;
	
	
-- Inner Join with more than two relation/TABLE

SELECT
    trackid,
    track.name AS track,
    album.title AS album,
    artist.name AS artist
FROM
    track
    INNER JOIN album ON album.albumid = track.albumid
    INNER JOIN artist ON artist.artistid = album.artistid;
	
-- Join with Where Condition

SELECT
	trackid,
	track.name AS Track,
	album.title AS Album,
	artist.name AS Artist
FROM
	track
INNER JOIN album ON album.albumid = track.albumid
INNER JOIN artist ON artist.artistid = album.artistid
WHERE
	artist.artistid = 10;
	
-- left join

SELECT
   artist.ArtistId, 
   AlbumId
FROM
   artist
LEFT JOIN album ON
   album.ArtistId = artist.ArtistId
ORDER BY
   AlbumId;
   
--   Can you frame business problem from below query?

SELECT
   artist.ArtistId
   , AlbumId
FROM
   artist
LEFT JOIN album ON
   album.ArtistId = artist.ArtistId
WHERE
   AlbumId IS NULL;
   
--  Right Join is a reverse direction of Left Join. SQL Lite - Does not support right join. However, functionality can be achieved by reversing tables.
-- Can we think how?

-- Key Pointers
-- Left Join is useful in Data Engineering to detect new incoming data based on a key (Can we think how can it be achieved? Hint: Where condition)

-- 	Cross JOIN

SELECT *
FROM A JOIN B;

SELECT *
FROM A
INNER JOIN B;

SELECT *
FROM A
CROSS JOIN B;

SELECT * 
FROM A, B;

-- 

CREATE TABLE ranks (
    rank TEXT NOT NULL
);

CREATE TABLE suits (
    suit TEXT NOT NULL
);

INSERT INTO ranks(rank) 
VALUES('2'),('3'),('4'),('5'),('6'),('7'),('8'),('9'),('10'),('J'),('Q'),('K'),('A');

INSERT INTO suits(suit) 
VALUES('Clubs'),('Diamonds'),('Hearts'),('Spades');

-- How many rows? 

SELECT rank,
       suit
  FROM ranks
       CROSS JOIN
       suits
ORDER BY suit;

-- Full Outer JOIN


-- create and insert data into the dogs table
CREATE TABLE dogs (
    type       TEXT,
    color TEXT
);

INSERT INTO dogs(type, color) 
VALUES('Hunting','Black'), ('Guard','Brown');

-- create and insert data into the cats table
CREATE TABLE cats (
    type       TEXT,
    color TEXT
);

INSERT INTO cats(type,color) 
VALUES('Indoor','White'), 
      ('Outdoor','Black');
	  

SELECT *
FROM dogs 
FULL OUTER JOIN cats
    ON dogs.color = cats.color;
	
-- How to Emulate? Look at table order reversal and Union All.
-- Note to know difference between Union vs Union ALL
-- Replace Using with Ansi SQL Format table.column = table2.column

SELECT d.type,
         d.color,
         c.type,
         c.color
FROM dogs d
LEFT JOIN cats c USING(color)
UNION ALL
SELECT d.type,
         d.color,
         c.type,
         c.color
FROM cats c
LEFT JOIN dogs d USING(color)
WHERE d.color IS NULL;

-- Self JOIN

SELECT m.firstname || ' ' || m.lastname AS 'Manager',
       e.firstname || ' ' || e.lastname AS 'Direct report' 
FROM employee e
INNER JOIN employee m ON m.employeeid = e.reportsto
ORDER BY manager;

-- Can you find number of ppl reporting to Andrew Adams.
-- Can you find who has most number of direct reports?
-- Can you find who is CEO?

-- Remember PEMDA Rule - Paranthesis, Exponential, Multiplication, Division, Addition/Sub (Left to Right)

SELECT DISTINCT
	e1.city,
	e1.firstName || ' ' || e1.lastname AS fullname
FROM
	employee e1
INNER JOIN employee e2 ON e2.city = e1.city 
   AND (e1.firstname <> e2.firstname AND e1.lastname <> e2.lastname)
ORDER BY
	e1.city;
	
-- Group By Clause

SELECT 
    column_1,
    aggregate_function(column_2) 
FROM 
    table
GROUP BY 
    column_1,
    column_2;


-- 	Find an Album and Count of Tracks in each album

SELECT
	albumid,
	COUNT(trackid)
FROM
	track
GROUP BY
	albumid;
	
-- 

SELECT
	albumid,
	COUNT(trackid)
FROM
	track
GROUP BY
	albumid
ORDER BY COUNT(trackid) DESC;


-- Group By after performing Join

SELECT
	track.albumid,
	title,
	COUNT(trackid)
FROM
	track
INNER JOIN album ON album.albumid = track.albumid
GROUP BY
	track.albumid;
	
-- 

SELECT
	track.albumid,
	title,
	COUNT(trackid)
FROM
	track
INNER JOIN album ON album.albumid = track.albumid
GROUP BY
	track.albumid
HAVING COUNT(trackid) > 15;

-- Aggregation Sum with Group By

SELECT
	albumid,
	SUM(milliseconds) length,
	SUM(bytes) size
FROM
	track
GROUP BY
	albumid;
	
-- Very Important for Profiling Data

SELECT
	track.albumid,
	title,
	min(milliseconds),
	max(milliseconds),
	round(avg(milliseconds),2)
FROM
	track
INNER JOIN album ON album.albumid = track.albumid
GROUP BY
	track.albumid;
	
-- Group by Multiple Fields (Whatever field is present in group by clause, must be present in select clause)
	
SELECT
   MediaTypeId, 
   GenreId, 
   COUNT(TrackId)
FROM
   track
GROUP BY
   MediaTypeId, 
   GenreId;
   
--  Group by Using DateTime (Date Time Formatting) - Important for MTD, YTD, WTD type of Analytical functions
--  Many Important Business Questions get answered with this Construct
--  Can you do it with a range filter?

SELECT
   STRFTIME('%Y', InvoiceDate) InvoiceYear, 
   COUNT(InvoiceId) InvoiceCount
FROM
   invoice
GROUP BY
   STRFTIME('%Y', InvoiceDate)
ORDER BY
   InvoiceYear;   
   
--  Usage of Having condition (After grouping and aggregating, How can I restrict?) - Is there any Way to achieve this?

SELECT
	column_1, 
        column_2,
	aggregate_function (column_3)
FROM
	table
GROUP BY
	column_1,
        column_2
HAVING
	search_condition;   
	

 SELECT
	albumid,
	COUNT(trackid)
FROM
	track
GROUP BY
	albumid;
	
-- 

SELECT
	albumid,
	COUNT(trackid)
FROM
	track
GROUP BY
	albumid
HAVING albumid = 1;
   
 
   
-- Find Album with tracks between 18 and 20
SELECT
   albumid,
   COUNT(trackid)
FROM
   track
GROUP BY
   albumid
HAVING 
   COUNT(albumid) BETWEEN 18 AND 20
ORDER BY albumid;


-- 


SELECT
	track.AlbumId,
	title,
	SUM(Milliseconds) AS length
FROM
	track
INNER JOIN album ON album.AlbumId = track.AlbumId
GROUP BY
	track.AlbumId 
HAVING
	length > 60000000;
	
	
-- Union Operation

query_1
UNION [ALL]
query_2
UNION [ALL]
query_3
...;


CREATE TABLE t1(
    v1 INT
);
 
INSERT INTO t1(v1)
VALUES(1),(2),(3);
 
CREATE TABLE t2(
    v2 INT
);
INSERT INTO t2(v2)
VALUES(2),(3),(4);

SELECT v1
  FROM t1
UNION
SELECT v2
  FROM t2;
  
SELECT v1
  FROM t1
UNION ALL
SELECT v2
  FROM t2;
  
SELECT FirstName, LastName, 'Employee' AS Type
FROM employee
UNION
SELECT FirstName, LastName, 'Customer'
FROM customer;


SELECT FirstName, LastName, 'Employee' AS Type
FROM employee
UNION
SELECT FirstName, LastName, 'Customer'
FROM customer
ORDER BY FirstName, LastName;

-- Minus Operation

SELECT select_list1
FROM table1
EXCEPT
SELECT select_list2
FROM table2

-- 

CREATE TABLE t1(
    v1 INT
);

INSERT INTO t1(v1)
VALUES(1),(2),(3);

CREATE TABLE t2(
    v2 INT
);

INSERT INTO t2(v2)
VALUES(2),(3),(4);


SELECT v1
FROM t1
EXCEPT 
SELECT v2
FROM t2;
  
	SELECT ArtistId
FROM artist
EXCEPT
SELECT ArtistId
FROM album;

-- Intersect Operator

SELECT select_list1
FROM table1
INTERSECT
SELECT select_list2
FROM table2

CREATE TABLE t1(
    v1 INT
);

INSERT INTO t1(v1)
VALUES(1),(2),(3);

CREATE TABLE t2(
    v2 INT
);
INSERT INTO t2(v2)
VALUES(2),(3),(4);


SELECT v1
FROM t1
INTERSECT
SELECT v2
FROM t2;

-- Customers who have made one purchase 

SELECT CustomerId
FROM customer
INTERSECT
SELECT CustomerId
FROM invoice
ORDER BY CustomerId;

-- Sub QUERY

SELECT column_1
FROM table_1
WHERE column_1 = (
   SELECT column_1 
   FROM table_2
);

SELECT column_1
  FROM table_1
 WHERE colum_1 = (SELECT column_1
  FROM table_2)
  
  
 SELECT trackid,
       name,
       albumid
FROM track
WHERE albumid = (
   SELECT albumid
   FROM album
   WHERE title = 'Let There Be Rock'
);


SELECT customerid,
       firstname,
       lastname
  FROM customer
 WHERE supportrepid IN (
           SELECT employeeid
             FROM employee
            WHERE country = 'Canada'
       );
	   
-- Qutime Why is the below query errors out?

SELECT AVG(SUM(bytes) 
FROM tracks
GROUP BY albumid;


SELECT
	AVG(album.size)
FROM
	(
		SELECT
			SUM(bytes) SIZE
		FROM
			track
		GROUP BY
			albumid
	) AS album;
	
-- Correlated Sub Query --
-- For each outer row, Inner row operation is performed

SELECT albumid,
       title
  FROM album
 WHERE 10000000 > (
                      SELECT sum(bytes) 
                        FROM track
                       WHERE track.AlbumId = album.AlbumId
                  )
 ORDER BY title;

-- Order of Execution Matters. Pls reason out below

SELECT albumid,
       title,
       (
           SELECT count(trackid) 
             FROM track
            WHERE track.AlbumId = album.AlbumId
       )
       tracks_count
  FROM album
 ORDER BY tracks_count DESC;
 
--  Usage of Exists Clause
-- Provide list of customers who have made atleast minimum one purchase
SELECT
    CustomerId,
    FirstName,
    LastName,
    Company
FROM
    Customer c
WHERE
    EXISTS (
        SELECT 
            1 
        FROM 
            Invoice
        WHERE 
            CustomerId = c.CustomerId
    )
ORDER BY
    FirstName,
    LastName; 

-- Usage of In - Instead of Exist (Which one is optimal?)
	
SELECT
   CustomerId, 
   FirstName, 
   LastName, 
   Company
FROM
   Customer c
WHERE
   CustomerId IN (
      SELECT
         CustomerId
      FROM
         Invoice
   )
ORDER BY
   FirstName, 
   LastName;
   
--  Find Artist who has not authored any Album

SELECT
   *
FROM
   Artist a
WHERE
   NOT EXISTS(
      SELECT
         1
      FROM
         Album
      WHERE
         ArtistId = a.ArtistId
   )
ORDER BY Name;

-- Most Important Statement for applying Categorical Selection of rows and qualify the same for aggregation (Critical for data visualization)
-- Most of the data analysis question will revolve around this.

CASE case_expression
     WHEN when_expression_1 THEN result_1
     WHEN when_expression_2 THEN result_2
     ...
     [ ELSE result_else ] 
END


SELECT customerid,
       firstname,
       lastname,
       CASE country 
           WHEN 'USA' 
               THEN 'Domestic' 
           ELSE 'Foreign' 
       END CustomerGroup
FROM 
    customer
ORDER BY 
    LastName,
    FirstName;
	
	
SELECT
	trackid,
	name,
	CASE
		WHEN milliseconds < 60000 THEN
			'short'
		WHEN milliseconds > 60000 AND milliseconds < 300000 THEN 'medium'
		ELSE
			'long'
		END category
FROM
	track;
	
-- SQL Insert Statement

INSERT INTO table1 (column1,column2 ,..)
VALUES 
   (value1,value2 ,...),
   (value1,value2 ,...),
    ...
   (value1,value2 ,...);

  
--  INSERT

INSERT INTO artist (name)
VALUES
	("Buddy Rich"),
	("Candido"),
	("Charlie Byrd");

SELECT
	ArtistId,
	Name
FROM
	artist
ORDER BY
	ArtistId DESC
LIMIT 3;


INSERT INTO artist DEFAULT VALUES;	

SELECT
	ArtistId,
	Name
FROM
	artist
ORDER BY
	ArtistId DESC;
	
-- 

CREATE TABLE artists_backup(
   ArtistId INTEGER PRIMARY KEY AUTOINCREMENT,
   Name NVARCHAR
);

-- How to take a table back up
-- Equivalent to Create Table as SELECT

INSERT INTO artists_backup 
SELECT ArtistId, Name
FROM artist;


SELECT * FROM artists_backup;

-- Update Statement Syntax

UPDATE table
SET column_1 = new_value_1,
    column_2 = new_value_2
WHERE
    search_condition 
ORDER column_or_expression
LIMIT row_count OFFSET offset;

-- 

SELECT
	employeeid,
	firstname,
	lastname,
	title,
	email
FROM
	employee;
	
-- Update single column with restrictive FILTER

UPDATE employee
SET lastname = 'Smith'
WHERE employeeid = 3;	

-- Update Multiple columns with restrictive FILTER

UPDATE employee
SET city = 'Toronto',
    state = 'ON',
    postalcode = 'M5P 2N7'
WHERE
    employeeid = 4;
	
-- Validate post UPDATE

SELECT
	employeeid,
	firstname,
	lastname,
	state,
	city,
	PostalCode
FROM
	employee
WHERE
	employeeid = 4;
	
	
SELECT
	employeeid,
	firstname,
	lastname,
	email
FROM
	employee;
	

	

UPDATE employee
SET email = lower(
	firstname || "." || lastname || "@chinookcorp.com"
)
;

-- Delete Statement

 DELETE FROM table
WHERE search_condition;


 DELETE FROM table
WHERE search_condition
ORDER BY criteria
LIMIT row_count OFFSET offset;


-- create artists backup table
CREATE TABLE artists_backup(
   artistid INTEGER PRIMARY KEY AUTOINCREMENT,
   name NVARCHAR
);

-- populate data from the artists table
INSERT INTO artists_backup 
SELECT artistid,name
FROM artist;

-- How do we resolve above error?

SELECT
	artistid,
	name
FROM
	artists_backup;


DELETE FROM artists_backup
WHERE artistid = 1;

DELETE FROM artists_backup
WHERE name LIKE '%Santana%';


DELETE FROM artists_backup;


SQLite & ACID
SQLite is a transactional database that all changes and queries are atomic, consistent, isolated, and durable (ACID).

SQLite guarantees all the transactions are ACID compliant even if the transaction is interrupted by a program crash, operation system dump, or power failure to the computer.

Atomic: a transaction should be atomic. It means that a change cannot be broken down into smaller ones. When you commit a transaction, either the entire transaction is applied or not.
Consistent: a transaction must ensure to change the database from one valid state to another. When a transaction starts and executes a statement to modify data, the database becomes inconsistent. However, when the transaction is committed or rolled back, it is important that the transaction must keep the database consistent.
Isolation: a pending transaction performed by a session must be isolated from other sessions. When a session starts a transaction and executes the INSERT or UPDATE statement to change the data, these changes are only visible to the current session, not others. On the other hand, the changes committed by other sessions after the transaction started should not be visible to the current session.
Durable: if a transaction is successfully committed, the changes must be permanent in the database regardless of the condition such as power failure or program crash. On the contrary, if the program crashes before the transaction is committed, the change should not persist.


BEGIN TRANSACTION;
COMMIT;
ROLLBACK;


drop table accounts;

CREATE TABLE accounts ( 
	account_no INTEGER NOT NULL, 
	balance DECIMAL NOT NULL DEFAULT 0,
	PRIMARY KEY(account_no),
        CHECK(balance >= 0)
);

drop table account_changes;

CREATE TABLE account_changes (
	change_no INT NOT NULL PRIMARY KEY,
	account_no INTEGER NOT NULL, 
	flag TEXT NOT NULL, 
	amount DECIMAL NOT NULL, 
	changed_at TEXT NOT NULL 
);

INSERT INTO accounts (account_no,balance)
VALUES (100,20100);

INSERT INTO accounts (account_no,balance)
VALUES (200,10100);

SELECT * FROM accounts;

SELECT * FROM account_changes;

commit;

END TRANSACTION;

BEGIN TRANSACTION;

UPDATE accounts
   SET balance = balance - 1000
 WHERE account_no = 100;

UPDATE accounts
   SET balance = balance + 1000
 WHERE account_no = 200;
 
INSERT INTO account_changes(change_no, account_no,flag,amount,changed_at) 
VALUES(1,100,'-',1000,datetime('now'));

INSERT INTO account_changes(change_no, account_no,flag,amount,changed_at) 
VALUES(2,200,'+',1000,datetime('now'));

COMMIT;

SELECT * FROM account_changes;

end TRANSACTION;

BEGIN TRANSACTION;

UPDATE accounts
   SET balance = balance - 20000
 WHERE account_no = 100;

INSERT INTO account_changes(change_no,account_no,flag,amount,changed_at) 
VALUES(3,100,'-',20000,datetime('now'));

-- Note that previous existing record is consistent.

SELECT * FROM account_changes;

-- what if end transaction is used?

ROLLBACK;

SELECT * FROM account_changes;

end TRANSACTION;

-- Data type

SELECT
	typeof(100),
	typeof(10.0),
	typeof('100'),
	typeof(x'1000'),
	typeof(NULL);
	
	
CREATE TABLE test_datatypes (
	id INTEGER PRIMARY KEY,
	val
);


INSERT INTO test_datatypes (val)
VALUES
	(1),
	(2),
	(10.1),
	(20.5),
	('A'),
	('B'),
	(NULL),
	(x'0010'),
	(x'0011');

	
SELECT
	id,
	val,
	typeof(val)
FROM
	test_datatypes;
	
-- datetime

CREATE TABLE datetime_text(
   d1 text, 
   d2 text
);

SELECT datetime('now');

SELECT datetime('now','localtime');

INSERT INTO datetime_text (d1, d2)
VALUES(datetime('now'),datetime('now', 'localtime'));

INSERT INTO datetime_text (d1, d2)
VALUES(datetime('now'),datetime('now', 'localtime'));

SELECT
	d1,
	typeof(d1),
	d2,
	typeof(d2)
FROM
	datetime_text;
	
	
CREATE TABLE datetime_real(
   d1 real
);


INSERT INTO datetime_real (d1)
VALUES(julianday('now'));


SELECT d1 FROM datetime_real;


SELECT
	date(d1),
	time(d1)
FROM
	datetime_real;
	
CREATE TABLE datetime_int (d1 int);

INSERT INTO datetime_int (d1)
VALUES(strftime('%s','now'));

SELECT datetime(d1,'unixepoch')
FROM datetime_int;


-- Create Statement

CREATE TABLE contact_groups(
   contact_id INTEGER,
   group_id INTEGER,
   PRIMARY KEY (contact_id, group_id),
   FOREIGN KEY (contact_id) 
      REFERENCES contacts (contact_id) 
         ON DELETE CASCADE 
         ON UPDATE NO ACTION,
   FOREIGN KEY (group_id) 
      REFERENCES groups (group_id) 
         ON DELETE CASCADE 
         ON UPDATE NO ACTION
);

-- Views

SELECT
   trackid,
   track.name,
   album.Title AS album,
   media_type.Name AS media,
   genre.Name AS genres
FROM
   track
INNER JOIN album ON Album.AlbumId = track.AlbumId
INNER JOIN media_type ON media_type.MediaTypeId = track.MediaTypeId
INNER JOIN genre ON genre.GenreId = track.GenreId;


CREATE VIEW v_tracks 
AS 
SELECT
   trackid,
   track.name,
   album.Title AS album,
   media_type.Name AS media,
   genre.Name AS genres
FROM
   track
INNER JOIN album ON Album.AlbumId = track.AlbumId
INNER JOIN media_type ON media_type.MediaTypeId = track.MediaTypeId
INNER JOIN genre ON genre.GenreId = track.GenreId;

SELECT * FROM v_tracks;


drop view v_albums;
CREATE VIEW v_albums (
    AlbumTitle,
    Minutes
)
AS
    SELECT album.title,
           SUM(milliseconds) / 60000
      FROM track
           INNER JOIN
           album USING (
               AlbumId
           )
     GROUP BY Album.Title;
	 
SELECT * FROM v_albums;



drop view if EXISTS view_name;

--Index Creation
 
CREATE TABLE contacts (
	first_name text NOT NULL,
	last_name text NOT NULL,
	email text NOT NULL
);


CREATE UNIQUE INDEX idx_contacts_email 
ON contacts (email);

INSERT INTO contacts (first_name, last_name, email)
VALUES('John','Doe','john.doe@sqlitetutorial.net');

-- Query PLAN

EXPLAIN QUERY PLAN 
SELECT
	first_name,
	last_name,
	email
FROM
	contacts
WHERE
	email = 'lisa.smith@sqlitetutorial.net';


-- Trigger

	
--Database TRIGGER
 
CREATE TRIGGER [IF NOT EXISTS] trigger_name 
   [BEFORE|AFTER|INSTEAD OF] [INSERT|UPDATE|DELETE] 
   ON table_name
   [WHEN condition]
BEGIN
 statements;
END;


-- 

CREATE TABLE leads (
	id integer PRIMARY KEY,
	first_name text NOT NULL,
	last_name text NOT NULL,
	phone text NOT NULL,
	email text NOT NULL,
	source text NOT NULL
);


CREATE TRIGGER validate_email_before_insert_leads 
   BEFORE INSERT ON leads
BEGIN
   SELECT
      CASE
	WHEN NEW.email NOT LIKE '%_@__%.__%' THEN
   	  RAISE (ABORT,'Invalid email address')
       END;
END;

INSERT INTO leads (first_name,last_name,email,phone)
VALUES('John','Doe','jjj','4089009334');


SELECT
	first_name,
	last_name,
	email,
	phone
FROM
	leads;
	
	
CREATE TABLE lead_logs (
	id INTEGER PRIMARY KEY,
	old_id int,
	new_id int,
	old_phone text,
	new_phone text,
	old_email text,
	new_email text,
	user_action text,
	created_at text
);


CREATE TRIGGER log_contact_after_update 
   AFTER UPDATE ON leads
   WHEN old.phone <> new.phone
        OR old.email <> new.email
BEGIN
	INSERT INTO lead_logs (
		old_id,
		new_id,
		old_phone,
		new_phone,
		old_email,
		new_email,
		user_action,
		created_at
	)
VALUES
	(
		old.id,
		new.id,
		old.phone,
		new.phone,
		old.email,
		new.email,
		'UPDATE',
		DATETIME('NOW')
	) ;
END;

UPDATE leads
SET 
   last_name = 'Smith'
WHERE
   id = 1;
   
   
 UPDATE leads
SET 
   phone = '4089998888',
   email = 'john.smith@sqlitetutorial.net'
WHERE
   id = 1;
   
 SELECT
   old_phone, 
   new_phone, 
   old_email, 
   new_email, 
   user_action
FROM
   lead_logs;
   

--   Rank over partition by clause (Very useful analytic function)   
   
   DENSE_RANK() OVER (
	PARTITION BY expression1, expression2,...
	ORDER BY expression1 [ASC | DESC], expression2,..
)

-- 

CREATE TABLE DenseRankDemo (
	Val TEXT
);

INSERT INTO DenseRankDemo(Val)
VALUES('A'),('B'),('C'),('C'),('D'),('D'),('E');

SELECT
	Val,
	DENSE_RANK () OVER ( 
		ORDER BY Val ) 
	ValRank 
FROM
	DenseRankDemo;

	
SELECT
	AlbumId,
	Name,
	Milliseconds,
	DENSE_RANK () OVER ( 
		PARTITION BY AlbumId 
		ORDER BY Milliseconds 
	) LengthRank
FROM
	track;
	
	
SELECT
    Name,
    printf('%,d',Bytes) Size,
    FIRST_VALUE(Name) OVER (
        ORDER BY Bytes
    ) AS SmallestTrack
FROM
    track
WHERE
    AlbumId = 1;
	
	
SELECT
    AlbumId,
    Name,
    printf('%,d',Bytes) Size,
    FIRST_VALUE(Name) OVER (
        PARTITION BY AlbumId
        ORDER BY Bytes DESC
    ) AS LargestTrack
FROM
    track;

 
	
-- Lead Function --

CREATE VIEW CustomerInvoices
AS
SELECT
	CustomerId,
	strftime('%Y',InvoiceDate) Year,
	SUM( total ) Total
FROM
	invoice
	GROUP BY CustomerId, strftime('%Y',InvoiceDate);
	
-- 
SELECT
	* 
FROM
	CustomerInvoices 
ORDER BY
	CustomerId,
	Year,
	Total;


	
-- CY, LY Comparison Query (Analytic Query - Very Important)

SELECT
	CustomerId,
	Year,
	Total,
	LEAD ( Total,1,0) OVER ( ORDER BY Year ) NextYearTotal
FROM
	CustomerInvoices 
WHERE
	CustomerId = 1;


	
SELECT
	CustomerId,
	Year,
	Total,
	LAG ( Total, 1, 0 ) OVER ( 
		ORDER BY Year 
	) PreviousYearTotal 
FROM
	CustomerInvoices
WHERE
	CustomerId = 4;
	
	
-- Find Longest Track In Every Album

SELECT
    AlbumId,
    Name,
    Milliseconds Length,
    NTH_VALUE ( Name,2 ) OVER (
        PARTITION BY AlbumId
        ORDER BY Milliseconds DESC
        RANGE BETWEEN 
            UNBOUNDED PRECEDING AND 
            UNBOUNDED FOLLOWING
    ) AS SecondLongestTrack 
FROM
    track;
	
-- Data Science Queries

SELECT
	AlbumId,
	Name,
	Milliseconds,
	NTILE ( 3 ) OVER ( 
		PARTITION BY AlbumId
		ORDER BY Bytes ) SizeBucket
FROM
	track;
	
-- What does the below query do?

SELECT
    Name,
    Milliseconds,
    printf('%.2f',PERCENT_RANK() OVER( 
        ORDER BY Milliseconds 
    )) LengthPercentRank
FROM
    track
WHERE
    AlbumId = 1;
	
-- What does the below query do?

SELECT 
	* 
FROM (
	SELECT
		Name,
		Milliseconds,
		AlbumId,
		RANK () OVER ( 
			PARTITION BY AlbumId
			ORDER BY Milliseconds DESC
		) LengthRank 
	FROM
		track
) 
WHERE 
	LengthRank = 2;




