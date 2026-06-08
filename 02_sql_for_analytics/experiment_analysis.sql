-- =============================================================================
-- Experiment Analysis: Treatment vs Control Comparison
-- =============================================================================
--
-- Goal: Analyse a two-variant A/B test, covering:
--   1. Sample ratio mismatch (SRM) check
--   2. Primary metric comparison
--   3. Guardrail metric check
--   4. Segment breakdown
--
-- Schema:
--   users(user_id, created_at, country, acquisition_channel, plan_type)
--   events(event_id, user_id, event_name, event_time, platform)
--   purchases(purchase_id, user_id, amount, currency, created_at)
--   experiment_assignments(user_id, experiment_id, variant, assigned_at)
--
-- Replace 'checkout_redesign_v1' with your experiment_id.
-- Adapt event names and metric definitions to match your experiment.
-- =============================================================================

-- =============================================================================
-- Step 1: SRM (Sample Ratio Mismatch) Check
-- =============================================================================
-- Run this FIRST. If the split deviates significantly from 50/50 (or your
-- intended ratio), there is an assignment integrity problem and you should
-- NOT interpret the metric results until it is resolved.

SELECT
    variant,
    COUNT(*)                                                                 AS assigned_users,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2)                      AS pct_of_total
FROM experiment_assignments
WHERE experiment_id = 'checkout_redesign_v1'
  AND assigned_at >= '2024-03-01'
  AND assigned_at <  '2024-03-22'
GROUP BY 1
ORDER BY 1;

-- Expected: ~50% per variant.
-- If you see 48/52 or worse, investigate before continuing.


-- =============================================================================
-- Step 2: Primary Metric — Checkout Conversion Rate
-- =============================================================================
-- Definition: proportion of assigned users who completed at least one purchase
-- after being assigned to the experiment.
--
-- Using LEFT JOIN so users who did not convert appear with converted = 0.
-- COUNT(DISTINCT) in the conversion CTE would give conversion = 1 or NULL;
-- we use a CASE to make 0 explicit.

WITH assignments AS (
    SELECT user_id, variant, assigned_at
    FROM experiment_assignments
    WHERE experiment_id = 'checkout_redesign_v1'
      AND assigned_at >= '2024-03-01'
      AND assigned_at <  '2024-03-22'
),

conversions AS (
    SELECT
        a.user_id,
        a.variant,
        MAX(CASE WHEN p.user_id IS NOT NULL THEN 1 ELSE 0 END) AS converted,
        COALESCE(SUM(p.amount), 0)                              AS total_revenue
    FROM assignments a
    LEFT JOIN purchases p
        ON a.user_id  = p.user_id
       AND p.created_at >= a.assigned_at      -- only purchases after assignment
    GROUP BY 1, 2
)

SELECT
    variant,
    COUNT(*)                                                                 AS users,
    SUM(converted)                                                           AS converters,
    ROUND(AVG(converted) * 100, 2)                                           AS conversion_rate_pct,
    ROUND(AVG(total_revenue), 2)                                             AS avg_revenue_per_user,
    ROUND(SUM(total_revenue), 2)                                             AS total_revenue
FROM conversions
GROUP BY 1
ORDER BY 1;


-- =============================================================================
-- Step 3: Guardrail Metric — Refund Rate
-- =============================================================================
-- Must NOT increase in treatment. If it does, investigate before shipping.

WITH assignments AS (
    SELECT user_id, variant, assigned_at
    FROM experiment_assignments
    WHERE experiment_id = 'checkout_redesign_v1'
      AND assigned_at >= '2024-03-01'
      AND assigned_at <  '2024-03-22'
),

refunds AS (
    SELECT DISTINCT a.user_id, a.variant
    FROM assignments a
    INNER JOIN events e
        ON a.user_id = e.user_id
       AND e.event_name  = 'refund_requested'
       AND e.event_time >= a.assigned_at
)

SELECT
    a.variant,
    COUNT(DISTINCT a.user_id)                                                AS assigned_users,
    COUNT(DISTINCT r.user_id)                                                AS users_with_refund,
    ROUND(COUNT(DISTINCT r.user_id) * 100.0
          / NULLIF(COUNT(DISTINCT a.user_id), 0), 2)                         AS refund_rate_pct
FROM assignments a
LEFT JOIN refunds r ON a.user_id = r.user_id
GROUP BY 1
ORDER BY 1;


-- =============================================================================
-- Step 4: Segment Breakdown — Conversion Rate by Platform
-- =============================================================================
-- Check whether the treatment effect holds across platforms.
-- Heterogeneous effects by segment can inform launch decisions
-- (e.g. ship only on mobile if the effect only holds there).

WITH assignments AS (
    SELECT a.user_id, a.variant, a.assigned_at,
           e.platform
    FROM experiment_assignments a
    INNER JOIN (
        -- Get the platform at time of first assignment-period event
        SELECT DISTINCT ON (user_id) user_id, platform
        FROM events
        ORDER BY user_id, event_time ASC
    ) e ON a.user_id = e.user_id
    WHERE a.experiment_id = 'checkout_redesign_v1'
      AND a.assigned_at >= '2024-03-01'
      AND a.assigned_at <  '2024-03-22'
),

conversions AS (
    SELECT
        a.user_id,
        a.variant,
        a.platform,
        MAX(CASE WHEN p.user_id IS NOT NULL THEN 1 ELSE 0 END) AS converted
    FROM assignments a
    LEFT JOIN purchases p
        ON a.user_id  = p.user_id
       AND p.created_at >= a.assigned_at
    GROUP BY 1, 2, 3
)

SELECT
    platform,
    variant,
    COUNT(*)                                                                 AS users,
    ROUND(AVG(converted) * 100, 2)                                           AS conversion_rate_pct
FROM conversions
GROUP BY 1, 2
ORDER BY 1, 2;
