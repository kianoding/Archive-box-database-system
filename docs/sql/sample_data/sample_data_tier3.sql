#INSERT for TIER 3
-- SQL INSERTS that follow were generated with the assistance of 
-- Antrophic's Claude Sonnet 4.5 language model.

## 15. BOX
INSERT INTO BOX (Box_ID, Assign_Date, Last_Modified_Date, Box_Size_ID, Status_ID, Location_ID, Classification_ID, Staff_id)
VALUES
	('BOX001', '2023-06-15', '2024-11-20', 2, 1, 1, 1, 1),
	('BOX002', '2023-08-10', '2024-12-01', 2, 2, 5, 2, 2),
	('BOX003', '2024-01-20', '2024-12-05', 3, 1, 2, 3, 3),
	('BOX004', '2024-02-14', '2024-12-08', 1, 1, 1, 4, 5),
	('BOX005', '2023-11-05', '2024-11-28', 4, 3, 8, 5, 6),
	('BOX006', '2024-03-22', '2024-12-10', 2, 1, 3, 6, 1),
	('BOX007', '2024-04-18', '2024-12-09', 3, 1, 4, 7, 7),
	('BOX008', '2023-09-30', '2024-11-15', 5, 1, 2, 8, 2),
	('BOX009', '2024-05-12', '2024-12-11', 1, 4, 9, 1, 5),
	('BOX010', '2024-06-08', '2024-12-07', 2, 1, 1, 2, 3
);

## 16. ITEM
INSERT INTO ITEM (Item_ID, Image_File_Path, Box_ID, Item_Type_ID, Condition_ID)
VALUES
	('ITEM001', NULL, 'BOX001', 1, 1),
	('ITEM002', NULL, 'BOX001', 2, 1),
	('ITEM003', NULL, 'BOX002', 1, 2),
	('ITEM004', NULL, 'BOX002', 1, 2),
	('ITEM005', NULL, 'BOX003', 1, 1),
	('ITEM006', NULL, 'BOX003', 2, 2),
	('ITEM007', NULL, 'BOX004', 2, 1),
	('ITEM008', NULL, 'BOX004', 2, 1),
	('ITEM009', NULL, 'BOX005', 1, 3),
	('ITEM010', NULL, 'BOX005', 3, 3),
	('ITEM011', NULL, 'BOX006', 1, 1),
	('ITEM012', NULL, 'BOX006', 1, 2),
	('ITEM013', NULL, 'BOX007', 3, 2),
	('ITEM014', NULL, 'BOX007', 1, 2),
	('ITEM015', NULL, 'BOX008', 3, 1),
	('ITEM016', NULL, 'BOX008', 3, 1),
	('ITEM017', NULL, 'BOX009', 2, 3),
	('ITEM018', NULL, 'BOX009', 2, 3),
	('ITEM019', NULL, 'BOX010', 1, 1),
	('ITEM020', NULL, 'BOX010', 2, 2
);


## 17. ITEM_STATUS_NAME
INSERT INTO ITEM_STATUS_NAME (Status_ID, Item_Status_Name, Description, Staff_id, Item_ID)
VALUES
('STATUS001', 'Available', 'Item available in archive storage', 1, 'ITEM001'),
('STATUS002', 'Available', 'Item available in archive storage', 1, 'ITEM002'),
('STATUS003', 'Unavailable--Checked out', 'Item checked out to patron', 2, 'ITEM003'),
('STATUS004', 'Unavailable--Checked out', 'Item checked out to patron', 2, 'ITEM004'),
('STATUS005', 'Available', 'Item available in archive storage', 3, 'ITEM005'),
('STATUS006', 'Available', 'Item available in archive storage', 3, 'ITEM006'),
('STATUS007', 'Available', 'Item available in archive storage', 5, 'ITEM007'),
('STATUS008', 'Available', 'Item available in archive storage', 5, 'ITEM008'),
('STATUS009', 'Unavailable--On Loan', 'Item on loan to external institution', 6, 'ITEM009'),
('STATUS010', 'Unavailable--On Loan', 'Item on loan to external institution', 6, 'ITEM010'),
('STATUS011', 'Available', 'Item available in archive storage', 1, 'ITEM011'),
('STATUS012', 'Available', 'Item available in archive storage', 1, 'ITEM012'),
('STATUS013', 'Available', 'Item available in archive storage', 7, 'ITEM013'),
('STATUS014', 'Available', 'Item available in archive storage', 7, 'ITEM014'),
('STATUS015', 'Available', 'Item available in archive storage', 2, 'ITEM015'),
('STATUS016', 'Available', 'Item available in archive storage', 2, 'ITEM016'),
('STATUS017', 'Unavailable--In Conservation', 'Item in conservation treatment', 5, 'ITEM017'),
('STATUS018', 'Unavailable--In Conservation', 'Item in conservation treatment', 5, 'ITEM018'),
('STATUS019', 'Available', 'Item available in archive storage', 3, 'ITEM019'),
('STATUS020', 'Available', 'Item available in archive storage', 3, 'ITEM020'
);


## 18. CHECKOUT_RECORD
INSERT INTO CHECKOUT_RECORD (Checkout_ID, Checkout_DateTime, Return_DateTime, Purpose, Staff_id, Box_ID, Item_ID, Patron_ID)
VALUES
	('CHK001', '2024-12-01 09:30:00', '2024-12-01 14:45:00', 'Research for dissertation on 19th century fashion', 2, 'BOX002', 'ITEM003', 1),
	('CHK002', '2024-11-20 10:00:00', '2024-11-20 15:30:00', 'Textile analysis for course material', 3, 'BOX003', 'ITEM005', 2),
	('CHK003', '2024-12-12 13:00:00', NULL, 'Museum exhibition research (currently in study room)', 5, 'BOX006', 'ITEM011', 3),
	('CHK004', '2024-12-05 11:15:00', '2024-12-05 16:00:00', 'Costume design reference for theater production', 1, 'BOX007', 'ITEM013', 4),
	('CHK005', '2024-11-15 14:30:00', '2024-11-15 17:00:00', 'Cultural heritage documentation project', 6, 'BOX010', 'ITEM019', 5
);

## 19. SHIPPING_RECORD
INSERT INTO SHIPPING_RECORD (Shipping_Record_ID, Movement_Date, Return_Due_Date, Actual_Return_Date, Box_ID, Movement_Type_ID, From_Location_ID, To_Location_ID, Staff_id)
VALUES
(1, '2024-11-28', '2025-02-28', NULL, 'BOX005', 2, 1, 1, 6),
(2, '2024-10-15', '2024-12-15', '2024-12-10', 'BOX003', 3, 2, 4, 3),
(3, '2024-11-01', '2025-01-01', NULL, 'BOX007', 1, 4, 2, 7),
(4, '2024-09-10', '2024-12-10', '2024-12-01', 'BOX001', 4, 1, 5, 2),
(5, '2024-08-20', '2024-11-20', '2024-11-18', 'BOX006', 5, 3, 3, 5
);




