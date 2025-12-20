## 📋 Advanced Workflows (Queries 8)

### Query 8: Patron Checkout Transaction

**Scenario:** Graduate student David checks out ITEM007 (Japanese kimono) for costume design research. Librarian Emily processes the checkout as a single atomic transaction.

**Business Need:** Ensure all checkout steps succeed together or roll back entirely to prevent data inconsistency

#### Transaction Workflow
![workflow mapping for query 08](/docs/images/workflow-map-query-08.png)

**ACID Transaction Components:**
- **Atomicity:** All three steps succeed or none do
- **Consistency:** Maintains referential integrity across tables
- **Isolation:** Prevents concurrent checkout conflicts
- **Durability:** Changes persist after COMMIT

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


**Transaction Safety:**
```sql
-- If any step fails, rollback example:
START TRANSACTION;
-- ... steps ...
-- Error occurs
ROLLBACK;  -- Undoes all changes
```

---
