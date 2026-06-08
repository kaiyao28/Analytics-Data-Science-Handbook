# Statistical Power and Sample Size

Getting the sample size right is one of the most important — and most ignored — parts of experiment design. This file explains the four inputs, how to use them, and what happens when you ignore them.

---

## Why this matters

An experiment with insufficient sample size produces one of two bad outcomes:
- A null result that tells you nothing ("the test was inconclusive, not that the feature didn't work")
- A positive result that is a false positive, because you were underpowered to be precise

Most teams run underpowered experiments without realising it. The fix is always the same: calculate before you launch.

---

## The four inputs

| Input | Definition | How to set it |
|-------|-----------|---------------|
| **Baseline rate** | Current performance of your primary metric | Pull from historical data; last 4 weeks is typical |
| **MDE** | Minimum detectable effect — the smallest improvement that is worth shipping | Business decision: what lift justifies the engineering cost? |
| **Alpha** | Significance level — the false positive rate you accept | Conventionally 0.05 |
| **Power** | Probability of detecting a true effect of size MDE | Conventionally 0.80 (80%) |

---

## How the inputs affect sample size

| If you... | Sample size... | Why |
|-----------|---------------|-----|
| Halve the MDE | Quadruples | Detecting a smaller signal requires much more data |
| Raise power from 0.80 to 0.90 | Increases ~35% | Harder to miss a real effect |
| Lower alpha from 0.05 to 0.01 | Increases ~25% | Stricter threshold requires stronger evidence |
| Increase baseline variance | Increases | More noise means harder to detect signal |

The MDE is the dominant lever. When a team says "we need to run a 3-month experiment," it usually means the MDE is too small, the baseline metric has high variance, or there is not enough traffic.

---

## Worked example

**Setup:**
- Primary metric: checkout completion rate
- Baseline: 32%
- MDE: 3pp (smallest lift worth the engineering investment)
- Alpha: 0.05, Power: 0.80

**Sample size formula (two-proportion z-test, 2-sided):**

```
n per group ≈ 2 × (Z_α/2 + Z_β)² × p̄(1 - p̄) / δ²

Where:
  Z_α/2 = 1.96  (alpha = 0.05, two-sided)
  Z_β   = 0.84  (power = 0.80)
  p̄     = 0.32  (baseline)
  δ     = 0.03  (MDE)
```

Result: **~2,800 users per group**

**Duration:**
- 400 eligible users per day per variant
- 2,800 / 400 = 7 days minimum
- Add weekly seasonality buffer: **run 21 days (3 full weekly cycles)**

---

## Choosing the MDE

The MDE is a business decision, not a statistical one. Ask:

1. What is the engineering cost of this change?
2. What lift would make it clearly worth shipping?
3. What lift would be too small to care about even if real?

If the engineering cost is high, the MDE should be set higher — only ship if the lift is large enough to justify the investment.

**Common error:** setting MDE to whatever comes out of the sample size calculator as "doable" given available traffic. This confuses statistical feasibility with business relevance. If the business only cares about lifts ≥ 5%, running an experiment sized to detect 1% is wasted precision.

---

## What "underpowered" means in practice

Suppose you ran a test with power = 0.30 for a 3pp lift, and got p = 0.18. What does this mean?

- There is a 70% chance you would have missed a real 3pp lift
- p = 0.18 is consistent with either: no effect, or a real 3pp effect that you were too underpowered to confirm
- The only valid conclusion: "the experiment was inconclusive"

You **cannot** conclude "this feature doesn't work" from an underpowered null result.

---

## The relationship between power and false positives

| Power | Beta | What happens at null result |
|-------|------|---------------------------|
| 80% | 0.20 | 20% chance of missing a real effect |
| 50% | 0.50 | 50% chance — a coin flip |
| 30% | 0.70 | 70% chance — most real effects are missed |

A team that routinely runs 30%-powered experiments will also accumulate false positives at a higher rate — because underpowered tests have inflated false positive rates when the true effect is smaller than the MDE.

---

## Variance reduction: getting more power without more users

If your experiment metric is very noisy (e.g. revenue per user), you can reduce variance — and therefore increase effective power — without increasing sample size.

**CUPED (Controlled-experiment Using Pre-Experiment Data):**
Use the user's pre-experiment value of the metric as a covariate. Regress out the pre-period variance. This can reduce variance by 30–60% for revenue metrics, effectively doubling the experiment's sensitivity.

**Other variance reduction approaches:**
- Cap outliers: winsorise revenue at the 99th percentile
- Use a ratio metric: revenue per converted user instead of revenue per user (reduces denominators dominated by non-converters)
- Stratified randomisation: assign users in proportion to predicted value buckets

---

## Quick-reference formulas

For a two-proportion test:
```
n per group ≈ 2 × (Z_α/2 + Z_β)² × p̄(1 - p̄) / δ²
```

For a two-mean test (revenue per user):
```
n per group ≈ 2 × (Z_α/2 + Z_β)² × σ² / δ²
```

Standard values:
- Z_α/2 = 1.96 (alpha = 0.05, two-sided)
- Z_β = 0.84 (power = 0.80)
- Z_β = 1.28 (power = 0.90)

---

## Interview answer structure

For "How do you determine the sample size for an A/B test?":

1. Name the four inputs: baseline, MDE, alpha, power
2. Explain MDE is a business decision (what lift is worth shipping?)
3. State that you'd use a sample size calculator in practice
4. Show you know: smaller MDE → larger sample; lower variance → smaller sample
5. Convert sample to duration: required users / daily eligible traffic
6. Add weekly cycle buffer

---

## Mini exercise

A team wants to test a new payment method. Baseline conversion: 18%. They believe any lift above 2pp is worth the integration effort.

1. What are the four inputs they need?
2. If the test requires 4,500 users per group and they see 300 eligible users per day per variant, how long should the test run?
3. The test runs for 10 days and shows p = 0.21. The PM says "let's run two more weeks." What do you say?
4. If the team instead sets MDE to 0.5pp, what happens to the required sample size?

---

*Back to overview: [ab_testing.md](ab_testing.md)*
*Common mistakes: [common_experiment_mistakes.md](common_experiment_mistakes.md)*
*Statistics questions: [../10_interview_prep/statistics_questions.md](../10_interview_prep/statistics_questions.md)*
