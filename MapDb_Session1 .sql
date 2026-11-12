/* ============================================================
   MapDb - Mock database for Session 1 (Model1 API)
   ตารางและคอลัมน์ออกแบบเองให้ตรงกับ response ในสเปก
   รันซ้ำได้กี่ครั้งก็ได้: ไม่ลบฐานข้อมูล ลบและสร้างเฉพาะตาราง
   (จึงไม่เจอ error 3702 / 5064 ถ้ามีหน้าต่างอื่นเชื่อมอยู่)
   ============================================================ */
USE master;
GO
IF DB_ID('MapDb') IS NULL
  CREATE DATABASE MapDb;
GO
USE MapDb;
GO

/* ---------- ลบตารางเก่า (ลำดับสำคัญ: Reviews อ้างอิง Users) ---------- */
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Congestions;
DROP TABLE IF EXISTS ScenicSpots;
DROP TABLE IF EXISTS Restaurants;
DROP TABLE IF EXISTS Users;
GO

/* ---------- Tables ---------- */
CREATE TABLE Users (
  UserId INT IDENTITY(1,1) PRIMARY KEY,
  Username NVARCHAR(50) NOT NULL UNIQUE,
  Password NVARCHAR(100) NOT NULL,      -- mock: plain text
  NickName NVARCHAR(50), Email NVARCHAR(100), Phone NVARCHAR(30),
  Avatar NVARCHAR(200),
  CreateTime DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE Restaurants (
  RestaurantId INT IDENTITY(1,1) PRIMARY KEY,
  RestaurantName NVARCHAR(100) NOT NULL, Address NVARCHAR(200), Phone NVARCHAR(30),
  Rating DECIMAL(2,1), PriceRange NVARCHAR(30), RestaurantType NVARCHAR(50),
  ImageUrl NVARCHAR(200), Description NVARCHAR(500), Distance DECIMAL(6,1),
  BusinessHours NVARCHAR(30), RemainingParkingSpaces INT
);

CREATE TABLE ScenicSpots (
  SpotId INT IDENTITY(1,1) PRIMARY KEY,
  SpotName NVARCHAR(100) NOT NULL, Address NVARCHAR(200),
  Latitude DECIMAL(9,4), Longitude DECIMAL(9,4), Phone NVARCHAR(30),
  Rating DECIMAL(2,1), TicketPrice NVARCHAR(30), OpeningHours NVARCHAR(30),
  Description NVARCHAR(500), Distance DECIMAL(6,1), ImageUrl NVARCHAR(200),
  TouristPeriod NVARCHAR(30)
);

CREATE TABLE Reviews (
  ReviewId INT IDENTITY(1,1) PRIMARY KEY,
  UserId INT NOT NULL REFERENCES Users(UserId),
  BusinessType NVARCHAR(20) NOT NULL CHECK (BusinessType IN ('scenic','restaurant')),
  BusinessId INT NOT NULL,
  Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
  ReviewContent NVARCHAR(1000) NOT NULL,
  ReviewTime DATETIME NOT NULL DEFAULT GETDATE(),
  ImageUrls NVARCHAR(1000) NULL,        -- คั่นด้วย comma
  LikeCount INT NOT NULL DEFAULT 0
);

CREATE TABLE Congestions (
  CongestionId INT IDENTITY(1,1) PRIMARY KEY,
  RoadName NVARCHAR(100),
  StartLatitude DECIMAL(9,4), StartLongitude DECIMAL(9,4), StartAddress NVARCHAR(200),
  EndLatitude DECIMAL(9,4), EndLongitude DECIMAL(9,4), EndAddress NVARCHAR(200),
  CongestionLevel NVARCHAR(20),         -- severe / moderate / smooth
  CongestionLength INT,                 -- เมตร
  DelayTime NVARCHAR(30)
);
GO

/* ---------- Users ---------- */
INSERT Users (Username,Password,NickName,Email,Phone,Avatar,CreateTime) VALUES
('admin','123456','Admin','admin@example.com','13800138000','/upload/20260602/639160099670709379.png','2026-05-11 15:14:12'),
('zhangsan','123456','Zhang San','zhangsan@example.com','13900000002',NULL,'2026-05-12 09:00:00'),
('lisi','123456','Li Si','lisi@example.com','13900000003',NULL,'2026-05-12 09:10:00'),
('wangwu','123456','Wang Wu','wangwu@example.com','13900000004',NULL,'2026-05-12 09:20:00'),
('user1','123456','User One','user1@example.com','13900000005',NULL,'2026-05-13 10:00:00');

/* ---------- Restaurants (10) ---------- */
INSERT Restaurants (RestaurantName,Address,Phone,Rating,PriceRange,RestaurantType,ImageUrl,Description,Distance,BusinessHours,RemainingParkingSpaces) VALUES
('Quanjude Roast Duck','30 Qianmen Street, Dongcheng District, Beijing','010-12345678',4.5,'$15-45','Beijing Cuisine','/upload/20260602/639160074121552317.png','Century-old roast duck restaurant',3.4,'10:00-22:00',15),
('Donglaishun Hot Pot','198 Wangfujing Street, Dongcheng District, Beijing','010-12345001',4.6,'$12-30','Hot Pot','/upload/20260602/639160074121552317.png','Famous for hand-sliced mutton',2.1,'11:00-21:00',20),
('Sijimintu Roast Duck','12 Dongsi Street, Dongcheng District, Beijing','010-12345002',4.7,'$20-50','Beijing Cuisine','/upload/20260602/639160074121552317.png','Classic roast duck with thin pancakes',1.5,'10:30-21:30',10),
('Dadong Roast Duck','3 Tuanjiehu Road, Chaoyang District, Beijing','010-12345003',4.5,'$25-60','Beijing Cuisine','/upload/20260602/639160074121552317.png','Lean, crispy roast duck',2.2,'11:00-22:00',30),
('Haidilao Hot Pot','88 Sanlitun Road, Chaoyang District, Beijing','010-12345004',4.9,'$15-37','Hot Pot','/upload/20260602/639160074121552317.png','Known for attentive service',2.5,'10:00-02:00',25),
('Grandma''s Home','1 Xizhimen Street, Xicheng District, Beijing','010-12345005',4.4,'$8-20','Home Cooking','/upload/20260602/639160074121552317.png','Affordable home-style dishes',1.3,'10:00-22:00',8),
('Xiao Nan Guo','56 Guanghua Road, Chaoyang District, Beijing','010-12345006',4.5,'$10-25','Local Snacks','/upload/20260602/639160074121552317.png','Casual local snacks',2.5,'09:00-21:00',12),
('Lao Beijing Noodles','7 Gulou Street, Dongcheng District, Beijing','010-12345007',4.3,'$5-12','Noodles','/upload/20260602/639160074121552317.png','Zhajiangmian specialists',3.0,'08:00-20:00',5),
('Sichuan Garden','22 Jianguo Road, Chaoyang District, Beijing','010-12345008',4.4,'$12-30','Sichuan Cuisine','/upload/20260602/639160074121552317.png','Spicy and numbing classics',4.2,'11:00-22:30',18),
('Hutong Dumplings','15 Nanluoguxiang, Dongcheng District, Beijing','010-12345009',4.2,'$6-15','Dumplings','/upload/20260602/639160074121552317.png','Handmade dumplings',3.8,'10:00-21:00',0);

/* ---------- ScenicSpots (10) ---------- */
INSERT ScenicSpots (SpotName,Address,Latitude,Longitude,Phone,Rating,TicketPrice,OpeningHours,Description,Distance,ImageUrl,TouristPeriod) VALUES
('Palace Museum','4 Jingshan Front Street, Dongcheng District, Beijing',39.9163,116.3972,'010-85007047',5.0,'$9','8:30-17:00','Imperial palace of Ming and Qing dynasties',3.4,'/upload/20260602/639160112022167429.png','09:00-11:00'),
('Summer Palace','19 Xinjiangongmen Road, Haidian District, Beijing',39.9999,116.2755,'010-62881144',4.9,'$4.5','6:30-18:00','Imperial garden with lake and pavilions',12.5,'/upload/20260602/639160112022167429.png','08:00-10:00'),
('Temple of Heaven','1 Tiantan Road, Dongcheng District, Beijing',39.8822,116.4066,'010-67028866',4.8,'$2','6:00-22:00','Ming dynasty ritual altar complex',6.1,'/upload/20260602/639160112022167429.png','07:00-09:00'),
('Great Wall at Badaling','Badaling, Yanqing District, Beijing',40.3598,116.0200,'010-69121383',4.7,'$6','6:30-19:00','Best-known section of the Great Wall',70.0,'/upload/20260602/639160112022167429.png','08:00-11:00'),
('Beihai Park','1 Wenjin Street, Xicheng District, Beijing',39.9255,116.3830,'010-64001889',4.6,'$1','6:00-20:00','Former imperial garden around a lake',4.0,'/upload/20260602/639160112022167429.png','09:00-11:00'),
('Jingshan Park','1 Jingshan West Street, Xicheng District, Beijing',39.9246,116.3970,'010-64038098',4.6,'$0.5','6:00-21:00','Hill park with a view over the Forbidden City',3.5,'/upload/20260602/639160112022167429.png','16:00-18:00'),
('Lama Temple','12 Yonghegong Street, Dongcheng District, Beijing',39.9472,116.4172,'010-64027577',4.7,'$3','9:00-16:30','Tibetan Buddhist temple',5.2,'/upload/20260602/639160112022167429.png','09:00-10:30'),
('Bird''s Nest Stadium','1 National Stadium South Road, Chaoyang District, Beijing',39.9929,116.3966,'010-84373008',4.5,'$7','9:00-18:00','2008 Olympic main stadium',9.0,'/upload/20260602/639160112022167429.png','10:00-12:00'),
('Prince Gong Mansion','14 Liuyin Street, Xicheng District, Beijing',39.9372,116.3797,'010-83288149',4.4,'$5','7:30-17:00','Best-preserved Qing prince mansion',5.0,'/upload/20260602/639160112022167429.png','09:00-11:00'),
('Ming Dynasty City Wall Ruins Park','Chongwenmen East, Dongcheng District, Beijing',39.9025,116.4350,'010-65270574',4.2,'$0','0:00-24:00','Remains of the Ming city wall',6.8,'/upload/20260602/639160112022167429.png','15:00-17:00');

/* ---------- Reviews (31 rows; id 31 = admin "Hi,This is TEST" ตามสเปก 1.2.2) ---------- */
DECLARE @i1 NVARCHAR(100) = '/upload/20260602/639160112022167429.png';
DECLARE @i2 NVARCHAR(100) = '/upload/20260602/639160074121552317.png';

INSERT Reviews (UserId,BusinessType,BusinessId,Rating,ReviewContent,ReviewTime,ImageUrls,LikeCount) VALUES
-- 1-5: ตรงกับตัวอย่างในสเปกและ prototype ของ S2
(2,'scenic',1,5,'Very nice scenic spot, worth visiting!','2026-04-27 10:00:00',@i1+','+@i2,128),
(2,'restaurant',2,5,'Donglaishun''s hot pot mutton is authentic','2026-04-17 19:30:00',NULL,78),
(3,'restaurant',5,5,'Haidilao service is really excellent','2026-04-24 19:00:00',NULL,156),
(4,'restaurant',5,4,'Haidilao service is excellent and hot pot is delicious','2026-04-10 18:00:00',NULL,267),
(1,'restaurant',5,5,'delicious!','2026-06-02 16:49:29',@i2,0),
-- 6-19: แหล่งท่องเที่ยว
(3,'scenic',1,5,'Magnificent architecture, go early','2026-04-28 09:15:00',@i1,64),
(4,'scenic',1,4,'Crowded but absolutely worth it','2026-05-01 11:20:00',NULL,41),
(5,'scenic',2,5,'Beautiful lake view in the morning','2026-05-03 08:40:00',@i2,37),
(2,'scenic',2,4,'Lovely garden, bring water','2026-05-10 14:05:00',NULL,19),
(3,'scenic',3,5,'Peaceful and full of history','2026-04-02 07:30:00',@i1,52),
(4,'scenic',3,5,'Great place for a morning walk','2026-04-15 07:50:00',NULL,23),
(5,'scenic',4,4,'Steep climb but amazing views','2026-05-20 10:10:00',@i1+','+@i2,88),
(2,'scenic',4,5,'A must-see in Beijing','2026-05-22 09:00:00',NULL,95),
(3,'scenic',5,4,'Nice park, rent a boat','2026-03-30 15:25:00',@i2,17),
(4,'scenic',6,5,'Best sunset view of the city','2026-04-05 17:40:00',@i1,60),
(5,'scenic',7,4,'Peaceful temple, strong incense smell','2026-04-12 10:00:00',NULL,12),
(2,'scenic',8,4,'Impressive stadium architecture','2026-05-05 13:30:00',NULL,9),
(3,'scenic',9,3,'Nice but a bit pricey inside','2026-05-08 12:45:00',NULL,4),
(4,'scenic',10,3,'Quiet place, not much to see','2026-05-15 16:20:00',NULL,2),
-- 20-30: ร้านอาหาร
(2,'restaurant',1,5,'Crispy duck, wonderful skin','2026-04-20 12:10:00',@i1,73),
(3,'restaurant',1,4,'Good duck but long queue','2026-04-26 18:30:00',NULL,31),
(4,'restaurant',3,5,'Best roast duck I have had','2026-05-02 19:15:00',@i2,58),
(5,'restaurant',3,4,'Great flavor, friendly staff','2026-05-09 20:00:00',NULL,14),
(2,'restaurant',4,4,'Lean duck, nice presentation','2026-05-12 19:40:00',NULL,20),
(3,'restaurant',6,5,'Tastes just like home','2026-05-14 12:00:00',@i1,33),
(4,'restaurant',7,4,'Cheap and tasty snacks','2026-05-18 13:15:00',NULL,8),
(5,'restaurant',8,4,'Noodles are rich and savory','2026-05-25 11:50:00',NULL,6),
(2,'restaurant',9,5,'Very spicy and very good','2026-05-27 20:20:00',@i2,27),
(3,'restaurant',9,4,'Mapo tofu was excellent','2026-06-01 19:05:00',NULL,11),
(4,'restaurant',10,4,'Juicy dumplings, small place','2026-06-03 12:30:00',NULL,5),
-- 31: รีวิวของ admin ตามสเปก 1.2.2
(1,'scenic',2,5,'Hi,This is TEST','2026-05-28 13:36:39',@i1+','+@i2,10);
GO

/* ---------- Congestions (10) ---------- */
INSERT Congestions (RoadName,StartLatitude,StartLongitude,StartAddress,EndLatitude,EndLongitude,EndAddress,CongestionLevel,CongestionLength,DelayTime) VALUES
('Central Ave',39.1500,-75.4500,'Dover Central Ave',39.1600,-75.4400,'Dover Capitol','severe',900,'15 minutes'),
('Home to Gas Station',39.1520,-75.4435,'Home',39.1600,-75.4440,'Gas Station','severe',1200,'18 minutes'),
('Gas Station to Restaurant',39.1600,-75.4440,'Gas Station',39.1650,-75.4500,'Restaurant','moderate',800,'8 minutes'),
('Restaurant to Company',39.1650,-75.4500,'Restaurant',39.1685,-75.4698,'Company','smooth',1500,'0 minutes'),
('Bayside Drive',39.1552,-75.4435,'Bayside Drive',39.1580,-75.4480,'Bayside Dr North','moderate',600,'6 minutes'),
('North Little Creek Road',39.1685,-75.4698,'North Little Creek Rd',39.1700,-75.4650,'Little Creek Jct','smooth',700,'0 minutes'),
('Forest Ave',39.1450,-75.5240,'Forest Ave South',39.1500,-75.5200,'Forest Ave North','severe',1000,'12 minutes'),
('Loockerman St',39.1580,-75.5260,'Loockerman West',39.1590,-75.5200,'Loockerman East','moderate',500,'5 minutes'),
('State St',39.1560,-75.5230,'State St South',39.1620,-75.5230,'State St North','smooth',650,'0 minutes'),
('Route 13',39.1400,-75.5100,'Route 13 South',39.1700,-75.5100,'Route 13 North','severe',2200,'25 minutes');
GO

/* ---------- ตรวจผล ---------- */
SELECT 'Users' AS TableName, COUNT(*) AS Cnt FROM Users
UNION ALL SELECT 'Restaurants', COUNT(*) FROM Restaurants
UNION ALL SELECT 'ScenicSpots', COUNT(*) FROM ScenicSpots
UNION ALL SELECT 'Reviews', COUNT(*) FROM Reviews        -- ต้องได้ 31
UNION ALL SELECT 'Congestions', COUNT(*) FROM Congestions;
