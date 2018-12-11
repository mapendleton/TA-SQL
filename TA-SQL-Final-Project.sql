
CREATE DATABASE TA_Library;
GO

/*CREATE TABLES*/

CREATE TABLE tbl_Library_Branch (
	Branch_ID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	Branch_Name VARCHAR(50) NOT NULL,
	Branch_Address VARCHAR(100) NOT NULL
);

CREATE TABLE tbl_Books (
	Book_ID INT PRIMARY KEY NOT NULL IDENTITY (1000,1),
	Book_Title VARCHAR(50) NOT NULL,
	Book_Publisher_Name VARCHAR(50) NOT NULL CONSTRAINT fk_Publisher_Name FOREIGN KEY REFERENCES tbl_Publisher(Publisher_Name) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tbl_Publisher (
	Publisher_Name VARCHAR(50) PRIMARY KEY NOT NULL,
	Publisher_Address VARCHAR(100) NOT NULL,
	Publisher_Phone VARCHAR(10) NOT NULL
);

CREATE TABLE tbl_Borrower (
	Borrower_CardNo INT PRIMARY KEY NOT NULL IDENTITY (2000,1),
	Borrower_Name VARCHAR(50) NOT NULL,
	Borrower_Address VARCHAR(100) NOT NULL,
	Borrower_Phone VARCHAR(10) NOT NULL
);

CREATE TABLE tbl_Book_Authors (
	Authors_Book_ID INT NOT NULL CONSTRAINT fk_Book_ID FOREIGN KEY REFERENCES tbl_Books(Book_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	Authors_Name VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_Book_Copies (
	Copies_Book_ID INT NOT NULL CONSTRAINT fk_Book_ID FOREIGN KEY REFERENCES tbl_Books(Book_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	Copies_Branch_ID INT NOT NULL CONSTRAINT fk_Branch_ID FOREIGN KEY REFERENCES tbl_Library_Branch(Branch_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	Copies_Num_Of_Copies INT NOT NULL
);

CREATE TABLE tbl_Book_Loans (
	Loans_Book_ID INT NOT NULL CONSTRAINT fk_Book_ID FOREIGN KEY REFERENCES tbl_Books(Book_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	Loans_Branch_ID INT NOT NULL CONSTRAINT fk_Branch_ID FOREIGN KEY REFERENCES tbl_Library_Branch(Branch_ID) ON UPDATE CASCADE ON DELETE CASCADE,
	Loans_CardNo INT NOT NULL CONSTRAINT fk_CardNo FOREIGN KEY REFERENCES tbl_Borrower(Borrower_CardNo) ON UPDATE CASCADE ON DELETE CASCADE,
	Loans_Date_Out DATE NOT NULL,
	Loans_Date_Due DATE NOT NULL
);

/*FILL IN TABLES WITH DATA*/

INSERT INTO tbl_Library_Branch
	(Branch_Name,Branch_Address)
	VALUES
	('Sharpstown','12345 Sharp St, Sharpstown, SP, 33050'),
	('Central','22342 Central Ave, Dulltown, SP, 33151'),
	('Downtown','59082 Main St, Lefttown, SP, 08403'),
	('Uptown','22090 2nd St, Righttown, SP, 18405')
;
SELECT * FROM tbl_Libray_Branch;

INSERT INTO tbl_Books
	(Book_Title,Book_Publisher_Name)
	VALUES
	('IT','Viking'),
	('The Outsider','Scribner'),
	('The Shining','Doubleday'),
	('Misery','Viking'),
	('Carrie','Doubleday'),
	('The Lightning Thief','Miramax Books'),
	('The Hidden Oracle','Disney-Hyperion'),
	('The Sword of Summer','Disney-Hyperion'),
	('The Enemy','Disney Publishing Worldwide'),
	('The Dead','Puffin Books'),
	('The Lord of the Rings','Allen & Unwin'),
	('Fantastic Beasts & Where to Find Them', 'Scholastic'),
	('Mere Christianity','Geoffrey Bles'),
	('Ulysses','Sylvia Beach'),
	('Moby Dick','Harper & Brothers'),
	('War and Peace','The Russian Messenger'),
	('The Adventures of Huckleberry Finn','Chatto & Windus'),
	('Pride and Prejudice','T.Egerton'),
	('The Catcher in the Rye','Little, Brown and Company'),
	('The Kite Runner','Riverhead Books')
	('The Lost Tribe','Cool Publisher')
;





/*DECLARE VARIABLE FOR AUTHORS W/MULTIPLE BOOKS*/
DECLARE @SKing VARCHAR(15),@RRiordan VARCHAR(15);
SET @SKing = 'Stephen King',@RRiordan = 'Rick Riordan';

INSERT INTO tbl_Book_Authors
	(Authors_Book_ID,Authors_Name)
	VALUES
	(1,@SKing),
	(2,@Sking),
	(3,@SKing),
	(4,@SKing),
	(5,@SKing),
	(6,@RRiordan),
	(7,@RRiordan),
	(8,@RRiordan),
	(9,'Charlie Higson'),
	(10,'Charlie Higson'),
	(11,'J.R.R. Tolkien'),
	(12,'J.K. Rowling'),
	(13,'C.S. Lewis'),
	(14,'James Joyce'),
	(15,'Herman Melville'),
	(16,'Leo Tolstoy'),
	(17,'Mark Twain'),
	(18,'Jane Austen'),
	(19,'J.D. Salinger'),
	(20,'Khaled Hosseini'),
	(21,'L. Tribe')
;

INSERT INTO tbl_Publisher
	(Publisher_Name,Publisher_Address,Publisher_Phone)
	VALUES
	('Viking','12345 blah st, blah, 44444','123-456-7890'),
	('Scribner'),
	('Doubleday'),
	('Miramax Books'),
	('Disney-Hyperion'),
	('Disney Publishing Worldwide'),
	('Puffin Books'),
	('Allen & Unwin'),
	('Scholastic'),
	('Geoffrey Bles'),
	('Sylvia Beach'),
	('Harper & Brothers'),
	('The Russian Messenger'),
	('Chatto & Windus'),
	('T.Egerton'),
	('Little, Brown and Company'),
	('Riverhead Books')
	('Cool Publisher')





	