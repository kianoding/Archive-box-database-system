## 📋 Applied Operations (Queries 4-5)

### Query 04: Update Box Location for Shipment

**Scenario:** Archivist James prepares BOX008 (Middle Eastern textiles) for museum pickup, moving it to Outgoing Staging Room

**Business Need:** Track box movements and update availability status before external shipping

**Data State Changes:**
- Location: Archive Room 205 → Outgoing Staging Room
- Status: Available → Unavailable
- Staff: Updated by James (Staff ID 6)
```sql
-- Check current state
SELECT * FROM STAFF;
SELECT * FROM LOCATION;
SELECT * FROM BOX_STATUS;
SELECT * FROM BOX;

-- James [6], the Archivist, prepares BOX008 for museum pickup
-- Moving to Outgoing Staging Room [8] and changing status to unavailable [3]
UPDATE BOX
SET Staff_id = 6,
    Location_ID = 8,
    Status_ID = 3,
    Last_Modified_Date = CURRENT_DATE
WHERE Box_ID = 'BOX008';

-- Verify update with multi-table JOIN
SELECT 
    b.Box_ID,
    b.Last_Modified_Date,
    bs.Status_Name,
    l.Room AS Current_Location,
    CONCAT(s.staff_fname, ' ', s.staff_lname) AS Updated_By
FROM BOX b
    JOIN BOX_STATUS bs ON b.Status_ID = bs.Status_ID
    JOIN LOCATION l ON b.Location_ID = l.Location_ID
    JOIN STAFF s ON b.Staff_id = s.staff_id
WHERE b.Box_ID = 'BOX008';
```

**Technical Notes:**
- Uses `CURRENT_DATE` for timestamp automation
- Verification query demonstrates 4-table JOIN
- Tracks accountability through Staff_id updates

---

### Query 05: Record Box Shipment to External Institution

**Scenario:** James creates shipping record for BOX008 (Middle Eastern textile roll box) going to Smithsonian for exhibition

**Business Need:** Track external loans with movement type, destination, and return expectations

**Workflow Steps:**
1. Verify movement type (Exhibition)
2. Confirm box details by cultural classification
3. Verify external institution (Smithsonian)
4. Create shipping record with return due date
```sql
-- Check movement type: Exhibition [2]
SELECT * FROM MOVEMENT_TYPE;

-- Verify the Middle Eastern textile box [BOX008]
SELECT
    cc.Classification_Name,
    b.Box_ID,
    bst.Size_Name
FROM BOX b
    JOIN CULTURAL_CLASS cc ON b.Classification_ID = cc.Classification_ID
    JOIN BOX_SIZE_TYPE bst ON b.Box_Size_ID = bst.Box_Size_ID
WHERE cc.Classification_Name LIKE 'Middle%';

-- Verify Smithsonian [3]
SELECT * FROM EXTERNAL_LOCATION;

-- Create shipping record
INSERT INTO SHIPPING_RECORD 
(Shipping_Record_ID, Movement_Date, Return_Due_Date, Actual_Return_Date, 
 Box_ID, Movement_Type_ID, From_Location_ID, To_Location_ID, Staff_id)
VALUES 
(6, '2024-12-13', '2025-03-13', NULL, 'BOX008', 2, 2, 3, 6);
```

**Technical Notes:**
- Uses `NULL` for Actual_Return_Date (not yet returned)
- 3-month loan period tracked
- Links internal (From_Location_ID) and external (To_Location_ID) locations
