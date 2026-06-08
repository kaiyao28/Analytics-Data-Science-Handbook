# 04 · Causal Inference

## Why this matters

Not every product question can be answered with an A/B test. Some interventions cannot be randomised: pricing changes in a marketplace, policy rollouts, geographic launches. Others are too slow, expensive or ethically complex to run as experiments. Causal inference gives you rigorous methods for estimating causal effects from observational data — and for being honest about the assumptions those estimates rest on.

---

## What you need to know

- Why observational comparisons are biased, and what selection bias is
- When to use observational methods vs experiments
- Difference-in-differences (DiD) and the parallel trends assumption
- Matching: what it does and does not solve
- Regression discontinuity design (RDD)
- How to communicate causal claims honestly to stakeholders

---

## Core concepts

**Counterfactual** — what would have happened to the treated group if they had not been treated. This is never directly observable. All causal methods are ways of constructing a credible counterfactual.

**Selection bias** — treated and untreated groups differ systematically before treatment, so a naive before-after or treated-vs-untreated comparison is misleading.

**Parallel trends assumption** — required for DiD: in the absence of treatment, the treated and control groups would have followed the same trend over time. This assumption cannot be proven, only made more or less credible by showing pre-period trends were similar.

**Regression discontinuity (RDD)** — exploits a sharp threshold in an assignment variable (e.g. a loyalty tier cutoff, an age limit, a score threshold) to compare units just above and just below. Units near the threshold are similar except for which side they fall on.

**Instrumental variable (IV)** — a variable that affects treatment assignment but affects the outcome only through the treatment. Rare to find in practice but powerful when valid.

**SUTVA (Stable Unit Treatment Value Assumption)** — assumes one unit's treatment does not affect another unit's outcome. Violated in networks and marketplaces (spillover effects).

---

## Practical example

A subscription service changes its refund policy for users in Germany but not France. To estimate the effect on churn:

**DiD setup:**
- Treatment group: German users (received the policy change)
- Control group: French users (similar market, no change)
- Pre-period: 3 months before the policy change
- Post-period: 3 months after

```
DiD estimate = (Germany_post − Germany_pre) − (France_post − France_pre)
```

This removes any time trend common to both markets, leaving only the effect of the policy change.

**Critical check before trusting this estimate:** Do Germany and France show parallel churn trends in the pre-period? If Germany was already declining faster than France before the policy change, DiD will overstate or understate the effect. Always plot pre-trends.

---

## Common mistakes

**Assuming parallel trends without checking.** This is the most important assumption in DiD. Always plot the trend for both groups through the pre-period. If trends diverge before treatment, DiD is not credible.

**Confusing regression coefficients with causal effects.** Adding control variables to a regression does not automatically produce a causal estimate. You need a credible identification strategy, not just more covariates.

**Using matching without checking covariate balance.** Matching reduces selection bias only if you match on the right variables. Always check that matched groups are actually comparable.

**Over-claiming certainty.** Observational methods give credible estimates under stated assumptions — not certainties. Always communicate the assumptions and what would invalidate the conclusion.

**Ignoring network spillovers.** In marketplace or social products, treating one user affects untreated users. This violates SUTVA and can bias both experiment and observational estimates.

---

## Interview relevance

Causal inference questions are common in senior analytics DS and product science interviews:

- "You can't run an A/B test. How would you estimate the effect of this change?"
- "Walk me through how you would set up a difference-in-differences study."
- "What are the assumptions of your approach, and how would you validate them?"
- "Why is correlation not causation in this scenario?"

The key skill is to state your method, explain its assumptions and tell the interviewer what would invalidate your conclusion. Interviewers want to see intellectual honesty, not false confidence.

---

## Exercises

1. A streaming service launches a new feature to users in one city but not another. Describe how you would use DiD to estimate the effect on watch time. What would make you trust or distrust the result?
2. Describe a product scenario where RDD would be appropriate. What is the threshold variable, and what is the key assumption?
3. A team observes that users who use the mobile app more than 5 times in their first week retain at much higher rates. They want to build a feature to push users to that threshold. What causal question are they really asking, and how would you answer it?

---

## Files in this folder

| File | Topic |
|------|-------|
| `causal_vs_correlation.md` | Why observational comparisons mislead and how to think about causality |
| `diff_in_diff.md` | DiD setup, parallel trends assumption, worked example |
| `matching.md` | Propensity score matching, exact matching, balance checks |
| `regression_discontinuity.md` | RDD setup, bandwidth selection, common applications |
| `when_ab_tests_are_not_possible.md` | Decision framework for choosing an observational method |

---

## Next

[05_python_and_analysis_workflows](../05_python_and_analysis_workflows/README.md) — learn to build reproducible analysis pipelines in Python.
