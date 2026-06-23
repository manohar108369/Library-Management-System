CREATE DATABASE LibraryDB;
USE LibraryDB;

-- Table 1: tbl_publisher
CREATE TABLE tbl_publisher (
    publisher_PublisherName VARCHAR(255),
    publisher_PublisherAddress VARCHAR(255),
    publisher_PublisherPhone VARCHAR(50)
);

-- Table 2: tbl_book

CREATE TABLE tbl_book (
    book_BookID INT,
    book_Title VARCHAR(255),
    book_PublisherName VARCHAR(255)
);

-- Table 3: tbl_book_authors

CREATE TABLE tbl_book_authors (
    book_authors_BookID INT,
    book_authors_AuthorName VARCHAR(255)
);

-- Table 4: tbl_library_branch

CREATE TABLE tbl_library_branch (
    library_branch_BranchName VARCHAR(255),
    library_branch_BranchAddress VARCHAR(255)
);

-- Table 5: tbl_book_copies

CREATE TABLE tbl_book_copies (
    book_copies_BookID INT,
    book_copies_BranchID INT,
    book_copies_No_Of_Copies INT
);

-- Table 6: tbl_borrower

CREATE TABLE tbl_borrower (
    borrower_CardNo INT,
    borrower_BorrowerName VARCHAR(255),
    borrower_BorrowerAddress VARCHAR(255),
    borrower_BorrowerPhone VARCHAR(50)
);

-- Table 7: tbl_book_loans

CREATE TABLE tbl_book_loans (
    book_loans_BookID INT,
    book_loans_BranchID INT,
    book_loans_CardNo INT,
    book_loans_DateOut VARCHAR(20),
    book_loans_DueDate VARCHAR(20)
);


/* 1. How many copies of the book titled "The Lost Tribe" are owned by the library
branch whose name is "Sharpstown"? */

SELECT bc.book_copies_No_Of_Copies
FROM tbl_book b
JOIN tbl_book_copies bc
ON b.book_BookID = bc.book_copies_BookID
WHERE b.book_Title = 'The Lost Tribe';

/* 2. How many copies of the book titled "The Lost Tribe" are owned by each library
branch? */

SELECT b.book_Title,
       bc.book_copies_BranchID,
       bc.book_copies_No_Of_Copies
FROM tbl_book b
JOIN tbl_book_copies bc
ON b.book_BookID = bc.book_copies_BookID
WHERE b.book_Title = 'The Lost Tribe';

/* 3. Retrieve the names of all borrowers who do not have any books checked out. */

SELECT borrower_BorrowerName
FROM tbl_borrower b
LEFT JOIN tbl_book_loans bl
ON b.borrower_CardNo = bl.book_loans_CardNo
WHERE bl.book_loans_CardNo IS NULL;

/* 4. For each book that is loaned out from the "Sharpstown" branch and whose
DueDate is 2/3/18, retrieve the book title, the borrower's name, and the
borrower's address. */

SELECT bk.book_Title,
       br.borrower_BorrowerName,
       br.borrower_BorrowerAddress
FROM tbl_book_loans bl
JOIN tbl_book bk
ON bl.book_loans_BookID = bk.book_BookID
JOIN tbl_borrower br
ON bl.book_loans_CardNo = br.borrower_CardNo
WHERE bl.book_loans_DueDate = '2/3/18';

/* 5. For each library branch, retrieve the branch name and the total number of books
loaned out from that branch. */

SELECT book_loans_BranchID,
       COUNT(*) AS Total_Loans
FROM tbl_book_loans
GROUP BY book_loans_BranchID;

/* 6. Retrieve the names, addresses, and number of books checked out for all
borrowers who have more than five books checked out. */

SELECT borrower_BorrowerName,
       borrower_BorrowerAddress,
       COUNT(*) AS Books_Checked_Out
FROM tbl_borrower b
JOIN tbl_book_loans bl
ON b.borrower_CardNo = bl.book_loans_CardNo
GROUP BY borrower_CardNo,
         borrower_BorrowerName,
         borrower_BorrowerAddress
HAVING COUNT(*) > 5;


/* 7. For each book authored by "Stephen King", retrieve the title and the number of
copies owned by the library branch whose name is "Central". */

SELECT b.book_Title,
       bc.book_copies_No_Of_Copies
FROM tbl_book b
JOIN tbl_book_authors ba
ON b.book_BookID = ba.book_authors_BookID
JOIN tbl_book_copies bc
ON b.book_BookID = bc.book_copies_BookID
WHERE ba.book_authors_AuthorName = 'Stephen King';


SELECT * FROM tbl_publisher;

SELECT * FROM tbl_book;

SELECT * FROM tbl_book_authors;

SELECT * FROM tbl_library_branch;

SELECT * FROM tbl_book_copies;

SELECT * FROM tbl_borrower;

SELECT * FROM tbl_book_loans;