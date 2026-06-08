# Case Study: Activation Rate Drop

**Format:** Metric diagnosis → segment analysis → recommendation

**Key skills:** 7-step diagnosis framework, decomposition, SQL, data quality

---

## Business context

A mobile productivity app tracks activation as its primary growth metric. Activation is defined as a user completing their first task within 7 days of signup.

On Monday morning, a PM sends a Slack message: "Activation dropped 19% week-over-week. It was 34% last week, now it's 28%. Something is wrong."

---

## Your role

You are the analytics data scientist for the growth team. You need to determine:
1. Whether the drop is real
2. What is driving it
3. What the team should do

---

## Data available

The schema you have access to:

```sql
users(user_id, signup_date, platform, country, acquisition_channel, plan_type)
events(user_id, event_type, event_time)
-- Relevant event types: 'task_created', 'task_completed', 'app_open'
```

Historical activation benchmark: ~33–35% for the past 8 weeks.

---

## Work through this yourself first

Before reading the analysis below, write your own:
1. What are the first two things you check?
2. What SQL would you write to start the investigation?
3. What segments would you break down by?
4. What hypotheses would you form?

---

## Analysis walkthrough

### Step 1: Verify the data

Before doing anything else, check whether the drop is real.

```sql
-- Check: did event logging change?
SELECT
    DATE_TRUNC('week', event_time) AS week,
    COUNT(*) AS total_events,
    COUNT(DISTINCT user_id) AS users_with_events
FROM events
WHERE event_time >= '2025-02-01'
GROUP BY 1
ORDER BY 1;
```

**Finding:** Total events look normal. But `task_completed` events dropped 60% the same week activation dropped, while `app_open` events were flat.

This is a red flag: if app opens are normal but task completions dropped, either (a) a bug in the task completion event, or (b) users genuinely stopped completing tasks.

```sql
-- Check: is task_completed event firing at all?
SELECT
    DATE_TRUNC('day', event_time) AS day,
    COUNT(*) AS task_completed_events
FROM events
WHERE event_type = 'task_completed'
  AND event_time >= '2025-03-10'
GROUP BY 1
ORDER BY 1;
```

**Finding:** `task_completed` events drop to zero starting Wednesday March 12. This is not gradual — it's a cliff edge.

**Conclusion:** This is a tracking bug, not a real activation drop. The activation metric is defined as completing a first task — if that event is missing, no users appear to have activated.

---

### Step 2: Escalate the data quality issue

This is not an analysis problem. This is an engineering problem.

Report to the PM immediately:
> "The activation drop is almost certainly a logging bug. The `task_completed` event stopped firing on Wednesday. App opens and new signups are unaffected. I'm escalating to engineering for a hotfix. We should not make any product decisions based on this week's activation data until the logging is confirmed fixed."

---

### What if the data had been clean?

If the logging check had shown all events were intact, the next steps would be:

**Step 3: Timing — what changed?**
- Was there an app release last week?
- A change to the onboarding flow?
- A marketing campaign that shifted the acquisition mix?

**Step 4: Segment by acquisition channel**
```sql
WITH signups AS (
  SELECT
    user_id,
    signup_date,
    acquisition_channel,
    DATE_TRUNC('week', signup_date) AS signup_week
  FROM users
  WHERE signup_date >= '2025-02-01'
),
activated AS (
  SELECT DISTINCT u.user_id
  FROM signups u
  JOIN events e ON u.user_id = e.user_id
  WHERE e.event_type = 'task_completed'
    AND e.event_time BETWEEN u.signup_date AND u.signup_date + INTERVAL '7 days'
)
SELECT
  s.signup_week,
  s.acquisition_channel,
  COUNT(DISTINCT s.user_id) AS signups,
  COUNT(DISTINCT a.user_id) AS activated,
  ROUND(100.0 * COUNT(DISTINCT a.user_id) / COUNT(DISTINCT s.user_id), 1) AS activation_pct
FROM signups s
LEFT JOIN activated a ON s.user_id = a.user_id
GROUP BY 1, 2
ORDER BY 1, 2;
```

**Step 5: Decompose — is it a numerator or denominator problem?**

If signups are up but activation is flat, the denominator grew. If signups are stable but activated users fell, the numerator fell.

New users from lower-quality channels activate at a much lower rate — a channel mix shift can cause activation to drop without any product change.

---

## What good looks like — answer rubric

| Dimension | Weak | Strong |
|-----------|------|--------|
| First move | Jump to hypothesis about product | Check data quality first |
| Tracking check | Not done | Checks whether events are firing |
| Communication | Wait until full analysis done | Immediately flag the tracking bug |
| SQL | Jumps to segment breakdown | Starts with event counts over time |
| Decomposition | Checks one segment | Checks acquisition mix, platform, timing |

**Key lesson:** The most common cause of an apparent activation drop is a tracking bug. The fastest way to check is to look at raw event counts over time before forming any product hypothesis.

---

## Interview version

**Question:** "Activation dropped 19% last week. How would you investigate?"

**Strong answer hits:**
1. Verify the data — check logging, not just the metric
2. Look at timing — when exactly did the drop start?
3. Segment by acquisition channel, platform, country
4. Decompose — new vs returning users, or numerator vs denominator
5. Check for correlated product or marketing changes
6. Form a specific hypothesis with a mechanism
7. State the next diagnostic step

---

*Framework: [../01_product_and_business_thinking/metric_change_diagnosis.md](../01_product_and_business_thinking/metric_change_diagnosis.md)*
*Related questions: [../10_interview_prep/product_sense_questions.md](../10_interview_prep/product_sense_questions.md)*
*SQL patterns used: [../02_sql_for_analytics/sql_patterns.md](../02_sql_for_analytics/sql_patterns.md)*
