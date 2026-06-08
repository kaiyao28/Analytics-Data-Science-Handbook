# Funnels, Retention and Cohorts

Three essential tools for understanding whether users find value in a product and whether they return.

---

## Funnels

### What a funnel is

A funnel tracks the proportion of users who complete each step toward a goal. Every step has a conversion rate (users who proceed) and a drop-off rate (users who do not).

### Example: subscription learning app

| Step | Users | Step conversion | Overall conversion |
|------|-------|-----------------|-------------------|
| Installed app | 10,000 | — | 100% |
| Signed up | 6,500 | 65% | 65% |
| Completed onboarding | 3,200 | 49% | 32% |
| Completed first lesson | 1,900 | 59% | 19% |
| Subscribed (within 7 days) | 380 | 20% | 3.8% |

The biggest absolute drop is **signup → onboarding**: 3,300 users lost at one step. That is where to focus first, regardless of which step has the lowest percentage conversion.

### Strict vs loose funnels

- **Strict**: users must complete steps in order within a defined time window
- **Loose**: users must complete all steps at some point, in any order

Use strict funnels for conversion analysis. Use loose funnels for feature adoption where order does not matter.

### Common funnel mistakes

- Not specifying strict vs loose (the same data produces different numbers for each)
- Using sessions as the unit instead of users — users who repeat a step inflate counts
- No defined time window — a 7-day and a 30-day window produce very different conversion numbers from identical data

---

## Retention

### What retention measures

The proportion of users from a group who are still active at a defined point after joining.

### Retention windows

| Window | What it reveals |
|--------|----------------|
| Day 1 | Immediate onboarding quality |
| Day 7 | First-week habit formation |
| Day 30 | Early product-market fit signal |
| Month 3, 6, 12 | Long-term engagement health |

### Reading a retention curve

A healthy product shows a curve that **flattens** at a positive rate. A product without product-market fit shows a curve that **approaches zero**.

```
Day 0:   100%
Day 1:    42%
Day 7:    27%
Day 30:   19%   ← flattening here is a healthy signal
Day 60:   18%
Day 90:   17%
```

If month-3 retention is still near 0%, the product has not formed habits. Improving acquisition will not fix a retention problem.

### Common retention mistakes

- Defining "active" too loosely (any session open vs completing a meaningful action)
- Confusing **day-N retention** (active exactly N days after signup) with **rolling retention** (active at any point in a window)
- Reporting average retention without checking cohort trends (see below)

---

## Cohort Analysis

### Why averages mislead

Aggregate retention averages mix users who signed up months ago with users who signed up last week. If a product is growing, the large base of older users can mask deteriorating new-cohort quality.

### Cohort retention table

Rows = signup cohort (usually by week or month). Columns = time since signup.

| Cohort | Month 0 | Month 1 | Month 2 | Month 3 |
|--------|---------|---------|---------|---------|
| Jan | 100% | 38% | 28% | 22% |
| Feb | 100% | 41% | 31% | 25% |
| Mar | 100% | 36% | 24% | 19% |
| Apr | 100% | 29% | 20% | — |

The March and April cohorts are retaining noticeably worse. This is invisible in aggregate retention averages. Always check cohort trends before drawing conclusions about product health.

### What drives cohort retention differences

- **Acquisition channel mix**: paid users often retain differently from organic
- **Onboarding changes**: a worse onboarding in March could explain the March cohort drop
- **Seasonality**: January fitness app cohorts may be more motivated than June cohorts
- **Product quality**: bugs or feature regressions shipped in March would show up here

### Common cohort mistakes

- Not normalising for cohort size when comparing across cohorts
- Mixing revenue cohorts with user cohorts without accounting for refunds
- Drawing conclusions from cohorts that are too young to have stabilised

---

## Connecting all three

A standard workflow for understanding product health:

1. **Funnel**: where are users dropping off before they reach the core value moment?
2. **Retention**: of users who pass activation, how many return in week 1, month 1, month 3?
3. **Cohort**: are recent cohorts retaining better or worse than older cohorts? Is product quality improving?

Together they answer: *do users find value in the product, and does that value keep them coming back?*

---

## Mini exercise

A marketplace's overall DAU grew 20% month-over-month. The CEO is concerned about underlying quality.

1. Which cohort analysis would you run first? What specific table would you build?
2. What would a reassuring result look like vs a concerning one?
3. If the March cohort retains worse than the February cohort, name three hypotheses for why and what data you would look at to test each one.

---

*See also: [metrics.md](metrics.md) · [metric_change_diagnosis.md](metric_change_diagnosis.md) · [../02_sql_for_analytics/retention_analysis.sql](../02_sql_for_analytics/retention_analysis.sql) · [../02_sql_for_analytics/cohort_analysis.sql](../02_sql_for_analytics/cohort_analysis.sql)*
