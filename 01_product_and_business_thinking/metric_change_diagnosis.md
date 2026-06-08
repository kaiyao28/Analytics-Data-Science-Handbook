# Metric Change Diagnosis

## Why it matters

Diagnosing unexpected metric movements is one of the most common tasks in analytics data science — and one of the most frequently tested in interviews. The skill is not just knowing what to look at; it is working through the investigation in the right order so you do not waste time on the wrong hypothesis.

---

## The seven-step framework

### Step 1: Verify the data first

Before concluding anything about the product, rule out data quality issues.

- Did the data pipeline run successfully?
- Are there missing records, unexpected nulls or zero values?
- Did any logging, instrumentation or schema change around the time of the drop?
- Do raw event counts look consistent with the metric trend?

**Why first?** A data issue creates a false alarm. Investigating a non-existent product problem wastes time and damages credibility. Verify the data is real before treating the signal as real.

---

### Step 2: Establish the timing

- When exactly did the metric change begin? Day? Hour?
- Was it a sudden step change or a gradual drift?
- Is it still happening now or did it stabilise?

A precise timestamp narrows the search for a cause. A step change on a specific hour points to a deployment or incident. A gradual drift over weeks points to a product quality, acquisition or seasonality issue.

---

### Step 3: Look for correlated events

At the time the metric changed, what else changed?

- Product releases or feature flag toggles
- Active experiments
- Marketing campaigns or channel mix shifts
- External events (competitor launch, media coverage, seasonality)
- Data pipeline or infrastructure changes

This is usually where the answer is. Build a timeline of changes that overlaps with the metric movement.

---

### Step 4: Disaggregate by every meaningful dimension

Break the metric down by:

- Platform (iOS, Android, web)
- Country or region
- User type (new vs returning, free vs paid, acquisition cohort)
- Acquisition channel
- Device type or OS version
- Product area or feature

If the change is isolated to one segment, the cause is segment-specific. If it is universal across all segments, the cause is more fundamental.

---

### Step 5: Decompose the metric

Most metrics are ratios. A ratio can move because:

- The **numerator** changed (e.g. fewer users converted)
- The **denominator** changed (e.g. more users entered the funnel, diluting the rate)
- The **composition** of the denominator shifted (e.g. mix shifted toward lower-converting segments)

Decompose before concluding. A falling conversion rate is very different depending on whether it is a true decline or a denominator effect from strong top-of-funnel growth.

---

### Step 6: Form a hypothesis

Synthesise what you have found into the most likely explanation.

Format:
> "The metric changed because [cause], affecting [segment], starting [date], likely triggered by [event]."

State what evidence supports the hypothesis and what evidence would contradict it.

---

### Step 7: Define the next step before running it

- What specific analysis would confirm or rule out your hypothesis?
- Is the change permanent or does it look like it will revert?
- What should the team do while the investigation continues?

---

## Weak vs strong answer

### Scenario: DAU dropped 18% overnight.

**Weak answer:**
> "I would look at the data and check what happened across different user groups to see if there is a pattern."

Why it is weak:
- No structure — the reader cannot tell what order things will be checked
- Does not start with data quality
- No specifics on what segments or metrics to check
- Does not end with a next step

---

**Strong answer:**
> "First I would check whether the drop is real: did the pipeline run, are event counts normal, did any logging change yesterday? If the data is clean, I would find the exact hour the drop started. Then I would look at what changed at that time — deployments, experiments, external events.
>
> Next I would disaggregate: is the drop on iOS or Android? A specific country? New or returning users? If it is isolated to one segment, the cause is segment-specific. If universal, it is more fundamental.
>
> I would also decompose the metric: is it fewer daily users, or the same users being counted differently (definition or instrumentation change)?
>
> Based on that, I would form the most likely hypothesis and define the next analysis to confirm or rule it out. I would also flag to the team whether any mitigation is needed while we investigate."

Why it is stronger:
- Clear sequence (data quality → timing → correlated events → disaggregation → decomposition)
- Distinguishes data issues from real issues
- Ends with a specific next step and considers operational impact
- An interviewer can follow the reasoning and probe each step

---

## Connecting to the SQL

The diagnosis typically requires several SQL queries:
- Event counts by day and segment (to confirm the data is real)
- Metric broken down by platform, country, user type (to disaggregate)
- Funnel steps to identify where in the flow the drop occurred

See [../02_sql_for_analytics/sql_patterns.md](../02_sql_for_analytics/sql_patterns.md) for the period-over-period pattern.

---

## Mini exercise

A subscription app's day-7 retention drops from 28% to 19% between the January and February signup cohorts.

1. What is the first thing you check? Why?
2. List five dimensions you would disaggregate by.
3. Name three plausible hypotheses for the drop.
4. What would you tell the team while you investigate?

---

*See also: [metrics.md](metrics.md) · [funnels_retention_cohorts.md](funnels_retention_cohorts.md) · [product_case_framework.md](product_case_framework.md)*
