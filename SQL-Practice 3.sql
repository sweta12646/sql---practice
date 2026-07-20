/* ============================================================
   PRACTICE ASSIGNMENT: CONSTRAINTS (PK, FK, NOT NULL, UNIQUE,
   CHECK, DEFAULT) ACROSS FOUR CONNECTED TABLES
   Scenario: Library Management System

   Tables and how they connect:
     Authors  --(author_id)-->  Books
     Books    --(book_id)-->    Transactions
     Members  --(member_id)-->  Transactions

   So Transactions is linked to BOTH Books and Members.
   ============================================================

   WHAT YOU NEED TO DO:
   1. Write the CREATE TABLE statement for each table below,
      following the constraint requirements given in the comments.
   2. Insert 10 rows of realistic data into EACH table.
   3. Create tables and insert data in this ORDER: Authors, Books,
      Members, Transactions (parent tables must exist and have
      data before child tables can reference them).
   4. Write the constraint-violation INSERT statements to test
      each constraint (they should fail when run).
   ============================================================ */


/* ------------------------------------------------------------
   TABLE 1: Authors  (Parent table)
   ------------------------------------------------------------
   1. author_id     -> uniquely identifies each author, cannot be empty
   2. author_name   -> cannot be left empty
   3. country        -> should default to 'India' if not specified
   4. birth_year     -> must only allow years between 1800 and 2015

   Write your CREATE TABLE statement below:
   ------------------------------------------------------------ */
create database practices3;
use practices3;

CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) DEFAULT 'India',
    birth_year INT CHECK (birth_year BETWEEN 1800 AND 2015)
);





/* Insert 10 rows into Authors.
   At least 2 rows should rely on the DEFAULT country. */


INSERT INTO Authors VALUES
(1,'Chetan Bhagat','India',1974),
(2,'J.K. Rowling','United Kingdom',1965),
(3,'Dan Brown','USA',1964),
(4,'Ruskin Bond',DEFAULT,1934),
(5,'R.K. Narayan',DEFAULT,1906),
(6,'Paulo Coelho','Brazil',1947),
(7,'Arundhati Roy','India',1961),
(8,'Amish Tripathi','India',1974),
(9,'Sudha Murty','India',1950),
(10,'George Orwell','United Kingdom',1903);

select * from Authors;


/* ------------------------------------------------------------
   TABLE 2: Books  (Child of Authors)
   ------------------------------------------------------------
   1. book_id         -> uniquely identifies each book, cannot be empty
   2. title            -> cannot be left empty
   3. isbn              -> must be unique across all books
   4. price              -> must only allow positive values, and
                             should default to 299.00 if not specified
   5. published_year     -> must only allow years between 1900 and 2026
   6. author_id           -> must reference a valid author from the
                              Authors table (Foreign Key)

   Write your CREATE TABLE statement below:
   ------------------------------------------------------------ */
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    price DECIMAL(8,2) DEFAULT 299.00 CHECK(price>0),
    published_year INT CHECK(published_year BETWEEN 1900 AND 2026),
    author_id INT,
    FOREIGN KEY(author_id) REFERENCES Authors(author_id)
);



/* Insert 10 rows into Books.
   Distribute books across the author_id values from Authors.
   At least 2 rows should rely on the DEFAULT price. */

INSERT INTO Books VALUES
(101,'Five Point Someone','ISBN001',350,2004,1),
(102,'Harry Potter','ISBN002',650,1997,2),
(103,'The Da Vinci Code','ISBN003',550,2003,3),
(104,'The Blue Umbrella','ISBN004',DEFAULT,1980,4),
(105,'Malgudi Days','ISBN005',DEFAULT,1943,5),
(106,'The Alchemist','ISBN006',400,1988,6),
(107,'The God of Small Things','ISBN007',500,1997,7),
(108,'The Immortals of Meluha','ISBN008',450,2010,8),
(109,'Wise and Otherwise','ISBN009',320,2002,9),
(110,'Animal Farm','ISBN010',280,1945,10);

select * from Books;


/* ------------------------------------------------------------
   TABLE 3: Members  (Parent table)
   ------------------------------------------------------------
   1. member_id      -> uniquely identifies each member, cannot be empty
   2. member_name    -> cannot be left empty
   3. age              -> must only allow members aged 12 or older
   4. email             -> must be unique across all members
   5. membership_type   -> should default to 'Standard' if not specified

   Write your CREATE TABLE statement below:
   ------------------------------------------------------------ */
CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(100) NOT NULL,
    age INT CHECK(age>=12),
    email VARCHAR(100) UNIQUE,
    membership_type VARCHAR(30) DEFAULT 'Standard'
);



/* Insert 10 rows into Members.
   At least 2 rows should rely on the DEFAULT membership_type.
   At least 1 row should have a NULL email (optional but unique
   when provided). */


INSERT INTO Members VALUES
(1,'Rahul Sharma',22,'rahul@gmail.com','Premium'),
(2,'Priya Das',19,'priya@gmail.com',DEFAULT),
(3,'Amit Kumar',30,'amit@gmail.com','Standard'),
(4,'Sneha Patel',25,NULL,DEFAULT),
(5,'Rohit Verma',28,'rohit@gmail.com','Premium'),
(6,'Neha Singh',20,'neha@gmail.com','Gold'),
(7,'Karan Mehta',32,'karan@gmail.com','Standard'),
(8,'Anjali Roy',18,'anjali@gmail.com',DEFAULT),
(9,'Vikash Das',24,'vikash@gmail.com','Premium'),
(10,'Pooja Mishra',29,'pooja@gmail.com','Gold');

select * from Members;



/* ------------------------------------------------------------
   TABLE 4: Transactions  (Child of Books AND Members)
   ------------------------------------------------------------
   1. transaction_id  -> uniquely identifies each transaction, cannot be empty
   2. book_id           -> must reference a valid book from the
                            Books table (Foreign Key)
   3. member_id          -> must reference a valid member from the
                             Members table (Foreign Key)
   4. issue_date          -> cannot be left empty
   5. return_date          -> no constraint (can be NULL if not yet returned)
   6. status                -> should default to 'Issued' if not specified
   7. fine                   -> must only allow values of 0 or more, and
                                 should default to 0.00 if not specified

   Write your CREATE TABLE statement below:
   ------------------------------------------------------------ */
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    issue_date DATE NOT NULL,
    return_date DATE,
    status VARCHAR(30) DEFAULT 'Issued',
    fine DECIMAL(8,2) DEFAULT 0.00 CHECK(fine>=0),
    FOREIGN KEY(book_id) REFERENCES Books(book_id),
    FOREIGN KEY(member_id) REFERENCES Members(member_id)
);



/* Insert 10 rows into Transactions.
   Mix book_id and member_id values from the tables above.
   At least 2 rows should rely on the DEFAULT status and/or fine.
   At least 2 rows should have a NULL return_date (not yet returned). */

INSERT INTO Transactions VALUES
(1001,101,1,'2026-01-10','2026-01-20','Returned',0),
(1002,102,2,'2026-01-15',NULL,DEFAULT,DEFAULT),
(1003,103,3,'2026-02-01','2026-02-10','Returned',20),
(1004,104,4,'2026-02-05',NULL,DEFAULT,DEFAULT),
(1005,105,5,'2026-02-10','2026-02-18','Returned',0),
(1006,106,6,'2026-02-15','2026-02-25','Returned',15),
(1007,107,7,'2026-03-01',NULL,'Issued',0),
(1008,108,8,'2026-03-05','2026-03-12','Returned',0),
(1009,109,9,'2026-03-10',NULL,'Issued',5),
(1010,110,10,'2026-03-15','2026-03-22','Returned',0);

select * from Transactions;



/* ============================================================
   CONSTRAINT-BREAKING DEMOS
   Write ONE INSERT statement for each case below. Run it,
   note the error, then write down (as a comment) which
   constraint caused it to fail.
   ============================================================ */

-- 1. Insert an Author with a NULL author_name
INSERT INTO Authors(author_id,author_name,country,birth_year)
VALUES(11,NULL,'India',1980);  #--Fails because author_name is NOT NULL



-- 2. Insert an Author with birth_year = 1750 (violates CHECK)
INSERT INTO Authors
VALUES(12,'Old Author','India',1750); # check violation


-- 3. Insert a Book with a duplicate isbn
INSERT INTO Books
VALUES(111,'Duplicate ISBN','ISBN001',350,2020,1); #unique violation


-- 4. Insert a Book with price = -100 (violates CHECK)
insert INTO Books
VALUES(112,'Negative Price','ISBN011',-100,2021,1); #check violation

-- 5. Insert a Book with an author_id that does not exist in Authors
--    (violates FOREIGN KEY)
INSERT INTO Books
VALUES(113,'Unknown Author','ISBN012',300,2022,99); #foreign violation


-- 6. Insert a Member with a duplicate member_id
INSERT INTO Members
VALUES(1,'Duplicate Member',20,'duplicate@gmail.com','Standard');  #primary key violation


-- 7. Insert a Member with age = 9 (violates CHECK)
insert into Members
VALUES(11,'Young Member',9,'young@gmail.com','Standard'); #check violation


-- 8. Insert a Member with a duplicate email
insert into Members
VALUES(12,'Another Member',25,'rahul@gmail.com','Standard'); #UNIQUE violation


-- 9. Insert a Transaction with a book_id that does not exist in Books
--    (violates FOREIGN KEY)
INSERT INTO Transactions
VALUES(1011,999,1,'2026-04-01',NULL,'Issued',0); #foreign key violation

-- 10. Insert a Transaction with a member_id that does not exist in Members
--     (violates FOREIGN KEY)
INSERT INTO Transactions
VALUES(1012,101,999,'2026-04-02',NULL,'Issued',0); #foreign key violation

-- 11. Insert a Transaction with a NULL issue_date

INSERT INTO Transactions
VALUES(1013,101,1,NULL,NULL,'Issued',0);# no null violation

-- 12. Insert a Transaction with fine = -50 (violates CHECK)
INSERT INTO Transactions
VALUES(1014,101,1,'2026-04-10',NULL,'Issued',-50); #check violation

