#INSERT for TIER 2
-- SQL INSERTS that follow were generated with the assistance of 
-- Antrophic's Claude Sonnet 4.5 language model.

## 10. BOX_STATUS
INSERT INTO BOX_STATUS (Status_ID, Status_Name, Description, Staff_id)
VALUES
	(1, 'Available', 'Box is available in archive storage', 1),
	(2, 'Unavailable--Checked out', 'Box checked out to patron for study', 2),
	(3, 'Unavailable--On Loan', 'Box loaned to external institution', 3),
	(4, 'Unavailable--In Conservation', 'Box undergoing conservation treatment', 5
);

## 11. PATRON
INSERT INTO PATRON (Patron_ID, Patron_FName, Patron_LName, Department, Contact_Email, Patron_Role_ID)
VALUES
	(1, 'Jennifer', 'Martinez', 'Fashion History', 'j.martinez@university.edu', 1),
	(2, 'Robert', 'Chang', 'Textile Design', 'r.chang@university.edu', 2),
	(3, 'Amanda', 'Williams', 'Art History', 'a.williams@museum.org', 3),
	(4, 'David', 'Patel', 'Costume Design', 'd.patel@university.edu', 1),
	(5, 'Sarah', 'Thompson', 'Museum Studies', 's.thompson@gallery.org', 4),
	(6, 'Michael', 'Lee', 'Anthropology', 'm.lee@research.edu', 3
);

## 12. EXTERNAL_LOCATION
INSERT INTO EXTERNAL_LOCATION (External_Location_ID, External_CPFname, External_CPLname, External_Contact_Number, External_Contact_Email, External_Address, Institution_Type_ID)
VALUES
	(1, 'Elizabeth', 'Johnson', '12125550100', 'e.johnson@metmuseum.org', '1000 5th Ave, New York, NY 10028', 1),
	(2, 'James', 'Rodriguez', '12155550200', 'j.rodriguez@philamuseum.org', '2600 Benjamin Franklin Pkwy, Philadelphia, PA', 1),
	(3, 'Maria', 'Chen', '12025550300', 'm.chen@si.edu', '14th St & Constitution Ave NW, Washington DC', 1),
	(4, 'David', 'Brown', '16175550400', 'd.brown@conservationlab.com', '25 Main St, Cambridge, MA 02138', 3),
	(5, 'Jennifer', 'White', '13105550500', 'j.white@lacma.org', '5905 Wilshire Blvd, Los Angeles, CA 90036', 1
);

## 13. TEMP_RECORD
INSERT INTO TEMP_RECORD (Record_ID, Reading_DateTime, Temperature, Humidity, Description, Report, Location_ID, Staff_id)
VALUES
	(1, '2024-12-01 09:00:00', 20.5, 45.0, 'Normal morning reading', 0, 1, 1),
	(2, '2024-12-01 13:00:00', 28.3, 68.5, 'Temperature spike - HVAC malfunction reported', 1, 1, 2),
	(3, '2024-12-01 17:00:00', 21.0, 46.2, 'Normal evening reading after HVAC repair', 0, 1, 1),
	(4, '2024-12-02 09:00:00', 19.8, 42.0, 'Normal morning reading', 0, 2, 3),
	(5, '2024-12-02 13:00:00', 20.2, 44.5, 'Normal afternoon reading', 0, 3, 1),
	(6, '2024-12-03 09:00:00', 21.5, 47.0, 'Normal morning reading', 0, 4, 5),
	(7, '2024-12-03 15:00:00', 26.8, 62.0, 'Humidity spike - door left open', 1, 2, 2
);


## 14. INVENTORY_RECORD
INSERT INTO BOX_INVENTORY_RECORD (Inventory_ID, Total_available_box, Last_modified_date, Box_Size_ID, Location_ID, Staff_id)
VALUES
	('INV001', 15, '2024-12-01', 1, 10, 2),
	('INV002', 20, '2024-12-01', 2, 10, 2),
	('INV003', 12, '2024-12-01', 3, 10, 2),
	('INV004', 8, '2024-12-01', 4, 10, 7),
	('INV005', 5, '2024-12-01', 5, 10, 7
);
