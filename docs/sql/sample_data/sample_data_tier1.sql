
#INSERT for TIER 1
-- SQL INSERTS that follow were generated with the assistance of 
-- Antrophic's Claude Sonnet 4.5 language model.

## 1. STAFF
INSERT INTO STAFF (staff_id, staff_fname, staff_lname, staff_role) VALUES
(1, 'Sarah', 'Johnson', 'Archivist'),
(2, 'Michael', 'Chen', 'Collection Manager'),
(3, 'Emily', 'Rodriguez', 'Archive Librarian'),
(4, 'David', 'Kim', 'Admin'),
(5, 'Lisa', 'Park', 'Archivist'),
(6, 'James', 'Williams', 'Archivist'),
(7, 'Maria', 'Garcia', 'Collection Manager'),
(8, 'Robert', 'Taylor', 'Archive Librarian'
);

## 2. BOX_SIZE_TYPE
INSERT INTO BOX_SIZE_TYPE (Box_Size_ID, Size_Name, Width, Depth, Height, Description) VALUES
(1, 'Small Flat Box', 12.00, 15.00, 3.00, 'Standard small archival box for small garments and accessories (dimensions in inches)'),
(2, 'Medium Flat Box', 15.00, 20.00, 5.00, 'Medium archival box for dresses and medium garments (dimensions in inches)'),
(3, 'Large Flat Box', 20.00, 24.00, 6.00, 'Large archival box for coats and large garments (dimensions in inches)'),
(4, 'Oversize Flat Box', 30.00, 40.00, 8.00, 'Oversize box for very large garments and textiles (dimensions in inches)'),
(5, 'Roll Box/Tube', 6.00, 6.00, 40.00, 'Cylindrical tube for rolled textiles and fabrics (dimensions in inches)'
);

## 3. CULTURAL_CLASS
INSERT INTO CULTURAL_CLASS (Classification_ID, Classification_Name, Description) VALUES
(1, 'Western European', 'Garments and textiles from Western European traditions'),
(2, 'East Asian', 'Garments and textiles from China, Japan, Korea'),
(3, 'South Asian', 'Garments and textiles from India, Pakistan, Bangladesh'),
(4, 'Southeast Asian', 'Garments and textiles from Thailand, Vietnam, Indonesia'),
(5, 'Indigenous American', 'Native American and Indigenous peoples garments from North America'),
(6, 'Latin American', 'Garments and textiles from Guatemala, Mexico, Central and South America'),
(7, 'African', 'Garments and textiles from African cultures'),
(8, 'Middle Eastern', 'Garments and textiles from Middle Eastern traditions'
);

## 4. ITEM_TYPE
INSERT INTO ITEM_TYPE (Item_Type_ID, Item_Type_Name, Description) VALUES
(1, 'Costume', 'Complete garments including dresses, coats, suits'),
(2, 'Accessories', 'Hats, shoes, jewelry, gloves, and other accessories'),
(3, 'Textiles/Decor', 'Fabric lengths, decorative textiles, and samples'
);

## 5. PATRON_ROLE
INSERT INTO PATRON_ROLE (Patron_Role_ID, Role_Name, Description) VALUES
(1, 'Student', 'University students conducting research'),
(2, 'Faculty', 'Faculty members from academic institutions'),
(3, 'Researcher', 'Independent researchers and scholars'),
(4, 'Curator', 'Museum curators and exhibition professionals'
);

## 6. MOVEMENT_TYPE
INSERT INTO MOVEMENT_TYPE (Movement_Type_ID, Movement_Type_Name, Description) VALUES
(1, 'Loan', 'Temporary loan to external institution'),
(2, 'Exhibition', 'Shipped for public exhibition'),
(3, 'Conservation', 'Sent to external conservation facility for treatment'),
(4, 'Research', 'Shipped for external research project'),
(5, 'Photography', 'Sent for professional photography/documentation'
);

## 7. INSTITUTION_TYPE
INSERT INTO INSTITUTION_TYPE (Institution_Type_ID, Ins_Type_Name, Description) VALUES
(1, 'Museum', 'Art museums and cultural institutions'),
(2, 'University', 'Academic institutions and universities'),
(3, 'Conservation Lab', 'Professional conservation facilities'),
(4, 'Gallery', 'Commercial or non-profit art galleries'),
(5, 'Research Institution', 'Research centers and institutes'
);

## 8. CONDITION_TYPE
INSERT INTO CONDITION_TYPE (Condition_ID, Condition_Name, Handling_Guidance, Description, Checking_Date)
VALUES
	(1, 'Good', 'Standard handling with gloves', 'Item in stable condition with minimal to moderate wear', '2024-01-15'),
	(2, 'Fair', 'Handle with extra care, provide support', 'Noticeable wear and some fragility', '2024-02-10'),
	(3, 'Requires Conservation', 'Minimal handling, conservation consultation required', 'Significant damage or extreme fragility requiring treatment', '2024-03-20'
);

## 9. LOCATION
INSERT INTO LOCATION (Location_ID, Building, Room, Section, Shelf, Shelf_Row) VALUES
(1, 'Main Archive', 'Archive Room 205', 1, 'A', 1),
(2, 'Main Archive', 'Archive Room 205', 1, 'A', 2),
(3, 'Main Archive', 'Archive Room 205', 2, 'B', 1),
(4, 'Main Archive', 'Archive Room 206', 1, 'C', 1),
(5, 'Main Archive', 'Study Room 1', 1, 'A', 1),
(6, 'Main Archive', 'Study Room 2', 1, 'A', 1),
(7, 'Main Archive', 'Processing Room', 1, 'A', 1),
(8, 'Main Archive', 'Outgoing Staging Room', 1, 'A', 1),
(9, 'Conservation Lab', '101', 1, 'C', 1),
(10, 'Main Archive', 'Storage Room', 1, 'A', 1);


