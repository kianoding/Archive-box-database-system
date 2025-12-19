-- =====================================================
-- ARCHIVE BOX MANAGEMENT DATABASE
-- Tier 1: Foundation Tables (No Dependencies)
-- =====================================================
-- Author: Kelsey Kiantoro
-- Course: INFO639 Database Design (Fall 2024)
-- Description: Core lookup tables and reference data
-- =====================================================

-- Drop tables if they exist (for clean re-run)
DROP TABLE IF EXISTS STAFF;
DROP TABLE IF EXISTS BOX_SIZE_TYPE;
DROP TABLE IF EXISTS CULTURAL_CLASS;
DROP TABLE IF EXISTS ITEM_TYPE;
DROP TABLE IF EXISTS PATRON_ROLE;
DROP TABLE IF EXISTS MOVEMENT_TYPE;
DROP TABLE IF EXISTS INSTITUTION_TYPE;
DROP TABLE IF EXISTS CONDITION_TYPE;
DROP TABLE IF EXISTS LOCATION;

-- =====================================================
-- TABLE 1: STAFF
-- Purpose: Archive personnel with role assignments
-- =====================================================
CREATE TABLE IF NOT EXISTS STAFF (
    staff_id INT NOT NULL PRIMARY KEY,
    staff_fname VARCHAR(50),
    staff_lname VARCHAR(50),
    staff_role ENUM('Archivist', 'Collection Manager', 'Archive Librarian', 'Admin')
);

-- =====================================================
-- TABLE 2: BOX_SIZE_TYPE
-- Purpose: Physical dimensions for archive boxes
-- =====================================================
CREATE TABLE IF NOT EXISTS BOX_SIZE_TYPE (
    Box_Size_ID INT NOT NULL PRIMARY KEY,
    Size_Name VARCHAR(40),
    Width DECIMAL(6, 2),
    Depth DECIMAL(6, 2),
    Height DECIMAL(6, 2),
    Description VARCHAR(300)
);

-- =====================================================
-- TABLE 3: CULTURAL_CLASS
-- Purpose: Cultural/geographic origin classifications
-- =====================================================
CREATE TABLE IF NOT EXISTS CULTURAL_CLASS (
    Classification_ID INT NOT NULL PRIMARY KEY,
    Classification_Name VARCHAR(40),
    Description VARCHAR(300)
);

-- =====================================================
-- TABLE 4: ITEM_TYPE
-- Purpose: Garment and textile type categories
-- =====================================================
CREATE TABLE IF NOT EXISTS ITEM_TYPE (
    Item_Type_ID INT NOT NULL PRIMARY KEY,
    Item_Type_Name VARCHAR(40),
    Description VARCHAR(300)
);

-- =====================================================
-- TABLE 5: PATRON_ROLE
-- Purpose: User access level definitions
-- =====================================================
CREATE TABLE IF NOT EXISTS PATRON_ROLE (
    Patron_Role_ID INT NOT NULL PRIMARY KEY,
    Role_Name ENUM('Student','Faculty','Researcher','Curator'),
    Description VARCHAR(300)
);

-- =====================================================
-- TABLE 6: MOVEMENT_TYPE
-- Purpose: Box shipment/transfer classifications
-- =====================================================
CREATE TABLE IF NOT EXISTS MOVEMENT_TYPE (
    Movement_Type_ID INT NOT NULL PRIMARY KEY,
    Movement_Type_Name VARCHAR(40),
    Description VARCHAR(300)
);

-- =====================================================
-- TABLE 7: INSTITUTION_TYPE
-- Purpose: External organization categories
-- =====================================================
CREATE TABLE IF NOT EXISTS INSTITUTION_TYPE (
    Institution_Type_ID INT NOT NULL PRIMARY KEY,
    Ins_Type_Name VARCHAR(40),
    Description VARCHAR(300)
);

-- =====================================================
-- TABLE 8: CONDITION_TYPE
-- Purpose: Item preservation states with handling guidance
-- =====================================================
CREATE TABLE IF NOT EXISTS CONDITION_TYPE (
    Condition_ID INT NOT NULL PRIMARY KEY,
    Condition_Name VARCHAR(50),
    Handling_Guidance VARCHAR(100),
    Description VARCHAR(300),
    Checking_Date DATE
);

-- =====================================================
-- TABLE 9: LOCATION
-- Purpose: Physical storage locations (building/room/shelf)
-- =====================================================
CREATE TABLE IF NOT EXISTS LOCATION (
    Location_ID INT NOT NULL PRIMARY KEY,
    Building VARCHAR(40),
    Room VARCHAR(40),
    Section INT,
    Shelf VARCHAR(5),
    Shelf_Row INT
);
