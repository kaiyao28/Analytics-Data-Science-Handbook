-- =============================================================================
-- Funnel Analysis: Signup → Activation → First Purchase
-- =============================================================================
--
-- Goal: Count unique users at each step and calculate step and overall
--       conversion rates, by signup cohort month.
--
-- Schema:
--   users(user_id, created_at, country, acquisition_channel, plan_type)
--   events(event_id, user_id, event_name, event_time, platform)
--   purchases(purchase_id, user_id, amount, currency, created_at)
--
-- Notes:
--   - This is a STRICT funnel: users must complete steps in order.
--   - DISTINCT prevents double-counting users who trigger the same event
--     multiple times.
--   - LEFT JOINs from step 1 ensure all users appear in the denominator,
--     even if they did not complete later steps.
--   - NULLIF prevents division by zero for months with no signups.
-- =============================================================================

WITH

-- Step 1: All users who signed up in the analysis window
-- This is the top of the funnel and the denominator for overall conversion.
step_1_signups AS (
    SELECT
        user_id,
        DATE_TRUNC('month', created_at)  AS signup_month,
        created_at                       AS signup_time
    FROM users
    WHERE created_at >= '2024-01-01'
      AND created_at <  '2024-04-01'
),

-- Step 2: Users who completed activation (first meaningful core action)
-- Deduplicated to first activation per user.
step_2_activation AS (
    SELECT DISTINCT user_id
    FROM events
    WHERE event_name = 'onboarding_completed'
),

-- Step 3: Users who made their first purchase within 30 days of signup.
-- The 30-day window prevents counting users who converted much later
-- as part of this funnel cohort analysis.
step_3_first_purchase AS (
    SELECT DISTINCT
        p.user_id
    FROM purchases p
    INNER JOIN users u
        ON p.user_id = u.user_id
    WHERE p.created_at <= u.created_at + INTERVAL '30 days'
)

-- Final funnel output: one row per signup cohort month
SELECT
    s1.signup_month,

    -- Absolute user counts at each step
    COUNT(DISTINCT s1.user_id)                                               AS step1_signups,
    COUNT(DISTINCT s2.user_id)                                               AS step2_activated,
    COUNT(DISTINCT s3.user_id)                                               AS step3_purchased,

    -- Step-to-step conversion rates
    ROUND(
        COUNT(DISTINCT s2.user_id) * 100.0
        / NULLIF(COUNT(DISTINCT s1.user_id), 0),
    1)                                                                       AS pct_signup_to_activation,

    ROUND(
        COUNT(DISTINCT s3.user_id) * 100.0
        / NULLIF(COUNT(DISTINCT s2.user_id), 0),
    1)                                                                       AS pct_activation_to_purchase,

    -- Overall funnel conversion (signup → purchase)
    ROUND(
        COUNT(DISTINCT s3.user_id) * 100.0
        / NULLIF(COUNT(DISTINCT s1.user_id), 0),
    1)                                                                       AS pct_overall_conversion

FROM step_1_signups s1
LEFT JOIN step_2_activation s2 ON s1.user_id = s2.user_id
LEFT JOIN step_3_first_purchase s3 ON s1.user_id = s3.user_id
GROUP BY 1
ORDER BY 1;


-- =============================================================================
-- Variant: Funnel with platform breakdown
-- =============================================================================
-- Useful for diagnosing whether a conversion problem is platform-specific.
-- Replaces the signup_month grouping with platform from the events table.

WITH

step_1 AS (
    SELECT user_id, DATE_TRUNC('month', created_at) AS signup_month
    FROM users
    WHERE created_at >= '2024-01-01'
      AND created_at <  '2024-04-01'
),

step_2_with_platform AS (
    -- Capture the platform at activation for the breakdown
    SELECT DISTINCT ON (user_id)
        user_id,
        platform
    FROM events
    WHERE event_name = 'onboarding_completed'
    ORDER BY user_id, event_time ASC
),

step_3 AS (
    SELECT DISTINCT p.user_id
    FROM purchases p
    INNER JOIN users u ON p.user_id = u.user_id
    WHERE p.created_at <= u.created_at + INTERVAL '30 days'
)

SELECT
    s1.signup_month,
    COALESCE(s2.platform, 'unknown')                                         AS platform,
    COUNT(DISTINCT s1.user_id)                                               AS signups,
    COUNT(DISTINCT s2.user_id)                                               AS activated,
    COUNT(DISTINCT s3.user_id)                                               AS purchased,
    ROUND(
        COUNT(DISTINCT s2.user_id) * 100.0
        / NULLIF(COUNT(DISTINCT s1.user_id), 0),
    1)                                                                       AS activation_rate,
    ROUND(
        COUNT(DISTINCT s3.user_id) * 100.0
        / NULLIF(COUNT(DISTINCT s1.user_id), 0),
    1)                                                                       AS overall_conversion
FROM step_1 s1
LEFT JOIN step_2_with_platform s2 ON s1.user_id = s2.user_id
LEFT JOIN step_3 s3 ON s1.user_id = s3.user_id
GROUP BY 1, 2
ORDER BY 1, 2;
