-- =============================================================================
-- Cohort Revenue Analysis: ARPU by Signup Cohort × Months of Life
-- =============================================================================
--
-- Goal: Show average revenue per user (ARPU) for each signup cohort
--       across their first 6 months. Used for LTV trend analysis and
--       understanding whether newer cohorts are monetising better or worse.
--
-- Schema:
--   users(user_id, created_at, country, acquisition_channel, plan_type)
--   purchases(purchase_id, user_id, amount, currency, created_at)
--
-- Notes:
--   - "Months since signup" uses DATE_DIFF to compute cohort age.
--   - ARPU divides by the total cohort size (including non-payers) so that
--     it reflects monetisation across the full cohort, not just buyers.
--   - Use currency filtering if your purchases table has multiple currencies.
-- =============================================================================

WITH

-- Define cohorts by signup month
cohorts AS (
    SELECT
        user_id,
        DATE_TRUNC('month', created_at)  AS cohort_month
    FROM users
    WHERE created_at >= '2023-01-01'
      AND created_at <  '2024-01-01'
),

-- Tag each purchase with the cohort month and months-since-signup
purchases_tagged AS (
    SELECT
        p.user_id,
        c.cohort_month,
        p.amount,
        -- Number of complete months between signup and purchase
        DATEDIFF('month', c.cohort_month, DATE_TRUNC('month', p.created_at))
                                         AS months_since_signup
    FROM purchases p
    INNER JOIN cohorts c
        ON p.user_id = c.user_id
    WHERE p.created_at >= '2023-01-01'
      AND DATEDIFF('month', c.cohort_month, DATE_TRUNC('month', p.created_at))
          BETWEEN 0 AND 5           -- first 6 months of cohort life
      -- AND p.currency = 'USD'    -- uncomment if filtering by currency
)

SELECT
    c.cohort_month,
    COUNT(DISTINCT c.user_id)                                                AS cohort_size,

    -- Revenue per user by cohort age month
    ROUND(SUM(CASE WHEN pt.months_since_signup = 0 THEN pt.amount ELSE 0 END)
          / NULLIF(COUNT(DISTINCT c.user_id), 0), 2)                         AS arpu_month0,

    ROUND(SUM(CASE WHEN pt.months_since_signup = 1 THEN pt.amount ELSE 0 END)
          / NULLIF(COUNT(DISTINCT c.user_id), 0), 2)                         AS arpu_month1,

    ROUND(SUM(CASE WHEN pt.months_since_signup = 2 THEN pt.amount ELSE 0 END)
          / NULLIF(COUNT(DISTINCT c.user_id), 0), 2)                         AS arpu_month2,

    ROUND(SUM(CASE WHEN pt.months_since_signup = 3 THEN pt.amount ELSE 0 END)
          / NULLIF(COUNT(DISTINCT c.user_id), 0), 2)                         AS arpu_month3,

    ROUND(SUM(CASE WHEN pt.months_since_signup = 4 THEN pt.amount ELSE 0 END)
          / NULLIF(COUNT(DISTINCT c.user_id), 0), 2)                         AS arpu_month4,

    ROUND(SUM(CASE WHEN pt.months_since_signup = 5 THEN pt.amount ELSE 0 END)
          / NULLIF(COUNT(DISTINCT c.user_id), 0), 2)                         AS arpu_month5,

    -- Cumulative 6-month ARPU (LTV proxy)
    ROUND(SUM(pt.amount) / NULLIF(COUNT(DISTINCT c.user_id), 0), 2)          AS arpu_6month_cumulative

FROM cohorts c
LEFT JOIN purchases_tagged pt
    ON c.user_id = pt.user_id
GROUP BY 1
ORDER BY 1;


-- =============================================================================
-- Variant: Cohort size and paid conversion by signup month
-- =============================================================================
-- Shows what proportion of each cohort ever made any purchase,
-- and the average order value among those who did.

WITH cohorts AS (
    SELECT user_id, DATE_TRUNC('month', created_at) AS cohort_month
    FROM users
    WHERE created_at >= '2023-01-01'
),

first_purchase AS (
    SELECT DISTINCT ON (user_id)
        user_id,
        amount             AS first_purchase_amount,
        created_at         AS first_purchase_time
    FROM purchases
    ORDER BY user_id, created_at ASC
)

SELECT
    c.cohort_month,
    COUNT(DISTINCT c.user_id)                                                AS cohort_size,
    COUNT(DISTINCT fp.user_id)                                               AS ever_purchased,
    ROUND(COUNT(DISTINCT fp.user_id) * 100.0
          / NULLIF(COUNT(DISTINCT c.user_id), 0), 1)                         AS pct_ever_purchased,
    ROUND(AVG(fp.first_purchase_amount), 2)                                  AS avg_first_order_value
FROM cohorts c
LEFT JOIN first_purchase fp ON c.user_id = fp.user_id
GROUP BY 1
ORDER BY 1;
