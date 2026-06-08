# Interview Mode

One-page reference for analytics and product data science interviews.

For the 30-minute version, go to [00_quick_reference/interview_panic_sheet.md](00_quick_reference/interview_panic_sheet.md).

---

## SQL questions

**What is being tested:** join types, window functions, deduplication, funnel/retention logic, aggregation correctness, handling of NULLs.

**Answer structure:**
1. Confirm or state the schema before writing
2. Explain your approach: "I'll use CTEs to break this into readable steps"
3. Name the join type and say why out loud — this signals you understand the grain
4. Use `DISTINCT` for user counts; verify you are not double-counting
5. Wrap denominators in `NULLIF(..., 0)`

**Common traps:**
- `INNER JOIN` silently drops users who never performed an action — use `LEFT JOIN` when absence matters
- `WHERE right_table.col IS NOT NULL` on a `LEFT JOIN` converts it to `INNER JOIN` — filter in the `ON` clause instead
- Joining before aggregating on a non-unique key fans out rows and inflates all counts

---

## Product sense: "How would you measure success?"

**What is being tested:** metric definition, trade-off thinking, guardrails, prioritisation.

**Answer structure:**
1. Clarify: what is the product? who are the users? what decision does this support?
2. State the **product goal** — not the metric yet
3. Choose a **primary metric** — be specific and state the denominator
4. Add **input metrics** (2 max) — actions the team can directly influence
5. Add **guardrail metrics** (2 max) — what must not get worse
6. Name one key segment to monitor separately

**Strong answer format:**
> "The goal is [X]. The primary metric I would use is [specific definition]. I would add [input metric] as a leading indicator. For guardrails I would watch [Y] and [Z] — these would tell us if we are improving the primary metric at the cost of [harm]."

---

## Metric change: "A metric dropped X%"

**What is being tested:** structured thinking, data quality awareness, segmentation, root cause logic.

**Answer structure:**
1. Data quality check first — pipeline, logging, instrumentation
2. Timing — exact date or hour
3. Correlated events — releases, experiments, external events
4. Disaggregation — platform, country, user type, channel
5. Decomposition — numerator, denominator, or composition effect
6. Hypothesis — specific, with evidence
7. Next step — what confirms or rules it out

**Opening:** "Before drawing conclusions, I want to check whether this is a data problem or a real product signal."

**Closing:** "Based on [segments affected + timing], my best hypothesis is [X]. To confirm, I would [specific analysis]. While investigating, I'd recommend [operational response]."

---

## A/B test design

**What is being tested:** understanding of randomisation, power, MDE, guardrails, duration.

**Answer structure:**
1. Hypothesis: if we do X, Y will change because Z
2. Randomisation unit — justify your choice
3. Primary metric — one, defined before launch
4. Guardrail metrics
5. Sample size — name the inputs: baseline rate, MDE, alpha = 0.05, power = 0.80
6. Duration — at least 2–3 full weekly cycles, state why
7. Pre-specified launch criterion

**Key numbers to mention:**
- Minimum detectable effect: "the smallest lift that would change the product decision"
- Alpha 0.05 = 5% false positive rate — 1 in 20 tests will appear significant by chance
- Power 0.80 = 20% chance of missing a real effect of the specified size

---

## A/B test interpretation

**What is being tested:** SRM awareness, practical vs statistical significance, segment analysis, novelty.

**Answer structure in order:**
1. SRM check — if mismatch, stop and investigate
2. Primary metric: direction + magnitude + p-value + confidence interval
3. Practical significance — translate to business terms
4. Guardrails — stable / improved / flagged
5. Segment consistency — same direction across major platforms and markets
6. Novelty check — compare week 1 vs week 3
7. Recommendation

**On p-values:** "The p-value tells us the probability of seeing this result if there were truly no effect — it is not the probability the result is real." Say this if asked to define it; many candidates get it wrong.

---

## Statistics concepts to know cold

| Concept | What to say |
|---------|------------|
| p-value | Probability of this result if null hypothesis is true |
| Confidence interval | Range containing the true value with stated probability — not "probability the value is in this range" |
| Type I error | False positive — we rejected a true null |
| Type II error | False negative — we failed to detect a real effect |
| Power | Probability of detecting a true effect of the specified size |
| Effect size | Magnitude of difference, independent of sample size |
| SRM | Sample ratio mismatch — assignment integrity problem |
| Practical significance | Is the effect large enough to matter, regardless of the p-value? |

---

## Communication under pressure

When you are unsure: "Let me think through this structure first, then I'll go into detail."
When you made a mistake: "Actually, let me revise that — [correction]."
When the question is ambiguous: "Before I answer, I want to clarify [X] — would it be [A] or [B]?"
When the evidence is inconclusive: "The honest answer is we don't have enough data to be confident. Here is what I would do next to resolve it."

---

## Common traps interviewers are watching for

- Choosing a metric without defining the denominator
- Not including guardrail metrics in an experiment design
- Saying p = 0.03 means "97% confidence the effect is real" — this is wrong
- Not checking for SRM before interpreting results
- Ending an analysis answer without a recommendation

---

*Practice questions: [10_interview_prep/](10_interview_prep/README.md)*
*Quick panic sheet: [00_quick_reference/interview_panic_sheet.md](00_quick_reference/interview_panic_sheet.md)*
