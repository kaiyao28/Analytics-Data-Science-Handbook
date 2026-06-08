# Interview Panic Sheet

Open this when you have 20 minutes before an analytics DS interview.

---

## SQL — answer structure

1. Confirm schema or state assumptions
2. Say your approach before writing: "I will use a CTE for each step"
3. Name the join type and justify it out loud
4. Use `DISTINCT` on user counts in aggregations
5. Wrap every denominator in `NULLIF(..., 0)`
6. If asked to debug: check join type, check grain, check WHERE on LEFT JOIN

---

## "How would you measure success?"

1. Clarify: what is the product? who are the users?
2. State the **goal** before naming a metric
3. Name one **primary metric** — be specific ("% of new users who complete ≥1 lesson in 7 days")
4. Add 1–2 **input metrics** (things the team can directly influence)
5. Add 1–2 **guardrail metrics** (what must not get worse)
6. Name one key segment to track

---

## "A metric dropped X%"

1. Check data quality first — pipeline, logging, instrumentation
2. Establish timing — exact date or hour
3. What changed then — releases, experiments, external events
4. Disaggregate — platform, country, user type, acquisition channel
5. Decompose — numerator, denominator, or composition effect?
6. Form a hypothesis: "Most likely cause is X because Y"
7. Next step: "To confirm, I would look at Z"

**Opening line:** "Before drawing conclusions, I want to check whether this is a data problem or a real product problem."

---

## A/B test design

1. State the hypothesis: if we do X, Y will change because Z
2. Randomisation unit (usually user)
3. Primary metric — defined before launch
4. Guardrail metrics
5. Sample size inputs: baseline rate, MDE, alpha (0.05), power (0.80)
6. Duration: minimum 2–3 full weekly cycles
7. Pre-specified ship criterion

---

## A/B test interpretation

1. SRM check — stop if mismatch, investigate before reading results
2. Primary metric: direction, magnitude, p-value
3. Practical significance: what does this mean in business terms?
4. Guardrails: stable?
5. Segment consistency: same direction on iOS, Android, major markets?
6. Novelty check: effect stable in weeks 2–3, not just week 1?
7. Recommendation: ship / iterate / investigate

---

## Statistics — one-liners

| Term | Say this |
|------|---------|
| p-value | "Probability of this result if the null were true — not the probability the result is real" |
| Alpha = 0.05 | "We accept a 5% false positive rate" |
| Power = 0.80 | "80% chance of detecting a real effect of the specified size" |
| Type I error | "False positive — we think it worked, it did not" |
| Type II error | "False negative — it worked, but we missed it" |
| Confidence interval | "Range that contains the true value 95% of the time if we repeated the experiment" |
| SRM | "Assignment bug — do not interpret results until resolved" |

---

## Common traps interviewers are watching for

- Saying p = 0.03 means "97% chance it is real" — this is wrong
- Not defining the population in a metric question
- Forgetting guardrail metrics
- Missing the composition effect in a metric change
- Not ending with a recommendation

---

## Closing phrases

- "My recommendation is X. The main uncertainty is Y — I would monitor Z post-launch."
- "This result is statistically significant, but let me check whether the effect size is practically meaningful."
- "Before interpreting the result I want to check for a sample ratio mismatch."
- "I would define the metric before writing any SQL."

---

*Full interview practice: [../10_interview_prep/README.md](../10_interview_prep/README.md)*
