# Metrics

## Why it matters

A metric is a claim about what the product is trying to achieve. Getting the metric wrong means the entire analysis is answering the wrong question — even if the analysis itself is technically correct.

---

## Types of metrics

### Output metrics

Measure business results directly. Usually the right things to care about ultimately.

Examples: revenue, paid subscriptions, DAU, retention rate.

- Aligned with company goals
- Slow to move; influenced by many factors at once
- Hard to attribute to specific product changes

### Input metrics

Measure user actions that lead to results. More controllable and actionable.

Examples: lessons completed, messages sent, items added to cart, searches performed.

Before relying on an input metric, ask:
- Has the link between this metric and the output metric been validated?
- Can it be gamed? (If so, add a guardrail)
- Is it specific enough to guide a product decision?

### Leading vs lagging indicators

| Type | Definition | Example | Trade-off |
|------|-----------|---------|-----------|
| Leading | Predicts future outcomes | Day-3 retention predicts month-1 | Actionable but often a weaker proxy |
| Lagging | Confirms past outcomes | Annual revenue | Meaningful but slow to measure |

---

## North star metric

The single metric that best captures the core value delivered to users.

Criteria:
- Reflects genuine user value, not just activity
- Predicts long-term retention and revenue
- Aligns the whole team (product, growth, engineering)

| Product type | North star candidate |
|-------------|---------------------|
| Music streaming | Monthly hours listened |
| Marketplace | Successful transactions per month |
| Learning app | Learners completing their first module |
| B2B SaaS | Weekly active teams |
| Social app | Messages sent between real connections |

A north star fails if it can be improved without improving user value (e.g. "sessions" can be inflated by crashes; "messages sent" by spam).

---

## Guardrail metrics

Metrics that must not degrade even if the primary metric improves. They prevent optimising in a way that harms users or the business.

| Optimising for | Example guardrail metrics |
|----------------|--------------------------|
| Checkout conversion | Refund rate, customer support contacts |
| Notification click rate | Opt-out rate, app uninstall rate |
| Ad revenue | Time in app, satisfaction score |
| Activation rate | Day-7 retention, first-session quality |

---

## Choosing a metric: five questions

1. Does it measure actual value or just activity?
2. Is the denominator unambiguous? (12% of *what* population?)
3. Is it sensitive enough to detect meaningful changes in a reasonable time frame?
4. Can it be gamed? What is the corresponding guardrail?
5. Is the whole team aligned on the definition before we start?

---

## Common mistakes

**Vanity metrics.** Downloads, registrations and page views are easy to grow and rarely predict business outcomes. Ask: if this metric doubled tomorrow, would it meaningfully change the product decision?

**Conflating activity with value.** An "active user" who opens the app but completes nothing meaningful is not the same as one who reaches the core value moment. Define activation around the value event.

**Metric proliferation.** A team tracking 50 metrics effectively prioritises none. Choose 3–5 primary metrics and protect them from definition drift.

**Changing definitions mid-analysis.** If you redefine "active" partway through, the comparison is invalid. Lock definitions before pulling data.

**Not documenting the denominator.** "Conversion rate is 12%" is ambiguous. "7-day paid conversion rate for new mobile users in the US" is not.

---

## Mini exercise

You are the analytics DS for a fitness app (users log workouts, follow guided programmes, track streaks).

1. Propose a north star metric. Justify it in one sentence.
2. Name two input metrics the product team could directly influence this quarter.
3. Name one guardrail metric for an experiment to increase push notification click rate.
4. Classify each of your proposed metrics as leading or lagging.

---

*See also: [funnels_retention_cohorts.md](funnels_retention_cohorts.md) · [metric_change_diagnosis.md](metric_change_diagnosis.md)*
