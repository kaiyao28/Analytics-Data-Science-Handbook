# A/B Testing

A/B testing (randomised controlled experiment) is the most reliable way to measure the causal impact of a product change. This file covers the full lifecycle: from designing a test to communicating the result.

---

## The experiment lifecycle

### 1. Hypothesis

Write the hypothesis before touching any data or code:

> "If we [make change X], then [metric Y] will [direction] because [mechanism]."

The mechanism forces you to reason about *why* the change should work. Without a mechanism, you cannot judge whether the result makes sense or whether it is likely to replicate.

| Weak hypothesis | Strong hypothesis |
|----------------|-------------------|
| "If we change the button colour, revenue will increase" | "If we increase the checkout button contrast ratio, completion rate will increase because low-contrast buttons are hard to see on mobile and cause users to abandon at the final step" |
| "If we add a feature, engagement will go up" | "If we add a weekly progress summary, D7 retention will increase because users who see progress evidence are less likely to churn" |

---

### 2. Choose the randomisation unit

The randomisation unit is what gets assigned to control or treatment.

**Default: the user.** Consistent experience across sessions and devices. Metrics aggregate naturally.

**Use session** only when user-level consistency is not required (e.g. testing a landing page for anonymous visitors).

**Use geographic cluster** when there is strong interference risk — one user's treatment might affect another (social networks, marketplaces, platforms with network effects).

The randomisation unit must be:
- Stable for the test duration
- The same level at which the experience is delivered
- Independent between units (no spillover)

---

### 3. Define the primary metric

**One metric only.** Pre-specified before launch.

It should:
- Move only when the mechanism you hypothesised is working
- Be measurable within the test duration
- Be defined precisely: metric name + numerator + denominator + time window

Example: "Checkout completion rate = purchases / checkout sessions started, per user per day, measured over the experiment window."

Define it in writing before the experiment launches. Store it in a shared doc, ticket or experiment platform.

---

### 4. Define guardrail metrics

Guardrails are metrics that must not degrade. They catch second-order effects: a feature that improves the primary metric but harms something else.

Typical guardrails:
- Revenue-per-user (for activation experiments)
- Refund rate (for checkout experiments)
- Notification opt-out rate (for notification experiments)
- D30 retention (for any short-term engagement optimisation)
- Latency / error rate (always, for engineering changes)

---

### 5. Calculate sample size

Four inputs:

| Input | What it is | Typical value |
|-------|-----------|---------------|
| Baseline rate | Current performance of the primary metric | From historical data |
| MDE | Minimum detectable effect — smallest lift worth shipping | Depends on cost of the change |
| Alpha | Significance level — false positive rate | 0.05 |
| Power | Probability of detecting a true effect | 0.80 |

The smaller the MDE, the larger the sample required. Doubling precision requires 4x the sample.

**Worked example:**

- Baseline checkout completion: 32%
- MDE: 3pp (smallest lift worth acting on given engineering cost)
- Alpha: 0.05, Power: 0.80
- Required per group: ~2,800 users
- Daily eligible traffic: 400 users per group
- Minimum duration: 7 days → run **21 days** (3 full weekly cycles)

---

### 6. Set the test duration

Duration = required users / daily eligible traffic per group

Always run for **at least 2–3 full weekly cycles.** Day-of-week effects are real: Monday users and Saturday users behave differently. A test that runs Thursday to Tuesday gives an unrepresentative sample.

Never stop early based on the results. Set a fixed end date before launch.

---

### 7. Pre-specify the launch criterion

Write the ship decision rule before launch:

> "We will ship if: (1) the primary metric improves by ≥ MDE, (2) all guardrails are stable or positive, (3) the SRM check passes."

This prevents post-hoc rationalisation: choosing to ship because "close enough" or extending because "almost significant."

---

### 8. Analyse at the end date

Run this sequence — do not skip steps:

1. **SRM check** — if the actual split deviates significantly from the intended split, stop. Do not interpret until resolved.
2. **Primary metric** — direction, magnitude, confidence interval, p-value.
3. **Practical significance** — translate to business terms. A 0.001% lift at p < 0.001 may not be worth shipping.
4. **Guardrail metrics** — check every one. A guardrail degradation is a blocker.
5. **Segment breakdown** — major cuts: platform, user tenure, geography. Heterogeneous effects inform partial rollouts but are exploratory.
6. **Novelty check** — compare the effect in week 1 vs weeks 2–3. A decaying effect means novelty, not a real improvement.

---

### 9. Communicate the result

See [../00_quick_reference/communication_templates.md](../00_quick_reference/communication_templates.md) for ready-to-use templates.

The structure of every experiment readout:

1. Recommendation (first, not last)
2. Primary metric result with confidence interval
3. Guardrail status
4. Segment summary
5. Key risks / caveats
6. Next step

---

## SRM check — worked example

Expected split: 50/50 (3,000 per group)

Actual: 3,120 control, 2,880 treatment

Chi-squared test: is this deviation significant?

```sql
-- From experiment_analysis.sql
SELECT
    variant,
    COUNT(*) AS actual_count,
    3000 AS expected_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct
FROM experiment_assignments
WHERE experiment_id = 'checkout_button_v2'
GROUP BY variant;
```

If the chi-squared p-value < 0.01, stop and investigate. Do not proceed with metric analysis.

---

## Interview answer structure

For "Design an A/B test":

1. Hypothesis (mechanism, not just direction)
2. Randomisation unit (and why)
3. Primary metric (one, precisely defined)
4. Guardrail metrics (at least two)
5. Sample size inputs: baseline, MDE, alpha, power
6. Duration calculation + weekly cycles
7. Pre-specified launch criterion
8. Key risks: SRM, novelty, peeking, interference

---

## Weak vs strong answer

**Question:** "How would you measure whether this new onboarding flow is better?"

**Weak:** "I'd run an A/B test and compare retention between the groups."

**Strong:** "First I'd define what 'better' means: I'd use D7 retention as the primary metric because onboarding quality predicts short-term retention most directly. I'd need the baseline D7 retention, decide the smallest improvement worth shipping (say 2pp), and calculate the sample size — probably around 5,000 per group given typical retention rates. I'd run for 3 full weeks to cover weekly seasonality. Guardrails would be D30 retention and paid conversion, because an onboarding change that hurts long-term engagement or monetisation is a net loss. I'd document all of this before launch and only analyse at the pre-specified end date."

---

## Mini exercise

A checkout team wants to test removing the promo code field. They believe it causes drop-off. Baseline checkout completion is 45%, and any lift ≥ 2pp is worth acting on.

1. Write the hypothesis (include the mechanism).
2. Name the primary metric and two guardrails.
3. Calculate required test duration if there are 1,200 checkout starts per day per variant.
4. Write the pre-specified ship criterion.
5. What would a novelty effect look like in the results, and how would you detect it?

---

*Cheatsheet: [../00_quick_reference/ab_testing_cheatsheet.md](../00_quick_reference/ab_testing_cheatsheet.md)*
*Common mistakes: [common_experiment_mistakes.md](common_experiment_mistakes.md)*
*Interview questions: [../10_interview_prep/ab_testing_questions.md](../10_interview_prep/ab_testing_questions.md)*
*Case study: [../09_case_studies/onboarding_activation_ab_test.md](../09_case_studies/onboarding_activation_ab_test.md)*
*SQL: [../02_sql_for_analytics/experiment_analysis.sql](../02_sql_for_analytics/experiment_analysis.sql)*
