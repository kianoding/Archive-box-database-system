---
layout: default
title: Query Documentation
nav_order: 2
has_children: true
---

# 💬 Query Documentation

This document showcases SQL query development for the Archive Box Management Database, demonstrating progression from basic CRUD operations to complex transaction management and automated workflows.

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
| Q7 | Check available items | Librarian | VIEW creation, nested SUBQUERIES (3 levels) | ⭐⭐⭐⭐ | Advanced |
| Q8 | Patron checkout transaction | Librarian | TRANSACTION (ACID), multi-step workflow | ⭐⭐⭐⭐⭐ | Advanced |

---
## 📋 Foundation Operations (Queries 1-3)
This is a list of less complex queries for the day-to-day report:
- Recording the temperature and humidity in the archive room
- Registering a new patron to the system
- Deleting the older record of the archive temperature log


---
## 📋 Applied Operations (Queries 4-5)
This is a list of queries with mid-level complexity for the daily operation report:
- Updating the record for pick-up ready boxes
- Preparing the report for the outbound shipping report


---
## 📋 Advanced Workflows (Queries 6-8)
This is a list of production-ready queries demonstrating complex SQL techniques for automated workflows, nested logic, and transaction management:


## Summary
This query collection demonstrates:

| Skill Level | Technical Capabilities Demonstrated | Queries |
|-------------|-------------------------------------|---------|
| **Foundation Skills** | • INSERT/DELETE operations with data validation<br>• Foreign key constraint handling<br>• SELECT verification patterns<br>• Single-table CRUD proficiency | [Query 01: Foundational Operation](../query/query_01_foundational_operation.md) |
| **Applied Skills** | • Multi-table JOIN optimization (4+ tables)<br>• UPDATE with referential integrity<br>• Complex SELECT with FK relationships<br>• Data consistency across related entities | [Query 02: Applied Operation](../query/query_02_applied_operational.md) |
| **Advanced Skills** | • Stored procedure design (TRIGGER automation)<br>• 3-level nested subquery logic<br>• ACID transaction implementation<br>• VIEW creation for query optimization<br>• Cascading update patterns<br>• Error handling and rollback capability | [Query 06: Item Return Processing](../query/query_6_item_return_processing.md)<br>[Query 07: Available Items Check](../query/query_7_available_items_check.md)<br>[Query 08: Checkout Transaction](../query/query_8_checkout_transaction.md) |


**Next Steps:** [View Complete SQL Files](../query) | [Return to Main README](/README.md)
