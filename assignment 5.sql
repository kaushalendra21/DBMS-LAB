CREATE DATABASE LibraryDB;
USE LibraryDB;

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    published_year DATE,
    genre VARCHAR(100),
    available_copies INT CHECK (available_copies >= 0)
);

CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    age INT CHECK (age > 0),
    gender VARCHAR(10)
);

CREATE TABLE Borrowed (
    borrow_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    borrow_date DATE,
    return_date DATE,
    fine_amount DECIMAL(10,2) DEFAULT 0,

    FOREIGN KEY (book_id)
        REFERENCES Books(book_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (member_id)
        REFERENCES Members(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    UNIQUE (book_id, member_id)
);
INSERT INTO Members VALUES

(101, 'John Smith', 'johnsmith@gmail.com', 25, 'Male'),

(102, 'Alice Johnson', 'alice@gmail.com', 30, 'Female'),

(103, 'Emma Watson', 'emma@gmail.com', 22, 'Female'),

(104, 'Robert Brown', 'robert@gmail.com', 65, 'Male'),

(105, 'Sophia Davis', 'sophia@gmail.com', 61, 'Female'),

(106, 'Michael Clark', 'michael@gmail.com', 45, 'Male'),

(107, 'Olivia Martin', 'olivia@gmail.com', 28, 'Female'),

(108, 'David Miller', 'david@gmail.com', 70, 'Male'),

(109, 'James Wilson', 'james@gmail.com', 35, 'Male'),

(110, 'Isabella Moore', 'isabella@gmail.com', 26, 'Female');

INSERT INTO Books VALUES
(551, 'The_Great_Gatsby', 'F_Scott_Fitzgerald', '1925-04-10', 'Tragedy', 10000),

(552, 'ULYSSES', 'James_Joyce', '1922-02-02', 'Modernist_Novel', 10000),

(553, 'Lolita', 'Vladimir_Nabokov', '1955-06-01', 'Novel', 10000),

(554, 'Brave_New_World', 'Aldous_Huxley', '1932-05-05', 'Science_Fiction_Dystopian_Fiction', 10000),

(555, 'The_Sound_And_The_Fury', 'William_Faulkner', '1929-01-03', 'Southern_Gothic', 10000),

(556, 'Catch22', 'Joseph_Heller', '1961-10-10', 'Dark_Comedy', 10000),

(557, 'The_Grapes_Of_Wrath', 'John_Steinbeck', '1939-04-14', 'Novel', 10000),

(558, 'I_Claudius', 'Robert_Graves', '1934-08-10', 'Historical', 10000),

(559, 'To_The_Lighthouse', 'Virginia_Woolf', '1927-05-05', 'Modernism', 10000),

(5510, 'Slaughterhouse_Five', 'Kurt_Vonnegut', '1969-03-31', 'War_Novel', 10000),

(5511, 'Invisible_Man', 'Ralph_Ellison', '1952-04-14', 'African_American_Literature', 10000),

(5512, 'Native_Son', 'Richard_Wright', '1940-01-03', 'Social_Protest', 10000),

(5513, 'USA_Trilogy', 'John_Dos_Passos', '1930-04-05', 'Political_Fiction', 10000),

(5514, 'A_Passage_To_India', 'E_M_Forster', '1924-04-06', 'Novel', 10000),

(5515, 'Tender_Is_The_Night', 'F_Scott_Fitzgerald', '1934-12-04', 'Tragedy', 10000),

(5516, 'Animal_Farm', 'George_Orwell', '1945-08-17', 'Political_Satire', 10000),

(5517, 'The_Golden_Bowl', 'Henry_James', '1904-10-11', 'Philosophy', 10000),

(5518, 'A_Handful_Of_Dust', 'Evelyn_Waugh', '1934-06-03', 'Fiction', 10000),

(5519, 'As_I_Lay_Dying', 'William_Faulkner', '1930-03-02', 'Black_Comedy', 10000),

(5520, 'The_Heart_Of_The_Matter', 'Graham_Greene', '1948-03-02', 'Novel', 10000);
INSERT INTO Borrowed VALUES

(1, 551, 101, '2026-04-01', '2026-04-05', 0),

(2, 553, 102, '2026-04-02', NULL, 50),

(3, 554, 103, '2026-04-03', '2026-04-20', 20),

(4, 555, 104, '2026-04-01', '2026-04-10', 0),

(5, 557, 105, '2026-04-04', NULL, 50),

(6, 552, 101, '2026-04-05', '2026-04-08', 0),

(7, 558, 106, '2026-04-06', '2026-04-15', 0),

(8, 559, 107, '2026-04-07', NULL, 50),

(9, 5510, 108, '2026-04-08', '2026-04-25', 30),

(10, 5511, 109, '2026-04-09', '2026-04-12', 0),

(11, 5512, 110, '2026-04-10', NULL, 50),

(12, 5513, 102, '2026-04-11', '2026-04-18', 0),

(13, 5514, 103, '2026-04-12', '2026-04-14', 0),

(14, 5515, 104, '2026-04-13', NULL, 50),

(15, 5516, 105, '2026-04-14', '2026-04-28', 10),

(16, 5517, 106, '2026-04-15', '2026-04-18', 0),

(17, 5518, 107, '2026-04-16', NULL, 50),

(18, 5519, 108, '2026-04-17', '2026-04-22', 0),

(19, 5520, 109, '2026-04-18', NULL, 50),

(20, 557, 101, '2026-04-19', '2026-04-25', 0);



select * from members m join borrowed b on b.member_id=m.member_id join books bk on bk.book_id=b.book_id;
-- 1
select m.name from members m join borrowed b on m.member_id=b.member_id join books bk on b.book_id=bk.book_id where bk.title='Lolita';

select * from members;
-- 2
select genre,sum(available_copies) as avl from books group by genre;
-- 3
select bk.genre,count(*) from members m join borrowed b on m.member_id=b.member_id join books bk on b.book_id=bk.book_id where m.gender='Female' group by bk.genre order by bk.genre limit 1;
-- 4
select bk.genre,count(*) from members m join borrowed b on m.member_id=b.member_id join books bk on b.book_id=bk.book_id where m.age>=60 group by bk.genre order by bk.genre limit 1;

select * from members m join borrowed b on m.member_id=b.member_id ;
-- 5
select m.name from members m join borrowed b on m.member_id=b.member_id where DATEDIFF(b.return_date, b.borrow_date) <= 14;
-- 6
select m.name,bk.title from members m join borrowed b on m.member_id=b.borrow_id join books bk on b.book_id=bk.book_id where datediff(b.return_date,b.borrow_date)>14;
-- 8
SELECT b.genre, COUNT(*) AS total
FROM Borrowed br
JOIN Books b ON b.book_id = br.book_id
GROUP BY b.genre
ORDER BY total DESC
LIMIT 1;
-- 10
select sum(fine_amount) from borrowed where return_date is null and datediff(curdate(),borrow_date)>=14;
-- 11
select m.name,count(*) as total from members m join borrowed b on m.member_id=b.member_id group by m.name order by total desc limit 5;
-- 12
alter table borrowed add constraint unique_val unique(book_id,member_id);
-- 13
select title,available_copies from books where available_copies>0;

SELECT m.name,
CASE
    WHEN COUNT(br.borrow_id) > 2 THEN 'Frequent Borrowers'
    WHEN COUNT(br.borrow_id) BETWEEN 1 AND 2 THEN 'Regular Borrowers'
    ELSE 'Occasional Borrowers'
END AS category
FROM Members m
LEFT JOIN Borrowed br ON m.member_id = br.member_id
GROUP BY m.member_id, m.name;

CREATE TRIGGER issue_book
AFTER INSERT ON Borrowed
FOR EACH ROW
UPDATE Books
SET available_copies = available_copies - 1
WHERE book_id = NEW.book_id;

CREATE TRIGGER return_book
AFTER UPDATE ON Borrowed
FOR EACH ROW
UPDATE Books
SET available_copies = available_copies + 1
WHERE book_id = NEW.book_id;