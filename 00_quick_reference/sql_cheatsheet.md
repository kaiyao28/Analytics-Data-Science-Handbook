# SQL Cheatsheet

---

## Join types

| Join | Returns | Use when |
|------|---------|---------|
| `INNER JOIN` | Rows with matches in both tables | Absence of a match means exclude |
| `LEFT JOIN` | All from left, matched from right (NULL if no match) | Absence of a match is meaningful data |
| `FULL OUTER JOIN` | All rows from both sides, NULLs where no match | Comparing two partly-overlapping populations |

**Most common mistake:** Using INNER when you need LEFT — silently drops users who did not perform the action.

---

## Window functions

| Function | Use for |
|----------|---------|
| `ROW_NUMBER()` | Deduplication, first/last event per user |
| `RANK()` / `DENSE_RANK()` | Ranking with ties |
| `LAG(col, n)` | Prior period value (week-over-week, day-over-day) |
| `LEAD(col, n)` | Next period value |
| `SUM() OVER (ORDER BY ...)` | Running total |
| `AVG() OVER (ROWS BETWEEN ...)` | Rolling average |

---

## Patterns at a glance

**Deduplicate — keep first event per user:**
```sql
ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY event_time ASC)
-- Then: WHERE rn = 1
```

**Anti-join — users who never did something:**
```sql
LEFT JOIN table b ON a.user_id = b.user_id
WHERE b.user_id IS NULL
-- Without the WHERE: returns all, not just unmatched
```

**Period-over-period comparison:**
```sql
LAG(metric) OVER (ORDER BY period)
```

**Rolling 7-day average:**
```sql
AVG(dau) OVER (ORDER BY dt ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
```

**Conditional count (pivot-style):**
```sql
COUNT(CASE WHEN group = 'paid' THEN 1 END)
```

---

## Mistakes that produce wrong numbers silently

| Mistake | Effect |
|---------|--------|
| INNER JOIN where LEFT is needed | Drops unmatched rows from denominator |
| `WHERE` on LEFT JOIN's right table | Converts LEFT to INNER |
| Joining before aggregating | Fan-out multiplies rows, inflates sums |
| No `NULLIF` on denominator | Division by zero on empty cohorts |
| Missing `DISTINCT` in user counts | Counts events, not users |

---

*Full patterns: [sql_patterns.md](../02_sql_for_analytics/sql_patterns.md)*
*Join + window reference: [joins_and_windows.md](../02_sql_for_analytics/joins_and_windows.md)*
