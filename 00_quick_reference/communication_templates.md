# Communication Templates

Reusable structures for writing up analytical work.

---

## Experiment readout (ship decision)

```
[One sentence: what changed and what the result was]

Result: [primary metric] moved from X to Y (+Z%, p = 0.0N).
Effect size: [business terms — "approximately $Xk annual revenue"].
Guardrails: [refund rate / retention / uninstall] — [stable / improved / flagged].
Segments: Effect consistent across [iOS, Android] and [US, UK].
Novelty check: Effect stable in weeks 2–3.

Recommendation: [Ship / Do not ship / Run follow-up experiment]

If shipping: monitor [metric] for the first 30 days post-launch.
```

---

## Experiment readout (null result)

```
[Primary metric] showed no statistically significant change
(control: X%, treatment: Y%, p = 0.NN, 95% CI: [A% to B%]).

This does not mean the feature had no effect. It means we do not
have sufficient evidence to conclude the effect is real given our
sample size and the effect size we were looking for.

The test was adequately powered to detect a [Z%] relative improvement.
The observed effect ([direction]) is consistent with [small benefit /
 true null / marginal harm].

Recommendation: [Do not ship based on this data / Redesign and retest /
 Accept the null and move on]
```

---

## Decision memo (one page)

```
## Decision: [verb + what]

**Background:** [1–2 sentences on the context]

**Options considered:**
1. [Option A] — [key trade-off]
2. [Option B] — [key trade-off]

**Evidence:**
- [Finding 1 — fact, not interpretation]
- [Finding 2]
- [Finding 3]

**Key uncertainty:** [what we do not know and how it affects the decision]

**Recommendation:** [Option X]
**Reason:** [1–2 sentences]
**If wrong:** [what would indicate we should reconsider]
```

---

## Insight sentence structure

Weak: "Conversion dropped 15% last month."
Strong: "Mobile checkout conversion dropped 15% (8.2% → 7.0%) in March, driven by iOS users acquired via paid channels. Desktop conversion was flat. This coincides with an iOS app update on March 4."

Pattern: **What changed** + **by how much** + **in which segment** + **since when** + **correlated with what**.

---

## Responding to "the data must be wrong"

1. "Walk me through what you're seeing that contradicts this."
2. "Let me check the methodology with you — [explain the definition, population, time period]."
3. "If the data is correct, here is what would need to be true for the conclusion to be different."
4. "I've validated this three ways. I'm confident in the number, but I want to understand your perspective on why it seems wrong."

Do not capitulate to pressure. Do not dismiss their concern.

---

## Explaining uncertainty to a non-technical stakeholder

"We are confident the improvement is real — the analysis shows it is very unlikely to be random noise. What we are less certain about is the exact size of the effect. Our best estimate is [X], but the true value is likely somewhere between [A] and [B]. I would recommend we treat [X] as the planning number but build in a buffer."

---

*Full communication guide: [../08_communication_and_decision_making/README.md](../08_communication_and_decision_making/README.md)*
