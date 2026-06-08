# SQL Patterns for Analytics

Core reusable patterns for product analytics. Each pattern solves a problem that comes up repeatedly across funnels, retention, experiment analysis and metric monitoring.

**Fictional schema used throughout:**
- `users(user_id, created_at, country, acquisition_channel, plan_type)`
- `events(event_id, user_id, event_name, event_time, platform)`
- `purchases(purchase_id, user_id, amount, currency, created_at)`
- `experiment_assignments(user_id, experiment_id, variant, assigned_at)`

---

## 1. Deduplication

Event tables often have duplicate rows from logging retries or pipeline issues. Always check for duplicates before aggregating.

### Detect duplicates
```sql
SELECT user_id, event_name, event_time, COUNT(*) AS cnt
FROM events
GROUP BY 1, 2, 3
HAVING COUNT(*) > 1;
```

### Keep the first occurrence per user per event type
```sql
WITH deduped AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY user_id, event_name
               ORDER BY event_time ASC
           ) AS rn
    FROM events
)
SELECT * FROM deduped WHERE rn = 1;
```

---

## 2. Date spine

A date spine generates a continuous series of dates. Without it, days with zero events are silently absent from your results rather than appearing as 0 — which can make a real drop look like a missing data day.

```sql
-- Generate a date spine for Q1 2024
WITH RECURSIVE date_spine AS (
    SELECT DATE '2024-01-01' AS dt
    UNION ALL
    SELECT dt + INTERVAL '1 day'
    FROM date_spine
    WHERE dt < DATE '2024-03-31'
)
SELECT
    d.dt,
    COALESCE(COUNT(DISTINCT e.user_id), 0) AS dau
FROM date_spine d
LEFT JOIN events e
    ON DATE_TRUNC('day', e.event_time) = d.dt
GROUP BY 1
ORDER BY 1;
```

---

## 3. Rolling average

Use window functions to smooth out day-of-week noise in time series charts.

```sql
SELECT
    dt,
    dau,
    AVG(dau) OVER (
        ORDER BY dt
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) AS dau_7day_rolling_avg
FROM (
    SELECT DATE_TRUNC('day', event_time) AS dt,
           COUNT(DISTINCT user_id)       AS dau
    FROM events
    GROUP BY 1
) daily
ORDER BY dt;
```

---

## 4. First and last events per user

```sql
-- Using aggregation (for scalar values only)
SELECT
    user_id,
    MIN(event_time) AS first_event,
    MAX(event_time) AS last_event,
    COUNT(*)        AS total_events
FROM events
GROUP BY user_id;

-- Using window functions (when you need the full row at first/last event)
WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY user_id
               ORDER BY event_time ASC
           ) AS rn
    FROM events
)
SELECT * FROM ranked WHERE rn = 1;
```

---

## 5. Anti-join (users who did NOT do something)

Find users who exist in one table but have no matching row in another.

```sql
-- Users who signed up but never made a purchase
SELECT u.user_id, u.created_at, u.acquisition_channel
FROM users u
LEFT JOIN purchases p ON u.user_id = p.user_id
WHERE p.user_id IS NULL;
```

Critical: `WHERE p.user_id IS NULL` is what makes this an anti-join. Without it, the LEFT JOIN returns all users, not just the unmatched ones.

---

## 6. Period-over-period comparison

Compare a metric in the current period to the same metric in the prior period.

```sql
WITH weekly AS (
    SELECT
        DATE_TRUNC('week', event_time) AS week,
        COUNT(DISTINCT user_id)        AS dau
    FROM events
    WHERE event_name = 'session_start'
    GROUP BY 1
)
SELECT
    week,
    dau,
    LAG(dau) OVER (ORDER BY week)                                        AS prior_week_dau,
    dau - LAG(dau) OVER (ORDER BY week)                                  AS absolute_change,
    ROUND(
        (dau - LAG(dau) OVER (ORDER BY week)) * 100.0
        / NULLIF(LAG(dau) OVER (ORDER BY week), 0),
    1)                                                                   AS pct_change
FROM weekly
ORDER BY week;
```

---

## 7. Aggregation with conditional counts (pivot-style)

Avoid separate queries for each variant or segment. Use `CASE WHEN` inside aggregates.

```sql
SELECT
    DATE_TRUNC('month', created_at) AS month,
    COUNT(*)                                                             AS total_users,
    COUNT(CASE WHEN plan_type = 'free'    THEN 1 END)                   AS free_users,
    COUNT(CASE WHEN plan_type = 'paid'    THEN 1 END)                   AS paid_users,
    COUNT(CASE WHEN country = 'US'        THEN 1 END)                   AS us_users,
    ROUND(COUNT(CASE WHEN plan_type = 'paid' THEN 1 END) * 100.0
          / NULLIF(COUNT(*), 0), 1)                                      AS paid_pct
FROM users
GROUP BY 1
ORDER BY 1;
```

---

## Common mistakes

**Not checking for duplicates before joining.** Joining an unaggregated table that has duplicate rows silently inflates every sum and count.

**Using WHERE on a LEFT JOIN's right table.** A `WHERE right_table.col IS NOT NULL` filter converts your left join into an inner join and drops users with no match. Move conditions on the right table into the `ON` clause.

**Forgetting NULLIF in denominators.** Always wrap denominators in `NULLIF(..., 0)` to avoid division-by-zero errors on empty cohorts.

**Not adding a date spine.** If you rely on the events table for your date axis, days with no events are missing — not zero. This makes real drops look like data gaps.

---

*See also: [joins_and_windows.md](joins_and_windows.md) · [funnel_analysis.sql](funnel_analysis.sql) · [retention_analysis.sql](retention_analysis.sql)*
