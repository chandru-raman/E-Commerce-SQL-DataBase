USE e_kart;

BEGIN TRANSACTION;

-- Customer table data - 1

INSERT INTO customers(first_name,last_name,email_id,phone_no,address,city,country)
VALUES
('Ravi','Kumar','ravikumar345@gmail.com','8940576880','123 MG Road','Mumbai','India'),
('Priya','Sharma','priyasharama.4546@gmail.com','9776543211','456 Banjara Hills','Hyderabad','India'),
('Arvind','Patel','aravindpatel782@email.com','755037894','789 Ashoka Road','Ahmedabad','India'),
('Neha','Yadav','nehayadavmailid@gmail.com','6365385689','101 Krishna Nagar','Delhi','India'),
('Rajesh','Verma','rajeshverma890@gmail.com','8534792310','202 Kalyan Nagar','Bangalore','India'),
('Simran','Kaur','simrankaur200@gmail.com','7000043215','303 Rani Bagh','Chandigarh','India'),
('Ankit','Singh','ankitsingh57@gmail.com','9876543567','404 Rajiv Gandhi Marg','Lucknow','India'),
('Aarti','Gupta','aartigupta003@gmail.com','6788211217','505 Kesar Bagh','Jaipur','India'),
('Vikas','Mehra','vikasmehra000@gmail.com','896664378','606 Shivaji Nagar','Pune','India'),
('Manisha','Reddy','manishareddy923@gmail.com','9000534570','707 Gachibowli','Hyderabad','India'),
('Suresh','Iyer','sureshiyer798@gmail.com','6885644100','808 Baghpat Road','Kolkata','India'),
('Sneha','Khatri','snehakhatri666@gmail.com','8744914678','909 Ambedkar Nagar','Bhopal','India'),
('Karan','Dixit','karandixit@gmail.com','7889655621','1010 Sector 15','Gurgaon','India'),
('Meenal','Shukla','meenalshukla57@gmail.com','8936793582','1111 Mayur Vihar','Noida','India'),
('Deepak','Jain','deepakjain78998@gmail.com','8936735111','1212 Pratap Nagar','Indore','India'),
('Pooja','Bhatia','poojabhatia24344@gmail.com','7727228991','1313 Dwarka Sector 12','Delhi','India'),
('Ashok','Bansal','ashokbansal522345@gmail.com','9998173811','1414 Model Town','Faridabad','India'),
('Shivani','Chopra','shivanichopra6789@gmail.com','7378298267','1515 Connaught Place','Delhi','India'),
('Rohit','Gupta','rohitgupta78854@gmail.com','9800543228','1616 New Market','Surat','India'),
('Tanya','Rathore','tanyarathore722@gmail.com','9986543229','1717 Sadar Bazar','Nagpur','India');


-- Category table data - 2
INSERT INTO category(category_name)
VALUES
('Electronics'),
('Clothing'),
('Home & Kitchen'),
('Sports & Outdoors'),
('Beauty & Personal Care'),
('Books'),
('Toys & Games'),
('Automotive'),
('Health'),
('Grocery'),
('Furniture'),
('Jewelry'),
('Music'),
('Baby Products'),
('Office Supplies'),
('Pet Supplies'),
('Garden & Outdoors'),
('Tools & Home Improvement'),
('Arts & Crafts'),
('Food & Beverage');

-- Product table data - 3

INSERT INTO products(product_id,name,description,price,stock_quantity,category_id)
VALUES
('P1001','Laptop','15 inch, 8GB RAM, 1TB HDD',50000.0,50,200),
('P1002','Smartphone','6.5 inch display, 128GB Storage',25000.0,100,200),
('P1003','T-Shirt','Cotton, Size M',500.0,200,201),
('P1004','Blender','750W, 3 Speed',2500.0,80,202),
('P1005','Basketball','Size 7, Indoor/Outdoor',1500.0,150,203),
('P1006','Face Cream','Hydrating, 50g',300.0,200,204),
('P1007','Novel','A gripping mystery novel',250.0,75,205),
('P1008','Board Game','2-4 players',800.0,60,206),
('P1009','Car Battery','12V, 200Ah',6000.0,40,207),
('P1010','Vitamins','Multivitamins, 30 Tablets',500.0,250,208),
('P1011','Sofa','3-Seater, Leather',20000.0,20,209),
('P1012','Necklace','Gold-plated, Adjustable',4000.0,100,210),
('P1013','Guitar','Acoustic, 6-string',6000.0,40,211),
('P1014','Baby Diapers','Pack of 50',1000.0,500,212),
('P1015','Desk Chair','Ergonomic, Adjustable Height',5000.0,60,209),
('P1016','Dog Collar','Leather, Medium',700.0,120,213),
('P1017','Garden Hose','50ft, Heavy Duty',1500.0,90,214),
('P1018','Power Drill','Cordless, 18V',4000.0,40,215),
('P1019','Paint Set','12 colors, Watercolor',800.0,150,216),
('P1020','Tea Pack','Assorted, 500g',200.0,100,217);


-- Orders table data - 4

INSERT INTO orders(customer_id,total_amount,status)
VALUES
(100,10000.00,'active'),
(101,2500.00,'active'),
(102,15000.00,'active'),
(103,2000.00,'active'),
(104,50000.00,'non-active'),
(105,12000.00,'active'),
(106,8500.00,'non-active'),
(107,3200.00,'active'),
(108,4500.00,'active'),
(109,5000.00,'non-active'),
(110,7000.00,'active'),
(111,1800.00,'active'),
(112,4000.00,'non-active'),
(113,2500.00,'active'),
(114,3500.00,'active'),
(115,15000.00,'active'),
(116,2200.00,'active'),
(117,6000.00,'non-active'),
(118,10000.00,'active'),
(119,8500.00,'active');

-- Order items table data - 5

INSERT INTO order_items(order_item_id,order_id,product_id,quantity,unit_price,subtotal)
VALUES
('OI1',1,'P1001',1,50000.00,50000.00),
('OI2',2,'P1002',1,25000.00,25000.00),
('OI3',3,'P1003',2,500.00,1000.00),
('OI4',4,'P1004',1,2500.00,2500.00),
('OI5',5,'P1005',2,1500.00,3000.00),
('OI6',6,'P1006',3,300.00,900.00),
('OI7',7,'P1007',1,250.00,250.00),
('OI8',8,'P1008',2,800.00,1600.00),
('OI9',9,'P1009',1,6000.00,6000.00),
('OI10',10,'P1010',2,500.00,1000.00),
('OI11',11,'P1011',1,20000.00,20000.00),
('OI12',12,'P1012',1,4000.00,4000.00),
('OI13',13,'P1013',1,6000.00,6000.00),
('OI14',14,'P1014',4,1000.00,4000.00),
('OI15',15,'P1015',2,5000.00,10000.00),
('OI16',16,'P1016',1,700.00,700.00),
('OI17',17,'P1017',2,1500.00,3000.00),
('OI18',18,'P1018',1,4000.00,4000.00),
('OI19',19,'P1019',3,800.00,2400.00),
('OI20',20,'P1020',1,200.00,200.00);


-- Payment method table data - 6

INSERT INTO payments(order_id,payment_method,amount)
VALUES
(1,'UPI',10000.00),
(2,'CARD',2500.00),
(3,'CASH',15000.00),
(4,'UPI',2000.00),
(5,'CARD',50000.00),
(6,'CASH',12000.00),
(7,'UPI',8500.00),
(8,'CARD',3200.00),
(9,'CASH',4500.00),
(10,'UPI',5000.00),
(11,'CARD',7000.00),
(12,'CASH',1800.00),
(13,'UPI',4000.00),
(14,'CARD',2500.00),
(15,'CASH',3500.00),
(16,'UPI',15000.00),
(17,'CARD',2200.00),
(18,'CASH',6000.00),
(19,'UPI',10000.00),
(20,'CARD',8500.00);

COMMIT;

