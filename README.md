# Archive-box-database-system

### 📖 Archive Box Management Database: Garment and Textile Overview
This project showcases a complete relational database design for managing a university's garment and textile archive collection. The system handles archive operations, including storage tracking, patron checkouts, environmental monitoring, and item preservation across multiple storage rooms.
The project demonstrates:

- **Conceptual design**: ERD modeling with 19 normalized tables (up to 3NF)
- **Implementation**: MySQL database with triggers for automated workflows and data integrity
- **Query development**: Complex queries addressing real archivists, librarians, and administrators' needs

Built using systematic database design principles from concept to working implementation, this project reflects graduate-level coursework in database systems.


## Key Features

* **Multi-Room Storage Management**: Tracks archive boxes and items across physical locations with capacity monitoring
* **Environmental Monitoring**: Automated alerts for temperature/humidity violations to protect textile preservation
* **Patron Checkout System**: Complete workflow tracking from checkout to return with automated status updates
* **Cascading Status Logic**: Triggers automatically update item and box statuses based on operational events
* **Cultural Classification**: Organizes garments by cultural origin, time period, and textile type
* **Condition Tracking**: Documents preservation states and conservation needs for individual items

## 📋 Schema Overview

**TIER 1: FOUNDATION TABLES**

| Table Name | Description |
|------------|-------------|
| `STAFF` | Archive personnel with role assignments |
| `BOX_SIZE_TYPE` | Physical dimensions and specifications for archive boxes |
| `CULTURAL_CLASS` | Cultural/geographic origin classifications for items |
| `ITEM_TYPE` | Garment and textile type categories |
| `PATRON_ROLE` | User access level definitions |
| `MOVEMENT_TYPE` | Classification for box shipping/transfers |
| `INSTITUTION_TYPE` | External organization categories |
| `CONDITION_TYPE` | Item preservation state with handling guidance |
| `LOCATION` | Physical storage locations (building/room/shelf) |



**TIER 2: DEPENDENT TABLES**

**Dependencies:** Tier 1  
| Table Name | Description |
|------------|-------------|
| `BOX_STATUS` | Box availability states tracked by staff |
| `PATRON` | Registered archive users with roles |
| `EXTERNAL_LOCATION` | Off-site institutions for loans/exhibitions |
| `TEMP_RECORD` | Environmental monitoring (temperature/humidity) |
| `BOX_INVENTORY_RECORD` | Box capacity tracking by location |

**TIER 3: CORE OPERATIONAL TABLES**
**Dependencies:** Tiers 1 & 2  
| Table Name | Description |
|------------|-------------|
| `BOX` | Archive box records with location and status |
| `ITEM` | Individual garment/textile items |
| `ITEM_STATUS_NAME` | Item-level availability tracking |
| `CHECKOUT_RECORD` | Patron borrowing transactions |
| `SHIPPING_RECORD` | External shipment tracking with loan periods |

---



## Sample Queries

This project includes **15+ complex queries** demonstrating advanced SQL techniques:
- **Transaction Management**: Multi-step patron checkout with rollback handling
- **Nested Subqueries**: Multi-level filtering for available items
- **Trigger Integration**: Automated status cascading across related tables
- **View-Based Operations**: Complex joins for stakeholder-specific data access
- **Conditional Logic**: Environmental monitoring with alert thresholds

**📋 [View Complete Query Documentation →](link-to-queries-page.md)**

*Queries organized by stakeholder role: Archivist, Librarian, Administrator, Conservator*

## Technologies Used

- **Database**: MySQL 8.0
- **Database Management Tool**: DBeaver, Postgresql, LucidChart for ERD Draft
- **Design Methodology**: 
  - Entity-Relationship Modeling (Crow's Foot notation)
  - Normalization (3rd Normal Form)
