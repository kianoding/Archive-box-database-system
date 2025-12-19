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

D
