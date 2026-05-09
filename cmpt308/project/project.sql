CREATE TABLE Users (
  UserID INT PRIMARY KEY,
  Username varchar,
  email varchar,
  password varchar
);

CREATE TABLE Carts (
  CartID INT PRIMARY KEY,
  UserID int,
  Constraint fk_userID
  FOREIGN KEY (UserID)
  References Users(UserID)
);

CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  order_date date DEFAULT CURRENT_DATE,
  UserID INT,
  OrderPrice INT,
  MeetingLocation varchar,
  Constraint fk_userID
  FOREIGN KEY (UserID)
  References Users(UserID)
);

CREATE TABLE Bids (
	BidID INT Primary Key,
	ItemID INT,
	UserID INT,
	bidAmount INT,
	Constraint fk_userID
  FOREIGN KEY (UserID)
  References Users(UserID),
  Constraint fk_ItemID
  FOREIGN KEY (ItemID)
  References Items(ItemID)
);

CREATE TABLE Items (
  ItemID INT PRIMARY KEY,
  itemName varchar,
  UserID INT,
  ItemPrice INT,
  CartID INT,
  OrderID INT,
  isAvailable boolean,
  Constraint fk_userID
  FOREIGN KEY (UserID)
  References Users(UserID),
  Constraint fk_CartID
  FOREIGN KEY (CartID)
  References Carts(cartID),
  Constraint fk_OrderID
  FOREIGN KEY (OrderID)
  References Orders(OrderID)
);

INSERT INTO Users (UserID, Username, email, password) VALUES
(1, 'jdoe_88', 'john.doe@example.com', 'P@ssw0rd123'),
(2, 'tech_wizard', 'alice.smith@webmail.org', 'MagicCode!99'),
(3, 'mountain_climber', 'climb_high@outdoors.net', 'Summit2026#'),
(4, 'pixel_artisan', 'design_pro@creative.io', 'Render_Master8'),
(5, 'coffee_lover', 'brew_master@cafe.com', 'Espresso_Shot1'),
(6, 'cyber_guard', 'sam.security@protomail.com', 'ShieldUp_442'),
(7, 'data_enthusiast', 'data.viz@analytics.edu', 'Graph_Theory_7');

INSERT INTO Carts (CartID, UserID)
VALUES 
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5),
  (6, 6),
  (7, 7);

INSERT INTO Orders (OrderID, UserID, OrderPrice, MeetingLocation)
VALUES 
  (1001, 1, 55, 'Main St. Hub'),
  (1002, 2, 120, 'Tech Park North'),
  (1003, 3, 45, 'Mountain Base Cafe'),
  (1004, 4, 300, 'Design Studio A'),
  (1005, 5, 15, 'Downtown Roastery'),
  (1006, 6, 85, 'Security HQ'),
  (1007, 7, 210, 'Library Annex');

INSERT INTO Items (ItemID, itemName, UserID, ItemPrice, CartID, OrderID, isAvailable)
VALUES 
  (101, 'Vintage Camera', 1, 150, 1, 1001, TRUE),
  (102, 'Wireless Headphones', 2, 85, 2, 1002, FALSE),
  (103, 'Mechanical Keyboard', 3, 120, 3, 1003, TRUE),
  (104, 'Graphic Tablet', 4, 300, 4, 1004, TRUE),
  (105, 'Coffee Grinder', 5, 45, 5, 1005, FALSE),
  (106, 'Security Camera', 6, 95, 6, 1006, TRUE),
  (107, 'Data Science Book', 7, 30, 7, 1007, TRUE);

INSERT INTO Bids (BidID, ItemID, UserID, bidAmount)
VALUES 
  (1, 101, 7, 160),
  (2, 102, 6, 95),
  (3, 103, 5, 130),
  (4, 104, 4, 310),
  (5, 105, 3, 55),
  (6, 106, 2, 110),
  (7, 107, 1, 40);

select * from bids
where bidamount > 100

select b.bidid, b.itemid, b.bidamount, u.userid, u.username, u.email from bids b
inner join users u on u.userid = b.userid

select c.cartid, c.userid, u.username, u.email from carts c
inner join users u on c.userid = u.userid

select order_date, count(*) from orders
group by order_date

select * from items i
where i.itemid in (select itemid from bids b where b.bidamount > 120)

create index userItems
On items(itemid, userId);


