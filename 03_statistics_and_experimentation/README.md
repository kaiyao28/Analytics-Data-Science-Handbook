# 03 · Statistics and Experimentation

## Why this matters

Experiments are the most reliable way to establish causality in a product context. Without statistical rigour, teams ship features that appear to work but do not — or fail to ship features that actually would have helped.

This section teaches the statistical thinking behind A/B testing: not just how to run a test but how to design it well, interpret results honestly and avoid the common mistakes that lead to false conclusions.

---

## What you need to know

- What a null hypothesis is and what it means to reject it
- What a p-value actually means (and the most common misinterpretation)
- Significance level (alpha) and statistical power (1 − beta)
- How to calculate sample size before a test
- How to set test duration and why weekly seasonality matters
- What a sample ratio mismatch is and why it invalidates a test
- Guardrail metrics and how to use them
- The most common experiment mistakes and how to avoid them

---

## Open this if...

| You need to... | Go to |
|----------------|-------|
| Understand the full A/B testing process | [ab_testing.md](ab_testing.md) |
| Know what can go wrong in an experiment | [common_experiment_mistakes.md](common_experiment_mistakes.md) |
| Calculate or explain sample size | [power_and_sample_size.md](power_and_sample_size.md) |
| Explain p-values or confidence intervals | [hypothesis_testing.md](hypothesis_testing.md) |
| Choose guardrail metrics | [guardrail_metrics.md](guardrail_metrics.md) |
| Build conceptual intuition before the details | [statistical_thinking.md](statistical_thinking.md) |
| Revise quickly for an interview | [../00_quick_reference/ab_testing_cheatsheet.md](../00_quick_reference/ab_testing_cheatsheet.md) |

---

## Core concepts

**Null hypothesis** — the assumption that there is no effect. The experiment tries to find evidence against it. Failing to reject the null does not prove the null is true; it means the data is consistent with it.

**p-value** — the probability of observing a result as extreme as the one observed, *if* the null hypothesis were true. It is not the probability that the result is due to chance, nor the probability that the null is true. This distinction matters in interviews and in practice.

**Statistical power** — the probability of detecting a true effect when it exists. Conventionally set to 80% (beta = 0.20). Low power means real, meaningful effects go undetected.

**Minimum detectable effect (MDE)** — the smallest effect size worth caring about. Drives sample size calculation. Setting it too small requires enormous samples; setting it too large misses real but modest improvements.

**Sample size** — determined by: MDE, significance level (alpha, usually 0.05) and power (usually 0.80). Never launch an experiment without calculating this. Running until it "looks right" guarantees inflated false positive rates.

**Multiple testing problem** — running many metrics simultaneously or testing multiple variants inflates the false positive rate. Address with Bonferroni correction or false discovery rate control.

**Novelty effect** — users interact differently with new features simply because they are new. Early experiment results often overestimate long-term impact. Check for stabilisation after week 1.

---

## Practical example

An e-commerce team tests a new checkout button. Current conversion rate: 4.0%. They want to detect a lift to 4.4% (a 10% relative improvement).

```
Minimum detectable effect: 0.4 percentage points
Significance level (alpha): 0.05
Power: 0.80
→ Required sample size: ~15,000 per group
→ At 1,000 daily visitors per group: 15 days minimum
→ Run for 21 days to cover 3 full weekly cycles
```

Result: treatment conversion = 4.5%, p = 0.03. Before shipping, the team checks:

- No sample ratio mismatch? ✓
- Guardrail metrics (refund rate, support contacts) stable? ✓
- Effect consistent across mobile and desktop? ✓
- Result stable in days 8–21 (no novelty effect)? ✓
- Effect size practically significant? ✓ (0.5pp lift ≈ $1.2M annual revenue)

**Recommendation: ship.**

---

## Common mistakes

**Peeking.** Checking results daily and stopping when p < 0.05 can more than double your false positive rate. Decide test duration before launch, or use sequential testing methods.

**Underpowered tests.** Running for too few days means you cannot detect real effects. A null result from an underpowered test tells you nothing.

**Ignoring practical significance.** A statistically significant effect of 0.01% conversion lift is not worth acting on. Always ask: how large is the effect in business terms?

**Choosing the metric after seeing results.** If you pick the metric that looks best after the test, you are p-hacking. Define the primary metric before launch and document it.

**Ignoring guardrail metrics.** A test can lift revenue while degrading user satisfaction or increasing churn. Always check guardrails.

**Declaring victory on secondary metrics.** If the primary metric is not significant but a secondary one is, that is not a win — it is a multiple comparisons problem.

---

## Interview relevance

A/B testing is a core topic in every analytics DS interview. Expected knowledge:

- How to calculate sample size (conceptually, with the right inputs)
- What a p-value actually means — many candidates describe it incorrectly
- Why peeking is a problem
- How to handle multiple metrics and variants
- What to do when the result is inconclusive
- How to explain a null result or a "do not ship" recommendation to a stakeholder

---

## Exercises

1. A team wants to detect a 5% relative improvement in day-30 retention from a baseline of 40%. What inputs do you need to calculate sample size? What sample size results (assume alpha = 0.05, power = 0.80)?
2. You get a result with p = 0.04. The product manager says "great, it worked — let's ship." What five questions do you ask before agreeing?
3. An experiment shows p = 0.22. The PM wants to "run it a bit longer to see if it becomes significant." How do you respond?
4. Write a one-paragraph explanation of p-values that a non-technical product manager would understand.

---

## Exercise answer rubric

| Exercise | Key points your answer must include |
|----------|-------------------------------------|
| 1 | Baseline = 40%, MDE = 2pp (5% relative of 40%), alpha = 0.05, power = 0.80. Approx 4,200 per group. Duration = 4,200 / daily traffic per variant. |
| 2 | (1) Was the primary metric pre-specified? (2) Is the effect ≥ MDE? (3) SRM check passed? (4) Guardrails stable? (5) No novelty effect (effect stable week 2+)? |
| 3 | Extending after observing results is peeking — inflates the false positive rate. p = 0.22 at a pre-specified end date means accept the null, or run a new pre-registered test with a smaller MDE. Never extend to chase significance. |
| 4 | Must include: (a) "if the change had no effect, this result would occur X% of the time by chance"; (b) must NOT say "97% probability the result is real"; (c) relate to alpha threshold and 1-in-20 false positive rate. |

---

## Files in this folder

| File | Topic |
|------|-------|
| `statistical_thinking.md` | Core statistical concepts for product analytics |
| `hypothesis_testing.md` | Null hypothesis, p-values, confidence intervals |
| `ab_testing.md` | End-to-end A/B testing process |
| `power_and_sample_size.md` | How to calculate sample size and test duration |
| `guardrail_metrics.md` | What guardrail metrics are and how to choose them |
| `common_experiment_mistakes.md` | Detailed breakdown of the most common testing errors |

---

## Next

[04_causal_inference](../04_causal_inference/README.md) — learn how to answer causal questions when randomised experiments are not possible.
