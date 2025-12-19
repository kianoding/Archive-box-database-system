-- =====================================================
-- ARCHIVE BOX MANAGEMENT DATABASE
-- Tier 3: Core Operational Tables (Requires Tiers 1 & 2)
-- =====================================================
-- Author: Kelsey Kiantoro
-- Course: INFO639 Database Design (Fall 2024)
-- Description: Main operational tables for archive workflows
-- =====================================================

-- =====================================================
-- TABLE 15: BOX
-- =====================================================
CREATE TABLE IF NOT EXISTS BOX(
    Box_ID VARCHAR(40) NOT NULL PRIMARY KEY,
    Assign_Date DATE,
    Last_Modified_Date DATE,
    Box_Size_ID INT,
    FOREIGN KEY (Box_Size_ID) REFERENCES BOX_SIZE_TYPE(Box_Size_ID),
    Status_ID INT,
    FOREIGN KEY (Status_ID) REFERENCES BOX_STATUS(Status_ID),
    Location_ID INT,
    FOREIGN KEY (Location_ID) REFERENCES LOCATION(Location_ID),
    Classification_ID INT,
    FOREIGN KEY (Classification_ID) REFERENCES CULTURAL_CLASS(Classification_ID),
    Staff_id INT,
    FOREIGN KEY (Staff_id) REFERENCES STAFF(Staff_id)
);

-- =====================================================
-- TABLE 16: ITEM
-- =====================================================
CREATE TABLE IF NOT EXISTS ITEM(
    Item_ID VARCHAR(40) NOT NULL PRIMARY KEY,
    Image_File_Path TINYBLOB,
    Box_ID VARCHAR(40),
    FOREIGN KEY (Box_ID) REFERENCES BOX(Box_ID),
    Item_Type_ID INT,
    FOREIGN KEY (Item_Type_ID) REFERENCES ITEM_TYPE(Item_Type_ID),
    Condition_ID INT,
    FOREIGN KEY (Condition_ID) REFERENCES CONDITION_TYPE(Condition_ID)
);

-- =====================================================
-- TABLE 17: ITEM_STATUS_NAME
-- =====================================================
CREATE TABLE IF NOT EXISTS ITEM_STATUS_NAME(
    Status_ID VARCHAR(40) NOT NULL PRIMARY KEY,
    Item_Status_Name ENUM ('Available', 'unavailable--Checked out', 'unavailable--On Loan', 'unavailable--In Conservation'),
    Description VARCHAR(300),
    Staff_id INT,
    FOREIGN KEY (Staff_id) REFERENCES STAFF(Staff_id),
    Item_ID VARCHAR(40),
    FOREIGN KEY (Item_ID) REFERENCES ITEM(Item_ID)
);

-- =====================================================
-- TABLE 18: CHECKOUT_RECORD
-- =====================================================
CREATE TABLE IF NOT EXISTS CHECKOUT_RECORD(
    Checkout_ID VARCHAR(40) NOT NULL PRIMARY KEY,
    Checkout_DateTime DATETIME,
    Return_DateTime DATETIME,
    Purpose VARCHAR(300),
    Staff_id INT,
    FOREIGN KEY (Staff_id) REFERENCES STAFF(Staff_id),
    Box_ID VARCHAR(40),
    FOREIGN KEY (Box_ID) REFERENCES BOX(Box_ID),
    Item_ID VARCHAR(40),
    FOREIGN KEY (Item_ID) REFERENCES ITEM(Item_ID),
    Patron_ID INT,
    FOREIGN KEY (Patron_ID) REFERENCES PATRON(Patron_ID)
);

-- =====================================================
-- TABLE 19: SHIPPING_RECORD
-- =====================================================
CREATE TABLE IF NOT EXISTS SHIPPING_RECORD(
    Shipping_Record_ID INT NOT NULL PRIMARY KEY,
    Movement_Date DATE,
    Return_Due_Date DATE,
    Actual_Return_Date DATE,
    Box_ID VARCHAR(40),
    FOREIGN KEY (Box_ID) REFERENCES BOX(Box_ID),
    Movement_Type_ID INT,
    FOREIGN KEY (Movement_Type_ID) REFERENCES MOVEMENT_TYPE(Movement_Type_ID),
    From_Location_ID INT, -- Internal Location
    FOREIGN KEY (From_Location_ID) REFERENCES LOCATION(Location_ID),
    To_Location_ID INT, -- External Location
    FOREIGN KEY (To_Location_ID) REFERENCES EXTERNAL_LOCATION(External_Location_ID),
    Staff_id INT,
    FOREIGN KEY (Staff_id) REFERENCES STAFF(staff_id)
);

-- =====================================================
-- END OF TIER 3 OPERATIONAL TABLES
-- =====================================================
