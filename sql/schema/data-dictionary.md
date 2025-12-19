## 📖 Data Dictionary
This document provides detailed metadata specifications for the Archive Box Management Database foundation tables (Tier 1). Each entry follows library and information science metadata standards, documenting attributes, data types, constraints, and contextual examples.

## Purpose

The data dictionary serves as the authoritative reference for:
- **Database administrators** implementing the schema
- **Developers** querying the database
- **Archivists and librarians** understanding data structure
- **Stakeholders** reviewing system capabilities

[📁 Sample Data Intro](sql/sample_data/sample_data_intro.md) to see realistic examples of these tables in use.

---
TIER 1: PARENT ENTITY
### `STAFF`
**Purpose:** Archive personnel managing collection operations

| Attribute | Data Type | Description | Example Values |
|-----------|-----------|-------------|----------------|
| staff_id | INT | Unique staff identifier | 1, 2, 3 |
| staff_fname | VARCHAR(50) | Staff member's first name | 'Jennifer', 'Mark' |
| staff_lname | VARCHAR(50) | Staff member's last name | 'Smith', 'Rodriguez' |
| staff_role | ENUM | Job function classification | 'Archivist', 'Collection Manager', 'Archive Librarian', 'Admin' |

---

### `BOX_SIZE_TYPE`
**Purpose:** Standardized physical dimensions for archive storage boxes

| Attribute | Data Type | Description | Example Values |
|-----------|-----------|-------------|----------------|
| Box_Size_ID | INT | Unique size type identifier | 1, 2, 3 |
| Size_Name | VARCHAR(40) | Descriptive size label | 'Small', 'Medium', 'Large' |
| Width | DECIMAL(6,2) | Box width in inches | 12.50, 18.00 |
| Depth | DECIMAL(6,2) | Box depth in inches | 10.00, 15.50 |
| Height | DECIMAL(6,2) | Box height in inches | 4.00, 6.25 |
| Description | VARCHAR(300) | Usage notes and specifications | 'Standard archival box for small textiles' |

---

### `CULTURAL_CLASS`
**Purpose:** Cultural and geographic origin classifications for collection items

| Attribute | Data Type | Description | Example Values |
|-----------|-----------|-------------|----------------|
| Classification_ID | INT | Unique classification identifier | 1, 2, 3 |
| Classification_Name | VARCHAR(40) | Cultural origin label | 'East Asian', 'West African', 'European' |
| Description | VARCHAR(300) | Geographic and cultural context | 'Garments from Japan, China, Korea' |

---

### `ITEM_TYPE`
**Purpose:** Garment and textile category classifications

| Attribute | Data Type | Description | Example Values |
|-----------|-----------|-------------|----------------|
| Item_Type_ID | INT | Unique type identifier | 1, 2, 3 |
| Item_Type_Name | VARCHAR(40) | Garment category | 'Kimono', 'Shawl', 'Ceremonial Dress' |
| Description | VARCHAR(300) | Type characteristics and usage | 'Traditional Japanese outer garment' |

---

### `PATRON_ROLE`
**Purpose:** User access levels and permissions

| Attribute | Data Type | Description | Example Values |
|-----------|-----------|-------------|----------------|
| Patron_Role_ID | INT | Unique role identifier | 1, 2, 3 |
| Role_Name | ENUM | Access level category | 'Student', 'Faculty', 'Researcher', 'Curator' |
| Description | VARCHAR(300) | Role permissions and restrictions | 'Graduate students conducting research' |

---

### `MOVEMENT_TYPE`
**Purpose:** Box shipment and transfer classifications

| Attribute | Data Type | Description | Example Values |
|-----------|-----------|-------------|----------------|
| Movement_Type_ID | INT | Unique movement type identifier | 1, 2, 3 |
| Movement_Type_Name | VARCHAR(40) | Transfer category | 'Loan', 'Exhibition', 'Conservation' |
| Description | VARCHAR(300) | Movement purpose and protocols | 'Temporary loan to external institution' |

---

### `INSTITUTION_TYPE`
**Purpose:** External organization classifications

| Attribute | Data Type | Description | Example Values |
|-----------|-----------|-------------|----------------|
| Institution_Type_ID | INT | Unique institution type identifier | 1, 2, 3 |
| Ins_Type_Name | VARCHAR(40) | Organization category | 'Museum', 'Research Library', 'University' |
| Description | VARCHAR(300) | Institution characteristics | 'Public museums with exhibition spaces' |

---

### `CONDITION_TYPE`
**Purpose:** Item preservation states with handling requirements

| Attribute | Data Type | Description | Example Values |
|-----------|-----------|-------------|----------------|
| Condition_ID | INT | Unique condition identifier | 1, 2, 3 |
| Condition_Name | VARCHAR(50) | Preservation state label | 'Excellent', 'Good', 'Fair', 'Poor' |
| Handling_Guidance | VARCHAR(100) | Care instructions for staff | 'Requires gloves and minimal handling' |
| Description | VARCHAR(300) | Detailed condition assessment | 'Minor fading, structurally sound' |
| Checking_Date | DATE | Last condition assessment date | '2024-03-15', '2024-06-20' |

---

### `LOCATION`
**Purpose:** Physical storage locations within the archive

| Attribute | Data Type | Description | Example Values |
|-----------|-----------|-------------|----------------|
| Location_ID | INT | Unique location identifier | 101, 102, 103 |
| Building | VARCHAR(40) | Building name or number | 'Main Archive Building', 'Annex A' |
| Room | VARCHAR(40) | Room designation | 'Storage Room 201', 'Climate Room B' |
| Section | INT | Room section number | 1, 2, 3 |
| Shelf | VARCHAR(5) | Shelf identifier | 'A', 'B1', 'C2' |
| Shelf_Row | INT | Row position on shelf | 1, 2, 3 |
