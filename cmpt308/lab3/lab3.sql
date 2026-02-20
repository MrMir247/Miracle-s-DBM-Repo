INSERT INTO Students(StudentID, StudentName, class_year)
VALUES(0, 'Miracle', '2028')

INSERT INTO JOINED(StudentID, ClubID, join_date, member_role)
VALUES(500, 2, '2026-09-12', 'Member')

SELECT * FROM Students

SELECT * FROM Joined
WHERE member_role IS NULL

SELECT s.StudentID, s.StudentName, c.ClubName, j.join_date, j.member_role FROM Students s
INNER JOIN Clubs c ON (s.StudentID = c.Clubid)
INNER JOIN Joined j ON (s.StudentID = c.Clubid and j.ClubID = c.ClubID)
WHERE s.StudentID > 2

SELECT * FROM Students
INNER JOIN Clubs ON (Students.StudentID = Clubs.Clubid)
INNER JOIN Joined ON (Students.StudentID = Clubs.Clubid and Joined.ClubID = Clubs.ClubID)
WHERE Students.StudentID > 2

SELECT * FROM Students
INNER JOIN Clubs ON (Students.StudentID = Clubs.Clubid)
INNER JOIN Joined ON (Students.StudentID = Clubs.Clubid and Joined.ClubID = Clubs.ClubID)

SELECT * FROM Students
INNER JOIN Clubs ON (Students.StudentID = Clubs.Clubid)

SELECT * FROM Joined

SELECT * FROM Clubs

SELECT * FROM Students

INSERT INTO Joined (StudentID, ClubID, join_date, member_role) VALUES
(2, 2, '2026-01-15', 'President'),
(2, 4, '2026-02-01', 'Member'),
(2, 6, '2026-08-30', NULL),
(3, 2, '2026-01-20', 'Treasurer'),
(4, 3, '2026-03-10', 'Secretary'),
(5, 9, '2026-01-05', 'Vice President'),
(10, 5, '2026-04-22', 'Member'),
(10, 9, '2026-09-12', 'Social Chair'),
(11, 2, '2026-01-18', 'Social Media Lead'),
(11, 8, '2026-05-05', 'Member'),
(11, 3, '2027-01-10', NULL),
(12, 7, '2026-02-14', NULL),
(100, 8, '2026-03-01', 'Hardware Lead'),
(100, 5, '2026-10-15', 'Member'),
(3, 4, '2027-02-20', 'Research Assistant');

SELECT * FROM Students

SELECT * FROM Clubs

INSERT INTO Clubs (ClubID, ClubName) VALUES
(2, 'Data Science Society'),
(3, 'Association for Computing Machinery'),
(4, 'Robotics and Automation Club'),
(5, 'Cyber Security Guild'),
(6, 'Video Game Development Alliance'),
(7, 'Artificial Intelligence Lab'),
(8, 'Open Source Hardware Group'),
(9, 'Women in Tech Network');

INSERT INTO Students (StudentID, StudentName, class_year) VALUES
(2, 'Alex Rivera', 2026),
(3, 'Bina Shah', 2027),
(4, 'Charlie Chen', 2028),
(5, 'Dakota Smith', 2029),
(10, 'Elena Gomez', 2026),
(11, 'Finn O?Connor', 2027),
(12, 'Gia Volkov', 2028),
(100, 'Hassan Mahmoud', 2029);



create table Joined(
	StudentID int NOT NULL,
	ClubID int NOT NULL,
	Foreign Key (StudentID) References Students(StudentID),
	Foreign Key (ClubID) References Clubs(ClubID),
	join_date varchar(30),
	member_role varchar(30)
)

create table Clubs(
	ClubID int Primary Key CHECK(ClubID > 1),
	ClubName varchar(40)
)

create table Students(
	StudentID int Primary Key CHECK(StudentID > 1),
	StudentName varchar(30),
	class_year int CHECK(class_year >= 2026 and class_year <= 2029)
	)
