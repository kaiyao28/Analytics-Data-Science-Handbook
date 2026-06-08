# 02 · SQL for Analytics

## Why this matters

SQL is the primary tool for extracting, transforming and analysing data in most analytics roles. Writing correct, readable, efficient SQL is a baseline expectation — not a differentiator.

What matters beyond correctness is judgment: structuring queries so the logic is clear, debugging unexpected results methodically, and avoiding traps that produce silently wrong answers.

---

## What you need to know

- Joins: inner, left, and when each is appropriate
- Aggregations: GROUP BY, HAVING, and common pitfalls
- Window functions: ROW_NUMBER, RANK, LAG, LEAD, running totals
- CTEs vs subqueries: when to use each for readability
- Funnel analysis: counting users at each step
- Retention analysis: cohort-based day-N retention
- Cohort analysis: grouping users by sign-up period
- Experiment analysis: comparing treatment and control metrics

---

## Core concepts

**Left join vs inner join** — a left join keeps all rows from the left table even if there is no match on the right. Use it when absence of a match is meaningful data (e.g. users who never converted). Inner joins silently drop non-matching rows.

**Grain** — the level at which a table is keyed (e.g. one row per user, one row per event). Misunderstanding grain is the most common cause of incorrect joins and double-counted metrics. Check cardinality before joining.

**Deduplication** — event tables often contain duplicate rows from logging retries or data pipeline issues. Always understand whether your source can have duplicates and add `DISTINCT` or `ROW_NUMBER()` logic if needed.

**Window functions** — calculate values across related rows without collapsing the result. Essential for: rankings, running totals, period-over-period comparisons and session analysis.

**CTEs (Common Table Expressions)** — named intermediate steps using `WITH`. Use them to break complex queries into readable, logical stages. Prefer CTEs over nested subqueries for anything beyond two levels.

---

## Practical example

Calculating 7-day retention using a cohort and events table:

```sql
WITH cohort AS (
    SELECT
        user_id,
        DATE_TRUNC('day', created_at) AS cohort_day
    FROM users
),
active AS (
    SELECT DISTINCT
        user_id,
        DATE_TRUNC('day', event_time) AS active_day
    FROM events
)
SELECT
    c.cohort_day,
    COUNT(DISTINCT c.user_id)                                        AS cohort_size,
    COUNT(DISTINCT CASE
        WHEN a.active_day = c.cohort_day + INTERVAL '7 days'
        THEN c.user_id END)                                          AS retained_day7,
    COUNT(DISTINCT CASE
        WHEN a.active_day = c.cohort_day + INTERVAL '7 days'
        THEN c.user_id END) * 1.0
        / NULLIF(COUNT(DISTINCT c.user_id), 0)                       AS retention_rate_day7
FROM cohort c
LEFT JOIN active a ON c.user_id = a.user_id
GROUP BY 1
ORDER BY 1;
```

Notes on this query:
- `LEFT JOIN` ensures users with no activity on day 7 are still counted in the denominator
- `DISTINCT` in the cohort CTE handles users who signed up multiple times
- `NULLIF` prevents division by zero

---

## Common mistakes

**Joining on non-unique keys.** If the right table has multiple rows per join key, the join fans out and double-counts. Always check cardinality before joining.

**Using INNER JOIN when LEFT JOIN is needed.** If a user never triggered an event, an inner join silently removes them. This is the most common source of denominator errors.

**Filtering a left-joined table in WHERE.** A `WHERE right_table.col IS NOT NULL` converts a left join to an inner join. Filtering conditions on the right table belong in the `ON` clause.

**Forgetting time zones.** Timestamps are often stored in UTC. Date truncation without timezone conversion produces incorrect cohort boundaries. Always check what timezone your data is in.

**Aggregating after a fan-out join.** If you join before aggregating and the join multiplies rows, your sums will be inflated. Aggregate first in a CTE, then join the summaries.

---

## Interview relevance

SQL is tested in almost every analytics DS interview. Common formats:

- Write a query to calculate [metric] — tests joins, window functions, and aggregation correctness
- Debug this query — tests attention to grain, join type and filter placement
- "What is wrong with this SQL?" — tests knowledge of common failure modes

Interviewers also probe follow-up questions: "What if users can appear multiple times?" or "How would this query behave if the events table has nulls?"

---

## Exercises

1. Write a query that calculates the 3-step funnel conversion rate (signup → activation → first purchase) from an `events` table.
2. Using a `purchases` table, calculate revenue per user by monthly acquisition cohort.
3. Write a query that identifies users who were active in month N but not in month N+1 (churned users).
4. Rewrite a correlated subquery that finds each user's most recent event as an equivalent window function.

---

## Files in this folder

| File | Topic |
|------|-------|
| `sql_patterns.md` | Core patterns: deduplication, date spine, rolling averages |
| `joins_and_windows.md` | Join types, window function reference, common use cases |
| `funnel_analysis.sql` | Funnel query with step-by-step comments |
| `retention_analysis.sql` | Day-N and week-N cohort retention queries |
| `cohort_analysis.sql` | Revenue and behaviour by cohort |
| `experiment_analysis.sql` | Treatment vs control comparison with guardrail checks |

---

## Next

[03_statistics_and_experimentation](../03_statistics_and_experimentation/README.md) — learn how to measure changes with statistical rigour.
