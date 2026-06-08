# Analysis Review Checklist

A structured checklist for reviewing someone else's analysis — or your own before sharing it. Use before any decision-facing work goes to a stakeholder.

---

## How to use

Work through each section in order. A red flag in sections 1–4 (problem framing, metric, data quality, SQL) usually means the rest of the analysis cannot be trusted without correction. Red flags in sections 5–10 affect how much weight to give the conclusions.

---

## 1. Problem framing

| Check | Pass | Red flag |
|-------|------|----------|
| The analysis states the decision it is meant to inform | The decision is named in the first paragraph | Analysis exists without a stated purpose |
| The question is the right question | The question maps to a real product decision | The question was given, not validated |
| Scope is appropriate | Time window, population and metric match the decision | Scope is too narrow (misses the full picture) or too broad (wastes effort) |
| Assumptions are stated | Key assumptions are listed upfront | Analysis proceeds on unstated assumptions |

**Review question:** "What decision will this analysis change, and how?"

---

## 2. Metric definition

| Check | Pass | Red flag |
|-------|------|----------|
| Primary metric has a precise definition | Metric name + numerator + denominator + time window | "Engagement" or "retention" without definition |
| Denominator is correct | Population is right for the question | Includes users who shouldn't be included (e.g. bot traffic) or excludes users who should be |
| Metric is measuring what it claims | The operationalisation matches the concept | "Activation" defined as "opened the app" when it should be "completed first task" |
| Guardrails or secondary metrics are named | At least one thing that must not worsen is identified | No consideration of what could go wrong |

**Review question:** "If you changed this metric definition slightly, would the conclusion change?"

---

## 3. Data quality

| Check | Pass | Red flag |
|-------|------|----------|
| Logging completeness is verified | Event counts look normal; no sudden drops | No check for logging gaps |
| Time window is checked | Trend starts where expected | Data cut-off or backfill creates artifical patterns |
| Outliers are identified | Extreme values examined; treatment justified | Large outliers silently inflating means |
| Known data issues are noted | Any known issues with the data source are flagged | Analysis proceeds as if data is perfect |

**Review question:** "What would happen to the conclusion if there was a logging bug in this data?"

---

## 4. SQL / data extraction logic

| Check | Pass | Red flag |
|-------|------|----------|
| JOIN type is correct | LEFT JOIN where nulls should be preserved; INNER JOIN only when exclusion is intended | INNER JOIN silently drops users with no events |
| Deduplication is handled | user_id-level analysis uses DISTINCT or explicit dedup | Double-counting due to multiple events per user |
| Timezone / date handling is correct | Timestamps normalised; time window boundaries correct | Implicit assumptions about timezone or cutoff |
| Edge cases are handled | Zero-event users, users in both groups, nulls | Edge cases silently excluded from denominator |

**Review question:** "What is the unit of each row in the final output table?"

---

## 5. Statistical validity

| Check | Pass | Red flag |
|-------|------|----------|
| Sample size is sufficient | Power was calculated before launch (for experiments) | Null result from a test with no power calculation |
| Significance threshold is pre-specified | Alpha is stated upfront; not adjusted after seeing results | Alpha changed post-hoc; multiple tests without correction |
| Confidence interval is reported | Effect size with CI, not just p-value | p-value only, no sense of magnitude or precision |
| Appropriate test is used | Test matches data type and distribution | t-test on highly skewed count data; proportion test on continuous outcome |

**Review question:** "What is the power of this analysis, and what does a null result actually mean?"

---

## 6. Segmentation and robustness

| Check | Pass | Red flag |
|-------|------|----------|
| Result is disaggregated by key dimensions | At least platform, user type or geography checked | Headline number only, no segment breakdown |
| Segments are consistent with hypothesis | Breakdown adds insight to the main finding | Segments chosen post-hoc to support a conclusion |
| Composition effects are accounted for | Controlled for known composition shifts (e.g. channel mix) | Mix shift confounding the overall trend |
| Result is stable across time sub-periods | No sudden reversal mid-period | Effect concentrated in one week or one day |

**Review question:** "Does the conclusion hold if you look only at one platform, or one user type?"

---

## 7. Business interpretation

| Check | Pass | Red flag |
|-------|------|----------|
| Statistical significance ≠ practical significance | Effect size is translated into business terms | "p = 0.003, therefore this is important" |
| Effect size is contextualised | Magnitude compared to historical benchmarks or cost of change | Lift stated without reference to what matters |
| Causality is handled correctly | Observational results are labelled as correlational | "X causes Y" from observational data |
| Counter-explanations are addressed | Alternative explanations considered and addressed or acknowledged | Single-explanation confirmation bias |

**Review question:** "Is there an equally plausible explanation that would lead to a different decision?"

---

## 8. Recommendation quality

| Check | Pass | Red flag |
|-------|------|----------|
| Recommendation is specific | Clear action, not "it depends" | Findings presented without a decision |
| Recommendation is actionable | Decision owner knows what to do next | Recommendation requires a follow-up meeting to interpret |
| Uncertainty is quantified | "We're 80% confident..." or "this assumes X" | False certainty or all uncertainty lumped into caveats |
| Decision risks are named | What could go wrong is stated; how to monitor is proposed | Risks acknowledged but not addressed |

**Review question:** "If I followed this recommendation and it turned out to be wrong, would I understand why?"

---

## 9. Communication clarity

| Check | Pass | Red flag |
|-------|------|----------|
| Recommendation is in the first two sentences | Anyone who reads only the opening knows what to do | Recommendation buried at the end |
| Statistical language is translated | "p = 0.03" becomes "this result is unlikely to be random" | Raw statistical output presented to non-technical audience |
| Caveats are proportional | Important caveats flagged once, clearly | Exhaustive caveat list makes the recommendation ambiguous |
| Length is appropriate | One page is usually enough | Long document for a routine decision |

**Review question:** "Could a PM who skimmed only the first paragraph know what to do?"

---

## 10. Decision readiness

| Check | Pass | Red flag |
|-------|------|----------|
| The decision can be made from this analysis | All necessary inputs are present | Analysis is missing data needed for the decision |
| Next steps are specific | Owner, action and timing are named | "Further research required" without specifics |
| Monitoring plan exists | Post-decision metrics and thresholds are named | No way to know after the fact if the decision worked |
| Escalation path is clear | It is clear who makes the final decision | Analysis presented without naming the decision owner |

**Review question:** "After reading this, what is the next thing the decision owner should do?"

---

## Summary scorecard

Rate each section pass / needs work / fail:

| Section | Status | Priority fix |
|---------|--------|-------------|
| Problem framing | | |
| Metric definition | | |
| Data quality | | |
| SQL / extraction | | |
| Statistical validity | | |
| Segmentation | | |
| Business interpretation | | |
| Recommendation quality | | |
| Communication clarity | | |
| Decision readiness | | |

A single "fail" in sections 1–4 usually means the analysis should be redone before sharing. A "needs work" in sections 5–10 means share with caveats and a clear plan to address.

---

*Career level context: [CAREER_LEVELS.md](CAREER_LEVELS.md)*
*Manager review guide: [MANAGER_MODE.md](MANAGER_MODE.md)*
*Before sharing checklist: [CHECKLISTS.md](CHECKLISTS.md)*
