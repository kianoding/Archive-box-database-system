### Query 1: Record Environmental Temperature

**Scenario:** Archivist records afternoon temperature and humidity reading in Archive Room 201

**Business Need:** Preserve textiles through environmental monitoring and compliance tracking
```sql
-- Record the temperature in the archive room
INSERT INTO TEMP_RECORD 
(Record_ID, Reading_DateTime, Temperature, Humidity, Description, Report, Location_ID, Staff_id)
VALUES 
(9, '2025-12-13 14:00:00', 21.3, 46.5, 'Normal afternoon reading', 0, 1, 1);

-- Verification
SELECT * FROM TEMP_RECORD;
```

**Key Learning:** Basic INSERT with timestamp handling and foreign key relationships

---

### Query 2: Register New Patron

**Scenario:** Museum Studies graduate student Catherine Liu requests archive access

**Business Need:** Track authorized users for security and usage statistics
```sql
-- Adding new patron to our record
INSERT INTO PATRON
(Patron_ID, Patron_FName, Patron_LName, Department, Contact_Email, Patron_Role_ID)
VALUES 
(7, 'Catherine', 'Liu', 'Museum Studies', 'c.liu@university.edu', 2);

-- Verification
SELECT * FROM PATRON;
```

**Key Learning:** Patron role classification through foreign key to PATRON_ROLE lookup table

---

### Query 3: Delete Duplicate Temperature Record

**Scenario:** Administrator identifies and removes duplicate environmental reading

**Business Need:** Maintain data integrity and accurate reporting
```sql
-- Check existing records
SELECT * FROM TEMP_RECORD;

-- Delete the duplicated record
DELETE FROM TEMP_RECORD
WHERE Record_ID = 8;
```

**Key Learning:** Verification before deletion, data cleanup operations


