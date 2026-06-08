# Metric Diagnosis Cheatsheet

Use when a key metric moves unexpectedly.

---

## The seven steps — in order

```
1. Verify the data
   Is this a pipeline, logging, or instrumentation issue?
   Check: event counts, pipeline run status, recent schema changes.

2. Establish timing
   When exactly did the change begin — date, hour?
   Step change = specific event. Gradual drift = trend or quality issue.

3. Find correlated events
   What else changed at that time?
   Product releases, experiments, marketing campaigns, external events.

4. Disaggregate
   Which segments are affected?
   → Platform (iOS, Android, web)
   → Country / region
   → User type (new vs returning, free vs paid)
   → Acquisition channel
   → Cohort

5. Decompose the metric
   Is it numerator, denominator, or composition?
   Rate can fall because denominator grew (more users entering the funnel).

6. Form a hypothesis
   "The metric changed because [cause], affecting [segment], from [date],
   likely triggered by [event]."

7. State the next step
   What analysis confirms or rules out the hypothesis?
   What should the team do while you investigate?
```

---

## Quick symptom table

| What you see | Most likely cause |
|-------------|------------------|
| Step change at exact midnight | Timezone conversion error or batch pipeline issue |
| Drop on one platform only | Platform-specific bug or logging change |
| Drop in one country only | Regional product change, external event, or data issue |
| Rate drops but absolute count is flat | Denominator grew (more traffic, not worse conversion) |
| Metric drops but correlated metrics are stable | Possible instrumentation error on that specific event |
| Drop starts the day after a release | Product regression from the deployment |
| Drop correlates with a new acquisition campaign | Acquisition quality change (lower-intent users entering funnel) |

---

## Opening line in an interview

> "Before drawing any conclusions about the product, I want to check whether this is a data quality issue or a real signal."

---

## Red flags that mean "stop here"

- Sample ratio mismatch in any experiment running at the same time
- Event counts in the raw log dropped to zero for any hour
- The metric drops but the total number of events logged did not change

---

*Full framework: [../01_product_and_business_thinking/metric_change_diagnosis.md](../01_product_and_business_thinking/metric_change_diagnosis.md)*
*SQL patterns: [../02_sql_for_analytics/sql_patterns.md](../02_sql_for_analytics/sql_patterns.md)*
