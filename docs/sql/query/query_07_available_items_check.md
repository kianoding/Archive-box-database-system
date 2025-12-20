---
layout: default
title: "Q7: Available Items Check"
parent: Query Documentation
nav_order: 4
---

## 📋 Advanced Workflows (Queries 7)

### Query 7: Check Available Items for Patron Checkout

**Scenario:** Librarian Emily creates a filtered view of items safe for patron checkout, excluding items requiring conservation

**Business Need:** Prevent checkout of fragile items, provide patrons with pre-filtered available inventory

#### Workflow Mapping

![workflow mapping for query 07]({{ '/docs/images/workflow-map-query-07.jpg' | relative_url }})

#### Implementation

**Step 1: Identify Staff**
```sql
SELECT *
FROM STAFF
WHERE staff_fname = 'Emily';
```

**Step 2: Analyze Current Conditions**
```sql
-- Check current item conditions distribution
SELECT
    ct.Condition_Name,
    COUNT(i.Item_ID) AS Item_Count
FROM ITEM i
JOIN CONDITION_TYPE ct ON i.Condition_ID = ct.Condition_ID
GROUP BY ct.Condition_Name;
```

**Step 3: Find Conservation-Required Items**
```sql
-- Finding items requiring conservation (will be excluded)
SELECT
    i.Item_ID,
    ct.Condition_Name
FROM ITEM i
JOIN CONDITION_TYPE ct ON i.Condition_ID = ct.Condition_ID
WHERE ct.Condition_Name = 'Requires Conservation';
```

**Step 4: Create Filtered View with Nested Subqueries**
```sql
-- Creating the view with 3-level filtering
CREATE VIEW Available_Items_For_Checkout AS
SELECT
    i.Item_ID,
    it.Item_Type_Name,
    b.Box_ID,
    cc.Classification_Name,
    ct.Condition_Name,
    ct.Handling_Guidance,
    l.Room AS Box_Location
FROM ITEM i
JOIN ITEM_TYPE it ON i.Item_Type_ID = it.Item_Type_ID
JOIN BOX b ON i.Box_ID = b.Box_ID
JOIN CULTURAL_CLASS cc ON b.Classification_ID = cc.Classification_ID
JOIN CONDITION_TYPE ct ON i.Condition_ID = ct.Condition_ID
JOIN ITEM_STATUS_NAME isn ON i.Item_ID = isn.Item_ID
JOIN LOCATION l ON b.Location_ID = l.Location_ID
JOIN BOX_STATUS bs ON b.Status_ID = bs.Status_ID
WHERE isn.Item_Status_Name = 'Available'
  AND b.Status_ID = 1
  AND i.Item_ID NOT IN (  -- SUBQUERY LEVEL 1
      SELECT Item_ID FROM ITEM
      WHERE Condition_ID = (  -- SUBQUERY LEVEL 2
          SELECT Condition_ID FROM CONDITION_TYPE
          WHERE Condition_Name = 'Requires Conservation'
      )
  );
```

**Step 5: Query View for Patrons**
```sql
-- View output for patron to check
SELECT * FROM Available_Items_For_Checkout
ORDER BY Classification_Name;
```

### Result

### Available Items For Checkout

| Item_ID | Item_Type_Name | Box_ID | Classification_Name | Condition_Name | Handling_Guidance | Box_Location |
|---------|----------------|--------|---------------------|----------------|-------------------|--------------|
| ITEM013 | Textiles/Decor | BOX007 | African | Fair | Handle with extra care, provide support | Archive Room 206 |
| ITEM014 | Costume | BOX007 | African | Fair | Handle with extra care, provide support | Archive Room 206 |
| ITEM019 | Costume | BOX010 | East Asian | Good | Standard handling with gloves | Archive Room 205 |
| ITEM020 | Accessories | BOX010 | East Asian | Fair | Handle with extra care, provide support | Archive Room 205 |
| ITEM011 | Costume | BOX006 | Latin American | Good | Standard handling with gloves | Archive Room 205 |
| ITEM012 | Costume | BOX006 | Latin American | Fair | Handle with extra care, provide support | Archive Room 205 |
| ITEM005 | Costume | BOX003 | South Asian | Good | Standard handling with gloves | Archive Room 205 |
| ITEM006 | Accessories | BOX003 | South Asian | Fair | Handle with extra care, provide support | Archive Room 205 |
| ITEM001 | Costume | BOX001 | Western European | Good | Standard handling with gloves | Archive Room 205 |
| ITEM002 | Accessories | BOX001 | Western European | Good | Standard handling with gloves | Archive Room 205 |

10 items available for patron checkout (excludes items requiring conservation)


**Technical Highlights:**
- ✅ 7-table JOIN for comprehensive item details
- ✅ Nested subqueries (3 levels deep) for condition filtering
- ✅ VIEW creation for recurring query optimization
- ✅ Combines positive filters (Available) with negative filters (NOT IN conservation)

