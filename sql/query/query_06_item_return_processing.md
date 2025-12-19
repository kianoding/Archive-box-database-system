---
## 📋 Advanced Workflows (Queries 6)

### Query 6: Automated Item Return Processing

**Scenario:** Patron Amanda returns ITEM011 to Librarian Lisa, triggering automated status updates across items and boxes

**Business Need:** Ensure consistent status updates when items return to the archive, reduce manual errors

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
