
--1
SELECT Title, BranchName, No_of_Copies 
FROM BOOK_COPIES as BC INNER JOIN BOOK as BK
ON BC.BookID = BK.BookID 
INNER JOIN LIBRARY_BRANCH as LB
ON LB.BranchID = BC.BranchID
WHERE BC.BookID = 1
AND BC.BranchID = 1

--2
SELECT No_of_Copies, Title, BranchName
FROM BOOK_COPIES INNER JOIN Book
ON BOOK_COPIES.BookID = Book.BookID
INNER JOIN LIBRARY_BRANCH
ON LIBRARY_BRANCH.BranchID = BOOK_COPIES.branchID 
WHERE BOOK_COPIES.BookID = 1

--3
SELECT Borrower.CardNo, Borrower.Name, Book_Loans.BookID
FROM Borrower LEFT OUTER JOIN Book_Loans
ON Borrower.CardNo = Book_Loans.CardNo
WHERE Book_Loans.BookID IS NULL


--4
-- Chose 11/2/16 as duedate since I did not have anything with today's duedate.

SELECT name, bor.address, LB.BranchName, Duedate, Title 
FROM Borrower as bor
INNER JOIN BOOk_Loans as bl
ON bor.CardNo = bl.CardNo
INNER JOIN Book as bo
ON bl.bookID = bo.bookID
INNER JOIN LIBRARY_BRANCH as LB
ON bl.BranchID = LB.BranchID 
WHERE bl.BranchID = '1' and 
DueDate = '11/2/16'


--5

SELECT BranchName, COUNT(Title)
FROM BOOK_LOANS as BL
INNER JOIN LIBRARY_BRANCH as LB
ON BL.BranchID = LB.BranchID
INNER JOIN Book as BK
ON BK.BookID = BL.BookID 
GROUP BY BranchName

--6

SELECT Name, address, Count(BookID) 
FROM Borrower as BR
INNER JOIN BOOK_LOANS as BL
ON BR.CardNo = BL.CardNo
GROUP BY Name, address
HAVING COUNT(BookID) > 5;


--7

SELECT Title, AuthorName, No_of_Copies, BranchName
FROM BOOK_AUTHOR as BA
INNER JOIN BOOK as BK
ON BA.bookid = BK.bookid 
INNER JOIN BOOK_COPIES as BC
ON BC.bookid = BK.bookid
INNER JOIN LIBRARY_BRANCH as LB
ON BC.BranchID = LB.BranchID
WHERE LB.Branchname = 'Central' 
AND BA.AuthorName = 'Stephen King'


--Stored Procedure

CREATE PROCEDURE dbo.nameswithquantitiesmorethanfive
AS
SELECT Name, address, Count(BookID) 
FROM Borrower as BR
INNER JOIN BOOK_LOANS as BL
ON BR.CardNo = BL.CardNo
GROUP BY Name, address
HAVING COUNT(BookID) > 5;

EXEC dbo.nameswithquantitiesmorethanfive