# Joins and Window Functions

Quick reference for the two most important SQL concepts in product analytics.

---

## Joins

### Join types at a glance

| Join type | Returns | Use when |
|-----------|---------|---------|
| `INNER JOIN` | Rows with matches in both tables | You only want users who did both things |
| `LEFT JOIN` | All rows from left, matched rows from right (NULL if no match) | Absence of a match is meaningful data |
| `RIGHT JOIN` | All rows from right; rarely used | Almost always rewrite as a LEFT JOIN |
| `FULL OUTER JOIN` | All rows from both, NULLs where no match | Comparing two populations that partially overlap |
| `CROSS JOIN` | Every row in A × every row in B | Generating combinations; almost never use on large tables |

### The most common mistake

Using `INNER JOIN` when you need `LEFT JOIN`.

```sql
-- WRONG: silently drops users who never made a purchase
SELECT u.user_id, COUNT(p.purchase_id) AS purchases
FROM users u
INNER JOIN purchases p ON u.user_id = p.user_id
GROUP BY 1;

-- CORRECT: users with no purchases get a count of 0
SELECT u.user_id, COUNT(p.purchase_id) AS purchases
FROM users u
LEFT JOIN purchases p ON u.user_id = p.user_id
GROUP BY 1;
```

### Checking cardinality before joining

Before joining, ask: how many rows per join key does each table have?

```sql
-- Check if user_id is unique in the users table
SELECT user_id, COUNT(*) AS cnt
FROM users
GROUP BY 1
HAVING COUNT(*) > 1;

-- Check fanout in events (many rows per user — expected)
SELECT user_id, COUNT(*) AS event_count
FROM events
GROUP BY 1
ORDER BY event_count DESC
LIMIT 10;
```

If the right table has multiple rows per join key, joining without prior aggregation will fan out the left table rows, silently doubling or tripling your counts.

### Filtering on a LEFT JOIN's right table

This is a very common bug:

```sql
-- BUG: WHERE on right table converts LEFT to INNER JOIN
SELECT u.user_id
FROM users u
LEFT JOIN events e ON u.user_id = e.user_id
WHERE e.event_name = 'purchase_completed';  -- drops users with no events

-- CORRECT: filter in the ON clause
SELECT u.user_id
FROM users u
LEFT JOIN events e
    ON u.user_id = e.user_id
   AND e.event_name = 'purchase_completed';  -- keeps users with no match
```

---

## Window Functions

Window functions compute a value for each row using a *window* of related rows, without collapsing the result set.

### Syntax

```sql
function_name() OVER (
    PARTITION BY col1, col2    -- group rows (like GROUP BY, but keeps all rows)
    ORDER BY col3              -- order within each partition
    ROWS/RANGE BETWEEN ...     -- define the window frame
)
```

### Essential window functions

| Function | What it does | Example use case |
|----------|-------------|-----------------|
| `ROW_NUMBER()` | Unique rank per partition, no ties | Deduplication, first event per user |
| `RANK()` | Rank with gaps on ties | Top-N with ties counted |
| `DENSE_RANK()` | Rank without gaps on ties | Percentile bucketing |
| `LAG(col, n)` | Value from n rows prior | Week-over-week comparison |
| `LEAD(col, n)` | Value from n rows ahead | Time to next event |
| `SUM() OVER (...)` | Running total | Cumulative revenue |
| `AVG() OVER (...)` | Rolling average | Smoothed DAU |
| `FIRST_VALUE()` | First value in window | First page per session |
| `LAST_VALUE()` | Last value in window | Last touch attribution |

---

### Deduplication with ROW_NUMBER

```sql
-- Keep only the first event per user per event type
WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY user_id, event_name
               ORDER BY event_time ASC
           ) AS rn
    FROM events
)
SELECT * FROM ranked WHERE rn = 1;
```

---

### Period-over-period with LAG

```sql
SELECT
    week,
    active_users,
    LAG(active_users) OVER (ORDER BY week) AS prev_week,
    active_users - LAG(active_users) OVER (ORDER BY week) AS wow_change
FROM weekly_actives;
```

---

### Running total with SUM OVER

```sql
SELECT
    DATE_TRUNC('day', created_at) AS day,
    COUNT(*)                      AS new_users,
    SUM(COUNT(*)) OVER (ORDER BY DATE_TRUNC('day', created_at)
                        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
                       )          AS cumulative_users
FROM users
GROUP BY 1
ORDER BY 1;
```

---

### Rolling average with AVG OVER ROWS

```sql
SELECT
    dt,
    dau,
    AVG(dau) OVER (
        ORDER BY dt
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS dau_7d_avg
FROM daily_actives;
```

---

### Session assignment with LAG and time gap

Assign session IDs by detecting gaps > 30 minutes between events.

```sql
WITH gaps AS (
    SELECT *,
           event_time - LAG(event_time) OVER (
               PARTITION BY user_id ORDER BY event_time
           ) AS time_since_last
    FROM events
),
session_starts AS (
    SELECT *,
           SUM(CASE WHEN time_since_last > INTERVAL '30 minutes'
                     OR time_since_last IS NULL
                    THEN 1 ELSE 0 END)
               OVER (PARTITION BY user_id ORDER BY event_time) AS session_id
    FROM gaps
)
SELECT * FROM session_starts;
```

---

## Common mistakes

**Using GROUP BY instead of PARTITION BY.** GROUP BY collapses rows. PARTITION BY does not. If you want one row per event with an aggregate property attached, use a window function.

**Forgetting ORDER BY inside OVER.** For LAG, LEAD and running totals, ORDER BY inside the OVER clause is required. Without it, the result is undefined.

**LAST_VALUE without ROWS BETWEEN.** By default, `LAST_VALUE()` uses the range from the start of the partition to the *current row*, not to the end. Always specify `ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING` to get the true last value.

---

*See also: [sql_patterns.md](sql_patterns.md) · [funnel_analysis.sql](funnel_analysis.sql) · [retention_analysis.sql](retention_analysis.sql)*
