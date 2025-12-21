# Archive-box-database-system 📦👘🔍

## 📖 Overview

### Archive Box Management Database: Garment and Textile
This project showcases a complete relational database design for managing a university's garment and textile archive collection. The system handles archive operations, including storage tracking, patron checkouts, environmental monitoring, and item preservation across multiple storage rooms.
The project demonstrates:

- **Conceptual design**: ERD modeling with 19 normalized tables (up to 3NF)
- **Implementation**: MySQL database with triggers for automated workflows and data integrity
- **Query development**: Complex queries addressing real archivists, librarians, and administrators' needs

Built using systematic database design principles from concept to working implementation, this project reflects graduate-level coursework in database systems.


## 🔑 Key Features

* **Multi-Room Storage Management**: Tracks archive boxes and items across physical locations with capacity monitoring
* **Environmental Monitoring**: Automated alerts for temperature/humidity violations to protect textile preservation
* **Patron Checkout System**: Complete workflow tracking from checkout to return with automated status updates
* **Cascading Status Logic**: Triggers automatically update item and box statuses based on operational events
* **Cultural Classification**: Organizes garments by cultural origin, time period, and textile type
* **Condition Tracking**: Documents preservation states and conservation needs for individual items

## 📋 Schema Overview

This database serves four primary user groups within the university archive:

| Stakeholder | Primary Responsibilities | Key Database Interactions |
|-------------|-------------------------|---------------------------|
| **Archivists** | Collection management, item processing, box organization | Catalog items, assign boxes, update locations, monitor conditions |
| **Librarians** | Patron services, checkout management, search assistance | Process patron requests, manage checkouts/returns, search collection |
| **Administrators** | Operations oversight, reporting, capacity planning | Generate reports, monitor space utilization, track shipments |
| **Conservators** | Preservation assessment, environmental monitoring, condition tracking | Record condition assessments, monitor environmental readings, flag preservation needs |

**Database Design Principle:** The three-tier structure ensures data integrity through dependency management while supporting diverse stakeholder workflows—from day-to-day patron checkouts to long-term preservation monitoring.

![ERD Map](/docs/images/ERD-archive-boxes.png)
*Image credit: Kelsey Kiantoro, 2025. ERD for Archive Box Database System.*

---
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

## 🗄️ Data Dictionary
Comprehensive metadata documentation for all foundation tables, including attribute definitions, data types, and example values.

**[→ View Complete Data Dictionary](/docs/data-dictionary.md)**

---

## 💬 Sample Queries

This project includes **15+ complex queries** demonstrating advanced SQL techniques:
- **Transaction Management**: Multi-step patron checkout with rollback handling
- **Nested Subqueries**: Multi-level filtering for available items
- **Trigger Integration**: Automated status cascading across related tables
- **View-Based Operations**: Complex joins for stakeholder-specific data access
- **Conditional Logic**: Environmental monitoring with alert thresholds

**📋 [View Complete Query Documentation →](sql/query/query_documentation.md)**

*Queries organized by stakeholder role: Archivist, Librarian, Administrator, Conservator*

## ⚙️ Technologies Used

- **Database**: MySQL 8.0
- **Database Management Tool**: DBeaver, Postgresql, LucidChart for ERD Draft
- **Design Methodology**: 
  - Entity-Relationship Modeling (Crow's Foot notation)
  - Normalization (3rd Normal Form)

## ⚠️ Project Scope & Limitations

### System Boundaries
This database manages **physical box storage and movement only**. The detailed garment and textile collection catalog (item-level metadata, provenance, conservation history) is maintained in a separate Collection Management System (CMS/TMS).

**This system handles:**
- Box location tracking and capacity management
- Patron checkout workflows
- External shipping logistics
- Environmental monitoring for storage areas

**Out of scope:**
- Detailed garment cataloging (fabric composition, measurements, maker attribution)
- Digital asset management (high-resolution images, 3D scans)
- Comprehensive provenance research
- Detailed conservation treatment records

**Known Limitations**
- **Sample data only**: Database contains representative test data, not production-scale records
- **Single-user context**: Designed for academic demonstration, not a multi-user production environment
- **Simplified workflows**: Some real-world archive processes are streamlined for clarity
- **No authentication layer**: User management handled externally (not in database scope)

## 📂 Repository Structure
```
archive-box-database-system/
│
├── docs/                                    # All project documentation and code
│   ├── data-dictionary.md                   # Metadata for Tier 1 foundation tables
│   ├── query_documentation.md               # Query overview and links to detailed pages
│   ├── sample_data_documentation.md         # Sample data explanation and usage
│   │
│   ├── images/                              # Visual documentation
│   │   ├── ERD-archive-boxes.png            # Entity-Relationship Diagram
│   │   ├── query6_workflow.png              # Q6: Item Return workflow
│   │   ├── query7_swimlane.png              # Q7: Available Items workflow
│   │   └── query8_workflow.png              # Q8: Checkout Transaction workflow
│   │
│   └── sql/                                 # Database implementation files
│       ├── schema/                          # Table creation scripts
│       │   ├── tier1_foundation_tables.sql  # 9 foundation tables (no dependencies)
│       │   ├── tier2_dependent_tables.sql   # 5 dependent tables (require Tier 1)
│       │   └── tier3_operational_tables.sql # 5 operational tables (require Tiers 1 & 2)
│       │
│       ├── sample_data/                     # Test data insert statements
│       │   ├── sample_data_tier1.sql        # Foundation table data
│       │   ├── sample_data_tier2.sql        # Dependent table data
│       │   └── sample_data_tier3.sql        # Operational table data
│       │
│       └── query/                           # Query demonstration files
│           ├── query_01_foundational_operation.md    # Queries 1-3: Basic CRUD
│           ├── query_02_applied_operational.md       # Queries 4-5: JOINs & workflows
│           ├── query_06_item_return_processing.md    # Q6: Trigger automation
│           ├── query_07_available_items_check.md     # Q7: Nested subqueries
│           └── query_08_checkout_transaction.md      # Q8: ACID transactions
│
├── index.md                                 # Project homepage (main entry point)
└── _config.yml                              # GitHub Pages configuration
```

This project is provided for educational and portfolio-review purposes only.

### Usage Restrictions
* This database system may NOT be used in any production environment without express written permission
* Commercial use requires explicit authorization from the author
* Academic study, review, and educational use are permitted
* Modifications for production deployment require author permission

For permission requests or inquiries, please get in touch with the author.

---

## 🌟 Author

**Kelsey Kiantoro**  
A graduate student in Library and Information Science with an interest in database systems and information architecture. I specialize in translating complex organizational needs into systematic database solutions, with a particular interest in archival systems, metadata standards, and data-driven collection management.

This project represents my work in mastering database design principles—from conceptual ERD modeling through production-ready MySQL implementation with automated workflows and triggers.


*Developed as the final project for INFO639: Database Design (Fall 2024)*

---

## 🙏 Acknowledgments

* **Course Instructor:** [Dr. Monica G. Maceli, Ph.D.](https://monicamaceli.com/)
* **Tools:** MySQL 8.0, DBeaver Community Edition
* **Methodologies:** E.F. Codd's relational model principles, systematic normalization approach
* **Design Inspiration:** Real-world university archive collection management workflows

Special thanks to Dr. Maceli for guidance on database design principles and normalization techniques, and for fostering a rigorous approach to systematic database development.
