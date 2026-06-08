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

*Full statistics: [../03_statistics_and_experimentation/README.md](../03_statistics_and_experimentation/README.md)*
*SQL template: [../02_sql_for_analytics/experiment_analysis.sql](../02_sql_for_analytics/experiment_analysis.sql)*
