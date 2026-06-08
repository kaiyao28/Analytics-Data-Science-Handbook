# A/B Testing Cheatsheet

---

## Experiment design — in order

1. State the hypothesis: *if we do X, Y will change because Z*
2. Choose the randomisation unit — usually user, sometimes session or device
3. Define the primary metric before launch — one metric, pre-specified
4. Define guardrail metrics — what must not degrade
5. Calculate sample size — inputs: baseline rate, MDE, alpha, power
6. Calculate duration — use weekly traffic to get days; multiply by 2–3 weekly cycles
7. Document the pre-specified launch criterion

---

## Sample size inputs

| Input | Typical value | Notes |
|-------|--------------|-------|
| Baseline rate | From historical data | Be precise — 32.0% not "around 30%" |
| MDE | Smallest lift worth acting on | Smaller MDE = larger sample needed |
| Significance level (alpha) | 0.05 | 1 in 20 false positives |
| Power (1 − beta) | 0.80 | 1 in 5 missed real effects |

---

## Before interpreting results — checklist

- [ ] Has the test run for the full pre-specified duration?
- [ ] SRM check: is the split within ±1% of intended? If not, stop.
- [ ] Primary metric: direction, magnitude, p-value, confidence interval
- [ ] Is the effect *practically* significant? (business impact, not just p < 0.05)
- [ ] Guardrails: stable?
- [ ] Segment breakdown: consistent effect across platform, country, user type?
- [ ] Novelty check: compare week 1 vs week 3 effect

---

## Common mistakes

| Mistake | Why it matters |
|---------|---------------|
| Peeking daily and stopping when p < 0.05 | Inflates false positive rate to 2–3× alpha |
| Underpowered test | Null result proves nothing if power was 30% |
| Not pre-specifying primary metric | Any post-hoc metric choice is p-hacking |
| Ignoring guardrails | Conversion can rise while churn also rises |
| Calling secondary metric wins | Multiple comparisons — at least 1 in 20 will be significant by chance |
| Declaring novelty a win | Effect concentrated in week 1 may not persist |

---

## Quick thresholds

```
p < 0.05      → statistically significant (at alpha = 0.05)
p ≥ 0.05      → not significant — not "no effect," just inconclusive
Power = 0.80  → 20% chance of missing a real effect of the specified size
SRM threshold → flag if split deviates > 1pp from intended ratio
```

---

## Explaining a null result to a stakeholder

> "The experiment did not reach statistical significance. This does not mean the change had no effect — it means we do not have enough evidence to be confident the effect is real and not random noise. Given our sample size and the size of the effect we were looking for, we had an 80% chance of detecting a true improvement of [X%]. The most honest summary is: we cannot conclude this worked."

---

---

## Self-check (answer key below)

1. An experiment ran for 14 days. You see p = 0.07. The team wants to run one more week. What do you say?
2. The split is 49.1% / 50.9% instead of 50/50. Is this an SRM?
3. Three secondary metrics are significant. The primary metric is not. Is this a win?

**Answers:**
1. No — extending after observing is peeking. Accept the null or run a new pre-registered test.
2. Depends on sample size. Run a chi-squared test. A split of 491/509 in 1,000 users is not significant (p ≈ 0.31). The same ratio in 50,000 users (24,550/25,450) produces p < 0.001. The threshold is significance, not the raw percentage gap.
3. No — this is a multiple comparisons problem. The primary metric is the ship criterion. Three significant secondary results from 10 tests is consistent with chance at alpha = 0.05.

---

*Full statistics: [../03_statistics_and_experimentation/README.md](../03_statistics_and_experimentation/README.md)*
*SQL template: [../02_sql_for_analytics/experiment_analysis.sql](../02_sql_for_analytics/experiment_analysis.sql)*
