
CREATE DATABASE TA_Library;
GO

USE TA_Library_Test;
GO

CREATE PROCEDURE createLibraryDB
AS
BEGIN

	/*IF TABLE EXHISTS DELETE, first 4 tables have fk constraints so have to be deleted before parent tables*/
	DROP TABLE IF EXISTS dbo.tbl_Books,dbo.tbl_Book_Loans,dbo.tbl_Book_Copies,dbo.tbl_Book_Authors,dbo.tbl_Library_Branch,dbo.tbl_Publisher,dbo.tbl_Borrower;

	/*CREATE TABLES*/
	CREATE TABLE tbl_Library_Branch (
		Branch_ID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		Branch_Name VARCHAR(50) NOT NULL,
		Branch_Address VARCHAR(100) NOT NULL
	);

	CREATE TABLE tbl_Publisher (
		Publisher_Name VARCHAR(50) PRIMARY KEY NOT NULL,
		Publisher_Address VARCHAR(100) NOT NULL,
		Publisher_Phone VARCHAR(15) NOT NULL
	);

	CREATE TABLE tbl_Borrower (
		Borrower_CardNo INT PRIMARY KEY NOT NULL IDENTITY (2000,1),
		Borrower_Name VARCHAR(50) NOT NULL,
		Borrower_Address VARCHAR(100) NOT NULL,
		Borrower_Phone VARCHAR(15) NOT NULL
	);

	CREATE TABLE tbl_Books (
		Book_ID INT PRIMARY KEY NOT NULL IDENTITY (1000,1),
		Book_Title VARCHAR(50) NOT NULL,
		Book_Publisher_Name VARCHAR(50) NOT NULL CONSTRAINT fk_Publisher_Name FOREIGN KEY REFERENCES tbl_Publisher(Publisher_Name) ON UPDATE CASCADE ON DELETE CASCADE
	);

	CREATE TABLE tbl_Book_Authors (
		Authors_Book_ID INT NOT NULL CONSTRAINT fk_Book_Authors_ID FOREIGN KEY REFERENCES tbl_Books(Book_ID) ON UPDATE CASCADE ON DELETE CASCADE,
		Authors_Name VARCHAR(50) NOT NULL
	);

	CREATE TABLE tbl_Book_Copies (
		Copies_Book_ID INT NOT NULL CONSTRAINT fk_Book_Copies_ID FOREIGN KEY REFERENCES tbl_Books(Book_ID) ON UPDATE CASCADE ON DELETE CASCADE,
		Copies_Branch_ID INT NOT NULL CONSTRAINT fk_Branch_ID FOREIGN KEY REFERENCES tbl_Library_Branch(Branch_ID) ON UPDATE CASCADE ON DELETE CASCADE,
		Copies_Num_Of_Copies INT NOT NULL
	);

	CREATE TABLE tbl_Book_Loans (
		Loans_Book_ID INT NOT NULL CONSTRAINT fk_Book_Loans_ID FOREIGN KEY REFERENCES tbl_Books(Book_ID) ON UPDATE CASCADE ON DELETE CASCADE,
		Loans_Branch_ID INT NOT NULL CONSTRAINT fk_Loans_Branch_ID FOREIGN KEY REFERENCES tbl_Library_Branch(Branch_ID) ON UPDATE CASCADE ON DELETE CASCADE,
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
	SELECT * FROM tbl_Library_Branch;

	INSERT INTO tbl_Publisher
		(Publisher_Name,Publisher_Address,Publisher_Phone)
		VALUES
		('Hard Case Crime','54322 hoppy rd, mango, 89443','231-433-6547'),
		('Viking','12345 blah st, blah, 44444','123-456-7890'),
		('Scribner','54232 bloo rd, boom, 32242','234-654-7654'),
		('Doubleday','87655 yellow st, apple, 99008','765-345-6723'),
		('Miramax Books','44456 green st, apple, 998855','440-998-0987'),
		('Disney-Hyperion','23113 orange st, banana, 65444','655-433-6542'),
		('Disney Publishing Worldwide','33245 blue st, banana, 67344','894-543-1234'),
		('Puffin Books','33245 blue st, banana, 67344','894-543-1234'),
		('Allen & Unwin','33245 red st, banana, 67344','894-543-1234'),
		('Scholastic','23245 red st, banana, 67344','894-543-1234'),
		('Geoffrey Bles','36545 purple st, banana, 67344','894-543-1234'),
		('Sylvia Beach','87245 black st, banana, 67344','894-543-1234'),
		('Harper & Brothers','39875 maroon st, banana, 67344','894-543-1234'),
		('The Russian Messenger','33545 brown st, banana, 67344','894-543-1234'),
		('Chatto & Windus','32245 orange st, banana, 67344','894-543-1234'),
		('T.Egerton','53245 pink st, banana, 62464','894-543-1234'),
		('Little, Brown and Company','33245 tan st, banana, 67344','894-543-1234'),
		('Riverhead Books','76245 white st, banana, 76544','894-543-1234'),
		('Cool Publisher','87655 blue st, banana, 60944','894-543-1234')
	;
	SELECT * FROM tbl_Publisher;

	INSERT INTO tbl_Books
		(Book_Title,Book_Publisher_Name)
		VALUES
		('Joyland','Hard Case Crime'),
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
		('The Kite Runner','Riverhead Books'),
		('The Lost Tribe','Cool Publisher')
	;
	SELECT * FROM tbl_Books;





	/*DECLARE VARIABLE FOR AUTHORS W/MULTIPLE BOOKS*/
	DECLARE @SKing VARCHAR(15),@RRiordan VARCHAR(15);
	SET @SKing = 'Stephen King';
	SET @RRiordan = 'Rick Riordan';

	INSERT INTO tbl_Book_Authors
		(Authors_Book_ID,Authors_Name)
		VALUES
		(1000,@SKing),
		(1001,@SKing),
		(1002,@Sking),
		(1003,@SKing),
		(1004,@SKing),
		(1005,@SKing),
		(1006,@RRiordan),
		(1007,@RRiordan),
		(1008,@RRiordan),
		(1009,'Charlie Higson'),
		(1010,'Charlie Higson'),
		(1011,'J.R.R. Tolkien'),
		(1012,'J.K. Rowling'),
		(1013,'C.S. Lewis'),
		(1014,'James Joyce'),
		(1015,'Herman Melville'),
		(1016,'Leo Tolstoy'),
		(1017,'Mark Twain'),
		(1018,'Jane Austen'),
		(1019,'J.D. Salinger'),
		(1020,'Khaled Hosseini'),
		(1021,'L. Tribe')
	;
	SELECT * FROM tbl_Book_Authors;

	INSERT INTO tbl_Book_Copies 
		(Copies_Book_ID, Copies_Branch_ID, Copies_Num_Of_Copies)
		VALUES
		(1000,1,4),
		(1000,2,6),
		(1000,3,2),
		(1000,4,7),
		(1001,1,3),
		(1001,2,5),
		(1001,3,3),
		(1001,4,7),
		(1002,1,3),
		(1002,2,2),
		(1003,2,8),
		(1004,3,5),
		(1005,4,6),
		(1006,2,6),
		(1006,3,6),
		(1006,4,5),
		(1007,1,7),
		(1008,1,4),
		(1008,2,5),
		(1008,3,4),
		(1008,4,4),
		(1009,3,4),
		(1009,4,4),
		(1010,2,4),
		(1011,3,4),
		(1011,1,4),
		(1012,4,7),
		(1012,1,7),
		(1012,2,5),
		(1013,3,5),
		(1013,4,5),
		(1014,4,3),
		(1015,1,3),
		(1016,2,3),
		(1017,3,2),
		(1017,4,7),
		(1017,1,4),
		(1018,3,6),
		(1019,2,6),
		(1020,3,6),
		(1021,1,5),
		(1021,2,5),
		(1021,3,5)
	;
	SELECT * FROM tbl_Book_Copies;

	INSERT INTO tbl_Borrower 
		(Borrower_Name, Borrower_Address, Borrower_Phone)
		VALUES
		('bob','12345 pink st, apple, 55300','123-432-3455'),
		('lisa','65432 pink st, apple, 55300','123-432-3455'),
		('larry','87654 yellow st, orange, 76554','534-456-8756'),
		('kerry','78905 green st, banana, 46775','345-654-5647'),
		('luke','34567 red ln, mango, 55306','987-678-9875'),
		('terry','86465 red st, mango, 55350','355-543-6567'),
		('matt','98534 white st, tree, 98755','443-675-8765'),
		('mike','74356 black st, apple, 45673','778-546-7765'),
		('brooke','43223 mustard ln, hotdog, 23541','223-432-1123')
	;
	SELECT * FROM tbl_Borrower;
	SELECT Copies_Book_ID, Copies_Num_Of_Copies AS 'Num Copies' FROM tbl_Book_Copies WHERE Copies_Branch_ID = 4;

	INSERT INTO tbl_Book_Loans
		(Loans_Book_ID, Loans_Branch_ID, Loans_CardNo, Loans_Date_Out, Loans_Date_Due)
		VALUES
		/*C0*/
		(1000,1,2000,'11-12-2018','11-19-2018'),
		(1001,1,2000,'11-12-2018','11-19-2018'),
		(1002,1,2000,'11-12-2018','11-19-2018'),
		(1007,1,2000,'11-12-2018','11-19-2018'),
		(1008,1,2000,'11-12-2018','11-19-2018'),
		(1012,1,2000,'11-12-2018','11-19-2018'),
		(1015,1,2000,'11-12-2018','11-19-2018'),
		(1017,1,2000,'11-12-2018','11-19-2018'),
		(1021,1,2000,'11-12-2018','11-19-2018'),
		(1011,1,2000,'11-12-2018','11-19-2018'),
		/*C1*/
		(1000,2,2001,'11-14-2018','11-21-2018'),
		(1002,2,2001,'11-14-2018','11-21-2018'),
		(1003,2,2001,'11-14-2018','11-21-2018'),
		(1006,2,2001,'11-14-2018','11-21-2018'),
		(1008,2,2001,'11-14-2018','11-21-2018'),
		(1010,2,2001,'11-14-2018','11-21-2018'),
		(1012,2,2001,'11-14-2018','11-21-2018'),
		(1016,2,2001,'11-14-2018','11-21-2018'),
		(1019,2,2001,'11-14-2018','11-21-2018'),
		(1021,2,2001,'11-14-2018','11-21-2018'),
		/*C2*/
		(1000,3,2002,'11-09-2018','11-16-2018'),
		(1001,3,2002,'11-09-2018','11-16-2018'),
		(1004,3,2002,'11-09-2018','11-16-2018'),
		(1006,3,2002,'11-09-2018','11-16-2018'),
		(1008,3,2002,'11-09-2018','11-16-2018'),
		/*C3*/
		(1000,3,2003,'11-09-2018','11-16-2018'),
		(1001,3,2003,'11-09-2018','11-16-2018'),
		(1013,3,2003,'11-09-2018','11-16-2018'),
		(1018,3,2003,'11-09-2018','11-16-2018'),
		(1020,3,2003,'11-09-2018','11-16-2018'),
		/*C4*/
		(1000,4,2004,'11-19-2018','11-26-2018'),
		(1001,4,2004,'11-19-2018','11-26-2018'),
		(1005,4,2004,'11-19-2018','11-26-2018'),
		(1006,4,2004,'11-19-2018','11-26-2018'),
		(1008,4,2004,'11-19-2018','11-26-2018'),
		/*C5*/
		(1000,4,2005,'11-19-2018','11-26-2018'),
		(1001,4,2005,'11-19-2018','11-26-2018'),
		(1009,4,2005,'11-19-2018','11-26-2018'),
		/*C6*/
		(1009,4,2006,'11-18-2018','11-25-2018'),
		(1012,4,2006,'11-18-2018','11-25-2018'),
		(1014,4,2006,'11-18-2018','11-25-2018'),
		(1017,4,2006,'11-18-2018','11-25-2018'),
		/*C7*/
		(1000,4,2007,'11-12-2018','11-19-2018'),
		(1005,4,2007,'11-12-2018','11-19-2018'),
		(1006,4,2007,'11-12-2018','11-19-2018'),
		(1009,4,2007,'11-14-2018','11-21-2018'),
		(1012,4,2007,'11-14-2018','11-21-2018'),
		(1013,4,2007,'11-16-2018','11-23-2018'),
		(1014,4,2007,'11-16-2018','11-23-2018'),
		(1017,4,2007,'11-17-2018','11-24-2018')
	;
	SELECT * FROM tbl_Book_Loans;

	/*QUERIES FOR THE INFORMATION*/

	/*TA FINAL PROJECT QUERY 1 - # of copies of The Lost Tribe in Sharpstown branch*/
	SELECT Book_Title,Branch_Name,Copies_Num_Of_Copies AS 'Number of Copies' 
		FROM tbl_Book_Copies 
		INNER JOIN tbl_Books ON tbl_Books.Book_ID = tbl_Book_Copies.Copies_Book_ID
		INNER JOIN tbl_Library_Branch ON tbl_Library_Branch.Branch_ID = tbl_Book_Copies.Copies_Branch_ID
		WHERE Book_Title = 'The Lost Tribe' AND Branch_Name = 'Sharpstown'
	;

	/*TA FINAL PROJECT QUERY 2 - # of copies of The Lost Tribe in all branches*/
	SELECT Branch_Name,Book_Title,Copies_Num_Of_Copies AS 'Number of Copies' 
		FROM tbl_Book_Copies 
		INNER JOIN tbl_Books ON tbl_Books.Book_ID = tbl_Book_Copies.Copies_Book_ID
		INNER JOIN tbl_Library_Branch ON tbl_Library_Branch.Branch_ID = tbl_Book_Copies.Copies_Branch_ID
		WHERE Book_Title = 'The Lost Tribe'
	;

	/*TA FINAL PROJECT QUERY 3 - names of borrowers with no books checked out*/ 
	SELECT Borrower_Name,Borrower_CardNo AS 'Card# - No Loans'
		FROM tbl_Borrower
		LEFT JOIN tbl_Book_Loans ON Loans_CardNo = Borrower_CardNo
		WHERE Loans_CardNo IS NULL
	;

	/*TA FINAL PROJECT QUERY 4 - who and what book is due today*/ 

	/*What I would use to check what's due for today
		DECLARE @CurrentDate AS DATE;
		SET @CurrentDate = GETDATE();
	*/

	/*Example current date to get results*/
	DECLARE @CurrentDate AS DATE;
	SET @CurrentDate = '11-19-2018';

	SELECT Book_Title,Borrower_Name,Borrower_Address 
		FROM tbl_Borrower
		INNER JOIN tbl_Book_Loans ON Loans_CardNo = Borrower_CardNo
		INNER JOIN tbl_Books ON Book_ID = Loans_Book_ID
		INNER JOIN tbl_Library_Branch ON Branch_ID = Loans_Branch_ID
		WHERE Branch_Name = 'Sharpstown' AND Loans_Date_Due = @CurrentDate
	;

	/*TA FINAL PROJECT QUERY 5 - total books loaned out for each branch*/ 

	SELECT Branch_Name, COUNT(Loans_Book_ID) AS '# books out'
		FROM tbl_Book_Loans
		INNER JOIN tbl_Library_Branch ON Branch_ID = Loans_Branch_ID
		GROUP BY Branch_Name
	;

	/*TA FINAL PROJECT QUERY 6*/ 

	SELECT Borrower_Name, Borrower_Address, COUNT(Loans_Book_ID) AS '# books checked'
		FROM tbl_Borrower
		INNER JOIN tbl_Book_Loans ON Loans_CardNo = Borrower_CardNo
		GROUP BY Borrower_Name, Borrower_Address
			HAVING COUNT(Loans_Book_ID) > 5
	;

	/*TA FINAL PROJECT QUERY 7 - Num of copies authored by Stephen King at Central Branch*/ 

	SELECT Book_Title, Branch_Name, Copies_Num_Of_Copies
		FROM tbl_Books
		INNER JOIN tbl_Book_Copies ON Copies_Book_ID = Book_ID
		INNER JOIN tbl_Library_Branch ON Branch_ID = Copies_Branch_ID
		INNER JOIN tbl_Book_Authors ON Authors_Book_ID = Book_ID
		WHERE Authors_Name = 'Stephen King' AND Branch_Name = 'Central'
	;
END
GO






	