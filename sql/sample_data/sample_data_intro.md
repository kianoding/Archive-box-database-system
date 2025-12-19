# Sample Data

This directory contains INSERT statements to populate the Archive Box Management Database with realistic test data.

## Purpose

The sample data demonstrates:
- Realistic archive operations across multiple storage locations
- Typical patron checkout workflows
- Environmental monitoring scenarios
- Cultural classification diversity
- Various item condition states

## Data Characteristics

**Scale:**
- 9 foundation tables with reference data
- 5 dependent tables with operational records
- 5 core transaction tables

**Represents:**
- Small-to-medium university archive collection
- Multiple storage rooms with capacity constraints
- Active patron borrowing activity
- Diverse cultural origins (East Asian, European, Indigenous, etc.)
- Range of textile types and preservation conditions

## Usage

Execute scripts in order:
1. `tier1_sample_data.sql` - Foundation/lookup tables first
2. `tier2_sample_data.sql` - Dependent tables second  
3. `tier3_sample_data.sql` - Operational/transaction tables last

**Note:** Requires schema tables to be created first (see `/sql/schema/`)

## Data Integrity

All sample data:
- ✅ Respects foreign key constraints
- ✅ Uses realistic values for archive operations
- ✅ Demonstrates proper referential relationships
- ✅ Includes edge cases (same-day returns, capacity limits, environmental alerts)

---

*Sample data is for demonstration and testing purposes only. Not based on real collections or individuals.*
