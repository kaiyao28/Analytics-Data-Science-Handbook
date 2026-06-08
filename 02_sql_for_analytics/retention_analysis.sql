-- =============================================================================
-- Cohort Retention Analysis: Day 1, 7, 14, 30
-- =============================================================================
--
-- Goal: For each weekly signup cohort, show what proportion of users
--       were active exactly N days after their signup date.
--
-- Schema:
--   users(user_id, created_at, country, acquisition_channel, plan_type)
--   events(event_id, user_id, event_name, event_time, platform)
--
-- "Active" = any event in the events table on that specific day.
-- To use a stricter definition, filter events by event_name below.
--
-- Notes:
--   - DATE_TRUNC('day', ...) normalises to midnight for day comparisons.
--   - LEFT JOIN from cohort ensures users with zero activity still appear
--     in the denominator with NULL for active days.
--   - NULLIF prevents division by zero for very recent cohorts with 0 users.
-- =============================================================================

WITH

-- Define signup cohorts (weekly buckets to reduce noise vs daily)
cohort AS (
    SELECT
        user_id,
        DATE_TRUNC('week', created_at)   AS cohort_week,
        DATE_TRUNC('day',  created_at)   AS signup_day
    FROM users
    WHERE created_at >= '2024-01-01'
      AND created_at <  '2024-04-01'
),

-- Get unique user-day combinations from the events table
-- DISTINCT prevents a user with 10 events on day 7 counting multiple times
daily_activity AS (
    SELECT DISTINCT
        user_id,
        DATE_TRUNC('day', event_time)    AS active_day
    FROM events
    WHERE event_time >= '2024-01-01'
    -- Optional: restrict to meaningful events only
    -- AND event_name IN ('lesson_completed', 'session_start')
),

-- Calculate days since signup for each active day
activity_with_offset AS (
    SELECT
        da.user_id,
        c.cohort_week,
        (da.active_day - c.signup_day)   AS days_since_signup
    FROM daily_activity da
    INNER JOIN cohort c ON da.user_id = c.user_id
)

SELECT
    c.cohort_week,
    COUNT(DISTINCT c.user_id)                                                AS cohort_size,

    -- Retained user counts at each checkpoint
    COUNT(DISTINCT CASE WHEN a.days_since_signup = 1  THEN c.user_id END)   AS retained_day1,
    COUNT(DISTINCT CASE WHEN a.days_since_signup = 7  THEN c.user_id END)   AS retained_day7,
    COUNT(DISTINCT CASE WHEN a.days_since_signup = 14 THEN c.user_id END)   AS retained_day14,
    COUNT(DISTINCT CASE WHEN a.days_since_signup = 30 THEN c.user_id END)   AS retained_day30,

    -- Retention rates as percentages
    ROUND(
        COUNT(DISTINCT CASE WHEN a.days_since_signup = 1  THEN c.user_id END) * 100.0
        / NULLIF(COUNT(DISTINCT c.user_id), 0),
    1)                                                                       AS pct_day1,
    ROUND(
        COUNT(DISTINCT CASE WHEN a.days_since_signup = 7  THEN c.user_id END) * 100.0
        / NULLIF(COUNT(DISTINCT c.user_id), 0),
    1)                                                                       AS pct_day7,
    ROUND(
        COUNT(DISTINCT CASE WHEN a.days_since_signup = 14 THEN c.user_id END) * 100.0
        / NULLIF(COUNT(DISTINCT c.user_id), 0),
    1)                                                                       AS pct_day14,
    ROUND(
        COUNT(DISTINCT CASE WHEN a.days_since_signup = 30 THEN c.user_id END) * 100.0
        / NULLIF(COUNT(DISTINCT c.user_id), 0),
    1)                                                                       AS pct_day30

FROM cohort c
LEFT JOIN activity_with_offset a ON c.user_id = a.user_id
GROUP BY 1
ORDER BY 1;


-- =============================================================================
-- Variant: N-week rolling retention (active in any day within a window)
-- =============================================================================
-- Some products use "active at any point in week N" rather than "active on
-- exactly day N". This catches users who return slightly early or late.
-- Adjust BETWEEN bounds to change the window width.

WITH

cohort AS (
    SELECT user_id,
           DATE_TRUNC('week', created_at) AS cohort_week,
           DATE_TRUNC('day',  created_at) AS signup_day
    FROM users
    WHERE created_at >= '2024-01-01'
      AND created_at <  '2024-04-01'
),

daily_activity AS (
    SELECT DISTINCT user_id, DATE_TRUNC('day', event_time) AS active_day
    FROM events
    WHERE event_time >= '2024-01-01'
)

SELECT
    c.cohort_week,
    COUNT(DISTINCT c.user_id)                                                AS cohort_size,

    -- Week 1: any activity between day 1 and day 7
    COUNT(DISTINCT CASE
        WHEN a.active_day BETWEEN c.signup_day + 1 AND c.signup_day + 7
        THEN c.user_id END)                                                  AS retained_week1,

    -- Week 4: any activity between day 22 and day 30
    COUNT(DISTINCT CASE
        WHEN a.active_day BETWEEN c.signup_day + 22 AND c.signup_day + 30
        THEN c.user_id END)                                                  AS retained_week4,

    ROUND(
        COUNT(DISTINCT CASE
            WHEN a.active_day BETWEEN c.signup_day + 1 AND c.signup_day + 7
            THEN c.user_id END) * 100.0
        / NULLIF(COUNT(DISTINCT c.user_id), 0),
    1)                                                                       AS pct_week1,
    ROUND(
        COUNT(DISTINCT CASE
            WHEN a.active_day BETWEEN c.signup_day + 22 AND c.signup_day + 30
            THEN c.user_id END) * 100.0
        / NULLIF(COUNT(DISTINCT c.user_id), 0),
    1)                                                                       AS pct_week4

FROM cohort c
LEFT JOIN daily_activity a ON c.user_id = a.user_id
GROUP BY 1
ORDER BY 1;
