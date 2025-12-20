-- =====================================================
-- ARCHIVE BOX MANAGEMENT DATABASE
-- Tier 2: Dependent Tables (Requires Tier 1)
-- =====================================================
-- Author: Kelsey Kiantoro
-- Course: INFO639 Database Design (Fall 2024)
-- Description: Tables with dependencies on Tier 1
-- =====================================================

-- =====================================================
-- TABLE 10: BOX_STATUS
-- =====================================================
CREATE TABLE IF NOT EXISTS BOX_STATUS(
    Status_ID INT NOT NULL PRIMARY KEY,
    Status_Name ENUM ('Available', 'Unavailable--Checked out', 'Unavailable--On Loan', 'Unavailable--In Conservation'),
    Description VARCHAR(300),
    Staff_id INT,
    FOREIGN KEY (Staff_id) REFERENCES STAFF(staff_id)
);

-- =====================================================
-- TABLE 11: PATRON
-- =====================================================
CREATE TABLE IF NOT EXISTS PATRON(
    Patron_ID INT NOT NULL PRIMARY KEY,
    Patron_FName VARCHAR(50),
    Patron_LName VARCHAR(50),
    Department CHAR(50),
    Contact_Email VARCHAR(50),
    Patron_Role_ID INT,
    FOREIGN KEY (Patron_Role_ID) REFERENCES PATRON_ROLE(Patron_Role_ID)
);

-- =====================================================
-- TABLE 12: EXTERNAL_LOCATION
-- =====================================================
CREATE TABLE IF NOT EXISTS EXTERNAL_LOCATION(
    External_Location_ID INT NOT NULL PRIMARY KEY,
    External_CPFname VARCHAR(50),
    External_CPLname VARCHAR(50),
    External_Contact_Number VARCHAR(45),
    External_Contact_Email VARCHAR(50),
    External_Address VARCHAR(50),
    Institution_Type_ID INT,
    FOREIGN KEY (Institution_Type_ID) REFERENCES INSTITUTION_TYPE(Institution_Type_ID)
);

-- =====================================================
-- TABLE 13: TEMP_RECORD
-- =====================================================
CREATE TABLE IF NOT EXISTS TEMP_RECORD(
    Record_ID INT NOT NULL PRIMARY KEY,
    Reading_DateTime DATETIME,
    Temperature FLOAT(5, 2),
    Humidity FLOAT(5, 2),
    Description VARCHAR(300),
    Report BOOL,
    Location_ID INT,
    FOREIGN KEY (Location_ID) REFERENCES LOCATION(Location_ID),
    Staff_id INT,
    FOREIGN KEY (Staff_id) REFERENCES STAFF(Staff_id)
);

-- =====================================================
-- TABLE 14: BOX_INVENTORY_RECORD
-- =====================================================
CREATE TABLE IF NOT EXISTS BOX_INVENTORY_RECORD(
    Inventory_ID VARCHAR(40) NOT NULL PRIMARY KEY,
    Total_available_box INT(3),
    Last_modified_date DATE,
    Box_Size_ID INT,
    FOREIGN KEY (Box_Size_ID) REFERENCES BOX_SIZE_TYPE(Box_Size_ID),
    Location_ID INT,
    FOREIGN KEY (Location_ID) REFERENCES LOCATION(Location_ID),
    Staff_id INT,
    FOREIGN KEY (Staff_id) REFERENCES STAFF(Staff_id)
);

-- =====================================================
-- END OF TIER 2 DEPENDENT TABLES
-- =====================================================
