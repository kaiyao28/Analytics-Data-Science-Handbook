# 01 · Product and Business Thinking

## Why this matters

Technical skills are only valuable when directed at the right question. Most analytics failures are not technical — they are failures of framing: answering the wrong question precisely, or measuring the wrong thing carefully.

This section teaches how to translate messy business and product questions into precise, answerable metrics and analytical tasks. It is the foundation everything else builds on.

---

## What you need to know

- What a metric is and how to choose one
- The difference between input and output metrics
- How to define activation, retention and churn for a product
- How to diagnose a change in a key metric
- How to apply a structured framework to a product case question

---

## Core concepts

**North star metric** — the single number that best captures the core value a product delivers to users. For Spotify it might be time spent listening. For a marketplace it might be successful transactions.

**Input vs output metrics** — output metrics (revenue, DAU) measure results. Input metrics (items added to cart, messages sent) measure actions that lead to results. Input metrics are more controllable.

**Leading vs lagging indicators** — leading metrics predict future outcomes and are more actionable. Lagging metrics confirm past outcomes and are more meaningful but harder to act on.

**Funnel** — a sequence of steps from first exposure to a desired outcome. Each step has a conversion rate. Funnels reveal where users drop off.

**Cohort** — a group of users who share a common start event (typically sign-up date). Cohort analysis shows how behaviour changes as users age.

**Guardrail metrics** — metrics that must not degrade even if the primary metric improves. Prevent shipping changes with harmful side effects.

**Composition effect** — a rate metric can change because the underlying population mix shifted, not because individual behaviour changed. Always check.

---

## Practical example

A subscription learning app wants to improve retention. Before analysing anything, the team must define:

1. What counts as "active"? (e.g. completed at least one lesson in the last 7 days)
2. What is the retention window? (Day 7? Day 30? Month 3?)
3. Which cohort? (All users? Only users who completed onboarding?)
4. What is the north star metric? (Lessons completed? Days active per week? Skills unlocked?)

Without these definitions, two analysts will produce different numbers from the same data and reach different conclusions. Defining the metric precisely is the first job, not an afterthought.

---

## Common mistakes

**Confusing activity with value.** Users opening an app is not the same as getting value from it. Clicks and opens are weak proxies. Define activation around the core value moment.

**Averaging over heterogeneous users.** Averages hide distribution. A new-user cohort and a six-month cohort behave differently. Segment before concluding.

**Changing metric definitions mid-analysis.** Once you start, define and lock your metrics. Changing them partway through introduces bias and makes results irreproducible.

**Ignoring the composition effect.** A rising average can mask falling performance if the user mix is shifting toward higher-value segments.

**Skipping the recommendation.** Producing accurate numbers without a recommendation is incomplete. Analysis exists to support decisions.

---

## Interview relevance

Product sense and metrics questions are central to every analytics DS interview. Common formats:

- "How would you measure the success of [feature]?"
- "A key metric dropped 20% overnight. Walk me through how you diagnose it."
- "What is the north star metric for [product]?"
- "How do you choose between metric A and metric B?"

Interviewers want structured thinking: define terms, clarify scope, identify trade-offs, give a recommendation.

---

## Exercises

1. Pick a product you use daily. Define its north star metric, one input metric and one guardrail metric. Write a two-sentence justification for each.
2. Write out the activation event for a food delivery app, a messaging app and a B2B SaaS product. Explain why each matters.
3. A social app's DAU/MAU ratio drops from 55% to 48% over three months. List five hypotheses for why and describe what data you would look at to test each one.

---

## Files in this folder

| File | Topic |
|------|-------|
| `metrics.md` | Input vs output metrics, north star, leading vs lagging indicators |
| `funnels_retention_cohorts.md` | Funnel analysis, retention curves, cohort analysis |
| `metric_change_diagnosis.md` | Framework for diagnosing unexpected metric movements |
| `product_case_framework.md` | Structured approach to open-ended product case questions |

---

## Next

[02_sql_for_analytics](../02_sql_for_analytics/README.md) — now that you can define the question, learn how to extract the data.
