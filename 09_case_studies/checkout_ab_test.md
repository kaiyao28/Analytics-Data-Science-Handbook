# Case Study: Checkout A/B Test

**Format:** Experiment design → results interpretation → recommendation

**Key skills:** SRM handling, guardrail interpretation, null result communication, practical significance

---

## Business context

An e-commerce team believes their checkout form has too many fields and is causing drop-off. They want to test a simplified version with fewer required fields.

**The hypothesis:** If we reduce the checkout form from 12 fields to 7 fields, checkout completion rate will increase because friction is the primary reason users abandon at the payment step.

---

## Experiment design

| Field | Value |
|-------|-------|
| Randomisation unit | User (assigned at first checkout session) |
| Primary metric | Checkout completion rate (purchases / checkout sessions started) |
| Guardrails | Refund rate, fraud rate, average order value |
| Baseline completion rate | 28% |
| MDE | 2pp (smallest lift worth the rebuild cost) |
| Alpha | 0.05, Power 0.80 |
| Required per group | ~4,200 users |
| Daily eligible traffic | 600 users per group |
| Minimum duration | 7 days → run 21 days |

---

## Work through this yourself first

Before reading the results section, answer:
1. Why is user the right randomisation unit here, rather than session?
2. Why is refund rate a guardrail for a checkout form change?
3. What would you check first before looking at conversion rates?

---

## Week 1 results

The experiment goes live. After one week, a PM checks the dashboard and says: "It's working! We're up 4pp, p = 0.008."

**What should you do?**

> This is peeking. The test was pre-specified to run 21 days. Looking at week 1 data and making a ship decision violates the pre-specified analysis plan. The week 1 result should be noted, but the test must run to completion.

---

## End-of-experiment results

After 21 days, the pre-specified end date:

### SRM check

| Group | Expected | Actual | % |
|-------|----------|--------|---|
| Control | 6,300 | 6,300 | 50.0% |
| Treatment | 6,300 | 5,480 | 46.5% |

**Chi-squared p-value: < 0.001**

**This is a sample ratio mismatch.** The treatment group has significantly fewer users than expected.

**What do you do?**

Stop. Do not interpret conversion rates. A difference this large (6,300 vs 5,480) suggests the assignment mechanism is broken — users are being lost from the treatment group before checkout.

**Investigation:** Engineering finds that the simplified form requires users to be logged in (required for address autofill). Users who arrived at checkout without being logged in were shown an error and dropped from the session — and from the experiment tracking. These users disproportionately showed up in treatment.

**Result:** The logged-in requirement was not in the original experiment spec. It was a scope creep in the implementation. The experiment cannot be interpreted as designed.

---

## Relaunch

After the fix — removing the logged-in requirement — the experiment relaunches. End results after 21 days:

### Primary metric

| Group | Rate | n |
|-------|------|---|
| Control | 28.2% | 6,290 |
| Treatment | 30.8% | 6,274 |
| Delta | +2.6pp | — |
| 95% CI | [+1.2pp, +4.0pp] | — |
| p-value | 0.009 | — |

MDE was 2pp. Observed delta is 2.6pp. **MDE met.**

### Guardrail metrics

| Metric | Control | Treatment | Delta | p-value | Status |
|--------|---------|-----------|-------|---------|--------|
| Refund rate | 3.1% | 4.8% | +1.7pp | 0.003 | **⚠ Degraded** |
| Fraud rate | 0.4% | 0.7% | +0.3pp | 0.04 | **⚠ Degraded** |
| Average order value | £62.4 | £61.8 | −£0.6 | 0.31 | Stable |

**Primary metric passes. But two guardrails are significantly degraded.**

---

## Work through the recommendation yourself

Before reading below, write your recommendation. Consider:
1. The primary metric improved meaningfully.
2. Refund rate and fraud rate both increased significantly.
3. What could explain the refund and fraud rate increases?
4. What would you recommend?

---

## Analysis and recommendation

**Why did refund and fraud rates increase?**

Hypothesis: removing address verification fields (required for fraud detection) allowed more fraudulent orders and higher-return purchases through. The 7-field form omitted the CVV check on desktop — a bug, not intentional.

This is not a trade-off to accept. A form change that increases fraud and refunds is not a net improvement, even if checkout conversion went up.

**Recommendation: Do not ship.**

Write-up:
> "The simplified checkout form increased completion rate by 2.6pp, exceeding our pre-specified MDE of 2pp. However, refund rate increased 1.7pp (p = 0.003) and fraud rate increased 0.3pp (p = 0.04) — both pre-specified guardrails.
>
> The most likely cause is that the form omitted address validation fields that also serve as fraud-prevention signals. Engineering has confirmed a missing CVV check on desktop.
>
> Recommendation: do not ship. Redesign the simplified form to preserve fraud-detection inputs and retest. The core hypothesis (fewer fields = higher conversion) remains plausible — the issue is with this specific implementation."

---

## Lessons from this case

1. **SRM is not a technicality — it invalidates results.** The first version of this experiment produced a false positive because the treatment group was systematically different from control.

2. **A guardrail firing is a hard stop.** The second version passed the primary metric but failed on refund and fraud. Ship criteria require all guardrails to pass, not just the primary metric.

3. **Peeking bias is real.** Week 1 showed +4pp, which would have led to shipping a broken experiment. The final result was +2.6pp with a guardrail failure.

4. **Understand the mechanism before shipping.** The refund/fraud increase had a specific cause: removed validation fields. Once identified, the fix is clear — redesign, don't abandon the hypothesis.

---

## Answer rubric

| What you should cover | Weak | Strong |
|----------------------|------|--------|
| SRM | Ignored | Flagged immediately; refused to interpret results |
| Peeking risk | Not mentioned | Explicitly noted that week 1 result should not drive ship decision |
| Guardrail interpretation | "Refund rate went up a bit" | Named as a hard stop; investigated mechanism |
| Recommendation | "Don't ship because the test failed" | "Don't ship this version; redesign to preserve fraud controls and retest" |
| Communication | Vague | Clear recommendation with reasoning and next step |

---

*Experiment analysis SQL: [../02_sql_for_analytics/experiment_analysis.sql](../02_sql_for_analytics/experiment_analysis.sql)*
*A/B testing guide: [../03_statistics_and_experimentation/ab_testing.md](../03_statistics_and_experimentation/ab_testing.md)*
*Common mistakes: [../03_statistics_and_experimentation/common_experiment_mistakes.md](../03_statistics_and_experimentation/common_experiment_mistakes.md)*
*Interview questions: [../10_interview_prep/ab_testing_questions.md](../10_interview_prep/ab_testing_questions.md)*
