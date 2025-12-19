-- =====================================================
-- ARCHIVE BOX MANAGEMENT DATABASE
-- Tier 1: Foundation Tables (No Dependencies)
-- =====================================================
-- Author: Kelsey Kiantoro
-- Course: INFO639 Database Design (Fall 2024)
-- Description: Core lookup tables and reference data
-- =====================================================

-- =====================================================
-- TABLE 1: STAFF
-- =====================================================
CREATE TABLE IF NOT EXISTS STAFF (
    staff_id INT NOT NULL PRIMARY KEY,
    staff_fname VARCHAR(50),
    staff_lname VARCHAR(50),
    staff_role ENUM('Archivist', 'Collection Manager', 'Archive Librarian', 'Admin')
);

-- =====================================================
-- TABLE 2: BOX_SIZE_TYPE
-- =====================================================
CREATE TABLE IF NOT EXISTS BOX_SIZE_TYPE(
    Box_Size_ID INT NOT NULL PRIMARY KEY,
    Size_Name VARCHAR(40),
    Width DECIMAL(6, 2),
    Depth DECIMAL(6, 2),
    Height DECIMAL(6, 2),
    Description VARCHAR(300)
);

-- =====================================================
-- TABLE 3: CULTURAL_CLASS
-- =====================================================
CREATE TABLE IF NOT EXISTS CULTURAL_CLASS(
    Classification_ID INT NOT NULL PRIMARY KEY,
    Classification_Name VARCHAR(40),
    Description VARCHAR(300)
);

-- =====================================================
-- TABLE 4: ITEM_TYPE
-- =====================================================
CREATE TABLE IF NOT EXISTS ITEM_TYPE(
    Item_Type_ID INT NOT NULL PRIMARY KEY,
    Item_Type_Name VARCHAR(40),
    Description VARCHAR(300)
);

-- =====================================================
-- TABLE 5: PATRON_ROLE
-- =====================================================
CREATE TABLE IF NOT EXISTS PATRON_ROLE(
    Patron_Role_ID INT NOT NULL PRIMARY KEY,
    Role_Name ENUM('Student','Faculty','Researcher','Curator'),
    Description VARCHAR(300)
);

-- =====================================================
-- TABLE 6: MOVEMENT_TYPE
-- =====================================================
CREATE TABLE IF NOT EXISTS MOVEMENT_TYPE(
    Movement_Type_ID INT NOT NULL PRIMARY KEY,
    Movement_Type_Name VARCHAR(40),
    Description VARCHAR(300)
);

-- =====================================================
-- TABLE 7: INSTITUTION_TYPE
-- =====================================================
CREATE TABLE IF NOT EXISTS INSTITUTION_TYPE(
    Institution_Type_ID INT NOT NULL PRIMARY KEY,
    Ins_Type_Name VARCHAR(40),
    Description VARCHAR(300)
);

-- =====================================================
-- TABLE 8: CONDITION_TYPE
-- =====================================================
CREATE TABLE IF NOT EXISTS CONDITION_TYPE(
    Condition_ID INT NOT NULL PRIMARY KEY,
    Condition_Name VARCHAR(50),
    Handling_Guidance VARCHAR(100),
    Description VARCHAR(300),
    Checking_Date DATE
);

-- =====================================================
-- TABLE 9: LOCATION
-- =====================================================
CREATE TABLE IF NOT EXISTS LOCATION(
    Location_ID INT NOT NULL PRIMARY KEY,
    Building VARCHAR(40),
    Room VARCHAR(40),
    Section INT,
    Shelf VARCHAR(5),
    Shelf_Row INT
);

-- =====================================================
-- END OF TIER 1 FOUNDATION TABLES
-- =====================================================
