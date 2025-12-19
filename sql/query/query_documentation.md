---
layout: default
title: Query Documentation
nav_order: 4
---

# 💬 Query Documentation

This document showcases SQL query development for the Archive Box Management Database, demonstrating progression from basic CRUD operations to complex transaction management and automated workflows.

**Related:** [📖 Data Dictionary](../sql/schema/data-dictionary.md) | [View Schema](../sql/schema/)

---

## 💬 Query Overview

| Query | Business Scenario | Stakeholder | SQL Techniques | Complexity | Level | 
|-------|-------------------|-------------|----------------|------------|------------|
| Q1 | Record environmental readings | Archivist | INSERT, SELECT verification | ⭐ | 1️⃣ Foundation |
| Q2 | Register new patron | Librarian | INSERT, SELECT verification | ⭐ | 1️⃣ Foundation |
| Q3 | Remove duplicate records | Administrator | DELETE, data cleanup | ⭐ | 1️⃣ Foundation |
| Q4 | Update box for shipment | Archivist | UPDATE with JOINs, multi-table verification | ⭐⭐ | 2️⃣ Applied Operations |
| Q5 | Track external shipment | Archivist | INSERT with FK relationships, complex SELECT | ⭐⭐ | 2️⃣ Applied Operations |
| Q6 | Process item return | Librarian | TRIGGER, cascading updates, automated workflow | ⭐⭐⭐ | Advanced |
| Q7 | Check available items | Patron/Librarian | VIEW creation, nested SUBQUERIES (3 levels) | ⭐⭐⭐⭐ | Advanced |
| Q8 | Patron checkout transaction | Librarian | TRANSACTION (ACID), multi-step workflow | ⭐⭐⭐⭐⭐ | Advanced |

---

## 1️⃣ Foundation Operations (Queries 1-3)
This is a list of less complex queries for the day-to-day report:
- Recording the temperature and humidity in the archive room
- Registering a new patron to the system
- Deleting the older record of the archive temperature log

→ [query_01_foundational_operation](../query/query_01_foundational_operation.md)

---



## 2️⃣ Applied Operations (Queries 4-5)
This is a list of queries with mid-level complexity for the daily operation report:
- Updating the record for pick-up ready boxes
- Preparing the report for outbound shipping report

→ [query_02_applied_operation](../query/query_01_foundational_operation.md)

---

## Advanced Workflows (Queries 6-8)

### Query 6: Automated Item Return Processing

**Scenario:** Patron Amanda returns ITEM011 to Librarian Lisa, triggering automated status updates across items and boxes

**Business Need:** Ensure consistent status updates when items return to archive, reduce manual errors

**Automation Logic:**
- ✅ When Return_DateTime is recorded → Trigger fires
- ✅ Item status: "Unavailable--Checked out" → "Available"
- ✅ Box status: Updates to "Available" when all items are returned
- ✅ Box location: Returns to archive storage automatically

#### Workflow Diagram
```
┌─────────────┐         ┌──────────────┐         ┌─────────────┐
│   Patron    │         │  Librarian   │         │   System    │
└──────┬──────┘         └──────┬───────┘         └──────┬──────┘
       │                       │                        │
       │  Returns Item         │                        │
       │──────────────────────>│                        │
       │                       │                        │
       │                       │ Records Return         │
       │                       │ (UPDATE Return_DateTime)│
       │                       │───────────────────────>│
       │                       │                        │
       │                       │              ┌─────────▼────────┐
       │                       │              │ TRIGGER FIRES    │
       │                       │              │ auto_process_    │
       │                       │              │ item_return      │
       │                       │              └─────────┬────────┘
       │                       │                        │
       │                       │              ┌─────────▼────────┐
       │                       │              │ Update Item      │
       │                       │              │ Status:Available │
       │                       │              └─────────┬────────┘
       │                       │                        │
       │                       │              ┌─────────▼────────┐
       │                       │              │ Update Box       │
       │                       │              │ Status: Available│
       │                       │              │ Location: Archive│
       │                       │              └─────────┬────────┘
       │                       │                        │
       │                       │<───────────────────────│
       │                       │  Confirmation          │
       │<──────────────────────│                        │
       │  Item Available       │                        │
```

#### Implementation

**Step 1: Check Checkout Details**
```sql
-- Amanda finished examining ITEM011. Lisa needs to update records.
SELECT 
    p.patron_Fname,
    s.staff_Fname,
    s.staff_ID,
    cr.Item_ID,
    cr.Box_ID,
    cr.Checkout_ID 
FROM CHECKOUT_RECORD cr
JOIN PATRON p ON CR.Patron_ID = p.Patron_ID
JOIN STAFF s ON CR.Staff_id = s.staff_id
WHERE cr.Item_ID = 'ITEM011';
```

**Step 2: Create Automated Trigger**
```sql
DELIMITER //
CREATE TRIGGER auto_process_item_return
AFTER UPDATE ON CHECKOUT_RECORD
FOR EACH ROW
BEGIN
    -- Trigger when Return_DateTime changes from NULL to a value
    IF OLD.Return_DateTime IS NULL AND NEW.Return_DateTime IS NOT NULL THEN
        -- Update item status back to Available
        UPDATE ITEM_STATUS_NAME isn
        JOIN ITEM i ON isn.Item_ID = i.Item_ID
        SET isn.Item_Status_Name = 'Available',
            isn.Description = 'Item returned and available in archive storage',
            isn.Staff_id = NEW.Staff_id
        WHERE i.Item_ID = NEW.Item_ID;
        
        -- Return box to archive storage
        UPDATE BOX
        SET Status_ID = 1,  -- Available
            Location_ID = 3  -- Archive Room 205 Section 2
        WHERE Box_ID = NEW.Box_ID;
    END IF;
END//
DELIMITER ;
```

**Step 3: Execute Return (Trigger Fires Automatically)**
```sql
-- Update return time - trigger handles the rest
UPDATE CHECKOUT_RECORD
SET Return_DateTime = '2024-12-13 16:00:00'
WHERE Checkout_ID = 'CHK003';
```

**Step 4: Verify Cascading Updates**
```sql
SELECT 
    cr.Checkout_ID,
    cr.Return_DateTime,
    isn.Item_Status_Name,
    bs.Status_Name AS Box_Status,
    l.Room AS Box_Location
FROM CHECKOUT_RECORD cr
JOIN ITEM i ON cr.Item_ID = i.Item_ID
JOIN ITEM_STATUS_NAME isn ON i.Item_ID = isn.Item_ID
JOIN BOX b ON cr.Box_ID = b.Box_ID
JOIN BOX_STATUS bs ON b.Status_ID = bs.Status_ID
JOIN LOCATION l ON b.Location_ID = l.Location_ID
WHERE cr.Checkout_ID = 'CHK003';
```

**Technical Highlights:**
- ✅ AFTER UPDATE trigger with conditional logic
- ✅ OLD vs NEW row comparison
- ✅ Cascading updates across 3 tables
- ✅ Maintains data consistency automatically

---

### Query 7: Check Available Items for Patron Checkout

**Scenario:** Librarian Emily creates a filtered view of items safe for patron checkout, excluding items requiring conservation

**Business Need:** Prevent checkout of fragile items, provide patrons with pre-filtered available inventory

**Complexity:** 3-level nested subqueries to filter by condition, status, and location

#### Query Logic Flow
```
┌─────────────────────────────────────────────┐
│  Start: Emily needs available item list     │
└──────────────────┬──────────────────────────┘
                   │
         ┌─────────▼──────────┐
         │  Check Current     │
         │  Item Conditions   │
         └─────────┬──────────┘
                   │
         ┌─────────▼──────────┐
         │  JOIN 7 Tables:    │
         │  - ITEM            │
         │  - ITEM_TYPE       │
         │  - BOX             │
         │  - CULTURAL_CLASS  │
         │  - CONDITION_TYPE  │
         │  - ITEM_STATUS     │
         │  - LOCATION        │
         └─────────┬──────────┘
                   │
         ┌─────────▼──────────┐
         │  Filter 1:         │
         │  Item Status =     │
         │  'Available'       │
         └─────────┬──────────┘
                   │
         ┌─────────▼──────────┐
         │  Filter 2:         │
         │  Box Status =      │
         │  Available (ID=1)  │
         └─────────┬──────────┘
                   │
         ┌─────────▼──────────┐
         │  Filter 3:         │
         │  NOT IN            │
         │  ┌───────────────┐ │
         │  │ Subquery 1:   │ │
         │  │ Items WHERE   │ │
         │  │ Condition =   │ │
         │  │ ┌───────────┐ │ │
         │  │ │Subquery 2:│ │ │
         │  │ │Get ID for │ │ │
         │  │ │"Requires  │ │ │
         │  │ │Conserv."  │ │ │
         │  │ └───────────┘ │ │
         │  └───────────────┘ │
         └─────────┬──────────┘
                   │
         ┌─────────▼──────────┐
         │  CREATE VIEW       │
         │  Available_Items_  │
         │  For_Checkout      │
         └─────────┬──────────┘
                   │
         ┌─────────▼──────────┐
         │  Return Results    │
         │  Sorted by Culture │
         └────────────────────┘
```

#### Implementation

**Step 1: Identify Staff**
```sql
SELECT *
FROM STAFF
WHERE staff_fname = 'Emily';
```

**Step 2: Analyze Current Conditions**
```sql
-- Check current item conditions distribution
SELECT
    ct.Condition_Name,
    COUNT(i.Item_ID) AS Item_Count
FROM ITEM i
JOIN CONDITION_TYPE ct ON i.Condition_ID = ct.Condition_ID
GROUP BY ct.Condition_Name;
```

**Step 3: Find Conservation-Required Items**
```sql
-- Finding items requiring conservation (will be excluded)
SELECT
    i.Item_ID,
    ct.Condition_Name
FROM ITEM i
JOIN CONDITION_TYPE ct ON i.Condition_ID = ct.Condition_ID
WHERE ct.Condition_Name = 'Requires Conservation';
```

**Step 4: Create Filtered View with Nested Subqueries**
```sql
-- Creating the view with 3-level filtering
CREATE VIEW Available_Items_For_Checkout AS
SELECT
    i.Item_ID,
    it.Item_Type_Name,
    b.Box_ID,
    cc.Classification_Name,
    ct.Condition_Name,
    ct.Handling_Guidance,
    l.Room AS Box_Location
FROM ITEM i
JOIN ITEM_TYPE it ON i.Item_Type_ID = it.Item_Type_ID
JOIN BOX b ON i.Box_ID = b.Box_ID
JOIN CULTURAL_CLASS cc ON b.Classification_ID = cc.Classification_ID
JOIN CONDITION_TYPE ct ON i.Condition_ID = ct.Condition_ID
JOIN ITEM_STATUS_NAME isn ON i.Item_ID = isn.Item_ID
JOIN LOCATION l ON b.Location_ID = l.Location_ID
JOIN BOX_STATUS bs ON b.Status_ID = bs.Status_ID
WHERE isn.Item_Status_Name = 'Available'
  AND b.Status_ID = 1
  AND i.Item_ID NOT IN (  -- SUBQUERY LEVEL 1
      SELECT Item_ID FROM ITEM
      WHERE Condition_ID = (  -- SUBQUERY LEVEL 2
          SELECT Condition_ID FROM CONDITION_TYPE
          WHERE Condition_Name = 'Requires Conservation'
      )
  );
```

**Step 5: Query View for Patrons**
```sql
-- View output for patron to check
SELECT * FROM Available_Items_For_Checkout
ORDER BY Classification_Name;
```

**Technical Highlights:**
- ✅ 7-table JOIN for comprehensive item details
- ✅ Nested subqueries (3 levels deep) for condition filtering
- ✅ VIEW creation for recurring query optimization
- ✅ Combines positive filters (Available) with negative filters (NOT IN conservation)

---

### Query 8: Patron Checkout Transaction

**Scenario:** Graduate student David checks out ITEM007 (Japanese kimono) for costume design research. Librarian Emily processes the checkout as a single atomic transaction.

**Business Need:** Ensure all checkout steps succeed together or roll back entirely to prevent data inconsistency

**ACID Transaction Components:**
- **Atomicity:** All 3 steps succeed or none do
- **Consistency:** Maintains referential integrity across tables
- **Isolation:** Prevents concurrent checkout conflicts
- **Durability:** Changes persist after COMMIT

#### Transaction Workflow
```
┌─────────────┐         ┌──────────────┐         ┌─────────────┐
│   Patron    │         │  Librarian   │         │  Database   │
│   (David)   │         │   (Emily)    │         │             │
└──────┬──────┘         └──────┬───────┘         └──────┬──────┘
       │                       │                        │
       │  Requests ITEM007     │                        │
       │──────────────────────>│                        │
       │  (Kimono research)    │                        │
       │                       │                        │
       │                       │ Verify Patron          │
       │                       │───────────────────────>│
       │                       │<───────────────────────│
       │                       │ (David = ID 4)         │
       │                       │                        │
       │                       │ Check Item Status      │
       │                       │───────────────────────>│
       │                       │<───────────────────────│
       │                       │ (Available, BOX004)    │
       │                       │                        │
       │                       │ START TRANSACTION;     │
       │                       │───────────────────────>│
       │                       │                   ┌────▼────┐
       │                       │                   │ LOCKED  │
       │                       │                   └────┬────┘
       │                       │                        │
       │                       │ Step 1: Move Box       │
       │                       │ BOX004 → Study Room    │
       │                       │───────────────────────>│
       │                       │                   ✅ Success
       │                       │                        │
       │                       │ Step 2: Update Item    │
       │                       │ Status → Checked Out   │
       │                       │───────────────────────>│
       │                       │                   ✅ Success
       │                       │                        │
       │                       │ Step 3: Create Record  │
       │                       │ CHK006 entry           │
       │                       │───────────────────────>│
       │                       │                   ✅ Success
       │                       │                        │
       │                       │ COMMIT;                │
       │                       │───────────────────────>│
       │                       │                   ┌────▼────┐
       │                       │                   │ UNLOCK  │
       │                       │                   │ Changes │
       │                       │                   │ Saved   │
       │                       │                   └────┬────┘
       │                       │<───────────────────────│
       │                       │  Confirmation          │
       │<──────────────────────│                        │
       │  Item Ready           │                        │
       │  Study Room 208       │                        │
```

#### Implementation

**Step 1: Verify Patron**
```sql
-- Checking David as Patron
SELECT Patron_ID, Patron_FName, Patron_LName, Department
FROM PATRON
WHERE Patron_Fname = 'David';
```

**Step 2: Check Item and Box Details**
```sql
-- Check item and patron details
SELECT
    i.Item_ID,
    isn.Item_Status_Name,
    b.Box_ID,
    l.Room
FROM ITEM i
JOIN BOX b ON i.Box_ID = b.Box_ID
JOIN LOCATION l ON b.Location_ID = l.Location_ID
JOIN ITEM_STATUS_NAME isn ON i.Item_ID = isn.Item_ID
WHERE i.Item_ID = 'ITEM007';
```

**Step 3: Verify Study Room Location**
```sql
-- Checking the location ID for Study Room
SELECT Location_ID, Room
FROM LOCATION;
```

**Step 4: Execute Transaction (All-or-Nothing)**
```sql
-- Ensure checkout is atomic - all steps succeed or none do
START TRANSACTION;

-- STEP 1: Move box to study room
UPDATE BOX
SET Location_ID = 6,  -- Study Room 208
    Status_ID = 2,  -- Unavailable--Checked out
    Last_Modified_Date = CURRENT_DATE
WHERE Box_ID = 'BOX004';

-- STEP 2: Update item status
SELECT *
FROM STAFF
WHERE staff_fname = 'Emily';

UPDATE ITEM_STATUS_NAME
SET Item_Status_Name = 'Unavailable--Checked out',
    Description = 'Item checked out to patron',
    Staff_id = 3  -- Emily
WHERE Item_ID = 'ITEM007';

-- STEP 3: Create checkout record
INSERT INTO CHECKOUT_RECORD
(Checkout_ID, Checkout_DateTime, Return_DateTime, Purpose, Staff_id, Box_ID, Item_ID, Patron_ID)
VALUES
('CHK006', '2024-12-13 10:30:00', NULL, 'Costume design reference', 3, 'BOX004', 'ITEM007', 4);

-- All steps succeeded - make changes permanent
COMMIT;
```

**Step 5: Verify Complete Transaction**
```sql
-- Check checkout record created
SELECT * FROM CHECKOUT_RECORD;

-- Verify all related updates with comprehensive JOIN
SELECT
    cr.Checkout_ID,
    CONCAT(p.Patron_FName, ' ', p.Patron_LName) AS Patron,
    i.Item_ID,
    l.Room AS Box_Location
FROM CHECKOUT_RECORD cr
JOIN PATRON p ON cr.Patron_ID = p.Patron_ID
JOIN ITEM i ON cr.Item_ID = i.Item_ID
JOIN BOX b ON cr.Box_ID = b.Box_ID
JOIN LOCATION l ON b.Location_ID = l.Location_ID
WHERE cr.Checkout_ID = 'CHK006';
```

**Technical Highlights:**
- ✅ Transaction ensures atomicity (all-or-nothing execution)
- ✅ Updates span 3 tables (BOX, ITEM_STATUS_NAME, CHECKOUT_RECORD)
- ✅ Maintains referential integrity throughout
- ✅ NULL for Return_DateTime indicates active checkout
- ✅ Rollback capability if any step fails

**Transaction Safety:**
```sql
-- If any step fails, rollback example:
START TRANSACTION;
-- ... steps ...
-- Error occurs
ROLLBACK;  -- Undoes all changes
```

---

## Summary

This query collection demonstrates:

**Foundation Skills:**
- Clean CRUD operations with verification steps
- Proper foreign key relationship handling
- Data integrity maintenance

**Applied Skills:**
- Multi-table JOINs for complex data retrieval
- Real-world workflow implementation
- Status tracking across related entities

**Advanced Skills:**
- Trigger-based automation for consistency
- Nested subqueries for complex filtering
- ACID transaction management
- View optimization for recurring queries

**Production-Ready Practices:**
- Verification queries before and after operations
- Clear commenting and stakeholder context
- Atomic operations for data integrity
- Automated workflows to reduce human error

---

**Next Steps:** [View Complete SQL Files](sql/) | [Return to Main README](README.md)
