# Hypothesis Testing

The foundation for interpreting any A/B test result. This file covers null and alternative hypotheses, p-values, confidence intervals, and the decisions that follow.

---

## The null and alternative hypothesis

**Null hypothesis (H₀):** There is no effect. The control and treatment are identical. Any observed difference is due to random variation.

**Alternative hypothesis (H₁):** There is an effect. The observed difference reflects a real difference in the underlying distribution.

The experiment does not prove or disprove H₀. It generates evidence that either does or does not allow us to *reject* H₀ at a pre-specified threshold.

**Failing to reject H₀ is not the same as proving it is true.** It means the data is consistent with no effect — but an underpowered test would reach the same conclusion even when a real effect exists.

---

## One-sided vs two-sided tests

| Type | Hypothesis | When to use |
|------|-----------|-------------|
| Two-sided | H₁: treatment ≠ control | Most product experiments — you care if the feature is worse, not just better |
| One-sided | H₁: treatment > control | Only when a negative result would definitely not change the decision — rare |

**Default to two-sided.** One-sided tests require half the sample but miss deterioration. Most product teams cannot truthfully claim they would ignore a significant negative result — so two-sided is the honest choice.

---

## The p-value

**Precise definition:**
The probability of observing a test statistic at least as extreme as the one observed, *assuming the null hypothesis is true*.

**What a p-value of 0.04 means:**
"If the treatment truly had no effect, there is only a 4% chance we would observe a difference this large by random variation alone."

**What a p-value of 0.04 does not mean:**

| Common misinterpretation | Why it is wrong |
|--------------------------|----------------|
| "There is a 96% probability the result is real" | p-values are not probabilities about the truth of the hypothesis |
| "There is a 4% chance the result is due to chance" | Same error — this is a probability about the hypothesis, not the data |
| "The effect is large" | p-values say nothing about magnitude; only about whether the signal exceeds noise |
| "We proved the feature works" | p < alpha is evidence against the null, not proof of anything |

---

## The significance level (alpha)

Alpha is the false positive rate you are willing to accept. At alpha = 0.05:
- 1 in 20 truly null experiments will appear significant by chance
- Pre-specified before launch — never changed after seeing results

Standard values:
- **0.05** — most product experiments
- **0.01** — high-stakes decisions (major product changes, monetisation features)
- **0.10** — exploratory tests where false positives are cheap

Lowering alpha reduces false positives but requires more sample to maintain power.

---

## Confidence intervals

A 95% confidence interval is constructed so that if the experiment were repeated many times, 95% of the calculated intervals would contain the true population parameter.

**What a CI tells you that p-values do not:**
- The direction and magnitude of the effect
- The precision of the estimate
- Whether the effect is practically significant

| Confidence interval | Interpretation |
|--------------------|---------------|
| [+1.2%, +4.8%] | Significant, precise, practically meaningful |
| [+0.01%, +4.99%] | Significant, but imprecise — compatible with tiny or large effects |
| [-0.5%, +4.5%] | Not significant (crosses zero), but plausible upside |
| [+0.001%, +0.002%] | Significant but trivially small — not worth shipping |

**Always report the confidence interval alongside the p-value.** A p-value without a CI hides information about effect size and precision.

---

## From hypothesis test to decision

The test generates a result. The decision is yours.

| Result | Action |
|--------|--------|
| p < alpha AND effect ≥ MDE AND guardrails stable | Ship |
| p < alpha BUT effect < MDE | Do not ship — statistically real but practically insignificant |
| p > alpha (null result) | Do not ship — but also do not conclude the feature "doesn't work" unless the test was adequately powered |
| p < alpha AND guardrail degraded | Do not ship — investigate the trade-off |
| SRM detected | Do not interpret — fix the test first |

The p-value is one input to the decision. Effect size, guardrail status, and business context matter equally.

---

## The statistics that appear in an experiment readout

```
Metric: checkout completion rate
Control:   32.1% (n = 8,420)
Treatment: 35.2% (n = 8,389)
Delta:     +3.1pp
95% CI:    [+1.8pp, +4.4pp]
p-value:   0.003
```

**How to read this:**
- The treatment outperformed control by 3.1pp
- The true effect is almost certainly between +1.8pp and +4.4pp
- A result this extreme would occur 0.3% of the time under the null
- MDE was 2.5pp → effect exceeds MDE → ship signal

---

## Common interview questions

**"Explain a p-value to a non-statistician."**

> "If we changed nothing, here's how likely we'd be to see a difference this big by random chance alone. The lower the number, the harder it is to explain the result as luck."

**"An experiment shows p = 0.06. Should we ship?"**

> "Not automatically. First, was this pre-specified at alpha = 0.05? If yes, then p = 0.06 is a null result — we do not have sufficient evidence. The right response is to accept the null or redesign the experiment with a different MDE. What we should not do: lower the alpha threshold after seeing the result to make it 'significant.'"

**"What is a confidence interval?"**

> "A range that the true population parameter would fall within in 95% of repeated experiments. It tells you both the likely magnitude of the effect and how precise your estimate is — information you can't get from a p-value alone."

---

## Mini exercise

An experiment testing a new search ranking model produces:
- Clicks per search: treatment +5.1%, p = 0.002
- Session depth: treatment -1.2%, p = 0.31
- Query reformulation rate: treatment -8.4%, p = 0.009 (lower is better)

1. Which results are statistically significant at alpha = 0.05?
2. What does the query reformulation result suggest about the model?
3. Would you recommend shipping? What additional information do you need?
4. The PM says "session depth was borderline at p = 0.31 — can we lower alpha to 0.35 just for this metric?" How do you respond?

---

*Sample size: [power_and_sample_size.md](power_and_sample_size.md)*
*Full experiment lifecycle: [ab_testing.md](ab_testing.md)*
*Interview questions: [../10_interview_prep/statistics_questions.md](../10_interview_prep/statistics_questions.md)*
