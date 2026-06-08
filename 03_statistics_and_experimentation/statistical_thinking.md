# Statistical Thinking

Before running a test or interpreting a result, it helps to have a clear mental model of what statistics is actually doing. This file builds that foundation.

---

## What statistics is actually for

Statistics is a set of tools for making decisions under uncertainty. Product decisions are almost always made with incomplete information: imperfect data, noisy metrics, limited time windows, and samples that do not perfectly represent the future.

Statistical thinking is the discipline of being honest about that uncertainty while still reaching conclusions that are better than guessing.

---

## The signal-to-noise problem

Every metric you measure has two components:
- **Signal** — the true underlying effect you are trying to measure
- **Noise** — random variation that would exist even if nothing had changed

Statistics helps you tell them apart. A large sample gives you more data points, which allows the signal to emerge more clearly from the noise. A small sample leaves too much noise to be confident about what you are seeing.

This is why "let's just run it for a few days and see" often produces garbage results: the sample is too small to distinguish signal from noise.

---

## Statistical significance is not the same as importance

A result is statistically significant when the signal is large enough relative to the noise that it is unlikely to be random. It says nothing about whether the signal matters.

With a sample of 10 million users, a 0.001% change in conversion rate will be statistically significant. That is 100 extra conversions per million users. Depending on context, it may be real but completely irrelevant to the business.

**Practical significance asks: is this effect large enough to care about?**

Always report both:
- Effect size with confidence interval
- Whether the effect meets the pre-specified MDE

A p-value alone is not a decision.

---

## Effect sizes in product analytics

| Context | Typically meaningful | Likely noise |
|---------|---------------------|-------------|
| Onboarding activation | ≥ 2–3pp absolute | < 0.5pp |
| Checkout conversion | ≥ 1–2pp absolute | < 0.3pp |
| Retention (D30) | ≥ 1pp absolute | < 0.5pp |
| Revenue per user | ≥ 3–5% relative | < 1% relative |
| Session length | ≥ 5–10% relative | < 2% relative |

These are rough guides. The right threshold depends on the specific business context and the cost of the change.

---

## Population vs sample

Your experiment runs on a sample of users. The question you are trying to answer is about the underlying population — all current and future users who will experience the change if you ship it.

Statistical inference is the process of using sample observations to reason about population-level truths. It is always uncertain. The confidence interval captures that uncertainty. The p-value describes how consistent the sample result is with a specific null hypothesis about the population.

This is why the same experiment, run twice with different samples, can produce different p-values and slightly different effect estimates — even if the underlying effect is identical.

---

## Correlation is not causation

This is a cliché because it is constantly violated. In observational data, two variables moving together does not mean one is causing the other.

**Common confounders in product analytics:**

| Observation | Confounder |
|-------------|-----------|
| Users with mobile app have 40% higher LTV | Mobile users self-select — they are more engaged to begin with |
| Users who read 5+ articles convert at 3× the rate | Reading more is a symptom of engagement, not a cause |
| Power users of feature X retain at 2× the rate | Power users have higher baseline retention regardless |

An A/B test removes confounders by design — random assignment means the groups are comparable on all dimensions, measured and unmeasured. This is why it is the gold standard for causal inference in product analytics.

When a randomised experiment is not possible, see [../04_causal_inference/README.md](../04_causal_inference/README.md).

---

## Simpson's paradox

A trend that appears in the overall data can reverse within every subgroup when the groups have different sizes or compositions.

**Classic example:**
- Overall: treatment conversion = 40%, control = 45% (control wins)
- Mobile: treatment = 35%, control = 30% (treatment wins)
- Desktop: treatment = 50%, control = 45% (treatment wins)

Treatment wins in both segments but appears to lose overall. This happens because mobile users (who have lower conversion regardless) are disproportionately in the treatment group.

Implication: **always check segment-level results alongside overall results.** If the segments disagree with the aggregate, there is a composition effect.

---

## Frequentist vs Bayesian (for interviews)

The statistics in this handbook is primarily frequentist: we set a significance threshold before the test, run the test to the end, and make a binary accept/reject decision.

**Bayesian testing** is an alternative approach where you continuously update a probability distribution over the effect size as data comes in. It allows early stopping without the peeking problem, and produces a more intuitive output ("probability that treatment is better than control").

For interviews: know that both approaches exist. Be able to explain the frequentist interpretation of a p-value. Mention Bayesian as an alternative that handles sequential analysis differently.

---

## The three questions to ask before any statistical result

1. **Was the analysis pre-specified?** If the analyst chose the test, metric, or segment after seeing the data, the p-value is unreliable.

2. **Is the effect practically significant?** Does the magnitude matter for the decision, or is this a real but trivially small effect?

3. **Was the test adequately powered?** If it is a null result, what was the power? An underpowered null is not evidence of no effect.

---

## Mini exercise

A data analyst reports: "Users who use the search feature retain at 2.5× the rate of users who do not. We should invest more in search."

1. What causal claim is the analyst implying?
2. Name one confounder that could explain this observation without search causing retention.
3. How would you design a test to establish whether search *causes* higher retention?
4. If an A/B test of a new search feature shows p = 0.08, what do you conclude?

---

*Hypothesis testing in practice: [hypothesis_testing.md](hypothesis_testing.md)*
*Power and sample size: [power_and_sample_size.md](power_and_sample_size.md)*
*Causal inference when A/B tests are not possible: [../04_causal_inference/README.md](../04_causal_inference/README.md)*
