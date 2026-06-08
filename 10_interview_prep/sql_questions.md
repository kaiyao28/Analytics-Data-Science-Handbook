# SQL Interview Questions

---

## What interviewers are testing

- Can you write correct, readable SQL without errors?
- Do you understand join types and when to use each?
- Can you use window functions for ranking, deduplication and running totals?
- Do you know how to handle NULLs, duplicates and aggregation correctly?
- Can you think about edge cases: what if a user has no events? What if there are duplicates?

## Answer framework

1. Confirm or state the schema before writing
2. Say your approach out loud: "I'll use a CTE for each logical step"
3. Name the join type and say why
4. Identify potential pitfalls (duplicates, NULL denominators) before writing
5. Read your query back once before finishing — check the WHERE clause on any LEFT JOIN

---

## Questions

### Q1 — Counting active users

**Schema:** `events(user_id, event_name, event_time)`

**Question:** Write a query to count daily active users (DAU) for the month of March 2024. A user is active if they have any event on that day.

**What it tests:** date truncation, DISTINCT, basic aggregation.

**Key insight:** Use `DATE_TRUNC('day', event_time)` to group by day. Use `COUNT(DISTINCT user_id)` — not `COUNT(*)` — to avoid counting a user with 10 events as 10 active users.

**Strong answer:**
```sql
SELECT
    DATE_TRUNC('day', event_time) AS dt,
    COUNT(DISTINCT user_id)       AS dau
FROM events
WHERE event_time >= '2024-03-01'
  AND event_time <  '2024-04-01'
GROUP BY 1
ORDER BY 1;
```

**Follow-up interviewers ask:** "What if you want 0 on days with no events?" → Add a date spine with a LEFT JOIN.

---

### Q2 — Users who never converted

**Schema:** `users(user_id, created_at)`, `purchases(user_id, created_at)`

**Question:** Write a query to find all users who signed up in Q1 2024 but never made a purchase.

**What it tests:** anti-join pattern with LEFT JOIN + WHERE IS NULL.

**Key insight:** LEFT JOIN on purchases, then `WHERE purchases.user_id IS NULL`. A `NOT IN` subquery works but is dangerous with NULLs. A `NOT EXISTS` is also valid.

**Strong answer:**
```sql
SELECT u.user_id, u.created_at
FROM users u
LEFT JOIN purchases p ON u.user_id = p.user_id
WHERE u.created_at >= '2024-01-01'
  AND u.created_at <  '2024-04-01'
  AND p.user_id IS NULL;
```

**Common mistake:** Forgetting `AND p.user_id IS NULL` — without it, you get all users, not just the non-buyers.

---

### Q3 — First event per user

**Schema:** `events(user_id, event_name, event_time)`

**Question:** For each user, return the event_name and event_time of their first event ever.

**What it tests:** window functions vs subquery approach, deduplication.

**Key insight:** Two valid approaches. Window function is preferred for readability and avoids a correlated subquery.

**Strong answer (window function):**
```sql
WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY user_id
               ORDER BY event_time ASC
           ) AS rn
    FROM events
)
SELECT user_id, event_name, event_time
FROM ranked
WHERE rn = 1;
```

**Follow-up:** "What if two events have the exact same timestamp?" → ROW_NUMBER breaks ties arbitrarily. If you need determinism, add a tiebreaker: `ORDER BY event_time ASC, event_id ASC`.

---

### Q4 — Funnel conversion

**Schema:** `events(user_id, event_name, event_time)`. Events: `signup`, `profile_completed`, `first_purchase`.

**Question:** Calculate the step-to-step conversion rate through a 3-step funnel for users who signed up in March 2024.

**What it tests:** multi-step funnel logic, LEFT JOIN chain, NULLIF.

**Key insight:** Start from step 1 (signup), LEFT JOIN each subsequent step. Count DISTINCT user_id at each step divided by the prior step's count. Users who skip a step should appear as not converted at that step — not excluded.

**Approach:**
- CTE for each step using DISTINCT user_id
- Final SELECT: count at each step + division with NULLIF

See [../02_sql_for_analytics/funnel_analysis.sql](../02_sql_for_analytics/funnel_analysis.sql) for the full annotated query.

---

### Q5 — Week-over-week change

**Schema:** `events(user_id, event_name, event_time)`

**Question:** Write a query showing weekly DAU and the week-over-week percentage change.

**What it tests:** DATE_TRUNC to week, LAG window function, division.

**Strong answer:**
```sql
WITH weekly AS (
    SELECT
        DATE_TRUNC('week', event_time) AS week,
        COUNT(DISTINCT user_id)        AS dau
    FROM events
    GROUP BY 1
)
SELECT
    week,
    dau,
    LAG(dau) OVER (ORDER BY week)                               AS prior_week_dau,
    ROUND(
        (dau - LAG(dau) OVER (ORDER BY week)) * 100.0
        / NULLIF(LAG(dau) OVER (ORDER BY week), 0),
    1)                                                          AS wow_pct_change
FROM weekly
ORDER BY week;
```

---

### Q6 — Retention (day 7)

**Schema:** `users(user_id, created_at)`, `events(user_id, event_time)`

**Question:** Calculate the day-7 retention rate for users who signed up in January 2024.

**What it tests:** cohort retention logic, date arithmetic, LEFT JOIN.

**Key insight:** Day-7 retention = users active exactly 7 days after their signup day / total users in cohort. Use `DATE_TRUNC('day', ...)` for both sides before comparing.

See [../02_sql_for_analytics/retention_analysis.sql](../02_sql_for_analytics/retention_analysis.sql) for the full query.

---

### Q7 — Debugging a wrong query

**Question:** What is wrong with this query? How would you fix it?

```sql
SELECT u.user_id, SUM(p.amount) AS total_revenue
FROM users u
LEFT JOIN purchases p ON u.user_id = p.user_id
WHERE p.created_at >= '2024-01-01'
GROUP BY 1;
```

**What it tests:** understanding that WHERE on a LEFT JOIN's right table converts it to an INNER JOIN.

**Answer:** The `WHERE p.created_at >= '2024-01-01'` filter eliminates rows where `p.created_at IS NULL` — which are exactly the users who made no purchases. This converts the LEFT JOIN to an INNER JOIN and excludes non-buyers.

**Fix:** Move the condition to the `ON` clause:
```sql
LEFT JOIN purchases p
    ON u.user_id = p.user_id
   AND p.created_at >= '2024-01-01'
```

---

### Q8 — Running total

**Schema:** `purchases(user_id, amount, created_at)`

**Question:** For each purchase, show the running total amount spent by that user up to and including that purchase.

**What it tests:** SUM OVER with ROWS BETWEEN, PARTITION BY.

**Strong answer:**
```sql
SELECT
    user_id,
    created_at,
    amount,
    SUM(amount) OVER (
        PARTITION BY user_id
        ORDER BY created_at
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM purchases
ORDER BY user_id, created_at;
```

---

## Common mistakes to avoid

| Mistake | Fix |
|---------|-----|
| `COUNT(*)` instead of `COUNT(DISTINCT user_id)` | Always clarify: counting events or users? |
| No NULLIF on denominator | Always: `/ NULLIF(denominator, 0)` |
| WHERE on LEFT JOIN right table | Move to ON clause |
| Forgetting ORDER BY inside OVER() for LAG/SUM | Required for all ordered window functions |

---

## Practice plan

| Time available | What to do |
|----------------|-----------|
| 1 hour | Answer Q1–Q4 out loud, writing the SQL |
| Half day | All 8 questions with explanations |
| Full prep | Write variations: change the metric, change the time window, add a segment breakdown |

---

*Full SQL reference: [../02_sql_for_analytics/README.md](../02_sql_for_analytics/README.md)*
*Quick cheatsheet: [../00_quick_reference/sql_cheatsheet.md](../00_quick_reference/sql_cheatsheet.md)*
