# Archive-box-database-system

### Archive Box Management Database: Garment and Textile
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
